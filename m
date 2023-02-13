Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB869435A
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjBMKpT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 05:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjBMKpB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 05:45:01 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589D41026B;
        Mon, 13 Feb 2023 02:44:06 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id o66so7924852ybc.0;
        Mon, 13 Feb 2023 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=It2YJ0yINpc6a/dHkqF30FII/gMWp9sdCsyV4n7KWtc=;
        b=SpPVZ3M2CpscTYE+9oAxmsVo3pW3fYwLwKm6WdbVb/+7yJjdapk4Q1q5lI7T0FzSYl
         PRRJ0bnzLQ5cxN7XOpFAe3qUicnGHoTcCE5NmVqcZ52iDL2e6OwheTVBTPBk2HlO/s2/
         zoBk41RmCQbTQdIF+psUf7XwwVrWTcy9rST19ICAJV11wiUdw3tEAedfViSBzMIgslmq
         NQTGODcX5CunR0J0gAcOVc8AIcSk9uTj1RMuAb3E0859aVeURIXWba3vjIObcDkllhUr
         exRcrqEW9xynUcXSk2OMmoW9IXczT2z1qK7XpvtPrRUZu2SOsSzUvTJvy1sZ+hjk8LuP
         nqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=It2YJ0yINpc6a/dHkqF30FII/gMWp9sdCsyV4n7KWtc=;
        b=kahAU1bsz1O8U3RYnvs4fpfKitudTk4TPh9TGB0OR4ixmsyUsT5K2f6nx8wvlRs0yE
         HsjdZ+3eXrW8YRfLWGGaA1UO6vZnZGTmyrRXXFUjYysYcaTFaJo7UxLaMtPpKpC5vQ3R
         0NuiIStKrYz+ekoEyzRNGqcEw22OskRt/aufHMH831PDhOBk6W/5dUzQUofuuQabFm+z
         ztT/6AHEgXLIMEG9c5bWLw+XQlXIYKGEJFvgVBH6TIEuzuYgHNKNZcX1PBapCMadjX85
         Jc7m+Vz4kRvux3lA/v1ORDb6sc28kr+cAwlpg/runYjn2CJuRrLsdUaPT3duZ3bLIcTu
         R66A==
X-Gm-Message-State: AO0yUKWsY2t/l/atc6ZBCaK0VenZKB/8duicGVFoPVvO823yPp5X6Xo6
        OJyLm5Pl7NgCUpUE+5urR9g8lTN+Uh6sLwGlYtROJwoYlMWmnw==
X-Google-Smtp-Source: AK7set+dqgxglvqteU7oT+niFnqkk+BFacOtvdkeY+hJXXDI3ddIhwjlC3/5GLKgi3wEj7G9LZQ+qjeXBPz2Lx2rPks=
X-Received: by 2002:a25:8a83:0:b0:92d:7c28:5d06 with SMTP id
 h3-20020a258a83000000b0092d7c285d06mr163303ybl.372.1676285042350; Mon, 13 Feb
 2023 02:44:02 -0800 (PST)
MIME-Version: 1.0
From:   Carsten Hatger <xmb8dsv4@gmail.com>
Date:   Mon, 13 Feb 2023 11:43:51 +0100
Message-ID: <CACp=KFQN79Rz0CHP-5kwP9Y5Y9bEAoN0eJzoOpSejg6aF9qnpw@mail.gmail.com>
Subject: RFI: Tablet mode support on HP Pro x360 435 G9 w/ AMD Ryzen 7 5825U
To:     linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     mario.limonciello@amd.com, Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear all,

I'd like to have tablet mode support on my system, probably by means
an linux input device such as implemented in the intel platform
specific driver drivers/platform/x86/intel/vbtn.c [0]

In the end I hope GNOME eventually to rotate the systems display and
to show some virtual keyboard (upon users request), cf. for [3]

It appears there has already been a patch proposed  by the chromium
team to support device PNP0C60 [1] but not merged to [5].

Since the system of interest is a HP Probook, there is already a
driver providing virtual buttons,namely hp-wmi [6]. However, the
driver loads probes and loads successfully but doesn't provide any
additional functionality plus some non critical errors on incorrect
ACPI method calls.

I've noticed AMD has started to provide platform specific driver(s)
such as pmf [2]. To my knowledge there is no support for CEZANNE/green
sardine based systems (yet).

What would be recommended practice and subsystem/folder to provide
such capability by means of a (platform specific) driver? At least the
CID PNP0C60 seems to be held by Microsoft [4] and thus be common to
both amd and intel platforms [4]. However, HID INT33D6 is held by
Intel and HID AMDI0081 by AMD. Yet I'm not quite sure if
iio-sensor-proxy [7] needs to be involved, too.

Best regards,
Carsten Hatger

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/intel/vbtn.c?h=v6.2-rc8
[1] https://lore.kernel.org/lkml/1472628817-3145-1-git-send-email-wnhuang@google.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/amd/pmf?h=v6.2-rc8
[3] https://gitlab.gnome.org/GNOME/mutter/-/issues/1760
[4] https://learn.microsoft.com/en-us/windows-hardware/drivers/gpiobtn/button-implementation
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/button.c?h=v6.2-rc8
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/hp/hp-wmi.c?h=v6.2-rc8
[7] https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/
