Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE3227255
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 00:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGTWYh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 18:24:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:35419 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgGTWYh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 18:24:37 -0400
IronPort-SDR: cPIuDFSTpvnJyRU+67Iy3iVNFg27bDveLOITT9kNrOYwi3M8nwTIyuX2A4UaUARJ/Fd952t8Kc
 rMoWvCx3n5mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="214686981"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="214686981"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:36 -0700
IronPort-SDR: iIp76i9KJeGc/P0nC7Df6WopWDiJnueDXRyvHfVFn3N4RNI1qutSypvhdA4yZfSBWJ4Smzvbkd
 XjKNn2HcTc8Q==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="487872182"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:35 -0700
Subject: [PATCH v3 10/11] PM,
 libnvdimm: Add runtime firmware activation support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Pavel Machek <pavel@ucw.cz>, Ira Weiny <ira.weiny@intel.com>,
        Len Brown <len.brown@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Jul 2020 15:08:18 -0700
Message-ID: <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Abstract platform specific mechanics for nvdimm firmware activation
behind a handful of generic ops. At the bus level ->activate_state()
indicates the unified state (idle, busy, armed) of all DIMMs on the bus,
and ->capability() indicates the system state expectations for activate.
At the DIMM level ->activate_state() indicates the per-DIMM state,
->activate_result() indicates the outcome of the last activation
attempt, and ->arm() attempts to transition the DIMM from 'idle' to
'armed'.

A new hibernate_quiet_exec() facility is added to support firmware
activation in an OS defined system quiesce state. It leverages the fact
that the hibernate-freeze state wants to assert that a memory
hibernation snapshot can be taken. This is in contrast to a platform
firmware defined quiesce state that may forcefully quiet the memory
controller independent of whether an individual device-driver properly
supports hibernate-freeze.

