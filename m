Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192D5464E52
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 13:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349450AbhLANCD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 08:02:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:6308 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349445AbhLANCC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Dec 2021 08:02:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="216468224"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="216468224"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:41 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="459242949"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:39 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 17BE320A2D;
        Wed,  1 Dec 2021 14:58:35 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1msPCx-003vlM-8W; Wed, 01 Dec 2021 14:59:35 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        rafael@kernel.org
Subject: [PATCH v2 6/7] device property: Use fwnode_graph_for_each_endpoint() macro
Date:   Wed,  1 Dec 2021 14:59:34 +0200
Message-Id: <20211201125934.936953-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
References: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now that we have fwnode_graph_for_each_endpoint() macro, use it instead of
calling fwnode_graph_get_next_endpoint() directly. It manages the iterator
variable for the user without manual intervention.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 90075c051dccf..78106192babb8 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1072,9 +1072,9 @@ struct fwnode_handle *
 fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port_id,
 			     u32 endpoint_id)
 {
-	struct fwnode_handle *endpoint = NULL;
+	struct fwnode_handle *endpoint;
 
-	while ((endpoint = fwnode_graph_get_next_endpoint(fwnode, endpoint))) {
+	fwnode_graph_for_each_endpoint(fwnode, endpoint) {
 		struct fwnode_endpoint fwnode_ep;
 		struct fwnode_handle *remote;
 		int ret;
@@ -1133,12 +1133,12 @@ struct fwnode_handle *
 fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 				u32 port, u32 endpoint, unsigned long flags)
 {
-	struct fwnode_handle *ep = NULL, *best_ep = NULL;
+	struct fwnode_handle *ep, *best_ep = NULL;
 	unsigned int best_ep_id = 0;
 	bool endpoint_next = flags & FWNODE_GRAPH_ENDPOINT_NEXT;
 	bool enabled_only = !(flags & FWNODE_GRAPH_DEVICE_DISABLED);
 
-	while ((ep = fwnode_graph_get_next_endpoint(fwnode, ep))) {
+	fwnode_graph_for_each_endpoint(fwnode, ep) {
 		struct fwnode_endpoint fwnode_ep = { 0 };
 		int ret;
 
-- 
2.30.2

