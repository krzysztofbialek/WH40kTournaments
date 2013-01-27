TournamentView = Backbone.View.extend({
  template: JST['tournaments/tournament'],
  className: 'tournament-details',

  initialize: function(){
    this.model.on('change', this.render, this);
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    this.$(".generate-pairings").bind("click", this.model.generatePairings);
    return this
  },


});

