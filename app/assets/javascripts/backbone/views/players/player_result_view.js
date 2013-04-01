PlayerResultView = Backbone.View.extend({
  template: JST['players/player_result'],
  tagName: 'tr',
  
  events: {
    'click .player-army button' : 'removePlayer' 
  },
  
  initialize: function(){
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

});

