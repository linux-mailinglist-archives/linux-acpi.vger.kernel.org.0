Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC52163D0
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 04:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGGCPo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 22:15:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:65234 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgGGCPo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Jul 2020 22:15:44 -0400
IronPort-SDR: BdYufs6a9fRFRpwADOZl0YvqDQZR54bif2S1a1XpJtkpg1ZMwWVq/R0JOifuYAimtz0uKhMefq
 wGbQy365+pPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149038913"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="149038913"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:43 -0700
IronPort-SDR: TmIvGbbqKmFWxDZP1hc62t3H4ck3smDq8kBt1Mmi2gJYm/T9ktT7GEVwvCEXR93QAVE+8yQiDh
 6REIY8YYnsbQ==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="315363744"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:42 -0700
Subject: [PATCH v2 10/12] libnvdimm: Add runtime firmware activation sysfs
 interface
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Jul 2020 18:59:27 -0700
Message-ID: <159408716708.2385045.6514024283397587226.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Abstract the platform specific mechanics for firmware activation behind
a handful of generic ops. At the bus level ->activate_state() indicates
the unified state (idle, busy, armed) of all DIMMs on the bus, and
->capability() indicates the system state expectations for activate. At
the DIMM level ->activate_state() indicates the per-DIMM state,
->activate_result() indicates the outcome of the last activation
attempt, and ->arm() attempts to transition the DIMM from 'idle' to
'armed'.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-nvdimm         |    2 
 .../driver-api/nvdimm/firmware-activate.rst        |   74 ++++++++++++++++
 drivers/nvdimm/core.c                              |   92 +++++++++++++++++++
 drivers/nvdimm/dimm_devs.c                         |   95 ++++++++++++++++++++
 drivers/nvdimm/nd-core.h                           |    1 
 include/linux/libnvdimm.h                          |   44 +++++++++
 6 files changed, 308 insertions(+)
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
index 000000000000..8b42c96e1f6f
--- /dev/null
+++ b/Documentation/driver-api/nvdimm/firmware-activate.rst
@@ -0,0 +1,74 @@
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
+The libnvdimm bus object, ndbusX, implements an ndbusX/firmware_activate
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
+This property is optionally read-write if the platform implementation
+allows firmware-activation at run-time. Some activations may involve a
+memory controller quiesce that may trigger undefined behavior in devices
+actively performing DMA. On these platform firmware_activate is not
+writable and instead activation occurs over a suspend event.
+
+The libnvdimm memory-device / DIMM object, nmemX, implements
+nmemX/firmware_activate and nmemX/firmware_activate_result attributes to
+communicate the per-device firmware activation state. Similar to the
+ndbusX/firmware_activate attribute, the nmemX/firmware_activate
+attribute indicates 'idle', 'armed', or 'busy'. The state transitions
+from 'armed' to 'idle' when the system is prepared to activate firmware,
+firmware staged + state set to armed, and a system sleep state
+transition is triggered. After that activation event the
+nmemX/firmware_activate_result attribute reflects the state of the last
+activation as one of:
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
index fe9bd6febdd2..b1cc7b35bd51 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -378,15 +378,107 @@ static ssize_t wait_probe_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(wait_probe);
 
+static ssize_t firmware_activate_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+	enum nvdimm_fwa_state state;
+
+	if (!nd_desc->fw_ops)
+		return -EOPNOTSUPP;
+
+	nvdimm_bus_lock(dev);
+	state = nd_desc->fw_ops->activate_state(nd_desc);
+	nvdimm_bus_unlock(dev);
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
+static ssize_t firmware_activate_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+	enum nvdimm_fwa_state state;
+	ssize_t rc;
+
+	if (!nd_desc->fw_ops)
+		return -EOPNOTSUPP;
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
+		rc = nd_desc->fw_ops->activate(nd_desc);
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
+static DEVICE_ATTR_ADMIN_RW(firmware_activate);
+
+static umode_t nvdimm_bus_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+
+	if (a == &dev_attr_firmware_activate.attr) {
+		enum nvdimm_fwa_capability cap;
+
+		if (!nd_desc->fw_ops)
+			return 0;
+
+		nvdimm_bus_lock(dev);
+		cap = nd_desc->fw_ops->capability(nd_desc);
+		nvdimm_bus_unlock(dev);
+
+		if (cap < NVDIMM_FWA_CAP_QUIESCE)
+			return 0;
+		/* Force suspend flow for activate */
+		if (cap == NVDIMM_FWA_CAP_QUIESCE)
+			return 0400;
+		/* Live activation permitted */
+			return 0600;
+	}
+	return a->mode;
+}
+
 static struct attribute *nvdimm_bus_attributes[] = {
 	&dev_attr_commands.attr,
 	&dev_attr_wait_probe.attr,
 	&dev_attr_provider.attr,
+	&dev_attr_firmware_activate.attr,
 	NULL,
 };
 
 static const struct attribute_group nvdimm_bus_attribute_group = {
 	.attrs = nvdimm_bus_attributes,
+	.is_visible = nvdimm_bus_visible,
 };
 
 const struct attribute_group *nvdimm_bus_attribute_groups[] = {
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index b7b77e8d9027..85835f9add7a 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -406,6 +406,88 @@ static ssize_t security_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(security);
 
+static ssize_t firmware_activate_result_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
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
+static DEVICE_ATTR_ADMIN_RO(firmware_activate_result);
+
+static ssize_t firmware_activate_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
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
+static ssize_t firmware_activate_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
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
+static DEVICE_ATTR_ADMIN_RW(firmware_activate);
+
 static struct attribute *nvdimm_attributes[] = {
 	&dev_attr_state.attr,
 	&dev_attr_flags.attr,
@@ -413,6 +495,8 @@ static struct attribute *nvdimm_attributes[] = {
 	&dev_attr_available_slots.attr,
 	&dev_attr_security.attr,
 	&dev_attr_frozen.attr,
+	&dev_attr_firmware_activate.attr,
+	&dev_attr_firmware_activate_result.attr,
 	NULL,
 };
 
@@ -421,6 +505,17 @@ static umode_t nvdimm_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct device *dev = container_of(kobj, typeof(*dev), kobj);
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
+	if (a == &dev_attr_firmware_activate.attr) {
+		struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
+		struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+
+		if (!nd_desc->fw_ops)
+			return 0;
+		if (!nvdimm->fw_ops)
+			return 0;
+		return a->mode;
+	}
+
 	if (a != &dev_attr_security.attr && a != &dev_attr_frozen.attr)
 		return a->mode;
 	if (!nvdimm->sec.flags)
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

