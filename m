Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C56620EB2
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Nov 2022 12:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiKHLV4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Nov 2022 06:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiKHLVr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Nov 2022 06:21:47 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D1D4B9BA
        for <linux-acpi@vger.kernel.org>; Tue,  8 Nov 2022 03:21:43 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-36a4b86a0abso130657587b3.7
        for <linux-acpi@vger.kernel.org>; Tue, 08 Nov 2022 03:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD/YBCtOhOa1ipEyheDVa6geA3XolzkSqDbroMLmTEw=;
        b=TH6ODfpzgWQOI6wK8En85vWReym/6MZKLaa27NkF6wKNmePYkJDD4IOjEcA55zYEoa
         HHB0a9gnxmJPipnjfbR/VTrTtbZP9JbC3khMivblt/XvUW8aBVIZyTmxKN/Qv0xNEpBV
         X05HHz+nqmiHXAfjfgiHxkx67gPkCb15hnBSl7YhnxRThqtJ0izawNEQRCBRgNr7/Vnw
         pgJhAFeW/Oo0lmTvp7FOO3mONf7oOkQPFxaPHBWSyR1yI88QGW2abJQWrY8AU74+txMd
         gKcxlEKpQy8Dh7cC+yRZRubj5o+X3LQDqSvIxldsnQinpZXNaqtta7vJkEyAVlZvCJO1
         TrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jD/YBCtOhOa1ipEyheDVa6geA3XolzkSqDbroMLmTEw=;
        b=51aQznBAZNRiNk1Mdt249w1MIZ4OeDARWmOvZJgRdithmVEMUgJL3HJTBfjZOi3dhN
         KDFR1LXx0vsMFXAXK6aOufPGjHvkK9E43TTIdrWHCtX4T65UBN6+3/7yETr2L66rtSUU
         zYJMt+yDOY4F+hzBtqz3k+KLuarMGgNGzN4GjpzMf3Iuh9Cr9gWPSp+FfW9OMNkh/luX
         t3Mg38J9yHx2DpX4l6kuddPRN6WRQBV/KsUCP7kZGwZAn+lNcpUNAD6wa1i7N++yTLXR
         dEJoYNFd3ymJ7BRjR6r9rPRC+iAznYOa0eV/YGyOeXuMyF8llavT7wC/eECubMx3SG+q
         K8nw==
X-Gm-Message-State: ACrzQf0w63caVQGsLgvgk0NGU5HFYnc8Z3y3v/aO/TnVAM4tJw+QYhuB
        I7AN/uGTru217xSITieMFvx0dWWYVhbajXlX4+s=
X-Google-Smtp-Source: AMsMyM73Po92pkBAuMw1lnuuxVsDEt6vWZsXPrYQ9yqzpQAFsXcQLr1QePow3gpIHUdrgggOwyqdpjF4eWyEAjgQlxQ=
X-Received: by 2002:a81:8644:0:b0:349:1126:97a4 with SMTP id
 w65-20020a818644000000b00349112697a4mr50326237ywf.333.1667906503158; Tue, 08
 Nov 2022 03:21:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a38a:b0:313:c983:1d7e with HTTP; Tue, 8 Nov 2022
 03:21:42 -0800 (PST)
Reply-To: mrinvest1010@gmail.com
From:   "K. A. Mr. Kairi" <ctocik2@gmail.com>
Date:   Tue, 8 Nov 2022 03:21:42 -0800
Message-ID: <CAC9COZcaXufcjypwUNRcwAEKjKwxfz16pebG_pB5BL8dL_E_kA@mail.gmail.com>
Subject: Re: My Response..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1130 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrinvest1010[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ctocik2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ctocik2[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

-- 
Hi

How are you with your family, I have a serious client, whom will be
interested to invest in your country, I got your Details through the
Investment Network and world Global Business directory.

If you are interested for more details.....

Sincerely,
Kairi Andrew
