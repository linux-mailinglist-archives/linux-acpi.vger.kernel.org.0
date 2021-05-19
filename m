Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878A7388FFD
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347060AbhESOOD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 10:14:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:2931 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242155AbhESOOC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 10:14:02 -0400
IronPort-SDR: FHPOMwBcA1IaDOsDKO+Fe8di4XeaLE/pl9+WjEvAdhRcE2E+SwHwIbbcxSs7ByxFADllIcNptN
 QSVxC37pf3cw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="181262846"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181262846"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 07:12:41 -0700
IronPort-SDR: Ar50fbapodIp7ooujhcBYNXIdEmayHiAeMdu89kOg861npqKS+aSato3O02cYKJubKz+EQGPia
 66yShqLMPavg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="474589579"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2021 07:12:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7774155A; Wed, 19 May 2021 17:12:59 +0300 (EEST)
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
Subject: [PATCH 3/9] thunderbolt: Add support for ACPI _DSM to power on/off retimers
Date:   Wed, 19 May 2021 17:12:53 +0300
Message-Id: <20210519141259.84839-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rajmohan Mani <rajmohan.mani@intel.com>

Typically retimers can be accessed only when the USB4 link is up (e.g
there is a cable connected). However, sometimes it is useful to be able
to access retimers even if there is nothing connected to the USB4 port.
For instance we may still want to be able to upgrade the retimer NVM
firmware even if the user does not have any USB4 devices. This is
something that USB4 spec leaves to implementers.

In case of ACPI based systems, we can support this by providing a
special _DSM method under each USB4 port. This _DSM can be used to turn
on power to on-board retimers (and cycle it through different modes so
that the sideband becomes usable).

This patch adds support for this _DSM and makes the functionality
available to the rest of the driver through tb_acpi_power_[on|off]_retimers().

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/acpi.c   | 206 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/domain.c |   9 +-
 drivers/thunderbolt/tb.h     |  13 +++
 3 files changed, 225 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index 35fa17f7e599..b67e72d5644b 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -180,3 +180,209 @@ bool tb_acpi_is_xdomain_allowed(void)
 		return osc_sb_native_usb4_control & OSC_USB_XDOMAIN;
 	return true;
 }
