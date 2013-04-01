PlayersResults = Backbone.View.extend({
  template: JST['players/results'],
  className: 'players-results',
  
  
  initialize: function(){
    this.collection.on('add', this.addOne, this);
    this.collection.on('reset', this.render, this);
  },

  render: function(){
    this.$el.html(this.template());
    this.collection.forEach(this.addOne, this);
  },
  
  addOne: function(player){
    var playerResultView = new PlayerResultView({model: player});
    playerResultView.render();
    this.$('tbody').append(playerResultView.el);
  },

});
