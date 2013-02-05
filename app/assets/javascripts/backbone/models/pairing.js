Pairing = Backbone.Model.extend({
  
  urlRoot: 'play/pairings',

  getRound: function(){
    console.log(model)
    return this.get('round');
  },
});
