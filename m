Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF393F34B5
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 21:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhHTTg5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Aug 2021 15:36:57 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41839 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhHTTgz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Aug 2021 15:36:55 -0400
Received: by mail-ot1-f46.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso1498517ota.8;
        Fri, 20 Aug 2021 12:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tlG8gFHdwbNMnGBV3L4Ud/dyohUxKHygZ2pV3sjYueE=;
        b=FTX0gFQd+RTqjJ7VR1RUabuGvXFn+rMoCtvL8as5UXpGUzoJHYfc0DdfO4e/iBEjdP
         YgmaoMzTkke15xHAGyXFosWQHmqTI1fOA/KbL4JWaIaAm5AG/aHoIeX9qAh84nOg4YKX
         faRoQdi0HzVMAHziTpBbpxYTJYpgd6T6Ld7KDdAiu9LGL5jrp5PJ4jlhDiTa/SJM6xk0
         SEDcIcXsS6KidnSbUXWqltZEE3TAq1C27A1GYDKjXLhaNGCZby3/4BAntK8PdMQVGRoA
         j4p/U3aRigp0+eMhogCoknvJsI+sVl3UIq3XQ+dhbmHthhZE3nzcY5lmlqfaKiUSYXph
         xuCA==
X-Gm-Message-State: AOAM532nGkqS2VuZNFP63XOX4Sr0TZIwNYIFFe0e5QbwIFlHUfWHepJK
        P2jDfq9JBw6qj/5QbtvOcFMwQwNQuYIvKJGVtZc=
X-Google-Smtp-Source: ABdhPJzO4vI7OgzMyMxKl9AmbSMGac8CHAtTH/FPfvvhz15gV2BzjRw3meT56Q1PVZzlFup7BncdO3WjE0JjBMsWj3M=
X-Received: by 2002:a9d:a57:: with SMTP id 81mr5054906otg.260.1629488177258;
 Fri, 20 Aug 2021 12:36:17 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Aug 2021 21:36:06 +0200
Message-ID: <CAJZ5v0g14eg5PT5+AnKh_Uf+a7Ap5t5+G_LcU8+A-tQS3UY15g@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.14-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.14-rc7

with top-most commit 0f09f4c48118ce3c562e1028df7fe0f8150493d6

 Merge branch 'acpi-pm'

on top of commit 7c60610d476766e128cc4284bb6349732cbd6606

 Linux 5.14-rc6

to receive ACPI fixes for 5.14-rc7.

These fix two mistakes in new code.

Specifics:

 - Prevent confusing messages from being printed if the PRMT table
   is not present or there are no PRM modules (Aubrey Li).

 - Fix the handling of suspend-to-idle entry and exit in the case
   when the Microsoft UUID is used with the Low-Power S0 Idle _DSM
   interface (Mario Limonciello).

Thanks!


---------------

Aubrey Li (1):
      ACPI: PRM: Deal with table not present or no module found

Mario Limonciello (1):
      ACPI: PM: s2idle: Invert Microsoft UUID entry and exit

---------------

 drivers/acpi/prmt.c       | 6 ++++++
 drivers/acpi/x86/s2idle.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)
