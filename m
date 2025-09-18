Return-Path: <linux-acpi+bounces-17001-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACE9B58F77
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 09:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405F11BC488A
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 07:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC66F2EBDC2;
	Tue, 16 Sep 2025 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seoqjGSf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2742E9EA0;
	Tue, 16 Sep 2025 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008717; cv=none; b=GhOvfnoRHhcCSOEgj+gTCB6xP5O+zXt0hgndVt/IzJY7wWHcbUkEts/XgfGY0SStttX9YE8iNOI9M6odrZxU6qP9MtDxFycYLLohLeiiaZg/qqrdr5FbYJRiv4UDrwBgy5Jn5G1pvG+qci5Z2aGOmjAOcv3ML7UShRYME3Ef5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008717; c=relaxed/simple;
	bh=TDPjKbP6JuxBf+E8pj9xVBmtW5mDyqaBa2s3+wF1yxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRi0X55V+9+YLJuMAXovlhvHsvLfJdN3+vN8/uQBq5hswdW7KRCM3HHhVgDJQGfsAx611FRMKm4HdchhMQ46dqDJJq+T3f29yelvh+ffX5Qzb2Zsqwb/TYkKeUaK9g9ANaYihiTvm3zgGrxpOmw1L2jykqKXCTCXkH3N34BwZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seoqjGSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAA3C113D0;
	Tue, 16 Sep 2025 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758008717;
	bh=TDPjKbP6JuxBf+E8pj9xVBmtW5mDyqaBa2s3+wF1yxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=seoqjGSfcad+F4LQlY4eypPy7RmGTApX8ESLhazqzEN1HqQT31hDXGjAN+ZV0YC82
	 l8J7wJ6sNdBc1Dqg/ONUUBlJ5WGVZNdLKxmjQpay4BFTwlU52E1GUGaAsmZwUCTxmM
	 HgWiKrQtvKegIxpfvR6+899VfqhZSoZVHYBYTl3owjcsBibjXIeyBn1U3vfToX2erT
	 nlNetMwECfwqULyQTTmrliyQ7t8HlFc8fvyNC2xlfFt2SS5PIkKQO45CH45JXSQnww
	 LHVWVcKzhxcqXP/JFfcRujFiDGFlcqW8QuNtOCyjtfLTXWG1W3rBub25RAId2LQEEj
	 TNAlua9tSPk5Q==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 00:45:11 -0700
Subject: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
In-Reply-To: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

After the list of preserved devices is constructed, the PCI subsystem can
now forward the liveupdate request to the driver.

The PCI subsystem saves and restores a u64 data from LUO callback. For
each device, the PCI subsystem preserve a "dev_state" struct, which
contains the path (domain + bus + devfn) and a per device u64 data.

The device driver will use such a u64 data area to store the device driver
state. The device live update callback looks very similar to the LUO
subsystem callback, with the "void *arg" change to "struct device *dev".

In the prepare callback, the PCI subsystem allocates then preserves a
folio big enough to hold all requested device state (struct pci_dev_ser)
in an array and the count.

The PCI sub system will just forward the liveupdate call back with u64
data point to the u64 field of the device state array.

If some device fails the prepare callback, all previous devices that
already successfully finished the prepare call back will get the cancel
call back to clean up the saved state. That clean up is the special case
that not the full list will be walked.

In other live update callbacks, all the devices in the preserved device
list will get the callback with their own u64 data field.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c       | 203 +++++++++++++++++++++++++++++++++++++++--
 include/linux/dev_liveupdate.h |  23 +++++
 include/linux/device/driver.h  |   6 ++
 3 files changed, 223 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index e8891844b8194dabf8d1e8e2d74d9c701bd741ca..2b215c224fb78c908579b0d22be713e1dc7ca21f 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -9,11 +9,25 @@
 #define dev_fmt(fmt) "PCI liveupdate: " fmt
 
 #include <linux/types.h>
+#include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
 #include "pci.h"
 
 #define PCI_SUBSYSTEM_NAME "pci"
 
+static LIST_HEAD(preserved_devices);
+
+struct pci_dev_ser {
+	u32	path;		/* domain + bus + slot + fn */
+	u32	flags;
+	u64	driver_data;	/* driver data */
+};
+
+struct pci_ser {
+	u32 count;
+	struct pci_dev_ser devs[];
+};
+
 static void stack_push_buses(struct list_head *stack, struct list_head *buses)
 {
 	struct pci_bus *bus;
@@ -70,42 +84,213 @@ static int build_liveupdate_devices(struct list_head *head)
 	return count;
 }
 
