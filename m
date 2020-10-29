Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3672B29E9CF
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 11:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgJ2K7s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 06:59:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:56275 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgJ2K7r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 06:59:47 -0400
IronPort-SDR: uJ4T/YhWIOH7D9gbSK6jD+8BtOhCJGQOhwUWXF3sLTb8B+7yEjjC8O/buhsXxL7S/v9RTaaZfn
 cF93vNSDOAuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="186197276"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="186197276"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 03:59:46 -0700
IronPort-SDR: u7hElj58jBAN8rBJkZBYuB4YPieYfvNyYAOVrqjlV8/Akyrw2Vkh1PM7JW5awfmEXvLwn5a6mW
 7zsW7LTK1qzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="425017594"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2020 03:59:44 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCHv2 1/3] software node: Power management operations for software nodes
Date:   Thu, 29 Oct 2020 13:59:39 +0300
Message-Id: <20201029105941.63410-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The software node specific PM operations make it possible to
handle most PM related quirks separately in their own
functions instead of conditionally in the device driver's
generic PM functions (and in some cases all over the
driver). The software node specific PM operations will also
reduce the need to pass platform data in some cases, for
example from a core MFD driver to the child device drivers,
as from now on the core MFD driver will be able to implement
the PM quirks directly for the child devices without the
need to touch the drivers of those child devices.

If a software node includes the PM operations, those PM
operations are always executed separately on top of the
other PM operations of the device, so the software node will
never replace any of the "normal" PM operations of the
device (including the PM domain's operations, class's or
bus's PM operations, the device drivers own operations, or
any other).

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/power/common.c |   8 +-
 drivers/base/swnode.c       | 693 +++++++++++++++++++++++++++++++++++-
 include/linux/property.h    |  10 +
 3 files changed, 701 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index bbddb267c2e69..b64cd4690ac63 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -109,8 +109,14 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
 	ret = acpi_dev_pm_attach(dev, power_on);
 	if (!ret)
 		ret = genpd_dev_pm_attach(dev);
+	if (ret < 0)
+		return ret;
 
-	return ret < 0 ? ret : 0;
+	ret = software_node_dev_pm_attach(dev, power_on);
+	if (ret)
+		dev_pm_domain_detach(dev, power_on);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
 
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 010828fc785bc..595a9c240fede 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -8,6 +8,8 @@
 
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
@@ -48,6 +50,19 @@ EXPORT_SYMBOL_GPL(is_software_node);
 				     struct swnode, fwnode) : NULL;	\
 	})
 
+static inline struct swnode *dev_to_swnode(struct device *dev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+
+	if (!fwnode)
+		return NULL;
+
+	if (!is_software_node(fwnode))
+		fwnode = fwnode->secondary;
+
+	return to_swnode(fwnode);
+}
+
 static struct swnode *
 software_node_to_swnode(const struct software_node *node)
 {
@@ -344,6 +359,673 @@ void property_entries_free(const struct property_entry *properties)
 }
 EXPORT_SYMBOL_GPL(property_entries_free);
 
