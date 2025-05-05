Return-Path: <linux-acpi+bounces-13470-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4915FAA9B78
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 20:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AF61694BB
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45FA26C386;
	Mon,  5 May 2025 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvigTnul"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFFA25EF97;
	Mon,  5 May 2025 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469414; cv=none; b=L1io2BUDWwevxLtYlqdloj28nung/BNPKhgxBq/cCx5naswtkBP8s1CRui5p3oOqGbp/Dq9nbH1X8huERj0H1vgsYv4ym91cF01yKga7pH80O69776IJCPyXa+ozkLlJroC97VwYacHtqilukYlOxb+SYBMOoRGzfnXs+df+z1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469414; c=relaxed/simple;
	bh=fUDuxMDvBRbnis329OXQrQBYRUoajKWHaTqaVVVXLk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRqm/XoCaWf68y1YsxvIiCCpMwht62r3e3zlKp7j9t6Z44Jp4ZTgfnnccnGKNojLu45lQToFYIr5x0SKVkzgeB1u/nYWiLdZbo/m+ZkNtRKBV+aloMUAZUKakmtTAjMLFTTpJJP+yHu42mzKfVWW5wQR2OhSSXJeaybByFLnTHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvigTnul; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e637edaa652so3633141276.1;
        Mon, 05 May 2025 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746469410; x=1747074210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJrh1fpJUM3CnP5u/kryoFi30LRmFNk3LukIvMTEexM=;
        b=OvigTnulhv4xVs6BZT6Z5TgGCAcMYf/ODPamOVzublYq6F8IewT2VAj9uJTS+egyBg
         3TokVKCvtlA8BfqtVkmSU2dsxmRBmp18ppxaJapj5tH/OUc+Ark7taMVkakMJqzfpBf7
         l8vlbWOLNT5oj/SDyuVu+oDh13bsybegzws5/FL2WWmcO6e868hulZmwg0ztGq42uc5x
         aMQYm23qAoEqaOuQHEhgfEUvmgnnWHEIwiLr9J7kataTSqINSvP+mRZPKmUoanjTmgGB
         +fVdFzQTU8UG+LBWhXwnr/UuID9kPWYfmsafsLIhnMU+b0RenIHCYCJu1fYpKGG0e9v8
         qZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746469410; x=1747074210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJrh1fpJUM3CnP5u/kryoFi30LRmFNk3LukIvMTEexM=;
        b=vNmD10i91eRGRZaxugBLmy6hHS7kTDYfNEKJZy0LQMa8frv7e2uAErcCIBtgjkyYul
         1rrdN2hHZzD4ZX6gB9scoKX+FPGKMw4a//XnTaiIyvYH58hVFIfMDntuGhlqS22UzQkF
         kEt23KusZ2XezNT6JagMiEdgk7JRZnk2mwfFlDVaQ2BIWySPSAvjlHJalA7na/sELdyp
         t3LUxl6sM7YJX7EOkbO7uTCu/xuue1HrBzFe6hkRjNQnTFaxhUIiNCRpLiuNqNNidFTt
         gWGZb4ftvq3WxHJJZFCA00Sneq03Z0E0gS2xgSiBzsySlygl1I6r+4m2GTUT7XqYpDR+
         v6mA==
X-Forwarded-Encrypted: i=1; AJvYcCXk21hBvI6ymkEUV86SNdT8g/uEZmeJZvlA/ZRC9v3uRb6zst/2BFqYwz3NALjwJBLmNzq+Blqm8ZUf@vger.kernel.org, AJvYcCXrx4lF+ziiMolqBwkX1mPtP5M66dgY+pizfWc/Lc5eQiwu84ucAMYIhYXglFiS9cRSM/ZdFOYfS7Hlhoe4@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhm38MoIrN98/edoIP+KYBBZ5IRAZ+cG46A8jLb/AYHcteBks
	r0WMmrO+ZnVqk/bYZFIaZvKMiOGVtc0dsSx/NBk0RszorAjr/XMm
