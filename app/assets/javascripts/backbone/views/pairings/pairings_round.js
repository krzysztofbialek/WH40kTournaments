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
    round.forEach(this.addOne, this);
    this.$('.toggle-round').on('click', this.toggleRound, this);
    if (this.$('.completed').size() === this.$('tr').size() ){
      this.$el.prepend('<tr><td class="round" colspan=2>Runda '+ index + '<i class="icon-plus toggle-round"> (rozwiń rundę)</i></td></tr>')
      this.$('.completed').hide();
    } else {
      this.$el.prepend('<tr><td class="round" colspan=2>Runda '+ index + '<i class="icon-minus toggle-round"> (zwiń rundę)</i></td></tr>')
    }
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
