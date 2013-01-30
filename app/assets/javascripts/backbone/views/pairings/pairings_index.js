PairingsIndex = Backbone.View.extend({
  template: JST['pairings/index'],
  className: 'pairings-list',
  
  
  initialize: function(){
    this.collection.on('reset', this.render, this);
  },

  render: function(){
    this.$el.html(this.template());
    this.collection.forEach(this.addOne, this);
  },
  
  addOne: function(pairing){
    var pairingView = new PairingView({model: pairing});
    pairingView.render();
    this.$('tbody').append(pairingView.el);
  },

});
