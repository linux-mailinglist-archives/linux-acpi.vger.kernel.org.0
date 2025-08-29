Return-Path: <linux-acpi+bounces-16199-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1850B3C4D0
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 00:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB28585FB3
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 22:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F30292B44;
	Fri, 29 Aug 2025 22:29:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349B286D57;
	Fri, 29 Aug 2025 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506586; cv=none; b=Fw8I/W2BNrviUeWYZ1fjHBOS1lIT4Egd7ORx25P9NjuM2ch6dwMNruWR8vZDu7yre5nw1aETc7rTZs1Ok7duNgf/4zNXR5qo76eT3hZQFF3D6B3ldkqf3XhSItm3U2TdtVJ2EFWmHFhe22/lJhHd2MaK/OmzAdicCqGeq2T9N5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506586; c=relaxed/simple;
	bh=gHoLisKmk0/pP+fypUHdRRQphWlNFnt9oOjY5Kn24Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9MAWJ6NNve8lvKsW/l/x+NCRzjrzeFOty+2DF9QUr//zA45JwNAKf2NEfFrzsl6AyuRR1vPl/k/LjR/TjSyNIwW4OP32aRS1n0IQR/3UCf7843SukHb52pSYRomsDHP6nUcYklQ+fuCTAwvnuzQ0f/8a3kiMvfUugtasNSwxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBD1C4CEF0;
	Fri, 29 Aug 2025 22:29:44 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	marc.herbert@linux.intel.com,
	akpm@linux-foundation.org,
	david@redhat.com
Subject: [PATCH v3 2/4] drivers/base/node: Add a helper function node_update_perf_attrs()
Date: Fri, 29 Aug 2025 15:29:05 -0700
Message-ID: <20250829222907.1290912-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829222907.1290912-1-dave.jiang@intel.com>
References: <20250829222907.1290912-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper function node_update_perf_attrs() to allow update of node access
coordinates computed by an external agent such as CXL. The helper allows
updating of coordinates after the attribute being created by HMAT.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/base/node.c  | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/node.h |  8 ++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 3399594136b2..db18a1c32637 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -248,6 +248,44 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 }
 EXPORT_SYMBOL_GPL(node_set_perf_attrs);
 
+/**
+ * node_update_perf_attrs - Update the performance values for given access class
+ * @nid: Node identifier to be updated
+ * @coord: Heterogeneous memory performance coordinates
+ * @access: The access class for the given attributes
+ */
+void node_update_perf_attrs(unsigned int nid, struct access_coordinate *coord,
+			    enum access_coordinate_class access)
+{
+	struct node_access_nodes *access_node;
+	struct node *node;
+	int i;
+
+	if (WARN_ON_ONCE(!node_online(nid)))
+		return;
+
+	node = node_devices[nid];
+	list_for_each_entry(access_node, &node->access_list, list_node) {
+		if (access_node->access != access)
+			continue;
+
+		access_node->coord = *coord;
+		for (i = 0; access_attrs[i]; i++) {
+			sysfs_notify(&access_node->dev.kobj,
+				     NULL, access_attrs[i]->name);
+		}
+		break;
+	}
+
+	/* When setting CPU access coordinates, update mempolicy */
+	if (access != ACCESS_COORDINATE_CPU)
+		return;
+
+	if (mempolicy_set_node_perf(nid, coord))
+		pr_info("failed to set mempolicy attrs for node %d\n", nid);
+}
+EXPORT_SYMBOL_GPL(node_update_perf_attrs);
+
 /**
  * struct node_cache_info - Internal tracking for memory node caches
  * @dev:	Device represeting the cache level
diff --git a/include/linux/node.h b/include/linux/node.h
index 2c7529335b21..866e3323f1fd 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -85,6 +85,8 @@ struct node_cache_attrs {
 void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs);
 void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 			 enum access_coordinate_class access);
+void node_update_perf_attrs(unsigned int nid, struct access_coordinate *coord,
+			    enum access_coordinate_class access);
 #else
 static inline void node_add_cache(unsigned int nid,
 				  struct node_cache_attrs *cache_attrs)
@@ -96,6 +98,12 @@ static inline void node_set_perf_attrs(unsigned int nid,
 				       enum access_coordinate_class access)
 {
 }
+
+static inline void node_update_perf_attrs(unsigned int nid,
+					  struct access_coordinate *coord,
+					  enum access_coordinate_class access)
+{
+}
 #endif
 
 struct node {
-- 
2.50.1


