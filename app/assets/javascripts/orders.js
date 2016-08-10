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

    $('input#order_relative_attributes_relationship').autocomplete({
        data: gon.relationships
    });

    $('input#order_deceased_attributes_cemetery_name').autocomplete({
        data: gon.cemetery_names
    });

    $('.collapsible').collapsible({
        // accordion : false
    });

    $('input.timepicker').bootstrapMaterialDatePicker({
        date: false,
        format: 'hh:mm'
    });

    $('.tooltipped').tooltip({delay: 50});

    $('ul.tabs').tabs();

    $('.dropdown-button').dropdown();

    $('#flowers.row')
        .on('cocoon:before-insert', function(e, flower_to_be_added) {
            flower_to_be_added.fadeIn('slow');
        })
        .on('cocoon:after-insert', function(e, added_task) {
            // e.g. set the background of inserted task
            // added_task.css("background","red");
        })
        .on('cocoon:before-remove', function(e, flower) {
            // allow some time for the animation to complete
            $(this).data('remove-timeout', 1000);
            flower.fadeOut('slow');
        });

    $('.add-flower')
        .data("association-insertion-method", 'before')
        .data("association-insertion-node",  function(link){
            return link.closest('.col')
        });

    Materialize.updateTextFields();

};

document.addEventListener("turbolinks:load", ready);
// $(document).ready(ready);
// $(document).on('page:change', ready);
