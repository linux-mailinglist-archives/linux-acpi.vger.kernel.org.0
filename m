Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8136A92227
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 13:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfHSLWs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 07:22:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:16982 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbfHSLWd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Aug 2019 07:22:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 04:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="202264277"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2019 04:22:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 00E7F2C2; Mon, 19 Aug 2019 14:22:23 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Raanan Avargil <raanan.avargil@intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 7/8] thunderbolt: Add support for Intel Ice Lake
Date:   Mon, 19 Aug 2019 14:22:22 +0300
Message-Id: <20190819112223.15359-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
References: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Thunderbolt controller is integrated into the Ice Lake CPU itself
and requires special flows to power it on and off using force power bit
in NHI VSEC registers. Runtime PM (RTD3) and Sx flows also differ from
the discrete solutions. Now the firmware notifies the driver whether
RTD3 entry or exit are possible. The driver is responsible of sending
Go2Sx command through link controller mailbox when system enters Sx
states (suspend-to-mem/disk). Rest of the ICM firwmare flows follow
Titan Ridge.

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Yehezkel Bernat <YehezkelShB@gmail.com>
---
 drivers/thunderbolt/Makefile   |   2 +-
 drivers/thunderbolt/icm.c      | 176 ++++++++++++++++++++++++++++++--
 drivers/thunderbolt/nhi.c      | 112 +++++++++++++++++++--
 drivers/thunderbolt/nhi.h      |  22 ++++
 drivers/thunderbolt/nhi_ops.c  | 179 +++++++++++++++++++++++++++++++++
 drivers/thunderbolt/nhi_regs.h |  37 +++++++
 drivers/thunderbolt/switch.c   |   2 +
 drivers/thunderbolt/tb_msgs.h  |  16 ++-
 include/linux/thunderbolt.h    |   2 +
 9 files changed, 526 insertions(+), 22 deletions(-)
 create mode 100644 drivers/thunderbolt/nhi_ops.c

diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index 3f55cb3c81b2..001187c577bf 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-${CONFIG_THUNDERBOLT} := thunderbolt.o
-thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel.o eeprom.o
+thunderbolt-objs := nhi.o nhi_ops.o ctl.o tb.o switch.o cap.o path.o tunnel.o eeprom.o
 thunderbolt-objs += domain.o dma_port.o icm.o property.o xdomain.o lc.o
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e9835ab35465..245588f691e7 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -56,16 +56,19 @@
  * @max_boot_acl: Maximum number of preboot ACL entries (%0 if not supported)
  * @rpm: Does the controller support runtime PM (RTD3)
  * @can_upgrade_nvm: Can the NVM firmware be upgrade on this controller
+ * @veto: Is RTD3 veto in effect
  * @is_supported: Checks if we can support ICM on this controller
  * @cio_reset: Trigger CIO reset
  * @get_mode: Read and return the ICM firmware mode (optional)
  * @get_route: Find a route string for given switch
  * @save_devices: Ask ICM to save devices to ACL when suspending (optional)
  * @driver_ready: Send driver ready message to ICM
+ * @set_uuid: Set UUID for the root switch (optional)
  * @device_connected: Handle device connected ICM message
  * @device_disconnected: Handle device disconnected ICM message
  * @xdomain_connected - Handle XDomain connected ICM message
  * @xdomain_disconnected - Handle XDomain disconnected ICM message
