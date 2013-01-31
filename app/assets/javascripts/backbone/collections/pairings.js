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
      success: function(response, xhr){
        console.log('cool')
      },
      error: function(collection, error){
        alert(JSON.parse(error.responseText).msg);
      },
    });
  },

});
