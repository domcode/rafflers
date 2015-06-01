// fancy example

var raffle = {
    init: function () {
        raffle.getPlayers(raffle.initGame);
        $("#resetGame").click(function () {
            $.post("resetgame", function () {
                raffle.getPlayers(raffle.initGame);
            });
        });
        $("#newGame").prop("disabled", true);
        $("#newGame").click(function () {
            $("#newGame").prop("disabled", true);
            $("#playFancy").prop("disabled", false);
            $('.fancy').addClass("hidden");
            raffle.getPlayers(raffle.initGame);
        });
        $("#loadNewPlayers").click(function () {
            window.location.href = 'newgame'
        });

    },

    initGame: function (players) {
        raffle.updateGame(players);

        $('.fancy .slot').jSlots({
            number: 1,
            winnerNumber: 1,
            spinner: '#playFancy',
            easing: 'easeOutSine',
            time: 10000,
            loops: 10,
            onStart: function () {
                $('.slot').removeClass('winner');

                $("#playFancy").prop("disabled", true);
                $("#resetGame").prop("disabled", true);
                $("#newGame").prop("disabled", true);
                $('.fancy').removeClass("hidden");

            },
            onEnd: function (winners) {
                $(".slot").addClass('winner');
                raffle.updateWinner($(".slot li:eq(" + (winners[0] - 1) + ")").attr("id"));
                $("#resetGame").prop("disabled", false);
                $("#newGame").prop("disabled", false);
                $("#playFancy").off();
            }
        });

    },

    updateGame: function (players) {

        $('.fancy').empty();
        $('.fancy').append('<ul class="slot"></ul>');
        $('.winners').empty();
        for (i = 0; i < players.length; i++) {
            if (!players[i].won) {

                $('.slot').append('<li id="' + players[i]._links.self.href + '"><span>' + players[i].name + '</span></li>');
            } else {
                $('.winners').append('<li><span>' + players[i].name + '</span></li>');
            }
        }
        $(".fancy .slot li").each(function () {
            $(this).css("background-color", raffle.get_random_color());
        });

    },

    get_random_color: function () {
        var letters = '0123456789ABCDEF'.split('');
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.round(Math.random() * 15)];
        }
        return color;
    },

    updateWinner: function (id) {
        $.ajax({
            url: id,
            dataType: 'json',
            type: 'patch',
            contentType: 'application/json',
            data: JSON.stringify({"won": true}),
            processData: false,
            success: function (data, textStatus, jQxhr) {
                //raffle.getPlayers(raffle.initGame);
            },
            error: function (jqXhr, textStatus, errorThrown) {
                console.log(errorThrown);
            }
        });
    },

    getPlayers: function (handleResult) {
        $.ajax({
            url: 'rafflePlayers',
            dataType: 'json',
            type: 'get',
            contentType: 'application/json',
            success: function (data, textStatus, jQxhr) {
                handleResult(data._embedded.rafflePlayers)

            },
            error: function (jqXhr, textStatus, errorThrown) {
                console.log(errorThrown);
            }
        });

    }
};


$(function () {
    raffle.init();
});