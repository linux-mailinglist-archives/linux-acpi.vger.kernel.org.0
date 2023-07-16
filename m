Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE32754E5C
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jul 2023 12:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjGPK3Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Jul 2023 06:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGPK3Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Jul 2023 06:29:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C635E63
        for <linux-acpi@vger.kernel.org>; Sun, 16 Jul 2023 03:29:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55b1238a013so2764121a12.3
        for <linux-acpi@vger.kernel.org>; Sun, 16 Jul 2023 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689503363; x=1692095363;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jlL8pzL6NVZbuVjV4h5KPilkuQmPMJRpXcDIhZ2tX0=;
        b=sL1TE4H3NDaYE+X0UIji5X+/VWoRMk/VV++hg4EMXYyLrmyXsAsxFVQPmjZeYrkvqa
         8YxuU/Hus35IHaY/MtV++WQAEthA0ZRIxZ5Q6lL2DotLhSMXhBqr+Ltkh7n9dcRfVIp2
         /2zILheo+rl0LD5NJxnW8PCULhQoWSvkRW4T51DCh8rn3e31jm9qNnAD9JKZFOCovg+C
         100YBlGkuUtnrUPQkLQfGc49icG5eORmg0zxNg8e40iFXZKIEJw/FKA/vBqxBBa0TLyM
         PIXpoIEBaS61x/1ooEp+X+W/JFH8paN0UzmUl0AUJ50x2kQk9QG7/n6fvDgm1UTd2dt6
         SWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689503363; x=1692095363;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jlL8pzL6NVZbuVjV4h5KPilkuQmPMJRpXcDIhZ2tX0=;
        b=YRZ7YnARPAn4INobCfxHOlenX6tiRqHPF44iApVGIos5fNH0uX0forPqBqomfo21ML
         rTh56bwZRaVX9hXFsfpuW0+KhFW6lYr4Ho8Xd3xNZ1RqRqXyziZblWoo5COKzZMuMlTt
         BpGSzSIM1wpRIJastXwJhuXbzdWWqdm1kYJEG7nOWr27Lzxng4fVrT5GzwHAinlUHoaH
         oZVb4IgCWWhAKXxbd8fI1Vyw08r+WhoFLATAKNPRmuE6aR9HViQJzbIvl4SLwqALzJPB
         ZtFg4dzdLBpZRmquhh168gHOdSdMaVCIn9mVviRPTHPROig0PCd26Ns+6o5ifIF5Po4S
         mBAw==
X-Gm-Message-State: ABy/qLbSJ87UyhAm95YXzz6zZmwqILfAaIzYXCfpz1+rtdHoM3EQuXL+
        zlr/LSIQTTAgrPW+NaNcbCrzxovqiAP9lxoZMso=
X-Google-Smtp-Source: APBJJlHnoxUYiSnKUoxwkEABiRFC9WAp9K4lML6NgpVPFXci7VBhwQWg5oXqIwqfKgQm0OmQoB91HcAPVR/MTFojvjk=
X-Received: by 2002:a17:90a:1610:b0:263:161c:9e9a with SMTP id
 n16-20020a17090a161000b00263161c9e9amr8492539pja.6.1689503362930; Sun, 16 Jul
 2023 03:29:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:1342:b0:d5:5f44:1840 with HTTP; Sun, 16 Jul 2023
 03:29:22 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <ninacoulibaly213@gmail.com>
Date:   Sun, 16 Jul 2023 10:29:22 +0000
Message-ID: <CAL52byZzxFLzndWknAL7Jyv+YwRb0n7-787jGpfsg2h7rS8YCA@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you.I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
