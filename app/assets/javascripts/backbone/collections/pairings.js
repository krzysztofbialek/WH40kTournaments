Pairings = Backbone.Collection.extend({
  url: 'play/tournament_pairings',
  model: Pairing,

  initialize: function() {
    _.bindAll(this)
  },
 
  generatePairings: function() {
    this.url = '/tournaments/' + Dmp40k.getTournamentId() + '/generate_pairings';
    this.fetch();
    this.updateRound();
  },

  generateNewRound: function(){
    this.url = '/tournaments/' + Dmp40k.getTournamentId() + '/generate_pairings';
    this.fetch({
      success: _.bind(function(response, xhr){
        this.updateRound();
      }, this),
      error: function(collection, error){
        alert(JSON.parse(error.responseText).msg);
      },
      reset: true
    });
  },

  updateRound: function(){
    text = $('.tournament_round').text();
    n = parseInt(text.match(/\d+/));
    text = text.replace(/\d+/, n + 1);
    $('.tournament_round').text(text);
  },

  swapPairings: function(source, target) {
    var source_pair = this.get(source.data('pairing-id'))
    var target_pair = this.get(target.data('pairing-id'))
  
    if (source_pair === target_pair) {
      return true
    }
  
    if ( gon.for_teams ) {
      this.updateTeamPairings(source_pair, target_pair, source, target)
    } else {
      this.updatePairings(source_pair, target_pair, source, target)
    }

    source_pair.save()
    target_pair.save()
    source_pair.fetch()
    target_pair.fetch()
  },

  updatePairings: function(source_pair, target_pair, source, target){
    if (source_pair.get('player1_id') === source.data('id')) {
      
      source_pair.set({ 'player1_id': target.data('id') });
      
      if (target_pair.get('player1_id') === target.data('id')){
        target_pair.set({ 'player1_id': source.data('id') });
      } else {
        target_pair.set({ 'player2_id': source.data('id') });
      }
        
    } else {
      source_pair.set({ 'player2_id': target.data('id') });
      if (target_pair.get('player1_id') === target.data('id')){
        target_pair.set({ 'player1_id': source.data('id') });
      } else {
        target_pair.set({ 'player2_id': source.data('id') });
      }
    }
  },
  
  updateTeamPairings: function(source_pair, target_pair, source, target){
    if (source_pair.get('team1_id') === source.data('id')) {
      
      source_pair.set({ 'team1_id': target.data('id') });
      
      if (target_pair.get('team_id') === target.data('id')){
        target_pair.set({ 'team1_id': source.data('id') });
      } else {
        target_pair.set({ 'team2_id': source.data('id') });
      }
        
    } else {
      source_pair.set({ 'team2_id': target.data('id') });
      if (target_pair.get('team1_id') === target.data('id')){
        target_pair.set({ 'team1_id': source.data('id') });
      } else {
        target_pair.set({ 'team2_id': source.data('id') });
      }
    }
  }
});
