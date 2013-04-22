PlayerResultView = Backbone.View.extend({
  template: JST['players/player_result'],
  tagName: 'tr',
  
  events: {
    'click .player-army button' : 'removePlayer', 
    'submit form' : 'update_player'
  },
  
  initialize: function(){
    _.bindAll(this, "render");
    this.model.bind('change:extra_points change:penalty_points', this.render, this);
  },

  removePlayer: function(){
    if(confirm('Czy chcesz usunąć gracza z turnieju?')) {this.remove(this.model);}
  },

  render: function(){
    this.$el.attr('id', this.model.id).html(this.template(this.model.toJSON()));
    return this
  },
  
  remove: function(model){
    this.$el.remove();
    model.destroy()
  },

  update_player: function(event){
    var id = this.model.id
    var that = this
    event.preventDefault();
    that.model.save({extra_points: 5, penalty_points: 5})
  },

});

