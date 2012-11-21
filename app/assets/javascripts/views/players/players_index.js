PlayersIndex = Backbone.View.extend({
  tagName: 'ul',
  
  initialize: function(){
    this.collection.on('add', this.addOne, this);
  },

  render: function(){
    this.collection.forEach(this.addOne, this);
  },
  
  addOne: function(player){
    var playerView = new PlayerView({model: player});
    playerView.render();
    this.$el.append(playerView.render.el);
  },
});
