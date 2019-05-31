function f = simulate_game(state_table)
    deck = [];
    index = 1;
    for(suite = 1:4) 
        deck = [deck, randperm(13,13)];
    end
    %{
        DEALER TURN
    %}
    dealer_cards = [min(10, deck(1,1)), min(10, deck(1,2))];
    index = 3;
    
    while(sum(dealer_cards) < 17)
        dealer_cards = [dealer_cards, min(10, deck(1, index))];
        index = index + 1;
    end

    if(sum(dealer_cards) > 21)
        dealer_value = -1;
    else
        dealer_value = sum(dealer_cards);
    end
    
    %{
        PLAYER TURN
    %}
    player_cards = [min(10, deck(1,index)), min(10, deck(1,index + 1))];
    index = index + 2;
    player_total = sum(player_cards);
    while(true)
        state = player_total;
        if(state_table(state,1) > state_table(state,2)) %Hit better than stay
            player_cards = [player_cards, min(10, deck(1,index))];
            index = index + 1;
            player_total = sum(player_cards);
            
            if(player_total > 21) %Bust
                f = -1;
                break;
            end
        else    %Stay better than hit
            player_total = sum(player_cards);
            if(dealer_value < 0) %Player wins, dealer busts
                f = 1;
                break;
            elseif(player_total > dealer_value) %Player stays, player higher
                f = 1;
                break;
            else %Player stays, dealer higher
                f = -1;
                break;
            end
        end
    end
end