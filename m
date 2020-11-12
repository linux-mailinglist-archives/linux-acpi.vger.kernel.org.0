Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44472B0950
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 17:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgKLQAS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 11:00:18 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36724 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgKLQAR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 11:00:17 -0500
Received: by mail-ot1-f51.google.com with SMTP id n89so6043520otn.3;
        Thu, 12 Nov 2020 08:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uSvbXH4CyeVHmYh9u1L91dcNlQQ8ypiS3s4LMmYrlaY=;
        b=UvwIWEVL9ZHGV0Qx92ml/3JTn+hbhJ6UyScKmbVwIBAc8V2CxQ4QSvS907+96cz98L
         eK6mL1eokhFhA73WA6J17k/01uHJzQtvT+pI0y0fjiYNUIXMAsFXeybqAYWfsvN/e1zR
         kilx/DH7x6mZTnfCDR03q3vRZWUPfLmHKU/osU3w9hd2vCAGE/H5C1vC4uPAo7uyCyhs
         6q6rjLhzPxVgmFA26EVhaVSVJkzkTfR37tWE7q7F+81TrYUXYAiotb5esXZZMoyX7stm
         EYEWmhoBjI7B5CTKU/5sJd+4AP8jGsVmQWiJDcvXlzvzmCJXuML0zn3ymiZGs7tf9MA4
         BHmg==
X-Gm-Message-State: AOAM531CObqQ7HAU0uOGhOFhSr3o9yLbkmcweoiJ0qW3xhhnM4E7Wq77
        tADO2wgu2kYApBl7orOmdNjiRAUtf0VFtZeV+J0zMuc9r/s=
X-Google-Smtp-Source: ABdhPJy20Psdcu+jBPDIbLC8rCOwltWSLfoYyZQ8GYS92dblTRH3atiBA0Fw4oDCD6xkVQ3txe2lClxmLtFiMaY0RT0=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr23123590otu.206.1605196816463;
 Thu, 12 Nov 2020 08:00:16 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Nov 2020 17:00:05 +0100
Message-ID: <CAJZ5v0gNPL6kbg9f5JgZOvH7k-GLC8yrvvidwj_VCq09ie9NYg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.10-rc4
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
 acpi-5.10-rc4

with top-most commit 7222a8a52c9ec59affc4d6c4e2632b3e4a44cd27

 Merge branches 'acpi-scan', 'acpi-misc', 'acpi-button' and 'acpi-dptf'

on top of commit f8394f232b1eab649ce2df5c5f15b0e528c92091

 Linux 5.10-rc3

to receive ACPI updates for 5.10-rc4.

These are mostly docmentation fixes and janitorial changes plus some
new device IDs and a new quirk.

Specifics:

 - Fix documentation regarding GPIO properties (Andy Shevchenko).

 - Fix spelling mistakes in ACPI documentation (Flavio Suligoi).

 - Fix white space inconsistencies in ACPI code (Maximilian Luz).

 - Fix string formatting in the ACPI Generic Event Device (GED)
   driver (Nick Desaulniers).

 - Add Intel Alder Lake device IDs to the ACPI drivers used by the
   Dynamic Platform and Thermal Framework (Srinivas Pandruvada).

 - Add lid-related DMI quirk for Medion Akoya E2228T to the ACPI
   button driver (Hans de Goede).

Thanks!


---------------

Andy Shevchenko (3):
      Documentation: firmware-guide: gpio-properties: Fix factual mistakes
      Documentation: firmware-guide: gpio-properties: active_low only
for GpioIo()
      Documentation: firmware-guide: gpio-properties: Clarify initial
output state

Flavio Suligoi (1):
      Documentation: ACPI: fix spelling mistakes

Hans de Goede (1):
      ACPI: button: Add DMI quirk for Medion Akoya E2228T

John Garry (1):
      ACPI: scan: Fix acpi_dma_configure_id() kerneldoc name

Maximilian Luz (1):
      ACPI: Fix whitespace inconsistencies

Nick Desaulniers (1):
      ACPI: GED: fix -Wformat

Srinivas Pandruvada (1):
      ACPI: DPTF: Support Alder Lake

---------------

 Documentation/firmware-guide/acpi/acpi-lid.rst     |  8 ++--
 .../firmware-guide/acpi/gpio-properties.rst        | 55 ++++++++++++++++------
 .../firmware-guide/acpi/method-tracing.rst         |  2 +-
 drivers/acpi/acpi_video.c                          |  6 +--
 drivers/acpi/battery.c                             |  2 +-
 drivers/acpi/button.c                              | 13 ++++-
 drivers/acpi/dptf/dptf_pch_fivr.c                  |  1 +
 drivers/acpi/dptf/dptf_power.c                     |  2 +
 drivers/acpi/dptf/int340x_thermal.c                |  6 +++
 drivers/acpi/event.c                               |  2 +-
 drivers/acpi/evged.c                               |  2 +-
 drivers/acpi/fan.c                                 |  1 +
 drivers/acpi/internal.h                            |  2 +-
 drivers/acpi/nfit/core.c                           | 10 ++--
 drivers/acpi/pci_irq.c                             |  2 +-
 drivers/acpi/pci_link.c                            | 12 ++---
 drivers/acpi/pci_mcfg.c                            |  2 +-
 drivers/acpi/power.c                               |  6 +--
 drivers/acpi/processor_perflib.c                   |  6 +--
 drivers/acpi/sbs.c                                 |  2 +-
 drivers/acpi/sbshc.c                               |  2 +-
 drivers/acpi/sbshc.h                               |  6 +--
 drivers/acpi/scan.c                                |  2 +-
 drivers/acpi/video_detect.c                        | 16 +++----
 drivers/acpi/wakeup.c                              |  4 +-
 25 files changed, 110 insertions(+), 62 deletions(-)
