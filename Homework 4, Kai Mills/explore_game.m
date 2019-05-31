function f = play_game(exploration_likelihood, alpha, gamma, state_table, win_reward, stay_and_lose_reward, bust_reward)
    deck = [];
    index = 1;
    for(suite = 1:4) 
        deck = [deck, randperm(13,13)];
    end

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
    
    player_cards = [min(10, deck(1,index)), min(10, deck(1,index + 1))];
    index = index + 2;
    player_total = sum(player_cards);
    
    while(player_total <= 21)
        state = player_total;
        state_action_value = 0;
        
        if(rand < exploration_likelihood) %Perform random hit to explore options
            player_cards = [player_cards, min(10, deck(1,index))];
            index = index + 1;
            player_total = sum(player_cards);
            if(player_total > 21) %Bust
                state_table(state,1) = (1-alpha)*state_table(state,1) +...
                    alpha*(bust_reward);
            else %Update table values based on value of turn end-condition
                state_table(state,1) = (1-alpha)*state_table(state,1) +...
                    alpha*(gamma*...
                    max(state_table(player_total,1), state_table(player_total,2)));
            end
        else  %Perform best action according to table
            if(state_table(state,1) > state_table(state,2)) %Hit better than stay
                player_cards = [player_cards, min(10, deck(1,index))];
                index = index + 1;
                player_total = sum(player_cards);
                if(player_total > 21) %Bust
                    state_table(state,1) = (1-alpha)*state_table(state,1) +...
                        alpha*(bust_reward);
                else %Update table values based on turn end-condition
                    state_table(state,1) = (1-alpha)*state_table(state,1) +...
                        alpha*(gamma*...
                        max(state_table(player_total,1), state_table(player_total,2)));
                end
            else    %Stay better than hit
                player_total = sum(player_cards);
                if(dealer_value < 0) %Player wins, dealer busts
                    state_table(state,2) = (1-alpha)*state_table(state,2) + alpha*(win_reward);
                    break;
                elseif(player_total > dealer_value) %Player stays, player higher
                    state_table(state,2) = (1-alpha)*state_table(state,2) + alpha*(win_reward);
                    break;
                else %Player stays, dealer higher
                    state_table(state,2) = (1-alpha)*state_table(state,2) + alpha*(stay_and_lose_reward);
                    break;
                end
            end
        end
    end
    
    f = state_table;
end