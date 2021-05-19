Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CC1389010
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 16:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbhESOOX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 10:14:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:39153 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242140AbhESOOV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 10:14:21 -0400
IronPort-SDR: fwVSwAfWX5OaMID3hh7CJgqaiNQMloiraRy0fq50T8IYxtWTEBNQJBnc7dlNdhcXi4HtBEt0Uz
 uYOQ6h9wIW+w==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="286513962"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286513962"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 07:12:45 -0700
IronPort-SDR: NcxIC1fxbvCPisc8hHIoLc94tL3xRdwYOJCeodNMevlkte8QZA58tP683WJZcE0lEL5pMck+C4
 yI0yl7CTyBTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="411747651"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2021 07:12:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8F6DF610; Wed, 19 May 2021 17:12:59 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Casey G Bowman <casey.g.bowman@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5/9] thunderbolt: Add support for retimer NVM upgrade when there is no link
Date:   Wed, 19 May 2021 17:12:55 +0300
Message-Id: <20210519141259.84839-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rajmohan Mani <rajmohan.mani@intel.com>

With help from platform firmware (ACPI) it is possible to power on
retimers even when there is no USB4 link (e.g nothing is connected to
the USB4 ports). This allows us to bring the USB4 sideband up so that we
can access retimers and upgrade their NVM firmware.

If the platform has support for this, we expose two additional
attributes under USB4 ports: offline and rescan. These can be used to
bring the port offline, rescan for the retimers and put the port online
again. The retimer NVM upgrade itself works the same way than with cable
connected.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 .../ABI/testing/sysfs-bus-thunderbolt         |  26 +++
 Documentation/admin-guide/thunderbolt.rst     |  29 +++
 drivers/thunderbolt/retimer.c                 |  24 ++-
 drivers/thunderbolt/switch.c                  |  48 +++--
 drivers/thunderbolt/tb.c                      |   4 +-
 drivers/thunderbolt/tb.h                      |   5 +-
 drivers/thunderbolt/usb4_port.c               | 169 ++++++++++++++++++
 7 files changed, 277 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index 3537ba1ba892..f6743dc33aac 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -297,6 +297,32 @@ Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
 Description:	Returns the current link mode. Possible values are
 		"usb4", "tbt" and "none".
 
+What:		/sys/bus/thunderbolt/devices/usb4_portX/offline
+Date:		Sep 2021
+KernelVersion:	v5.14
+Contact:	Rajmohan Mani <rajmohan.mani@intel.com>
+Description:	Writing 1 to this attribute puts the USB4 port into
+		offline mode. Only allowed when there is nothing
+		connected to the port (link attribute returns "none").
+		Once the port is in offline mode it does not receive any
+		hotplug events. This is used to update NVM firmware of
+		on-board retimers. Writing 0 puts the port back to
+		online mode.
+
+		This attribute is only visible if the platform supports
+		powering on retimers when there is no cable connected.
+
+What:		/sys/bus/thunderbolt/devices/usb4_portX/rescan
+Date:		Sep 2021
+KernelVersion:	v5.14
+Contact:	Rajmohan Mani <rajmohan.mani@intel.com>
+Description:	When the USB4 port is in offline mode writing 1 to this
+		attribute forces rescan of the sideband for on-board
+		retimers. Each retimer appear under the USB4 port as if
+		the USB4 link was up. These retimers act in the same way
+		as if the cable was connected so upgrading their NVM
+		firmware can be done the usual way.
+
 What:		/sys/bus/thunderbolt/devices/<device>:<port>.<index>/device
 Date:		Oct 2020
 KernelVersion:	v5.9
diff --git a/Documentation/admin-guide/thunderbolt.rst b/Documentation/admin-guide/thunderbolt.rst
index f18e881373c4..2ed79f41a411 100644
--- a/Documentation/admin-guide/thunderbolt.rst
+++ b/Documentation/admin-guide/thunderbolt.rst
@@ -256,6 +256,35 @@ Note names of the NVMem devices ``nvm_activeN`` and ``nvm_non_activeN``
 depend on the order they are registered in the NVMem subsystem. N in
 the name is the identifier added by the NVMem subsystem.
 
