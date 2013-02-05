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
    col = _.groupBy(this.collection.models, function(model){
      return parseInt(model.get('round'))
    });
    _.each(col, this.addRound, this)
  },
 
  addRound: function(round, index){
    this.$('tbody').append('<tr><td colspan=2>Runda '+ index +'</td></tr>')
    round.forEach(this.addOne, this);
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
