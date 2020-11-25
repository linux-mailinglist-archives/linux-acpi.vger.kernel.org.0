Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963C32C46A1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 18:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgKYRYz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 12:24:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8036 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbgKYRYy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 12:24:54 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ch76f4sSDzhc0Z;
        Thu, 26 Nov 2020 01:24:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 01:24:38 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <maz@kernel.org>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v3 2/5] ACPI: Make acpi_dev_irqresource_disabled() public
Date:   Thu, 26 Nov 2020 01:20:38 +0800
Message-ID: <1606324841-217570-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606324841-217570-1-git-send-email-john.garry@huawei.com>
References: <1606324841-217570-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

To allow the platform device to "put" an irq, make the function to reset
an ACPI companion device irq resource public.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/acpi/resource.c | 2 +-
 include/linux/acpi.h    | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ad04824ca3ba..0999a98cab3c 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -380,7 +380,7 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
 
-static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
+void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
 {
 	res->start = gsi;
 	res->end = gsi;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 39263c6b52e1..d5101e36a645 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -467,6 +467,7 @@ bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
 					 struct resource_win *win);
 unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable);
 unsigned int acpi_dev_get_irq_type(int triggering, int polarity);
+void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi);
 bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 				 struct resource *res);
 
@@ -939,6 +940,10 @@ static inline struct acpi_device *acpi_resource_consumer(struct resource *res)
 	return NULL;
 }
 
+static inline void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
+{
+}
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
-- 
2.26.2

