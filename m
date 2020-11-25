Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4292C4698
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbgKYRYu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 12:24:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8585 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgKYRYu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 12:24:50 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ch76X2gxzzLtmw;
        Thu, 26 Nov 2020 01:24:20 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 01:24:39 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <maz@kernel.org>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v3 4/5] Driver core: platform: Add devm_platform_get_irqs_affinity()
Date:   Thu, 26 Nov 2020 01:20:40 +0800
Message-ID: <1606324841-217570-5-git-send-email-john.garry@huawei.com>
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

Drivers for multi-queue platform devices may also want managed interrupts
for handling HW queue completion interrupts, so add support.

The function accepts an affinity descriptor pointer, which covers a set
of irqs for the device.

The reason a devm method is added - as opposed to non-devm - is because the
only current in-tree user will also use devm method for requesting the
interrupts; as such, the function is made as devm as it can ensure ordering
of freeing the irq and disposing of the mapping.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/base/platform.c         | 114 +++++++++++++++++++++++++++++++-
 include/linux/platform_device.h |   6 ++
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3eeda3746701..08f4175c4ac8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -15,6 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/memblock.h>
 #include <linux/err.h>
@@ -289,7 +290,7 @@ int platform_irq_count(struct platform_device *dev)
 }
 EXPORT_SYMBOL_GPL(platform_irq_count);
 
-void platform_put_irq(struct platform_device *dev, unsigned int num)
+static void platform_put_irq(struct platform_device *dev, unsigned int num)
 {
 	unsigned int virq = platform_get_irq(dev, num);
 
@@ -303,6 +304,117 @@ void platform_put_irq(struct platform_device *dev, unsigned int num)
 	}
 }
 
+struct irq_affinity_devres {
+	unsigned int count;
+	void *dev_id;
+	unsigned int irq[];
+};
+
+static void devm_platform_get_irqs_affinity_release(struct device *dev,
+						    void *res)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct irq_affinity_devres *ptr = res;
+	int i;
+
+	for (i = 0; i < ptr->count; i++)
+		platform_put_irq(pdev, i);
+}
+
+/**
+ * devm_platform_get_irqs_affinity - devm method to get a set of IRQs for a
+ *				device using an interrupt affinity descriptor
+ * @dev: platform device pointer
+ * @affd: affinity descriptor
+ * @minvec: minimum count of interrupt vectors
+ * @maxvec: maximum count of interrupt vectors
+ * @irqs: pointer holder for IRQ numbers
+ *
+ * Gets a set of IRQs for a platform device, and updates IRQ afffinty according
+ * to the passed affinity descriptor
+ *
+ * Return: Number of vectors on success, negative error number on failure.
+ */
+int devm_platform_get_irqs_affinity(struct platform_device *dev,
+				    struct irq_affinity *affd,
+				    unsigned int minvec,
+				    unsigned int maxvec,
+				    int **irqs)
+{
+	struct irq_affinity_devres *ptr;
+	struct irq_affinity_desc *desc;
+	size_t size;
+	int i, ret, nvec;
+
+	if (!affd)
+		return -EPERM;
+
+	if (maxvec < minvec)
+		return -ERANGE;
+
+	nvec = platform_irq_count(dev);
+
+	if (nvec < minvec)
+		return -ENOSPC;
+
+	if (nvec <= affd->pre_vectors + affd->post_vectors)
+		return -EIO;
+
+	nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
+	if (nvec < minvec)
+		return -ENOSPC;
+
+	if (nvec > maxvec)
+		nvec = maxvec;
+
+	size = sizeof(*ptr) + sizeof(unsigned int) * nvec;
+	ptr = devres_alloc(devm_platform_get_irqs_affinity_release, size,
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ptr->count = nvec;
+
+	for (i = 0; i < nvec; i++) {
+		int irq = platform_get_irq(dev, i);
+		if (irq < 0) {
+			ret = irq;
+			goto err_free_devres;
+		}
+		ptr->irq[i] = irq;
+	}
+
+	desc = irq_create_affinity_masks(nvec, affd);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto err_free_devres;
+	}
+
+	for (i = 0; i < nvec; i++) {
+		ret = irq_update_affinity_desc(ptr->irq[i], &desc[i]);
+		if (ret) {
+			dev_err(&dev->dev, "failed to update irq%d affinity descriptor (%d)\n",
+				ptr->irq[i], ret);
+			goto err_free_desc;
+		}
+	}
+
+	devres_add(&dev->dev, ptr);
+
+	kfree(desc);
+
+	*irqs = ptr->irq;
+
+	return nvec;
+
+err_free_desc:
+	kfree(desc);
+err_free_devres:
+	devres_free(ptr);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_platform_get_irqs_affinity);
+
 /**
  * platform_get_resource_byname - get a resource for a device by name
  * @dev: platform device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 77a2aada106d..4d75633e6735 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -15,6 +15,7 @@
 #define PLATFORM_DEVID_NONE	(-1)
 #define PLATFORM_DEVID_AUTO	(-2)
 
+struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
@@ -70,6 +71,11 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);
+extern int devm_platform_get_irqs_affinity(struct platform_device *dev,
+					   struct irq_affinity *affd,
+					   unsigned int minvec,
+					   unsigned int maxvec,
+					   int **irqs);
 extern struct resource *platform_get_resource_byname(struct platform_device *,
 						     unsigned int,
 						     const char *);
-- 
2.26.2

