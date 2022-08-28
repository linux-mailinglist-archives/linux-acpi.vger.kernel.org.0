Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012715A3C17
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Aug 2022 08:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiH1GKc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Aug 2022 02:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiH1GKb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Aug 2022 02:10:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5379924BD6
        for <linux-acpi@vger.kernel.org>; Sat, 27 Aug 2022 23:10:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s11so6579526edd.13
        for <linux-acpi@vger.kernel.org>; Sat, 27 Aug 2022 23:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=9ZY+84P/V7ISkk7M9H7PFl6lUFVKmSowbYPOrl5Fc5w=;
        b=cIf/6fd0U+n/+Tn+xr+WInajz1aSxN8qSZ8NHDn9p4PGCMzSn3Yxho42vsWc40x2xE
         KomP+Hbw1WRBsElwb4W83DpONRio8JoHVNZiPU1YiC3c15QKbS/x0UELSPFGHrfSXl/i
         1WDK23YMwH8blKLnvI59Wmu2dugCYeHSAO02iThvVrADE9DFsDGYLeGejzujD1WlzJ1D
         FM4CPAsGZIFsDb1VUJFgHmiztxCUPVPcJLhP7WA60U8TWwrySwQgWEpXr/USYOc+MVTW
         V0Excm0fEfvZluM8Z/HHBCk4cydJxHQYWe1FkZ5jwKGJIavPeYzxGzEEoSaYibPggTFO
         MFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=9ZY+84P/V7ISkk7M9H7PFl6lUFVKmSowbYPOrl5Fc5w=;
        b=tkJ/+pHhG9+4eQ9PdJbhj0vtpCq3GP5LGNpsvd/bzSTWoiUZBh9YRRbefG01gw3acT
         E2n1IpH31C/5mZiRGbnHDlMfGDyU7Gifqy6FY4W5bllLJUOow4cFULoRt84CPMCNoTTw
         PUdzJ5cYWhHacfnvo502UlhJZythhdLALvD5VPLbxgHdM0YqGfyRo3nVPE7EIR1wJKAT
         EeNLm2Dc+NTtMXWSTA/ChtJ57NaJ60xV+9JEEaP/sx9QzXCpaa5vVnBnnNv+tJ8Z+Uyt
         +imwnLDqOf825ZA7lxUJmPoLBA9JQIAGeRF8AULPvVaEhcxKusMdcwuhbQCGFc9L/vjL
         GH+Q==
X-Gm-Message-State: ACgBeo2+ZCrx7NPJ9tb7qh1RIPE7HoY4vJfCjvIYjoIT+Oy+uaMT6mc8
        Xt2VOHuFmaGsmVNq9Oti0vtmkzf+dhb2gG9ngzI=
X-Google-Smtp-Source: AA6agR7XsY9qOgVH9MOpj3LBGIFGKrf2rwZvxH92QwDuNAhfcwvBtlRh67NCO1kbAaVxenrugWdXpv4/CRB/O7AUpJo=
X-Received: by 2002:a05:6402:1704:b0:447:811f:1eef with SMTP id
 y4-20020a056402170400b00447811f1eefmr12462200edu.14.1661667028765; Sat, 27
 Aug 2022 23:10:28 -0700 (PDT)
MIME-Version: 1.0
Reply-To: consulttdd@gmail.com
Sender: gloriaagoda94@gmail.com
Received: by 2002:a05:640c:2fc4:b0:17f:693a:f5ec with HTTP; Sat, 27 Aug 2022
 23:10:24 -0700 (PDT)
From:   CONSULT <iidafranciscob@gmail.com>
Date:   Sun, 28 Aug 2022 06:10:24 +0000
X-Google-Sender-Auth: IpKtGSt3Id_jdp0aSEjUwdDg9tA
Message-ID: <CAJY4oNpgJ=DYF6iKiEr_jt-B=p29cMwnQMhvmyWg1os1F7k0xw@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_REPLYTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:536 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_REPLYTO Reply-To username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [iidafranciscob[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gloriaagoda94[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Good Day,
How are you doing today? Please, I wrote to you earlier without
response from you. I have an important project that I would like to
discuss with you.
Regards
D. Toure
