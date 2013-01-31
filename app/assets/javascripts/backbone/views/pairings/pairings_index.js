PairingsIndex = Backbone.View.extend({
  template: JST['pairings/index'],
  className: 'pairings-list',
  
  initialize: function(){
    this.collection.on('reset', this.render, this);
    $(".generate-pairings").live("click", this.collection.generatePairings);
    $(".generate-new-round").live("click", this.collection.generateNewRound);
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

  errorHandler: function(collection, error){
    alert(error);
  },

});