X-Gm-Gg: ASbGnctYpvN01+YBI2f97ctZZrM80d3cIsczShTycAZP6ChJuPligjBDwataRQbAoMB
	EPImxyLIrSjYMzu0oxH72BPk3/boH2ohDGBo4FqsyIhcjy2EtN6SqJJ41gW986dATmaKX+blF9J
	FZC+RPQsW85KubqEFGDHDTBP5tKYCTWEk0tPLc3AwhhedE/ZUErdPE5Fg5TiObGB2XfUGicnAH3
	0UGVyRoGG6ktJMc79R7q3uVoApf8O70YMjNFTmGoMRe0yer+iC3ihXui/pJrG+DNzL57kQXgxdb
	W60cwhz7lWaAtFB0EJI8+kn/VyWS/Px4H7G4ML1h
X-Google-Smtp-Source: AGHT+IE6s3qswJE8SErBzlimmGslVyunD60C+MR+Gh9O8dkDNf8U2qql+vS27WxmuoWbADP0T04+0A==
X-Received: by 2002:a05:690c:314:b0:6fe:abff:cb17 with SMTP id 00721157ae682-708eaf6437emr105696127b3.26.1746469409911;
        Mon, 05 May 2025 11:23:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70918578b1fsm740127b3.19.2025.05.05.11.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:23:29 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: gourry@gourry.net,
	ying.huang@linux.alibaba.com
Cc: honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Mon,  5 May 2025 11:23:28 -0700
Message-ID: <20250505182328.4148265-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On machines with multiple memory nodes, interleaving page allocations
across nodes allows for better utilization of each node's bandwidth.
Previous work by Gregory Price [1] introduced weighted interleave, which
allowed for pages to be allocated across nodes according to user-set ratios.

Ideally, these weights should be proportional to their bandwidth, so
that under bandwidth pressure, each node uses its maximal efficient
bandwidth and prevents latency from increasing exponentially.

Previously, weighted interleave's default weights were just 1s -- which
would be equivalent to the (unweighted) interleave mempolicy, which goes
through the nodes in a round-robin fashion, ignoring bandwidth information.

This patch has two main goals:
First, it makes weighted interleave easier to use for users who wish to
relieve bandwidth pressure when using nodes with varying bandwidth (CXL).
By providing a set of "real" default weights that just work out of the
box, users who might not have the capability (or wish to) perform
experimentation to find the most optimal weights for their system can
still take advantage of bandwidth-informed weighted interleave.

Second, it allows for weighted interleave to dynamically adjust to
hotplugged memory with new bandwidth information. Instead of manually
updating node weights every time new bandwidth information is reported
or taken off, weighted interleave adjusts and provides a new set of
default weights for weighted interleave to use when there is a change
in bandwidth information.

To meet these goals, this patch introduces an auto-configuration mode
for the interleave weights that provides a reasonable set of default
weights, calculated using bandwidth data reported by the system. In auto
mode, weights are dynamically adjusted based on whatever the current
bandwidth information reports (and responds to hotplug events).

This patch still supports users manually writing weights into the nodeN
sysfs interface by entering into manual mode. When a user enters manual
mode, the system stops dynamically updating any of the node weights,
even during hotplug events that shift the optimal weight distribution.

A new sysfs interface "auto" is introduced, which allows users to switch
between the auto (writing 1 or Y) and manual (writing 0 or N) modes. The
system also automatically enters manual mode when a nodeN interface is
manually written to.

There is one functional change that this patch makes to the existing
weighted_interleave ABI: previously, writing 0 directly to a nodeN
interface was said to reset the weight to the system default. Before
this patch, the default for all weights were 1, which meant that writing
0 and 1 were functionally equivalent. With this patch, writing 0 is invalid.

