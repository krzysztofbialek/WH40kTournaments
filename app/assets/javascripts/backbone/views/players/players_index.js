PlayersIndex = Backbone.View.extend({
  tagName: 'ul',
  template: JST['players/index'],
  
  initialize: function(){
    this.collection.on('add', this.addOne, this);
    this.collection.on('reset', this.render, this);
  },

  render: function(){
    this.$el.html(this.template());
    this.collection.forEach(this.addOne, this);
  },
  
  addOne: function(player){
    var playerView = new PlayerView({model: player});
    playerView.render();
    this.$el.append(playerView.el);
  },
});
