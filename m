Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079703F3152
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 18:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhHTQNY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Aug 2021 12:13:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58168 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhHTQNV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Aug 2021 12:13:21 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id bd9c341d9aad94d5; Fri, 20 Aug 2021 18:12:41 +0200
Received: from kreacher.localnet (unknown [213.134.175.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3E08D66A221;
        Fri, 20 Aug 2021 18:12:40 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>
Cc:     Wendy Wang <wendy.wang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH] PCI: VMD: ACPI: Make ACPI companion lookup work for VMD bus
Date:   Fri, 20 Aug 2021 18:12:39 +0200
Message-ID: <11834551.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.112
X-CLIENT-HOSTNAME: 213.134.175.112
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrddujeehrdduuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrudduvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehinhhtvghlrdgtohhmpdhrtghpthhtohepfigvnhguhidrfigrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
 ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvihgurdgvrdgsohigsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On some systems, in order to get to the deepest low-power state of
the platform (which may be necessary to save significant enough
amounts of energy while suspended to idle. for example), devices on
the PCI bus exposed by the VMD driver need to be power-managed via
ACPI.  However, the layout of the ACPI namespace below the VMD
controller device object does not reflect the layout of the PCI bus
under the VMD host bridge, so in order to identify the ACPI companion
objects for the devices on that bus, it is necessary to use a special
_ADR encoding on the ACPI side.  In other words, acpi_pci_find_companion()
does not work for these devices, so it needs to be amended with a
special lookup logic specific to the VMD bus.

Address this issue by allowing the VMD driver to temporarily install
an ACPI companion lookup hook containing the code matching the devices
on the VMD PCI bus with the corresponding objects in the ACPI
namespace.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Wendy Wang <wendy.wang@intel.com>
---
 drivers/pci/controller/vmd.c |   48 ++++++++++++++++++++++++++
 drivers/pci/host-bridge.c    |    1 
 drivers/pci/pci-acpi.c       |   78 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h     |    3 +
 4 files changed, 130 insertions(+)

Index: linux-pm/drivers/pci/controller/vmd.c
===================================================================
--- linux-pm.orig/drivers/pci/controller/vmd.c
+++ linux-pm/drivers/pci/controller/vmd.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
 #include <linux/srcu.h>
 #include <linux/rculist.h>
@@ -447,6 +448,49 @@ static struct pci_ops vmd_ops = {
 	.write		= vmd_pci_write,
 };
 
+#ifdef CONFIG_ACPI
+static struct acpi_device *vmd_acpi_find_companion(struct pci_dev *pci_dev)
+{
+	struct pci_host_bridge *bridge;
+	u32 busnr, addr;
+
+	if (pci_dev->bus->ops != &vmd_ops)
+		return NULL;
+
+	bridge = pci_find_host_bridge(pci_dev->bus);
+	busnr = pci_dev->bus->number - bridge->bus->number;
+	addr = (busnr << 24) | ((u32)pci_dev->devfn << 16) | 0x8000FFFFU;
+
+	dev_dbg(&pci_dev->dev, "Looking for ACPI companion (address 0x%x)\n",
+		addr);
+
+	return acpi_find_child_device(ACPI_COMPANION(bridge->dev.parent), addr,
+				      false);
+}
+
+static bool hook_installed;
+
+static void vmd_acpi_begin(void)
+{
+	if (pci_acpi_set_companion_lookup_hook(vmd_acpi_find_companion))
+		return;
+
+	hook_installed = true;
+}
+
+static void vmd_acpi_end(void)
+{
+	if (!hook_installed)
+		return;
+
+	pci_acpi_clear_companion_lookup_hook();
+	hook_installed = false;
+}
+#else
+static inline void vmd_acpi_begin(void) { }
+static inline void vmd_acpi_end(void) { }
+#endif /* CONFIG_ACPI */
+
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
 	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
@@ -747,6 +791,8 @@ static int vmd_enable_domain(struct vmd_
 	if (vmd->irq_domain)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 
+	vmd_acpi_begin();
+
 	pci_scan_child_bus(vmd->bus);
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
@@ -760,6 +806,8 @@ static int vmd_enable_domain(struct vmd_
 
 	pci_bus_add_devices(vmd->bus);
 
+	vmd_acpi_end();
+
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 	return 0;
Index: linux-pm/drivers/pci/host-bridge.c
===================================================================
--- linux-pm.orig/drivers/pci/host-bridge.c
+++ linux-pm/drivers/pci/host-bridge.c
@@ -23,6 +23,7 @@ struct pci_host_bridge *pci_find_host_br
 
 	return to_pci_host_bridge(root_bus->bridge);
 }
+EXPORT_SYMBOL_GPL(pci_find_host_bridge);
 
 struct device *pci_get_host_bridge_device(struct pci_dev *dev)
 {
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -1159,6 +1159,72 @@ void acpi_pci_remove_bus(struct pci_bus
 }
 
 /* ACPI bus type */
+
+
+DEFINE_STATIC_KEY_FALSE(pci_acpi_companion_lookup_key);
+static DEFINE_MUTEX(pci_acpi_companion_lookup_mtx);
+static struct acpi_device *(*pci_acpi_find_companion_hook)(struct pci_dev *);
+
+/**
+ * pci_acpi_set_companion_lookup_hook - Set ACPI companion lookup callback.
+ * @func: ACPI companion lookup callback pointer or NULL.
+ *
+ * Set a special ACPI companion lookup callback for PCI devices whose companion
+ * objects in the ACPI namespace have _ADR with non-standard bus-device-function
+ * encodings.
+ *
+ * Return 0 on success or a negative error code on failure (in which case no
+ * changes are made).
+ *
+ * The caller is responsible for the appropriate ordering of the invocations of
+ * this function with respect to the enumeration of the PCI devices needing the
+ * callback installed by it.
+ */
+int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *))
+{
+	int ret;
+
+	if (!func)
+		return -EINVAL;
+
+	mutex_lock(&pci_acpi_companion_lookup_mtx);
+
+	if (pci_acpi_find_companion_hook) {
+		ret = -EBUSY;
+	} else {
+		pci_acpi_find_companion_hook = func;
+		static_branch_enable(&pci_acpi_companion_lookup_key);
+		ret = 0;
+	}
+
+	mutex_unlock(&pci_acpi_companion_lookup_mtx);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_acpi_set_companion_lookup_hook);
+
+/**
+ * pci_acpi_clear_companion_lookup_hook - Clear ACPI companion lookup callback.
+ *
+ * Clear the special ACPI companion lookup callback previously set by
+ * pci_acpi_set_companion_lookup_hook().  Block until the last running instance
+ * of the callback returns before clearing it.
+ *
+ * The caller is responsible for the appropriate ordering of the invocations of
+ * this function with respect to the enumeration of the PCI devices needing the
+ * callback cleared by it.
+ */
+void pci_acpi_clear_companion_lookup_hook(void)
+{
+	mutex_lock(&pci_acpi_companion_lookup_mtx);
+
+	pci_acpi_find_companion_hook = NULL;
+	static_branch_disable(&pci_acpi_companion_lookup_key);
+
+	mutex_unlock(&pci_acpi_companion_lookup_mtx);
+}
+EXPORT_SYMBOL_GPL(pci_acpi_clear_companion_lookup_hook);
+
 static struct acpi_device *acpi_pci_find_companion(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -1166,6 +1232,18 @@ static struct acpi_device *acpi_pci_find
 	bool check_children;
 	u64 addr;
 
+	if (static_branch_unlikely(&pci_acpi_companion_lookup_key)) {
+		mutex_lock(&pci_acpi_companion_lookup_mtx);
+
+		adev = pci_acpi_find_companion_hook ?
+			pci_acpi_find_companion_hook(pci_dev) : NULL;
+
+		mutex_unlock(&pci_acpi_companion_lookup_mtx);
+
+		if (adev)
+			return adev;
+	}
+
 	check_children = pci_is_bridge(pci_dev);
 	/* Please ref to ACPI spec for the syntax of _ADR */
 	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
Index: linux-pm/include/linux/pci-acpi.h
===================================================================
--- linux-pm.orig/include/linux/pci-acpi.h
+++ linux-pm/include/linux/pci-acpi.h
@@ -122,6 +122,9 @@ static inline void pci_acpi_add_edr_noti
 static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
 #endif /* CONFIG_PCIE_EDR */
 
+int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
+void pci_acpi_clear_companion_lookup_hook(void);
+
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }



