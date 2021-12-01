Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09452464E5E
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 14:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349454AbhLANDm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 08:03:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:14213 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349377AbhLANDk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Dec 2021 08:03:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236395544"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236395544"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 05:00:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="609542469"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 05:00:17 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 6062C2036B;
        Wed,  1 Dec 2021 15:00:15 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1msPEZ-003vmX-MH; Wed, 01 Dec 2021 15:01:15 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        rafael@kernel.org, Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 7/7] device property: Drop fwnode_graph_get_remote_node()
Date:   Wed,  1 Dec 2021 15:01:15 +0200
Message-Id: <20211201130115.937052-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
References: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

fwnode_graph_get_remote_node() is only used by the tegra-video driver.
Convert it to use newer fwnode_graph_get_endpoint_by_id() and drop
now-unused fwnode_graph_get_remote_node().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c                | 38 --------------------------
 drivers/staging/media/tegra-video/vi.c | 12 +++++---
 include/linux/property.h               |  3 --
 3 files changed, 8 insertions(+), 45 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 78106192babb8..a7086e5526445 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1059,44 +1059,6 @@ fwnode_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
 
-/**
- * fwnode_graph_get_remote_node - get remote parent node for given port/endpoint
- * @fwnode: pointer to parent fwnode_handle containing graph port/endpoint
- * @port_id: identifier of the parent port node
- * @endpoint_id: identifier of the endpoint node
- *
- * Return: Remote fwnode handle associated with remote endpoint node linked
- *	   to @node. Use fwnode_node_put() on it when done.
- */
-struct fwnode_handle *
-fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port_id,
-			     u32 endpoint_id)
-{
-	struct fwnode_handle *endpoint;
-
-	fwnode_graph_for_each_endpoint(fwnode, endpoint) {
-		struct fwnode_endpoint fwnode_ep;
-		struct fwnode_handle *remote;
-		int ret;
-
-		ret = fwnode_graph_parse_endpoint(endpoint, &fwnode_ep);
-		if (ret < 0)
-			continue;
-
-		if (fwnode_ep.port != port_id || fwnode_ep.id != endpoint_id)
-			continue;
-
-		remote = fwnode_graph_get_remote_port_parent(endpoint);
-		if (!remote)
-			return NULL;
-
-		return fwnode_device_is_available(remote) ? remote : NULL;
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_node);
-
 static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
 {
 	struct fwnode_handle *dev_node;
diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 69d9787d53384..d1f43f465c224 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1845,7 +1845,6 @@ static int tegra_vi_graph_init(struct tegra_vi *vi)
 	struct tegra_vi_channel *chan;
 	struct fwnode_handle *fwnode = dev_fwnode(vi->dev);
 	int ret;
-	struct fwnode_handle *remote = NULL;
 
 	/*
 	 * Walk the links to parse the full graph. Each channel will have
@@ -1857,11 +1856,16 @@ static int tegra_vi_graph_init(struct tegra_vi *vi)
 	 * next channels.
 	 */
 	list_for_each_entry(chan, &vi->vi_chans, list) {
-		remote = fwnode_graph_get_remote_node(fwnode, chan->portnos[0],
-						      0);
-		if (!remote)
+		struct fwnode_handle *ep, *remote;
+
+		ep = fwnode_graph_get_endpoint_by_id(fwnode,
+						     chan->portnos[0], 0, 0);
+		if (!ep)
 			continue;
 
+		remote = fwnode_graph_get_remote_port_parent(ep);
+		fwnode_handle_put(ep);
+
 		ret = tegra_vi_graph_parse_one(chan, remote);
 		fwnode_handle_put(remote);
 		if (ret < 0 || list_empty(&chan->notifier.asd_list))
diff --git a/include/linux/property.h b/include/linux/property.h
index e32b95f42c9db..3a31765895c11 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -401,9 +401,6 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
 	const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_graph_get_remote_endpoint(
 	const struct fwnode_handle *fwnode);
-struct fwnode_handle *
-fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port,
-			     u32 endpoint);
 
 static inline bool fwnode_graph_is_endpoint(struct fwnode_handle *fwnode)
 {
-- 
2.30.2