[1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/

Suggested-by: Yunjeong Mun <yunjeong.mun@sk.com>
Suggested-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
Suggested-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Co-developed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
Changelog
v8:
- Rebased on top of mm-new (93129fd5a3a9c87fe0e53ff8b0bfa30ee43a873a)
  - Specifically, to include Rakie Kim's patchset mm/mempolicy:
    Enhance sysfs handling for memory hotplug in weighted interleave
    (1f553871c3925bd1fc474b5fad53a0e8609cd5b0)
  - Rebasing also included cleaning up this patch's sysfs creation.
- Fixes to prevent racing between rcu_access_pointer and rcu_dereference
- Wordsmithing

v7:
- Wordsmithing
- Rename iw_table_lock to wi_state_lock
- Clean up reduce_interleave_weights, as suggested by Yunjeong Mun.
  - Combine iw_table allocation & initialization to be outside the function.
  - Skip scaling to [1,100] before scaling to [1,weightiness].
- Removed the second part of this patch, which prevented creating weight
  sysfs interfaces for memoryless nodes.
- Added Suggested-by tags; I should have done this much, much earlier.

v6:
- iw_weights and mode_auto are combined into one rcu-protected struct.
- Protection against memoryless nodes, as suggested by Oscar Salvador
- Wordsmithing (documentation, commit message and comments), as suggested
  by Andrew Morton.
- Removed unnecessary #include statement in hmat.c, as pointed out by
  Harry (Hyeonggon) Yoo and Ying Huang.
- Bandwidth values changed from u64_t to unsigned int, as pointed out by
  Ying Huang and Dan Carpenter.
- RCU optimizations, as suggested by Ying Huang.
- A second patch is included to fix unintended behavior that creates a
  weight knob for memoryless nodes as well.
- Sysfs show/store functions use str_true_false & kstrtobool.
- Fix a build error in 32-bit systems, which are unable to perform
  64-bit division by casting 64-bit values to 32-bit, if under the range.

v5:
- I accidentally forgot to add the mm/mempolicy: subject tag since v1 of
  this patch. Added to the subject now!
- Wordsmithing, correcting typos, and re-naming variables for clarity.
- No functional changes.

v4:
- Renamed the mode interface to the "auto" interface, which now only
  emits either 'Y' or 'N'. Users can now interact with it by
  writing 'Y', '1', 'N', or '0' to it.
- Added additional documentation to the nodeN sysfs interface.
- Makes sure iw_table locks are properly held.
- Removed unlikely() call in reduce_interleave_weights.
- Wordsmithing

v3:
- Weightiness (max_node_weight) is now fixed to 32.
- Instead, the sysfs interface now exposes a "mode" parameter, which
  can either be "auto" or "manual".
  - Thank you Hyeonggon and Honggyu for the feedback.
- Documentation updated to reflect new sysfs interface, explicitly
  specifies that 0 is invalid.
  - Thank you Gregory and Ying for the discussion on how best to
    handle the 0 case.
- Re-worked nodeN sysfs store to handle auto --> manual shifts
- mempolicy_set_node_perf internally handles the auto / manual
  case differently now. bw is always updated, iw updates depend on
  what mode the user is in.
- Wordsmithing comments for clarity.
- Removed RFC tag.

v2:
- Name of the interface is changed: "max_node_weight" --> "weightiness"
- Default interleave weight table no longer exists. Rather, the
  interleave weight table is initialized with the defaults, if bandwidth
  information is available.
  - In addition, all sections that handle iw_table have been changed
    to reference iw_table if it exists, otherwise defaulting to 1.
- All instances of unsigned long are converted to uint64_t to guarantee
  support for both 32-bit and 64-bit machines
- sysfs initialization cleanup
- Documentation has been rewritten to explicitly outline expected
  behavior and expand on the interpretation of "weightiness".
- kzalloc replaced with kcalloc for readability
- Thank you Gregory and Hyeonggon for your review & feedback!

 ...fs-kernel-mm-mempolicy-weighted-interleave |  35 +-
 drivers/base/node.c                           |   9 +
 include/linux/mempolicy.h                     |  13 +
 mm/mempolicy.c                                | 311 ++++++++++++++----
 4 files changed, 307 insertions(+), 61 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
index 0b7972de04e9..ec13382c606f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -20,6 +20,35 @@ Description:	Weight configuration interface for nodeN
 		Minimum weight: 1
 		Maximum weight: 255
 
-		Writing an empty string or `0` will reset the weight to the
-		system default. The system default may be set by the kernel
-		or drivers at boot or during hotplug events.
+		Writing invalid values (i.e. any values not in [1,255],
+		empty string, ...) will return -EINVAL.
+
+		Changing the weight to a valid value will automatically
+		update the system to manual mode as well.
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/auto
+Date:		May 2025
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Auto-weighting configuration interface
+
+		Configuration mode for weighted interleave. 'true' indicates
+		that the system is in auto mode, and a 'false' indicates that
+		the system is in manual mode.
+
+		In auto mode, all node weights are re-calculated and overwritten
+		(visible via the nodeN interfaces) whenever new bandwidth data
+		is made available during either boot or hotplug events.
+
+		In manual mode, node weights can only be updated by the user.
+		Note that nodes that are onlined with previously set weights
+		will reuse those weights. If they were not previously set or
+		are onlined with missing bandwidth data, the weights will use
+		a default weight of 1.
+
+		Writing any true value string (e.g. Y or 1) will enable auto
+		mode, while writing any false value string (e.g. N or 0) will
+		enable manual mode. All other strings are ignored and will
+		return -EINVAL.
+
+		Writing a new weight to a node directly via the nodeN interface
+		will also automatically switch the system to manual mode.
diff --git a/drivers/base/node.c b/drivers/base/node.c
index cd13ef287011..25ab9ec14eb8 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memory.h>
+#include <linux/mempolicy.h>
 #include <linux/vmstat.h>
 #include <linux/notifier.h>
 #include <linux/node.h>
@@ -214,6 +215,14 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 			break;
 		}
 	}
