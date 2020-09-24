Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644152766C7
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 05:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIXDMu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 23:12:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbgIXDMu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 23:12:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C8DE62C86B68AB15116D;
        Thu, 24 Sep 2020 11:05:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 11:05:02 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 00/15] Cleanups before decoupling ACPICA debug with ACPI driver
Date:   Thu, 24 Sep 2020 10:56:52 +0800
Message-ID: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

With the evolution of the ACPI driver code, lots of the ACPICA debug            
functions such as ACPI_DEBUG_PRINT() used in ACPI drivers were removed
away, this makes some of the ACPICA debug code in ACPI driver as dead,
for example, _COMPONENT and ACPI_MODULE_NAME() are useless without
ACPICA debug functions.

This patch set will cleanup those dead code before decoupling ACPICA
debug with ACPI driver, should be no functional change.

v1->v2:
- Remove patches that not for ACPICA debug cleanups, send them
  seperately, this patch set only contains cleanups for ACPICA debug
  functionality.

Hanjun Guo (15):
  ACPI: cmos_rtc: Remove the leftover ACPICA code ACPI_MODULE_NAME()
  ACPI: LPSS: Remove the ACPI_MODULE_NAME()
  ACPI: memhotplug: Remove the leftover ACPICA debug functionality
  ACPI: platform: Remove the ACPI_MODULE_NAME()
  ACPI: container: Remove the leftover ACPICA debug functionality
  ACPI: custom_method: Remove the dead ACPICA debug code
  ACPI: debugfs: Remove the dead ACPICA debug code
  ACPI: dock: Remove the dead ACPICA debug code
  ACPI: event: Remove the leftover ACPICA debug code
  ACPI: PCI: Remove the unused ACPICA debug code
  ACPI: proc: Remove the dead ACPICA debug code
  ACPI: processor: Remove the dead ACPICA debug code
  ACPI: tiny-power-button: Remove the dead ACPICA debug code
  ACPI: video: Remove the leftover ACPICA debug code
  ACPI: wakeup: Remove the dead ACPICA debug code

 drivers/acpi/acpi_cmos_rtc.c     | 2 --
 drivers/acpi/acpi_lpss.c         | 2 --
 drivers/acpi/acpi_memhotplug.c   | 7 -------
 drivers/acpi/acpi_platform.c     | 2 --
 drivers/acpi/container.c         | 3 ---
 drivers/acpi/custom_method.c     | 2 --
 drivers/acpi/debugfs.c           | 3 ---
 drivers/acpi/dock.c              | 2 --
 drivers/acpi/event.c             | 3 ---
 drivers/acpi/pci_root.c          | 2 --
 drivers/acpi/pci_slot.c          | 3 ---
 drivers/acpi/proc.c              | 4 ----
 drivers/acpi/processor_core.c    | 3 ---
 drivers/acpi/processor_thermal.c | 2 --
 drivers/acpi/tiny-power-button.c | 1 -
 drivers/acpi/video_detect.c      | 3 ---
 drivers/acpi/wakeup.c            | 2 --
 17 files changed, 46 deletions(-)

-- 
1.7.12.4

