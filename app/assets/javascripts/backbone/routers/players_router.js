var Dmp40k =  new (Backbone.Router.extend({
  routes: { '': 'index' },

  initialize: function() {
    this.pairingsList = new Pairings();
    this.pairingsView = new PairingsIndex({collection: this.pairingsList});
    this.playersList = new Players();
    this.playersView = new PlayersIndex({collection: this.playersList});
    this.tournament = new Tournament({id: this.getTournamentId()});
    this.tournamentView = new TournamentView({model: this.tournament});
    $('.container-fluid').prepend(this.playersView.el)
    $('.container-fluid').append(this.tournamentView.el)
    $('.container-fluid').append(this.pairingsView.el)
  },

  start: function(){
    Backbone.history.start({pushState: true, root: "/tournaments/" + this.getTournamentId() + "/play"});
  },
 
  index: function(){
    this.playersList.fetch();
    this.tournament.fetch();
    this.pairingsList.fetch();
  },
  
  getTournamentId: function(){
    var urlParts = document.location.pathname.split('/');
    return urlParts[2];
  }
}));