+
+	/* When setting CPU access coordinates, update mempolicy */
+	if (access == ACCESS_COORDINATE_CPU) {
+		if (mempolicy_set_node_perf(nid, coord)) {
+			pr_info("failed to set mempolicy attrs for node %d\n",
+				nid);
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(node_set_perf_attrs);
 
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ce9885e0178a..3e8da8ba1146 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
+#include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/pagemap.h>
 #include <uapi/linux/mempolicy.h>
@@ -56,6 +57,15 @@ struct mempolicy {
 	} w;
 };
 
+/*
+ * A null weighted_interleave_state is interpted as having .mode = "auto",
+ * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
+ */
+struct weighted_interleave_state {
+	bool mode_auto;
+	u8 iw_table[];
+};
+
 /*
  * Support for managing mempolicy data objects (clone, copy, destroy)
  * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
@@ -178,6 +188,9 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 
 extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
 
+extern int mempolicy_set_node_perf(unsigned int node,
+				   struct access_coordinate *coords);
+
 #else
 
 struct mempolicy {};
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f43951668c41..f542691b7123 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -109,6 +109,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
+#include <linux/gcd.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -140,31 +141,130 @@ static struct mempolicy default_policy = {
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
 /*
- * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
- * system-default value should be used. A NULL iw_table also denotes that
- * system-default values should be used. Until the system-default table
- * is implemented, the system-default is always 1.
- *
- * iw_table is RCU protected
+ * weightiness balances the tradeoff between small weights (cycles through nodes
+ * faster, more fair/even distribution) and large weights (smaller errors
+ * between actual bandwidth ratios and weight ratios). 32 is a number that has
+ * been found to perform at a reasonable compromise between the two goals.
+ */
+static const int weightiness = 32;
+
+static struct weighted_interleave_state __rcu *wi_state;
+static unsigned int *node_bw_table;
+
+/*
+ * wi_state_lock protects both wi_state and node_bw_table.
+ * node_bw_table is only used by writers to update wi_state.
  */
-static u8 __rcu *iw_table;
-static DEFINE_MUTEX(iw_table_lock);
+static DEFINE_MUTEX(wi_state_lock);
 
 static u8 get_il_weight(int node)
 {
-	u8 *table;
-	u8 weight;
+	struct weighted_interleave_state *state;
+	u8 weight = 1;
 
 	rcu_read_lock();
-	table = rcu_dereference(iw_table);
-	/* if no iw_table, use system default */
-	weight = table ? table[node] : 1;
-	/* if value in iw_table is 0, use system default */
-	weight = weight ? weight : 1;
+	state = rcu_dereference(wi_state);
+	if (state)
+		weight = state->iw_table[node];
 	rcu_read_unlock();
 	return weight;
 }
 
+/*
+ * Convert bandwidth values into weighted interleave weights.
+ * Call with wi_state_lock.
+ */
+static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
+{
+	u64 sum_bw = 0;
+	unsigned int cast_sum_bw, scaling_factor = 1, iw_gcd = 0;
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY)
+		sum_bw += bw[nid];
+
+	/* Scale bandwidths to whole numbers in the range [1, weightiness] */
+	for_each_node_state(nid, N_MEMORY) {
+		/*
+		 * Try not to perform 64-bit division.
+		 * If sum_bw < scaling_factor, then sum_bw < U32_MAX.
+		 * If sum_bw > scaling_factor, then round the weight up to 1.
+		 */
+		scaling_factor = weightiness * bw[nid];
+		if (bw[nid] && sum_bw < scaling_factor) {
+			cast_sum_bw = (unsigned int)sum_bw;
+			new_iw[nid] = scaling_factor / cast_sum_bw;
+		} else {
+			new_iw[nid] = 1;
+		}
+		if (!iw_gcd)
+			iw_gcd = new_iw[nid];
+		iw_gcd = gcd(iw_gcd, new_iw[nid]);
+	}
+
+	/* 1:2 is strictly better than 16:32. Reduce by the weights' GCD. */
+	for_each_node_state(nid, N_MEMORY)
+		new_iw[nid] /= iw_gcd;
+}
+
+int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
+{
+	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
+	unsigned int *old_bw, *new_bw;
+	unsigned int bw_val;
+	int i;
+
+	bw_val = min(coords->read_bandwidth, coords->write_bandwidth);
+	new_bw = kcalloc(nr_node_ids, sizeof(unsigned int), GFP_KERNEL);
+	if (!new_bw)
+		return -ENOMEM;
+
+	new_wi_state = kmalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
+			       GFP_KERNEL);
+	if (!new_wi_state) {
+		kfree(new_bw);
+		return -ENOMEM;
+	}
+	new_wi_state->mode_auto = true;
+	for (i = 0; i < nr_node_ids; i++)
+		new_wi_state->iw_table[i] = 1;
+
+	/*
+	 * Update bandwidth info, even in manual mode. That way, when switching
+	 * to auto mode in the future, iw_table can be overwritten using
+	 * accurate bw data.
+	 */
+	mutex_lock(&wi_state_lock);
+
+	old_bw = node_bw_table;
+	if (old_bw)
+		memcpy(new_bw, old_bw, nr_node_ids * sizeof(*old_bw));
+	new_bw[node] = bw_val;
+	node_bw_table = new_bw;
+
+	old_wi_state = rcu_dereference_protected(wi_state,
+					lockdep_is_held(&wi_state_lock));
+	if (old_wi_state && !old_wi_state->mode_auto) {
+		/* Manual mode; skip reducing weights and updating wi_state */
+		mutex_unlock(&wi_state_lock);
+		kfree(new_wi_state);
+		goto out;
+	}
+
+	/* NULL wi_state assumes auto=true; reduce weights and update wi_state*/
+	reduce_interleave_weights(new_bw, new_wi_state->iw_table);
+	rcu_assign_pointer(wi_state, new_wi_state);
+
+	mutex_unlock(&wi_state_lock);
+	if (old_wi_state) {
+		synchronize_rcu();
+		kfree(old_wi_state);
+	}
+out:
+	kfree(old_bw);
+	return 0;
+}
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -2023,26 +2123,28 @@ static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
 
 static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 {
+	struct weighted_interleave_state *state;
 	nodemask_t nodemask;
 	unsigned int target, nr_nodes;
-	u8 *table;
+	u8 *table = NULL;
 	unsigned int weight_total = 0;
 	u8 weight;
-	int nid;
+	int nid = 0;
 
 	nr_nodes = read_once_policy_nodemask(pol, &nodemask);
 	if (!nr_nodes)
 		return numa_node_id();
 
 	rcu_read_lock();
-	table = rcu_dereference(iw_table);
+
+	state = rcu_dereference(wi_state);
+	/* Uninitialized wi_state means we should assume all weights are 1 */
+	if (state)
+		table = state->iw_table;
+
 	/* calculate the total weight */
-	for_each_node_mask(nid, nodemask) {
-		/* detect system default usage */
-		weight = table ? table[nid] : 1;
-		weight = weight ? weight : 1;
-		weight_total += weight;
-	}
+	for_each_node_mask(nid, nodemask)
+		weight_total += table ? table[nid] : 1;
 
 	/* Calculate the node offset based on totals */
 	target = ilx % weight_total;
@@ -2050,7 +2152,6 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	while (target) {
 		/* detect system default usage */
 		weight = table ? table[nid] : 1;
-		weight = weight ? weight : 1;
 		if (target < weight)
 			break;
 		target -= weight;
@@ -2451,13 +2552,14 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
+	struct weighted_interleave_state *state;
 	struct task_struct *me = current;
 	unsigned int cpuset_mems_cookie;
 	unsigned long total_allocated = 0;
 	unsigned long nr_allocated = 0;
 	unsigned long rounds;
 	unsigned long node_pages, delta;
-	u8 *table, *weights, weight;
+	u8 *weights, weight;
 	unsigned int weight_total = 0;
 	unsigned long rem_pages = nr_pages;
 	nodemask_t nodes;
@@ -2507,17 +2609,19 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 		return total_allocated;
 
 	rcu_read_lock();
-	table = rcu_dereference(iw_table);
-	if (table)
-		memcpy(weights, table, nr_node_ids);
-	rcu_read_unlock();
+	state = rcu_dereference(wi_state);
+	if (state) {
+		memcpy(weights, state->iw_table, nr_node_ids * sizeof(u8));
+		rcu_read_unlock();
+	} else {
+		rcu_read_unlock();
+		for (i = 0; i < nr_node_ids; i++)
+			weights[i] = 1;
+	}
 
 	/* calculate total, detect system default usage */
-	for_each_node_mask(node, nodes) {
-		if (!weights[node])
-			weights[node] = 1;
+	for_each_node_mask(node, nodes)
 		weight_total += weights[node];
-	}
 
 	/*
 	 * Calculate rounds/partial rounds to minimize __alloc_pages_bulk calls.
@@ -3431,6 +3535,7 @@ struct iw_node_attr {
 struct sysfs_wi_group {
 	struct kobject wi_kobj;
 	struct mutex kobj_lock;
+	struct kobj_attribute auto_kobj_attr;
 	struct iw_node_attr *nattrs[];
 };
 
@@ -3450,31 +3555,104 @@ static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t count)
 {
+	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
 	struct iw_node_attr *node_attr;
-	u8 *new;
-	u8 *old;
 	u8 weight = 0;
+	int i;
 
 	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
 	if (count == 0 || sysfs_streq(buf, ""))
 		weight = 0;
-	else if (kstrtou8(buf, 0, &weight))
+	else if (kstrtou8(buf, 0, &weight) || weight == 0)
 		return -EINVAL;
 
-	new = kzalloc(nr_node_ids, GFP_KERNEL);
-	if (!new)
+	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
+			       GFP_KERNEL);
+	if (!new_wi_state)
 		return -ENOMEM;
 
-	mutex_lock(&iw_table_lock);
-	old = rcu_dereference_protected(iw_table,
-					lockdep_is_held(&iw_table_lock));
-	if (old)
-		memcpy(new, old, nr_node_ids);
-	new[node_attr->nid] = weight;
-	rcu_assign_pointer(iw_table, new);
-	mutex_unlock(&iw_table_lock);
-	synchronize_rcu();
-	kfree(old);
+	mutex_lock(&wi_state_lock);
+	old_wi_state = rcu_dereference_protected(wi_state,
+					lockdep_is_held(&wi_state_lock));
+	if (old_wi_state) {
+		memcpy(new_wi_state->iw_table, old_wi_state->iw_table,
+					nr_node_ids * sizeof(u8));
+	} else {
+		for (i = 0; i < nr_node_ids; i++)
+			new_wi_state->iw_table[i] = 1;
+	}
+	new_wi_state->iw_table[node_attr->nid] = weight;
+	new_wi_state->mode_auto = false;
+
+	rcu_assign_pointer(wi_state, new_wi_state);
+	mutex_unlock(&wi_state_lock);
+	if (old_wi_state) {
+		synchronize_rcu();
+		kfree(old_wi_state);
+	}
+	return count;
+}
+
+static ssize_t weighted_interleave_auto_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct weighted_interleave_state *state;
+	bool wi_auto = true;
+
+	rcu_read_lock();
+	state = rcu_dereference(wi_state);
+	if (state)
+		wi_auto = state->mode_auto;
+	rcu_read_unlock();
+
+	return sysfs_emit(buf, "%s\n", str_true_false(wi_auto));
+}
+
+static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
+	unsigned int *bw;
+	bool input;
+	int i;
+
+	if (kstrtobool(buf, &input))
+		return -EINVAL;
+
+	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
+			       GFP_KERNEL);
+	if (!new_wi_state)
+		return -ENOMEM;
+	for (i = 0; i < nr_node_ids; i++)
+		new_wi_state->iw_table[i] = 1;
+
+	mutex_lock(&wi_state_lock);
+	if (!input) {
+		old_wi_state = rcu_dereference_protected(wi_state,
+					lockdep_is_held(&wi_state_lock));
+		if (old_wi_state)
+			memcpy(new_wi_state->iw_table, old_wi_state->iw_table,
+					nr_node_ids * sizeof(u8));
+		goto update_wi_state;
+	}
+
+	bw = node_bw_table;
+	if (!bw) {
+		mutex_unlock(&wi_state_lock);
+		kfree(new_wi_state);
+		return -ENODEV;
+	}
+
+	new_wi_state->mode_auto = true;
+	reduce_interleave_weights(bw, new_wi_state->iw_table);
+
+update_wi_state:
+	rcu_assign_pointer(wi_state, new_wi_state);
+	mutex_unlock(&wi_state_lock);
+	if (old_wi_state) {
+		synchronize_rcu();
+		kfree(old_wi_state);
+	}
 	return count;
 }
 
@@ -3508,23 +3686,31 @@ static void sysfs_wi_node_delete_all(void)
 		sysfs_wi_node_delete(nid);
 }
 
-static void iw_table_free(void)
+static void wi_state_free(void)
 {
-	u8 *old;
+	struct weighted_interleave_state *old_wi_state;
 
-	mutex_lock(&iw_table_lock);
-	old = rcu_dereference_protected(iw_table,
-					lockdep_is_held(&iw_table_lock));
-	rcu_assign_pointer(iw_table, NULL);
-	mutex_unlock(&iw_table_lock);
+	mutex_lock(&wi_state_lock);
+
+	old_wi_state = rcu_dereference_protected(wi_state,
+			lockdep_is_held(&wi_state_lock));
+	if (!old_wi_state) {
+		mutex_unlock(&wi_state_lock);
+		goto out;
+	}
 
+	rcu_assign_pointer(wi_state, NULL);
+	mutex_unlock(&wi_state_lock);
 	synchronize_rcu();
-	kfree(old);
+	kfree(old_wi_state);
+out:
+	kfree(&wi_group->wi_kobj);
 }
 
 static void wi_cleanup(void) {
+	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
 	sysfs_wi_node_delete_all();
-	iw_table_free();
+	wi_state_free();
 }
 
 static void wi_kobj_release(struct kobject *wi_kobj)
@@ -3612,6 +3798,10 @@ static int wi_node_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static struct kobj_attribute wi_auto_attr =
+	__ATTR(auto, 0664, weighted_interleave_auto_show,
+			   weighted_interleave_auto_store);
+
 static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 {
 	int nid, err;
@@ -3627,6 +3817,11 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 	if (err)
 		goto err_put_kobj;
 
+	err = sysfs_create_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
+	if (err)
+		goto err_put_kobj;
+	wi_group->auto_kobj_attr = wi_auto_attr;
+
 	for_each_online_node(nid) {
 		if (!node_state(nid, N_MEMORY))
 			continue;
-- 
2.47.1


