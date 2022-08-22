Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1622D59BC34
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Aug 2022 11:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiHVJCj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Aug 2022 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiHVJC3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Aug 2022 05:02:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770C42E9E7
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2022 02:02:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m15so2242368pjj.3
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2022 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=p9eXFPYaWoUQYd93GZHfKWGzwlV1gqge90LRrpP+sWM=;
        b=Gn33yOewWkI5C9V6G7ukU0PQo3eyHKxFNaomLXhM1GgS2Wik2x8kBs7GiCNhYnuVMJ
         l5zgxJUfXzHl9kdXNmbpWSeDvrFpCVDvg3COScbm8Fqb3KS6t8mbt83izyKXXMMW3DbM
         gcEcFFvc2957bcjT8HwZ4xA9QzEfXhEPE6YB5oYIAsfjBcBd6RhkZS5p04Vi3QJxKLPE
         9X7GWbLHAK5lbFcDiuw7Hj9py4n+lQyQ+7FA4VxApQfZFKjxFR46pJUH/1Atb+d3jJ9B
         Ww67XDXVBn2b6XUGUf7Ni7BEkuRUGjk+drOz0OCDuwpc87D0WK2cswe97CQjqyMgU0ZE
         I4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=p9eXFPYaWoUQYd93GZHfKWGzwlV1gqge90LRrpP+sWM=;
        b=phcYS8pl+dwO55DJUtyKgDDTtVI13QYQ8w5KxV3R/KTqCoPcglQ+n0gKRaG2tCavKf
         eFE7pwSa3Wg8S3+9VlxUTwpKqXutwvlf603Q8sz501D5XyXvbUDZabDND+TDy3y8/d7u
         QTiSYHXbJBnuYj+u4L6JqZuSLmNxfS/gUK3US3pZQpjUSSYp83FjTO2nd0gmgt1VJarT
         iiWLK+va7WA0ZeiXbN1k3wv6IWd9W+WEbgx7wGA9C6/qwBQGMNryHw1UfGKGBFOQz2Bg
         lQX/wDDYVoznVq71WVIuR2DbghfXFE8lP6FBs50IQqWC0WAwEmmwg+khFL9Sj45U9j07
         GKkg==
X-Gm-Message-State: ACgBeo3A5beRGF65kY0XdN8YP3OyKVqFTQawyuOKEEDpm8343kz24gFQ
        uB97TulblzMSQ9czPSezumbzKrU/IfnezEGhohE=
X-Google-Smtp-Source: AA6agR7Nk4UytFrFc7xwvZvfm0WFV7sfC/UlPNmKrYzJxGY+sY1csrisCXE88VhWTiCn5Ja3nYvfCDaFoaWeaN2/J4k=
X-Received: by 2002:a17:90b:1c90:b0:1f8:42dd:9eba with SMTP id
 oo16-20020a17090b1c9000b001f842dd9ebamr28431087pjb.160.1661158947919; Mon, 22
 Aug 2022 02:02:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:4185:b0:43:a6bb:bfcd with HTTP; Mon, 22 Aug 2022
 02:02:27 -0700 (PDT)
Reply-To: lindacliford05@yahoo.com
From:   linsa cliford <linda27cliford@gmail.com>
Date:   Mon, 22 Aug 2022 06:02:27 -0300
Message-ID: <CAKYqKb6jwG8jHH-Asi6D2uVinUujTbRgymBFNRbO4rDEzXgh5g@mail.gmail.com>
Subject: WITH DUE RESPECT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1031 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [linda27cliford[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lindacliford05[at]yahoo.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

  Drear Love One,

  Good day dear love one my name is miss Lnda Cliford  from cote
d'ivoire please i need your help for fund transfer of 2,500 000 us
dollars  if you  are
willing please get back to me  for  more information thanks and have a
good day,
Waiting to hear from you thanks,

your s Linda Clifford
Regards
