Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91607304342
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 17:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404310AbhAZP7j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 10:59:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:61152 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404388AbhAZP7R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 10:59:17 -0500
IronPort-SDR: O5LRL8qcsrvnhNtWjvMsjAS8WBLJo6VJqqRK4h9UeQaWZVBn4sVIQbZnpwTo/DUSiF+G0KVc4l
 eBx142Xu2iMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="159697372"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159697372"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 07:57:27 -0800
IronPort-SDR: 9fSmgMqIDQjSwY19s7lpKfgUUw3LcDaQq/bD0dGe8vRLZ+q9CyqXqYryWS8JQJMOHGIck1FPGy
 l00wip3Mg07w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="406758725"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2021 07:57:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3B0B4214; Tue, 26 Jan 2021 17:57:24 +0200 (EET)
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
Subject: [PATCH 3/6] thunderbolt: Allow disabling XDomain protocol
Date:   Tue, 26 Jan 2021 18:57:20 +0300
Message-Id: <20210126155723.9388-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This allows disabling XDomain protocol completely if the user does not
plan to use the USB4/Thunderbolt peer-to-peer functionality, or for
security reasons.

XDomain protocol is enabled by default but with this commit it is
possible to disable it by passing "xdomain=0" as module parameter (or
through the kernel command line).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/domain.c  | 4 +++-
 drivers/thunderbolt/icm.c     | 6 ++++--
 drivers/thunderbolt/tb.c      | 3 +++
 drivers/thunderbolt/tb.h      | 1 +
 drivers/thunderbolt/xdomain.c | 9 +++++++++
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index a1c79c9c4f66..89ae614eaba2 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -412,7 +412,9 @@ static bool tb_domain_event_cb(void *data, enum tb_cfg_pkg_type type,
 	switch (type) {
 	case TB_CFG_PKG_XDOMAIN_REQ:
 	case TB_CFG_PKG_XDOMAIN_RESP:
-		return tb_xdomain_handle_request(tb, type, buf, size);
+		if (tb_is_xdomain_enabled())
+			return tb_xdomain_handle_request(tb, type, buf, size);
+		break;
 
 	default:
 		tb->cm_ops->handle_event(tb, type, buf, size);
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 8b7f941a9bb7..6b853c59aa34 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1701,10 +1701,12 @@ static void icm_handle_notification(struct work_struct *work)
 			icm->device_disconnected(tb, n->pkg);
 			break;
 		case ICM_EVENT_XDOMAIN_CONNECTED:
-			icm->xdomain_connected(tb, n->pkg);
+			if (tb_is_xdomain_enabled())
+				icm->xdomain_connected(tb, n->pkg);
 			break;
 		case ICM_EVENT_XDOMAIN_DISCONNECTED:
-			icm->xdomain_disconnected(tb, n->pkg);
+			if (tb_is_xdomain_enabled())
+				icm->xdomain_disconnected(tb, n->pkg);
 			break;
 		case ICM_EVENT_RTD3_VETO:
 			icm->rtd3_veto(tb, n->pkg);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index d08879849abe..4a99cc3913c9 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -179,6 +179,9 @@ static void tb_scan_xdomain(struct tb_port *port)
 	struct tb_xdomain *xd;
 	u64 route;
 
+	if (!tb_is_xdomain_enabled())
+		return;
+
 	route = tb_downstream_route(port);
 	xd = tb_xdomain_find_by_route(tb, route);
 	if (xd) {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 31468de658e4..01fe849e9d4c 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -953,6 +953,7 @@ static inline u64 tb_downstream_route(struct tb_port *port)
 	       | ((u64) port->port << (port->sw->config.depth * 8));
 }
 
+bool tb_is_xdomain_enabled(void);
 bool tb_xdomain_handle_request(struct tb *tb, enum tb_cfg_pkg_type type,
 			       const void *buf, size_t size);
 struct tb_xdomain *tb_xdomain_alloc(struct tb *tb, struct device *parent,
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index f2d4db1cd84d..655ae4fefd69 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -30,6 +30,10 @@ struct xdomain_request_work {
 	struct tb *tb;
 };
 
+static bool tb_xdomain_enabled = true;
+module_param_named(xdomain, tb_xdomain_enabled, bool, 0444);
+MODULE_PARM_DESC(xdomain, "allow XDomain protocol (default: true)");
+
 /* Serializes access to the properties and protocol handlers below */
 static DEFINE_MUTEX(xdomain_lock);
 
@@ -47,6 +51,11 @@ static const uuid_t tb_xdp_uuid =
 	UUID_INIT(0xb638d70e, 0x42ff, 0x40bb,
 		  0x97, 0xc2, 0x90, 0xe2, 0xc0, 0xb2, 0xff, 0x07);
 
+bool tb_is_xdomain_enabled(void)
+{
+	return tb_xdomain_enabled;
+}
+
 static bool tb_xdomain_match(const struct tb_cfg_request *req,
 			     const struct ctl_pkg *pkg)
 {
-- 
2.29.2

