Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB62CBAC7
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 11:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbgLBKll (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 05:41:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8490 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388620AbgLBKll (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 05:41:41 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CmFqS54jczhlkn;
        Wed,  2 Dec 2020 18:40:36 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 18:40:48 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <maz@kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <dwagner@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v5 2/5] resource: Add irqresource_disabled()
Date:   Wed, 2 Dec 2020 18:36:54 +0800
Message-ID: <1606905417-183214-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a common function to set the fields for a irq resource to disabled,
which mimics what is done in acpi_dev_irqresource_disabled(), with a view
to replace that function.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/ioport.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5135d4b86cd6..f9bf374f9633 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -307,6 +307,13 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 struct resource *request_free_mem_region(struct resource *base,
 		unsigned long size, const char *name);
 
+static inline void irqresource_disabled(struct resource *res, u32 irq)
+{
+	res->start = irq;
+	res->end = irq;
+	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
+}
+
 #ifdef CONFIG_IO_STRICT_DEVMEM
 void revoke_devmem(struct resource *res);
 #else
-- 
2.26.2

