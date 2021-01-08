Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC722EF6CC
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 18:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAHRyV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 12:54:21 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46886 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbhAHRyV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 12:54:21 -0500
Received: by mail-oi1-f181.google.com with SMTP id q205so12177035oig.13;
        Fri, 08 Jan 2021 09:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=64bLvDgCgYBUvVvAphyLAP7mcN/gvgPAZaS5Ydc+1zM=;
        b=VoIjvmVH8pN/IrUdJwwxpuY1TyEFBCjBVrKBpXaxhe9MtZzy4yJ618QXQRikiWkVUR
         XZG1IkkPAlBV6Nldks9jQXZSvwq0neQrP7zK3BRa1iuAy+sK7KYcdVvwmnDgd5P0DRTp
         y6NsBDZGMtI3jDg9T5q/VkxoVVe7VhJwGuz7/ecRGC/Of3dLzt3uIjRc6iJzUlIIeI/p
         S+RWLzDPj8n9rwiATHea7HxFQz/I5nqFwHG88tnw/MWTbVglPIPDbg3MLO5vPS7FYN7/
         vEeiBTIXpY4/vsJ86dC3vV+p1I/ATlQ3Rcnz54rkANpb97ypaDagcMq2hrcgZwggLKnj
         pnEw==
X-Gm-Message-State: AOAM530zioVT/H+kLmBdh9r/PYy6BdOlJZzm+IO9r1kbW66AjgpTBOKa
        NAohyOpGwLQATnzsrvN5GGMOtKSomaH03hm9MUChvP19G7w=
X-Google-Smtp-Source: ABdhPJzF3kao47vS5LN6XIubxJB7JS5wJsaGQHNNPbD2uqTmUXtzyumaR+GdxUWLoOjPrxsok9JJO4fXMcNI8CqEec8=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr2897549oig.69.1610128420533;
 Fri, 08 Jan 2021 09:53:40 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Jan 2021 18:53:29 +0100
Message-ID: <CAJZ5v0hZP8tsniMBtjBatd-ORJMXqVWXiPEPpJvpfZagUGyPEw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.11-rc3
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
 acpi-5.11-rc3

with top-most commit 24e8ab6886d80fe60b1d4e64b6d9f15ea9ad597a

 Merge branches 'acpi-scan' and 'acpi-misc'

on top of commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62

 Linux 5.11-rc2

to receive ACPI fixes for 5.11-rc3.

These address two build issues and drop confusing text from a couple
of Kconfig entries.

Specifics:

 - Drop two local variables that are never read and the code updating
   their values from the x86 suspend-to-idle code (Rafael Wysocki).

 - Add empty stub of an ACPI helper function to avoid build issues
   when CONFIG_ACPI is not set (Shawn Guo).

 - Remove confusing text regarding modules from Kconfig entries that
   correspond to non-modular code (Peter Robinson).

Thanks!


---------------

Peter Robinson (1):
      ACPI: Update Kconfig help text for items that are no longer modular

Rafael J. Wysocki (1):
      ACPI: PM: s2idle: Drop unused local variables and related code

Shawn Guo (1):
      ACPI: scan: add stub acpi_create_platform_device() for !CONFIG_ACPI

---------------

 drivers/acpi/Kconfig      |  6 ------
 drivers/acpi/x86/s2idle.c | 14 +-------------
 include/linux/acpi.h      |  7 +++++++
 3 files changed, 8 insertions(+), 19 deletions(-)
