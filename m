Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E67389003
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 16:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhESOOE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 10:14:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:36773 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241214AbhESOOC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 10:14:02 -0400
IronPort-SDR: jllzIMypXRYy+/pzJo2hBhJssYm4daxMR9Er13XJJK3clee9X5j77/m2Lp7AFUC9HXiwejYuUJ
 pwYUWCew1APw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="188392644"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188392644"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 07:12:41 -0700
IronPort-SDR: 34BTr8ao/KjwyvuTgfEbQzVmbfR8gES8o7RUkY5Gbhy9rsvFcP5Zvli2JEU1pjEwOuvmN3vDoi
 6iK51qAhXCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="439739629"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 19 May 2021 07:12:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 82D0C5D4; Wed, 19 May 2021 17:12:59 +0300 (EEST)
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
Subject: [PATCH 4/9] thunderbolt: Add additional USB4 port operations for retimer access
Date:   Wed, 19 May 2021 17:12:54 +0300
Message-Id: <20210519141259.84839-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rajmohan Mani <rajmohan.mani@intel.com>

When accessing retimers when there is no cable connected we are going to
need additional USB4 port operations. First the port needs to be put
into offline mode, and then the sideband channel transactions must be
enabled on the SBTX line. This adds support for these operations.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/sb_regs.h |  2 +
 drivers/thunderbolt/tb.h      |  3 ++
 drivers/thunderbolt/usb4.c    | 69 +++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/thunderbolt/sb_regs.h b/drivers/thunderbolt/sb_regs.h
index 9dafd696612f..bda889ff3bda 100644
--- a/drivers/thunderbolt/sb_regs.h
+++ b/drivers/thunderbolt/sb_regs.h
@@ -17,7 +17,9 @@
 enum usb4_sb_opcode {
 	USB4_SB_OPCODE_ERR = 0x20525245,			/* "ERR " */
 	USB4_SB_OPCODE_ONS = 0x444d4321,			/* "!CMD" */
+	USB4_SB_OPCODE_ROUTER_OFFLINE = 0x4e45534c,		/* "LSEN" */
 	USB4_SB_OPCODE_ENUMERATE_RETIMERS = 0x4d554e45,		/* "ENUM" */
+	USB4_SB_OPCODE_SET_INBOUND_SBTX = 0x5055534c,		/* "LSUP" */
 	USB4_SB_OPCODE_QUERY_LAST_RETIMER = 0x5453414c,		/* "LAST" */
 	USB4_SB_OPCODE_GET_NVM_SECTOR_SIZE = 0x53534e47,	/* "GNSS" */
 	USB4_SB_OPCODE_NVM_SET_OFFSET = 0x53504f42,		/* "BOPS" */
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index c5704f495afa..936518adca74 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1062,8 +1062,11 @@ int usb4_port_configure(struct tb_port *port);
 void usb4_port_unconfigure(struct tb_port *port);
 int usb4_port_configure_xdomain(struct tb_port *port);
 void usb4_port_unconfigure_xdomain(struct tb_port *port);
+int usb4_port_router_offline(struct tb_port *port);
+int usb4_port_router_online(struct tb_port *port);
 int usb4_port_enumerate_retimers(struct tb_port *port);
 
+int usb4_port_retimer_set_inbound_sbtx(struct tb_port *port, u8 index);
 int usb4_port_retimer_read(struct tb_port *port, u8 index, u8 reg, void *buf,
 			   u8 size);
 int usb4_port_retimer_write(struct tb_port *port, u8 index, u8 reg,
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 1f82af35328e..8af96dbaa7a7 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -1318,6 +1318,48 @@ static int usb4_port_sb_op(struct tb_port *port, enum usb4_sb_target target,
 	return -ETIMEDOUT;
 }
 
+static int usb4_port_set_router_offline(struct tb_port *port, bool offline)
+{
+	u32 val = !offline;
+	int ret;
+
+	ret = usb4_port_sb_write(port, USB4_SB_TARGET_ROUTER, 0,
+				  USB4_SB_METADATA, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	val = USB4_SB_OPCODE_ROUTER_OFFLINE;
+	return usb4_port_sb_write(port, USB4_SB_TARGET_ROUTER, 0,
+				  USB4_SB_OPCODE, &val, sizeof(val));
+}
+
+/**
+ * usb4_port_router_offline() - Put the USB4 port to offline mode
+ * @port: USB4 port
+ *
+ * This function puts the USB4 port into offline mode. In this mode the
+ * port does not react on hotplug events anymore. This needs to be
+ * called before retimer access is done when the USB4 links is not up.
+ *
+ * Returns %0 in case of success and negative errno if there was an
+ * error.
+ */
+int usb4_port_router_offline(struct tb_port *port)
+{
+	return usb4_port_set_router_offline(port, true);
+}
+
+/**
+ * usb4_port_router_online() - Put the USB4 port back to online
+ * @port: USB4 port
+ *
+ * Makes the USB4 port functional again.
+ */
+int usb4_port_router_online(struct tb_port *port)
+{
+	return usb4_port_set_router_offline(port, false);
+}
+
 /**
  * usb4_port_enumerate_retimers() - Send RT broadcast transaction
  * @port: USB4 port
@@ -1343,6 +1385,33 @@ static inline int usb4_port_retimer_op(struct tb_port *port, u8 index,
 			       timeout_msec);
 }
 
+/**
+ * usb4_port_retimer_set_inbound_sbtx() - Enable sideband channel transactions
+ * @port: USB4 port
+ * @index: Retimer index
+ *
+ * Enables sideband channel transations on SBTX. Can be used when USB4
+ * link does not go up, for example if there is no device connected.
+ */
+int usb4_port_retimer_set_inbound_sbtx(struct tb_port *port, u8 index)
+{
+	int ret;
+
+	ret = usb4_port_retimer_op(port, index, USB4_SB_OPCODE_SET_INBOUND_SBTX,
+				   500);
+
+	if (ret != -ENODEV)
+		return ret;
+
+	/*
+	 * Per the USB4 retimer spec, the retimer is not required to
+	 * send an RT (Retimer Transaction) response for the first
+	 * SET_INBOUND_SBTX command
+	 */
+	return usb4_port_retimer_op(port, index, USB4_SB_OPCODE_SET_INBOUND_SBTX,
+				    500);
+}
+
 /**
  * usb4_port_retimer_read() - Read from retimer sideband registers
  * @port: USB4 port
-- 
2.30.2

