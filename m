Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6359C37B
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Aug 2022 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiHVPwb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Aug 2022 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbiHVPwZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Aug 2022 11:52:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F012B1B9
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2022 08:52:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m3so10203583lfg.10
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2022 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=EDlMQzzVbGTvS/Xi3jfsxW5Vdl1DnbH6ryI6Z5fSkFQ=;
        b=DcYL9ChbZJvgoDvGqox7IUaq5n/JXKEYT3aAw1DyWPy7mTWy7ug+sdWOk7iciNacAt
         SL5LG0m6HE9jUimc2g39S1dP7doPub8Oygn5s7Unpt/MwLpxGhKN+wlSb6QFAypiu4Fp
         bggo5Z1XoMCAHEmYufWTh21Q0uJbd3+hez2UtCxKY8A3qyOOWTdLnGzzNnMPeBeGtG+G
         JjmOh10qlJT21VFzZNprOsGMNSAl8bpcuThXz9V4ePbV8bsvHL/wpJ8sZhRUelzfNRme
         uLlqFdVfM4UgKtuKvu90eFVFC6KB8SAiTQV/b0ZgFMsD1UgMx0RkimQA0NCufwkhgGS6
         1XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=EDlMQzzVbGTvS/Xi3jfsxW5Vdl1DnbH6ryI6Z5fSkFQ=;
        b=HLrkNdTL65uEHSrqOihoOE0iWtqqz4QI0vuPjQ5GEQc3cIml55VluzA0XN+L1Q6Aq6
         EL//yrjEFC2mKfAHKe59jqTJXlvSVZPDJklKtsshnkvxSLzjfnYnbBuKAKz4VG7yrLy4
         OHyw2PuLT1swE77KjAd16utdlTWHL6+9sSO89OZ9e40N5kWPiSuJwDPUqQB87mBTXgoX
         Ja5GdQU3fNzqRu0V+YCY/pcLFdnanmAqxnbt6nlgTeruuxFjinTGpLL/o/DPF2Jm6NbI
         kZVbVqfhfpVIcPEr6rX5DeNxHpM8QpkKgVa0PJhMrkzm+Zr/6xujKQ9nqIH+JQgtcXG9
         /SJQ==
X-Gm-Message-State: ACgBeo1ETuaDkikYXC0J7glbNi+YOvr/HdDLZcFtagMT2BJc21xRCn/M
        5zcjGOi+GQZ89M+305MZH4M5SL6B5FgWxPKH5VQ=
X-Google-Smtp-Source: AA6agR7VGKT5k3ZuWaNwQEI2m0SaQQe48PruzyrmZapwTkyeyLUUN+BIUlcaZl7p/eY8eYnKkH5n129Q1WGtxU3lnVw=
X-Received: by 2002:a05:6512:22cc:b0:48b:115d:968e with SMTP id
 g12-20020a05651222cc00b0048b115d968emr7883639lfu.357.1661183542696; Mon, 22
 Aug 2022 08:52:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:45cd:b0:204:fee3:9bf0 with HTTP; Mon, 22 Aug 2022
 08:52:21 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <abhishek9504931114@gmail.com>
Date:   Mon, 22 Aug 2022 15:52:21 +0000
Message-ID: <CAE44iJVGvBPyfHJuAZMHM-ZhbZq9+g9OPZstCmdYR_NF4kdCVw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abhishek9504931114[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylla202[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abhishek9504931114[at]gmail.com]
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

Bok draga, molim te jesi li primila moju prethodnu poruku, hvala.
