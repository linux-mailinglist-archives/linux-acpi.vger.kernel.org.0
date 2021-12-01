Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173B6464E50
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 13:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349438AbhLANCC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 08:02:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:14072 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349437AbhLANCA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Dec 2021 08:02:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236395263"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236395263"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:37 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="512008570"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:36 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 8945820830;
        Wed,  1 Dec 2021 14:58:34 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1msPCw-003vl4-QR; Wed, 01 Dec 2021 14:59:34 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        rafael@kernel.org
Subject: [PATCH v2 1/7] device property: Fix fwnode_graph_devcon_match() fwnode leak
Date:   Wed,  1 Dec 2021 14:59:29 +0200
Message-Id: <20211201125934.936953-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
References: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