+
+/* UUID for retimer _DSM: e0053122-795b-4122-8a5e-57be1d26acb3 */
+static const guid_t retimer_dsm_guid =
+	GUID_INIT(0xe0053122, 0x795b, 0x4122,
+		  0x8a, 0x5e, 0x57, 0xbe, 0x1d, 0x26, 0xac, 0xb3);
+
+#define RETIMER_DSM_QUERY_ONLINE_STATE	1
+#define RETIMER_DSM_SET_ONLINE_STATE	2
+
+static int tb_acpi_retimer_set_power(struct tb_port *port, bool power)
+{
+	struct usb4_port *usb4 = port->usb4;
+	union acpi_object argv4[2];
+	struct acpi_device *adev;
+	union acpi_object *obj;
+	int ret;
+
+	if (!usb4->can_offline)
+		return 0;
+
+	adev = ACPI_COMPANION(&usb4->dev);
+	if (WARN_ON(!adev))
+		return 0;
+
+	/* Check if we are already powered on (and in correct mode) */
+	obj = acpi_evaluate_dsm_typed(adev->handle, &retimer_dsm_guid, 1,
+				      RETIMER_DSM_QUERY_ONLINE_STATE, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		tb_port_warn(port, "ACPI: query online _DSM failed\n");
+		return -EIO;
+	}
+
+	ret = obj->integer.value;
+	ACPI_FREE(obj);
+
+	if (power == ret)
+		return 0;
+
+	tb_port_dbg(port, "ACPI: calling _DSM to power %s retimers\n",
+		    power ? "on" : "off");
+
+	argv4[0].type = ACPI_TYPE_PACKAGE;
+	argv4[0].package.count = 1;
+	argv4[0].package.elements = &argv4[1];
+	argv4[1].integer.type = ACPI_TYPE_INTEGER;
+	argv4[1].integer.value = power;
+
+	obj = acpi_evaluate_dsm_typed(adev->handle, &retimer_dsm_guid, 1,
+				      RETIMER_DSM_SET_ONLINE_STATE, argv4,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		tb_port_warn(port,
+			     "ACPI: set online state _DSM evaluation failed\n");
+		return -EIO;
+	}
+
+	ret = obj->integer.value;
+	ACPI_FREE(obj);
+
+	if (ret >= 0) {
+		if (power)
+			return ret == 1 ? 0 : -EBUSY;
+		return 0;
+	}
+
+	tb_port_warn(port, "ACPI: set online state _DSM failed with error %d\n", ret);
+	return -EIO;
+}
+
+/**
+ * tb_acpi_power_on_retimers() - Call platform to power on retimers
+ * @port: USB4 port
+ *
+ * Calls platform to turn on power to all retimers behind this USB4
+ * port. After this function returns successfully the caller can
+ * continue with the normal retimer flows (as specified in the USB4
+ * spec). Note if this returns %-EBUSY it means the type-C port is in
+ * non-USB4/TBT mode (there is non-USB4/TBT device connected).
+ *
+ * This should only be called if the USB4/TBT link is not up.
+ *
+ * Returns %0 on success.
+ */
+int tb_acpi_power_on_retimers(struct tb_port *port)
+{
+	return tb_acpi_retimer_set_power(port, true);
+}
+
+/**
+ * tb_acpi_power_off_retimers() - Call platform to power off retimers
+ * @port: USB4 port
+ *
+ * This is the opposite of tb_acpi_power_on_retimers(). After returning
+ * successfully the normal operations with the @port can continue.
+ *
+ * Returns %0 on success.
+ */
+int tb_acpi_power_off_retimers(struct tb_port *port)
+{
+	return tb_acpi_retimer_set_power(port, false);
+}
+
+static bool tb_acpi_bus_match(struct device *dev)
+{
+	return tb_is_switch(dev) || tb_is_usb4_port_device(dev);
+}
+
+static struct acpi_device *tb_acpi_find_port(struct acpi_device *adev,
+					     const struct tb_port *port)
+{
+	struct acpi_device *port_adev;
+
+	if (!adev)
+		return NULL;
+
+	/*
+	 * Device routers exists under the downstream facing USB4 port
+	 * of the parent router. Their _ADR is always 0.
+	 */
+	list_for_each_entry(port_adev, &adev->children, node) {
+		if (acpi_device_adr(port_adev) == port->port)
+			return port_adev;
+	}
+
+	return NULL;
+}
+
+static struct acpi_device *tb_acpi_switch_find_companion(struct tb_switch *sw)
+{
+	struct acpi_device *adev = NULL;
+	struct tb_switch *parent_sw;
+
+	parent_sw = tb_switch_parent(sw);
+	if (parent_sw) {
+		struct tb_port *port = tb_port_at(tb_route(sw), parent_sw);
+		struct acpi_device *port_adev;
+
+		port_adev = tb_acpi_find_port(ACPI_COMPANION(&parent_sw->dev), port);
+		if (port_adev)
+			adev = acpi_find_child_device(port_adev, 0, false);
+	} else {
+		struct tb_nhi *nhi = sw->tb->nhi;
+		struct acpi_device *parent_adev;
+
+		parent_adev = ACPI_COMPANION(&nhi->pdev->dev);
+		if (parent_adev)
+			adev = acpi_find_child_device(parent_adev, 0, false);
+	}
+
+	return adev;
+}
+
+static struct acpi_device *tb_acpi_find_companion(struct device *dev)
+{
+	/*
+	 * The Thunderbolt/USB4 hierarchy looks like following:
+	 *
+	 * Device (NHI)
+	 *   Device (HR)		// Host router _ADR == 0
+	 *      Device (DFP0)		// Downstream port _ADR == lane 0 adapter
+	 *        Device (DR)		// Device router _ADR == 0
+	 *          Device (UFP)	// Upstream port _ADR == lane 0 adapter
+	 *      Device (DFP1)		// Downstream port _ADR == lane 0 adapter number
+	 *
+	 * At the moment we bind the host router to the corresponding
+	 * Linux device.
+	 */
+	if (tb_is_switch(dev))
+		return tb_acpi_switch_find_companion(tb_to_switch(dev));
+	else if (tb_is_usb4_port_device(dev))
+		return tb_acpi_find_port(ACPI_COMPANION(dev->parent),
+					 tb_to_usb4_port_device(dev)->port);
+	return NULL;
+}
+
+static void tb_acpi_setup(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct usb4_port *usb4 = tb_to_usb4_port_device(dev);
+
+	if (!adev || !usb4)
+		return;
+
+	if (acpi_check_dsm(adev->handle, &retimer_dsm_guid, 1,
+			   BIT(RETIMER_DSM_QUERY_ONLINE_STATE) |
+			   BIT(RETIMER_DSM_SET_ONLINE_STATE)))
+		usb4->can_offline = true;
+}
+
+static struct acpi_bus_type tb_acpi_bus = {
+	.name = "thunderbolt",
+	.match = tb_acpi_bus_match,
+	.find_companion = tb_acpi_find_companion,
+	.setup = tb_acpi_setup,
+};
+
+int tb_acpi_init(void)
+{
+	return register_acpi_bus_type(&tb_acpi_bus);
+}
+
+void tb_acpi_exit(void)
+{
+	unregister_acpi_bus_type(&tb_acpi_bus);
+}
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 98f4056f89ff..a062befcb3b2 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -881,11 +881,12 @@ int tb_domain_init(void)
 	int ret;
 
 	tb_test_init();
