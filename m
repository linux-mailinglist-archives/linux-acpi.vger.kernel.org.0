Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5230433C
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 16:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403965AbhAZP7h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 10:59:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:61215 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404422AbhAZP7R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 10:59:17 -0500
IronPort-SDR: eRCuEZtWuoffOHde6tSHyIweA9lnE7PoXXqdIKPoVe3RAiskoyh7rLNhuOQej80hBvEDQ6G3oq
 M7zP1DI/hYoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="241451039"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="241451039"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 07:57:31 -0800
IronPort-SDR: 0XPj4otM8pXRSCEteCtg4rRlT7irZkGBlQR3xFjmvYmFkh0m++fJ8It6cVfO0OwTerGoBRDQAi
 yArEsOBmkFuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387869735"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 26 Jan 2021 07:57:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 64F30413; Tue, 26 Jan 2021 17:57:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 6/6] thunderbolt: Add support for native USB4 _OSC
Date:   Tue, 26 Jan 2021 18:57:23 +0300
Message-Id: <20210126155723.9388-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 6.4 introduced a new _OSC capability used to negotiate whether the
OS is supposed to use Software (native) or Firmware based Connection
Manager. If the native support is granted then there are set of bits
that enable/disable different tunnel types that the Software Connection
Manager is allowed to tunnel.

This adds support for this new USB4 _OSC accordingly. When PCIe
tunneling is disabled then the driver switches security level to be
"nopcie" following the security level 5 used in Firmware based
Connection Manager.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/acpi.c    | 65 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/nhi.c     | 27 +++++++++++++--
 drivers/thunderbolt/tb.c      | 19 +++++++++-
 drivers/thunderbolt/tb.h      | 12 +++++++
 drivers/thunderbolt/tunnel.c  | 10 +++---
 drivers/thunderbolt/usb4.c    | 11 ++++--
 drivers/thunderbolt/xdomain.c |  2 +-
 7 files changed, 134 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index b5442f979b4d..35fa17f7e599 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -115,3 +115,68 @@ void tb_acpi_add_links(struct tb_nhi *nhi)
 	if (ACPI_FAILURE(status))
 		dev_warn(&nhi->pdev->dev, "failed to enumerate tunneled ports\n");
 }
+
+/**
+ * tb_acpi_is_native() - Did the platform grant native TBT/USB4 control
+ *
+ * Returns %true if the platform granted OS native control over
+ * TBT/USB4. In this case software based connection manager can be used,
+ * otherwise there is firmware based connection manager running.
+ */
+bool tb_acpi_is_native(void)
+{
+	return osc_sb_native_usb4_support_confirmed &&
+	       osc_sb_native_usb4_control;
+}
+
+/**
+ * tb_acpi_may_tunnel_usb3() - Is USB3 tunneling allowed by the platform
+ *
+ * When software based connection manager is used, this function
+ * returns %true if platform allows native USB3 tunneling.
+ */
+bool tb_acpi_may_tunnel_usb3(void)
+{
+	if (tb_acpi_is_native())
+		return osc_sb_native_usb4_control & OSC_USB_USB3_TUNNELING;
+	return true;
+}
+
+/**
+ * tb_acpi_may_tunnel_dp() - Is DisplayPort tunneling allowed by the platform
+ *
+ * When software based connection manager is used, this function
+ * returns %true if platform allows native DP tunneling.
+ */
+bool tb_acpi_may_tunnel_dp(void)
+{
+	if (tb_acpi_is_native())
+		return osc_sb_native_usb4_control & OSC_USB_DP_TUNNELING;
+	return true;
+}
+
+/**
+ * tb_acpi_may_tunnel_pcie() - Is PCIe tunneling allowed by the platform
+ *
+ * When software based connection manager is used, this function
+ * returns %true if platform allows native PCIe tunneling.
+ */
+bool tb_acpi_may_tunnel_pcie(void)
+{
+	if (tb_acpi_is_native())
+		return osc_sb_native_usb4_control & OSC_USB_PCIE_TUNNELING;
+	return true;
+}
+
+/**
+ * tb_acpi_is_xdomain_allowed() - Are XDomain connections allowed
+ *
+ * When software based connection manager is used, this function
+ * returns %true if platform allows XDomain connections.
+ */
+bool tb_acpi_is_xdomain_allowed(void)
+{
+	if (tb_acpi_is_native())
+		return osc_sb_native_usb4_control & OSC_USB_XDOMAIN;
+	return true;
+}
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index cfc622da4f83..2ea953c853bd 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1188,6 +1188,29 @@ static void tb_apple_add_links(struct tb_nhi *nhi)
 	}
 }
 
+static struct tb *nhi_select_cm(struct tb_nhi *nhi)
+{
+	struct tb *tb;
+
+	/*
+	 * USB4 case is simple. If we got control of any of the
+	 * capabilities, we use software CM.
+	 */
+	if (tb_acpi_is_native())
+		return tb_probe(nhi);
+
+	/*
+	 * Either firmware based CM is running (we did not get control
+	 * from the firmware) or this is pre-USB4 PC so try first
+	 * firmware CM and then fallback to software CM.
+	 */
+	tb = icm_probe(nhi);
+	if (!tb)
+		tb = tb_probe(nhi);
+
+	return tb;
+}
+
 static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct tb_nhi *nhi;
@@ -1256,9 +1279,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	tb_apple_add_links(nhi);
 	tb_acpi_add_links(nhi);
 
