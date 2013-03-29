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
    roundView = new PairingsRound
    roundView.render(round, index);
    this.$('table').append(roundView.el);
  },
 
});
