Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079493517C9
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 19:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhDARmr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 13:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbhDARhB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 13:37:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5CCC02D55B
        for <linux-acpi@vger.kernel.org>; Thu,  1 Apr 2021 08:48:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x16so2296444wrn.4
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2021 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlFSa/zqTNwpFZebOatz2euTYpbVsT3TnaPQDnNRfCY=;
        b=CNyf8sCo/zIsiSncH+8CpPI2jFgHmg0K0n4dxY1wP+UVae78e3C0u5oP/qCJaMxYJi
         xL5VP6g00agYHYH5ynTfEYf6mF/KXZXJ6fLdSaRqEK9rOfS97gxnUBya0XCSquKeLnza
         TOEl+J0J2RtVjeSrK639bSbNbtSK4M3xwTltGacbdTn5ql6AdQo1yGQpWxEFvdSFW8wO
         7YwOkgCgsm3bcW7Fd9Aj0W+BJzdx+bySZ8os3sOPywd2coVmZBr5TBan7p3qLIaAyGV5
         BasPgtcqZuos/tPBeXZac8bsOzPN4/X45KXggPK+pUuxi1B0gu0z62oyzcchS84kQ3pC
         W/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlFSa/zqTNwpFZebOatz2euTYpbVsT3TnaPQDnNRfCY=;
        b=W8Xg0p+jb7rz9vGQtx0VvgnLW0RZQAhPmSyhx9Y6aNQBwWKS0d4OtsMyyHAduQw/a0
         EId8jVT1j7mKvx4pkH6+/MqqRmXj0K9Rc/zCfmL9QG1NRFA33LSAnO45mtBJoA4MKbUE
         CIfiU9OopsWyRiaOHXaStuHFjpJ1ZqTh0cEzVLh2ou5D4g8tlWtbuW7lgDIfSt0qyI2M
         YH93vdU/vKL73qvGY9ikwgXsiguZn6vJuM7sceoabcC5lFUOaZ3FP2JdhveRW3KlKH/f
         6sBVwfdQNR2HESzis6zIl6UaCfLXDOPbmoiBQfz1Jpx4kzcIXkoT/AXuZIkm1CIuopua
         bxUQ==
X-Gm-Message-State: AOAM533HWXBMqkE0/rE8I/lAHzpAWaYQSB6Hq6AjYQAyLYKmWF8j9mBj
        HY4cgD1HV65SuaVkbDPmr/RsyA==
X-Google-Smtp-Source: ABdhPJzt/pZIzY5/VtqgYTxe9hFgZ++PadCzw7BEecdiJen/HxdrAfXz29XGzpNVejBfmbPMAqhH6g==
X-Received: by 2002:a5d:6c6a:: with SMTP id r10mr10529432wrz.42.1617292099592;
        Thu, 01 Apr 2021 08:48:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:48:19 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v14 06/10] iommu: Add a page fault handler
