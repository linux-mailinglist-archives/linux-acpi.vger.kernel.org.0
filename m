Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF115BEC2A
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Sep 2022 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiITRmR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Sep 2022 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiITRmQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Sep 2022 13:42:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541D4DF33
        for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2022 10:42:15 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id u6-20020a056830118600b006595e8f9f3fso2262815otq.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2022 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=kF4vnyUz6OCd9gYihpLjPxozlF1dUIGHy284MJ5g6cA=;
        b=PtgRsWOMzuTIV83lWVzzSdORB4if6LDPSFAlWHXjE5zptFJ65aJUf+BAqPIJ98a1Sz
         cbwPVbnKU05K2bIg0hSWF6zLyzRfbXpdtUxFIRnAqMUSwR182LWlQOjKVCJirJ/9YvNK
         KUevJWQkemkIaXeaW+h99bLXxkJvl6hcNct2YK0R5zZrUUJjKO+y9u37wPieIDBRZHAJ
         0sbjeA5ZRcGIn/p4kCVo7v0LUsbYUytwXWnE1cuPSNqS+9xK5zuxjxUyDcXVdnyYl6KT
         eQoOBZteq0IRxCsgEbsxxFJnMqztFIOlIBvsdhJsXgwCfd1eN64zXeNlgqUu3GcBwnAc
         nYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kF4vnyUz6OCd9gYihpLjPxozlF1dUIGHy284MJ5g6cA=;
        b=sA3qLimljiuHvLyg1WVSrHOSpdawZCD0RkK/ksaVJd9LYnjqUZqVj1Mj7ssjH3fz7d
         gUFm7scjEKfGM5JVi6v3EjD6u8ByEV2nqp0ch8ihQidIPlSoYMO5zb8/gVWDT6Xmg6Mi
         a1JL7m046dQEpxIj3NLjVnosZNe22kVkav7OyqjIBcHlm0QRMQ95CLR0OsWcSM+a+B1Z
         S9qTHkMIXA31PqMghCrZrGsvG7897zRMf9QNveOj1lIAnXsEfzGaIQhVNBiSrYIFsWbl
         64A57inTdphZcdCGcfpl4QhrjRmq3aWQmPiVkC/W3gMttY1CG4DYIEOBS5jwDupk1NSF
         voDg==
X-Gm-Message-State: ACrzQf0JSpSlUSV9ysNF/X9qZcjG0RkRtOWa5Xpj+RopQ/8ytitJmA5O
        y+Go1Df9Oa0MFNkUYdcF9YAvnCW4rbocp72OxcLTu50g3uI=
X-Google-Smtp-Source: AMsMyM6pau/r/g7MT1xw9KwU8KWULxthB1QgxkEYIu8Wz7lagkbewpPhKm1sMomO4nyhW1/VoZ/tEyMcvFBCXqUtsTg=
X-Received: by 2002:a05:6830:90b:b0:659:4fe0:7ab6 with SMTP id
 v11-20020a056830090b00b006594fe07ab6mr10502138ott.385.1663695734899; Tue, 20
 Sep 2022 10:42:14 -0700 (PDT)
MIME-Version: 1.0
Sender: guenimatoure@gmail.com
Received: by 2002:a8a:e08:0:b0:474:2f92:1c23 with HTTP; Tue, 20 Sep 2022
 10:42:14 -0700 (PDT)
From:   Miss marybeth <marybethmonson009@gmail.com>
Date:   Tue, 20 Sep 2022 17:42:14 +0000
X-Google-Sender-Auth: 4RYsvV8NdlVOYl6k_s3W2LNZZ6s
Message-ID: <CAK1f_T9phcmdEvg4DcEhDdodvZ9BStUYDcqDRdvE4rM2oZ0LFQ@mail.gmail.com>
Subject: RE:HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

You received my previous message? I contacted you before but the
message failed back, so i decided to write again. Please confirm if
you receive this so that i can proceed,

waiting  for your response.

Regards,
Miss marybeth