The libnvdimm sysfs interface is extended to support detection of a
firmware activate capability. The mechanism supports enumeration and
triggering of firmware activate, optionally in the
hibernate_quiet_exec() context.

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
[rafael: hibernate_quiet_exec() proposal]
Co-developed-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-nvdimm         |    2 
 .../driver-api/nvdimm/firmware-activate.rst        |   86 ++++++++++++
 drivers/nvdimm/core.c                              |  149 ++++++++++++++++++++
 drivers/nvdimm/dimm_devs.c                         |  115 +++++++++++++++
 drivers/nvdimm/nd-core.h                           |    1 
 include/linux/libnvdimm.h                          |   44 ++++++
 include/linux/suspend.h                            |    6 +
 kernel/power/hibernate.c                           |   97 +++++++++++++
 8 files changed, 500 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-nvdimm
 create mode 100644 Documentation/driver-api/nvdimm/firmware-activate.rst

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
new file mode 100644
index 000000000000..d64380262be8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -0,0 +1,2 @@
+The libnvdimm sub-system implements a common sysfs interface for
+platform nvdimm resources. See Documentation/driver-api/nvdimm/.
diff --git a/Documentation/driver-api/nvdimm/firmware-activate.rst b/Documentation/driver-api/nvdimm/firmware-activate.rst
new file mode 100644
index 000000000000..9eb98aa833c5
--- /dev/null
+++ b/Documentation/driver-api/nvdimm/firmware-activate.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+NVDIMM Runtime Firmware Activation
+==================================
+
+Some persistent memory devices run a firmware locally on the device /
+"DIMM" to perform tasks like media management, capacity provisioning,
+and health monitoring. The process of updating that firmware typically
+involves a reboot because it has implications for in-flight memory
+transactions. However, reboots are disruptive and at least the Intel
+persistent memory platform implementation, described by the Intel ACPI
+DSM specification [1], has added support for activating firmware at
+runtime.
+
+A native sysfs interface is implemented in libnvdimm to allow platform
+to advertise and control their local runtime firmware activation
+capability.
+
+The libnvdimm bus object, ndbusX, implements an ndbusX/firmware/activate
+attribute that shows the state of the firmware activation as one of 'idle',
+'armed', 'overflow', and 'busy'.
+
+- idle:
+  No devices are set / armed to activate firmware
+
+- armed:
+  At least one device is armed
+
+- busy:
+  In the busy state armed devices are in the process of transitioning
+  back to idle and completing an activation cycle.
+
+- overflow:
+  If the platform has a concept of incremental work needed to perform
+  the activation it could be the case that too many DIMMs are armed for
+  activation. In that scenario the potential for firmware activation to
+  timeout is indicated by the 'overflow' state.
+
+The 'ndbusX/firmware/activate' property can be written with a value of
+either 'live', or 'quiesce'. A value of 'quiesce' triggers the kernel to
+run firmware activation from within the equivalent of the hibernation
+'freeze' state where drivers and applications are notified to stop their
+modifications of system memory. A value of 'live' attempts
+firmware-activation without this hibernation cycle. The
+'ndbusX/firmware/activate' property will be elided completely if no
+firmware activation capability is detected.
+
+Another property 'ndbusX/firmware/capability' indicates a value of
+'live', or 'quiesce'. Where 'live' indicates that the firmware
+does not require or inflict any quiesce period on the system to update
+firmware. A capability value of 'quiesce' indicates that firmware does
+expect and injects a quiet period for the memory controller, but 'live'
+may still be written to 'ndbusX/firmware/activate' as an override to
+assume the risk of racing firmware update with in-flight device and
+application activity. The 'ndbusX/firmware/capability' property will be
+elided completely if no firmware activation capability is detected.
+
+The libnvdimm memory-device / DIMM object, nmemX, implements
+'nmemX/firmware/activate' and 'nmemX/firmware/result' attributes to
+communicate the per-device firmware activation state. Similar to the
+'ndbusX/firmware/activate' attribute, the 'nmemX/firmware/activate'
+attribute indicates 'idle', 'armed', or 'busy'. The state transitions
+from 'armed' to 'idle' when the system is prepared to activate firmware,
+firmware staged + state set to armed, and 'ndbusX/firmware/activate' is
+triggered. After that activation event the nmemX/firmware/result
+attribute reflects the state of the last activation as one of:
+
+- none:
+  No runtime activation triggered since the last time the device was reset
+
+- success:
+  The last runtime activation completed successfully.
+
+- fail:
+  The last runtime activation failed for device-specific reasons.
+
+- not_staged:
+  The last runtime activation failed due to a sequencing error of the
+  firmware image not being staged.
+
+- need_reset:
+  Runtime firmware activation failed, but the firmware can still be
+  activated via the legacy method of power-cycling the system.
+
+[1]: https://docs.pmem.io/persistent-memory/
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index fe9bd6febdd2..c21ba0602029 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -4,6 +4,7 @@
  */
 #include <linux/libnvdimm.h>
 #include <linux/badblocks.h>
+#include <linux/suspend.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/blkdev.h>
@@ -389,8 +390,156 @@ static const struct attribute_group nvdimm_bus_attribute_group = {
 	.attrs = nvdimm_bus_attributes,
 };
 
