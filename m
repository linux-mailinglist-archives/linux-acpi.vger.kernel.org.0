Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3CB3B7831
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhF2TFr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 15:05:47 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42592 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhF2TFr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 15:05:47 -0400
Received: by mail-oi1-f171.google.com with SMTP id o6so12820420oic.9;
        Tue, 29 Jun 2021 12:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4yz5LfZwrH+LX4tKEfyXffYVisedU6O7RAcKGI7Sppc=;
        b=TkjKdRUMg/STAP+EwAfSJhqLfzT8PYrVFPzKcdgnwL3B6t+FfwhN/Yr5iSGOx98srA
         4cxNZMMhYNLQ3PJ/G6HQGeSDbOnCKIv57RdKMmaGd9m86VqddQmkS7CCJeixVGoRilqI
         g2GwAZt3J2v16J1sIG7jajHRFRk59ULA0AHiBnEuYRIKuD4ICFjRchu9fyPDuefscqyZ
         JZeibGoP+txODYfLewLKKd7g7sNumN74u+euUPi7jMY+ozcoiv28CTVX7q7Lr37lzMpL
         5IBiDBiszA19xgI6sdq2cS00tfbTuoxX8axnUdLOOnKrKen6/MvvOMqFtdos5g+//7X0
         f+6w==
X-Gm-Message-State: AOAM533UTDOW/OAZOEfbxZC4gSimT2vp5WwtVRhczp6yVmsmn9sQD1th
        2kvtStUR4BtP5JfhbigFRIP8bP4+Ckby3lSyCmLrvEFVleg=
X-Google-Smtp-Source: ABdhPJw7Q1yNYT7S7uEZiwj8IBZbWptMPocsVe3w4z+5BfTfZVnlWVYa9Pcp+//KJsHGnhOAUgHGT1JnJV7YUU6/k04=
X-Received: by 2002:aca:d11:: with SMTP id 17mr14706289oin.69.1624993399328;
 Tue, 29 Jun 2021 12:03:19 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Jun 2021 21:03:08 +0200
Message-ID: <CAJZ5v0hNnTcoTUd8fn-kRUP6+1Nd-1zRMFgaa_ZL-VaGpx67PQ@mail.gmail.com>
Subject: [GIT PULL] PNP updates for v5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pnp-5.14-rc1

with top-most commit 17aa26c96fb240de92db90ec1bfd616f28b6dc16

 PNP: pnpbios: Use list_for_each_entry() instead of list_for_each()

on top of commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc

 Linux 5.13-rc2

to receive PNP updates for 5.14-rc1.

These get rid of unnecessary local variables and function, reduce
code duplication and clean up message printing.

Specifics:

 - Remove unnecessary local variables from isapnp_proc_attach_device()
   (Anupama K Patil).

 - Make the callers of pnp_alloc() use kzalloc() directly and drop
   the former (Heiner Kallweit).

 - Make two pieces of code use dev_dbg() instead of dev_printk() with
   the KERN_DEBUG message level (Heiner Kallweit).

 - Use DEVICE_ATTR_RO() instead of full DEVICE_ATTR() in some places
   in card.c (Zhen Lei).

 - Use list_for_each_entry() instead of list_for_each() in
   insert_device() (Zou Wei).

Thanks!


---------------

Anupama K Patil (1):
      drivers: pnp: isapnp: proc.c: Remove unnecessary local variables

Heiner Kallweit (2):
      PNP: Remove pnp_alloc()
      PNP: Switch over to dev_dbg()

Zhen Lei (1):
      PNP: use DEVICE_ATTR_RO macro

Zou Wei (1):
      PNP: pnpbios: Use list_for_each_entry() instead of list_for_each()

---------------

 drivers/pnp/base.h         |  1 -
 drivers/pnp/card.c         | 14 +++++++-------
 drivers/pnp/core.c         | 17 ++---------------
 drivers/pnp/interface.c    |  4 ++--
 drivers/pnp/isapnp/proc.c  | 13 ++++++-------
 drivers/pnp/pnpbios/core.c |  4 +---
 drivers/pnp/resource.c     |  2 +-
 7 files changed, 19 insertions(+), 36 deletions(-)
