Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7CD586AFE
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Aug 2022 14:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiHAMlO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Aug 2022 08:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiHAMko (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Aug 2022 08:40:44 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3FCA2BA4
        for <linux-acpi@vger.kernel.org>; Mon,  1 Aug 2022 05:19:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so8066870otb.5
        for <linux-acpi@vger.kernel.org>; Mon, 01 Aug 2022 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=kCSqCOP5NnmgqzMKAvoC+xj8lkHVueu0SPSEqGKA1Ew=;
        b=FkegYUqRhWxbobYiKeSFd34TCVGj4HNvEP5y4rLAv6hX9Xdb0Qx1VTw85BurwGbhni
         WK4bLJ6iBiZKpSws5trAmvj0CwcDhAPvOtCZRHAYzcuz1hPNDv0rGGYT6BAuHMIM07MS
         MR5aS+AAuwtH6upjK2QR6nQo2K8WAu9U9UqZXH7eIvB880kp/HOB2P+DKcG9gTH2jiYa
         IvQLTV0NuwcMYeahVmfPm59SdtZepPRUnbCKwwq+/FmBkqN/FmaXtZLUflM1Ym5FHNKj
         t9ejHwsKNkzOqzJYPW7tjCgJG5wNc/TuJTpOSN3YTqipWuH9AvlHpLFWweOsN1CldXJy
         K7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kCSqCOP5NnmgqzMKAvoC+xj8lkHVueu0SPSEqGKA1Ew=;
        b=46MNNoNegPqEQMiBRq2tfq1JWN6QwEj4ZHaIDx89MuXP4HLJ3B0XUVKGETp4Epi6qK
         TfQv74OoFzJbP1M98ER3g76KwnIjwqeaNQUuati4dZxiRfpSK2b29pBZbFIBgz8ggNMH
         gkTQ7FJe1lEHKAIPdSzjeD2hEIWNzUykvMVcNn8LaQIrHpMkqiqvG9V+F8J4G2gmAXZx
         JOumfrXSULmycur+Ue9uSweGtW/XRufV93kniIqejyZy1mEili19vEozysXu9PLdxXyP
         O54x6Khv6qQuHR0m1uesfk4YehwW+MiW0YpzfBL2zW8kLOj04n5mDaAZPHALYGcwEAHb
         rLAg==
X-Gm-Message-State: AJIora/FPYf1EAjYA9q2XRF7zXUoaP2As7DRhzaiw+Pmvj+X78ggtbIM
        PorcX6uY44L70mbZ1W/IDoOWtO+BZXsf5GsLs7U=
X-Google-Smtp-Source: AGRyM1vzrblXVEDdRw+ayC6/Fo2z75RwjZ64imPm1OmmdwN8mABr9FvuWlucHwv2ihOLLD8ih5vYTdHkLxHvrNJO7JA=
X-Received: by 2002:a05:6830:138b:b0:61c:c423:ca15 with SMTP id
 d11-20020a056830138b00b0061cc423ca15mr5850386otq.202.1659356370596; Mon, 01
 Aug 2022 05:19:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6850:e61c:b0:314:dc02:5b77 with HTTP; Mon, 1 Aug 2022
 05:19:30 -0700 (PDT)
Reply-To: lisarobinsongift02@gmail.com
From:   Lisa Robinson <masesedinah132@gmail.com>
Date:   Mon, 1 Aug 2022 15:19:30 +0300
Message-ID: <CAPaG1UT2vnFYP1zLPQWr6a4Fvz3mJeJ78_mRebnV+oiMksfMLQ@mail.gmail.com>
Subject: Donation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:32f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lisarobinsongift02[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [masesedinah132[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [masesedinah132[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=20
You were chosen by God to receive my Grant Donation of 1.200.000,00 =E2=82=
=AC
Please contact: Mrs Lisa Robinson via email:
lisarobinsongift02@gmail.com
Surname:
Country:
WhatsApp phone number:
