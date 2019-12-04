Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B36112961
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2019 11:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfLDKhC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Dec 2019 05:37:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46949 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDKhC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2019 05:37:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id g18so5835094otj.13;
        Wed, 04 Dec 2019 02:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hrn+T0qXoBS7Oix705yZN70rK/KjrjidrzrYQzpvk60=;
        b=uOiZ5L3ycsWP1ypJcqLcVydDA2vOHcjwdIV8iV64rGC/L/SR9xTQPpfSSuWjI5nYMc
         bp0rGEC9XQRRrZVR+pO5MyLpDL8OT/mZnAXl9keQcmE2DKY/O/AqGeAi64yexfYxjTBI
         uTeFv9b+90CiaQs0cqQayIkfiPSFPiDgI+kynDdGIPQ+Ipoi+KVW8ibhIkhc26v1W4Bl
         d5jIEnAF5gF/TcSY0hYPv3YcDkgVivhJfxTuZzzBApNu9jxVFT2XbYzjSaNKf4BZliik
         1e0cXwo+77w3W+0GuHp+vnn/FPYWHi+lAg7G75AR7pXCeXMaUcsxgjU6pfDiL8ZRVAV8
         cYkA==
X-Gm-Message-State: APjAAAXnXwcxDI0OxDkp1wvcZ+BHGOP8LuLRbkS0zTaqLJybyeX5sGze
        K92wUody8GIM9WzSkUgPXzC/+4pdbmQI9+T+8eI=
X-Google-Smtp-Source: APXvYqylkz9yP/hrkQViDPt291eUwfZVYWuWFjR8l2wU4NqXVMwO1iSg4PjIa/CfW4XWAaZk9Q06SEPG/3IkwwHc9L0=
X-Received: by 2002:a9d:7483:: with SMTP id t3mr1952495otk.262.1575455821133;
 Wed, 04 Dec 2019 02:37:01 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Dec 2019 11:36:50 +0100
Message-ID: <CAJZ5v0g4T6cCQr0BegWhY+KD0W2VJRqBTNoeu-bV8RYmPzTtRg@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.5-rc1-2

with top-most commit b65d56305c6f5c74b1b4fcaf55d48e949e49d67c

 Merge branches 'acpi-bus', 'acpi-button', 'acpi-sysfs' and 'acpi-misc'

on top of commit 6e9f879684b46331f51d0c76ebee981c788417db

 Merge tag 'acpi-5.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.5-rc1.

These close a nasty race condition in the ACPI memory mappings
management code and an invalid parameter check in a library
routing, allow GPE 0xFF to be masked via kernel command line,
add a new lid switch blacklist entry and clean up Kconfig.

Specifics:

 - Fix locking issue in acpi_os_map_cleanup() leading to a race
   condition that can be harnessed for provoking a kernel panic
   from user space (Francesco Ruggeri).

 - Fix parameter check in acpi_bus_get_private_data() (Vamshi K
   Sthambamkadi).

 - Allow GPE 0xFF to be masked via kernel command line (Yunfeng Ye).

 - Add a new lid switch blacklist entry for Acer Switch 10 SW5-032
   to the ACPI button driver (Hans de Goede).

 - Clean up Kconfig (Krzysztof Kozlowski).

Thanks!


---------------

Francesco Ruggeri (1):
      ACPI: OSL: only free map once in osl.c

Hans de Goede (1):
      ACPI: button: Add DMI quirk for Acer Switch 10 SW5-032 lid-switch

Krzysztof Kozlowski (1):
      ACPI: Fix Kconfig indentation

Vamshi K Sthambamkadi (1):
      ACPI: bus: Fix NULL pointer check in acpi_bus_get_private_data()

Yunfeng Ye (1):
      ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100

---------------

 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 drivers/acpi/Kconfig                            |  8 +++----
 drivers/acpi/bus.c                              |  2 +-
 drivers/acpi/button.c                           | 13 ++++++++++++
 drivers/acpi/osl.c                              | 28 +++++++++++++++----------
 drivers/acpi/sysfs.c                            |  6 +++---
 6 files changed, 39 insertions(+), 20 deletions(-)
