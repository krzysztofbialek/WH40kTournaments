Pairings = Backbone.Collection.extend({
  url: 'play/tournament_pairings',
  model: Pairing,

  initialize: function() {
    _.bindAll(this)
  },
 
  generatePairings: function() {
    console.log(collection)
    $.post('/tournaments/' + Dmp40k.getTournamentId() + '/generate_pairings', function(data){
      alert(data.inspect);
    });
  },

  generateNewRound: function(){
    this.url = '/tournaments/' + Dmp40k.getTournamentId() + '/generate_pairings';
    this.fetch();
  },

});