Date:   Thu,  1 Apr 2021 17:47:15 +0200
Message-Id: <20210401154718.307519-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some systems allow devices to handle I/O Page Faults in the core mm. For
example systems implementing the PCIe PRI extension or Arm SMMU stall
model. Infrastructure for reporting these recoverable page faults was
added to the IOMMU core by commit 0c830e6b3282 ("iommu: Introduce device
fault report API"). Add a page fault handler for host SVA.

IOMMU driver can now instantiate several fault workqueues and link them
to IOPF-capable devices. Drivers can choose between a single global
workqueue, one per IOMMU device, one per low-level fault queue, one per
domain, etc.

When it receives a fault event, most commonly in an IRQ handler, the
IOMMU driver reports the fault using iommu_report_device_fault(), which
calls the registered handler. The page fault handler then calls the mm
fault handler, and reports either success or failure with
iommu_page_response(). After the handler succeeds, the hardware retries
the access.

The iopf_param pointer could be embedded into iommu_fault_param. But
putting iopf_param into the iommu_param structure allows us not to care
about ordering between calls to iopf_queue_add_device() and
iommu_register_device_fault_handler().

Tested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Makefile        |   1 +
 drivers/iommu/iommu-sva-lib.h |  53 ++++
 include/linux/iommu.h         |   2 +
 drivers/iommu/io-pgfault.c    | 461 ++++++++++++++++++++++++++++++++++
 4 files changed, 517 insertions(+)
 create mode 100644 drivers/iommu/io-pgfault.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 61bd30cd8369..60fafc23dee6 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o
+obj-$(CONFIG_IOMMU_SVA_LIB) += io-pgfault.o
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index b40990aef3fd..031155010ca8 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -12,4 +12,57 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
 void iommu_sva_free_pasid(struct mm_struct *mm);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
 
+/* I/O Page fault */
+struct device;
+struct iommu_fault;
+struct iopf_queue;
+
+#ifdef CONFIG_IOMMU_SVA_LIB
+int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
+
+int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
+int iopf_queue_remove_device(struct iopf_queue *queue,
+			     struct device *dev);
+int iopf_queue_flush_dev(struct device *dev);
+struct iopf_queue *iopf_queue_alloc(const char *name);
+void iopf_queue_free(struct iopf_queue *queue);
+int iopf_queue_discard_partial(struct iopf_queue *queue);
+
+#else /* CONFIG_IOMMU_SVA_LIB */
+static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
+{
+	return -ENODEV;
+}
+
+static inline int iopf_queue_add_device(struct iopf_queue *queue,
+					struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline int iopf_queue_remove_device(struct iopf_queue *queue,
+					   struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline int iopf_queue_flush_dev(struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline struct iopf_queue *iopf_queue_alloc(const char *name)
+{
+	return NULL;
+}
+
+static inline void iopf_queue_free(struct iopf_queue *queue)
+{
+}
+
+static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_IOMMU_SVA_LIB */
 #endif /* _IOMMU_SVA_LIB_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 45c4eb372f56..86d688c4418f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -367,6 +367,7 @@ struct iommu_fault_param {
  * struct dev_iommu - Collection of per-device IOMMU data
  *
  * @fault_param: IOMMU detected device fault reporting data
+ * @iopf_param:	 I/O Page Fault queue and data
  * @fwspec:	 IOMMU fwspec data
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
@@ -377,6 +378,7 @@ struct iommu_fault_param {
 struct dev_iommu {
 	struct mutex lock;
 	struct iommu_fault_param	*fault_param;
+	struct iopf_device_param	*iopf_param;
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
new file mode 100644
index 000000000000..1df8c1dcae77
--- /dev/null
+++ b/drivers/iommu/io-pgfault.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handle device page faults
+ *
+ * Copyright (C) 2020 ARM Ltd.
+ */
+
+#include <linux/iommu.h>
+#include <linux/list.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#include "iommu-sva-lib.h"
+
+/**
+ * struct iopf_queue - IO Page Fault queue
+ * @wq: the fault workqueue
+ * @devices: devices attached to this queue
+ * @lock: protects the device list
+ */
+struct iopf_queue {
+	struct workqueue_struct		*wq;
+	struct list_head		devices;
+	struct mutex			lock;
+};
+
+/**
+ * struct iopf_device_param - IO Page Fault data attached to a device
+ * @dev: the device that owns this param
+ * @queue: IOPF queue
+ * @queue_list: index into queue->devices
+ * @partial: faults that are part of a Page Request Group for which the last
+ *           request hasn't been submitted yet.
+ */
+struct iopf_device_param {
+	struct device			*dev;
+	struct iopf_queue		*queue;
+	struct list_head		queue_list;
+	struct list_head		partial;
+};
+
+struct iopf_fault {
+	struct iommu_fault		fault;
+	struct list_head		list;
+};
+
+struct iopf_group {
+	struct iopf_fault		last_fault;
+	struct list_head		faults;
+	struct work_struct		work;
+	struct device			*dev;
+};
+
+static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
+			       enum iommu_page_response_code status)
+{
+	struct iommu_page_response resp = {
+		.version		= IOMMU_PAGE_RESP_VERSION_1,
+		.pasid			= iopf->fault.prm.pasid,
+		.grpid			= iopf->fault.prm.grpid,
+		.code			= status,
+	};
+
+	if ((iopf->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) &&
+	    (iopf->fault.prm.flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID))
+		resp.flags = IOMMU_PAGE_RESP_PASID_VALID;
+
+	return iommu_page_response(dev, &resp);
+}
+
+static enum iommu_page_response_code
+iopf_handle_single(struct iopf_fault *iopf)
+{
+	vm_fault_t ret;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned int access_flags = 0;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_page_request *prm = &iopf->fault.prm;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
+
+	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
+		return status;
+
+	mm = iommu_sva_find(prm->pasid);
+	if (IS_ERR_OR_NULL(mm))
+		return status;
+
+	mmap_read_lock(mm);
+
+	vma = find_extend_vma(mm, prm->addr);
+	if (!vma)
+		/* Unmapped area */
+		goto out_put_mm;
+
+	if (prm->perm & IOMMU_FAULT_PERM_READ)
+		access_flags |= VM_READ;
+
+	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
+		access_flags |= VM_WRITE;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
+		access_flags |= VM_EXEC;
+		fault_flags |= FAULT_FLAG_INSTRUCTION;
+	}
+
+	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
+		fault_flags |= FAULT_FLAG_USER;
+
+	if (access_flags & ~vma->vm_flags)
+		/* Access fault */
+		goto out_put_mm;
+
+	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
+	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
+		IOMMU_PAGE_RESP_SUCCESS;
+
+out_put_mm:
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	return status;
+}
+
+static void iopf_handle_group(struct work_struct *work)
+{
+	struct iopf_group *group;
+	struct iopf_fault *iopf, *next;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
+
+	group = container_of(work, struct iopf_group, work);
+
+	list_for_each_entry_safe(iopf, next, &group->faults, list) {
+		/*
+		 * For the moment, errors are sticky: don't handle subsequent
+		 * faults in the group if there is an error.
+		 */
+		if (status == IOMMU_PAGE_RESP_SUCCESS)
+			status = iopf_handle_single(iopf);
+
+		if (!(iopf->fault.prm.flags &
+		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
+			kfree(iopf);
+	}
+
+	iopf_complete_group(group->dev, &group->last_fault, status);
+	kfree(group);
+}
+
+/**
+ * iommu_queue_iopf - IO Page Fault handler
+ * @fault: fault event
+ * @cookie: struct device, passed to iommu_register_device_fault_handler.
+ *
+ * Add a fault to the device workqueue, to be handled by mm.
+ *
+ * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
+ * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
+ * expect a response. It may be generated when disabling a PASID (issuing a
+ * PASID stop request) by some PCI devices.
+ *
+ * The PASID stop request is issued by the device driver before unbind(). Once
+ * it completes, no page request is generated for this PASID anymore and
+ * outstanding ones have been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1
+ * and 10.4.1.2 - Managing PASID TLP Prefix Usage). Some PCI devices will wait
+ * for all outstanding page requests to come back with a response before
+ * completing the PASID stop request. Others do not wait for page responses, and
+ * instead issue this Stop Marker that tells us when the PASID can be
+ * reallocated.
+ *
+ * It is safe to discard the Stop Marker because it is an optimization.
+ * a. Page requests, which are posted requests, have been flushed to the IOMMU
+ *    when the stop request completes.
+ * b. The IOMMU driver flushes all fault queues on unbind() before freeing the
+ *    PASID.
+ *
+ * So even though the Stop Marker might be issued by the device *after* the stop
+ * request completes, outstanding faults will have been dealt with by the time
+ * the PASID is freed.
+ *
+ * Return: 0 on success and <0 on error.
+ */
+int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
+{
+	int ret;
+	struct iopf_group *group;
+	struct iopf_fault *iopf, *next;
+	struct iopf_device_param *iopf_param;
+
+	struct device *dev = cookie;
+	struct dev_iommu *param = dev->iommu;
+
+	lockdep_assert_held(&param->lock);
+
+	if (fault->type != IOMMU_FAULT_PAGE_REQ)
+		/* Not a recoverable page fault */
+		return -EOPNOTSUPP;
+
+	/*
+	 * As long as we're holding param->lock, the queue can't be unlinked
+	 * from the device and therefore cannot disappear.
+	 */
+	iopf_param = param->iopf_param;
+	if (!iopf_param)
+		return -ENODEV;
+
+	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
+		iopf = kzalloc(sizeof(*iopf), GFP_KERNEL);
+		if (!iopf)
+			return -ENOMEM;
+
+		iopf->fault = *fault;
+
+		/* Non-last request of a group. Postpone until the last one */
+		list_add(&iopf->list, &iopf_param->partial);
+
+		return 0;
+	}
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	if (!group) {
+		/*
+		 * The caller will send a response to the hardware. But we do
+		 * need to clean up before leaving, otherwise partial faults
+		 * will be stuck.
+		 */
+		ret = -ENOMEM;
+		goto cleanup_partial;
+	}
+
+	group->dev = dev;
+	group->last_fault.fault = *fault;
+	INIT_LIST_HEAD(&group->faults);
+	list_add(&group->last_fault.list, &group->faults);
+	INIT_WORK(&group->work, iopf_handle_group);
+
+	/* See if we have partial faults for this group */
+	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
+		if (iopf->fault.prm.grpid == fault->prm.grpid)
+			/* Insert *before* the last fault */
+			list_move(&iopf->list, &group->faults);
+	}
+
+	queue_work(iopf_param->queue->wq, &group->work);
+	return 0;
+
+cleanup_partial:
+	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
+		if (iopf->fault.prm.grpid == fault->prm.grpid) {
+			list_del(&iopf->list);
+			kfree(iopf);
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_queue_iopf);
+
+/**
+ * iopf_queue_flush_dev - Ensure that all queued faults have been processed
+ * @dev: the endpoint whose faults need to be flushed.
+ *
+ * The IOMMU driver calls this before releasing a PASID, to ensure that all
+ * pending faults for this PASID have been handled, and won't hit the address
+ * space of the next process that uses this PASID. The driver must make sure
+ * that no new fault is added to the queue. In particular it must flush its
+ * low-level queue before calling this function.
+ *
+ * Return: 0 on success and <0 on error.
+ */
+int iopf_queue_flush_dev(struct device *dev)
+{
+	int ret = 0;
+	struct iopf_device_param *iopf_param;
+	struct dev_iommu *param = dev->iommu;
+
+	if (!param)
+		return -ENODEV;
+
+	mutex_lock(&param->lock);
+	iopf_param = param->iopf_param;
+	if (iopf_param)
+		flush_workqueue(iopf_param->queue->wq);
+	else
+		ret = -ENODEV;
+	mutex_unlock(&param->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
+
+/**
+ * iopf_queue_discard_partial - Remove all pending partial fault
+ * @queue: the queue whose partial faults need to be discarded
+ *
+ * When the hardware queue overflows, last page faults in a group may have been
+ * lost and the IOMMU driver calls this to discard all partial faults. The
+ * driver shouldn't be adding new faults to this queue concurrently.
+ *
+ * Return: 0 on success and <0 on error.
+ */
+int iopf_queue_discard_partial(struct iopf_queue *queue)
+{
+	struct iopf_fault *iopf, *next;
+	struct iopf_device_param *iopf_param;
+
+	if (!queue)
+		return -EINVAL;
+
+	mutex_lock(&queue->lock);
+	list_for_each_entry(iopf_param, &queue->devices, queue_list) {
+		list_for_each_entry_safe(iopf, next, &iopf_param->partial,
+					 list) {
+			list_del(&iopf->list);
+			kfree(iopf);
+		}
+	}
+	mutex_unlock(&queue->lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_discard_partial);
+
+/**
+ * iopf_queue_add_device - Add producer to the fault queue
+ * @queue: IOPF queue
+ * @dev: device to add
+ *
+ * Return: 0 on success and <0 on error.
+ */
+int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
+{
+	int ret = -EBUSY;
+	struct iopf_device_param *iopf_param;
+	struct dev_iommu *param = dev->iommu;
+
+	if (!param)
+		return -ENODEV;
+
+	iopf_param = kzalloc(sizeof(*iopf_param), GFP_KERNEL);
+	if (!iopf_param)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&iopf_param->partial);
+	iopf_param->queue = queue;
+	iopf_param->dev = dev;
+
+	mutex_lock(&queue->lock);
+	mutex_lock(&param->lock);
+	if (!param->iopf_param) {
+		list_add(&iopf_param->queue_list, &queue->devices);
+		param->iopf_param = iopf_param;
+		ret = 0;
+	}
+	mutex_unlock(&param->lock);
+	mutex_unlock(&queue->lock);
+
+	if (ret)
+		kfree(iopf_param);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_add_device);
+
+/**
+ * iopf_queue_remove_device - Remove producer from fault queue
+ * @queue: IOPF queue
+ * @dev: device to remove
+ *
+ * Caller makes sure that no more faults are reported for this device.
+ *
+ * Return: 0 on success and <0 on error.
+ */
+int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
+{
+	int ret = -EINVAL;
+	struct iopf_fault *iopf, *next;
+	struct iopf_device_param *iopf_param;
+	struct dev_iommu *param = dev->iommu;
+
+	if (!param || !queue)
+		return -EINVAL;
+
+	mutex_lock(&queue->lock);
+	mutex_lock(&param->lock);
+	iopf_param = param->iopf_param;
+	if (iopf_param && iopf_param->queue == queue) {
+		list_del(&iopf_param->queue_list);
+		param->iopf_param = NULL;
+		ret = 0;
+	}
+	mutex_unlock(&param->lock);
+	mutex_unlock(&queue->lock);
+	if (ret)
+		return ret;
+
+	/* Just in case some faults are still stuck */
+	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list)
+		kfree(iopf);
+
+	kfree(iopf_param);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_remove_device);
+
+/**
+ * iopf_queue_alloc - Allocate and initialize a fault queue
+ * @name: a unique string identifying the queue (for workqueue)
+ *
+ * Return: the queue on success and NULL on error.
+ */
+struct iopf_queue *iopf_queue_alloc(const char *name)
+{
+	struct iopf_queue *queue;
+
+	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
+	if (!queue)
+		return NULL;
+
+	/*
+	 * The WQ is unordered because the low-level handler enqueues faults by
+	 * group. PRI requests within a group have to be ordered, but once
+	 * that's dealt with, the high-level function can handle groups out of
+	 * order.
+	 */
+	queue->wq = alloc_workqueue("iopf_queue/%s", WQ_UNBOUND, 0, name);
+	if (!queue->wq) {
+		kfree(queue);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&queue->devices);
+	mutex_init(&queue->lock);
+
+	return queue;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_alloc);
+
+/**
+ * iopf_queue_free - Free IOPF queue
+ * @queue: queue to free
+ *
+ * Counterpart to iopf_queue_alloc(). The driver must not be queuing faults or
+ * adding/removing devices on this queue anymore.
+ */
+void iopf_queue_free(struct iopf_queue *queue)
+{
+	struct iopf_device_param *iopf_param, *next;
+
+	if (!queue)
+		return;
+
+	list_for_each_entry_safe(iopf_param, next, &queue->devices, queue_list)
+		iopf_queue_remove_device(queue, iopf_param->dev);
+
+	destroy_workqueue(queue->wq);
+	kfree(queue);
+}
+EXPORT_SYMBOL_GPL(iopf_queue_free);
-- 
2.31.1

