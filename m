Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB960382
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 11:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfGEJ6P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 05:58:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:42516 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbfGEJ6J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jul 2019 05:58:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 02:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="155246741"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Jul 2019 02:58:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 23569687; Fri,  5 Jul 2019 12:58:01 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 7/8] thunderbolt: Add support for Intel Ice Lake
Date:   Fri,  5 Jul 2019 12:57:59 +0300
Message-Id: <20190705095800.43534-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
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
---
 drivers/thunderbolt/icm.c      | 151 ++++++++++++++++--
 drivers/thunderbolt/nhi.c      | 274 ++++++++++++++++++++++++++++++++-
 drivers/thunderbolt/nhi.h      |   2 +
 drivers/thunderbolt/nhi_regs.h |  25 +++
 drivers/thunderbolt/switch.c   |   2 +
 drivers/thunderbolt/tb_msgs.h  |  16 +-
 include/linux/thunderbolt.h    |   2 +
 7 files changed, 453 insertions(+), 19 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 2a56d9478b34..e882e79b32a4 100644
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
@@ -519,14 +525,16 @@ static int icm_fr_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
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
 
@@ -557,14 +565,18 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
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
@@ -1086,7 +1098,8 @@ static int icm_tr_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 }
 
 static void
-icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
+__icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
+			  bool force_rtd3)
 {
 	const struct icm_tr_event_device_connected *pkg =
 		(const struct icm_tr_event_device_connected *)hdr;
@@ -1151,13 +1164,21 @@ icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
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
@@ -1468,6 +1489,72 @@ static int icm_ar_set_boot_acl(struct tb *tb, const uuid_t *uuids,
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
+	struct icm *icm = tb_priv(tb);
+
+	tb_dbg(tb, "ICM rtd3 veto=0x%08x\n", pkg->veto_reason);
+
+	if (pkg->veto_reason) {
+		if (!icm->veto) {
+			icm->veto = true;
+			/* Keep the domain powered while veto is in effect */
+			pm_runtime_get(&tb->dev);
+		}
+	} else {
+		if (icm->veto) {
+			icm->veto = false;
+			/* Allow the domain suspend now */
+			pm_runtime_mark_last_busy(&tb->dev);
+			pm_runtime_put_autosuspend(&tb->dev);
+		}
+	}
+}
+
 static void icm_handle_notification(struct work_struct *work)
 {
 	struct icm_notification *n = container_of(work, typeof(*n), work);
@@ -1495,6 +1582,9 @@ static void icm_handle_notification(struct work_struct *work)
 		case ICM_EVENT_XDOMAIN_DISCONNECTED:
 			icm->xdomain_disconnected(tb, n->pkg);
 			break;
+		case ICM_EVENT_RTD3_VETO:
+			icm->rtd3_veto(tb, n->pkg);
+			break;
 		}
 	}
 
@@ -1853,6 +1943,18 @@ static void icm_complete(struct tb *tb)
 	if (tb->nhi->going_away)
 		return;
 
+	/*
+	 * If RTD3 was vetoed before we entered system suspend allow it
+	 * again now before driver ready is sent. Firmware sends a new RTD3
+	 * veto if it is still the case after we have sent it driver ready
+	 * command.
+	 */
+	if (icm->veto) {
+		icm->veto = false;
+		pm_runtime_mark_last_busy(&tb->dev);
+		pm_runtime_put_autosuspend(&tb->dev);
+	}
+
 	icm_unplug_children(tb->root_switch);
 
 	/*
@@ -1918,6 +2020,9 @@ static int icm_start(struct tb *tb)
 	tb->root_switch->no_nvm_upgrade = !icm->can_upgrade_nvm;
 	tb->root_switch->rpm = icm->rpm;
 
+	if (icm->set_uuid)
+		icm->set_uuid(tb);
+
 	ret = tb_switch_add(tb->root_switch);
 	if (ret) {
 		tb_switch_put(tb->root_switch);
@@ -2002,6 +2107,19 @@ static const struct tb_cm_ops icm_tr_ops = {
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
@@ -2070,6 +2188,19 @@ struct tb *icm_probe(struct tb_nhi *nhi)
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
index 09242653da67..1af873c8127c 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -16,6 +16,8 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/property.h>
+#include <linux/suspend.h>
 
 #include "nhi.h"
 #include "nhi_regs.h"
@@ -38,6 +40,60 @@
 #define MSIX_MAX_VECS		16
 
 #define NHI_MAILBOX_TIMEOUT	500 /* ms */
