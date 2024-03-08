Return-Path: <linux-acpi+bounces-4209-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5CE876C99
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 23:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04E91C2091A
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91685E06C;
	Fri,  8 Mar 2024 22:01:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFEE5CDC9;
	Fri,  8 Mar 2024 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935276; cv=none; b=kHMId93qHW70hKboMsXzd4idbiD6WVLDhoHqXhiJM2PDBdmnpxJeCLm41663OnzxaNz8xTl1sXBP/iX2QHW4qTYavIELzh+hgbYYNfK8zORlL2ZuQ2FGfyT8FImhyCEcQ98Akq9Ek7qel6r6eMsqgp5I3lADP679jGWMrg6v2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935276; c=relaxed/simple;
	bh=YaYqCKNbazvnxtrF1YBGbBgHt2VF05Keddl6vOLn3/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5Sefl4x4HdMjaaGsOvezotOlAq4usX4QUEm1ofVDOYReFtnYMpCvf9SFKe4LwPfgQZqVaHFjj4b23gZCEn3T5cvYJQFCVdKV7fJp7IE5XtkIJWnEWG/2m9lwDRigHyUIM0zHOWuTN3v/rxp6suVuNNMKGxIQGpxEcLMv7HSKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75270C433F1;
	Fri,  8 Mar 2024 22:01:15 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	rafael@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v7 02/12] base/node / ACPI: Enumerate node access class for 'struct access_coordinate'
Date: Fri,  8 Mar 2024 14:59:21 -0700
Message-ID: <20240308220055.2172956-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308220055.2172956-1-dave.jiang@intel.com>
References: <20240308220055.2172956-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both generic node and HMAT handling code have been using magic numbers to
indicate access classes for 'struct access_coordinate'. Introduce enums to
enumerate the access0 and access1 classes shared by the two subsystems.
Update the function parameters and callers as appropriate to utilize the
new enum.

Access0 is named to ACCESS_COORDINATE_LOCAL in order to indicate that the
access class is for 'struct access_coordinate' between a target node and
the nearest initiator node.

Access1 is named to ACCESS_COORDINATE_CPU in order to indicate that the
access class is for 'struct access_coordinate' between a target node and
the nearest CPU node.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c | 26 ++++++++++++++------------
 drivers/base/node.c      |  6 +++---
 include/linux/node.h     | 18 +++++++++++++++---
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index a26e7793ec4e..e0144cfbf1f3 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -59,9 +59,7 @@ struct target_cache {
 };
 
 enum {
-	NODE_ACCESS_CLASS_0 = 0,
-	NODE_ACCESS_CLASS_1,
-	NODE_ACCESS_CLASS_GENPORT_SINK,
+	NODE_ACCESS_CLASS_GENPORT_SINK = ACCESS_COORDINATE_MAX,
 	NODE_ACCESS_CLASS_MAX,
 };
 
@@ -374,11 +372,11 @@ static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_px
 
 	if (target && target->processor_pxm == init_pxm) {
 		hmat_update_target_access(target, type, value,
-					  NODE_ACCESS_CLASS_0);
+					  ACCESS_COORDINATE_LOCAL);
 		/* If the node has a CPU, update access 1 */
 		if (node_state(pxm_to_node(init_pxm), N_CPU))
 			hmat_update_target_access(target, type, value,
-						  NODE_ACCESS_CLASS_1);
+						  ACCESS_COORDINATE_CPU);
 	}
 }
 
