Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1070E89E97
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2019 14:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfHLMjQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Aug 2019 08:39:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:31865 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfHLMiy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Aug 2019 08:38:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 05:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="175871416"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2019 05:38:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3D4AF38C; Mon, 12 Aug 2019 15:38:48 +0300 (EEST)
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
Subject: [PATCH v2 4/8] thunderbolt: Do not fail adding switch if some port is not implemented
Date:   Mon, 12 Aug 2019 15:38:43 +0300
Message-Id: <20190812123847.50802-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812123847.50802-1-mika.westerberg@linux.intel.com>
References: <20190812123847.50802-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are two ways to mark a port as unimplemented. Typical way is to
return port type as TB_TYPE_INACTIVE when its config space is read.
Alternatively if the port is not physically present (such as ports 10
and 11 in ICL) reading from port config space returns
TB_CFG_ERROR_INVALID_CONFIG_SPACE instead. Currently the driver bails
out from adding the switch if it receives any error during port
inititialization which is wrong.

Handle this properly and just leave the port as TB_TYPE_INACTIVE before
continuing to the next port.

This also allows us to get rid of special casing for Light Ridge port 5
in eeprom.c.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Yehezkel Bernat <YehezkelShB@gmail.com>
---
 drivers/thunderbolt/ctl.c    | 23 +++++++++++++++++++----
 drivers/thunderbolt/eeprom.c |  4 ----
 drivers/thunderbolt/switch.c |  8 +++++++-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 2427d73be731..2ec1af8f7968 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -930,6 +930,23 @@ struct tb_cfg_result tb_cfg_write_raw(struct tb_ctl *ctl, const void *buffer,
 	return res;
 }
 
+static int tb_cfg_get_error(struct tb_ctl *ctl, enum tb_cfg_space space,
+			    const struct tb_cfg_result *res)
+{
+	/*
+	 * For unimplemented ports access to port config space may return
+	 * TB_CFG_ERROR_INVALID_CONFIG_SPACE (alternatively their type is
+	 * set to TB_TYPE_INACTIVE). In the former case return -ENODEV so
+	 * that the caller can mark the port as disabled.
+	 */
+	if (space == TB_CFG_PORT &&
+	    res->tb_error == TB_CFG_ERROR_INVALID_CONFIG_SPACE)
+		return -ENODEV;
+
+	tb_cfg_print_error(ctl, res);
+	return -EIO;
+}
+
 int tb_cfg_read(struct tb_ctl *ctl, void *buffer, u64 route, u32 port,
 		enum tb_cfg_space space, u32 offset, u32 length)
 {
@@ -942,8 +959,7 @@ int tb_cfg_read(struct tb_ctl *ctl, void *buffer, u64 route, u32 port,
 
 	case 1:
 		/* Thunderbolt error, tb_error holds the actual number */
-		tb_cfg_print_error(ctl, &res);
-		return -EIO;
+		return tb_cfg_get_error(ctl, space, &res);
 
 	case -ETIMEDOUT:
 		tb_ctl_warn(ctl, "timeout reading config space %u from %#x\n",
@@ -969,8 +985,7 @@ int tb_cfg_write(struct tb_ctl *ctl, const void *buffer, u64 route, u32 port,
 
 	case 1:
 		/* Thunderbolt error, tb_error holds the actual number */
-		tb_cfg_print_error(ctl, &res);
-		return -EIO;
+		return tb_cfg_get_error(ctl, space, &res);
 
 	case -ETIMEDOUT:
 		tb_ctl_warn(ctl, "timeout writing config space %u to %#x\n",
diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 81e8ac4c5805..3b2fb4aafd92 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -525,10 +525,6 @@ int tb_drom_read(struct tb_switch *sw)
 		sw->ports[3].dual_link_port = &sw->ports[4];
 		sw->ports[4].dual_link_port = &sw->ports[3];
 
-		/* Port 5 is inaccessible on this gen 1 controller */
-		if (sw->config.device_id == PCI_DEVICE_ID_INTEL_LIGHT_RIDGE)
-			sw->ports[5].disabled = true;
-
 		return 0;
 	}
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 5668a44e0653..64f845fe4690 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -611,8 +611,14 @@ static int tb_init_port(struct tb_port *port)
 	int cap;
 
 	res = tb_port_read(port, &port->config, TB_CFG_PORT, 0, 8);
-	if (res)
+	if (res) {
+		if (res == -ENODEV) {
+			tb_dbg(port->sw->tb, " Port %d: not implemented\n",
+			       port->port);
+			return 0;
+		}
 		return res;
+	}
 
 	/* Port 0 is the switch itself and has no PHY. */
 	if (port->config.type == TB_TYPE_PORT && port->port != 0) {
-- 
2.20.1

