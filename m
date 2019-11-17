Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBB6FFB37
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2019 19:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKQSAJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Nov 2019 13:00:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:26321 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQSAI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Nov 2019 13:00:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 10:00:08 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="236672940"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 10:00:07 -0800
Subject: [PATCH v2 14/18] acpi/numa: Up-level "map to online node"
 functionality
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Michal Hocko <mhocko@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 17 Nov 2019 09:45:51 -0800
Message-ID: <157401275104.43284.15865121806241743141.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The acpi_map_pxm_to_online_node() helper is used to find the closest
online node to a given proximity domain. This is used to map devices in
a proximity domain with no online memory or cpus to the closest online
node and populate a device's 'numa_node' property. The numa_node
property allows applications to be migrated "close" to a resource.

In preparation for providing a generic facility to optionally map an
address range to its closest online node, or the node the range would
represent were it to be onlined (target_node), up-level the core of
acpi_map_pxm_to_online_node() to a generic mm/numa helper.

Cc: Michal Hocko <mhocko@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa.c  |   41 -----------------------------------------
 include/linux/acpi.h |   23 ++++++++++++++++++++++-
 include/linux/numa.h |    9 +++++++++
 mm/mempolicy.c       |   30 ++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index eadbf90e65d1..47b4969d9b93 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -72,47 +72,6 @@ int acpi_map_pxm_to_node(int pxm)
 }
 EXPORT_SYMBOL(acpi_map_pxm_to_node);
 
-/**
- * acpi_map_pxm_to_online_node - Map proximity ID to online node
- * @pxm: ACPI proximity ID
- *
- * This is similar to acpi_map_pxm_to_node(), but always returns an online
- * node.  When the mapped node from a given proximity ID is offline, it
- * looks up the node distance table and returns the nearest online node.
- *
- * ACPI device drivers, which are called after the NUMA initialization has
- * completed in the kernel, can call this interface to obtain their device
- * NUMA topology from ACPI tables.  Such drivers do not have to deal with
- * offline nodes.  A node may be offline when a device proximity ID is
- * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
- * "numa=off" on x86.
- */
-int acpi_map_pxm_to_online_node(int pxm)
-{
-	int node, min_node;
-
-	node = acpi_map_pxm_to_node(pxm);
-
-	if (node == NUMA_NO_NODE)
-		node = 0;
-
-	min_node = node;
-	if (!node_online(node)) {
-		int min_dist = INT_MAX, dist, n;
-
-		for_each_online_node(n) {
-			dist = node_distance(node, n);
-			if (dist < min_dist) {
-				min_dist = dist;
-				min_node = n;
-			}
-		}
-	}
-
-	return min_node;
-}
-EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
-
 static void __init
 acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8b4e516bac00..aeedd09f2f71 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -401,9 +401,30 @@ extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
 #ifdef CONFIG_ACPI_NUMA
-int acpi_map_pxm_to_online_node(int pxm);
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);
+
+/**
+ * acpi_map_pxm_to_online_node - Map proximity ID to online node
+ * @pxm: ACPI proximity ID
+ *
+ * This is similar to acpi_map_pxm_to_node(), but always returns an online
+ * node.  When the mapped node from a given proximity ID is offline, it
+ * looks up the node distance table and returns the nearest online node.
+ *
+ * ACPI device drivers, which are called after the NUMA initialization has
+ * completed in the kernel, can call this interface to obtain their device
+ * NUMA topology from ACPI tables.  Such drivers do not have to deal with
+ * offline nodes.  A node may be offline when a device proximity ID is
+ * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
+ * "numa=off" on x86.
+ */
+static inline int acpi_map_pxm_to_online_node(int pxm)
+{
+	int node = acpi_map_pxm_to_node(pxm);
+
+	return numa_map_to_online_node(node);
+}
 #else
 static inline int acpi_map_pxm_to_online_node(int pxm)
 {
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 110b0e5d0fb0..20f4e44b186c 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -13,4 +13,13 @@
 
 #define	NUMA_NO_NODE	(-1)
 
+#ifdef CONFIG_NUMA
+int numa_map_to_online_node(int node);
+#else
+static inline int numa_map_to_online_node(int node)
+{
+	return NUMA_NO_NODE;
+}
+#endif
+
 #endif /* _LINUX_NUMA_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4ae967bcf954..e2d8dd21ce9d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -127,6 +127,36 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+/**
+ * numa_map_to_online_node - Find closest online node
+ * @nid: Node id to start the search
+ *
+ * Lookup the next closest node by distance if @nid is not online.
+ */
+int numa_map_to_online_node(int node)
+{
+	int min_node;
+
+	if (node == NUMA_NO_NODE)
+		node = 0;
+
+	min_node = node;
+	if (!node_online(node)) {
+		int min_dist = INT_MAX, dist, n;
+
+		for_each_online_node(n) {
+			dist = node_distance(node, n);
+			if (dist < min_dist) {
+				min_dist = dist;
+				min_node = n;
+			}
+		}
+	}
+
+	return min_node;
+}
+EXPORT_SYMBOL_GPL(numa_map_to_online_node);
+
 struct mempolicy *get_task_policy(struct task_struct *p)
 {
 	struct mempolicy *pol = p->mempolicy;