+static void dev_cleanup_liveupdate(struct device *dev)
+{
+	dev->lu.flags &= ~LU_DEPENDED;
+	list_del_init(&dev->lu.lu_next);
+}
+
 static void cleanup_liveupdate_devices(struct list_head *head)
 {
 	struct device *d, *n;
 
-	list_for_each_entry_safe(d, n, head, lu.lu_next) {
-		d->lu.flags &= ~LU_DEPENDED;
-		list_del_init(&d->lu.lu_next);
+	list_for_each_entry_safe(d, n, head, lu.lu_next)
+		dev_cleanup_liveupdate(d);
+}
+
+static void cleanup_liveupdate_state(struct pci_ser *pci_state)
+{
+	struct folio *folio = virt_to_folio(pci_state);
+
+	kho_unpreserve_folio(folio);
+	folio_put(folio);
+}
+
+static void pci_call_cancel(struct pci_ser *pci_state)
+{
+	struct pci_dev_ser *si = pci_state->devs;
+	struct device *dev, *next;
+
+	list_for_each_entry_safe(dev, next, &preserved_devices, lu.lu_next) {
+		struct pci_dev_ser *s = si++;
+
+		if (!dev->driver)
+			panic("PCI liveupdate cancel: %s has no driver", dev_name(dev));
+		if (!dev->driver->lu)
+			panic("PCI liveupdate cancel: %s driver %s does not support liveupdate",
+			      dev_name(dev), dev->driver->name ? : "(null name)");
+		if (dev->driver->lu->cancel)
+			dev->driver->lu->cancel(dev, s->driver_data);
+		dev_cleanup_liveupdate(dev);
 	}
 }
 
-static int pci_liveupdate_prepare(void *arg, u64 *data)
+static int pci_get_device_path(struct pci_dev *pdev)
+{
+	return (pci_domain_nr(pdev->bus) << 16) | pci_dev_id(pdev);
+}
+
+static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	s->path = pci_get_device_path(pdev);
+	s->flags = dev->lu.flags;
+	return 0;
+}
+
+static int pci_call_prepare(struct pci_ser *pci_state,
+			    struct list_head *devices)
+{
+	struct pci_dev_ser *pdev_state_current = pci_state->devs;
+	struct device *dev, *next;
+	int ret;
+	char *reason;
+
+	list_for_each_entry_safe(dev, next, devices, lu.lu_next) {
+		struct pci_dev_ser *s = pdev_state_current++;
+
+		if (!dev->driver) {
+			reason = "no driver";
+			ret = -ENOENT;
+			goto cancel;
+		}
+		if (!dev->driver->lu) {
+			reason = "driver does not support liveupdate";
+			ret = -EPERM;
+			goto cancel;
+		}
+		ret = pci_save_device_state(dev, s);
+		if (ret) {
+			reason = "save device state failed";
+			goto cancel;
+		}
+		if (dev->driver->lu->prepare) {
+			ret = dev->driver->lu->prepare(dev, &s->driver_data);
+			if (ret) {
+				reason = "prepare() failed";
+				goto cancel;
+			}
+		}
+		list_move_tail(&dev->lu.lu_next, &preserved_devices);
+	}
+	return 0;
+
+cancel:
+	dev_err(dev, "luo prepare failed %d (%s)\n", ret, reason);
+	pci_call_cancel(pci_state);
+	return ret;
+}
+
+static int __pci_liveupdate_prepare(void *arg, u64 *data)
 {
 	LIST_HEAD(requested_devices);
+	struct pci_ser *pci_state;
+	int ret;
+	int count = build_liveupdate_devices(&requested_devices);
+	int size = sizeof(*pci_state) + sizeof(pci_state->devs[0]) * count;
+	int order = get_order(size);
+	struct folio *folio;
 
-	pr_info("prepare data[%llx]\n", *data);
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
+	if (!folio) {
+		ret = -ENOMEM;
+		goto cleanup_device;
+	}
 
-	pci_lock_rescan_remove();
-	down_write(&pci_bus_sem);
+	pci_state = folio_address(folio);
+	pci_state->count = count;
+
+	ret = kho_preserve_folio(folio);
+	if (ret) {
+		pr_err("liveupdate_preserve_folio failed\n");
+		goto release_folio;
+	}
+
+	ret = pci_call_prepare(pci_state, &requested_devices);
+	if (ret)
+		goto unpreserve;
 
-	build_liveupdate_devices(&requested_devices);
+	*data = __pa(pci_state);
+	pr_info("prepare data[%llx]\n", *data);
+	return 0;
+
+unpreserve:
+	kho_unpreserve_folio(folio);
+release_folio:
+	folio_put(folio);
+cleanup_device:
 	cleanup_liveupdate_devices(&requested_devices);
+	return ret;
+}
 
