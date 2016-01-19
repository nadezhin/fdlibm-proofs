(in-package "ACL2")
(include-book "../llvm")
(include-book "w_sqrt")
(include-book "s_fabs")
(include-book "s_scalbn")

(defconst *__ieee754_pow-globals* '(
  (one #x00000000 #x3ff00000)
  (bp #x00000000 #x3ff00000 #x00000000 #x3ff80000)
  (dp_l #x00000000 #x00000000 #x43cfd006 #x3e4cfdeb)
  (dp_h #x00000000 #x00000000 #x40000000 #x3fe2b803)))

(defund @__ieee754_pow-%706 (mem %1)
  (b* (
    (%707 (load-double %1 mem)))
  %707))

(defund @__ieee754_pow-%702 (mem %s %z %1)
  (b* (
    (%703 (load-double %s mem))
    (%704 (load-double %z mem))
    (%705 (fmul-double %703 %704))
    (mem (store-double %705 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%695 (mem %n %s %z %1)
  (b* (
    (%696 (load-i32 %n mem))
    (%697 (shl-i32 %696 20))
    (%698 (bitcast-double*-to-i32* %z))
    (%699 (getelementptr-i32 %698 1))
    (%700 (load-i32 %699 mem))
    (%701 (add-i32 %700 %697))
    (mem (store-i32 %701 %699 mem)))
  (@__ieee754_pow-%702 mem %s %z %1)))

(defund @__ieee754_pow-%691 (mem %n %s %z %1)
  (b* (
    (%692 (load-double %z mem))
    (%693 (load-i32 %n mem))
    (%694 (@scalbn %692 %693))
    (mem (store-double %694 %z mem)))
  (@__ieee754_pow-%702 mem %s %z %1)))

(defund @__ieee754_pow-%622 (mem %j %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* (
    (%623 (load-double %p_l mem))
    (%624 (load-double %p_h mem))
    (%625 (fadd-double %623 %624))
    (mem (store-double %625 %t mem))
    (%626 (bitcast-double*-to-i32* %t))
    (mem (store-i32 0 %626 mem))
    (%627 (load-double %t mem))
    (%628 (fmul-double %627 #x3FE62E4300000000))
    (mem (store-double %628 %u mem))
    (%629 (load-double %p_l mem))
    (%630 (load-double %t mem))
    (%631 (load-double %p_h mem))
    (%632 (fsub-double %630 %631))
    (%633 (fsub-double %629 %632))
    (%634 (fmul-double %633 #x3FE62E42FEFA39EF))
    (%635 (load-double %t mem))
    (%636 (fmul-double %635 #xBE205C610CA86C39))
    (%637 (fadd-double %634 %636))
    (mem (store-double %637 %v mem))
    (%638 (load-double %u mem))
    (%639 (load-double %v mem))
    (%640 (fadd-double %638 %639))
    (mem (store-double %640 %z mem))
    (%641 (load-double %v mem))
    (%642 (load-double %z mem))
    (%643 (load-double %u mem))
    (%644 (fsub-double %642 %643))
    (%645 (fsub-double %641 %644))
    (mem (store-double %645 %w mem))
    (%646 (load-double %z mem))
    (%647 (load-double %z mem))
    (%648 (fmul-double %646 %647))
    (mem (store-double %648 %t mem))
    (%649 (load-double %z mem))
    (%650 (load-double %t mem))
    (%651 (load-double %t mem))
    (%652 (load-double %t mem))
    (%653 (load-double %t mem))
    (%654 (load-double %t mem))
    (%655 (fmul-double %654 #x3E66376972BEA4D0))
    (%656 (fadd-double #xBEBBBD41C5D26BF1 %655))
    (%657 (fmul-double %653 %656))
    (%658 (fadd-double #x3F11566AAF25DE2C %657))
    (%659 (fmul-double %652 %658))
    (%660 (fadd-double #xBF66C16C16BEBD93 %659))
    (%661 (fmul-double %651 %660))
    (%662 (fadd-double #x3FC555555555553E %661))
    (%663 (fmul-double %650 %662))
    (%664 (fsub-double %649 %663))
    (mem (store-double %664 %t1 mem))
    (%665 (load-double %z mem))
    (%666 (load-double %t1 mem))
    (%667 (fmul-double %665 %666))
    (%668 (load-double %t1 mem))
    (%669 (fsub-double %668 #x4000000000000000))
    (%670 (fdiv-double %667 %669))
    (%671 (load-double %w mem))
    (%672 (load-double %z mem))
    (%673 (load-double %w mem))
    (%674 (fmul-double %672 %673))
    (%675 (fadd-double %671 %674))
    (%676 (fsub-double %670 %675))
    (mem (store-double %676 %r mem))
    (%677 (load-double %r mem))
    (%678 (load-double %z mem))
    (%679 (fsub-double %677 %678))
    (%680 (fsub-double #x3ff0000000000000 %679))
    (mem (store-double %680 %z mem))
    (%681 (bitcast-double*-to-i32* %z))
    (%682 (getelementptr-i32 %681 1))
    (%683 (load-i32 %682 mem))
    (mem (store-i32 %683 %j mem))
    (%684 (load-i32 %n mem))
    (%685 (shl-i32 %684 20))
    (%686 (load-i32 %j mem))
    (%687 (add-i32 %686 %685))
    (mem (store-i32 %687 %j mem))
    (%688 (load-i32 %j mem))
    (%689 (ashr-i32 %688 20))
    (%690 (icmp-sle-i32 %689 0)))
  (case %690
    (-1  (@__ieee754_pow-%691 mem %n %s %z %1))
    (0 (@__ieee754_pow-%695 mem %n %s %z %1)))))

(defund @__ieee754_pow-%618 (mem %j %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* (
    (%619 (load-double %t mem))
    (%620 (load-double %p_h mem))
    (%621 (fsub-double %620 %619))
    (mem (store-double %621 %p_h mem)))
  (@__ieee754_pow-%622 mem %j %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))

(defund @__ieee754_pow-%615 (mem %j %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* (
    (%616 (load-i32 %n mem))
    (%617 (sub-i32 0 %616))
    (mem (store-i32 %617 %n mem)))
  (@__ieee754_pow-%618 mem %j %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))

(defund @__ieee754_pow-%590 (mem %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* (
    (%591 (load-i32 %j mem))
    (%592 (load-i32 %k mem))
    (%593 (add-i32 %592 1))
    (%594 (ashr-i32 1048576 %593))
    (%595 (add-i32 %591 %594))
    (mem (store-i32 %595 %n mem))
    (%596 (load-i32 %n mem))
    (%597 (and-i32 %596 2147483647))
    (%598 (ashr-i32 %597 20))
    (%599 (sub-i32 %598 1023))
    (mem (store-i32 %599 %k mem))
    (mem (store-double #x0000000000000000 %t mem))
    (%600 (load-i32 %n mem))
    (%601 (load-i32 %k mem))
    (%602 (ashr-i32 1048575 %601))
    (%603 (xor-i32 %602 -1))
    (%604 (and-i32 %600 %603))
    (%605 (bitcast-double*-to-i32* %t))
    (%606 (getelementptr-i32 %605 1))
    (mem (store-i32 %604 %606 mem))
    (%607 (load-i32 %n mem))
    (%608 (and-i32 %607 1048575))
    (%609 (or-i32 %608 1048576))
    (%610 (load-i32 %k mem))
    (%611 (sub-i32 20 %610))
    (%612 (ashr-i32 %609 %611))
    (mem (store-i32 %612 %n mem))
    (%613 (load-i32 %j mem))
    (%614 (icmp-slt-i32 %613 0)))
  (case %614
    (-1  (@__ieee754_pow-%615 mem %j %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1))
    (0 (@__ieee754_pow-%618 mem %j %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))))

(defund @__ieee754_pow-%582 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* (
    (%583 (load-i32 %j mem))
    (%584 (and-i32 %583 2147483647))
    (mem (store-i32 %584 %i mem))
    (%585 (load-i32 %i mem))
    (%586 (ashr-i32 %585 20))
    (%587 (sub-i32 %586 1023))
    (mem (store-i32 %587 %k mem))
    (mem (store-i32 0 %n mem))
    (%588 (load-i32 %i mem))
    (%589 (icmp-sgt-i32 %588 1071644672)))
  (case %589
    (-1  (@__ieee754_pow-%590 mem %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1))
    (0 (@__ieee754_pow-%622 mem %j %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))))

(defund @__ieee754_pow-%581 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* ()
  (@__ieee754_pow-%582 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))

(defund @__ieee754_pow-%580 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* ()
  (@__ieee754_pow-%581 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))

(defund @__ieee754_pow-%579 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* ()
  (@__ieee754_pow-%580 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))

(defund @__ieee754_pow-%575 (mem %s %1)
  (b* (
    (%576 (load-double %s mem))
    (%577 (fmul-double %576 #x01a56e1fc2f8f359))
    (%578 (fmul-double %577 #x01a56e1fc2f8f359))
    (mem (store-double %578 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%569 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* (
    (%570 (load-double %p_l mem))
    (%571 (load-double %z mem))
    (%572 (load-double %p_h mem))
    (%573 (fsub-double %571 %572))
    (%574 (fcmp-ole-double %570 %573)))
  (case %574
    (-1  (@__ieee754_pow-%575 mem %s %1))
    (0 (@__ieee754_pow-%579 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))))

(defund @__ieee754_pow-%565 (mem %s %1)
  (b* (
    (%566 (load-double %s mem))
    (%567 (fmul-double %566 #x01a56e1fc2f8f359))
    (%568 (fmul-double %567 #x01a56e1fc2f8f359))
    (mem (store-double %568 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%559 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* (
    (%560 (load-i32 %j mem))
    (%561 (sub-i32 %560 -1064252416))
    (%562 (load-i32 %i mem))
    (%563 (or-i32 %561 %562))
    (%564 (icmp-ne-i32 %563 0)))
  (case %564
    (-1  (@__ieee754_pow-%565 mem %s %1))
    (0 (@__ieee754_pow-%569 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))))

(defund @__ieee754_pow-%555 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* (
    (%556 (load-i32 %j mem))
    (%557 (and-i32 %556 2147483647))
    (%558 (icmp-sge-i32 %557 1083231232)))
  (case %558
    (-1  (@__ieee754_pow-%559 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1))
    (0 (@__ieee754_pow-%581 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))))

(defund @__ieee754_pow-%554 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* ()
  (@__ieee754_pow-%582 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))

(defund @__ieee754_pow-%553 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* ()
  (@__ieee754_pow-%554 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))

(defund @__ieee754_pow-%549 (mem %s %1)
  (b* (
    (%550 (load-double %s mem))
    (%551 (fmul-double %550 #x7e37e43c8800759c))
    (%552 (fmul-double %551 #x7e37e43c8800759c))
    (mem (store-double %552 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%542 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* (
    (%543 (load-double %p_l mem))
    (%544 (fadd-double %543 #x3C971547652B82FE))
    (%545 (load-double %z mem))
    (%546 (load-double %p_h mem))
    (%547 (fsub-double %545 %546))
    (%548 (fcmp-ogt-double %544 %547)))
  (case %548
    (-1  (@__ieee754_pow-%549 mem %s %1))
    (0 (@__ieee754_pow-%553 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))))

(defund @__ieee754_pow-%538 (mem %s %1)
  (b* (
    (%539 (load-double %s mem))
    (%540 (fmul-double %539 #x7e37e43c8800759c))
    (%541 (fmul-double %540 #x7e37e43c8800759c))
    (mem (store-double %541 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%532 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)
  (b* (
    (%533 (load-i32 %j mem))
    (%534 (sub-i32 %533 1083179008))
    (%535 (load-i32 %i mem))
    (%536 (or-i32 %534 %535))
    (%537 (icmp-ne-i32 %536 0)))
  (case %537
    (-1  (@__ieee754_pow-%538 mem %s %1))
    (0 (@__ieee754_pow-%542 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))))

(defund @__ieee754_pow-%507 (mem %i %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)
  (b* (
    (%508 (load-double %3 mem))
    (mem (store-double %508 %y1 mem))
    (%509 (bitcast-double*-to-i32* %y1))
    (mem (store-i32 0 %509 mem))
    (%510 (load-double %3 mem))
    (%511 (load-double %y1 mem))
    (%512 (fsub-double %510 %511))
    (%513 (load-double %t1 mem))
    (%514 (fmul-double %512 %513))
    (%515 (load-double %3 mem))
    (%516 (load-double %t2 mem))
    (%517 (fmul-double %515 %516))
    (%518 (fadd-double %514 %517))
    (mem (store-double %518 %p_l mem))
    (%519 (load-double %y1 mem))
    (%520 (load-double %t1 mem))
    (%521 (fmul-double %519 %520))
    (mem (store-double %521 %p_h mem))
    (%522 (load-double %p_l mem))
    (%523 (load-double %p_h mem))
    (%524 (fadd-double %522 %523))
    (mem (store-double %524 %z mem))
    (%525 (bitcast-double*-to-i32* %z))
    (%526 (getelementptr-i32 %525 1))
    (%527 (load-i32 %526 mem))
    (mem (store-i32 %527 %j mem))
    (%528 (bitcast-double*-to-i32* %z))
    (%529 (load-i32 %528 mem))
    (mem (store-i32 %529 %i mem))
    (%530 (load-i32 %j mem))
    (%531 (icmp-sge-i32 %530 1083179008)))
  (case %531
    (-1  (@__ieee754_pow-%532 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1))
    (0 (@__ieee754_pow-%555 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %u %v %w %z %1)))))

(defund @__ieee754_pow-%358 (mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* (
    (%359 (load-i32 %ix mem))
    (%360 (bitcast-double*-to-i32* %ax))
    (%361 (getelementptr-i32 %360 1))
    (mem (store-i32 %359 %361 mem))
    (%362 (load-double %ax mem))
    (%363 (load-i32 %k mem))
    (%364 (sext-i32-to-i64 %363))
    (%365 (getelementptr-double '(bp . 0) %364))
    (%366 (load-double %365 mem))
    (%367 (fsub-double %362 %366))
    (mem (store-double %367 %u mem))
    (%368 (load-double %ax mem))
    (%369 (load-i32 %k mem))
    (%370 (sext-i32-to-i64 %369))
    (%371 (getelementptr-double '(bp . 0) %370))
    (%372 (load-double %371 mem))
    (%373 (fadd-double %368 %372))
    (%374 (fdiv-double #x3ff0000000000000 %373))
    (mem (store-double %374 %v mem))
    (%375 (load-double %u mem))
    (%376 (load-double %v mem))
    (%377 (fmul-double %375 %376))
    (mem (store-double %377 %ss mem))
    (%378 (load-double %ss mem))
    (mem (store-double %378 %s_h mem))
    (%379 (bitcast-double*-to-i32* %s_h))
    (mem (store-i32 0 %379 mem))
    (mem (store-double #x0000000000000000 %t_h mem))
    (%380 (load-i32 %ix mem))
    (%381 (ashr-i32 %380 1))
    (%382 (or-i32 %381 536870912))
    (%383 (add-i32 %382 524288))
    (%384 (load-i32 %k mem))
    (%385 (shl-i32 %384 18))
    (%386 (add-i32 %383 %385))
    (%387 (bitcast-double*-to-i32* %t_h))
    (%388 (getelementptr-i32 %387 1))
    (mem (store-i32 %386 %388 mem))
    (%389 (load-double %ax mem))
    (%390 (load-double %t_h mem))
    (%391 (load-i32 %k mem))
    (%392 (sext-i32-to-i64 %391))
    (%393 (getelementptr-double '(bp . 0) %392))
    (%394 (load-double %393 mem))
    (%395 (fsub-double %390 %394))
    (%396 (fsub-double %389 %395))
    (mem (store-double %396 %t_l mem))
    (%397 (load-double %v mem))
    (%398 (load-double %u mem))
    (%399 (load-double %s_h mem))
    (%400 (load-double %t_h mem))
    (%401 (fmul-double %399 %400))
    (%402 (fsub-double %398 %401))
    (%403 (load-double %s_h mem))
    (%404 (load-double %t_l mem))
    (%405 (fmul-double %403 %404))
    (%406 (fsub-double %402 %405))
    (%407 (fmul-double %397 %406))
    (mem (store-double %407 %s_l mem))
    (%408 (load-double %ss mem))
    (%409 (load-double %ss mem))
    (%410 (fmul-double %408 %409))
    (mem (store-double %410 %s2 mem))
    (%411 (load-double %s2 mem))
    (%412 (load-double %s2 mem))
    (%413 (fmul-double %411 %412))
    (%414 (load-double %s2 mem))
    (%415 (load-double %s2 mem))
    (%416 (load-double %s2 mem))
    (%417 (load-double %s2 mem))
    (%418 (load-double %s2 mem))
    (%419 (fmul-double %418 #x3FCA7E284A454EEF))
    (%420 (fadd-double #x3FCD864A93C9DB65 %419))
    (%421 (fmul-double %417 %420))
    (%422 (fadd-double #x3FD17460A91D4101 %421))
    (%423 (fmul-double %416 %422))
    (%424 (fadd-double #x3FD55555518F264D %423))
    (%425 (fmul-double %415 %424))
    (%426 (fadd-double #x3FDB6DB6DB6FABFF %425))
    (%427 (fmul-double %414 %426))
    (%428 (fadd-double #x3FE3333333333303 %427))
    (%429 (fmul-double %413 %428))
    (mem (store-double %429 %r mem))
    (%430 (load-double %s_l mem))
    (%431 (load-double %s_h mem))
    (%432 (load-double %ss mem))
    (%433 (fadd-double %431 %432))
    (%434 (fmul-double %430 %433))
    (%435 (load-double %r mem))
    (%436 (fadd-double %435 %434))
    (mem (store-double %436 %r mem))
    (%437 (load-double %s_h mem))
    (%438 (load-double %s_h mem))
    (%439 (fmul-double %437 %438))
    (mem (store-double %439 %s2 mem))
    (%440 (load-double %s2 mem))
    (%441 (fadd-double #x4008000000000000 %440))
    (%442 (load-double %r mem))
    (%443 (fadd-double %441 %442))
    (mem (store-double %443 %t_h mem))
    (%444 (bitcast-double*-to-i32* %t_h))
    (mem (store-i32 0 %444 mem))
    (%445 (load-double %r mem))
    (%446 (load-double %t_h mem))
    (%447 (fsub-double %446 #x4008000000000000))
    (%448 (load-double %s2 mem))
    (%449 (fsub-double %447 %448))
    (%450 (fsub-double %445 %449))
    (mem (store-double %450 %t_l mem))
    (%451 (load-double %s_h mem))
    (%452 (load-double %t_h mem))
    (%453 (fmul-double %451 %452))
    (mem (store-double %453 %u mem))
    (%454 (load-double %s_l mem))
    (%455 (load-double %t_h mem))
    (%456 (fmul-double %454 %455))
    (%457 (load-double %t_l mem))
    (%458 (load-double %ss mem))
    (%459 (fmul-double %457 %458))
    (%460 (fadd-double %456 %459))
    (mem (store-double %460 %v mem))
    (%461 (load-double %u mem))
    (%462 (load-double %v mem))
    (%463 (fadd-double %461 %462))
    (mem (store-double %463 %p_h mem))
    (%464 (bitcast-double*-to-i32* %p_h))
    (mem (store-i32 0 %464 mem))
    (%465 (load-double %v mem))
    (%466 (load-double %p_h mem))
    (%467 (load-double %u mem))
    (%468 (fsub-double %466 %467))
    (%469 (fsub-double %465 %468))
    (mem (store-double %469 %p_l mem))
    (%470 (load-double %p_h mem))
    (%471 (fmul-double #x3FEEC709E0000000 %470))
    (mem (store-double %471 %z_h mem))
    (%472 (load-double %p_h mem))
    (%473 (fmul-double #xBE3E2FE0145B01F5 %472))
    (%474 (load-double %p_l mem))
    (%475 (fmul-double %474 #x3FEEC709DC3A03FD))
    (%476 (fadd-double %473 %475))
    (%477 (load-i32 %k mem))
    (%478 (sext-i32-to-i64 %477))
    (%479 (getelementptr-double '(dp_l . 0) %478))
    (%480 (load-double %479 mem))
    (%481 (fadd-double %476 %480))
    (mem (store-double %481 %z_l mem))
    (%482 (load-i32 %n mem))
    (%483 (sitofp-i32-to-double %482))
    (mem (store-double %483 %t mem))
    (%484 (load-double %z_h mem))
    (%485 (load-double %z_l mem))
    (%486 (fadd-double %484 %485))
    (%487 (load-i32 %k mem))
    (%488 (sext-i32-to-i64 %487))
    (%489 (getelementptr-double '(dp_h . 0) %488))
    (%490 (load-double %489 mem))
    (%491 (fadd-double %486 %490))
    (%492 (load-double %t mem))
    (%493 (fadd-double %491 %492))
    (mem (store-double %493 %t1 mem))
    (%494 (bitcast-double*-to-i32* %t1))
    (mem (store-i32 0 %494 mem))
    (%495 (load-double %z_l mem))
    (%496 (load-double %t1 mem))
    (%497 (load-double %t mem))
    (%498 (fsub-double %496 %497))
    (%499 (load-i32 %k mem))
    (%500 (sext-i32-to-i64 %499))
    (%501 (getelementptr-double '(dp_h . 0) %500))
    (%502 (load-double %501 mem))
    (%503 (fsub-double %498 %502))
    (%504 (load-double %z_h mem))
    (%505 (fsub-double %503 %504))
    (%506 (fsub-double %495 %505))
    (mem (store-double %506 %t2 mem)))
  (@__ieee754_pow-%507 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)))

(defund @__ieee754_pow-%357 (mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* ()
  (@__ieee754_pow-%358 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))

(defund @__ieee754_pow-%352 (mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* (
    (mem (store-i32 0 %k mem))
    (%353 (load-i32 %n mem))
    (%354 (add-i32 %353 1))
    (mem (store-i32 %354 %n mem))
    (%355 (load-i32 %ix mem))
    (%356 (sub-i32 %355 1048576))
    (mem (store-i32 %356 %ix mem)))
  (@__ieee754_pow-%357 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))

(defund @__ieee754_pow-%351 (mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* (
    (mem (store-i32 1 %k mem)))
  (@__ieee754_pow-%357 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))

(defund @__ieee754_pow-%348 (mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* (
    (%349 (load-i32 %j mem))
    (%350 (icmp-slt-i32 %349 767610)))
  (case %350
    (-1  (@__ieee754_pow-%351 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3))
    (0 (@__ieee754_pow-%352 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))))

(defund @__ieee754_pow-%347 (mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* (
    (mem (store-i32 0 %k mem)))
  (@__ieee754_pow-%358 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))

(defund @__ieee754_pow-%335 (mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* (
    (%336 (load-i32 %ix mem))
    (%337 (ashr-i32 %336 20))
    (%338 (sub-i32 %337 1023))
    (%339 (load-i32 %n mem))
    (%340 (add-i32 %339 %338))
    (mem (store-i32 %340 %n mem))
    (%341 (load-i32 %ix mem))
    (%342 (and-i32 %341 1048575))
    (mem (store-i32 %342 %j mem))
    (%343 (load-i32 %j mem))
    (%344 (or-i32 %343 1072693248))
    (mem (store-i32 %344 %ix mem))
    (%345 (load-i32 %j mem))
    (%346 (icmp-sle-i32 %345 235662)))
  (case %346
    (-1  (@__ieee754_pow-%347 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3))
    (0 (@__ieee754_pow-%348 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))))

(defund @__ieee754_pow-%327 (mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* (
    (%328 (load-double %ax mem))
    (%329 (fmul-double %328 #x4340000000000000))
    (mem (store-double %329 %ax mem))
    (%330 (load-i32 %n mem))
    (%331 (sub-i32 %330 53))
    (mem (store-i32 %331 %n mem))
    (%332 (bitcast-double*-to-i32* %ax))
    (%333 (getelementptr-i32 %332 1))
    (%334 (load-i32 %333 mem))
    (mem (store-i32 %334 %ix mem)))
  (@__ieee754_pow-%335 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))

(defund @__ieee754_pow-%324 (mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* (
    (mem (store-i32 0 %n mem))
    (%325 (load-i32 %ix mem))
    (%326 (icmp-slt-i32 %325 1048576)))
  (case %326
    (-1  (@__ieee754_pow-%327 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3))
    (0 (@__ieee754_pow-%335 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))))

(defund @__ieee754_pow-%295 (mem %ax %i %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)
  (b* (
    (%296 (load-double %ax mem))
    (%297 (fsub-double %296 #x3ff0000000000000))
    (mem (store-double %297 %t mem))
    (%298 (load-double %t mem))
    (%299 (load-double %t mem))
    (%300 (fmul-double %298 %299))
    (%301 (load-double %t mem))
    (%302 (load-double %t mem))
    (%303 (fmul-double %302 #x3fd0000000000000))
    (%304 (fsub-double #x3FD5555555555555 %303))
    (%305 (fmul-double %301 %304))
    (%306 (fsub-double #x3fe0000000000000 %305))
    (%307 (fmul-double %300 %306))
    (mem (store-double %307 %w mem))
    (%308 (load-double %t mem))
    (%309 (fmul-double #x3FF7154760000000 %308))
    (mem (store-double %309 %u mem))
    (%310 (load-double %t mem))
    (%311 (fmul-double %310 #x3E54AE0BF85DDF44))
    (%312 (load-double %w mem))
    (%313 (fmul-double %312 #x3FF71547652B82FE))
    (%314 (fsub-double %311 %313))
    (mem (store-double %314 %v mem))
    (%315 (load-double %u mem))
    (%316 (load-double %v mem))
    (%317 (fadd-double %315 %316))
    (mem (store-double %317 %t1 mem))
    (%318 (bitcast-double*-to-i32* %t1))
    (mem (store-i32 0 %318 mem))
    (%319 (load-double %v mem))
    (%320 (load-double %t1 mem))
    (%321 (load-double %u mem))
    (%322 (fsub-double %320 %321))
    (%323 (fsub-double %319 %322))
    (mem (store-double %323 %t2 mem)))
  (@__ieee754_pow-%507 mem %i %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)))

(defund @__ieee754_pow-%293 (mem %1 %294)
  (b* (
    ; %294 = phi double [ %288, %285 ], [ %292, %289 ]
    (mem (store-double %294 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%289 (mem %s %1)
  (b* (
    (%290 (load-double %s mem))
    (%291 (fmul-double %290 #x01a56e1fc2f8f359))
    (%292 (fmul-double %291 #x01a56e1fc2f8f359)))
  (@__ieee754_pow-%293 mem %1 %292)))

(defund @__ieee754_pow-%285 (mem %s %1)
  (b* (
    (%286 (load-double %s mem))
    (%287 (fmul-double %286 #x7e37e43c8800759c))
    (%288 (fmul-double %287 #x7e37e43c8800759c)))
  (@__ieee754_pow-%293 mem %1 %288)))

(defund @__ieee754_pow-%282 (mem %hy %s %1)
  (b* (
    (%283 (load-i32 %hy mem))
    (%284 (icmp-sgt-i32 %283 0)))
  (case %284
    (-1  (@__ieee754_pow-%285 mem %s %1))
    (0 (@__ieee754_pow-%289 mem %s %1)))))

(defund @__ieee754_pow-%279 (mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)
  (b* (
    (%280 (load-i32 %ix mem))
    (%281 (icmp-sgt-i32 %280 1072693248)))
  (case %281
    (-1  (@__ieee754_pow-%282 mem %hy %s %1))
    (0 (@__ieee754_pow-%295 mem %ax %i %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)))))

(defund @__ieee754_pow-%277 (mem %1 %278)
  (b* (
    ; %278 = phi double [ %272, %269 ], [ %276, %273 ]
    (mem (store-double %278 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%273 (mem %s %1)
  (b* (
    (%274 (load-double %s mem))
    (%275 (fmul-double %274 #x01a56e1fc2f8f359))
    (%276 (fmul-double %275 #x01a56e1fc2f8f359)))
  (@__ieee754_pow-%277 mem %1 %276)))

(defund @__ieee754_pow-%269 (mem %s %1)
  (b* (
    (%270 (load-double %s mem))
    (%271 (fmul-double %270 #x7e37e43c8800759c))
    (%272 (fmul-double %271 #x7e37e43c8800759c)))
  (@__ieee754_pow-%277 mem %1 %272)))

(defund @__ieee754_pow-%266 (mem %hy %s %1)
  (b* (
    (%267 (load-i32 %hy mem))
    (%268 (icmp-slt-i32 %267 0)))
  (case %268
    (-1  (@__ieee754_pow-%269 mem %s %1))
    (0 (@__ieee754_pow-%273 mem %s %1)))))

(defund @__ieee754_pow-%263 (mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)
  (b* (
    (%264 (load-i32 %ix mem))
    (%265 (icmp-slt-i32 %264 1072693247)))
  (case %265
    (-1  (@__ieee754_pow-%266 mem %hy %s %1))
    (0 (@__ieee754_pow-%279 mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)))))

(defund @__ieee754_pow-%262 (mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)
  (b* ()
  (@__ieee754_pow-%263 mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)))

(defund @__ieee754_pow-%258 (mem %hy %1)
  (b* (
    (%259 (load-i32 %hy mem))
    (%260 (icmp-sgt-i32 %259 0))
    (%261 (select-double %260 #x7FF0000000000000 #x0000000000000000))
    (mem (store-double %261 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%255 (mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)
  (b* (
    (%256 (load-i32 %ix mem))
    (%257 (icmp-sge-i32 %256 1072693248)))
  (case %257
    (-1  (@__ieee754_pow-%258 mem %hy %1))
    (0 (@__ieee754_pow-%262 mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)))))

(defund @__ieee754_pow-%251 (mem %hy %1)
  (b* (
    (%252 (load-i32 %hy mem))
    (%253 (icmp-slt-i32 %252 0))
    (%254 (select-double %253 #x7FF0000000000000 #x0000000000000000))
    (mem (store-double %254 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%248 (mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)
  (b* (
    (%249 (load-i32 %ix mem))
    (%250 (icmp-sle-i32 %249 1072693247)))
  (case %250
    (-1  (@__ieee754_pow-%251 mem %hy %1))
    (0 (@__ieee754_pow-%255 mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)))))

(defund @__ieee754_pow-%245 (mem %ax %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)
  (b* (
    (%246 (load-i32 %iy mem))
    (%247 (icmp-sgt-i32 %246 1139802112)))
  (case %247
    (-1  (@__ieee754_pow-%248 mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3))
    (0 (@__ieee754_pow-%263 mem %ax %hy %i %ix %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3)))))

(defund @__ieee754_pow-%242 (mem %ax %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* (
    (%243 (load-i32 %iy mem))
    (%244 (icmp-sgt-i32 %243 1105199104)))
  (case %244
    (-1  (@__ieee754_pow-%245 mem %ax %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %t %t1 %t2 %u %v %w %y1 %z %1 %3))
    (0 (@__ieee754_pow-%324 mem %ax %i %ix %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))))

(defund @__ieee754_pow-%241 (mem %ax %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)
  (b* (
    (mem (store-double #xbff0000000000000 %s mem)))
  (@__ieee754_pow-%242 mem %ax %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))

(defund @__ieee754_pow-%235 (mem %ax %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %3)
  (b* (
    (mem (store-double #x3ff0000000000000 %s mem))
    (%236 (load-i32 %n mem))
    (%237 (load-i32 %yisint mem))
    (%238 (sub-i32 %237 1))
    (%239 (or-i32 %236 %238))
    (%240 (icmp-eq-i32 %239 0)))
  (case %240
    (-1  (@__ieee754_pow-%241 mem %ax %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3))
    (0 (@__ieee754_pow-%242 mem %ax %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %z %z_h %z_l %1 %3)))))

(defund @__ieee754_pow-%227 (mem %1 %2)
  (b* (
    (%228 (load-double %2 mem))
    (%229 (load-double %2 mem))
    (%230 (fsub-double %228 %229))
    (%231 (load-double %2 mem))
    (%232 (load-double %2 mem))
    (%233 (fsub-double %231 %232))
    (%234 (fdiv-double %230 %233))
    (mem (store-double %234 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%219 (mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%220 (load-i32 %hx mem))
    (%221 (ashr-i32 %220 31))
    (%222 (add-i32 %221 1))
    (mem (store-i32 %222 %n mem))
    (%223 (load-i32 %n mem))
    (%224 (load-i32 %yisint mem))
    (%225 (or-i32 %223 %224))
    (%226 (icmp-eq-i32 %225 0)))
  (case %226
    (-1  (@__ieee754_pow-%227 mem %1 %2))
    (0 (@__ieee754_pow-%235 mem %ax %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %3)))))

(defund @__ieee754_pow-%218 (mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* ()
  (@__ieee754_pow-%219 mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%216 (mem %z %1)
  (b* (
    (%217 (load-double %z mem))
    (mem (store-double %217 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%215 (mem %z %1)
  (b* ()
  (@__ieee754_pow-%216 mem %z %1)))

(defund @__ieee754_pow-%214 (mem %z %1)
  (b* ()
  (@__ieee754_pow-%215 mem %z %1)))

(defund @__ieee754_pow-%211 (mem %z %1)
  (b* (
    (%212 (load-double %z mem))
    (%213 (fsub-double #x8000000000000000 %212))
    (mem (store-double %213 %z mem)))
  (@__ieee754_pow-%214 mem %z %1)))

(defund @__ieee754_pow-%208 (mem %yisint %z %1)
  (b* (
    (%209 (load-i32 %yisint mem))
    (%210 (icmp-eq-i32 %209 1)))
  (case %210
    (-1  (@__ieee754_pow-%211 mem %z %1))
    (0 (@__ieee754_pow-%214 mem %z %1)))))

(defund @__ieee754_pow-%200 (mem %z %1)
  (b* (
    (%201 (load-double %z mem))
    (%202 (load-double %z mem))
    (%203 (fsub-double %201 %202))
    (%204 (load-double %z mem))
    (%205 (load-double %z mem))
    (%206 (fsub-double %204 %205))
    (%207 (fdiv-double %203 %206))
    (mem (store-double %207 %z mem)))
  (@__ieee754_pow-%215 mem %z %1)))

(defund @__ieee754_pow-%194 (mem %ix %yisint %z %1)
  (b* (
    (%195 (load-i32 %ix mem))
    (%196 (sub-i32 %195 1072693248))
    (%197 (load-i32 %yisint mem))
    (%198 (or-i32 %196 %197))
    (%199 (icmp-eq-i32 %198 0)))
  (case %199
    (-1  (@__ieee754_pow-%200 mem %z %1))
    (0 (@__ieee754_pow-%208 mem %yisint %z %1)))))

(defund @__ieee754_pow-%191 (mem %hx %ix %yisint %z %1)
  (b* (
    (%192 (load-i32 %hx mem))
    (%193 (icmp-slt-i32 %192 0)))
  (case %193
    (-1  (@__ieee754_pow-%194 mem %ix %yisint %z %1))
    (0 (@__ieee754_pow-%216 mem %z %1)))))

(defund @__ieee754_pow-%188 (mem %hx %ix %yisint %z %1)
  (b* (
    (%189 (load-double %z mem))
    (%190 (fdiv-double #x3ff0000000000000 %189))
    (mem (store-double %190 %z mem)))
  (@__ieee754_pow-%191 mem %hx %ix %yisint %z %1)))

(defund @__ieee754_pow-%184 (mem %ax %hx %hy %ix %yisint %z %1)
  (b* (
    (%185 (load-double %ax mem))
    (mem (store-double %185 %z mem))
    (%186 (load-i32 %hy mem))
    (%187 (icmp-slt-i32 %186 0)))
  (case %187
    (-1  (@__ieee754_pow-%188 mem %hx %ix %yisint %z %1))
    (0 (@__ieee754_pow-%191 mem %hx %ix %yisint %z %1)))))

(defund @__ieee754_pow-%181 (mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%182 (load-i32 %ix mem))
    (%183 (icmp-eq-i32 %182 1072693248)))
  (case %183
    (-1  (@__ieee754_pow-%184 mem %ax %hx %hy %ix %yisint %z %1))
    (0 (@__ieee754_pow-%218 mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%178 (mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%179 (load-i32 %ix mem))
    (%180 (icmp-eq-i32 %179 0)))
  (case %180
    (-1  (@__ieee754_pow-%184 mem %ax %hx %hy %ix %yisint %z %1))
    (0 (@__ieee754_pow-%181 mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%175 (mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%176 (load-i32 %ix mem))
    (%177 (icmp-eq-i32 %176 2146435072)))
  (case %177
    (-1  (@__ieee754_pow-%184 mem %ax %hx %hy %ix %yisint %z %1))
    (0 (@__ieee754_pow-%178 mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%170 (mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%171 (load-double %2 mem))
    (%172 (@fabs %171))
    (mem (store-double %172 %ax mem))
    (%173 (load-i32 %lx mem))
    (%174 (icmp-eq-i32 %173 0)))
  (case %174
    (-1  (@__ieee754_pow-%175 mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%219 mem %ax %hx %hy %i %ix %iy %j %k %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%169 (mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* ()
  (@__ieee754_pow-%170 mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%168 (mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* ()
  (@__ieee754_pow-%169 mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%165 (mem %1 %2)
  (b* (
    (%166 (load-double %2 mem))
    (%167 (@sqrt %166))
    (mem (store-double %167 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%162 (mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%163 (load-i32 %hx mem))
    (%164 (icmp-sge-i32 %163 0)))
  (case %164
    (-1  (@__ieee754_pow-%165 mem %1 %2))
    (0 (@__ieee754_pow-%168 mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%159 (mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%160 (load-i32 %hy mem))
    (%161 (icmp-eq-i32 %160 1071644672)))
  (case %161
    (-1  (@__ieee754_pow-%162 mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%169 mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%155 (mem %1 %2)
  (b* (
    (%156 (load-double %2 mem))
    (%157 (load-double %2 mem))
    (%158 (fmul-double %156 %157))
    (mem (store-double %158 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%152 (mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%153 (load-i32 %hy mem))
    (%154 (icmp-eq-i32 %153 1073741824)))
  (case %154
    (-1  (@__ieee754_pow-%155 mem %1 %2))
    (0 (@__ieee754_pow-%159 mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%150 (mem %1 %2)
  (b* (
    (%151 (load-double %2 mem))
    (mem (store-double %151 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%147 (mem %1 %2)
  (b* (
    (%148 (load-double %2 mem))
    (%149 (fdiv-double #x3ff0000000000000 %148))
    (mem (store-double %149 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%144 (mem %hy %1 %2)
  (b* (
    (%145 (load-i32 %hy mem))
    (%146 (icmp-slt-i32 %145 0)))
  (case %146
    (-1  (@__ieee754_pow-%147 mem %1 %2))
    (0 (@__ieee754_pow-%150 mem %1 %2)))))

(defund @__ieee754_pow-%141 (mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%142 (load-i32 %iy mem))
    (%143 (icmp-eq-i32 %142 1072693248)))
  (case %143
    (-1  (@__ieee754_pow-%144 mem %hy %1 %2))
    (0 (@__ieee754_pow-%152 mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%139 (mem %1 %140)
  (b* (
    ; %140 = phi double [ %137, %135 ], [ #x0000000000000000, %138 ]
    (mem (store-double %140 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%138 (mem %1)
  (b* ()
  (@__ieee754_pow-%139 mem %1 #x0000000000000000)))

(defund @__ieee754_pow-%135 (mem %1 %3)
  (b* (
    (%136 (load-double %3 mem))
    (%137 (fsub-double #x8000000000000000 %136)))
  (@__ieee754_pow-%139 mem %1 %137)))

(defund @__ieee754_pow-%132 (mem %hy %1 %3)
  (b* (
    (%133 (load-i32 %hy mem))
    (%134 (icmp-slt-i32 %133 0)))
  (case %134
    (-1  (@__ieee754_pow-%135 mem %1 %3))
    (0 (@__ieee754_pow-%138 mem %1)))))

(defund @__ieee754_pow-%130 (mem %1 %131)
  (b* (
    ; %131 = phi double [ %128, %127 ], [ #x0000000000000000, %129 ]
    (mem (store-double %131 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%129 (mem %1)
  (b* ()
  (@__ieee754_pow-%130 mem %1 #x0000000000000000)))

(defund @__ieee754_pow-%127 (mem %1 %3)
  (b* (
    (%128 (load-double %3 mem)))
  (@__ieee754_pow-%130 mem %1 %128)))

(defund @__ieee754_pow-%124 (mem %hy %1 %3)
  (b* (
    (%125 (load-i32 %hy mem))
    (%126 (icmp-sge-i32 %125 0)))
  (case %126
    (-1  (@__ieee754_pow-%127 mem %1 %3))
    (0 (@__ieee754_pow-%129 mem %1)))))

(defund @__ieee754_pow-%121 (mem %hy %ix %1 %3)
  (b* (
    (%122 (load-i32 %ix mem))
    (%123 (icmp-sge-i32 %122 1072693248)))
  (case %123
    (-1  (@__ieee754_pow-%124 mem %hy %1 %3))
    (0 (@__ieee754_pow-%132 mem %hy %1 %3)))))

(defund @__ieee754_pow-%117 (mem %1 %3)
  (b* (
    (%118 (load-double %3 mem))
    (%119 (load-double %3 mem))
    (%120 (fsub-double %118 %119))
    (mem (store-double %120 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%111 (mem %hy %ix %lx %1 %3)
  (b* (
    (%112 (load-i32 %ix mem))
    (%113 (sub-i32 %112 1072693248))
    (%114 (load-i32 %lx mem))
    (%115 (or-i32 %113 %114))
    (%116 (icmp-eq-i32 %115 0)))
  (case %116
    (-1  (@__ieee754_pow-%117 mem %1 %3))
    (0 (@__ieee754_pow-%121 mem %hy %ix %1 %3)))))

(defund @__ieee754_pow-%108 (mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%109 (load-i32 %iy mem))
    (%110 (icmp-eq-i32 %109 2146435072)))
  (case %110
    (-1  (@__ieee754_pow-%111 mem %hy %ix %lx %1 %3))
    (0 (@__ieee754_pow-%141 mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%105 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%106 (load-i32 %ly mem))
    (%107 (icmp-eq-i32 %106 0)))
  (case %107
    (-1  (@__ieee754_pow-%108 mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%170 mem %ax %hx %hy %i %ix %iy %j %k %lx %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%104 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* ()
  (@__ieee754_pow-%105 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%103 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* ()
  (@__ieee754_pow-%104 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%102 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* ()
  (@__ieee754_pow-%103 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%101 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* ()
  (@__ieee754_pow-%102 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%100 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* ()
  (@__ieee754_pow-%101 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%96 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%97 (load-i32 %j mem))
    (%98 (and-i32 %97 1))
    (%99 (sub-i32 2 %98))
    (mem (store-i32 %99 %yisint mem)))
  (@__ieee754_pow-%100 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%85 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%86 (load-i32 %iy mem))
    (%87 (load-i32 %k mem))
    (%88 (sub-i32 20 %87))
    (%89 (ashr-i32 %86 %88))
    (mem (store-i32 %89 %j mem))
    (%90 (load-i32 %j mem))
    (%91 (load-i32 %k mem))
    (%92 (sub-i32 20 %91))
    (%93 (shl-i32 %90 %92))
    (%94 (load-i32 %iy mem))
    (%95 (icmp-eq-i32 %93 %94)))
  (case %95
    (-1  (@__ieee754_pow-%96 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%100 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%82 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%83 (load-i32 %ly mem))
    (%84 (icmp-eq-i32 %83 0)))
  (case %84
    (-1  (@__ieee754_pow-%85 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%101 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%81 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* ()
  (@__ieee754_pow-%102 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%77 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%78 (load-i32 %j mem))
    (%79 (and-i32 %78 1))
    (%80 (sub-i32 2 %79))
    (mem (store-i32 %80 %yisint mem)))
  (@__ieee754_pow-%81 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%66 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%67 (load-i32 %ly mem))
    (%68 (load-i32 %k mem))
    (%69 (sub-i32 52 %68))
    (%70 (lshr-i32 %67 %69))
    (mem (store-i32 %70 %j mem))
    (%71 (load-i32 %j mem))
    (%72 (load-i32 %k mem))
    (%73 (sub-i32 52 %72))
    (%74 (shl-i32 %71 %73))
    (%75 (load-i32 %ly mem))
    (%76 (icmp-eq-i32 %74 %75)))
  (case %76
    (-1  (@__ieee754_pow-%77 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%81 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%60 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%61 (load-i32 %iy mem))
    (%62 (ashr-i32 %61 20))
    (%63 (sub-i32 %62 1023))
    (mem (store-i32 %63 %k mem))
    (%64 (load-i32 %k mem))
    (%65 (icmp-sgt-i32 %64 20)))
  (case %65
    (-1  (@__ieee754_pow-%66 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%82 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%57 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%58 (load-i32 %iy mem))
    (%59 (icmp-sge-i32 %58 1072693248)))
  (case %59
    (-1  (@__ieee754_pow-%60 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%103 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%56 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (mem (store-i32 2 %yisint mem)))
  (@__ieee754_pow-%104 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))

(defund @__ieee754_pow-%53 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%54 (load-i32 %iy mem))
    (%55 (icmp-sge-i32 %54 1128267776)))
  (case %55
    (-1  (@__ieee754_pow-%56 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%57 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%50 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (mem (store-i32 0 %yisint mem))
    (%51 (load-i32 %hx mem))
    (%52 (icmp-slt-i32 %51 0)))
  (case %52
    (-1  (@__ieee754_pow-%53 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%105 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%46 (mem %1 %2 %3)
  (b* (
    (%47 (load-double %2 mem))
    (%48 (load-double %3 mem))
    (%49 (fadd-double %47 %48))
    (mem (store-double %49 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%43 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%44 (load-i32 %ly mem))
    (%45 (icmp-ne-i32 %44 0)))
  (case %45
    (-1  (@__ieee754_pow-%46 mem %1 %2 %3))
    (0 (@__ieee754_pow-%50 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%40 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%41 (load-i32 %iy mem))
    (%42 (icmp-eq-i32 %41 2146435072)))
  (case %42
    (-1  (@__ieee754_pow-%43 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%50 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%37 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%38 (load-i32 %iy mem))
    (%39 (icmp-sgt-i32 %38 2146435072)))
  (case %39
    (-1  (@__ieee754_pow-%46 mem %1 %2 %3))
    (0 (@__ieee754_pow-%40 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%34 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%35 (load-i32 %lx mem))
    (%36 (icmp-ne-i32 %35 0)))
  (case %36
    (-1  (@__ieee754_pow-%46 mem %1 %2 %3))
    (0 (@__ieee754_pow-%37 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%31 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%32 (load-i32 %ix mem))
    (%33 (icmp-eq-i32 %32 2146435072)))
  (case %33
    (-1  (@__ieee754_pow-%34 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3))
    (0 (@__ieee754_pow-%37 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%28 (mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)
  (b* (
    (%29 (load-i32 %ix mem))
    (%30 (icmp-sgt-i32 %29 2146435072)))
  (case %30
    (-1  (@__ieee754_pow-%46 mem %1 %2 %3))
    (0 (@__ieee754_pow-%31 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow-%27 (mem %1)
  (b* (
    (mem (store-double #x3ff0000000000000 %1 mem)))
  (@__ieee754_pow-%706 mem %1)))

(defund @__ieee754_pow-%0 (mem %x %y)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    ((mv %3 mem) (alloca-double 'y 1 mem))
    ((mv %z mem) (alloca-double 'z 1 mem))
    ((mv %ax mem) (alloca-double 'ax 1 mem))
    ((mv %z_h mem) (alloca-double 'z_h 1 mem))
    ((mv %z_l mem) (alloca-double 'z_l 1 mem))
    ((mv %p_h mem) (alloca-double 'p_h 1 mem))
    ((mv %p_l mem) (alloca-double 'p_l 1 mem))
    ((mv %y1 mem) (alloca-double 'y1 1 mem))
    ((mv %t1 mem) (alloca-double 't1 1 mem))
    ((mv %t2 mem) (alloca-double 't2 1 mem))
    ((mv %r mem) (alloca-double 'r 1 mem))
    ((mv %s mem) (alloca-double 's 1 mem))
    ((mv %t mem) (alloca-double 't 1 mem))
    ((mv %u mem) (alloca-double 'u 1 mem))
    ((mv %v mem) (alloca-double 'v 1 mem))
    ((mv %w mem) (alloca-double 'w 1 mem))
    ((mv %i0 mem) (alloca-i32 'i0 1 mem))
    ((mv %i1 mem) (alloca-i32 'i1 1 mem))
    ((mv %i mem) (alloca-i32 'i 1 mem))
    ((mv %j mem) (alloca-i32 'j 1 mem))
    ((mv %k mem) (alloca-i32 'k 1 mem))
    ((mv %yisint mem) (alloca-i32 'yisint 1 mem))
    ((mv %n mem) (alloca-i32 'n 1 mem))
    ((mv %hx mem) (alloca-i32 'hx 1 mem))
    ((mv %hy mem) (alloca-i32 'hy 1 mem))
    ((mv %ix mem) (alloca-i32 'ix 1 mem))
    ((mv %iy mem) (alloca-i32 'iy 1 mem))
    ((mv %lx mem) (alloca-i32 'lx 1 mem))
    ((mv %ly mem) (alloca-i32 'ly 1 mem))
    ((mv %ss mem) (alloca-double 'ss 1 mem))
    ((mv %s2 mem) (alloca-double 's2 1 mem))
    ((mv %s_h mem) (alloca-double 's_h 1 mem))
    ((mv %s_l mem) (alloca-double 's_l 1 mem))
    ((mv %t_h mem) (alloca-double 't_h 1 mem))
    ((mv %t_l mem) (alloca-double 't_l 1 mem))
    (mem (store-double %x %2 mem))
    (mem (store-double %y %3 mem))
    (%4 (load-i32 '(one . 0) mem))
    (%5 (ashr-i32 %4 29))
    (%6 (xor-i32 %5 1))
    (mem (store-i32 %6 %i0 mem))
    (%7 (load-i32 %i0 mem))
    (%8 (sub-i32 1 %7))
    (mem (store-i32 %8 %i1 mem))
    (%9 (bitcast-double*-to-i32* %2))
    (%10 (getelementptr-i32 %9 1))
    (%11 (load-i32 %10 mem))
    (mem (store-i32 %11 %hx mem))
    (%12 (bitcast-double*-to-i32* %2))
    (%13 (load-i32 %12 mem))
    (mem (store-i32 %13 %lx mem))
    (%14 (bitcast-double*-to-i32* %3))
    (%15 (getelementptr-i32 %14 1))
    (%16 (load-i32 %15 mem))
    (mem (store-i32 %16 %hy mem))
    (%17 (bitcast-double*-to-i32* %3))
    (%18 (load-i32 %17 mem))
    (mem (store-i32 %18 %ly mem))
    (%19 (load-i32 %hx mem))
    (%20 (and-i32 %19 2147483647))
    (mem (store-i32 %20 %ix mem))
    (%21 (load-i32 %hy mem))
    (%22 (and-i32 %21 2147483647))
    (mem (store-i32 %22 %iy mem))
    (%23 (load-i32 %iy mem))
    (%24 (load-i32 %ly mem))
    (%25 (or-i32 %23 %24))
    (%26 (icmp-eq-i32 %25 0)))
  (case %26
    (-1  (@__ieee754_pow-%27 mem %1))
    (0 (@__ieee754_pow-%28 mem %ax %hx %hy %i %ix %iy %j %k %lx %ly %n %p_h %p_l %r %s %s2 %s_h %s_l %ss %t %t1 %t2 %t_h %t_l %u %v %w %y1 %yisint %z %z_h %z_l %1 %2 %3)))))

(defund @__ieee754_pow (%x %y)
  (@__ieee754_pow-%0 *__ieee754_pow-globals* %x %y))
