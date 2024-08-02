Return-Path: <linux-acpi+bounces-7216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65649457CA
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 07:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1140B1C212F7
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 05:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2D3EA98;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH9yK/A8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41E1757D;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578119; cv=none; b=P2Zchr7lC185iTsuXUhGYwNGi6oRqjryLkNrhXhZcWUYv5UPoKFy79zvQnUevSRn2Lz+wvqpVP3Gk7DKQJ8sFt8tVaMUunK0zLukqq/+IMiwnOk6e2KevPAPmP2ulxNJF6mqi7miaYvib0PFmlLPFHdY2hD5uYkgJE/gefd1jZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578119; c=relaxed/simple;
	bh=AxtWneldSm9lWW9WolDLawhVdargn0y7wRo9Jq5s5bM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECZHQrrKZn61vb4dQlhiVs2J0QryA2mpbVnTuwp5Ld8mKexVziVdvnPlwblHsPCfrYWLCTAsxqI45jZzzQeu4g6Dx3As2Wlx5tcuyO9TtyaBTAIFTvovVCF9fbuE4JneHJZBMdd9giNX14VvbJnsSg3tOFru1eOBUVPpKsAOIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH9yK/A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51FB2C4AF10;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722578119;
	bh=AxtWneldSm9lWW9WolDLawhVdargn0y7wRo9Jq5s5bM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uH9yK/A8KTiUnCB/wRYsNBm0efNp8duBcSc069zmKigPfqvhXBl7apgtSV9dJ5YUR
	 oLaZCs45pxm0NL/c8sl1UIJ0Xx7dsJVgzCcQf0BIm9WJ4356uVJGHatsm05qwSZA12
	 uqt9Y5T/cuQmNtQKAoy/Io51mcyAhGJiAOOjCxJ7W0REFi1vT7dQfIbiRW5lyI1mql
	 cAFopYdUFhvF2CsJ0BlvK0gfoGnjT9wFva9s3AtRgnsOMsETluECCuozdKV/Q4//Q6
	 uXXALrK9NU3S84iyEp55fWkrFyDC4wPf+wmlO0VVMkmeoNiTANq1lfCRK/ZAYTqopH
	 Fyfb8OtOwAnuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42628C52D74;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 02 Aug 2024 11:25:02 +0530
Subject: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for bridges
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-pci-bridge-d3-v5-3-2426dd9e8e27@linaro.org>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
In-Reply-To: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=14065;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+UbyNghldovQGDHW5wq3Nj4VVWdDPl/7KL/Kc/Mfuk8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmrHTDcZGAfECZCzal9nJj1EC6T9sSHUpElLz/U
 tpd6E2wjOCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqx0wwAKCRBVnxHm/pHO
 9aHyB/9qqryeGB3K4b7HlcJ8Sy2v9Uj+lqG+0AkeZFRfYHOpSEKyDXCZpfK6MJ8BKg2XWw8U6Eb
 RvXAjwruIb3iuzZF0xb7PGxhNlWVLHBLTZnTPKROthzT/bSzg43kp3KQfcy+aKt1Fh0JoBbe9RJ
 QqOsDLa7WyOW2Izr5XE4cj/C+tWEhZtO22zJ30nPKxT5t3wESXtN8BxrbACLOrVjRblMCl68hsv
 OCzn9idBp4jwjh3hWni+wjZtUfZup6r4NFwnXM4I4BYy+dVmCJrWV4bTvqhgt/HBLe1zNiKTuc/
 fohRmJRSJ2DXfmR5t3/bi5HY1NBbAOGEZ/lTt3x95MrqIs1Q
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Currently, there is no proper distinction between D3Hot and D3Cold while
handling the power management for PCI bridges. For instance,
pci_bridge_d3_allowed() API decides whether it is allowed to put the
bridge in D3, but it doesn't explicitly specify whether D3Hot or D3Cold
is allowed in a scenario. This often leads to confusion and may be prone
to errors.

So let's split the D3Hot and D3Cold handling where possible. The current
pci_bridge_d3_allowed() API is now split into pci_bridge_d3hot_allowed()
and pci_bridge_d3cold_allowed() APIs and used in relevant places.

