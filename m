Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A762C46A0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 18:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbgKYRYz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 12:24:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8035 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731278AbgKYRYx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 12:24:53 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ch76f57gkzhcWr;
        Thu, 26 Nov 2020 01:24:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 01:24:37 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <maz@kernel.org>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v3 1/5] genirq/affinity: Add irq_update_affinity_desc()
Date:   Thu, 26 Nov 2020 01:20:37 +0800
Message-ID: <1606324841-217570-2-git-send-email-john.garry@huawei.com>
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

Add a function to allow the affinity of an interrupt be switched to
managed, such that interrupts allocated for platform devices may be
managed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/interrupt.h |  8 +++++
 kernel/irq/manage.c       | 63 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ee8299eb1f52..870b3251e174 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -352,6 +352,8 @@ extern int irq_can_set_affinity(unsigned int irq);
 extern int irq_select_affinity(unsigned int irq);
 
 extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
+extern int irq_update_affinity_desc(unsigned int irq,
+				    struct irq_affinity_desc *affinity);
 
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
@@ -387,6 +389,12 @@ static inline int irq_set_affinity_hint(unsigned int irq,
 	return -EINVAL;
 }
 
+static inline int irq_update_affinity_desc(unsigned int irq,
+					   struct irq_affinity_desc *affinity)
+{
+	return -EINVAL;
+}
+
 static inline int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 {
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c460e0496006..8201aff639f7 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -371,6 +371,69 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	return ret;
 }
 
+/**
+ * irq_update_affinity_desc - Update affinity management for an interrupt
+ * @irq:	The interrupt number to update
+ * @affinity:	Pointer to the affinity descriptor
+ *
+ * This interface can be used to configure the affinity management of
+ * interrupts which have been allocated already.
+ */
+int irq_update_affinity_desc(unsigned int irq,
+			     struct irq_affinity_desc *affinity)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+	bool activated;
+	int ret = 0;
+
+	/*
+	 * Supporting this with the reservation scheme used by x86 needs
+	 * some more thought. Fail it for now.
+	 */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
+		return -EOPNOTSUPP;
+
+	desc = irq_get_desc_buslock(irq, &flags, 0);
+	if (!desc)
+		return -EINVAL;
+
+	/* Requires the interrupt to be shut down */
+	if (irqd_is_started(&desc->irq_data)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/* Interrupts which are already managed cannot be modified */
+	if (irqd_affinity_is_managed(&desc->irq_data)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/*
+	 * Deactivate the interrupt. That's required to undo
+	 * anything an earlier activation has established.
+	 */
+	activated = irqd_is_activated(&desc->irq_data);
+	if (activated)
+		irq_domain_deactivate_irq(&desc->irq_data);
+
+	if (affinity->is_managed) {
+		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
+		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
+	}
+
+	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
+
+	/* Restore the activation state */
+	if (activated)
+		irq_domain_deactivate_irq(&desc->irq_data);
+
+out_unlock:
+	irq_put_desc_busunlock(desc, flags);
+	return ret;
+}
+
 int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-- 
2.26.2