-
 	tb_debugfs_init();
+	tb_acpi_init();
+
 	ret = tb_xdomain_init();
 	if (ret)
-		goto err_debugfs;
+		goto err_acpi;
 	ret = bus_register(&tb_bus_type);
 	if (ret)
 		goto err_xdomain;
@@ -894,7 +895,8 @@ int tb_domain_init(void)
 
 err_xdomain:
 	tb_xdomain_exit();
-err_debugfs:
+err_acpi:
+	tb_acpi_exit();
 	tb_debugfs_exit();
 	tb_test_exit();
 
@@ -907,6 +909,7 @@ void tb_domain_exit(void)
 	ida_destroy(&tb_domain_ida);
 	tb_nvm_exit();
 	tb_xdomain_exit();
+	tb_acpi_exit();
 	tb_debugfs_exit();
 	tb_test_exit();
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 948e7601428f..c5704f495afa 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -247,10 +247,13 @@ struct tb_port {
  * struct usb4_port - USB4 port device
  * @dev: Device for the port
  * @port: Pointer to the lane 0 adapter
+ * @can_offline: Does the port have necessary platform support to moved
+ *		 it into offline mode and back
  */
 struct usb4_port {
 	struct device dev;
 	struct tb_port *port;
+	bool can_offline;
 };
 
 /**
@@ -1113,6 +1116,11 @@ bool tb_acpi_may_tunnel_usb3(void);
 bool tb_acpi_may_tunnel_dp(void);
 bool tb_acpi_may_tunnel_pcie(void);
 bool tb_acpi_is_xdomain_allowed(void);
+
+int tb_acpi_init(void);
+void tb_acpi_exit(void);
+int tb_acpi_power_on_retimers(struct tb_port *port);
+int tb_acpi_power_off_retimers(struct tb_port *port);
 #else
 static inline void tb_acpi_add_links(struct tb_nhi *nhi) { }
 
@@ -1121,6 +1129,11 @@ static inline bool tb_acpi_may_tunnel_usb3(void) { return true; }
 static inline bool tb_acpi_may_tunnel_dp(void) { return true; }
 static inline bool tb_acpi_may_tunnel_pcie(void) { return true; }
 static inline bool tb_acpi_is_xdomain_allowed(void) { return true; }
+
+static inline int tb_acpi_init(void) { return 0; }
+static inline void tb_acpi_exit(void) { }
+static inline int tb_acpi_power_on_retimers(struct tb_port *port) { return 0; }
+static inline int tb_acpi_power_off_retimers(struct tb_port *port) { return 0; }
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.30.2

