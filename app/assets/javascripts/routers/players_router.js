var Dmp40k =  new (Backbone.Router.extend({
  routes: { '/': 'index' },

  initialize: function() {
    this.playersList = new Players();
    this.playersView = new PlayersIndex({collection: this.playersList});
    $('.container-fluid').append(this.playersView.el)
  },

  start: function(){
    Backbone.history.start({pushState: true});
  },
 
  index: function(){
    this.playersList.fetch();
  }
  
}));