+#define LC_MAILBOX_TIMEOUT	500 /* ms */
+
+enum lc_mailbox_cmd {
+	LC_GO2SX = 0x02,
+	LC_GO2SX_NO_WAKE = 0x03,
+	LC_PREPARE_FOR_RESET = 0x21,
+};
+
+/**
+ * struct tb_nhi_ops - NHI specific optional operations
+ * @force_power: Issue force power for the NHI
+ * @set_ltr: Program LTR requirement values for the NHI
+ * @lc_mailbox_cmd: Send mailbox command to the link controller
+ * @lc_mailbox_cmd_complete: Wait for the previous command to complete
+ */
+struct tb_nhi_ops {
+	int (*force_power)(struct tb_nhi *nhi, bool power);
+	void (*set_ltr)(struct tb_nhi *nhi);
+	void (*lc_mailbox_cmd)(struct tb_nhi *nhi, enum lc_mailbox_cmd cmd);
+	int (*lc_mailbox_cmd_complete)(struct tb_nhi *nhi, int timeout);
+};
+
+static inline int nhi_power_up(struct tb_nhi *nhi)
+{
+	if (nhi->ops && nhi->ops->force_power)
+		return nhi->ops->force_power(nhi, true);
+	return 0;
+}
+
+static inline int nhi_power_down(struct tb_nhi *nhi)
+{
+	if (nhi->ops && nhi->ops->force_power)
+		return nhi->ops->force_power(nhi, false);
+	return 0;
+}
+
+static inline void nhi_set_ltr(struct tb_nhi *nhi)
+{
+	if (nhi->ops && nhi->ops->set_ltr)
+		nhi->ops->set_ltr(nhi);
+}
+
+static inline void lc_mailbox_cmd(struct tb_nhi *nhi, enum lc_mailbox_cmd cmd)
+{
+	if (nhi->ops && nhi->ops->lc_mailbox_cmd)
+		nhi->ops->lc_mailbox_cmd(nhi, cmd);
+}
+
+static inline int lc_mailbox_cmd_complete(struct tb_nhi *nhi, int timeout)
+{
+	if (nhi->ops && nhi->ops->lc_mailbox_cmd_complete)
+		return nhi->ops->lc_mailbox_cmd_complete(nhi, timeout);
+	return 0;
+}
 
 static int ring_interrupt_index(struct tb_ring *ring)
 {
@@ -863,12 +919,85 @@ static irqreturn_t nhi_msi(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int nhi_suspend_noirq(struct device *dev)
+static int nhi_device_connected(struct device *dev, void *data)
+{
+	return tb_is_switch(dev);
+}
+
+static int nhi_suspend_power_down(struct tb *tb)
+{
+	int ret;
+
+	/*
+	 * If there is no device connected we need to perform an additional
+	 * handshake through LC mailbox and force power down before
+	 * entering D3.
+	 */
+	ret = device_for_each_child(&tb->root_switch->dev, NULL,
+				    nhi_device_connected);
+	if (!ret) {
+		lc_mailbox_cmd(tb->nhi, LC_PREPARE_FOR_RESET);
+		ret = lc_mailbox_cmd_complete(tb->nhi,
+					      LC_MAILBOX_TIMEOUT);
+		if (ret)
+			return ret;
+
+		return nhi_power_down(tb->nhi);
+	}
+
+	return 0;
+}
+
+static int __nhi_suspend_noirq(struct device *dev, bool wakeup)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct tb *tb = pci_get_drvdata(pdev);
+	int ret;
+
+	ret = tb_domain_suspend_noirq(tb);
+	if (ret)
+		return ret;
+
+	if (pm_suspend_via_firmware()) {
+		enum lc_mailbox_cmd cmd = wakeup ? LC_GO2SX : LC_GO2SX_NO_WAKE;
+
+		lc_mailbox_cmd(tb->nhi, cmd);
+		ret = lc_mailbox_cmd_complete(tb->nhi, LC_MAILBOX_TIMEOUT);
+		if (ret)
+			return ret;
+	} else {
+		ret = nhi_suspend_power_down(tb);
+	}
+
+	return ret;
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
@@ -891,16 +1020,23 @@ static int nhi_resume_noirq(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct tb *tb = pci_get_drvdata(pdev);
+	int ret;
+
+	ret = nhi_power_up(tb->nhi);
+	if (ret)
+		return ret;
 
 	/*
 	 * Check that the device is still there. It may be that the user
 	 * unplugged last device which causes the host controller to go
 	 * away on PCs.
 	 */
-	if (!pci_device_is_present(pdev))
+	if (!pci_device_is_present(pdev)) {
 		tb->nhi->going_away = true;
-	else
+	} else {
+		nhi_set_ltr(tb->nhi);
 		nhi_enable_int_throttling(tb->nhi);
+	}
 
 	return tb_domain_resume_noirq(tb);
 }
@@ -933,16 +1069,28 @@ static int nhi_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct tb *tb = pci_get_drvdata(pdev);
+	int ret;
 
-	return tb_domain_runtime_suspend(tb);
+	ret = tb_domain_runtime_suspend(tb);
+	if (ret)
+		return ret;
+
+	return nhi_suspend_power_down(tb);
 }
 
 static int nhi_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct tb *tb = pci_get_drvdata(pdev);
+	int ret;
 
+	ret = nhi_power_up(tb->nhi);
+	if (ret)
+		return ret;
+
+	nhi_set_ltr(tb->nhi);
 	nhi_enable_int_throttling(tb->nhi);
+
 	return tb_domain_runtime_resume(tb);
 }
 
