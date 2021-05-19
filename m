Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62563389001
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 16:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242353AbhESOOD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 10:14:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:44083 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234208AbhESOOC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 10:14:02 -0400
IronPort-SDR: vL7bsQMfNA3t2AGGahS56UzGI0xFS44X9GEhsGQ69WsyE+/nuUYuQ9NSYMrkQG8XLrHnDA1Qva
 oCSohdlMKYMw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="262212421"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262212421"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 07:12:41 -0700
IronPort-SDR: JtsCF+GmLig5gLkDS9PFCR+3IHEIyUJbC61jvEQXv2oQLwQdzvN38+PRoYcJYmp9oFC7kbZZ7I
 +iUq6hrRn0+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="394421796"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2021 07:12:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5CDABB7; Wed, 19 May 2021 17:12:59 +0300 (EEST)
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
Subject: [PATCH 1/9] thunderbolt: Log the link as TBT instead of TBT3
Date:   Wed, 19 May 2021 17:12:51 +0300
Message-Id: <20210519141259.84839-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The upstream port can be connected to any previous generation
Thunderbolt port so logging as "TBT" is more accurate than "TBT3.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/usb4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index edab8ea63c0b..94cc25cc6388 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -260,7 +260,7 @@ int usb4_switch_setup(struct tb_switch *sw)
 	parent = tb_switch_parent(sw);
 	downstream_port = tb_port_at(tb_route(sw), parent);
 	sw->link_usb4 = link_is_usb4(downstream_port);
-	tb_sw_dbg(sw, "link: %s\n", sw->link_usb4 ? "USB4" : "TBT3");
+	tb_sw_dbg(sw, "link: %s\n", sw->link_usb4 ? "USB4" : "TBT");
 
 	xhci = val & ROUTER_CS_6_HCI;
 	tbt3 = !(val & ROUTER_CS_6_TNS);
-- 
2.30.2

