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
    this.$el.append('<tr><td class="round" colspan=2>Runda '+ index + '<i class="icon-minus toggle-round"> (zwiń rundę)</i></td></tr>')
    round.forEach(this.addOne, this);
    this.$('.toggle-round').on('click', this.toggleRound, this)
  },
    
  addOne: function(pairing){
    var pairingView = new PairingView({model: pairing});
    pairingView.render();
    this.$el.append(pairingView.el);
  },

  toggleRound: function(){
    this.$('tr').slice(1, 99).fadeToggle()
    that = this.$('.toggle-round')
    if (that.hasClass('icon-minus')) { 
      that.text(' ( rozwiń rundę )');
    } else {
      that.text(' ( zwiń rundę )');
    }
    that.toggleClass('icon-plus icon-minus')
  },
    
});