Also, pci_bridge_d3_update() API is now renamed to
pci_bridge_d3cold_update() since it was only used to check the possibility
of D3Cold.

Note that it is assumed that only D3Hot needs to be checked while
transitioning the bridge during runtime PM and D3Cold in other places. In
the ACPI case, wakeup is now only enabled if both D3Hot and D3Cold are
allowed for the bridge.

Still, there are places where just 'd3' is used opaquely, but those are
hard to distinguish, hence left for future cleanups.

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c          |  2 +-
 drivers/pci/pci-acpi.c     |  5 +--
 drivers/pci/pci-sysfs.c    |  2 +-
 drivers/pci/pci.c          | 78 ++++++++++++++++++++++++++++++----------------
 drivers/pci/pci.h          | 12 ++++---
 drivers/pci/pcie/portdrv.c | 16 +++++-----
 drivers/pci/remove.c       |  2 +-
 include/linux/pci.h        |  3 +-
 8 files changed, 75 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..cb1a1aaefa90 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -346,7 +346,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 		of_pci_make_dev_node(dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
-	pci_bridge_d3_update(dev);
+	pci_bridge_d3cold_update(dev);
 
 	dev->match_driver = !dn || of_device_is_available(dn);
 	retval = device_attach(&dev->dev);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0f260cdc4592..aaf5a68e7984 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 	 * reason is that the bridge may have additional methods such as
 	 * _DSW that need to be called.
 	 */
-	if (pci_dev->bridge_d3_allowed)
+	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
 		device_wakeup_enable(dev);
 
 	acpi_pci_wakeup(pci_dev, false);
@@ -1452,7 +1452,8 @@ void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)
 	pci_acpi_remove_pm_notifier(adev);
 	if (adev->wakeup.flags.valid) {
 		acpi_device_power_remove_dependent(adev, dev);
-		if (pci_dev->bridge_d3_allowed)
+		if (pci_dev->bridge_d3cold_allowed &&
+		    pci_dev->bridge_d3hot_allowed)
 			device_wakeup_disable(dev);
 
 		device_set_wakeup_capable(dev, false);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 40cfa716392f..45628b0dd116 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -529,7 +529,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 		return -EINVAL;
 
 	pdev->d3cold_allowed = !!val;
-	pci_bridge_d3_update(pdev);
+	pci_bridge_d3cold_update(pdev);
 
 	pm_runtime_resume(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0edc4e448c2d..c7a4f961ec28 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -166,9 +166,9 @@ bool pci_ats_disabled(void)
 }
 EXPORT_SYMBOL_GPL(pci_ats_disabled);
 
-/* Disable bridge_d3 for all PCIe ports */
+/* Disable both D3Hot and D3Cold for all PCIe ports */
 static bool pci_bridge_d3_disable;
-/* Force bridge_d3 for all PCIe ports */
+/* Force both D3Hot and D3Cold for all PCIe ports */
 static bool pci_bridge_d3_force;
 
 static int __init pcie_port_pm_setup(char *str)
@@ -2966,14 +2966,11 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 	{ }
 };
 
-/**
- * pci_bridge_d3_allowed - Is it allowed to put the bridge into D3
- * @bridge: Bridge to check
- *
- * This function checks if the bridge is allowed to move to D3.
- * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
+/*
+ * Helper function to check whether it is allowed to put the bridge into D3
+ * states (D3Hot and D3Cold).
  */
-bool pci_bridge_d3_allowed(struct pci_dev *bridge)
+static bool pci_bridge_d3_allowed(struct pci_dev *bridge, pci_power_t state)
 {
 	if (!pci_is_pcie(bridge))
 		return false;
@@ -3026,6 +3023,32 @@ bool pci_bridge_d3_allowed(struct pci_dev *bridge)
 	return false;
 }
 