@@ -709,7 +707,8 @@ static void hmat_update_target_attrs(struct memory_target *target,
 	 */
 	if (target->processor_pxm != PXM_INVAL) {
 		cpu_nid = pxm_to_node(target->processor_pxm);
-		if (access == 0 || node_state(cpu_nid, N_CPU)) {
+		if (access == ACCESS_COORDINATE_LOCAL ||
+		    node_state(cpu_nid, N_CPU)) {
 			set_bit(target->processor_pxm, p_nodes);
 			return;
 		}
@@ -737,7 +736,8 @@ static void hmat_update_target_attrs(struct memory_target *target,
 		list_for_each_entry(initiator, &initiators, node) {
 			u32 value;
 
-			if (access == 1 && !initiator->has_cpu) {
+			if (access == ACCESS_COORDINATE_CPU &&
+			    !initiator->has_cpu) {
 				clear_bit(initiator->processor_pxm, p_nodes);
 				continue;
 			}
@@ -782,8 +782,10 @@ static void hmat_register_target_initiators(struct memory_target *target)
 {
 	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
 
-	__hmat_register_target_initiators(target, p_nodes, 0);
-	__hmat_register_target_initiators(target, p_nodes, 1);
+	__hmat_register_target_initiators(target, p_nodes,
+					  ACCESS_COORDINATE_LOCAL);
+	__hmat_register_target_initiators(target, p_nodes,
+					  ACCESS_COORDINATE_CPU);
 }
 
 static void hmat_register_target_cache(struct memory_target *target)
@@ -854,8 +856,8 @@ static void hmat_register_target(struct memory_target *target)
 	if (!target->registered) {
 		hmat_register_target_initiators(target);
 		hmat_register_target_cache(target);
-		hmat_register_target_perf(target, NODE_ACCESS_CLASS_0);
-		hmat_register_target_perf(target, NODE_ACCESS_CLASS_1);
+		hmat_register_target_perf(target, ACCESS_COORDINATE_LOCAL);
+		hmat_register_target_perf(target, ACCESS_COORDINATE_CPU);
 		target->registered = true;
 	}
 	mutex_unlock(&target_lock);
@@ -927,7 +929,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
 		return NOTIFY_OK;
 
 	mutex_lock(&target_lock);
-	hmat_update_target_attrs(target, p_nodes, 1);
+	hmat_update_target_attrs(target, p_nodes, ACCESS_COORDINATE_CPU);
 	mutex_unlock(&target_lock);
 
 	perf = &target->coord[1];
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 1c05640461dd..a73b0c9a401a 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -126,7 +126,7 @@ static void node_access_release(struct device *dev)
 }
 
 static struct node_access_nodes *node_init_node_access(struct node *node,
-						       unsigned int access)
+						       enum access_coordinate_class access)
 {
 	struct node_access_nodes *access_node;
 	struct device *dev;
@@ -191,7 +191,7 @@ static struct attribute *access_attrs[] = {
  * @access: The access class the for the given attributes
  */
 void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
-			 unsigned int access)
+			 enum access_coordinate_class access)
 {
 	struct node_access_nodes *c;
 	struct node *node;
@@ -689,7 +689,7 @@ int register_cpu_under_node(unsigned int cpu, unsigned int nid)
  */
 int register_memory_node_under_compute_node(unsigned int mem_nid,
 					    unsigned int cpu_nid,
-					    unsigned int access)
+					    enum access_coordinate_class access)
 {
 	struct node *init_node, *targ_node;
 	struct node_access_nodes *initiator, *target;
diff --git a/include/linux/node.h b/include/linux/node.h
index 25b66d705ee2..dfc004e4bee7 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -34,6 +34,18 @@ struct access_coordinate {
 	unsigned int write_latency;
 };
 
+/*
+ * ACCESS_COORDINATE_LOCAL correlates to ACCESS CLASS 0
+ *	- access_coordinate between target node and nearest initiator node
+ * ACCESS_COORDINATE_CPU correlates to ACCESS CLASS 1
+ *	- access_coordinate between target node and nearest CPU node
+ */
+enum access_coordinate_class {
+	ACCESS_COORDINATE_LOCAL,
+	ACCESS_COORDINATE_CPU,
+	ACCESS_COORDINATE_MAX
+};
+
 enum cache_indexing {
 	NODE_CACHE_DIRECT_MAP,
 	NODE_CACHE_INDEXED,
@@ -66,7 +78,7 @@ struct node_cache_attrs {
 #ifdef CONFIG_HMEM_REPORTING
 void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs);
 void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
-			 unsigned access);
+			 enum access_coordinate_class access);
 #else
 static inline void node_add_cache(unsigned int nid,
 				  struct node_cache_attrs *cache_attrs)
@@ -75,7 +87,7 @@ static inline void node_add_cache(unsigned int nid,
 
 static inline void node_set_perf_attrs(unsigned int nid,
 				       struct access_coordinate *coord,
-				       unsigned access)
+				       enum access_coordinate_class access)
 {
 }
 #endif
@@ -137,7 +149,7 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
 
 extern int register_memory_node_under_compute_node(unsigned int mem_nid,
 						   unsigned int cpu_nid,
-						   unsigned access);
+						   enum access_coordinate_class access);
 #else
 static inline void node_dev_init(void)
 {
-- 
2.44.0


