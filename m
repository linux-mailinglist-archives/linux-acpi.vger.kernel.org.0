Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD303757AA
	for <lists+linux-acpi@lfdr.de>; Thu,  6 May 2021 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhEFPkz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 May 2021 11:40:55 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42905 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbhEFPki (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2021 11:40:38 -0400
Received: by mail-oi1-f181.google.com with SMTP id v24so5860919oiv.9;
        Thu, 06 May 2021 08:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sdjQ0pJ/CZ8t7dbJVu4aunJF6Pe/uNssbk7mGeRm9Qc=;
        b=XvG+MdzxTOBEjnSaHDdEIrddGqikdrmxoSpjPs8R+0/HYDSxIJ0MlIowNtLRvSqzoz
         0oxG810botw6uMDNcZwnAy7zQsLCSARBcN5W2zx5IDMtt/EXzcmYu3zEhdzc3gPv+Yua
         bCBszPqX2DTI/oiggUld3HAyhcdvQiFd/Ec3p5VuFgs5I+98dv66wFk0KEVrJVMAUBbv
         TCIsL7VGTnE8CUPZDhkuE/BKz9v4zBfz8WMu34LSCQfP6YqZ15EwJ44hwfh3wCySlb59
         VxPyRteMpr3Ke0LB3qeAGlxZbaSWNAE2ptcJYd9zZTxiYxnft8B+pTL6ncIrKOffrBpw
         Z9Gw==
X-Gm-Message-State: AOAM5334vSi3FDOybhniUn7GS9R6uQ8QexfeiwylhXIAttfAuAVvyTMW
        82s1iUTXBVp2zK8hqJBy2aHZuNR9yBuIeRWu3XpAlP7Sv1s=
X-Google-Smtp-Source: ABdhPJyL2IddCEkm8O1kz510+fbDkAwQL7i4c9S254ThXXAQl0anHxWLSslGGI+frvYlcT+aVdOTbfbsQecZEoavQu8=
X-Received: by 2002:aca:bc89:: with SMTP id m131mr3672209oif.71.1620315579236;
 Thu, 06 May 2021 08:39:39 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 May 2021 17:39:28 +0200
Message-ID: <CAJZ5v0hLfXuUNRw2B48S7mQK5bnsZFFKQfqf5mCncMnak6uXYw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.13-rc1
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
 acpi-5.13-rc1-2

with top-most commit 3da53c754502acf74d4d9ba8ac23fc356e6c3d0f

 Merge branches 'acpi-pm' and 'acpi-docs'

on top of commit d8f9176b4ece17e831306072678cd9ae49688cf5

 Merge tag 'acpi-5.13-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI fixes for 5.13-rc1.

These revert one recent commit that turned out to be problematic,
address two issues in the ACPI "custom method" interface and
update GPIO properties documentation.

Specifics:

 - Revent recent commit related to the handling of ACPI power
   resources during initialization, because it turned out to cause
   problems to occur on some systems (Rafael Wysocki).

 - Fix potential use-after-free and potential memory leak in the
   ACPI "custom method" debugfs interface (Mark Langsdorf).

 - Update ACPI GPIO properties documentation to cover assumptions
   regarding GPIO polarity (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      Documentation: firmware-guide: gpio-properties: Add note to SPI CS case

Mark Langsdorf (2):
      ACPI: custom_method: fix potential use-after-free issue
      ACPI: custom_method: fix a possible memory leak

Rafael J. Wysocki (1):
      Revert "ACPI: scan: Turn off unused power resources during initialization"

---------------

 Documentation/firmware-guide/acpi/gpio-properties.rst | 6 ++++++
 drivers/acpi/custom_method.c                          | 4 +++-
 drivers/acpi/internal.h                               | 1 -
 drivers/acpi/power.c                                  | 2 +-
 drivers/acpi/scan.c                                   | 2 --
 drivers/acpi/sleep.h                                  | 1 +
 6 files changed, 11 insertions(+), 5 deletions(-)
