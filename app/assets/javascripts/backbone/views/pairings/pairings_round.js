PairingsRound = Backbone.View.extend({
  template: JST['pairings/round'],
  className: 'pairings-round',
  tagName: 'tbody', 

  events: {
    'click .round' : 'toggleRound'
  },

  render: function(round, index){
    this.$el.html(this.template());
    this.$el.attr('id', 'round' + index)
    this.$el.append('<tr><td class="round" colspan=2>Runda '+ index +'</td></tr>')
    round.forEach(this.addOne, this);
    this.$('.round').on('click', this.toggleRound, this)
  },
    
  addOne: function(pairing){
    var pairingView = new PairingView({model: pairing});
    pairingView.render();
    this.$el.append(pairingView.el);
  },

  toggleRound: function(){
    this.$('tr').slice(1, 99).toggle()
  }
});