@@ -970,6 +1118,7 @@ static void nhi_shutdown(struct tb_nhi *nhi)
 		flush_work(&nhi->interrupt_work);
 	}
 	ida_destroy(&nhi->msix_ida);
+	nhi_power_down(nhi);
 }
 
 static int nhi_init_msi(struct tb_nhi *nhi)
@@ -1014,12 +1163,27 @@ static int nhi_init_msi(struct tb_nhi *nhi)
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
@@ -1037,6 +1201,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	nhi->pdev = pdev;
+	nhi->ops = (const struct tb_nhi_ops *)id->driver_data;
 	/* cannot fail - table is allocated bin pcim_iomap_regions */
 	nhi->iobase = pcim_iomap_table(pdev)[0];
 	nhi->hop_count = ioread32(nhi->iobase + REG_HOP_COUNT) & 0x3ff;
@@ -1080,6 +1245,14 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_dbg(&nhi->pdev->dev, "NHI initialized, starting thunderbolt\n");
 
+	res = nhi_power_up(nhi);
+	if (res) {
+		tb_domain_put(tb);
+		return res;
+	}
+
+	nhi_set_ltr(nhi);
+
 	res = tb_domain_add(tb);
 	if (res) {
 		/*
@@ -1111,6 +1284,7 @@ static void nhi_remove(struct pci_dev *pdev)
 
 	tb_domain_remove(tb);
 	nhi_shutdown(nhi);
+	nhi_power_down(nhi);
 }
 
 /*
@@ -1129,12 +1303,98 @@ static const struct dev_pm_ops nhi_pm_ops = {
 	.restore_noirq = nhi_resume_noirq,
 	.suspend = nhi_suspend,
 	.freeze = nhi_suspend,
+	.poweroff_noirq = nhi_poweroff_noirq,
 	.poweroff = nhi_suspend,
 	.complete = nhi_complete,
 	.runtime_suspend = nhi_runtime_suspend,
 	.runtime_resume = nhi_runtime_resume,
 };
 
+/* Ice Lake specific NHI operations */
+
+static int icl_nhi_force_power(struct tb_nhi *nhi, bool power)
+{
+	u32 vs_cap;
+
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
+static void icl_nhi_lc_mailbox_cmd(struct tb_nhi *nhi, enum lc_mailbox_cmd cmd)
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
+static const struct tb_nhi_ops icl_nhi_ops = {
+	.force_power = icl_nhi_force_power,
+	.set_ltr = icl_nhi_set_ltr,
+	.lc_mailbox_cmd = icl_nhi_lc_mailbox_cmd,
+	.lc_mailbox_cmd_complete = icl_nhi_lc_mailbox_cmd_complete,
+};
+
 static struct pci_device_id nhi_ids[] = {
 	/*
 	 * We have to specify class, the TB bridges use the same device and
@@ -1176,6 +1436,10 @@ static struct pci_device_id nhi_ids[] = {
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
index 1b5d47ecd3ed..dad691d1b704 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -51,5 +51,7 @@ enum nhi_fw_mode nhi_mailbox_mode(struct tb_nhi *nhi);
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE	0x15ea
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI		0x15eb
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE	0x15ef
+#define PCI_DEVICE_ID_INTEL_ICL_NHI1			0x8a0d
+#define PCI_DEVICE_ID_INTEL_ICL_NHI0			0x8a17
 
 #endif
diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_regs.h
index a60bd98c1d04..8754e7dd63d5 100644
--- a/drivers/thunderbolt/nhi_regs.h
+++ b/drivers/thunderbolt/nhi_regs.h
@@ -124,4 +124,29 @@ struct ring_desc {
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
 #endif
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index e318e9714a38..b896aa78fa9f 100644
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
2.20.1

