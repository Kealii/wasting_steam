var wastedMoney = 0

var getDataForGames = function getDataForGames(gameIds) {
    var source   = $("#gameTemplate").html();
    var template = Handlebars.compile(source);
    var table = $('#games tbody');

    gameIds.forEach(function(value) {

        $.get("/results/"+value, function(data) {
            wastedMoney += data.cost
            $('#waste').text(wastedMoney)

            table.append(template(data))
        })
    })
}