+static int pci_liveupdate_prepare(void *arg, u64 *data)
+{
+	int ret;
+
+	pci_lock_rescan_remove();
+	down_write(&pci_bus_sem);
+	ret = __pci_liveupdate_prepare(arg, data);
 	up_write(&pci_bus_sem);
 	pci_unlock_rescan_remove();
+	return ret;
+}
+
+static int pci_call_freeze(struct pci_ser *pci_state, struct list_head *devlist)
+{
+	struct pci_dev_ser *n = pci_state->devs;
+	struct device *dev;
+	int ret = 0;
+
+	list_for_each_entry(dev, devlist, lu.lu_next) {
+		struct pci_dev_ser *s = n++;
+
+		if (!dev->driver) {
+			if (!dev->parent)
+				continue;
+			panic("PCI liveupdate freeze: %s has no driver", dev_name(dev));
+		}
+		if (!dev->driver->lu->freeze)
+			continue;
+		ret = dev->driver->lu->freeze(dev, &s->driver_data);
+		if (ret) {
+			dev_err(dev, "luo freeze failed %d\n", ret);
+			pci_call_cancel(pci_state);
+			return ret;
+		}
+	}
 	return 0;
 }
 
 static int pci_liveupdate_freeze(void *arg, u64 *data)
 {
+	struct pci_ser *pci_state = phys_to_virt(*data);
+	int ret;
+
 	pr_info("freeze data[%llx]\n", *data);
-	return 0;
+	pci_lock_rescan_remove();
+	down_write(&pci_bus_sem);
+
+	ret = pci_call_freeze(pci_state, &preserved_devices);
+
+	up_write(&pci_bus_sem);
+	pci_unlock_rescan_remove();
+	return ret;
 }
 
 static void pci_liveupdate_cancel(void *arg, u64 data)
 {
+	struct pci_ser *pci_state = phys_to_virt(data);
+
 	pr_info("cancel data[%llx]\n", data);
+	pci_lock_rescan_remove();
+	down_write(&pci_bus_sem);
+
+	pci_call_cancel(pci_state);
+	cleanup_liveupdate_state(pci_state);
+
+	up_write(&pci_bus_sem);
+	pci_unlock_rescan_remove();
 }
 
 static void pci_liveupdate_finish(void *arg, u64 data)
diff --git a/include/linux/dev_liveupdate.h b/include/linux/dev_liveupdate.h
index 72297cba08a999e89f7bc0997dabdbe14e0aa12c..80a723c7701ac4ddc2ddd03d0ffc9cc5a62a6083 100644
--- a/include/linux/dev_liveupdate.h
+++ b/include/linux/dev_liveupdate.h
@@ -20,6 +20,8 @@ enum liveupdate_flag {
 #define	LU_REQUESTED	(LU_BUSMASTER)
 #define	LU_DEPENDED	(LU_BUSMASTER_BRIDGE)
 
+struct device;
+
 /**
  * struct dev_liveupdate - Device state for live update operations
  * @lu_next:	List head for linking the device into live update
@@ -40,5 +42,26 @@ struct dev_liveupdate {
 	bool visited:1;
 };
 
+/**
+ * struct dev_liveupdate_ops - Live Update callback functions
+ * @prepare:     Prepare device for the upcoming state transition. Driver and
+ *               buses should save the necessary device state.
+ * @freeze:      A final notification before the system jumps to the new kernel.
+ *               Called from reboot() syscall.
+ * @cancel:      Cancel the live update process. Driver should clean
+ *               up any saved state if necessary.
+ * @finish:      The system has completed a transition. Drivers and buses should
+ *               have already restored the previously saved device state.
+ *               Clean-up any saved state or reset unreclaimed device.
+ *
+ * This structure is used by drivers and buses to hold the callback from LUO.
+ */
+struct dev_liveupdate_ops {
+	int (*prepare)(struct device *dev, u64 *data);
+	int (*freeze)(struct device *dev, u64 *data);
+	void (*cancel)(struct device *dev, u64 data);
+	void (*finish)(struct device *dev, u64 data);
+};
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_DEV_LIVEUPDATE_H */
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index cd8e0f0a634be9ea63ff22e89d66ada3b1a9eaf2..b2ba469cc3065a412f02230c62e811af19c4d2c6 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/device/bus.h>
 #include <linux/module.h>
+#include <linux/dev_liveupdate.h>
 
 /**
  * enum probe_type - device driver probe type to try
@@ -80,6 +81,8 @@ enum probe_type {
  *		it is bound to the driver.
  * @pm:		Power management operations of the device which matched
  *		this driver.
+ * @lu:		Live update callbacks, notify device of the live
+ *		update state, and allow preserve device across reboot.
  * @coredump:	Called when sysfs entry is written to. The device driver
  *		is expected to call the dev_coredump API resulting in a
  *		uevent.
@@ -116,6 +119,9 @@ struct device_driver {
 	const struct attribute_group **dev_groups;
 
 	const struct dev_pm_ops *pm;
+#ifdef CONFIG_LIVEUPDATE
+	const struct dev_liveupdate_ops *lu;
+#endif
 	void (*coredump) (struct device *dev);
 
 	struct driver_private *p;

-- 
2.51.0.384.g4c02a37b29-goog


