Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4E26D6BA
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIQIeh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:34:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgIQIe3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:34:29 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 52F208350F0EE35B506D;
        Thu, 17 Sep 2020 15:46:50 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:42 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 00/25] ACPI: First step to decouple ACPICA debug functionality from ACPI driver
Date:   Thu, 17 Sep 2020 15:38:40 +0800
Message-ID: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For now, ACPI driver debug functionality is mixed of pr_* functions and
ACPI_DEBUG_PRINT() which is provided ACPICA core directly, ACPICA debug
functions are not friendly for users and also make ACPICA core deeply
coupled with ACPI drivers.

With the evolution of the ACPI driver code, lots of the ACPICA debug
functions used in ACPI drivers were removed away, this makes the ACPICA
debug in ACPI driver to be fragile, for example, some of the COMPONENT
such as ACPI_CONTAINER_COMPONENT and ACPI_MEMORY_DEVICE_COMPONENT are not
used anymore, they leaved as dead code.

From another aspert, removing the ACPICA debug functions didn't raise
concerns in the past, so I believe the ACPICA debug in ACPI driver can be
removed and replace with equivalent pr_* debug functions, then decouple
ACPICA debug functionality from ACPI driver.

In order to decouple ACPICA debug functionality from ACPI driver, I do it
in two steps:
 - Remove the dead ACPICA functionality code, and remove the not used
   COMPONENT;
 - Remove all the ACPICA debug code from ACPI drivers.

This patch set is the first step to decouple ACPICA debug functionality
from ACPI driver, just remove the dead ACPICA functionality code and
some cleanups for ACPI drivers, should no functional change if you don't
apply the last two patches.

Patch 1/25 ~ patch 23/25 are removing the dead code and cleanups;
Patch 24/25 ~ patch 25/25 are the actual ABI change.

If the ABI change is making sense, I will go further to remove the
ACPICA debug functionality from ACPI driver, just keep it inside
the ACPICA core.

Hanjun Guo (25):
  ACPI: cmos_rtc: Remove the ACPI_MODULE_NAME()
  ACPI: configfs: Decouple with ACPICA
  ACPI: configfs: Add the missing config_item_put()
  ACPI: debug: Remove the not used function
  ACPI: LPSS: Remove the ACPI_MODULE_NAME()
  ACPI: memhotplug: Remove the leftover ACPICA debug functionality
  ACPI: memhotplug: Remove the state for memory device
  ACPI: platform: Remove the leftover ACPICA debug functinality
  ACPI: container: Remove the leftover ACPICA debug functionality
  ACPI: custom_method: Remove the ACPICA debug code
  ACPI: debugfs: Remove the ACPICA debug code
  ACPI: dock: Remove the ACPICA debug code
  ACPI: event: Remove the ACPICA debug code
  ACPI: PCI: Remove the unused ACPICA debug code
  ACPI: proc: Remove the unused ACPICA debug code
  ACPI: processor: Remove the dead ACPICA debug code
  ACPI: processor: Remove the duplicated ACPI_PROCESSOR_CLASS macro
  ACPI: SBS: Simplify the driver init code
  ACPI: SBS: Simplify the code using module_acpi_driver()
  ACPI: tiny-power-button: Remove the dead ACPICA debug code
  ACPI: tiny-power-button: Simplify the code using module_acpi_driver()
  ACPI: video: Remove the dead ACPICA debug code
  ACPI: wakeup: Remove the dead ACPICA debug code
  ACPI: sysfs: Remove the dead debug interfaces
  ACPI: debug: Update the ACPI debug document

 Documentation/firmware-guide/acpi/debug.rst |  4 ----
 drivers/acpi/acpi_cmos_rtc.c                |  2 --
 drivers/acpi/acpi_configfs.c                |  6 ++----
 drivers/acpi/acpi_dbg.c                     |  7 -------
 drivers/acpi/acpi_lpss.c                    |  2 --
 drivers/acpi/acpi_memhotplug.c              | 17 -----------------
 drivers/acpi/acpi_platform.c                |  2 --
 drivers/acpi/container.c                    |  3 ---
 drivers/acpi/custom_method.c                |  2 --
 drivers/acpi/debugfs.c                      |  3 ---
 drivers/acpi/dock.c                         |  2 --
 drivers/acpi/event.c                        |  3 ---
 drivers/acpi/pci_root.c                     |  2 --
 drivers/acpi/pci_slot.c                     |  3 ---
 drivers/acpi/proc.c                         |  4 ----
 drivers/acpi/processor_core.c               |  3 ---
 drivers/acpi/processor_idle.c               |  1 -
 drivers/acpi/processor_perflib.c            |  1 -
 drivers/acpi/processor_thermal.c            |  4 ----
 drivers/acpi/processor_throttling.c         |  1 -
 drivers/acpi/sbs.c                          | 24 +-----------------------
 drivers/acpi/sysfs.c                        | 18 +++++++-----------
 drivers/acpi/tiny-power-button.c            |  5 +----
 drivers/acpi/video_detect.c                 |  3 ---
 drivers/acpi/wakeup.c                       |  2 --
 include/acpi/acpi_drivers.h                 |  8 ++------
 26 files changed, 13 insertions(+), 119 deletions(-)

-- 
1.7.12.4

