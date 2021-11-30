Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D90463A18
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 16:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhK3PfP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 10:35:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:25819 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238810AbhK3PfO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Nov 2021 10:35:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223466682"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="223466682"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:31:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="609170395"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:31:54 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id F3BF2204C6;
        Tue, 30 Nov 2021 17:31:51 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1ms57i-003vRF-8c; Tue, 30 Nov 2021 17:32:50 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        rafael@kernel.org,
        /tmp/small/0000-cover-letter.patch@punajuuri.localdomain
Subject: [PATCH 1/7] device property: Fix fwnode_graph_devcon_match() fwnode leak
Date:   Tue, 30 Nov 2021 17:32:44 +0200
Message-Id: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For each endpoint it encounters, fwnode_graph_devcon_match() checks
whether the endpoint's remote port parent device is available. If it is
not, it ignores the endpoint but does not put the reference to the remote
endpoint port parent fwnode. For available devices the fwnode handle
reference is put as expected.

Put the reference for unavailable devices now.

Fixes: 637e9e52b185 ("device connection: Find device connections also from device graphs")
Cc: stable@vger.kernel.org # for 5.1 and later
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f1f35b48ab8b9..6df99e526ab0f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1206,8 +1206,10 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 
 	fwnode_graph_for_each_endpoint(fwnode, ep) {
 		node = fwnode_graph_get_remote_port_parent(ep);
-		if (!fwnode_device_is_available(node))
+		if (!fwnode_device_is_available(node)) {
+			fwnode_handle_put(node);
 			continue;
+		}
 
 		ret = match(node, con_id, data);
 		fwnode_handle_put(node);
-- 
2.30.2

