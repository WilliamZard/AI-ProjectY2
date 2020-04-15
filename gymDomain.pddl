
(define (domain gym)

    (:requirements :typing :equality :fluents)
    
    (:types person station)

    (:predicates (station ?s) (person ?p) (at ?p - person ?s - station)
        (injured ?p - person))

    (:functions (stamina-level ?p - person) (stamina-required ?p - person ?a - action)
        (calories-burnt ?p - person) (calory-goal ?p - person)
        (activity-calories ?p - person ?a - action))

    (:action use
        :parameters (?p - person ?s - station ?a - action)
        :precondition (and (at ?p ?s) (>= (stamina-level ?p) (stamina-required ?p ?a)) (not injured ?p)))
        :effect (and (decrease (stamina-level ?p) (stamina-required ?p ?a)) 
                (increase (calories-burnt ?p) (activity-calories ?p ?a)))
    )
    
    (:action move
        :parameters (?p - person ?from ?to - station)
        :precondition (and (at ?p ?from))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
)
