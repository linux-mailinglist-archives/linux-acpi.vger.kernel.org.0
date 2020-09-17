Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE9026D600
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIQILv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:11:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35398 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgIQIDs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:03:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 89362DC748F08AE1FE1D;
        Thu, 17 Sep 2020 15:47:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:50 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 14/25] ACPI: PCI: Remove the unused ACPICA debug code
Date:   Thu, 17 Sep 2020 15:38:54 +0800
Message-ID: <1600328345-27627-15-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPICA debug code is not used, so can be removed.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/pci_root.c | 2 --
 drivers/acpi/pci_slot.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f90e841..7a6abd3 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -24,8 +24,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT		ACPI_PCI_COMPONENT
-ACPI_MODULE_NAME("pci_root");
 #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
 #define ACPI_PCI_ROOT_DEVICE_NAME	"PCI Root Bridge"
 static int acpi_pci_root_add(struct acpi_device *device,
diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index ca2461d..d6cb2c2 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -28,9 +28,6 @@
 
 static int check_sta_before_sun;
 
-#define _COMPONENT		ACPI_PCI_COMPONENT
-ACPI_MODULE_NAME("pci_slot");
-
 #define SLOT_NAME_SIZE 21		/* Inspired by #define in acpiphp.h */
 
 struct acpi_pci_slot {
-- 
1.7.12.4

