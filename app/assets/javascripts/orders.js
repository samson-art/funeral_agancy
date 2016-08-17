$.fn.toggleAttr = function(attr, attr1, attr2) {
    return this.each(function() {
        var self = $(this);
        if (self.attr(attr) == attr1)
            self.attr(attr, attr2);
        else
            self.attr(attr, attr1);
    });
};

var ready = function() {

    var top = $('main').offset().top;
    var bot = $('footer').position().top;

    function dateclick() {
        var picker = $('.pickdate#order_'+$(this).attr('id')).pickadate('picker');
        event.stopPropagation();
        picker.open();
        picker.set('editable', false);
        event.preventDefault();
    }

    $('.documents').pushpin({
        top: top,
        bottom: bot,
        offset: 58
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

    $('input#order_deceased_attributes_coffin_kind').autocomplete({
        data: gon.coffin_kinds
    });

    $('.collapsible').collapsible();

    $('.pickdate').pickadate({
        selectMonths: true,
        editable: true,
        format: 'dd/mm/yyyy',
        clear: false,
        selectYears: 120,
        min: moment().subtract(100, 'years').toDate(),
        max: moment().add(1, 'years').toDate(),
        onClose: function () {
            this.set('editable', true);
        }
    });

    $('.showpicker').click(dateclick);

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
        .data("association-insertion-method", 'append')
        .data("association-insertion-node",  function(link){
            return link.closest('.row').next('#flowers.row');
        });
    $('.add-car')
        .data("association-insertion-method", 'append')
        .data("association-insertion-node",  function(link){
            return link.closest('.row').next('#cars');
        });
    $('#cars')
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
    $('#assistants')
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

    $('.add-assistant')
        .data("association-insertion-method", 'append')
        .data("association-insertion-node",  function(link){
            return link.closest('.row').next('#assistants');
        });

    var search = $("#orders_search");
    search.keyup(function () {
        $.get(search.attr("action"), $("#orders_search, #orders_sort").serialize(), null, "script");
        return false;
    });

    $('#order-panel').on('click', '', function(event) {
        event.preventDefault();
        $.getScript(this.href);
        console.log(this.href);
        return false;
    });

    var icons = $('.timepicker');
    icons.tooltip({tooltip: 'Show clock'});
    icons.click(function () {
        var input = $('.'+$(this).data('field'));
        if (input.data('dtp')) {
            input.bootstrapMaterialDatePicker('destroy');
            $(this).tooltip('remove');
            $(this).tooltip({tooltip: 'Show clock'});
        } else {
            input.bootstrapMaterialDatePicker({
                date: false,
                format: 'HH:mm',
                clearButton: false,
                nowButton: false
            });
            input.bootstrapMaterialDatePicker('_onFocus');
            $(this).tooltip('remove');
            $(this).tooltip({tooltip: 'Disable clock'});
        }
        $(this).toggleClass('picker-active');
    });

    $('.note-lock').click(function () {
        $(this).children('i').toggleClass('lock');
        $('#note .card-action').toggleClass('hide');
        var textarea = $('textarea#order_deceased_attributes_note');
        textarea.prop('readonly', function (_, val) { return ! val; });
        textarea.toggleAttr('title', 'Locked', null);
    });

    $('#note-update').click(function () {
        $('#note .edit_order').submit()
    });

    var orders_sort = $('#orders_sort');
    var order_direction = $('#order_direction');
    var icon = order_direction.children('i');
    var reverse = icon.hasClass('reverse');
    order_direction.tooltip({tooltip: reverse ? 'To direct order' : 'To reverse order'});
    order_direction.click(function () {
        icon.toggleClass('reverse');
        var reverse = icon.hasClass('reverse');
        $('#reverse').val(reverse ? true : null);
        $(this).tooltip('remove');
        $(this).tooltip({tooltip: reverse ? 'To direct order' : 'To reverse order'});
        $.get(orders_sort.attr("action"), $("#orders_search, #orders_sort").serialize(), null, "script");
        return false;
    });
    $('#order').change(function () {
        $(this).children('option:selected').val();
        $.get(orders_sort.attr("action"), $("#orders_search, #orders_sort").serialize(), null, "script");
        return false;
    });
    $('select#view').change(function () {
        console.log($(this).children('option:selected').val());
        $.get(orders_sort.attr("action"), $("#orders_search, #orders_sort").serialize(), null, "script");
        return false;
    });

    $('select').material_select();

    Materialize.updateTextFields();

};

document.addEventListener("turbolinks:load", ready);