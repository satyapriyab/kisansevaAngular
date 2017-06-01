        var $table = $('#fresh-table'),
            $alertBtn = $('#alertBtn'),
            full_screen = false;
$(document).ready(function(){
    $table.bootstrapTable({
        toolbar: ".toolbar",
        search: true,
        showToggle: true,
        showColumns: false,
        pagination: true,
        striped: true,
        pageSize: 5,
        pageList: [5,10,25,50,100],

        formatShowingRows: function(pageFrom, pageTo, totalRows){
        },
        formatRecordsPerPage: function(pageNumber){
            return pageNumber + " rows visible";
        },
        icons: {
            toggle: 'fa fa-th-list',
            columns: 'fa fa-columns',
            detailOpen: 'fa fa-plus-circle',
            detailClose: 'fa fa-minus-circle'
        }
    });

    $(window).resize(function () {
        $table.bootstrapTable('resetView');
        });

        window.operateEvents = {
        'click .like': function (e, value, row, index) {
            alert('You click like icon, row: ' + JSON.stringify(row));
            console.log(value, row, index);
        },
        'click .edit': function (e, value, row, index) {
            alert('You click edit icon, row: ' + JSON.stringify(row));
            console.log(value, row, index);
        },
        'click .remove': function (e, value, row, index) {
            $table.bootstrapTable('remove', {
            field: 'id',
            values: [row.id]
            });
        }
    };
});