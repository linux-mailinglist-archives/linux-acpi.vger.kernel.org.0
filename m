Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60741EBE4
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2019 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfEOKOu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 May 2019 06:14:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38585 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOKOu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 May 2019 06:14:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id u199so1404334oie.5;
        Wed, 15 May 2019 03:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+nWoClQWpbXaS5S9TSrITRgcguaOUgfYrV0DD+nmoZA=;
        b=qBVYNdj+fwltllbTuBk5sdLLSYUpKX/+ahBRzDwrFPgewGKmDrkyPcfhz7YfaNmygt
         VbFBahBzMg/Y3lmVzZgh2qTbtEjce0aYKi3Cn1YhSAOnXBxP3j3SGX+DrDFhcGrT1iEo
         OluigwtOr99himHdg+IhfnNjzFMsUwQ5ec83cIqAzTIdn/+Pjiel6mJg5wEsU2xIndZx
         BJd27Mod9qPZm0xKJiJprp9KBGOuzjk7DhO3HuvieSPGqoehyiWqxeuD5L1kPKUM38XG
         HlTtYinUuZiuOb6bXHKfbVpn8rNuJVKQXrYxrMPMAIG6mcZoiobnuzuNJG19AQRmeoZP
         qBXQ==
X-Gm-Message-State: APjAAAWMut6jo++j9kQMonohNhmaQ6ibfYHqXGfLGRmhBN0TIMdCgF+/
        itrI6NkE1LAQUcHsJT+jyb8HOL/lcAyKOutAZQg=
X-Google-Smtp-Source: APXvYqzTDSS2Cr0LBBir3iTnrXejwfF4FuOP+Kek2CS2V1C/ZgM3wT2XrH1e7u/xuKkvDGFNhJi1OyPBnR8BHz+LskY=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr6472865oif.110.1557915289800;
 Wed, 15 May 2019 03:14:49 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 May 2019 12:14:39 +0200
Message-ID: <CAJZ5v0j3pD8rqiQoR7e3FbQx3JjaBh32f4+bHjxza00RsYBmcQ@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.2-rc1-2

with top-most commit e3e28670bb28ad52d0d0224e86ec11c3f31ff1ff

 Merge branches 'acpi-bus', 'acpi-doc' and 'acpi-pm'

on top of commit 59df1c2bdecb0d1aaadfb8533df4bea528ee4952

 Merge tag 'acpi-5.2-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.2-rc1.

These fix two regressions introduced during the 5.0 cycle, in ACPICA
and in device PM, cause the values returned by _ADR to be stored in
64 bits and fix two ACPI documentation issues.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20190509
   including one regression fix:
   * Prevent excessive ACPI debug messages from being printed
     by moving the ACPI_DEBUG_DEFAULT definition to the right
     place (Erik Schmauss).

 - Set the enable_for_wake bits for wakeup GPEs during suspend to
   idle to allow acpi_enable_all_wakeup_gpes() to enable them as
   aproppriate and make wakeup devices sighaling events through ACPI
   GPEs work with suspend-to-idle again (Rajat Jain).

 - Use 64 bits to store the return values of _ADR which are assumed
   to be 64-bit by some bus specs and may contain nonzero bits in the
   upper 32 bits part for some devices (Pierre-Louis Bossart).

 - Fix two minor issues with the ACPI documentation (Sakari Ailus).

Thanks!


---------------

Bob Moore (1):
      ACPICA: Update version to 20190509

Erik Schmauss (1):
      ACPICA: Linux: move ACPI_DEBUG_DEFAULT flag out of ifndef

Pierre-Louis Bossart (1):
      ACPI: bus: change _ADR representation to 64 bits

Rajat Jain (1):
      ACPI: PM: Set enable_for_wake for wakeup GPEs during suspend-to-idle

Sakari Ailus (2):
      Documentation: ACPI: Use tabs for graph ASL indentation
      Documentation: ACPI: Direct references are allowed to devices only

---------------

 .../acpi/dsd/data-node-references.rst              |   6 +-
 Documentation/firmware-guide/acpi/dsd/graph.rst    | 120 ++++++++++-----------
 drivers/acpi/device_sysfs.c                        |   6 +-
 drivers/acpi/sleep.c                               |   4 +
 include/acpi/acpi_bus.h                            |   2 +-
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/platform/aclinux.h                    |  10 +-
 7 files changed, 78 insertions(+), 72 deletions(-)
