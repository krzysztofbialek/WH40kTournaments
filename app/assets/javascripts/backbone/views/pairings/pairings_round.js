PairingsRound = Backbone.View.extend({
  template: JST['pairings/round'],
  className: 'pairings-round',


  render: function(){
    this.$el.html(this.template());
  },
});
