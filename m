Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817452C8B79
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 18:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgK3Rkw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 12:40:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8221 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgK3Rku (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2020 12:40:50 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ClCCf5mLVzkjgD;
        Tue,  1 Dec 2020 01:39:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 01:39:50 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <maz@kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <dwagner@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v4 3/5] ACPI: Drop acpi_dev_irqresource_disabled()
Date:   Tue, 1 Dec 2020 01:35:57 +0800
Message-ID: <1606757759-6076-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606757759-6076-1-git-send-email-john.garry@huawei.com>
References: <1606757759-6076-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The functionality of acpi_dev_irqresource_disabled() is same as in common
irqresource_disabled(), so drop acpi_dev_irqresource_disabled() in favour
of that function.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/acpi/resource.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ad04824ca3ba..58203193417e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -380,13 +380,6 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
 
-static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
-{
-	res->start = gsi;
-	res->end = gsi;
-	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
-}
-
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
 				     bool legacy)
@@ -394,7 +387,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	int irq, p, t;
 
 	if (!valid_IRQ(gsi)) {
-		acpi_dev_irqresource_disabled(res, gsi);
+		irqresource_disabled(res, gsi);
 		return;
 	}
 
@@ -426,7 +419,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 		res->start = irq;
 		res->end = irq;
 	} else {
-		acpi_dev_irqresource_disabled(res, gsi);
+		irqresource_disabled(res, gsi);
 	}
 }
 
@@ -463,7 +456,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 		 */
 		irq = &ares->data.irq;
 		if (index >= irq->interrupt_count) {
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 			return false;
 		}
 		acpi_dev_get_irqresource(res, irq->interrupts[index],
@@ -473,7 +466,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		ext_irq = &ares->data.extended_irq;
 		if (index >= ext_irq->interrupt_count) {
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 			return false;
 		}
 		if (is_gsi(ext_irq))
@@ -481,7 +474,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 					 ext_irq->triggering, ext_irq->polarity,
 					 ext_irq->shareable, false);
 		else
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 		break;
 	default:
 		res->flags = 0;
-- 
2.26.2