+/* -------------------------------------------------------------------------- */
+/* Power management operations */
+
+/*
+ * The power management operations in software nodes are handled with a power
+ * management domain - a "wrapper" PM domain:
+ *
+ *   When PM operations are supplied as part of the software node, the primary
+ *   PM domain of the device is stored and replaced with a device specific
+ *   software node PM domain. The software node PM domain's PM operations, which
+ *   are implemented below, will then always call the matching PM operation of
+ *   the primary PM domain (which was stored) on top of the software node's own
+ *   operation.
+ *
+ * If the device does not have primary PM domain, the software node PM wrapper
+ * operations below will also call the classes, buses and device type's PM
+ * operations, and of course the device driver's own PM operations if they are
+ * implemented. The priority of those calls follows drivers/base/power/domain.c:
+ *
+ * 1) device type
+ * 2) class
+ * 3) bus
+ * 4) driver
+ *
+ * NOTE. The software node PM operation is always called before the primary
+ * PM domain with resume/on callbacks, and after the primary PM domain with
+ * suspend/off callbacks. This order is used because the software node PM
+ * operations are primarily meant to be used to implement quirks, quirks that
+ * may be needed to power on the device to a point where it is even possible to
+ * execute the primary PM domain's resume/on routines.
+ */
+
+#ifdef CONFIG_PM
+struct swnode_pm_domain {
+	struct dev_pm_domain pm_domain;
+	struct dev_pm_domain *primary;
+};
+
+#define to_swnode_pm_domain(d) \
+		container_of(d, struct swnode_pm_domain, pm_domain)
+
+static int software_node_runtime_suspend(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.runtime_suspend)
+		ret = domain->primary->ops.runtime_suspend(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->runtime_suspend)
+		ret = dev->type->pm->runtime_suspend(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->runtime_suspend)
+		ret = dev->class->pm->runtime_suspend(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
+		ret = dev->bus->pm->runtime_suspend(dev);
+	else
+		ret = pm_generic_runtime_suspend(dev);
+
+	if (ret || !swnode->node->pm->runtime_suspend)
+		return ret;
+
+	return swnode->node->pm->runtime_suspend(dev);
+}
+
+static int software_node_runtime_resume(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (swnode->node->pm->runtime_resume) {
+		ret = swnode->node->pm->runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (domain->primary && domain->primary->ops.runtime_resume)
+		ret = domain->primary->ops.runtime_resume(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->runtime_resume)
+		ret = dev->type->pm->runtime_resume(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->runtime_resume)
+		ret = dev->class->pm->runtime_resume(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
+		ret = dev->bus->pm->runtime_resume(dev);
+	else
+		ret = pm_generic_runtime_resume(dev);
+
+	return ret;
+}
+
+static int software_node_runtime_idle(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret = 0;
+
+	if (domain->primary && domain->primary->ops.runtime_idle)
+		ret = domain->primary->ops.runtime_idle(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->runtime_idle)
+		ret = dev->type->pm->runtime_idle(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->runtime_idle)
+		ret = dev->class->pm->runtime_idle(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle)
+		ret = dev->bus->pm->runtime_idle(dev);
+	else if (dev->driver && dev->driver->pm && dev->driver->pm->runtime_idle)
+		ret = dev->driver->pm->runtime_idle(dev);
+
+	if (ret || !swnode->node->pm->runtime_idle)
+		return ret;
+
+	return swnode->node->pm->runtime_idle(dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int software_node_prepare(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.prepare)
+		ret = domain->primary->ops.prepare(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->prepare)
+		ret = dev->type->pm->prepare(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->prepare)
+		ret = dev->class->pm->prepare(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->prepare)
+		ret = dev->bus->pm->prepare(dev);
+	else
+		ret = pm_generic_prepare(dev);
+
+	if (ret || !swnode->node->pm->prepare)
+		return ret;
+
+	return swnode->node->pm->prepare(dev);
+}
+
+static void software_node_complete(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+
+	if (swnode->node->pm->complete)
+		swnode->node->pm->complete(dev);
+
+	if (domain->primary && domain->primary->ops.complete)
+		domain->primary->ops.complete(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->complete)
+		dev->type->pm->complete(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->complete)
+		dev->class->pm->complete(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->complete)
+		dev->bus->pm->complete(dev);
+	else
+		pm_generic_complete(dev);
+}
+
+static int software_node_suspend(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.suspend)
+		ret = domain->primary->ops.suspend(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->suspend)
+		ret = dev->type->pm->suspend(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->suspend)
+		ret = dev->class->pm->suspend(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->suspend)
+		ret = dev->bus->pm->suspend(dev);
+	else
+		ret = pm_generic_suspend(dev);
+
+	if (ret || !swnode->node->pm->suspend)
+		return ret;
+
+	return swnode->node->pm->suspend(dev);
+}
+
+static int software_node_resume(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (swnode->node->pm->resume) {
+		ret = swnode->node->pm->resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (domain->primary && domain->primary->ops.resume)
+		ret = domain->primary->ops.resume(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->resume)
+		ret = dev->type->pm->resume(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->resume)
+		ret = dev->class->pm->resume(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->resume)
+		ret = dev->bus->pm->resume(dev);
+	else
+		ret = pm_generic_resume(dev);
+
+	return ret;
+}
+
+static int software_node_freeze(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.freeze)
+		ret = domain->primary->ops.freeze(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->freeze)
+		ret = dev->type->pm->freeze(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->freeze)
+		ret = dev->class->pm->freeze(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->freeze)
+		ret = dev->bus->pm->freeze(dev);
+	else
+		ret = pm_generic_freeze(dev);
+
+	if (ret || !swnode->node->pm->freeze)
+		return ret;
+
+	return swnode->node->pm->freeze(dev);
+}
+
+static int software_node_thaw(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (swnode->node->pm->thaw) {
+		ret = swnode->node->pm->thaw(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (domain->primary && domain->primary->ops.thaw)
+		ret = domain->primary->ops.thaw(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->thaw)
+		ret = dev->type->pm->thaw(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->thaw)
+		ret = dev->class->pm->thaw(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->thaw)
+		ret = dev->bus->pm->thaw(dev);
+	else
+		ret = pm_generic_thaw(dev);
+
+	return ret;
+}
+
+static int software_node_poweroff(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.poweroff)
+		ret = domain->primary->ops.poweroff(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->poweroff)
+		ret = dev->type->pm->poweroff(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->poweroff)
+		ret = dev->class->pm->poweroff(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->poweroff)
+		ret = dev->bus->pm->poweroff(dev);
+	else
+		ret = pm_generic_poweroff(dev);
+
+	if (ret || !swnode->node->pm->poweroff)
+		return ret;
+
+	return swnode->node->pm->poweroff(dev);
+}
+
+static int software_node_restore(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (swnode->node->pm->restore) {
+		ret = swnode->node->pm->restore(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (domain->primary && domain->primary->ops.restore)
+		ret = domain->primary->ops.restore(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->restore)
+		ret = dev->type->pm->restore(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->restore)
+		ret = dev->class->pm->restore(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->restore)
+		ret = dev->bus->pm->restore(dev);
+	else
+		ret = pm_generic_restore(dev);
+
+	return ret;
+}
+
+static int software_node_suspend_late(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.suspend_late)
+		ret = domain->primary->ops.suspend_late(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->suspend_late)
+		ret = dev->type->pm->suspend_late(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->suspend_late)
+		ret = dev->class->pm->suspend_late(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->suspend_late)
+		ret = dev->bus->pm->suspend_late(dev);
+	else
+		ret = pm_generic_suspend_late(dev);
+
+	if (ret || !swnode->node->pm->suspend_late)
+		return ret;
+
+	return swnode->node->pm->suspend_late(dev);
+}
+
+static int software_node_resume_early(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (swnode->node->pm->resume_early) {
+		ret = swnode->node->pm->resume_early(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (domain->primary && domain->primary->ops.resume_early)
+		ret = domain->primary->ops.resume_early(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->resume_early)
+		ret = dev->type->pm->resume_early(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->resume_early)
+		ret = dev->class->pm->resume_early(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->resume_early)
+		ret = dev->bus->pm->resume_early(dev);
+	else
+		pm_generic_resume_early(dev);
+
+	return 0;
+}
+
+static int software_node_freeze_late(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.freeze_late)
+		ret = domain->primary->ops.freeze_late(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->freeze_late)
+		ret = dev->type->pm->freeze_late(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->freeze_late)
+		ret = dev->class->pm->freeze_late(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->freeze_late)
+		ret = dev->bus->pm->freeze_late(dev);
+	else
+		ret = pm_generic_freeze_late(dev);
+
+	if (ret || !swnode->node->pm->freeze_late)
+		return ret;
+
+	return swnode->node->pm->freeze_late(dev);
+}
+
+static int software_node_thaw_early(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (swnode->node->pm->thaw_early) {
+		ret = swnode->node->pm->thaw_early(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (domain->primary && domain->primary->ops.thaw_early)
+		ret = domain->primary->ops.thaw_early(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->thaw_early)
+		ret = dev->type->pm->thaw_early(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->thaw_early)
+		ret = dev->class->pm->thaw_early(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->thaw_early)
+		ret = dev->bus->pm->thaw_early(dev);
+	else
+		ret = pm_generic_thaw_early(dev);
+
+	return ret;
+}
+
+static int software_node_poweroff_late(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.poweroff_late)
+		ret = domain->primary->ops.poweroff_late(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->poweroff_late)
+		ret = dev->type->pm->poweroff_late(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->poweroff_late)
+		ret = dev->class->pm->poweroff_late(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->poweroff_late)
+		ret = dev->bus->pm->poweroff_late(dev);
+	else
+		ret = pm_generic_poweroff_late(dev);
+
+	if (ret || !swnode->node->pm->poweroff_late)
+		return ret;
+
+	return swnode->node->pm->poweroff(dev);
+}
+
+static int software_node_restore_early(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (swnode->node->pm->restore_early) {
+		ret = swnode->node->pm->restore_early(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (domain->primary && domain->primary->ops.restore_early)
+		ret = domain->primary->ops.restore_early(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->restore_early)
+		ret = dev->type->pm->restore_early(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->restore_early)
+		ret = dev->class->pm->restore_early(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->restore_early)
+		ret = dev->bus->pm->restore_early(dev);
+	else
+		ret = pm_generic_restore_early(dev);
+
+	return ret;
+}
+
+static int software_node_suspend_noirq(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.suspend_noirq)
+		ret = domain->primary->ops.suspend_noirq(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->suspend_noirq)
+		ret = dev->type->pm->suspend_noirq(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->suspend_noirq)
+		ret = dev->class->pm->suspend_noirq(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->suspend_noirq)
+		ret = dev->bus->pm->suspend_noirq(dev);
+	else
+		ret = pm_generic_suspend_noirq(dev);
+
+	if (ret || !swnode->node->pm->suspend_noirq)
+		return ret;
+
+	return swnode->node->pm->suspend_noirq(dev);
+}
+
+static int software_node_resume_noirq(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (swnode->node->pm->resume_noirq) {
+		ret = swnode->node->pm->resume_noirq(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (domain->primary && domain->primary->ops.resume_noirq)
+		ret = domain->primary->ops.resume_noirq(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->resume_noirq)
+		ret = dev->type->pm->resume_noirq(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->resume_noirq)
+		ret = dev->class->pm->resume_noirq(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->resume_noirq)
+		ret = dev->bus->pm->resume_noirq(dev);
+	else
+		ret = pm_generic_resume_noirq(dev);
+
+	return ret;
+}
+
+static int software_node_freeze_noirq(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.freeze_noirq)
+		ret = domain->primary->ops.freeze_noirq(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->freeze_noirq)
+		ret = dev->type->pm->freeze_noirq(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->freeze_noirq)
+		ret = dev->class->pm->freeze_noirq(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->freeze_noirq)
+		ret = dev->bus->pm->freeze_noirq(dev);
+	else
+		ret = pm_generic_freeze_noirq(dev);
+
+	if (ret || !swnode->node->pm->freeze_noirq)
+		return ret;
+
+	return swnode->node->pm->freeze_noirq(dev);
+}
+
+static int software_node_thaw_noirq(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (swnode->node->pm->thaw_noirq) {
+		ret = swnode->node->pm->thaw_noirq(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (domain->primary && domain->primary->ops.thaw_noirq)
+		ret = domain->primary->ops.thaw_noirq(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->thaw_noirq)
+		ret = dev->type->pm->thaw_noirq(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->thaw_noirq)
+		ret = dev->class->pm->thaw_noirq(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->thaw_noirq)
+		ret = dev->bus->pm->thaw_noirq(dev);
+	else
+		ret = pm_generic_thaw_noirq(dev);
+
+	return ret;
+}
+
+static int software_node_poweroff_noirq(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (domain->primary && domain->primary->ops.poweroff_noirq)
+		ret = domain->primary->ops.poweroff_noirq(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->poweroff_noirq)
+		ret = dev->type->pm->poweroff_noirq(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->poweroff_noirq)
+		ret = dev->class->pm->poweroff_noirq(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->poweroff_noirq)
+		ret = dev->bus->pm->poweroff_noirq(dev);
+	else
+		ret = pm_generic_poweroff_noirq(dev);
+
+	if (ret || !swnode->node->pm->poweroff)
+		return ret;
+
+	return swnode->node->pm->poweroff_noirq(dev);
+}
+
+static int software_node_restore_noirq(struct device *dev)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+	struct swnode *swnode = dev_to_swnode(dev);
+	int ret;
+
+	if (swnode->node->pm->restore_noirq) {
+		ret = swnode->node->pm->restore_noirq(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (domain->primary && domain->primary->ops.restore_noirq)
+		ret = domain->primary->ops.restore_noirq(dev);
+	else if (dev->type && dev->type->pm && dev->type->pm->restore_noirq)
+		ret = dev->type->pm->restore_noirq(dev);
+	else if (dev->class && dev->class->pm && dev->class->pm->restore_noirq)
+		ret = dev->class->pm->restore_noirq(dev);
+	else if (dev->bus && dev->bus->pm && dev->bus->pm->restore_noirq)
+		ret = dev->bus->pm->restore_noirq(dev);
+	else
+		ret = pm_generic_restore_noirq(dev);
+
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops software_node_pm_ops = {
+	.runtime_suspend = software_node_runtime_suspend,
+	.runtime_resume = software_node_runtime_resume,
+	.runtime_idle = software_node_runtime_idle,
+#ifdef CONFIG_PM_SLEEP
+	.prepare = software_node_prepare,
+	.complete = software_node_complete,
+	.suspend = software_node_suspend,
+	.resume = software_node_resume,
+	.freeze = software_node_freeze,
+	.thaw = software_node_thaw,
+	.poweroff = software_node_poweroff,
+	.restore = software_node_restore,
+	.suspend_late = software_node_suspend_late,
+	.resume_early = software_node_resume_early,
+	.freeze_late = software_node_freeze_late,
+	.thaw_early = software_node_thaw_early,
+	.poweroff_late = software_node_poweroff_late,
+	.restore_early = software_node_restore_early,
+	.suspend_noirq = software_node_suspend_noirq,
+	.resume_noirq = software_node_resume_noirq,
+	.freeze_noirq = software_node_freeze_noirq,
+	.thaw_noirq = software_node_thaw_noirq,
+	.poweroff_noirq = software_node_poweroff_noirq,
+	.restore_noirq = software_node_restore_noirq,
+#endif /* CONFIG_PM_SLEEP */
+};
+
+static void software_node_dev_pm_detach(struct device *dev, bool power_off)
+{
+	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
+
+	if (domain->primary && domain->primary->detach) {
+		dev->pm_domain = domain->primary;
+		domain->primary->detach(dev, power_off);
+	} else {
+		dev_pm_domain_set(dev, NULL);
+	}
+
+	kfree(domain);
+}
+
+int software_node_dev_pm_attach(struct device *dev, bool power_on)
+{
+	struct swnode *swnode = dev_to_swnode(dev);
+	struct swnode_pm_domain *domain;
+
+	if (!swnode || !swnode->node->pm)
+		return 0;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return -ENOMEM;
+
+	if (dev->pm_domain)
+		domain->pm_domain = *dev->pm_domain;
+
+	domain->primary = dev->pm_domain;
+	domain->pm_domain.ops = software_node_pm_ops;
+	domain->pm_domain.detach = software_node_dev_pm_detach;
+
+	dev_pm_domain_set(dev, &domain->pm_domain);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(software_node_dev_pm_attach);
+#endif /* CONFIG_PM */
+
 /* -------------------------------------------------------------------------- */
 /* fwnode operations */
 
@@ -845,20 +1527,13 @@ EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
 
 int software_node_notify(struct device *dev, unsigned long action)
 {
-	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct swnode *swnode;
 	int ret;
 
-	if (!fwnode)
-		return 0;
-
-	if (!is_software_node(fwnode))
-		fwnode = fwnode->secondary;
-	if (!is_software_node(fwnode))
+	swnode = dev_to_swnode(dev);
+	if (!swnode)
 		return 0;
 
-	swnode = to_swnode(fwnode);
-
 	switch (action) {
 	case KOBJ_ADD:
 		ret = sysfs_create_link(&dev->kobj, &swnode->kobj,
diff --git a/include/linux/property.h b/include/linux/property.h
index 2d4542629d80b..33b25c8bd4052 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -453,11 +453,13 @@ static inline void *device_connection_find_match(struct device *dev,
  * @name: Name of the software node
  * @parent: Parent of the software node
  * @properties: Array of device properties
+ * @pm: Power management operations
  */
 struct software_node {
 	const char *name;
 	const struct software_node *parent;
 	const struct property_entry *properties;
+	const struct dev_pm_ops *pm;
 };
 
 bool is_software_node(const struct fwnode_handle *fwnode);
@@ -479,6 +481,14 @@ int software_node_register(const struct software_node *node);
 void software_node_unregister(const struct software_node *node);
 
 int software_node_notify(struct device *dev, unsigned long action);
+#ifdef CONFIG_PM
+int software_node_dev_pm_attach(struct device *dev, bool power_on);
+#else
+static inline int software_node_dev_pm_attach(struct device *dev, bool power_on)
+{
+	return 0;
+}
+#endif /* CONFIG_PM */
 
 struct fwnode_handle *
 fwnode_create_software_node(const struct property_entry *properties,
-- 
2.28.0