-	tb = icm_probe(nhi);
-	if (!tb)
-		tb = tb_probe(nhi);
+	tb = nhi_select_cm(nhi);
 	if (!tb) {
 		dev_err(&nhi->pdev->dev,
 			"failed to determine connection manager, aborting\n");
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 4a99cc3913c9..122b32640552 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -437,6 +437,11 @@ static int tb_tunnel_usb3(struct tb *tb, struct tb_switch *sw)
 	struct tb_cm *tcm = tb_priv(tb);
 	struct tb_tunnel *tunnel;
 
+	if (!tb_acpi_may_tunnel_usb3()) {
+		tb_dbg(tb, "USB3 tunneling disabled, not creating tunnel\n");
+		return 0;
+	}
+
 	up = tb_switch_find_port(sw, TB_TYPE_USB3_UP);
 	if (!up)
 		return 0;
@@ -512,6 +517,9 @@ static int tb_create_usb3_tunnels(struct tb_switch *sw)
 	struct tb_port *port;
 	int ret;
 
+	if (!tb_acpi_may_tunnel_usb3())
+		return 0;
+
 	if (tb_route(sw)) {
 		ret = tb_tunnel_usb3(sw->tb, sw);
 		if (ret)
@@ -841,6 +849,11 @@ static void tb_tunnel_dp(struct tb *tb)
 	struct tb_port *port, *in, *out;
 	struct tb_tunnel *tunnel;
 
+	if (!tb_acpi_may_tunnel_dp()) {
+		tb_dbg(tb, "DP tunneling disabled, not creating tunnel\n");
+		return;
+	}
+
 	/*
 	 * Find pair of inactive DP IN and DP OUT adapters and then
 	 * establish a DP tunnel between them.
@@ -1549,7 +1562,11 @@ struct tb *tb_probe(struct tb_nhi *nhi)
 	if (!tb)
 		return NULL;
 
-	tb->security_level = TB_SECURITY_USER;
+	if (tb_acpi_may_tunnel_pcie())
+		tb->security_level = TB_SECURITY_USER;
+	else
+		tb->security_level = TB_SECURITY_NOPCIE;
+
 	tb->cm_ops = &tb_cm_ops;
 
 	tcm = tb_priv(tb);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 01fe849e9d4c..4dd4ff79dede 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1039,8 +1039,20 @@ void tb_check_quirks(struct tb_switch *sw);
 
 #ifdef CONFIG_ACPI
 void tb_acpi_add_links(struct tb_nhi *nhi);
+
+bool tb_acpi_is_native(void);
+bool tb_acpi_may_tunnel_usb3(void);
+bool tb_acpi_may_tunnel_dp(void);
+bool tb_acpi_may_tunnel_pcie(void);
+bool tb_acpi_is_xdomain_allowed(void);
 #else
 static inline void tb_acpi_add_links(struct tb_nhi *nhi) { }
+
+static inline bool tb_acpi_is_native(void) { return true; }
+static inline bool tb_acpi_may_tunnel_usb3(void) { return true; }
+static inline bool tb_acpi_may_tunnel_dp(void) { return true; }
+static inline bool tb_acpi_may_tunnel_pcie(void) { return true; }
+static inline bool tb_acpi_is_xdomain_allowed(void) { return true; }
 #endif
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index dcdf9c7a9cae..5d3110e604bc 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -932,12 +932,14 @@ static int tb_usb3_activate(struct tb_tunnel *tunnel, bool activate)
 static int tb_usb3_consumed_bandwidth(struct tb_tunnel *tunnel,
 		int *consumed_up, int *consumed_down)
 {
+	int pcie_enabled = tb_acpi_may_tunnel_pcie();
+
 	/*
-	 * PCIe tunneling affects the USB3 bandwidth so take that it
-	 * into account here.
+	 * PCIe tunneling, if enabled, affects the USB3 bandwidth so
+	 * take that it into account here.
 	 */
-	*consumed_up = tunnel->allocated_up * (3 + 1) / 3;
-	*consumed_down = tunnel->allocated_down * (3 + 1) / 3;
+	*consumed_up = tunnel->allocated_up * (3 + pcie_enabled) / 3;
+	*consumed_down = tunnel->allocated_down * (3 + pcie_enabled) / 3;
 	return 0;
 }
 
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 67a2867382ed..680bc738dd66 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -331,13 +331,18 @@ int usb4_switch_setup(struct tb_switch *sw)
 	if (ret)
 		return ret;
 
-	if (sw->link_usb4 && tb_switch_find_port(parent, TB_TYPE_USB3_DOWN)) {
+	if (tb_acpi_may_tunnel_usb3() && sw->link_usb4 &&
+	    tb_switch_find_port(parent, TB_TYPE_USB3_DOWN)) {
 		val |= ROUTER_CS_5_UTO;
 		xhci = false;
 	}
 
-	/* Only enable PCIe tunneling if the parent router supports it */
-	if (tb_switch_find_port(parent, TB_TYPE_PCIE_DOWN)) {
+	/*
+	 * Only enable PCIe tunneling if the parent router supports it
+	 * and it is not disabled.
+	 */
+	if (tb_acpi_may_tunnel_pcie() &&
+	    tb_switch_find_port(parent, TB_TYPE_PCIE_DOWN)) {
 		val |= ROUTER_CS_5_PTO;
 		/*
 		 * xHCI can be enabled if PCIe tunneling is supported
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 655ae4fefd69..a7af869e234b 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -53,7 +53,7 @@ static const uuid_t tb_xdp_uuid =
 
 bool tb_is_xdomain_enabled(void)
 {
-	return tb_xdomain_enabled;
+	return tb_xdomain_enabled && tb_acpi_is_xdomain_allowed();
 }
 
 static bool tb_xdomain_match(const struct tb_cfg_request *req,
-- 
2.29.2

