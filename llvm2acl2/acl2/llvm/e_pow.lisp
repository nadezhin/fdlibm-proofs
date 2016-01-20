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

(defund @__ieee754_pow-%706 (mem)
  (b* (
    (%707 (load-double '(ret . 0) mem)))
  %707))

(defund @__ieee754_pow-%702 (mem)
  (b* (
    (%703 (load-double '(s . 0) mem))
    (%704 (load-double '(z . 0) mem))
    (%705 (fmul-double %703 %704))
    (mem (store-double %705 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%695 (mem)
  (b* (
    (%696 (load-i32 '(n . 0) mem))
    (%697 (shl-i32 %696 20))
    (%698 (bitcast-double*-to-i32* '(z . 0)))
    (%699 (getelementptr-i32 %698 1))
    (%700 (load-i32 %699 mem))
    (%701 (add-i32 %700 %697))
    (mem (store-i32 %701 %699 mem)))
  (@__ieee754_pow-%702 mem)))

(defund @__ieee754_pow-%691 (mem)
  (b* (
    (%692 (load-double '(z . 0) mem))
    (%693 (load-i32 '(n . 0) mem))
    (%694 (@scalbn %692 %693))
    (mem (store-double %694 '(z . 0) mem)))
  (@__ieee754_pow-%702 mem)))

(defund @__ieee754_pow-%622 (mem)
  (b* (
    (%623 (load-double '(p_l . 0) mem))
    (%624 (load-double '(p_h . 0) mem))
    (%625 (fadd-double %623 %624))
    (mem (store-double %625 '(t . 0) mem))
    (%626 (bitcast-double*-to-i32* '(t . 0)))
    (mem (store-i32 0 %626 mem))
    (%627 (load-double '(t . 0) mem))
    (%628 (fmul-double %627 #x3FE62E4300000000))
    (mem (store-double %628 '(u . 0) mem))
    (%629 (load-double '(p_l . 0) mem))
    (%630 (load-double '(t . 0) mem))
    (%631 (load-double '(p_h . 0) mem))
    (%632 (fsub-double %630 %631))
    (%633 (fsub-double %629 %632))
    (%634 (fmul-double %633 #x3FE62E42FEFA39EF))
    (%635 (load-double '(t . 0) mem))
    (%636 (fmul-double %635 #xBE205C610CA86C39))
    (%637 (fadd-double %634 %636))
    (mem (store-double %637 '(v . 0) mem))
    (%638 (load-double '(u . 0) mem))
    (%639 (load-double '(v . 0) mem))
    (%640 (fadd-double %638 %639))
    (mem (store-double %640 '(z . 0) mem))
    (%641 (load-double '(v . 0) mem))
    (%642 (load-double '(z . 0) mem))
    (%643 (load-double '(u . 0) mem))
    (%644 (fsub-double %642 %643))
    (%645 (fsub-double %641 %644))
    (mem (store-double %645 '(w . 0) mem))
    (%646 (load-double '(z . 0) mem))
    (%647 (load-double '(z . 0) mem))
    (%648 (fmul-double %646 %647))
    (mem (store-double %648 '(t . 0) mem))
    (%649 (load-double '(z . 0) mem))
    (%650 (load-double '(t . 0) mem))
    (%651 (load-double '(t . 0) mem))
    (%652 (load-double '(t . 0) mem))
    (%653 (load-double '(t . 0) mem))
    (%654 (load-double '(t . 0) mem))
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
    (mem (store-double %664 '(t1 . 0) mem))
    (%665 (load-double '(z . 0) mem))
    (%666 (load-double '(t1 . 0) mem))
    (%667 (fmul-double %665 %666))
    (%668 (load-double '(t1 . 0) mem))
    (%669 (fsub-double %668 #x4000000000000000))
    (%670 (fdiv-double %667 %669))
    (%671 (load-double '(w . 0) mem))
    (%672 (load-double '(z . 0) mem))
    (%673 (load-double '(w . 0) mem))
    (%674 (fmul-double %672 %673))
    (%675 (fadd-double %671 %674))
    (%676 (fsub-double %670 %675))
    (mem (store-double %676 '(r . 0) mem))
    (%677 (load-double '(r . 0) mem))
    (%678 (load-double '(z . 0) mem))
    (%679 (fsub-double %677 %678))
    (%680 (fsub-double #x3ff0000000000000 %679))
    (mem (store-double %680 '(z . 0) mem))
    (%681 (bitcast-double*-to-i32* '(z . 0)))
    (%682 (getelementptr-i32 %681 1))
    (%683 (load-i32 %682 mem))
    (mem (store-i32 %683 '(j . 0) mem))
    (%684 (load-i32 '(n . 0) mem))
    (%685 (shl-i32 %684 20))
    (%686 (load-i32 '(j . 0) mem))
    (%687 (add-i32 %686 %685))
    (mem (store-i32 %687 '(j . 0) mem))
    (%688 (load-i32 '(j . 0) mem))
    (%689 (ashr-i32 %688 20))
    (%690 (icmp-sle-i32 %689 0)))
  (case %690
    (-1 (@__ieee754_pow-%691 mem))
    (0 (@__ieee754_pow-%695 mem)))))

(defund @__ieee754_pow-%618 (mem)
  (b* (
    (%619 (load-double '(t . 0) mem))
    (%620 (load-double '(p_h . 0) mem))
    (%621 (fsub-double %620 %619))
    (mem (store-double %621 '(p_h . 0) mem)))
  (@__ieee754_pow-%622 mem)))

(defund @__ieee754_pow-%615 (mem)
  (b* (
    (%616 (load-i32 '(n . 0) mem))
    (%617 (sub-i32 0 %616))
    (mem (store-i32 %617 '(n . 0) mem)))
  (@__ieee754_pow-%618 mem)))

(defund @__ieee754_pow-%590 (mem)
  (b* (
    (%591 (load-i32 '(j . 0) mem))
    (%592 (load-i32 '(k . 0) mem))
    (%593 (add-i32 %592 1))
    (%594 (ashr-i32 1048576 %593))
    (%595 (add-i32 %591 %594))
    (mem (store-i32 %595 '(n . 0) mem))
    (%596 (load-i32 '(n . 0) mem))
    (%597 (and-i32 %596 2147483647))
    (%598 (ashr-i32 %597 20))
    (%599 (sub-i32 %598 1023))
    (mem (store-i32 %599 '(k . 0) mem))
    (mem (store-double #x0000000000000000 '(t . 0) mem))
    (%600 (load-i32 '(n . 0) mem))
    (%601 (load-i32 '(k . 0) mem))
    (%602 (ashr-i32 1048575 %601))
    (%603 (xor-i32 %602 -1))
    (%604 (and-i32 %600 %603))
    (%605 (bitcast-double*-to-i32* '(t . 0)))
    (%606 (getelementptr-i32 %605 1))
    (mem (store-i32 %604 %606 mem))
    (%607 (load-i32 '(n . 0) mem))
    (%608 (and-i32 %607 1048575))
    (%609 (or-i32 %608 1048576))
    (%610 (load-i32 '(k . 0) mem))
    (%611 (sub-i32 20 %610))
    (%612 (ashr-i32 %609 %611))
    (mem (store-i32 %612 '(n . 0) mem))
    (%613 (load-i32 '(j . 0) mem))
    (%614 (icmp-slt-i32 %613 0)))
  (case %614
    (-1 (@__ieee754_pow-%615 mem))
    (0 (@__ieee754_pow-%618 mem)))))

(defund @__ieee754_pow-%582 (mem)
  (b* (
    (%583 (load-i32 '(j . 0) mem))
    (%584 (and-i32 %583 2147483647))
    (mem (store-i32 %584 '(i . 0) mem))
    (%585 (load-i32 '(i . 0) mem))
    (%586 (ashr-i32 %585 20))
    (%587 (sub-i32 %586 1023))
    (mem (store-i32 %587 '(k . 0) mem))
    (mem (store-i32 0 '(n . 0) mem))
    (%588 (load-i32 '(i . 0) mem))
    (%589 (icmp-sgt-i32 %588 1071644672)))
  (case %589
    (-1 (@__ieee754_pow-%590 mem))
    (0 (@__ieee754_pow-%622 mem)))))

(defund @__ieee754_pow-%581 (mem)
  (b* ()
  (@__ieee754_pow-%582 mem)))

(defund @__ieee754_pow-%580 (mem)
  (b* ()
  (@__ieee754_pow-%581 mem)))

(defund @__ieee754_pow-%579 (mem)
  (b* ()
  (@__ieee754_pow-%580 mem)))

(defund @__ieee754_pow-%575 (mem)
  (b* (
    (%576 (load-double '(s . 0) mem))
    (%577 (fmul-double %576 #x01a56e1fc2f8f359))
    (%578 (fmul-double %577 #x01a56e1fc2f8f359))
    (mem (store-double %578 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%569 (mem)
  (b* (
    (%570 (load-double '(p_l . 0) mem))
    (%571 (load-double '(z . 0) mem))
    (%572 (load-double '(p_h . 0) mem))
    (%573 (fsub-double %571 %572))
    (%574 (fcmp-ole-double %570 %573)))
  (case %574
    (-1 (@__ieee754_pow-%575 mem))
    (0 (@__ieee754_pow-%579 mem)))))

(defund @__ieee754_pow-%565 (mem)
  (b* (
    (%566 (load-double '(s . 0) mem))
    (%567 (fmul-double %566 #x01a56e1fc2f8f359))
    (%568 (fmul-double %567 #x01a56e1fc2f8f359))
    (mem (store-double %568 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%559 (mem)
  (b* (
    (%560 (load-i32 '(j . 0) mem))
    (%561 (sub-i32 %560 -1064252416))
    (%562 (load-i32 '(i . 0) mem))
    (%563 (or-i32 %561 %562))
    (%564 (icmp-ne-i32 %563 0)))
  (case %564
    (-1 (@__ieee754_pow-%565 mem))
    (0 (@__ieee754_pow-%569 mem)))))

(defund @__ieee754_pow-%555 (mem)
  (b* (
    (%556 (load-i32 '(j . 0) mem))
    (%557 (and-i32 %556 2147483647))
    (%558 (icmp-sge-i32 %557 1083231232)))
  (case %558
    (-1 (@__ieee754_pow-%559 mem))
    (0 (@__ieee754_pow-%581 mem)))))

(defund @__ieee754_pow-%554 (mem)
  (b* ()
  (@__ieee754_pow-%582 mem)))

(defund @__ieee754_pow-%553 (mem)
  (b* ()
  (@__ieee754_pow-%554 mem)))

(defund @__ieee754_pow-%549 (mem)
  (b* (
    (%550 (load-double '(s . 0) mem))
    (%551 (fmul-double %550 #x7e37e43c8800759c))
    (%552 (fmul-double %551 #x7e37e43c8800759c))
    (mem (store-double %552 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%542 (mem)
  (b* (
    (%543 (load-double '(p_l . 0) mem))
    (%544 (fadd-double %543 #x3C971547652B82FE))
    (%545 (load-double '(z . 0) mem))
    (%546 (load-double '(p_h . 0) mem))
    (%547 (fsub-double %545 %546))
    (%548 (fcmp-ogt-double %544 %547)))
  (case %548
    (-1 (@__ieee754_pow-%549 mem))
    (0 (@__ieee754_pow-%553 mem)))))

(defund @__ieee754_pow-%538 (mem)
  (b* (
    (%539 (load-double '(s . 0) mem))
    (%540 (fmul-double %539 #x7e37e43c8800759c))
    (%541 (fmul-double %540 #x7e37e43c8800759c))
    (mem (store-double %541 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%532 (mem)
  (b* (
    (%533 (load-i32 '(j . 0) mem))
    (%534 (sub-i32 %533 1083179008))
    (%535 (load-i32 '(i . 0) mem))
    (%536 (or-i32 %534 %535))
    (%537 (icmp-ne-i32 %536 0)))
  (case %537
    (-1 (@__ieee754_pow-%538 mem))
    (0 (@__ieee754_pow-%542 mem)))))

(defund @__ieee754_pow-%507 (mem)
  (b* (
    (%508 (load-double '(y . 0) mem))
    (mem (store-double %508 '(y1 . 0) mem))
    (%509 (bitcast-double*-to-i32* '(y1 . 0)))
    (mem (store-i32 0 %509 mem))
    (%510 (load-double '(y . 0) mem))
    (%511 (load-double '(y1 . 0) mem))
    (%512 (fsub-double %510 %511))
    (%513 (load-double '(t1 . 0) mem))
    (%514 (fmul-double %512 %513))
    (%515 (load-double '(y . 0) mem))
    (%516 (load-double '(t2 . 0) mem))
    (%517 (fmul-double %515 %516))
    (%518 (fadd-double %514 %517))
    (mem (store-double %518 '(p_l . 0) mem))
    (%519 (load-double '(y1 . 0) mem))
    (%520 (load-double '(t1 . 0) mem))
    (%521 (fmul-double %519 %520))
    (mem (store-double %521 '(p_h . 0) mem))
    (%522 (load-double '(p_l . 0) mem))
    (%523 (load-double '(p_h . 0) mem))
    (%524 (fadd-double %522 %523))
    (mem (store-double %524 '(z . 0) mem))
    (%525 (bitcast-double*-to-i32* '(z . 0)))
    (%526 (getelementptr-i32 %525 1))
    (%527 (load-i32 %526 mem))
    (mem (store-i32 %527 '(j . 0) mem))
    (%528 (bitcast-double*-to-i32* '(z . 0)))
    (%529 (load-i32 %528 mem))
    (mem (store-i32 %529 '(i . 0) mem))
    (%530 (load-i32 '(j . 0) mem))
    (%531 (icmp-sge-i32 %530 1083179008)))
  (case %531
    (-1 (@__ieee754_pow-%532 mem))
    (0 (@__ieee754_pow-%555 mem)))))

(defund @__ieee754_pow-%358 (mem)
  (b* (
    (%359 (load-i32 '(ix . 0) mem))
    (%360 (bitcast-double*-to-i32* '(ax . 0)))
    (%361 (getelementptr-i32 %360 1))
    (mem (store-i32 %359 %361 mem))
    (%362 (load-double '(ax . 0) mem))
    (%363 (load-i32 '(k . 0) mem))
    (%364 (sext-i32-to-i64 %363))
    (%365 (getelementptr-double '(bp . 0) %364))
    (%366 (load-double %365 mem))
    (%367 (fsub-double %362 %366))
    (mem (store-double %367 '(u . 0) mem))
    (%368 (load-double '(ax . 0) mem))
    (%369 (load-i32 '(k . 0) mem))
    (%370 (sext-i32-to-i64 %369))
    (%371 (getelementptr-double '(bp . 0) %370))
    (%372 (load-double %371 mem))
    (%373 (fadd-double %368 %372))
    (%374 (fdiv-double #x3ff0000000000000 %373))
    (mem (store-double %374 '(v . 0) mem))
    (%375 (load-double '(u . 0) mem))
    (%376 (load-double '(v . 0) mem))
    (%377 (fmul-double %375 %376))
    (mem (store-double %377 '(ss . 0) mem))
    (%378 (load-double '(ss . 0) mem))
    (mem (store-double %378 '(s_h . 0) mem))
    (%379 (bitcast-double*-to-i32* '(s_h . 0)))
    (mem (store-i32 0 %379 mem))
    (mem (store-double #x0000000000000000 '(t_h . 0) mem))
    (%380 (load-i32 '(ix . 0) mem))
    (%381 (ashr-i32 %380 1))
    (%382 (or-i32 %381 536870912))
    (%383 (add-i32 %382 524288))
    (%384 (load-i32 '(k . 0) mem))
    (%385 (shl-i32 %384 18))
    (%386 (add-i32 %383 %385))
    (%387 (bitcast-double*-to-i32* '(t_h . 0)))
    (%388 (getelementptr-i32 %387 1))
    (mem (store-i32 %386 %388 mem))
    (%389 (load-double '(ax . 0) mem))
    (%390 (load-double '(t_h . 0) mem))
    (%391 (load-i32 '(k . 0) mem))
    (%392 (sext-i32-to-i64 %391))
    (%393 (getelementptr-double '(bp . 0) %392))
    (%394 (load-double %393 mem))
    (%395 (fsub-double %390 %394))
    (%396 (fsub-double %389 %395))
    (mem (store-double %396 '(t_l . 0) mem))
    (%397 (load-double '(v . 0) mem))
    (%398 (load-double '(u . 0) mem))
    (%399 (load-double '(s_h . 0) mem))
    (%400 (load-double '(t_h . 0) mem))
    (%401 (fmul-double %399 %400))
    (%402 (fsub-double %398 %401))
    (%403 (load-double '(s_h . 0) mem))
    (%404 (load-double '(t_l . 0) mem))
    (%405 (fmul-double %403 %404))
    (%406 (fsub-double %402 %405))
    (%407 (fmul-double %397 %406))
    (mem (store-double %407 '(s_l . 0) mem))
    (%408 (load-double '(ss . 0) mem))
    (%409 (load-double '(ss . 0) mem))
    (%410 (fmul-double %408 %409))
    (mem (store-double %410 '(s2 . 0) mem))
    (%411 (load-double '(s2 . 0) mem))
    (%412 (load-double '(s2 . 0) mem))
    (%413 (fmul-double %411 %412))
    (%414 (load-double '(s2 . 0) mem))
    (%415 (load-double '(s2 . 0) mem))
    (%416 (load-double '(s2 . 0) mem))
    (%417 (load-double '(s2 . 0) mem))
    (%418 (load-double '(s2 . 0) mem))
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
    (mem (store-double %429 '(r . 0) mem))
    (%430 (load-double '(s_l . 0) mem))
    (%431 (load-double '(s_h . 0) mem))
    (%432 (load-double '(ss . 0) mem))
    (%433 (fadd-double %431 %432))
    (%434 (fmul-double %430 %433))
    (%435 (load-double '(r . 0) mem))
    (%436 (fadd-double %435 %434))
    (mem (store-double %436 '(r . 0) mem))
    (%437 (load-double '(s_h . 0) mem))
    (%438 (load-double '(s_h . 0) mem))
    (%439 (fmul-double %437 %438))
    (mem (store-double %439 '(s2 . 0) mem))
    (%440 (load-double '(s2 . 0) mem))
    (%441 (fadd-double #x4008000000000000 %440))
    (%442 (load-double '(r . 0) mem))
    (%443 (fadd-double %441 %442))
    (mem (store-double %443 '(t_h . 0) mem))
    (%444 (bitcast-double*-to-i32* '(t_h . 0)))
    (mem (store-i32 0 %444 mem))
    (%445 (load-double '(r . 0) mem))
    (%446 (load-double '(t_h . 0) mem))
    (%447 (fsub-double %446 #x4008000000000000))
    (%448 (load-double '(s2 . 0) mem))
    (%449 (fsub-double %447 %448))
    (%450 (fsub-double %445 %449))
    (mem (store-double %450 '(t_l . 0) mem))
    (%451 (load-double '(s_h . 0) mem))
    (%452 (load-double '(t_h . 0) mem))
    (%453 (fmul-double %451 %452))
    (mem (store-double %453 '(u . 0) mem))
    (%454 (load-double '(s_l . 0) mem))
    (%455 (load-double '(t_h . 0) mem))
    (%456 (fmul-double %454 %455))
    (%457 (load-double '(t_l . 0) mem))
    (%458 (load-double '(ss . 0) mem))
    (%459 (fmul-double %457 %458))
    (%460 (fadd-double %456 %459))
    (mem (store-double %460 '(v . 0) mem))
    (%461 (load-double '(u . 0) mem))
    (%462 (load-double '(v . 0) mem))
    (%463 (fadd-double %461 %462))
    (mem (store-double %463 '(p_h . 0) mem))
    (%464 (bitcast-double*-to-i32* '(p_h . 0)))
    (mem (store-i32 0 %464 mem))
    (%465 (load-double '(v . 0) mem))
    (%466 (load-double '(p_h . 0) mem))
    (%467 (load-double '(u . 0) mem))
    (%468 (fsub-double %466 %467))
    (%469 (fsub-double %465 %468))
    (mem (store-double %469 '(p_l . 0) mem))
    (%470 (load-double '(p_h . 0) mem))
    (%471 (fmul-double #x3FEEC709E0000000 %470))
    (mem (store-double %471 '(z_h . 0) mem))
    (%472 (load-double '(p_h . 0) mem))
    (%473 (fmul-double #xBE3E2FE0145B01F5 %472))
    (%474 (load-double '(p_l . 0) mem))
    (%475 (fmul-double %474 #x3FEEC709DC3A03FD))
    (%476 (fadd-double %473 %475))
    (%477 (load-i32 '(k . 0) mem))
    (%478 (sext-i32-to-i64 %477))
    (%479 (getelementptr-double '(dp_l . 0) %478))
    (%480 (load-double %479 mem))
    (%481 (fadd-double %476 %480))
    (mem (store-double %481 '(z_l . 0) mem))
    (%482 (load-i32 '(n . 0) mem))
    (%483 (sitofp-i32-to-double %482))
    (mem (store-double %483 '(t . 0) mem))
    (%484 (load-double '(z_h . 0) mem))
    (%485 (load-double '(z_l . 0) mem))
    (%486 (fadd-double %484 %485))
    (%487 (load-i32 '(k . 0) mem))
    (%488 (sext-i32-to-i64 %487))
    (%489 (getelementptr-double '(dp_h . 0) %488))
    (%490 (load-double %489 mem))
    (%491 (fadd-double %486 %490))
    (%492 (load-double '(t . 0) mem))
    (%493 (fadd-double %491 %492))
    (mem (store-double %493 '(t1 . 0) mem))
    (%494 (bitcast-double*-to-i32* '(t1 . 0)))
    (mem (store-i32 0 %494 mem))
    (%495 (load-double '(z_l . 0) mem))
    (%496 (load-double '(t1 . 0) mem))
    (%497 (load-double '(t . 0) mem))
    (%498 (fsub-double %496 %497))
    (%499 (load-i32 '(k . 0) mem))
    (%500 (sext-i32-to-i64 %499))
    (%501 (getelementptr-double '(dp_h . 0) %500))
    (%502 (load-double %501 mem))
    (%503 (fsub-double %498 %502))
    (%504 (load-double '(z_h . 0) mem))
    (%505 (fsub-double %503 %504))
    (%506 (fsub-double %495 %505))
    (mem (store-double %506 '(t2 . 0) mem)))
  (@__ieee754_pow-%507 mem)))

(defund @__ieee754_pow-%357 (mem)
  (b* ()
  (@__ieee754_pow-%358 mem)))

(defund @__ieee754_pow-%352 (mem)
  (b* (
    (mem (store-i32 0 '(k . 0) mem))
    (%353 (load-i32 '(n . 0) mem))
    (%354 (add-i32 %353 1))
    (mem (store-i32 %354 '(n . 0) mem))
    (%355 (load-i32 '(ix . 0) mem))
    (%356 (sub-i32 %355 1048576))
    (mem (store-i32 %356 '(ix . 0) mem)))
  (@__ieee754_pow-%357 mem)))

(defund @__ieee754_pow-%351 (mem)
  (b* (
    (mem (store-i32 1 '(k . 0) mem)))
  (@__ieee754_pow-%357 mem)))

(defund @__ieee754_pow-%348 (mem)
  (b* (
    (%349 (load-i32 '(j . 0) mem))
    (%350 (icmp-slt-i32 %349 767610)))
  (case %350
    (-1 (@__ieee754_pow-%351 mem))
    (0 (@__ieee754_pow-%352 mem)))))

(defund @__ieee754_pow-%347 (mem)
  (b* (
    (mem (store-i32 0 '(k . 0) mem)))
  (@__ieee754_pow-%358 mem)))

(defund @__ieee754_pow-%335 (mem)
  (b* (
    (%336 (load-i32 '(ix . 0) mem))
    (%337 (ashr-i32 %336 20))
    (%338 (sub-i32 %337 1023))
    (%339 (load-i32 '(n . 0) mem))
    (%340 (add-i32 %339 %338))
    (mem (store-i32 %340 '(n . 0) mem))
    (%341 (load-i32 '(ix . 0) mem))
    (%342 (and-i32 %341 1048575))
    (mem (store-i32 %342 '(j . 0) mem))
    (%343 (load-i32 '(j . 0) mem))
    (%344 (or-i32 %343 1072693248))
    (mem (store-i32 %344 '(ix . 0) mem))
    (%345 (load-i32 '(j . 0) mem))
    (%346 (icmp-sle-i32 %345 235662)))
  (case %346
    (-1 (@__ieee754_pow-%347 mem))
    (0 (@__ieee754_pow-%348 mem)))))

(defund @__ieee754_pow-%327 (mem)
  (b* (
    (%328 (load-double '(ax . 0) mem))
    (%329 (fmul-double %328 #x4340000000000000))
    (mem (store-double %329 '(ax . 0) mem))
    (%330 (load-i32 '(n . 0) mem))
    (%331 (sub-i32 %330 53))
    (mem (store-i32 %331 '(n . 0) mem))
    (%332 (bitcast-double*-to-i32* '(ax . 0)))
    (%333 (getelementptr-i32 %332 1))
    (%334 (load-i32 %333 mem))
    (mem (store-i32 %334 '(ix . 0) mem)))
  (@__ieee754_pow-%335 mem)))

(defund @__ieee754_pow-%324 (mem)
  (b* (
    (mem (store-i32 0 '(n . 0) mem))
    (%325 (load-i32 '(ix . 0) mem))
    (%326 (icmp-slt-i32 %325 1048576)))
  (case %326
    (-1 (@__ieee754_pow-%327 mem))
    (0 (@__ieee754_pow-%335 mem)))))

(defund @__ieee754_pow-%295 (mem)
  (b* (
    (%296 (load-double '(ax . 0) mem))
    (%297 (fsub-double %296 #x3ff0000000000000))
    (mem (store-double %297 '(t . 0) mem))
    (%298 (load-double '(t . 0) mem))
    (%299 (load-double '(t . 0) mem))
    (%300 (fmul-double %298 %299))
    (%301 (load-double '(t . 0) mem))
    (%302 (load-double '(t . 0) mem))
    (%303 (fmul-double %302 #x3fd0000000000000))
    (%304 (fsub-double #x3FD5555555555555 %303))
    (%305 (fmul-double %301 %304))
    (%306 (fsub-double #x3fe0000000000000 %305))
    (%307 (fmul-double %300 %306))
    (mem (store-double %307 '(w . 0) mem))
    (%308 (load-double '(t . 0) mem))
    (%309 (fmul-double #x3FF7154760000000 %308))
    (mem (store-double %309 '(u . 0) mem))
    (%310 (load-double '(t . 0) mem))
    (%311 (fmul-double %310 #x3E54AE0BF85DDF44))
    (%312 (load-double '(w . 0) mem))
    (%313 (fmul-double %312 #x3FF71547652B82FE))
    (%314 (fsub-double %311 %313))
    (mem (store-double %314 '(v . 0) mem))
    (%315 (load-double '(u . 0) mem))
    (%316 (load-double '(v . 0) mem))
    (%317 (fadd-double %315 %316))
    (mem (store-double %317 '(t1 . 0) mem))
    (%318 (bitcast-double*-to-i32* '(t1 . 0)))
    (mem (store-i32 0 %318 mem))
    (%319 (load-double '(v . 0) mem))
    (%320 (load-double '(t1 . 0) mem))
    (%321 (load-double '(u . 0) mem))
    (%322 (fsub-double %320 %321))
    (%323 (fsub-double %319 %322))
    (mem (store-double %323 '(t2 . 0) mem)))
  (@__ieee754_pow-%507 mem)))

(defund @__ieee754_pow-%293 (mem %294)
  (b* (
    ; %294 = phi double [ %288, %285 ], [ %292, %289 ]
    (mem (store-double %294 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%289 (mem)
  (b* (
    (%290 (load-double '(s . 0) mem))
    (%291 (fmul-double %290 #x01a56e1fc2f8f359))
    (%292 (fmul-double %291 #x01a56e1fc2f8f359)))
  (@__ieee754_pow-%293 mem %292)))

(defund @__ieee754_pow-%285 (mem)
  (b* (
    (%286 (load-double '(s . 0) mem))
    (%287 (fmul-double %286 #x7e37e43c8800759c))
    (%288 (fmul-double %287 #x7e37e43c8800759c)))
  (@__ieee754_pow-%293 mem %288)))

(defund @__ieee754_pow-%282 (mem)
  (b* (
    (%283 (load-i32 '(hy . 0) mem))
    (%284 (icmp-sgt-i32 %283 0)))
  (case %284
    (-1 (@__ieee754_pow-%285 mem))
    (0 (@__ieee754_pow-%289 mem)))))

(defund @__ieee754_pow-%279 (mem)
  (b* (
    (%280 (load-i32 '(ix . 0) mem))
    (%281 (icmp-sgt-i32 %280 1072693248)))
  (case %281
    (-1 (@__ieee754_pow-%282 mem))
    (0 (@__ieee754_pow-%295 mem)))))

(defund @__ieee754_pow-%277 (mem %278)
  (b* (
    ; %278 = phi double [ %272, %269 ], [ %276, %273 ]
    (mem (store-double %278 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%273 (mem)
  (b* (
    (%274 (load-double '(s . 0) mem))
    (%275 (fmul-double %274 #x01a56e1fc2f8f359))
    (%276 (fmul-double %275 #x01a56e1fc2f8f359)))
  (@__ieee754_pow-%277 mem %276)))

(defund @__ieee754_pow-%269 (mem)
  (b* (
    (%270 (load-double '(s . 0) mem))
    (%271 (fmul-double %270 #x7e37e43c8800759c))
    (%272 (fmul-double %271 #x7e37e43c8800759c)))
  (@__ieee754_pow-%277 mem %272)))

(defund @__ieee754_pow-%266 (mem)
  (b* (
    (%267 (load-i32 '(hy . 0) mem))
    (%268 (icmp-slt-i32 %267 0)))
  (case %268
    (-1 (@__ieee754_pow-%269 mem))
    (0 (@__ieee754_pow-%273 mem)))))

(defund @__ieee754_pow-%263 (mem)
  (b* (
    (%264 (load-i32 '(ix . 0) mem))
    (%265 (icmp-slt-i32 %264 1072693247)))
  (case %265
    (-1 (@__ieee754_pow-%266 mem))
    (0 (@__ieee754_pow-%279 mem)))))

(defund @__ieee754_pow-%262 (mem)
  (b* ()
  (@__ieee754_pow-%263 mem)))

(defund @__ieee754_pow-%258 (mem)
  (b* (
    (%259 (load-i32 '(hy . 0) mem))
    (%260 (icmp-sgt-i32 %259 0))
    (%261 (select-double %260 #x7FF0000000000000 #x0000000000000000))
    (mem (store-double %261 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%255 (mem)
  (b* (
    (%256 (load-i32 '(ix . 0) mem))
    (%257 (icmp-sge-i32 %256 1072693248)))
  (case %257
    (-1 (@__ieee754_pow-%258 mem))
    (0 (@__ieee754_pow-%262 mem)))))

(defund @__ieee754_pow-%251 (mem)
  (b* (
    (%252 (load-i32 '(hy . 0) mem))
    (%253 (icmp-slt-i32 %252 0))
    (%254 (select-double %253 #x7FF0000000000000 #x0000000000000000))
    (mem (store-double %254 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%248 (mem)
  (b* (
    (%249 (load-i32 '(ix . 0) mem))
    (%250 (icmp-sle-i32 %249 1072693247)))
  (case %250
    (-1 (@__ieee754_pow-%251 mem))
    (0 (@__ieee754_pow-%255 mem)))))

(defund @__ieee754_pow-%245 (mem)
  (b* (
    (%246 (load-i32 '(iy . 0) mem))
    (%247 (icmp-sgt-i32 %246 1139802112)))
  (case %247
    (-1 (@__ieee754_pow-%248 mem))
    (0 (@__ieee754_pow-%263 mem)))))

(defund @__ieee754_pow-%242 (mem)
  (b* (
    (%243 (load-i32 '(iy . 0) mem))
    (%244 (icmp-sgt-i32 %243 1105199104)))
  (case %244
    (-1 (@__ieee754_pow-%245 mem))
    (0 (@__ieee754_pow-%324 mem)))))

(defund @__ieee754_pow-%241 (mem)
  (b* (
    (mem (store-double #xbff0000000000000 '(s . 0) mem)))
  (@__ieee754_pow-%242 mem)))

(defund @__ieee754_pow-%235 (mem)
  (b* (
    (mem (store-double #x3ff0000000000000 '(s . 0) mem))
    (%236 (load-i32 '(n . 0) mem))
    (%237 (load-i32 '(yisint . 0) mem))
    (%238 (sub-i32 %237 1))
    (%239 (or-i32 %236 %238))
    (%240 (icmp-eq-i32 %239 0)))
  (case %240
    (-1 (@__ieee754_pow-%241 mem))
    (0 (@__ieee754_pow-%242 mem)))))

(defund @__ieee754_pow-%227 (mem)
  (b* (
    (%228 (load-double '(x . 0) mem))
    (%229 (load-double '(x . 0) mem))
    (%230 (fsub-double %228 %229))
    (%231 (load-double '(x . 0) mem))
    (%232 (load-double '(x . 0) mem))
    (%233 (fsub-double %231 %232))
    (%234 (fdiv-double %230 %233))
    (mem (store-double %234 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%219 (mem)
  (b* (
    (%220 (load-i32 '(hx . 0) mem))
    (%221 (ashr-i32 %220 31))
    (%222 (add-i32 %221 1))
    (mem (store-i32 %222 '(n . 0) mem))
    (%223 (load-i32 '(n . 0) mem))
    (%224 (load-i32 '(yisint . 0) mem))
    (%225 (or-i32 %223 %224))
    (%226 (icmp-eq-i32 %225 0)))
  (case %226
    (-1 (@__ieee754_pow-%227 mem))
    (0 (@__ieee754_pow-%235 mem)))))

(defund @__ieee754_pow-%218 (mem)
  (b* ()
  (@__ieee754_pow-%219 mem)))

(defund @__ieee754_pow-%216 (mem)
  (b* (
    (%217 (load-double '(z . 0) mem))
    (mem (store-double %217 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%215 (mem)
  (b* ()
  (@__ieee754_pow-%216 mem)))

(defund @__ieee754_pow-%214 (mem)
  (b* ()
  (@__ieee754_pow-%215 mem)))

(defund @__ieee754_pow-%211 (mem)
  (b* (
    (%212 (load-double '(z . 0) mem))
    (%213 (fsub-double #x8000000000000000 %212))
    (mem (store-double %213 '(z . 0) mem)))
  (@__ieee754_pow-%214 mem)))

(defund @__ieee754_pow-%208 (mem)
  (b* (
    (%209 (load-i32 '(yisint . 0) mem))
    (%210 (icmp-eq-i32 %209 1)))
  (case %210
    (-1 (@__ieee754_pow-%211 mem))
    (0 (@__ieee754_pow-%214 mem)))))

(defund @__ieee754_pow-%200 (mem)
  (b* (
    (%201 (load-double '(z . 0) mem))
    (%202 (load-double '(z . 0) mem))
    (%203 (fsub-double %201 %202))
    (%204 (load-double '(z . 0) mem))
    (%205 (load-double '(z . 0) mem))
    (%206 (fsub-double %204 %205))
    (%207 (fdiv-double %203 %206))
    (mem (store-double %207 '(z . 0) mem)))
  (@__ieee754_pow-%215 mem)))

(defund @__ieee754_pow-%194 (mem)
  (b* (
    (%195 (load-i32 '(ix . 0) mem))
    (%196 (sub-i32 %195 1072693248))
    (%197 (load-i32 '(yisint . 0) mem))
    (%198 (or-i32 %196 %197))
    (%199 (icmp-eq-i32 %198 0)))
  (case %199
    (-1 (@__ieee754_pow-%200 mem))
    (0 (@__ieee754_pow-%208 mem)))))

(defund @__ieee754_pow-%191 (mem)
  (b* (
    (%192 (load-i32 '(hx . 0) mem))
    (%193 (icmp-slt-i32 %192 0)))
  (case %193
    (-1 (@__ieee754_pow-%194 mem))
    (0 (@__ieee754_pow-%216 mem)))))

(defund @__ieee754_pow-%188 (mem)
  (b* (
    (%189 (load-double '(z . 0) mem))
    (%190 (fdiv-double #x3ff0000000000000 %189))
    (mem (store-double %190 '(z . 0) mem)))
  (@__ieee754_pow-%191 mem)))

(defund @__ieee754_pow-%184 (mem)
  (b* (
    (%185 (load-double '(ax . 0) mem))
    (mem (store-double %185 '(z . 0) mem))
    (%186 (load-i32 '(hy . 0) mem))
    (%187 (icmp-slt-i32 %186 0)))
  (case %187
    (-1 (@__ieee754_pow-%188 mem))
    (0 (@__ieee754_pow-%191 mem)))))

(defund @__ieee754_pow-%181 (mem)
  (b* (
    (%182 (load-i32 '(ix . 0) mem))
    (%183 (icmp-eq-i32 %182 1072693248)))
  (case %183
    (-1 (@__ieee754_pow-%184 mem))
    (0 (@__ieee754_pow-%218 mem)))))

(defund @__ieee754_pow-%178 (mem)
  (b* (
    (%179 (load-i32 '(ix . 0) mem))
    (%180 (icmp-eq-i32 %179 0)))
  (case %180
    (-1 (@__ieee754_pow-%184 mem))
    (0 (@__ieee754_pow-%181 mem)))))

(defund @__ieee754_pow-%175 (mem)
  (b* (
    (%176 (load-i32 '(ix . 0) mem))
    (%177 (icmp-eq-i32 %176 2146435072)))
  (case %177
    (-1 (@__ieee754_pow-%184 mem))
    (0 (@__ieee754_pow-%178 mem)))))

(defund @__ieee754_pow-%170 (mem)
  (b* (
    (%171 (load-double '(x . 0) mem))
    (%172 (@fabs %171))
    (mem (store-double %172 '(ax . 0) mem))
    (%173 (load-i32 '(lx . 0) mem))
    (%174 (icmp-eq-i32 %173 0)))
  (case %174
    (-1 (@__ieee754_pow-%175 mem))
    (0 (@__ieee754_pow-%219 mem)))))

(defund @__ieee754_pow-%169 (mem)
  (b* ()
  (@__ieee754_pow-%170 mem)))

(defund @__ieee754_pow-%168 (mem)
  (b* ()
  (@__ieee754_pow-%169 mem)))

(defund @__ieee754_pow-%165 (mem)
  (b* (
    (%166 (load-double '(x . 0) mem))
    (%167 (@sqrt %166))
    (mem (store-double %167 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%162 (mem)
  (b* (
    (%163 (load-i32 '(hx . 0) mem))
    (%164 (icmp-sge-i32 %163 0)))
  (case %164
    (-1 (@__ieee754_pow-%165 mem))
    (0 (@__ieee754_pow-%168 mem)))))

(defund @__ieee754_pow-%159 (mem)
  (b* (
    (%160 (load-i32 '(hy . 0) mem))
    (%161 (icmp-eq-i32 %160 1071644672)))
  (case %161
    (-1 (@__ieee754_pow-%162 mem))
    (0 (@__ieee754_pow-%169 mem)))))

(defund @__ieee754_pow-%155 (mem)
  (b* (
    (%156 (load-double '(x . 0) mem))
    (%157 (load-double '(x . 0) mem))
    (%158 (fmul-double %156 %157))
    (mem (store-double %158 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%152 (mem)
  (b* (
    (%153 (load-i32 '(hy . 0) mem))
    (%154 (icmp-eq-i32 %153 1073741824)))
  (case %154
    (-1 (@__ieee754_pow-%155 mem))
    (0 (@__ieee754_pow-%159 mem)))))

(defund @__ieee754_pow-%150 (mem)
  (b* (
    (%151 (load-double '(x . 0) mem))
    (mem (store-double %151 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%147 (mem)
  (b* (
    (%148 (load-double '(x . 0) mem))
    (%149 (fdiv-double #x3ff0000000000000 %148))
    (mem (store-double %149 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%144 (mem)
  (b* (
    (%145 (load-i32 '(hy . 0) mem))
    (%146 (icmp-slt-i32 %145 0)))
  (case %146
    (-1 (@__ieee754_pow-%147 mem))
    (0 (@__ieee754_pow-%150 mem)))))

(defund @__ieee754_pow-%141 (mem)
  (b* (
    (%142 (load-i32 '(iy . 0) mem))
    (%143 (icmp-eq-i32 %142 1072693248)))
  (case %143
    (-1 (@__ieee754_pow-%144 mem))
    (0 (@__ieee754_pow-%152 mem)))))

(defund @__ieee754_pow-%139 (mem %140)
  (b* (
    ; %140 = phi double [ %137, %135 ], [ #x0000000000000000, %138 ]
    (mem (store-double %140 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%138 (mem)
  (b* ()
  (@__ieee754_pow-%139 mem #x0000000000000000)))

(defund @__ieee754_pow-%135 (mem)
  (b* (
    (%136 (load-double '(y . 0) mem))
    (%137 (fsub-double #x8000000000000000 %136)))
  (@__ieee754_pow-%139 mem %137)))

(defund @__ieee754_pow-%132 (mem)
  (b* (
    (%133 (load-i32 '(hy . 0) mem))
    (%134 (icmp-slt-i32 %133 0)))
  (case %134
    (-1 (@__ieee754_pow-%135 mem))
    (0 (@__ieee754_pow-%138 mem)))))

(defund @__ieee754_pow-%130 (mem %131)
  (b* (
    ; %131 = phi double [ %128, %127 ], [ #x0000000000000000, %129 ]
    (mem (store-double %131 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%129 (mem)
  (b* ()
  (@__ieee754_pow-%130 mem #x0000000000000000)))

(defund @__ieee754_pow-%127 (mem)
  (b* (
    (%128 (load-double '(y . 0) mem)))
  (@__ieee754_pow-%130 mem %128)))

(defund @__ieee754_pow-%124 (mem)
  (b* (
    (%125 (load-i32 '(hy . 0) mem))
    (%126 (icmp-sge-i32 %125 0)))
  (case %126
    (-1 (@__ieee754_pow-%127 mem))
    (0 (@__ieee754_pow-%129 mem)))))

(defund @__ieee754_pow-%121 (mem)
  (b* (
    (%122 (load-i32 '(ix . 0) mem))
    (%123 (icmp-sge-i32 %122 1072693248)))
  (case %123
    (-1 (@__ieee754_pow-%124 mem))
    (0 (@__ieee754_pow-%132 mem)))))

(defund @__ieee754_pow-%117 (mem)
  (b* (
    (%118 (load-double '(y . 0) mem))
    (%119 (load-double '(y . 0) mem))
    (%120 (fsub-double %118 %119))
    (mem (store-double %120 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%111 (mem)
  (b* (
    (%112 (load-i32 '(ix . 0) mem))
    (%113 (sub-i32 %112 1072693248))
    (%114 (load-i32 '(lx . 0) mem))
    (%115 (or-i32 %113 %114))
    (%116 (icmp-eq-i32 %115 0)))
  (case %116
    (-1 (@__ieee754_pow-%117 mem))
    (0 (@__ieee754_pow-%121 mem)))))

(defund @__ieee754_pow-%108 (mem)
  (b* (
    (%109 (load-i32 '(iy . 0) mem))
    (%110 (icmp-eq-i32 %109 2146435072)))
  (case %110
    (-1 (@__ieee754_pow-%111 mem))
    (0 (@__ieee754_pow-%141 mem)))))

(defund @__ieee754_pow-%105 (mem)
  (b* (
    (%106 (load-i32 '(ly . 0) mem))
    (%107 (icmp-eq-i32 %106 0)))
  (case %107
    (-1 (@__ieee754_pow-%108 mem))
    (0 (@__ieee754_pow-%170 mem)))))

(defund @__ieee754_pow-%104 (mem)
  (b* ()
  (@__ieee754_pow-%105 mem)))

(defund @__ieee754_pow-%103 (mem)
  (b* ()
  (@__ieee754_pow-%104 mem)))

(defund @__ieee754_pow-%102 (mem)
  (b* ()
  (@__ieee754_pow-%103 mem)))

(defund @__ieee754_pow-%101 (mem)
  (b* ()
  (@__ieee754_pow-%102 mem)))

(defund @__ieee754_pow-%100 (mem)
  (b* ()
  (@__ieee754_pow-%101 mem)))

(defund @__ieee754_pow-%96 (mem)
  (b* (
    (%97 (load-i32 '(j . 0) mem))
    (%98 (and-i32 %97 1))
    (%99 (sub-i32 2 %98))
    (mem (store-i32 %99 '(yisint . 0) mem)))
  (@__ieee754_pow-%100 mem)))

(defund @__ieee754_pow-%85 (mem)
  (b* (
    (%86 (load-i32 '(iy . 0) mem))
    (%87 (load-i32 '(k . 0) mem))
    (%88 (sub-i32 20 %87))
    (%89 (ashr-i32 %86 %88))
    (mem (store-i32 %89 '(j . 0) mem))
    (%90 (load-i32 '(j . 0) mem))
    (%91 (load-i32 '(k . 0) mem))
    (%92 (sub-i32 20 %91))
    (%93 (shl-i32 %90 %92))
    (%94 (load-i32 '(iy . 0) mem))
    (%95 (icmp-eq-i32 %93 %94)))
  (case %95
    (-1 (@__ieee754_pow-%96 mem))
    (0 (@__ieee754_pow-%100 mem)))))

(defund @__ieee754_pow-%82 (mem)
  (b* (
    (%83 (load-i32 '(ly . 0) mem))
    (%84 (icmp-eq-i32 %83 0)))
  (case %84
    (-1 (@__ieee754_pow-%85 mem))
    (0 (@__ieee754_pow-%101 mem)))))

(defund @__ieee754_pow-%81 (mem)
  (b* ()
  (@__ieee754_pow-%102 mem)))

(defund @__ieee754_pow-%77 (mem)
  (b* (
    (%78 (load-i32 '(j . 0) mem))
    (%79 (and-i32 %78 1))
    (%80 (sub-i32 2 %79))
    (mem (store-i32 %80 '(yisint . 0) mem)))
  (@__ieee754_pow-%81 mem)))

(defund @__ieee754_pow-%66 (mem)
  (b* (
    (%67 (load-i32 '(ly . 0) mem))
    (%68 (load-i32 '(k . 0) mem))
    (%69 (sub-i32 52 %68))
    (%70 (lshr-i32 %67 %69))
    (mem (store-i32 %70 '(j . 0) mem))
    (%71 (load-i32 '(j . 0) mem))
    (%72 (load-i32 '(k . 0) mem))
    (%73 (sub-i32 52 %72))
    (%74 (shl-i32 %71 %73))
    (%75 (load-i32 '(ly . 0) mem))
    (%76 (icmp-eq-i32 %74 %75)))
  (case %76
    (-1 (@__ieee754_pow-%77 mem))
    (0 (@__ieee754_pow-%81 mem)))))

(defund @__ieee754_pow-%60 (mem)
  (b* (
    (%61 (load-i32 '(iy . 0) mem))
    (%62 (ashr-i32 %61 20))
    (%63 (sub-i32 %62 1023))
    (mem (store-i32 %63 '(k . 0) mem))
    (%64 (load-i32 '(k . 0) mem))
    (%65 (icmp-sgt-i32 %64 20)))
  (case %65
    (-1 (@__ieee754_pow-%66 mem))
    (0 (@__ieee754_pow-%82 mem)))))

(defund @__ieee754_pow-%57 (mem)
  (b* (
    (%58 (load-i32 '(iy . 0) mem))
    (%59 (icmp-sge-i32 %58 1072693248)))
  (case %59
    (-1 (@__ieee754_pow-%60 mem))
    (0 (@__ieee754_pow-%103 mem)))))

(defund @__ieee754_pow-%56 (mem)
  (b* (
    (mem (store-i32 2 '(yisint . 0) mem)))
  (@__ieee754_pow-%104 mem)))

(defund @__ieee754_pow-%53 (mem)
  (b* (
    (%54 (load-i32 '(iy . 0) mem))
    (%55 (icmp-sge-i32 %54 1128267776)))
  (case %55
    (-1 (@__ieee754_pow-%56 mem))
    (0 (@__ieee754_pow-%57 mem)))))

(defund @__ieee754_pow-%50 (mem)
  (b* (
    (mem (store-i32 0 '(yisint . 0) mem))
    (%51 (load-i32 '(hx . 0) mem))
    (%52 (icmp-slt-i32 %51 0)))
  (case %52
    (-1 (@__ieee754_pow-%53 mem))
    (0 (@__ieee754_pow-%105 mem)))))

(defund @__ieee754_pow-%46 (mem)
  (b* (
    (%47 (load-double '(x . 0) mem))
    (%48 (load-double '(y . 0) mem))
    (%49 (fadd-double %47 %48))
    (mem (store-double %49 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%43 (mem)
  (b* (
    (%44 (load-i32 '(ly . 0) mem))
    (%45 (icmp-ne-i32 %44 0)))
  (case %45
    (-1 (@__ieee754_pow-%46 mem))
    (0 (@__ieee754_pow-%50 mem)))))

(defund @__ieee754_pow-%40 (mem)
  (b* (
    (%41 (load-i32 '(iy . 0) mem))
    (%42 (icmp-eq-i32 %41 2146435072)))
  (case %42
    (-1 (@__ieee754_pow-%43 mem))
    (0 (@__ieee754_pow-%50 mem)))))

(defund @__ieee754_pow-%37 (mem)
  (b* (
    (%38 (load-i32 '(iy . 0) mem))
    (%39 (icmp-sgt-i32 %38 2146435072)))
  (case %39
    (-1 (@__ieee754_pow-%46 mem))
    (0 (@__ieee754_pow-%40 mem)))))

(defund @__ieee754_pow-%34 (mem)
  (b* (
    (%35 (load-i32 '(lx . 0) mem))
    (%36 (icmp-ne-i32 %35 0)))
  (case %36
    (-1 (@__ieee754_pow-%46 mem))
    (0 (@__ieee754_pow-%37 mem)))))

(defund @__ieee754_pow-%31 (mem)
  (b* (
    (%32 (load-i32 '(ix . 0) mem))
    (%33 (icmp-eq-i32 %32 2146435072)))
  (case %33
    (-1 (@__ieee754_pow-%34 mem))
    (0 (@__ieee754_pow-%37 mem)))))

(defund @__ieee754_pow-%28 (mem)
  (b* (
    (%29 (load-i32 '(ix . 0) mem))
    (%30 (icmp-sgt-i32 %29 2146435072)))
  (case %30
    (-1 (@__ieee754_pow-%46 mem))
    (0 (@__ieee754_pow-%31 mem)))))

(defund @__ieee754_pow-%27 (mem)
  (b* (
    (mem (store-double #x3ff0000000000000 '(ret . 0) mem)))
  (@__ieee754_pow-%706 mem)))

(defund @__ieee754_pow-%0 (mem %x %y)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-double 'y 1 mem))
    (mem (alloca-double 'z 1 mem))
    (mem (alloca-double 'ax 1 mem))
    (mem (alloca-double 'z_h 1 mem))
    (mem (alloca-double 'z_l 1 mem))
    (mem (alloca-double 'p_h 1 mem))
    (mem (alloca-double 'p_l 1 mem))
    (mem (alloca-double 'y1 1 mem))
    (mem (alloca-double 't1 1 mem))
    (mem (alloca-double 't2 1 mem))
    (mem (alloca-double 'r 1 mem))
    (mem (alloca-double 's 1 mem))
    (mem (alloca-double 't 1 mem))
    (mem (alloca-double 'u 1 mem))
    (mem (alloca-double 'v 1 mem))
    (mem (alloca-double 'w 1 mem))
    (mem (alloca-i32 'i0 1 mem))
    (mem (alloca-i32 'i1 1 mem))
    (mem (alloca-i32 'i 1 mem))
    (mem (alloca-i32 'j 1 mem))
    (mem (alloca-i32 'k 1 mem))
    (mem (alloca-i32 'yisint 1 mem))
    (mem (alloca-i32 'n 1 mem))
    (mem (alloca-i32 'hx 1 mem))
    (mem (alloca-i32 'hy 1 mem))
    (mem (alloca-i32 'ix 1 mem))
    (mem (alloca-i32 'iy 1 mem))
    (mem (alloca-i32 'lx 1 mem))
    (mem (alloca-i32 'ly 1 mem))
    (mem (alloca-double 'ss 1 mem))
    (mem (alloca-double 's2 1 mem))
    (mem (alloca-double 's_h 1 mem))
    (mem (alloca-double 's_l 1 mem))
    (mem (alloca-double 't_h 1 mem))
    (mem (alloca-double 't_l 1 mem))
    (mem (store-double %x '(x . 0) mem))
    (mem (store-double %y '(y . 0) mem))
    (%4 (load-i32 '(one . 0) mem))
    (%5 (ashr-i32 %4 29))
    (%6 (xor-i32 %5 1))
    (mem (store-i32 %6 '(i0 . 0) mem))
    (%7 (load-i32 '(i0 . 0) mem))
    (%8 (sub-i32 1 %7))
    (mem (store-i32 %8 '(i1 . 0) mem))
    (%9 (bitcast-double*-to-i32* '(x . 0)))
    (%10 (getelementptr-i32 %9 1))
    (%11 (load-i32 %10 mem))
    (mem (store-i32 %11 '(hx . 0) mem))
    (%12 (bitcast-double*-to-i32* '(x . 0)))
    (%13 (load-i32 %12 mem))
    (mem (store-i32 %13 '(lx . 0) mem))
    (%14 (bitcast-double*-to-i32* '(y . 0)))
    (%15 (getelementptr-i32 %14 1))
    (%16 (load-i32 %15 mem))
    (mem (store-i32 %16 '(hy . 0) mem))
    (%17 (bitcast-double*-to-i32* '(y . 0)))
    (%18 (load-i32 %17 mem))
    (mem (store-i32 %18 '(ly . 0) mem))
    (%19 (load-i32 '(hx . 0) mem))
    (%20 (and-i32 %19 2147483647))
    (mem (store-i32 %20 '(ix . 0) mem))
    (%21 (load-i32 '(hy . 0) mem))
    (%22 (and-i32 %21 2147483647))
    (mem (store-i32 %22 '(iy . 0) mem))
    (%23 (load-i32 '(iy . 0) mem))
    (%24 (load-i32 '(ly . 0) mem))
    (%25 (or-i32 %23 %24))
    (%26 (icmp-eq-i32 %25 0)))
  (case %26
    (-1 (@__ieee754_pow-%27 mem))
    (0 (@__ieee754_pow-%28 mem)))))

(defund @__ieee754_pow (%x %y)
  (@__ieee754_pow-%0 *__ieee754_pow-globals*  %x %y))
