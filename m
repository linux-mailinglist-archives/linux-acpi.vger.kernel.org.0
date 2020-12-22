Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990172E0EB1
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Dec 2020 20:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgLVTQP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Dec 2020 14:16:15 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38834 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLVTQO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Dec 2020 14:16:14 -0500
Received: by mail-ot1-f44.google.com with SMTP id j20so12883838otq.5;
        Tue, 22 Dec 2020 11:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ygKvG+Xi5YRuoJ8yhycwuvW5pwPVyAlu9r1/cRnWCXU=;
        b=r6+ZgHQCCMc8flPWN+kLwLoO2RHtE+dEeDtPG4YPQuip8A2NfSWA3N6lGtMVVEYXMQ
         ArGc1rAggtnLK9EVgEuKEDyZ4k2KuJ5Gt+xXVk1iSQr6VuIamrF9diQgTC4wgqvtjGzD
         LRfT9qLm+AiFKCn5MZ1t8sJjU6P0AAbsi4RbHSMqdUHDv8hMdfgfxjOWqbDf07rW2Fsp
         ndS90clUhtkyxTH5TRTCU+6D/sWZ6+yRvndEaLFY6m6MMNySjMmOkN2dD/7sP+abScrP
         raao/kmX3cr2iUUrONQMLXarOzGOxESwrCFxKoMFH7KsnuvVt8um4CDAXmapKw9hQial
         9U/A==
X-Gm-Message-State: AOAM530GEQ7o9WY/J0lwL2/jS9leWh7qnybzSLRp8+k0uDO3L3+XtBlY
        WZJWX/vqUN7sIwKISsMMEVZHW5Iy8WTA06NoAS9WcKDrLKM=
X-Google-Smtp-Source: ABdhPJwE0AahC1wgufL8Le6mAiZdJqEXJP0NI3a0iUlXmOW+y/KD/53RuSiPhQavMMI/1Tu2DJ8NJpDb7uBH33PE7Kc=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr17221313otn.321.1608664533212;
 Tue, 22 Dec 2020 11:15:33 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Dec 2020 20:15:22 +0100
Message-ID: <CAJZ5v0jS2-kDBA70XwStNEg3pUusK_=h5P58d71cOx83zU-WOw@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.11-rc1-2

with top-most commit 538fcf57aaee6ad78a05f52b69a99baa22b33418

 Merge branches 'acpi-scan', 'acpi-pnp' and 'acpi-sleep'

on top of commit aab7ce2b099bd9df82573cd3170acf6518fdebeb

 Merge tag 'acpi-5.11-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.11-rc1.

These make the ACPI enumeration of devices take _DEP information
into account more aggressively, fix device IDs matching in the ACPI
part of the PNP devices framework and update the ACPI code related
to suspend-to-idle to take systems based on AMD hardware into account
properly.

Specifics:

 - Modify the ACPI device enumeration code to defer the enumeration
   of devices with an _HID whose lists of operation region
   dependencies returned by _DEP are not empty after eliminating the
   entries representing known-benign dependencies from them (Rafael
   Wysocki, Hans de Goede).

 - Make the ACPI PNP code matching device IDs also take the length of
   the given ID string into account (Hui Wang).

 - Add AMD systems support to the ACPI code handling suspend-to-idle
   via the PNP0D80 (System Power Management Controller) device _DSM
   interface (Shyam Sundar).

 - Move the suspend-to-idle handling code related to the PNP0D80
   device _DSM interface, which is x86-specific, to a separate file
   in the x86/ subdirectory (Rafael Wysocki).

Thanks!


---------------

Hans de Goede (1):
      ACPI: scan: Add Intel Baytrail Mailbox Device to acpi_ignore_dep_ids

Hui Wang (1):
      ACPI: PNP: compare the string length in the matching_id()

Rafael J. Wysocki (4):
      ACPI: scan: Evaluate _DEP before adding the device
      ACPI: scan: Defer enumeration of devices with _DEP lists
      ACPI: scan: Avoid unnecessary second pass in acpi_bus_scan()
      ACPI: PM: s2idle: Move x86-specific code to the x86 directory

Shyam Sundar S K (1):
      ACPI: PM: s2idle: Add AMD support to handle _DSM

---------------

 drivers/acpi/Makefile     |   1 +
 drivers/acpi/acpi_pnp.c   |   3 +
 drivers/acpi/scan.c       | 143 ++++++++++----
 drivers/acpi/sleep.c      | 305 ++----------------------------
 drivers/acpi/sleep.h      |  16 ++
 drivers/acpi/x86/s2idle.c | 460 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 598 insertions(+), 330 deletions(-)
