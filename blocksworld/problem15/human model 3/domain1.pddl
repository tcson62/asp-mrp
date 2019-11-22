(define (domain BLOCKS)
  (:requirements :strips :typing)
  (:types block)
  (:predicates (on ?x - block ?y - block)
	       (ontable ?x - block)
	       (clear ?x - block)
	       (handempty)
	       (holding ?x - block)
	       )

  (:action pickup
	     :parameters (?x - block)
	     :precondition (and (ontable ?x) (handempty))
	     :effect
	     (and (not (ontable ?x))
		   (not (handempty))
		   (holding ?x)))

  (:action putdown
	     :parameters (?x - block)
	     :precondition (and (holding ?x))
	     :effect
	     (and (not (holding ?x))
		   (clear ?x)
		   (ontable ?x)))

  (:action stack
	     :parameters (?x - block ?y - block)
	     :precondition (and (clear ?y))
	     :effect
	     (and (not (holding ?x))
		   (not (clear ?y))
		   (clear ?x)
		   (on ?x ?y)))
  (:action unstack
	     :parameters (?x - block ?y - block)
	     :precondition (and (clear ?x) (handempty))
	     :effect
	     (and (holding ?x)
		   (not (clear ?x))
		   (not (handempty))
		   (not (on ?x ?y)))))