+ * @rtd3_veto: Handle RTD3 veto notification ICM message
  */
 struct icm {
 	struct mutex request_lock;
@@ -76,6 +79,7 @@ struct icm {
 	bool safe_mode;
 	bool rpm;
 	bool can_upgrade_nvm;
+	bool veto;
 	bool (*is_supported)(struct tb *tb);
 	int (*cio_reset)(struct tb *tb);
 	int (*get_mode)(struct tb *tb);
@@ -84,6 +88,7 @@ struct icm {
 	int (*driver_ready)(struct tb *tb,
 			    enum tb_security_level *security_level,
 			    size_t *nboot_acl, bool *rpm);
+	void (*set_uuid)(struct tb *tb);
 	void (*device_connected)(struct tb *tb,
 				 const struct icm_pkg_header *hdr);
 	void (*device_disconnected)(struct tb *tb,
@@ -92,6 +97,7 @@ struct icm {
 				  const struct icm_pkg_header *hdr);
 	void (*xdomain_disconnected)(struct tb *tb,
 				     const struct icm_pkg_header *hdr);
+	void (*rtd3_veto)(struct tb *tb, const struct icm_pkg_header *hdr);
 };
 
 struct icm_notification {
@@ -296,6 +302,43 @@ static int icm_request(struct tb *tb, const void *request, size_t request_size,
 	return -ETIMEDOUT;
 }
 
+/*
+ * If rescan is queued to run (we are resuming), postpone it to give the
+ * firmware some more time to send device connected notifications for next
+ * devices in the chain.
+ */
+static void icm_postpone_rescan(struct tb *tb)
+{
+	struct icm *icm = tb_priv(tb);
+
+	if (delayed_work_pending(&icm->rescan_work))
+		mod_delayed_work(tb->wq, &icm->rescan_work,
+				 msecs_to_jiffies(500));
+}
+
+static void icm_veto_begin(struct tb *tb)
+{
+	struct icm *icm = tb_priv(tb);
+
+	if (!icm->veto) {
+		icm->veto = true;
+		/* Keep the domain powered while veto is in effect */
+		pm_runtime_get(&tb->dev);
+	}
+}
+
+static void icm_veto_end(struct tb *tb)
+{
+	struct icm *icm = tb_priv(tb);
+
+	if (icm->veto) {
+		icm->veto = false;
+		/* Allow the domain suspend now */
+		pm_runtime_mark_last_busy(&tb->dev);
+		pm_runtime_put_autosuspend(&tb->dev);
+	}
+}
+
 static bool icm_fr_is_supported(struct tb *tb)
 {
 	return !x86_apple_machine;
@@ -519,14 +562,16 @@ static int icm_fr_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 	return 0;
 }
 
-static void add_switch(struct tb_switch *parent_sw, u64 route,
-		       const uuid_t *uuid, const u8 *ep_name,
-		       size_t ep_name_size, u8 connection_id, u8 connection_key,
-		       u8 link, u8 depth, enum tb_security_level security_level,
-		       bool authorized, bool boot)
+static struct tb_switch *add_switch(struct tb_switch *parent_sw, u64 route,
+				    const uuid_t *uuid, const u8 *ep_name,
+				    size_t ep_name_size, u8 connection_id,
+				    u8 connection_key, u8 link, u8 depth,
+				    enum tb_security_level security_level,
+				    bool authorized, bool boot)
 {
 	const struct intel_vss *vss;
 	struct tb_switch *sw;
+	int ret;
 
 	pm_runtime_get_sync(&parent_sw->dev);
 
@@ -557,14 +602,18 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 	tb_port_at(route, parent_sw)->remote = tb_upstream_port(sw);
 	tb_upstream_port(sw)->remote = tb_port_at(route, parent_sw);
 
-	if (tb_switch_add(sw)) {
+	ret = tb_switch_add(sw);
+	if (ret) {
 		tb_port_at(tb_route(sw), parent_sw)->remote = NULL;
 		tb_switch_put(sw);
+		sw = ERR_PTR(ret);
 	}
 
 out:
 	pm_runtime_mark_last_busy(&parent_sw->dev);
 	pm_runtime_put_autosuspend(&parent_sw->dev);
+
+	return sw;
 }
 
 static void update_switch(struct tb_switch *parent_sw, struct tb_switch *sw,
@@ -656,6 +705,8 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	u64 route;
 	int ret;
 
+	icm_postpone_rescan(tb);
+
 	link = pkg->link_info & ICM_LINK_INFO_LINK_MASK;
 	depth = (pkg->link_info & ICM_LINK_INFO_DEPTH_MASK) >>
 		ICM_LINK_INFO_DEPTH_SHIFT;
@@ -1086,7 +1137,8 @@ static int icm_tr_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 }
 
 static void
-icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
+__icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
+			  bool force_rtd3)
 {
 	const struct icm_tr_event_device_connected *pkg =
 		(const struct icm_tr_event_device_connected *)hdr;
@@ -1096,6 +1148,8 @@ icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	bool authorized, boot;
 	u64 route;
 
+	icm_postpone_rescan(tb);
+
 	/*
 	 * Currently we don't use the QoS information coming with the
 	 * device connected message so simply just ignore that extra
@@ -1151,13 +1205,21 @@ icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		return;
 	}
 
-	add_switch(parent_sw, route, &pkg->ep_uuid, (const u8 *)pkg->ep_name,
-		   sizeof(pkg->ep_name), pkg->connection_id,
-		   0, 0, 0, security_level, authorized, boot);
+	sw = add_switch(parent_sw, route, &pkg->ep_uuid, (const u8 *)pkg->ep_name,
+			sizeof(pkg->ep_name), pkg->connection_id, 0, 0, 0,
+			security_level, authorized, boot);
+	if (!IS_ERR(sw) && force_rtd3)
+		sw->rpm = true;
 
 	tb_switch_put(parent_sw);
 }
 
+static void
+icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
+{
+	__icm_tr_device_connected(tb, hdr, false);
+}
+
 static void
 icm_tr_device_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 {
@@ -1468,6 +1530,61 @@ static int icm_ar_set_boot_acl(struct tb *tb, const uuid_t *uuids,
 	return 0;
 }
 
+static int
+icm_icl_driver_ready(struct tb *tb, enum tb_security_level *security_level,
+		    size_t *nboot_acl, bool *rpm)
+{
+	struct icm_tr_pkg_driver_ready_response reply;
+	struct icm_pkg_driver_ready request = {
+		.hdr.code = ICM_DRIVER_READY,
+	};
+	int ret;
+
+	memset(&reply, 0, sizeof(reply));
+	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
+			  1, 20000);
+	if (ret)
+		return ret;
+
+	/* Ice Lake always supports RTD3 */
+	if (rpm)
+		*rpm = true;
+
+	return 0;
+}
+
+static void icm_icl_set_uuid(struct tb *tb)
+{
+	struct tb_nhi *nhi = tb->nhi;
+	u32 uuid[4];
+
+	pci_read_config_dword(nhi->pdev, VS_CAP_10, &uuid[0]);
+	pci_read_config_dword(nhi->pdev, VS_CAP_11, &uuid[1]);
+	uuid[2] = 0xffffffff;
+	uuid[3] = 0xffffffff;
+
+	tb->root_switch->uuid = kmemdup(uuid, sizeof(uuid), GFP_KERNEL);
+}
+
+static void
+icm_icl_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
+{
+	__icm_tr_device_connected(tb, hdr, true);
+}
+
+static void icm_icl_rtd3_veto(struct tb *tb, const struct icm_pkg_header *hdr)
+{
+	const struct icm_icl_event_rtd3_veto *pkg =
+		(const struct icm_icl_event_rtd3_veto *)hdr;
+
+	tb_dbg(tb, "ICM rtd3 veto=0x%08x\n", pkg->veto_reason);
+
+	if (pkg->veto_reason)
+		icm_veto_begin(tb);
+	else
+		icm_veto_end(tb);
+}
+
 static void icm_handle_notification(struct work_struct *work)
 {
 	struct icm_notification *n = container_of(work, typeof(*n), work);
@@ -1495,6 +1612,9 @@ static void icm_handle_notification(struct work_struct *work)
 		case ICM_EVENT_XDOMAIN_DISCONNECTED:
 			icm->xdomain_disconnected(tb, n->pkg);
 			break;
+		case ICM_EVENT_RTD3_VETO:
+			icm->rtd3_veto(tb, n->pkg);
+			break;
 		}
 	}
 
@@ -1853,6 +1973,13 @@ static void icm_complete(struct tb *tb)
 	if (tb->nhi->going_away)
 		return;
 
+	/*
+	 * If RTD3 was vetoed before we entered system suspend allow it
+	 * again now before driver ready is sent. Firmware sends a new RTD3
+	 * veto if it is still the case after we have sent it driver ready
+	 * command.
+	 */
+	icm_veto_end(tb);
 	icm_unplug_children(tb->root_switch);
 
 	/*
@@ -1918,6 +2045,9 @@ static int icm_start(struct tb *tb)
 	tb->root_switch->no_nvm_upgrade = !icm->can_upgrade_nvm;
 	tb->root_switch->rpm = icm->rpm;
 
+	if (icm->set_uuid)
+		icm->set_uuid(tb);
+
 	ret = tb_switch_add(tb->root_switch);
 	if (ret) {
 		tb_switch_put(tb->root_switch);
@@ -2002,6 +2132,19 @@ static const struct tb_cm_ops icm_tr_ops = {
 	.disconnect_xdomain_paths = icm_tr_disconnect_xdomain_paths,
 };
 
+/* Ice Lake */
+static const struct tb_cm_ops icm_icl_ops = {
+	.driver_ready = icm_driver_ready,
+	.start = icm_start,
+	.stop = icm_stop,
+	.complete = icm_complete,
+	.runtime_suspend = icm_runtime_suspend,
+	.runtime_resume = icm_runtime_resume,
+	.handle_event = icm_handle_event,
+	.approve_xdomain_paths = icm_tr_approve_xdomain_paths,
+	.disconnect_xdomain_paths = icm_tr_disconnect_xdomain_paths,
+};
+
 struct tb *icm_probe(struct tb_nhi *nhi)
 {
 	struct icm *icm;
@@ -2070,6 +2213,19 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 		icm->xdomain_disconnected = icm_tr_xdomain_disconnected;
 		tb->cm_ops = &icm_tr_ops;
 		break;
+
+	case PCI_DEVICE_ID_INTEL_ICL_NHI0:
+	case PCI_DEVICE_ID_INTEL_ICL_NHI1:
+		icm->is_supported = icm_ar_is_supported;
+		icm->driver_ready = icm_icl_driver_ready;
+		icm->set_uuid = icm_icl_set_uuid;
+		icm->device_connected = icm_icl_device_connected;
+		icm->device_disconnected = icm_tr_device_disconnected;
+		icm->xdomain_connected = icm_tr_xdomain_connected;
+		icm->xdomain_disconnected = icm_tr_xdomain_disconnected;
+		icm->rtd3_veto = icm_icl_rtd3_veto;
+		tb->cm_ops = &icm_icl_ops;
+		break;
 	}
 
 	if (!icm->is_supported || !icm->is_supported(tb)) {
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 9c782706e652..641b21b54460 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/property.h>
 
 #include "nhi.h"
 #include "nhi_regs.h"
@@ -859,12 +860,52 @@ static irqreturn_t nhi_msi(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int nhi_suspend_noirq(struct device *dev)
+static int __nhi_suspend_noirq(struct device *dev, bool wakeup)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct tb *tb = pci_get_drvdata(pdev);
+	struct tb_nhi *nhi = tb->nhi;
+	int ret;
+
+	ret = tb_domain_suspend_noirq(tb);
+	if (ret)
+		return ret;
+
+	if (nhi->ops && nhi->ops->suspend_noirq) {
+		ret = nhi->ops->suspend_noirq(tb->nhi, wakeup);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int nhi_suspend_noirq(struct device *dev)
+{
+	return __nhi_suspend_noirq(dev, device_may_wakeup(dev));
+}
+
+static bool nhi_wake_supported(struct pci_dev *pdev)
+{
+	u8 val;
+
+	/*
+	 * If power rails are sustainable for wakeup from S4 this
+	 * property is set by the BIOS.
+	 */
+	if (device_property_read_u8(&pdev->dev, "WAKE_SUPPORTED", &val))
+		return !!val;
+
+	return true;
+}
+
+static int nhi_poweroff_noirq(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool wakeup;
 
-	return tb_domain_suspend_noirq(tb);
+	wakeup = device_may_wakeup(dev) && nhi_wake_supported(pdev);
+	return __nhi_suspend_noirq(dev, wakeup);
 }
 
 static void nhi_enable_int_throttling(struct tb_nhi *nhi)
@@ -887,16 +928,24 @@ static int nhi_resume_noirq(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct tb *tb = pci_get_drvdata(pdev);
+	struct tb_nhi *nhi = tb->nhi;
+	int ret;
 
 	/*
 	 * Check that the device is still there. It may be that the user
 	 * unplugged last device which causes the host controller to go
 	 * away on PCs.
 	 */
-	if (!pci_device_is_present(pdev))
-		tb->nhi->going_away = true;
-	else
+	if (!pci_device_is_present(pdev)) {
+		nhi->going_away = true;
+	} else {
+		if (nhi->ops && nhi->ops->resume_noirq) {
+			ret = nhi->ops->resume_noirq(nhi);
+			if (ret)
+				return ret;
+		}
 		nhi_enable_int_throttling(tb->nhi);
+	}
 
 	return tb_domain_resume_noirq(tb);
 }
@@ -929,16 +978,35 @@ static int nhi_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct tb *tb = pci_get_drvdata(pdev);
+	struct tb_nhi *nhi = tb->nhi;
+	int ret;
+
+	ret = tb_domain_runtime_suspend(tb);
+	if (ret)
+		return ret;
 
-	return tb_domain_runtime_suspend(tb);
+	if (nhi->ops && nhi->ops->runtime_suspend) {
+		ret = nhi->ops->runtime_suspend(tb->nhi);
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
 
 static int nhi_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct tb *tb = pci_get_drvdata(pdev);
+	struct tb_nhi *nhi = tb->nhi;
+	int ret;
+
+	if (nhi->ops && nhi->ops->runtime_resume) {
+		ret = nhi->ops->runtime_resume(nhi);
+		if (ret)
+			return ret;
+	}
 
-	nhi_enable_int_throttling(tb->nhi);
+	nhi_enable_int_throttling(nhi);
 	return tb_domain_runtime_resume(tb);
 }
 
@@ -966,6 +1034,9 @@ static void nhi_shutdown(struct tb_nhi *nhi)
 		flush_work(&nhi->interrupt_work);
 	}
 	ida_destroy(&nhi->msix_ida);
+
+	if (nhi->ops && nhi->ops->shutdown)
+		nhi->ops->shutdown(nhi);
 }
 
 static int nhi_init_msi(struct tb_nhi *nhi)
@@ -1010,12 +1081,27 @@ static int nhi_init_msi(struct tb_nhi *nhi)
 	return 0;
 }
 
+static bool nhi_imr_valid(struct pci_dev *pdev)
+{
+	u8 val;
+
+	if (!device_property_read_u8(&pdev->dev, "IMR_VALID", &val))
+		return !!val;
+
+	return true;
+}
+
 static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct tb_nhi *nhi;
 	struct tb *tb;
 	int res;
 
+	if (!nhi_imr_valid(pdev)) {
+		dev_warn(&pdev->dev, "firmware image not valid, aborting\n");
+		return -ENODEV;
+	}
+
 	res = pcim_enable_device(pdev);
 	if (res) {
 		dev_err(&pdev->dev, "cannot enable PCI device, aborting\n");
@@ -1033,6 +1119,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	nhi->pdev = pdev;
+	nhi->ops = (const struct tb_nhi_ops *)id->driver_data;
 	/* cannot fail - table is allocated bin pcim_iomap_regions */
 	nhi->iobase = pcim_iomap_table(pdev)[0];
 	nhi->hop_count = ioread32(nhi->iobase + REG_HOP_COUNT) & 0x3ff;
@@ -1065,6 +1152,12 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_master(pdev);
 
+	if (nhi->ops && nhi->ops->init) {
+		res = nhi->ops->init(nhi);
+		if (res)
+			return res;
+	}
+
 	tb = icm_probe(nhi);
 	if (!tb)
 		tb = tb_probe(nhi);
@@ -1125,6 +1218,7 @@ static const struct dev_pm_ops nhi_pm_ops = {
 	.restore_noirq = nhi_resume_noirq,
 	.suspend = nhi_suspend,
 	.freeze = nhi_suspend,
+	.poweroff_noirq = nhi_poweroff_noirq,
 	.poweroff = nhi_suspend,
 	.complete = nhi_complete,
 	.runtime_suspend = nhi_runtime_suspend,
@@ -1172,6 +1266,10 @@ static struct pci_device_id nhi_ids[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI) },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI) },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI) },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICL_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICL_NHI1),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
 
 	{ 0,}
 };
diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 1b5d47ecd3ed..b7b973949f8e 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -30,6 +30,26 @@ enum nhi_mailbox_cmd {
 int nhi_mailbox_cmd(struct tb_nhi *nhi, enum nhi_mailbox_cmd cmd, u32 data);
 enum nhi_fw_mode nhi_mailbox_mode(struct tb_nhi *nhi);
 
+/**
+ * struct tb_nhi_ops - NHI specific optional operations
+ * @init: NHI specific initialization
+ * @suspend_noirq: NHI specific suspend_noirq hook
+ * @resume_noirq: NHI specific resume_noirq hook
+ * @runtime_suspend: NHI specific runtime_suspend hook
+ * @runtime_resume: NHI specific runtime_resume hook
+ * @shutdown: NHI specific shutdown
+ */
+struct tb_nhi_ops {
+	int (*init)(struct tb_nhi *nhi);
+	int (*suspend_noirq)(struct tb_nhi *nhi, bool wakeup);
+	int (*resume_noirq)(struct tb_nhi *nhi);
+	int (*runtime_suspend)(struct tb_nhi *nhi);
+	int (*runtime_resume)(struct tb_nhi *nhi);
+	void (*shutdown)(struct tb_nhi *nhi);
+};
+
+extern const struct tb_nhi_ops icl_nhi_ops;
+
 /*
  * PCI IDs used in this driver from Win Ridge forward. There is no
  * need for the PCI quirk anymore as we will use ICM also on Apple
@@ -51,5 +71,7 @@ enum nhi_fw_mode nhi_mailbox_mode(struct tb_nhi *nhi);
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE	0x15ea
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI		0x15eb
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE	0x15ef
+#define PCI_DEVICE_ID_INTEL_ICL_NHI1			0x8a0d
+#define PCI_DEVICE_ID_INTEL_ICL_NHI0			0x8a17
 
 #endif
diff --git a/drivers/thunderbolt/nhi_ops.c b/drivers/thunderbolt/nhi_ops.c
new file mode 100644
index 000000000000..61cd09cef943
--- /dev/null
+++ b/drivers/thunderbolt/nhi_ops.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NHI specific operations
+ *
+ * Copyright (C) 2019, Intel Corporation
+ * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/suspend.h>
+
+#include "nhi.h"
+#include "nhi_regs.h"
+#include "tb.h"
+
+/* Ice Lake specific NHI operations */
+
+#define ICL_LC_MAILBOX_TIMEOUT	500 /* ms */
+
+static int check_for_device(struct device *dev, void *data)
+{
+	return tb_is_switch(dev);
+}
+
+static bool icl_nhi_is_device_connected(struct tb_nhi *nhi)
+{
+	struct tb *tb = pci_get_drvdata(nhi->pdev);
+	int ret;
+
+	ret = device_for_each_child(&tb->root_switch->dev, NULL,
+				    check_for_device);
+	return ret > 0;
+}
+
+static int icl_nhi_force_power(struct tb_nhi *nhi, bool power)
+{
+	u32 vs_cap;
+
+	/*
+	 * The Thunderbolt host controller is present always in Ice Lake
+	 * but the firmware may not be loaded and running (depending
+	 * whether there is device connected and so on). Each time the
+	 * controller is used we need to "Force Power" it first and wait
+	 * for the firmware to indicate it is up and running. This "Force
+	 * Power" is really not about actually powering on/off the
+	 * controller so it is accessible even if "Force Power" is off.
+	 *
+	 * The actual power management happens inside shared ACPI power
+	 * resources using standard ACPI methods.
+	 */
+	pci_read_config_dword(nhi->pdev, VS_CAP_22, &vs_cap);
+	if (power) {
+		vs_cap &= ~VS_CAP_22_DMA_DELAY_MASK;
+		vs_cap |= 0x22 << VS_CAP_22_DMA_DELAY_SHIFT;
+		vs_cap |= VS_CAP_22_FORCE_POWER;
+	} else {
+		vs_cap &= ~VS_CAP_22_FORCE_POWER;
+	}
+	pci_write_config_dword(nhi->pdev, VS_CAP_22, vs_cap);
+
+	if (power) {
+		unsigned int retries = 10;
+		u32 val;
+
+		/* Wait until the firmware tells it is up and running */
+		do {
+			pci_read_config_dword(nhi->pdev, VS_CAP_9, &val);
+			if (val & VS_CAP_9_FW_READY)
+				return 0;
+			msleep(250);
+		} while (--retries);
+
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void icl_nhi_lc_mailbox_cmd(struct tb_nhi *nhi, enum icl_lc_mailbox_cmd cmd)
+{
+	u32 data;
+
+	pci_read_config_dword(nhi->pdev, VS_CAP_19, &data);
+	data = (cmd << VS_CAP_19_CMD_SHIFT) & VS_CAP_19_CMD_MASK;
+	pci_write_config_dword(nhi->pdev, VS_CAP_19, data | VS_CAP_19_VALID);
+}
+
+static int icl_nhi_lc_mailbox_cmd_complete(struct tb_nhi *nhi, int timeout)
+{
+	unsigned long end;
+	u32 data;
+
+	if (!timeout)
+		goto clear;
+
+	end = jiffies + msecs_to_jiffies(timeout);
+	do {
+		pci_read_config_dword(nhi->pdev, VS_CAP_18, &data);
+		if (data & VS_CAP_18_DONE)
+			goto clear;
+		msleep(100);
+	} while (time_before(jiffies, end));
+
+	return -ETIMEDOUT;
+
+clear:
+	/* Clear the valid bit */
+	pci_write_config_dword(nhi->pdev, VS_CAP_19, 0);
+	return 0;
+}
+
+static void icl_nhi_set_ltr(struct tb_nhi *nhi)
+{
+	u32 max_ltr, ltr;
+
+	pci_read_config_dword(nhi->pdev, VS_CAP_16, &max_ltr);
+	max_ltr &= 0xffff;
+	/* Program the same value for both snoop and no-snoop */
+	ltr = max_ltr << 16 | max_ltr;
+	pci_write_config_dword(nhi->pdev, VS_CAP_15, ltr);
+}
+
+static int icl_nhi_suspend(struct tb_nhi *nhi)
+{
+	int ret;
+
+	if (icl_nhi_is_device_connected(nhi))
+		return 0;
+
+	/*
+	 * If there is no device connected we need to perform both: a
+	 * handshake through LC mailbox and force power down before
+	 * entering D3.
+	 */
+	icl_nhi_lc_mailbox_cmd(nhi, ICL_LC_PREPARE_FOR_RESET);
+	ret = icl_nhi_lc_mailbox_cmd_complete(nhi, ICL_LC_MAILBOX_TIMEOUT);
+	if (ret)
+		return ret;
+
+	return icl_nhi_force_power(nhi, false);
+}
+
+static int icl_nhi_suspend_noirq(struct tb_nhi *nhi, bool wakeup)
+{
+	enum icl_lc_mailbox_cmd cmd;
+
+	if (!pm_suspend_via_firmware())
+		return icl_nhi_suspend(nhi);
+
+	cmd = wakeup ? ICL_LC_GO2SX : ICL_LC_GO2SX_NO_WAKE;
+	icl_nhi_lc_mailbox_cmd(nhi, cmd);
+	return icl_nhi_lc_mailbox_cmd_complete(nhi, ICL_LC_MAILBOX_TIMEOUT);
+}
+
+static int icl_nhi_resume(struct tb_nhi *nhi)
+{
+	int ret;
+
+	ret = icl_nhi_force_power(nhi, true);
+	if (ret)
+		return ret;
+
+	icl_nhi_set_ltr(nhi);
+	return 0;
+}
+
+static void icl_nhi_shutdown(struct tb_nhi *nhi)
+{
+	icl_nhi_force_power(nhi, false);
+}
+
+const struct tb_nhi_ops icl_nhi_ops = {
+	.init = icl_nhi_resume,
+	.suspend_noirq = icl_nhi_suspend_noirq,
+	.resume_noirq = icl_nhi_resume,
+	.runtime_suspend = icl_nhi_suspend,
+	.runtime_resume = icl_nhi_resume,
+	.shutdown = icl_nhi_shutdown,
+};
diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_regs.h
index a60bd98c1d04..0d4970dcef84 100644
--- a/drivers/thunderbolt/nhi_regs.h
+++ b/drivers/thunderbolt/nhi_regs.h
@@ -124,4 +124,41 @@ struct ring_desc {
 #define REG_FW_STS_ICM_EN_INVERT	BIT(1)
 #define REG_FW_STS_ICM_EN		BIT(0)
 
+/* ICL NHI VSEC registers */
+
+/* FW ready */
+#define VS_CAP_9			0xc8
+#define VS_CAP_9_FW_READY		BIT(31)
+/* UUID */
+#define VS_CAP_10			0xcc
+#define VS_CAP_11			0xd0
+/* LTR */
+#define VS_CAP_15			0xe0
+#define VS_CAP_16			0xe4
+/* TBT2PCIe */
+#define VS_CAP_18			0xec
+#define VS_CAP_18_DONE			BIT(0)
+/* PCIe2TBT */
+#define VS_CAP_19			0xf0
+#define VS_CAP_19_VALID			BIT(0)
+#define VS_CAP_19_CMD_SHIFT		1
+#define VS_CAP_19_CMD_MASK		GENMASK(7, 1)
+/* Force power */
+#define VS_CAP_22			0xfc
+#define VS_CAP_22_FORCE_POWER		BIT(1)
+#define VS_CAP_22_DMA_DELAY_MASK	GENMASK(31, 24)
+#define VS_CAP_22_DMA_DELAY_SHIFT	24
+
+/**
+ * enum icl_lc_mailbox_cmd - ICL specific LC mailbox commands
+ * @ICL_LC_GO2SX: Ask LC to enter Sx without wake
+ * @ICL_LC_GO2SX_NO_WAKE: Ask LC to enter Sx with wake
+ * @ICL_LC_PREPARE_FOR_RESET: Prepare LC for reset
+ */
+enum icl_lc_mailbox_cmd {
+	ICL_LC_GO2SX = 0x02,
+	ICL_LC_GO2SX_NO_WAKE = 0x03,
+	ICL_LC_PREPARE_FOR_RESET = 0x21,
+};
+
 #endif
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 531f11fecf75..410bf1bceeee 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1470,6 +1470,8 @@ static int tb_switch_get_generation(struct tb_switch *sw)
 	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE:
 	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE:
 	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_ICL_NHI0:
+	case PCI_DEVICE_ID_INTEL_ICL_NHI1:
 		return 3;
 
 	default:
diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index afbe1d29bb03..4b641e4ee0c5 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -104,10 +104,11 @@ enum icm_pkg_code {
 };
 
 enum icm_event_code {
-	ICM_EVENT_DEVICE_CONNECTED = 3,
-	ICM_EVENT_DEVICE_DISCONNECTED = 4,
-	ICM_EVENT_XDOMAIN_CONNECTED = 6,
-	ICM_EVENT_XDOMAIN_DISCONNECTED = 7,
+	ICM_EVENT_DEVICE_CONNECTED = 0x3,
+	ICM_EVENT_DEVICE_DISCONNECTED = 0x4,
+	ICM_EVENT_XDOMAIN_CONNECTED = 0x6,
+	ICM_EVENT_XDOMAIN_DISCONNECTED = 0x7,
+	ICM_EVENT_RTD3_VETO = 0xa,
 };
 
 struct icm_pkg_header {
@@ -463,6 +464,13 @@ struct icm_tr_pkg_disconnect_xdomain_response {
 	uuid_t remote_uuid;
 };
 
+/* Ice Lake messages */
+
+struct icm_icl_event_rtd3_veto {
+	struct icm_pkg_header hdr;
+	u32 veto_reason;
+};
+
 /* XDomain messages */
 
 struct tb_xdomain_header {
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 2d7e012db03f..ece782ef5466 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -429,6 +429,7 @@ static inline struct tb_xdomain *tb_service_parent(struct tb_service *svc)
  * @lock: Must be held during ring creation/destruction. Is acquired by
  *	  interrupt_work when dispatching interrupts to individual rings.
  * @pdev: Pointer to the PCI device
+ * @ops: NHI specific optional ops
  * @iobase: MMIO space of the NHI
  * @tx_rings: All Tx rings available on this host controller
  * @rx_rings: All Rx rings available on this host controller
@@ -442,6 +443,7 @@ static inline struct tb_xdomain *tb_service_parent(struct tb_service *svc)
 struct tb_nhi {
 	spinlock_t lock;
 	struct pci_dev *pdev;
+	const struct tb_nhi_ops *ops;
 	void __iomem *iobase;
 	struct tb_ring **tx_rings;
 	struct tb_ring **rx_rings;
-- 
2.23.0.rc1