+Upgrading on-board retimer NVM when there is no cable connected
+---------------------------------------------------------------
+If the platform supports, it may be possible to upgrade the retimer NVM
+firmware even when there is nothing connected to the USB4
+ports. When this is the case the ``usb4_portX`` devices have two special
+attributes: ``offline`` and ``rescan``. The way to upgrade the firmware
+is to first put the USB4 port into offline mode::
+
+  # echo 1 > /sys/bus/thunderbolt/devices/0-0/usb4_port1/offline
+
+This step makes sure the port does not respond to any hotplug events,
+and also ensures the retimers are powered on. The next step is to scan
+for the retimers::
+
+  # echo 1 > /sys/bus/thunderbolt/devices/0-0/usb4_port1/rescan
+
+This enumerates and adds the on-board retimers. Now retimer NVM can be
+upgraded in the same way than with cable connected (see previous
+section). However, the retimer is not disconnected as we are offline
+mode) so after writing ``1`` to ``nvm_authenticate`` one should wait for
+5 or more seconds before running rescan again::
+
+  # echo 1 > /sys/bus/thunderbolt/devices/0-0/usb4_port1/rescan
+
+This point if everything went fine, the port can be put back to
+functional state again::
+
+  # echo 0 > /sys/bus/thunderbolt/devices/0-0/usb4_port1/offline
+
 Upgrading NVM when host controller is in safe mode
 --------------------------------------------------
 If the existing NVM is not properly authenticated (or is missing) the
diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 2e5188fb1150..05af0feefe84 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -401,19 +401,18 @@ static struct tb_retimer *tb_port_find_retimer(struct tb_port *port, u8 index)
 /**
  * tb_retimer_scan() - Scan for on-board retimers under port
  * @port: USB4 port to scan
+ * @add: If true also registers found retimers
  *
- * Tries to enumerate on-board retimers connected to @port. Found
- * retimers are registered as children of @port. Does not scan for cable
- * retimers for now.
+ * Brings the sideband into a state where retimers can be accessed.
+ * Then Tries to enumerate on-board retimers connected to @port. Found
+ * retimers are registered as children of @port if @add is set.  Does
+ * not scan for cable retimers for now.
  */