+static ssize_t capability_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+	enum nvdimm_fwa_capability cap;
+
+	if (!nd_desc->fw_ops)
+		return -EOPNOTSUPP;
+
+	nvdimm_bus_lock(dev);
+	cap = nd_desc->fw_ops->capability(nd_desc);
+	nvdimm_bus_unlock(dev);
+
+	switch (cap) {
+	case NVDIMM_FWA_CAP_QUIESCE:
+		return sprintf(buf, "quiesce\n");
+	case NVDIMM_FWA_CAP_LIVE:
+		return sprintf(buf, "live\n");
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static DEVICE_ATTR_RO(capability);
+
+static ssize_t activate_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+	enum nvdimm_fwa_capability cap;
+	enum nvdimm_fwa_state state;
+
+	if (!nd_desc->fw_ops)
+		return -EOPNOTSUPP;
+
+	nvdimm_bus_lock(dev);
+	cap = nd_desc->fw_ops->capability(nd_desc);
+	state = nd_desc->fw_ops->activate_state(nd_desc);
+	nvdimm_bus_unlock(dev);
+
+	if (cap < NVDIMM_FWA_CAP_QUIESCE)
+		return -EOPNOTSUPP;
+
+	switch (state) {
+	case NVDIMM_FWA_IDLE:
+		return sprintf(buf, "idle\n");
+	case NVDIMM_FWA_BUSY:
+		return sprintf(buf, "busy\n");
+	case NVDIMM_FWA_ARMED:
+		return sprintf(buf, "armed\n");
+	case NVDIMM_FWA_ARM_OVERFLOW:
+		return sprintf(buf, "overflow\n");
+	default:
+		return -ENXIO;
+	}
+}
+
+static int exec_firmware_activate(void *data)
+{
+	struct nvdimm_bus_descriptor *nd_desc = data;
+
+	return nd_desc->fw_ops->activate(nd_desc);
+}
+
+static ssize_t activate_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+	enum nvdimm_fwa_state state;
+	bool quiesce;
+	ssize_t rc;
+
+	if (!nd_desc->fw_ops)
+		return -EOPNOTSUPP;
+
+	if (sysfs_streq(buf, "live"))
+		quiesce = false;
+	else if (sysfs_streq(buf, "quiesce"))
+		quiesce = true;
+	else
+		return -EINVAL;
+
+	nvdimm_bus_lock(dev);
+	state = nd_desc->fw_ops->activate_state(nd_desc);
+
+	switch (state) {
+	case NVDIMM_FWA_BUSY:
+		rc = -EBUSY;
+		break;
+	case NVDIMM_FWA_ARMED:
+	case NVDIMM_FWA_ARM_OVERFLOW:
+		if (quiesce)
+			rc = hibernate_quiet_exec(exec_firmware_activate, nd_desc);
+		else
+			rc = nd_desc->fw_ops->activate(nd_desc);
+		break;
+	case NVDIMM_FWA_IDLE:
+	default:
+		rc = -ENXIO;
+	}
+	nvdimm_bus_unlock(dev);
+
+	if (rc == 0)
+		rc = len;
+	return rc;
+}
+
+static DEVICE_ATTR_ADMIN_RW(activate);
+
+static umode_t nvdimm_bus_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+	enum nvdimm_fwa_capability cap;
+
+	/*
+	 * Both 'activate' and 'capability' disappear when no ops
+	 * detected, or a negative capability is indicated.
+	 */
+	if (!nd_desc->fw_ops)
+		return 0;
+
+	nvdimm_bus_lock(dev);
+	cap = nd_desc->fw_ops->capability(nd_desc);
+	nvdimm_bus_unlock(dev);
+
+	if (cap < NVDIMM_FWA_CAP_QUIESCE)
+		return 0;
+
+	return a->mode;
+}
+static struct attribute *nvdimm_bus_firmware_attributes[] = {
+	&dev_attr_activate.attr,
+	&dev_attr_capability.attr,
+	NULL,
+};
+
+static const struct attribute_group nvdimm_bus_firmware_attribute_group = {
+	.name = "firmware",
+	.attrs = nvdimm_bus_firmware_attributes,
+	.is_visible = nvdimm_bus_firmware_visible,
+};
+
 const struct attribute_group *nvdimm_bus_attribute_groups[] = {
 	&nvdimm_bus_attribute_group,
+	&nvdimm_bus_firmware_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index b7b77e8d9027..85b53a7f44f2 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -446,9 +446,124 @@ static const struct attribute_group nvdimm_attribute_group = {
 	.is_visible = nvdimm_visible,
 };
 
+static ssize_t result_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	enum nvdimm_fwa_result result;
+
+	if (!nvdimm->fw_ops)
+		return -EOPNOTSUPP;
+
+	nvdimm_bus_lock(dev);
+	result = nvdimm->fw_ops->activate_result(nvdimm);
+	nvdimm_bus_unlock(dev);
+
+	switch (result) {
+	case NVDIMM_FWA_RESULT_NONE:
+		return sprintf(buf, "none\n");
+	case NVDIMM_FWA_RESULT_SUCCESS:
+		return sprintf(buf, "success\n");
+	case NVDIMM_FWA_RESULT_FAIL:
+		return sprintf(buf, "fail\n");
+	case NVDIMM_FWA_RESULT_NOTSTAGED:
+		return sprintf(buf, "not_staged\n");
+	case NVDIMM_FWA_RESULT_NEEDRESET:
+		return sprintf(buf, "need_reset\n");
+	default:
+		return -ENXIO;
+	}
+}
+static DEVICE_ATTR_ADMIN_RO(result);
+
+static ssize_t activate_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	enum nvdimm_fwa_state state;
+
+	if (!nvdimm->fw_ops)
+		return -EOPNOTSUPP;
+
+	nvdimm_bus_lock(dev);
+	state = nvdimm->fw_ops->activate_state(nvdimm);
+	nvdimm_bus_unlock(dev);
+
+	switch (state) {
+	case NVDIMM_FWA_IDLE:
+		return sprintf(buf, "idle\n");
+	case NVDIMM_FWA_BUSY:
+		return sprintf(buf, "busy\n");
+	case NVDIMM_FWA_ARMED:
+		return sprintf(buf, "armed\n");
+	default:
+		return -ENXIO;
+	}
+}
+
+static ssize_t activate_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	enum nvdimm_fwa_trigger arg;
+	int rc;
+
+	if (!nvdimm->fw_ops)
+		return -EOPNOTSUPP;
+
+	if (sysfs_streq(buf, "arm"))
+		arg = NVDIMM_FWA_ARM;
+	else if (sysfs_streq(buf, "disarm"))
+		arg = NVDIMM_FWA_DISARM;
+	else
+		return -EINVAL;
+
+	nvdimm_bus_lock(dev);
+	rc = nvdimm->fw_ops->arm(nvdimm, arg);
+	nvdimm_bus_unlock(dev);
+
+	if (rc < 0)
+		return rc;
+	return len;
+}
+static DEVICE_ATTR_ADMIN_RW(activate);
+
+static struct attribute *nvdimm_firmware_attributes[] = {
+	&dev_attr_activate.attr,
+	&dev_attr_result.attr,
+};
+
+static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	enum nvdimm_fwa_capability cap;
+
+	if (!nd_desc->fw_ops)
+		return 0;
+	if (!nvdimm->fw_ops)
+		return 0;
+
+	nvdimm_bus_lock(dev);
+	cap = nd_desc->fw_ops->capability(nd_desc);
+	nvdimm_bus_unlock(dev);
+
+	if (cap < NVDIMM_FWA_CAP_QUIESCE)
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group nvdimm_firmware_attribute_group = {
+	.name = "firmware",
+	.attrs = nvdimm_firmware_attributes,
+	.is_visible = nvdimm_firmware_visible,
+};
+
 static const struct attribute_group *nvdimm_attribute_groups[] = {
 	&nd_device_attribute_group,
 	&nvdimm_attribute_group,
+	&nvdimm_firmware_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index ddb9d97d9129..564faa36a3ca 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -45,6 +45,7 @@ struct nvdimm {
 		struct kernfs_node *overwrite_state;
 	} sec;
 	struct delayed_work dwork;
+	const struct nvdimm_fw_ops *fw_ops;
 };
 
 static inline unsigned long nvdimm_security_flags(
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index ad9898ece7d3..15dbcb718316 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -86,6 +86,7 @@ struct nvdimm_bus_descriptor {
 	int (*flush_probe)(struct nvdimm_bus_descriptor *nd_desc);
 	int (*clear_to_send)(struct nvdimm_bus_descriptor *nd_desc,
 			struct nvdimm *nvdimm, unsigned int cmd, void *data);
+	const struct nvdimm_bus_fw_ops *fw_ops;
 };
 
 struct nd_cmd_desc {
@@ -200,6 +201,49 @@ struct nvdimm_security_ops {
 	int (*query_overwrite)(struct nvdimm *nvdimm);
 };
 
+enum nvdimm_fwa_state {
+	NVDIMM_FWA_INVALID,
+	NVDIMM_FWA_IDLE,
+	NVDIMM_FWA_ARMED,
+	NVDIMM_FWA_BUSY,
+	NVDIMM_FWA_ARM_OVERFLOW,
+};
+
+enum nvdimm_fwa_trigger {
+	NVDIMM_FWA_ARM,
+	NVDIMM_FWA_DISARM,
+};
+
+enum nvdimm_fwa_capability {
+	NVDIMM_FWA_CAP_INVALID,
+	NVDIMM_FWA_CAP_NONE,
+	NVDIMM_FWA_CAP_QUIESCE,
+	NVDIMM_FWA_CAP_LIVE,
+};
+
+enum nvdimm_fwa_result {
+	NVDIMM_FWA_RESULT_INVALID,
+	NVDIMM_FWA_RESULT_NONE,
+	NVDIMM_FWA_RESULT_SUCCESS,
+	NVDIMM_FWA_RESULT_NOTSTAGED,
+	NVDIMM_FWA_RESULT_NEEDRESET,
+	NVDIMM_FWA_RESULT_FAIL,
+};
+
+struct nvdimm_bus_fw_ops {
+	enum nvdimm_fwa_state (*activate_state)
+		(struct nvdimm_bus_descriptor *nd_desc);
+	enum nvdimm_fwa_capability (*capability)
+		(struct nvdimm_bus_descriptor *nd_desc);
+	int (*activate)(struct nvdimm_bus_descriptor *nd_desc);
+};
+
+struct nvdimm_fw_ops {
+	enum nvdimm_fwa_state (*activate_state)(struct nvdimm *nvdimm);
+	enum nvdimm_fwa_result (*activate_result)(struct nvdimm *nvdimm);
+	int (*arm)(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arg);
+};
+
 void badrange_init(struct badrange *badrange);
 int badrange_add(struct badrange *badrange, u64 addr, u64 length);
 void badrange_forget(struct badrange *badrange, phys_addr_t start,
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b960098acfb0..045499699b86 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -453,6 +453,8 @@ extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
+
+int hibernate_quiet_exec(int (*func)(void *data), void *data);
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
@@ -464,6 +466,10 @@ static inline void hibernation_set_ops(const struct platform_hibernation_ops *op
 static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
 static inline bool hibernation_available(void) { return false; }
+
+static inline hibernate_quiet_exec(int (*func)(void *data), void *data) {
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_HIBERNATION */
 
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 02ec716a4927..e6fab3f09c98 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -795,6 +795,103 @@ int hibernate(void)
 	return error;
 }
 
+/**
+ * hibernate_quiet_exec - Execute a function with all devices frozen.
+ * @func: Function to execute.
+ * @data: Data pointer to pass to @func.
+ *
+ * Return the @func return value or an error code if it cannot be executed.
+ */
+int hibernate_quiet_exec(int (*func)(void *data), void *data)
+{
+	int error, nr_calls = 0;
+
+	lock_system_sleep();
+
+	if (!hibernate_acquire()) {
+		error = -EBUSY;
+		goto unlock;
+	}
+
+	pm_prepare_console();
+
+	error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
+	if (error) {
+		nr_calls--;
+		goto exit;
+	}
+
+	error = freeze_processes();
+	if (error)
+		goto exit;
+
+	lock_device_hotplug();
+
+	pm_suspend_clear_flags();
+
+	error = platform_begin(true);
+	if (error)
+		goto thaw;
+
+	error = freeze_kernel_threads();
+	if (error)
+		goto thaw;
+
+	error = dpm_prepare(PMSG_FREEZE);
+	if (error)
+		goto dpm_complete;
+
+	suspend_console();
+
+	error = dpm_suspend(PMSG_FREEZE);
+	if (error)
+		goto dpm_resume;
+
+	error = dpm_suspend_end(PMSG_FREEZE);
+	if (error)
+		goto dpm_resume;
+
+	error = platform_pre_snapshot(true);
+	if (error)
+		goto skip;
+
+	error = func(data);
+
+skip:
+	platform_finish(true);
+
+	dpm_resume_start(PMSG_THAW);
+
+dpm_resume:
+	dpm_resume(PMSG_THAW);
+
+	resume_console();
+
+dpm_complete:
+	dpm_complete(PMSG_THAW);
+
+	thaw_kernel_threads();
+
+thaw:
+	platform_end(true);
+
+	unlock_device_hotplug();
+
+	thaw_processes();
+
+exit:
+	__pm_notifier_call_chain(PM_POST_HIBERNATION, nr_calls, NULL);
+
+	pm_restore_console();
+
+	hibernate_release();
+
+unlock:
+	unlock_system_sleep();
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(hibernate_quiet_exec);
 
 /**
  * software_resume - Resume from a saved hibernation image.

