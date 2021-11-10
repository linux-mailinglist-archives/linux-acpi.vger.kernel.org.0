Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C38C44C2F9
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 15:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhKJOdh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 09:33:37 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46878 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhKJOdg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Nov 2021 09:33:36 -0500
Received: by mail-ot1-f50.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so4090953otk.13;
        Wed, 10 Nov 2021 06:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XjAf3OlmbwOXhyg2GEvgGGx342vsuJVL9IPZ/IIBANY=;
        b=ZxTolRUZ4DcX4WBuOUCSe1UDzLMTtf1En9FZwu/2yvM0dRVEQzwFTjr3HPHdIdUaKi
         ZQJQUaQ9XevtqPxGgMxVip4r6qN0IUZpzUgVG/+XD+IvZchtKiIiHhzKoP4Pb9nuDEcw
         3cvJNt1U7HJlXqUIsponeyaMlURHUfOvHWlzThqJLP74wyQRNeN8aT49G4SgG5RvZj+1
         6UQAtudIaSOYtpmkc6alhUdVxe2Gj+6JmAOq6e1GoQ6i3sdynZ5b0mfmUJ+tZWbYqumy
         4/SE3bt63vqlnwM/ZA9KaeYX6Yl7KVhcceml9j5k4yuKGHyw9WTvlJZFHtIZn0FGfAl+
         NGXw==
X-Gm-Message-State: AOAM531pRLlbnUE1/YUhpSKA6Zb8HqTIbM1KcUmVTiIO4+1PfxhpqapP
        mgvhTr3rChTU23LZEp00J106FWvoNr5i8UYsSKMdVS+iNXM=
X-Google-Smtp-Source: ABdhPJwi1BEY0IwcEqIvTRpTXx9VoeabJxpg6sKKwVVM8Llb/8b4C+IVunq6CwGn+/m4cuXt5XNzAwFGh6cj3vkh/H8=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr243394otu.254.1636554648750;
 Wed, 10 Nov 2021 06:30:48 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Nov 2021 15:30:37 +0100
Message-ID: <CAJZ5v0hjcR1z_kD_jXthbXuebYbRCG3-BZsaZBD+Ta83-Kf+og@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.16-rc1
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
 acpi-5.16-rc1-2

with top-most commit 314c6e2b4545efd5b88988f2308e90eda6a4bcf1

 Merge branches 'acpica', 'acpi-ec', 'acpi-pmic' and 'acpi-video'

on top of commit c0d6586afa3546a3d148cf4b9d9a407b4f79d0bb

 Merge tag 'acpi-5.16-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.16-rc1.

These add support for a new ACPI device configuration object called
_DSC, fix some issues including one recent regression, add two new
items to quirk lists and clean up assorted pieces of code.

Specifics:

 - Add support for new ACPI device configuration object called _DSC
   to allow certain devices to be probed without changing their power
   states, document it and make two drivers use it (Sakari Ailus,
   Rajmohan Mani).

 - Fix device wakeup power reference counting broken recently by
   mistake (Rafael Wysocki).

 - Drop unused symbol and macros depending on it from acgcc.h (Rafael
   Wysocki).

 - Add HP ZHAN 66 Pro to the "no EC wakeup" quirk list (Binbin Zhou).

 - Add Xiaomi Mi Pad 2 to the backlight quirk list and drop an unused
   piece of data from all of the list entries (Hans de Goede).

 - Fix register read accesses handling in the Intel PMIC operation
   region driver (Hans de Goede).

 - Clean up static variables initialization in the EC driver
   (wangzhitong).

Thanks!


---------------

Binbin Zhou (1):
      ACPI: EC: Use ec_no_wakeup on HP ZHAN 66 Pro

Hans de Goede (3):
      ACPI: PMIC: Fix intel_pmic_regs_handler() read accesses
      ACPI: video: Drop dmi_system_id.ident settings from
video_detect_dmi_table[]
      ACPI: video: use platform backlight driver on Xiaomi Mi Pad 2

Rafael J. Wysocki (2):
      ACPI: PM: Fix device wakeup power reference counting error
      ACPI: Drop ACPI_USE_BUILTIN_STDARG ifdef from acgcc.h

Rajmohan Mani (1):
      media: i2c: imx319: Support device probe in non-zero ACPI D state

Sakari Ailus (6):
      ACPI: scan: Obtain device's desired enumeration power state
      i2c: Allow an ACPI driver to manage the device's power state during probe
      Documentation: ACPI: Document _DSC object usage for enum power state
      ACPI: Add a convenience function to tell a device is in D0 state
      at24: Support probing while in non-zero ACPI D state
      Documentation: ACPI: Fix non-D0 probe _DSC object example

wangzhitong (1):
      ACPI: EC: Remove initialization of static variables to false

---------------

 Documentation/firmware-guide/acpi/index.rst        |  1 +
 Documentation/firmware-guide/acpi/non-d0-probe.rst | 78 ++++++++++++++++++++++
 drivers/acpi/device_pm.c                           | 26 ++++++++
 drivers/acpi/ec.c                                  | 11 ++-
 drivers/acpi/pmic/intel_pmic.c                     | 51 +++++++-------
 drivers/acpi/power.c                               |  8 +--
 drivers/acpi/scan.c                                |  4 ++
 drivers/acpi/video_detect.c                        | 78 ++++++++++++----------
 drivers/i2c/i2c-core-acpi.c                        | 10 +++
 drivers/i2c/i2c-core-base.c                        |  7 +-
 drivers/media/i2c/imx319.c                         | 74 +++++++++++---------
 drivers/misc/eeprom/at24.c                         | 45 ++++++++-----
 include/acpi/acpi_bus.h                            |  1 +
 include/acpi/platform/acgcc.h                      | 13 ----
 include/linux/acpi.h                               |  5 ++
 include/linux/i2c.h                                | 18 +++++
 16 files changed, 301 insertions(+), 129 deletions(-)
