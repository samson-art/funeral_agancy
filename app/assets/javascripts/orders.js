var ready = function(){
    var top = $('main').offset().top;
    var bot = $('.page-footer').offset().top;
    $('.documents').pushpin({
        top: 8,
        bottom: bot
    });
    $('#order-fab').pushpin({
        bottom: $('main #order').height() - 2*$('#order-fab').outerHeight(true) - 25
    });
    $('input.datepicker').bootstrapMaterialDatePicker({
        time: false,
        format: 'DD/MM/YYYY'
    });

    $('input#order_deceased_attributes_funeral_place').autocomplete({
        data: gon.funeral_places
    });

    $('input#order_deceased_attributes_cemetery_name').autocomplete({
        data: gon.cemetery_names
    });

    $('.collapsible').collapsible({
        // accordion : false
    });

    $('input#order_deceased_attributes_funeral_time').bootstrapMaterialDatePicker({
        date: false,
        format: 'hh:mm'
    });

    $('.tooltipped').tooltip({delay: 50});

    $('ul.tabs').tabs();

    $('.dropdown-button').dropdown();

    Materialize.updateTextFields();

    console.log(gon.cemetery_names);

};

document.addEventListener("turbolinks:load", ready);
// $(document).ready(ready);
// $(document).on('page:change', ready);