+/**
+ * pci_bridge_d3cold_allowed - Is it allowed to put the bridge into D3Cold
+ * @bridge: Bridge to check
+ *
+ * This function checks if the bridge is allowed to move to D3Cold.
+ * Currently we only allow D3Cold for recent enough PCIe ports on ACPI based
+ * platforms and Thunderbolt.
+ */
+bool pci_bridge_d3cold_allowed(struct pci_dev *bridge)
+{
+	return pci_bridge_d3_allowed(bridge, PCI_D3cold);
+}
+
+/**
+ * pci_bridge_d3hot_allowed - Is it allowed to put the bridge into D3Hot
+ * @bridge: Bridge to check
+ *
+ * This function checks if the bridge is allowed to move to D3Hot.
+ * Currently we only allow D3Hot for recent enough PCIe ports on ACPI based
+ * platforms and Thunderbolt.
+ */
+bool pci_bridge_d3hot_allowed(struct pci_dev *bridge)
+{
+	return pci_bridge_d3_allowed(bridge, PCI_D3hot);
+}
+
 static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 {
 	bool *d3cold_ok = data;
@@ -3046,55 +3069,55 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 }
 
 /*
- * pci_bridge_d3_update - Update bridge D3 capabilities
+ * pci_bridge_d3cold_update - Update bridge D3Cold capabilities
  * @dev: PCI device which is changed
  *
  * Update upstream bridge PM capabilities accordingly depending on if the
  * device PM configuration was changed or the device is being removed.  The
  * change is also propagated upstream.
  */
-void pci_bridge_d3_update(struct pci_dev *dev)
+void pci_bridge_d3cold_update(struct pci_dev *dev)
 {
 	bool remove = !device_is_registered(&dev->dev);
 	struct pci_dev *bridge;
 	bool d3cold_ok = true;
 
 	bridge = pci_upstream_bridge(dev);
-	if (!bridge || !pci_bridge_d3_allowed(bridge))
+	if (!bridge || !pci_bridge_d3cold_allowed(bridge))
 		return;
 
 	/*
-	 * If D3 is currently allowed for the bridge, removing one of its
+	 * If D3Cold is currently allowed for the bridge, removing one of its
 	 * children won't change that.
 	 */
-	if (remove && bridge->bridge_d3_allowed)
+	if (remove && bridge->bridge_d3cold_allowed)
 		return;
 
 	/*
-	 * If D3 is currently allowed for the bridge and a child is added or
-	 * changed, disallowance of D3 can only be caused by that child, so
+	 * If D3Cold is currently allowed for the bridge and a child is added or
+	 * changed, disallowance of D3Cold can only be caused by that child, so
 	 * we only need to check that single device, not any of its siblings.
 	 *
-	 * If D3 is currently not allowed for the bridge, checking the device
-	 * first may allow us to skip checking its siblings.
+	 * If D3Cold is currently not allowed for the bridge, checking the
+	 * device first may allow us to skip checking its siblings.
 	 */
 	if (!remove)
 		pci_dev_check_d3cold(dev, &d3cold_ok);
 
 	/*
-	 * If D3 is currently not allowed for the bridge, this may be caused
+	 * If D3Cold is currently not allowed for the bridge, this may be caused
 	 * either by the device being changed/removed or any of its siblings,
 	 * so we need to go through all children to find out if one of them
-	 * continues to block D3.
+	 * continues to block D3Cold.
 	 */
-	if (d3cold_ok && !bridge->bridge_d3_allowed)
+	if (d3cold_ok && !bridge->bridge_d3cold_allowed)
 		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
 			     &d3cold_ok);
 
-	if (bridge->bridge_d3_allowed != d3cold_ok) {
-		bridge->bridge_d3_allowed = d3cold_ok;
+	if (bridge->bridge_d3cold_allowed != d3cold_ok) {
+		bridge->bridge_d3cold_allowed = d3cold_ok;
 		/* Propagate change to upstream bridges */
-		pci_bridge_d3_update(bridge);
+		pci_bridge_d3cold_update(bridge);
 	}
 }
 
@@ -3110,7 +3133,7 @@ void pci_d3cold_enable(struct pci_dev *dev)
 {
 	if (dev->no_d3cold) {
 		dev->no_d3cold = false;
-		pci_bridge_d3_update(dev);
+		pci_bridge_d3cold_update(dev);
 	}
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_enable);
@@ -3127,7 +3150,7 @@ void pci_d3cold_disable(struct pci_dev *dev)
 {
 	if (!dev->no_d3cold) {
 		dev->no_d3cold = true;
-		pci_bridge_d3_update(dev);
+		pci_bridge_d3cold_update(dev);
 	}
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_disable);
@@ -3167,7 +3190,8 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->pm_cap = pm;
 	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
