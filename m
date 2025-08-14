Return-Path: <linux-acpi+bounces-15706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11313B26D70
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012D5AA0454
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA66212B0C;
	Thu, 14 Aug 2025 17:17:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7AA32145D;
	Thu, 14 Aug 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191856; cv=none; b=XU6IsFLUYwHx+fihYrKmKD4PtjmUiWI0tqXduXKcppMhGip4cq56y4G/2Jf122nPwydVBIJb+mOGXjn5BmD6VXOwlfoUUozS8cobDBY/wqM4xxunc/q6Fvg/VuQCAfroRikGbZD3KcD+hmkCX3CcTeaxtzBZlpvYLmZwXNbEydA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191856; c=relaxed/simple;
	bh=VHAyX8lQ9ZY5EEEs5iW9VxbbfBWZFd6zMPtgUD4CwWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljpOTAmsqVoSRPhyI48kUGuqWoJ0y3fE1U83T2kD84sV9Gb8MkgW57K6ERkOACzfOXLFC0IhPZELSB0jHIqaaj9WbbcRpgP4+s2LpvZzDXVilHV4RVjdX2dHjseBUJUF+KpNgK/RN7ufkXPoPYOlv5KjmxZldJCJO3lm6vseWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F52C4CEED;
	Thu, 14 Aug 2025 17:17:34 +0000 (UTC)
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
Subject: [PATCH 2/4] drivers/base/node: Add a helper function node_update_perf_attrs()
Date: Thu, 14 Aug 2025 10:16:48 -0700
Message-ID: <20250814171650.3002930-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814171650.3002930-1-dave.jiang@intel.com>
References: <20250814171650.3002930-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/base/node.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/node.h |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 3399594136b2..cf395da18c9b 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -248,6 +248,45 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 }
 EXPORT_SYMBOL_GPL(node_set_perf_attrs);
 
+/**
+ * node_update_perf_attrs - Update the performance values for given access class
+ * @nid: Node identifier to be updated
+ * @coord: Heterogeneous memory performance coordinates
+ * @access: The access class the for the given attributes
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
+	if (access == ACCESS_COORDINATE_CPU) {
+		if (mempolicy_set_node_perf(nid, coord)) {
+			pr_info("failed to set mempolicy attrs for node %d\n",
+				nid);
+		}
+	}
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


