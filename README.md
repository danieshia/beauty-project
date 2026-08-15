## Drugstore Dupes

 Comparing affordable drugstore makeup brands (e.l.f., NYX, Maybelline, Wet n Wild) against Charlotte Tilbury, a prestige benchmark, across five product categories using SQL and Tableau.

 Tech stack used: Python (pandas) MySQL, Tableau

## Data Source
For this data source, I asked Claude to make up a small dataset for this project.

## Overview

Charlotte Tilbury is widely regarded as a benchmark for quality in prestige makeup, but its price point puts it out of reach for many shoppers. This project asks a practical question: how close do affordable drugstore alternatives actually get to Charlotte Tilbury on customer satisfaction, and which specific products come closest?

The analysis covers five categories: lipstick, foundation, mascara, concealer, and blush. It compares one product from each of four drugstore brands against the equivalent Charlotte Tilbury product.



# Lipstick

Findings: This is the strongest category for drugstore brands. NYX actually beats Charlotte Tilbury on sentiment while matching its star rating at a third of the price. Wet n Wild is even more interesting, as it has the highest star rating in the whole category (4.8) at the lowest price ($6.03), even though its sentiment score trails NYX and Charlotte Tilbury slightly.

Suggestion: NYX for the closest head-to-head match against Charlotte Tilbury; Wet n Wild if star rating and price matter more to you than the sentiment number specifically.




# Foundation
Findings: This is Charlotte Tilbury’s strongest category, as it leads in rating and ties for the sentiment lead. Wet n Wild ties Charlotte Tilbury’'s sentiment score exactly, but its lower star rating (3.8 vs. 4.4) suggests customers are satisfied on average, but with more variance or complaints on specifics (e.g shade range), the sentiment score alone doesn't tell us why. NYX stands out as the weak point in this specific table. It has a solid star rating (4.3★) but the lowest sentiment score, which is something worth flagging rather than glossing over. It hints that the numeric rating and the sentiment score may be capturing different things for that product.

Suggestion: pick  Wet n Wild for sentiment parity with Charlotte Tilbury at a fraction of the cost, if you're willing to trade off some of the star-rating consistency.




# Mascara

Findings: Charlotte Tilbury leads sentiment here too, but by a smaller margin than Foundation. The standout is e.l.f.: it has the highest star rating in this entire dataset (4.7) despite a mid-pack sentiment score (80%), another case where rating and sentiment tell slightly different stories. Wet n Wild is the best all-around value: second-highest sentiment, lowest price by far ($4.83)
Suggestion: Pick Wet n Wild for value; e.l.f. If star rating specifically is your priority.



# Concealer

Analysis: This is the biggest drugstore win in the dataset: e.l.f. beats Charlotte Tilbury on sentiment by 6 points at roughly 1/6th the price, making this the strongest "dupe" claim you can make across all five categories. Although Maybelline has a high star rating (4.5, second-highest in category), the lowest sentiment score of the drugstore options is 72%.
Suggestion: Pick e.l.f., as it's the standout result of the whole project.


#Blush
Findings: Wet n Wild has the highest sentiment score in the whole category (90%), beating both Charlotte Tilbury and e.l.f., at the lowest price ($4.14). But it's not the very top of the chart if you sort by star rating instead (4.0, lower than e.l.f.'s 4.5, or Charlotte Tilbury's 4.6). e.l.f. is essentially tied with Charlotte Tilbury on both metrics at 1/7th the cost, which is the more "balanced" pick.

Suggestion: Pick Wet n Wild if sentiment is your primary metric; e.l.f. if you want the closest overall match to Charlotte Tilbury on both rating and sentiment.






