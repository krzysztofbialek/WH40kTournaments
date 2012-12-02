var Dmp40k =  new (Backbone.Router.extend({
  routes: { '': 'index' },

  initialize: function() {
    this.playersList = new Players();
    this.playersView = new PlayersIndex({collection: this.playersList});
    $('.container-fluid').prepend(this.playersView.el)
  },

  start: function(){
    var urlParts = document.location.pathname.split('/');
    var id = urlParts[2]
    Backbone.history.start({pushState: true, root: "/tournaments/" + id + "/play"});
  },
 
  index: function(){
    this.playersList.fetch();
  }
  
}));
