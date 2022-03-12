Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C574D70A9
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Mar 2022 21:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiCLUFE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Mar 2022 15:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiCLUFD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Mar 2022 15:05:03 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF914925D
        for <linux-acpi@vger.kernel.org>; Sat, 12 Mar 2022 12:03:57 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id u10so23425020ybd.9
        for <linux-acpi@vger.kernel.org>; Sat, 12 Mar 2022 12:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=ElKoPt64izj9FSG/0eE/NmsT2fBcrqCjzH/tZgH7SXeqBdYMAi/IvuZyXePP7Bwjzj
         EOFmv0h13Ia/uhSsz1IGQCe62l0TQuXOb7HQw4GssxN8tnbVyXupHiBmRYtCe9gL0uXl
         p5zSAjhW3bQtd0eJzTysvzdJlAqPoiEQABs+l13Gr9AHBlojt0jtJ/7DO7gaQvh4UoBo
         jzcMCdE67eDB4T1ZZtb4ROz7MafVnL+8v/kqIcM87B32upjp8QZqC4iKrpVD1PD+gr/B
         QmELstyUq+ueCTn/9B3X7ZKomb9c6+AL1cZ69coSamkqFu+L8jpjEIgIf/CK7juC+YBp
         5C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=tgawtAPTVjPffVAEPJRDlyaLUC3Kj977dv1Z/thhhSZjjv7icvaTYVlvIpkRNTxJ16
         YtwYE3FTZ70zQdwLFlODFFEusCeGgSK6vsNMiquDcxgM7fUvbGDLj1M+jOwBfHviPUrY
         orXuAX/cMFKEhODu8rAce2RoEQMbszKo03keEnyagwAwqxekK/tUGN8RjKPPKi4TgMJf
         CXdhufDbP2jifU4vqRgNZM5e6CS1kUHClYyefUSL3Qlgy0Gq50dnjpvJPTcgNBlWNgi1
         4mxRitTRI+lT3xv3fb8b6tjdugaBJ7XYWA2M5c25k/tiVdN2BPystoiKg1OPM3nepKQT
         LC+A==
X-Gm-Message-State: AOAM531Cvj+vKfYyC7D+aR217qAYTnHNUZTfFSdV4r/x2nXWDa0DGo4c
        BbJ9ZEDdehm6+RBXAMuU1hlK6WtsfiBMqB9LXkM=
X-Google-Smtp-Source: ABdhPJxUb1eIenpMFGZ4ZJT7YCpQjYQCjTf0T6fpp+19StyQ4qJ07TXUqgYKdtC1Mixr/W1WfHc2RvDlHtSmX+zb6IU=
X-Received: by 2002:a5b:9c2:0:b0:611:ad59:be04 with SMTP id
 y2-20020a5b09c2000000b00611ad59be04mr12452938ybq.405.1647115436363; Sat, 12
 Mar 2022 12:03:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7108:1cc:0:0:0:0 with HTTP; Sat, 12 Mar 2022 12:03:55
 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <doctortracywilliam@gmail.com>
Date:   Sat, 12 Mar 2022 12:03:55 -0800
Message-ID: <CAJiqmQHLGPWsQG2YkOzOHO1_wHb8JRyyj0B1bkmD36ktGMwnTw@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4124]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [avamedicinemed3[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [doctortracywilliam[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