-	dev->bridge_d3_allowed = pci_bridge_d3_allowed(dev);
+	dev->bridge_d3cold_allowed = pci_bridge_d3cold_allowed(dev);
+	dev->bridge_d3hot_allowed = pci_bridge_d3hot_allowed(dev);
 	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 53ca75639201..f819eab793fc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -92,8 +92,9 @@ void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
-bool pci_bridge_d3_allowed(struct pci_dev *dev);
-void pci_bridge_d3_update(struct pci_dev *dev);
+bool pci_bridge_d3cold_allowed(struct pci_dev *dev);
+bool pci_bridge_d3hot_allowed(struct pci_dev *dev);
+void pci_bridge_d3cold_update(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
@@ -111,9 +112,12 @@ static inline bool pci_power_manageable(struct pci_dev *pci_dev)
 {
 	/*
 	 * Currently we allow normal PCI devices and PCI bridges transition
-	 * into D3 if their bridge_d3 is set.
+	 * into D3 states if both bridge_d3cold_allowed and bridge_d3hot_allowed
+	 * are set.
 	 */
-	return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3_allowed;
+	return !pci_has_subordinate(pci_dev) ||
+	       (pci_dev->bridge_d3cold_allowed &&
+		pci_dev->bridge_d3hot_allowed);
 }
 
 static inline bool pcie_downstream_port(const struct pci_dev *dev)
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 8401a0f7b394..655754b9f06a 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -632,7 +632,7 @@ __setup("pcie_ports=", pcie_port_setup);
 #ifdef CONFIG_PM
 static int pcie_port_runtime_suspend(struct device *dev)
 {
-	if (!to_pci_dev(dev)->bridge_d3_allowed)
+	if (!to_pci_dev(dev)->bridge_d3hot_allowed)
 		return -EBUSY;
 
 	return pcie_port_device_runtime_suspend(dev);
@@ -641,11 +641,11 @@ static int pcie_port_runtime_suspend(struct device *dev)
 static int pcie_port_runtime_idle(struct device *dev)
 {
 	/*
-	 * Assume the PCI core has set bridge_d3_allowed whenever it thinks the
-	 * port should be good to go to D3.  Everything else, including moving
-	 * the port to D3, is handled by the PCI core.
+	 * Assume the PCI core has set bridge_d3hot_allowed whenever it thinks
+	 * the port should be good to go to D3Hot.  Everything else, including
+	 * moving the port to D3Hot, is handled by the PCI core.
 	 */
-	return to_pci_dev(dev)->bridge_d3_allowed ? 0 : -EBUSY;
+	return to_pci_dev(dev)->bridge_d3hot_allowed ? 0 : -EBUSY;
 }
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
@@ -702,7 +702,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
 					   DPM_FLAG_SMART_SUSPEND);
 
-	if (dev->bridge_d3_allowed) {
+	if (dev->bridge_d3hot_allowed) {
 		/*
 		 * Keep the port resumed 100ms to make sure things like
 		 * config space accesses from userspace (lspci) will not
@@ -720,7 +720,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (dev->bridge_d3_allowed) {
+	if (dev->bridge_d3hot_allowed) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
@@ -733,7 +733,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 
 static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
-	if (dev->bridge_d3_allowed) {
+	if (dev->bridge_d3hot_allowed) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..36d8cb50b582 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -41,7 +41,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 
 	pci_doe_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
-	pci_bridge_d3_update(dev);
+	pci_bridge_d3cold_update(dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2a48c88512e1..d0947f932b9a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,7 +375,8 @@ struct pci_dev {
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
-	unsigned int	bridge_d3_allowed:1;	/* Allow D3 for bridge */
+	unsigned int	bridge_d3cold_allowed:1;	/* Allow D3Cold for bridge */
+	unsigned int	bridge_d3hot_allowed:1;		/* Allow D3Hot for bridge */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */

-- 
2.25.1



