Pairings = Backbone.Collection.extend({
  url: 'play/tournament_pairings',
  model: Pairing,

  initialize: function() {
    _.bindAll(this)
  },
 
  generatePairings: function() {
    this.url = '/tournaments/' + Dmp40k.getTournamentId() + '/generate_pairings';
    this.fetch();
  },

  generateNewRound: function(){
    this.url = '/tournaments/' + Dmp40k.getTournamentId() + '/generate_pairings';
    this.fetch({
      success: _.bind(function(response, xhr){
        this.updateRound();
      }, this),
      error: function(collection, error){
        alert(JSON.parse(error.responseText).msg);
      }
    });
  },

  updateRound: function(){
    console.log('update')
    text = $('.round').text();
    n = parseInt(text.match(/\d+/));
    text = text.replace(/\d+/, n + 1);
    $('.round').text(text);
    console.log(text);
  },

});
