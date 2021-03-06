var Dmp40k =  new (Backbone.Router.extend({
  routes: { '': 'index' },

  initialize: function() {
    this.pairingsList = new Pairings();
    this.pairingsView = new PairingsIndex({collection: this.pairingsList});
    this.resultsList = new Results();
    this.playersList = new Players();
    this.playersView = new PlayersIndex({collection: this.playersList});
    this.resultsView = new PlayersResults({collection: this.resultsList});
    this.tournament = new Tournament({id: this.getTournamentId()});
    this.tournamentView = new TournamentView({model: this.tournament});
    $('.left-column').prepend(this.playersView.el)
    $('.right-column').append(this.tournamentView.el)
    $('.right-column').append(this.resultsView.el)
    $('.left-column').append(this.pairingsView.el)
  },

  start: function(){
    Backbone.history.start({pushState: true, root: "/tournaments/" + this.getTournamentId() + "/play"});
  },
 
  index: function(){
    this.playersList.fetch({reset: true});
    this.resultsList.fetch({reset: true});
    this.tournament.fetch();
    this.pairingsList.fetch({reset: true});
  },
  
  getTournamentId: function(){
    var urlParts = document.location.pathname.split('/');
    return urlParts[2];
  }
}));
