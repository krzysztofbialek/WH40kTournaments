PlayerView = Backbone.View.extend({
  template: JST['players/player'],
  template1: JST['teams/team'],
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
    if (gon.for_teams) {
      this.$el.attr('id', this.model.id).html(this.template1(this.model.toJSON()));
    } else {
      this.$el.attr('id', this.model.id).html(this.template(this.model.toJSON()));
    }
    return this
  },
  
  remove: function(model){
    this.$el.remove();
    model.destroy()
  },

});