-int tb_retimer_scan(struct tb_port *port)
+int tb_retimer_scan(struct tb_port *port, bool add)
 {
 	u32 status[TB_MAX_RETIMER_INDEX + 1] = {};
 	int ret, i, last_idx = 0;
 
-	if (!port->cap_usb4)
-		return 0;
-
 	/*
 	 * Send broadcast RT to make sure retimer indices facing this
 	 * port are set.
@@ -422,6 +421,13 @@ int tb_retimer_scan(struct tb_port *port)
 	if (ret)
 		return ret;
 
+	/*
+	 * Enable sideband channel for each retimer. We can do this
+	 * regardless whether there is device connected or not.
+	 */
+	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++)
+		usb4_port_retimer_set_inbound_sbtx(port, i);
+
 	/*
 	 * Before doing anything else, read the authentication status.
 	 * If the retimer has it set, store it for the new retimer
@@ -453,10 +459,10 @@ int tb_retimer_scan(struct tb_port *port)
 		rt = tb_port_find_retimer(port, i);
 		if (rt) {
 			put_device(&rt->dev);
-		} else {
+		} else if (add) {
 			ret = tb_retimer_add(port, i, status[i]);
 			if (ret && ret != -EOPNOTSUPP)
-				return ret;
+				break;
 		}
 	}
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 7303c61a891a..dae59919e2bf 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1153,6 +1153,33 @@ static int tb_port_start_lane_initialization(struct tb_port *port)
 	return ret == -EINVAL ? 0 : ret;
 }
 
+/*
+ * Returns true if the port had something (router, XDomain) connected
+ * before suspend.
+ */
+static bool tb_port_resume(struct tb_port *port)
+{
+	bool has_remote = tb_port_has_remote(port);
+
+	if (port->usb4) {
+		usb4_port_device_resume(port->usb4);
+	} else if (!has_remote) {
+		/*
+		 * For disconnected downstream lane adapters start lane
+		 * initialization now so we detect future connects.
+		 *
+		 * For XDomain start the lane initialzation now so the
+		 * link gets re-established.
+		 *
+		 * This is only needed for non-USB4 ports.
+		 */
+		if (!tb_is_upstream_port(port) || port->xdomain)
+			tb_port_start_lane_initialization(port);
+	}
+
+	return has_remote || port->xdomain;
+}
+
 /**
  * tb_port_is_enabled() - Is the adapter port enabled
  * @port: Port to check
@@ -2915,22 +2942,11 @@ int tb_switch_resume(struct tb_switch *sw)
 
 	/* check for surviving downstream switches */
 	tb_switch_for_each_port(sw, port) {
-		if (!tb_port_has_remote(port) && !port->xdomain) {
-			/*
-			 * For disconnected downstream lane adapters
-			 * start lane initialization now so we detect
-			 * future connects.
-			 */
-			if (!tb_is_upstream_port(port) && tb_port_is_null(port))
-				tb_port_start_lane_initialization(port);
+		if (!tb_port_is_null(port))
+			continue;
+
+		if (!tb_port_resume(port))
 			continue;
-		} else if (port->xdomain) {
-			/*
-			 * Start lane initialization for XDomain so the
-			 * link gets re-established.
-			 */
-			tb_port_start_lane_initialization(port);
-		}
 
 		if (tb_wait_for_port(port, true) <= 0) {
 			tb_port_warn(port,
@@ -2939,7 +2955,7 @@ int tb_switch_resume(struct tb_switch *sw)
 				tb_sw_set_unplugged(port->remote->sw);
 			else if (port->xdomain)
 				port->xdomain->is_unplugged = true;
-		} else if (tb_port_has_remote(port) || port->xdomain) {
+		} else {
 			/*
 			 * Always unlock the port so the downstream
 			 * switch/domain is accessible.
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 7e6dc2b03bed..bc6d568dbb89 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -595,7 +595,7 @@ static void tb_scan_port(struct tb_port *port)
 		return;
 	}
 
-	tb_retimer_scan(port);
+	tb_retimer_scan(port, true);
 
 	sw = tb_switch_alloc(port->sw->tb, &port->sw->dev,
 			     tb_downstream_route(port));
@@ -662,7 +662,7 @@ static void tb_scan_port(struct tb_port *port)
 		tb_sw_warn(sw, "failed to enable TMU\n");
 
 	/* Scan upstream retimers */
-	tb_retimer_scan(upstream_port);
+	tb_retimer_scan(upstream_port, true);
 
 	/*
 	 * Create USB 3.x tunnels only when the switch is plugged to the
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 936518adca74..341e8443a22d 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -249,11 +249,13 @@ struct tb_port {
  * @port: Pointer to the lane 0 adapter
  * @can_offline: Does the port have necessary platform support to moved
  *		 it into offline mode and back
+ * @offline: The port is currently in offline mode
  */
 struct usb4_port {
 	struct device dev;
 	struct tb_port *port;
 	bool can_offline;
+	bool offline;
 };
 
 /**
@@ -1017,7 +1019,7 @@ void tb_xdomain_remove(struct tb_xdomain *xd);
 struct tb_xdomain *tb_xdomain_find_by_link_depth(struct tb *tb, u8 link,
 						 u8 depth);
 
-int tb_retimer_scan(struct tb_port *port);
+int tb_retimer_scan(struct tb_port *port, bool add);
 void tb_retimer_remove_all(struct tb_port *port);
 
 static inline bool tb_is_retimer(const struct device *dev)
@@ -1105,6 +1107,7 @@ static inline struct usb4_port *tb_to_usb4_port_device(struct device *dev)
 
 struct usb4_port *usb4_port_device_add(struct tb_port *port);
 void usb4_port_device_remove(struct usb4_port *usb4);
+int usb4_port_device_resume(struct usb4_port *usb4);
 
 /* Keep link controller awake during update */
 #define QUIRK_FORCE_POWER_LINK_CONTROLLER		BIT(0)
diff --git a/drivers/thunderbolt/usb4_port.c b/drivers/thunderbolt/usb4_port.c
index 520bbfd7bf33..765c74179598 100644
--- a/drivers/thunderbolt/usb4_port.c
+++ b/drivers/thunderbolt/usb4_port.c
@@ -44,8 +44,166 @@ static const struct attribute_group common_group = {
 	.attrs = common_attrs,
 };
 
+static int usb4_port_offline(struct usb4_port *usb4)
+{
+	struct tb_port *port = usb4->port;
+	int ret;
+
+	ret = tb_acpi_power_on_retimers(port);
+	if (ret)
+		return ret;
+
+	ret = usb4_port_router_offline(port);
+	if (ret) {
+		tb_acpi_power_off_retimers(port);
+		return ret;
+	}
+
+	ret = tb_retimer_scan(port, false);
+	if (ret) {
+		usb4_port_router_online(port);
+		tb_acpi_power_off_retimers(port);
+	}
+
+	return ret;
+}
+
+static void usb4_port_online(struct usb4_port *usb4)
+{
+	struct tb_port *port = usb4->port;
+
+	usb4_port_router_online(port);
+	tb_acpi_power_off_retimers(port);
+}
+
+static ssize_t offline_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct usb4_port *usb4 = tb_to_usb4_port_device(dev);
+
+	return sysfs_emit(buf, "%d\n", usb4->offline);
+}
+
+static ssize_t offline_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct usb4_port *usb4 = tb_to_usb4_port_device(dev);
+	struct tb_port *port = usb4->port;
+	struct tb *tb = port->sw->tb;
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(&usb4->dev);
+
+	if (mutex_lock_interruptible(&tb->lock)) {
+		ret = -ERESTARTSYS;
+		goto out_rpm;
+	}
+
+	if (val == usb4->offline)
+		goto out_unlock;
+
+	/* Offline mode works only for ports that are not connected */
+	if (tb_port_has_remote(port)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (val) {
+		ret = usb4_port_offline(usb4);
+		if (ret)
+			goto out_unlock;
+	} else {
+		usb4_port_online(usb4);
+		tb_retimer_remove_all(port);
+	}
+
+	usb4->offline = val;
+	tb_port_dbg(port, "%s offline mode\n", val ? "enter" : "exit");
+
+out_unlock:
+	mutex_unlock(&tb->lock);
+out_rpm:
+	pm_runtime_mark_last_busy(&usb4->dev);
+	pm_runtime_put_autosuspend(&usb4->dev);
+
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_RW(offline);
+
+static ssize_t rescan_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct usb4_port *usb4 = tb_to_usb4_port_device(dev);
+	struct tb_port *port = usb4->port;
+	struct tb *tb = port->sw->tb;
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	if (!val)
+		return count;
+
+	pm_runtime_get_sync(&usb4->dev);
+
+	if (mutex_lock_interruptible(&tb->lock)) {
+		ret = -ERESTARTSYS;
+		goto out_rpm;
+	}
+
+	/* Must be in offline mode already */
+	if (!usb4->offline) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	tb_retimer_remove_all(port);
+	ret = tb_retimer_scan(port, true);
+
+out_unlock:
+	mutex_unlock(&tb->lock);
+out_rpm:
+	pm_runtime_mark_last_busy(&usb4->dev);
+	pm_runtime_put_autosuspend(&usb4->dev);
+
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(rescan);
+
+static struct attribute *service_attrs[] = {
+	&dev_attr_offline.attr,
+	&dev_attr_rescan.attr,
+	NULL
+};
+
+static umode_t service_attr_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct usb4_port *usb4 = tb_to_usb4_port_device(dev);
+
+	/*
+	 * Always need some platform help to cycle the modes so that
+	 * retimers can be accessed through the sideband.
+	 */
+	return usb4->can_offline ? attr->mode : 0;
+}
+
+static const struct attribute_group service_group = {
+	.attrs = service_attrs,
+	.is_visible = service_attr_is_visible,
+};
+
 static const struct attribute_group *usb4_port_device_groups[] = {
 	&common_group,
+	&service_group,
 	NULL
 };
 
@@ -110,3 +268,14 @@ void usb4_port_device_remove(struct usb4_port *usb4)
 {
 	device_unregister(&usb4->dev);
 }
+
+/**
+ * usb4_port_device_resume() - Resumes USB4 port device
+ * @usb4: USB4 port device
+ *
+ * Used to resume USB4 port device after sleep state.
+ */
+int usb4_port_device_resume(struct usb4_port *usb4)
+{
+	return usb4->offline ? usb4_port_offline(usb4) : 0;
+}
-- 
2.30.2

