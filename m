Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867273984E7
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFBJIV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:21 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3347 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhFBJIS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:18 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw31T4qpdz19Shh;
        Wed,  2 Jun 2021 17:01:49 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:41 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:41 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 00/18] ACPI: Further cleanups for message printing
Date:   Wed, 2 Jun 2021 16:54:22 +0800
Message-ID: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After the message printing cleanups to decouple with ACPICA, the message
printing in ACPI subsystem still have the room for improvement. For now
we use both PREFIX "ACPI: " and pr_*() macros for message print in ACPI
subsystem, they are misused in follwing ways:

 - Duplicated prefix. For example in sysfs.c we have pr_fmt() but we
   still use pr_err(PREFIX ...), which is worng;

 - Using pr_*() macros without pr_fmt(), but some pr_*() calls added
   the PREFIX and some didn't in the same file;

 - Mixed use of printk(PREFIX) and pr_*() macros in one driver but
   don't have the same prefix for message printing.

All the above will confuse people, sometimes leads to write some wrong
message printing code, so just use pr_fmt() and pr_*() macros to generate
a unified format string, and remove the using of PREFIX "ACPI: " in ACPI
drivers, finally remove PREFIX "ACPI: " definition in the internal.h,
which prevent further misuse of the PREFIX.

Also remove some in-house DBG code which is not useful, replace with
pr_debug() instead.

Hanjun Guo (18):
  ACPI: cmos_rtc: Using pr_fmt() and remove PREFIX
  ACPI: blacklist: Unify the message printing
  ACPI: bus: Use pr_*() macros to replace printk()
  ACPI: event: Use pr_*() macros to replace printk()
  ACPI: glue: Clean up the printing messages
  ACPI: nvs: Unify the message printing
  ACPI: osl: Remove the duplicated PREFIX for message printing
  ACPI: pci_root: Unify the message printing
  ACPI: processor_thermal: Remove unused PREFIX for printing
  ACPI: processor_perflib: Cleanup print messages
  ACPI: processor_throttling: Cleanup the printing messages
  ACPI: reboot: Unify the message printing
  ACPI: sysfs: Cleanup message printing
  ACPI: sbshc: Unify the message printing
  ACPI: scan: Unify the log message printing
  ACPI: sbs: Unify the message printing
  ACPI: sleep: Unify the message printing
  ACPI: Remove the macro PREFIX "ACPI: "

 drivers/acpi/acpi_cmos_rtc.c        |  6 ++--
 drivers/acpi/blacklist.c            |  9 +++---
 drivers/acpi/bus.c                  |  4 +--
 drivers/acpi/event.c                |  6 ++--
 drivers/acpi/glue.c                 | 29 ++++++------------
 drivers/acpi/internal.h             |  2 --
 drivers/acpi/nvs.c                  |  8 +++--
 drivers/acpi/osl.c                  |  4 +--
 drivers/acpi/pci_root.c             |  4 ++-
 drivers/acpi/processor_perflib.c    | 38 +++++++++++------------
 drivers/acpi/processor_thermal.c    |  2 --
 drivers/acpi/processor_throttling.c | 60 ++++++++++++++++---------------------
 drivers/acpi/reboot.c               |  4 ++-
 drivers/acpi/sbs.c                  | 12 ++++----
 drivers/acpi/sbshc.c                |  8 ++---
 drivers/acpi/scan.c                 | 11 +++----
 drivers/acpi/sleep.c                | 18 +++++------
 drivers/acpi/sysfs.c                |  8 ++---
 18 files changed, 109 insertions(+), 124 deletions(-)

-- 
1.7.12.4

