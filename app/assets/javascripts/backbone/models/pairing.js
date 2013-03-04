Pairing = Backbone.Model.extend({
  
  urlRoot: 'play/tournament_pairings',

  getRound: function(){
    return this.get('round');
  },
});
