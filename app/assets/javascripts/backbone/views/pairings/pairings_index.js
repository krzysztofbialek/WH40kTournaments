PairingsIndex = Backbone.View.extend({
  template: JST['pairings/index'],
  className: 'pairings-list',
  
  initialize: function(){
    this.collection.bind('reset', this.render, this);
    $(document).bind("click", "generate-pairings", this.collection.generatePairings);
    $(document).bind("click", "generate-new-round", this.collection.generateNewRound);
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
