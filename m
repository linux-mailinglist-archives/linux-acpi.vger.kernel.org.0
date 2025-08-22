Return-Path: <linux-acpi+bounces-15920-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC2BB31EE5
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA76640950
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DBE23F412;
	Fri, 22 Aug 2025 15:32:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454123F26B;
	Fri, 22 Aug 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876730; cv=none; b=X3sbimbeohwweUTbU0UbW19D7DgFlG6dPNVufIm5xQqxmQj5SpMzen8K49LHvD0ca93VcgrW9NUMYduKBt9HrNDlzNfm6RBKPzcV4fnIflKQUUgu7F+RloBTMRBvILjmjQaGrvz6Bels2f/QX/kggJ9C6pWANzQ6K6uyskn64iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876730; c=relaxed/simple;
	bh=s3Xj+lbMOvTmdXj7q5KRK49H5FJws7pRFoVYzoSjSUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nesp6Mn2tyE8t0u5bzRDKVzwNpQB9mpXQVqGwt4LxWrL/4xUB5R+He1gz49Gkb0H4jBlp28LWNQWOljJFIJqUAFLgtQHas6c0jvJXoKXsV0cfBWBRDQBYsIi3Y9TUIUxrNHe0Lyelt1YwuvQV9WMVUE3Ov+YTr+T9pdJ17rWtEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39C3E27B5;
	Fri, 22 Aug 2025 08:32:00 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BD903F63F;
	Fri, 22 Aug 2025 08:32:03 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 11/33] arm_mpam: Add support for memory controller MSC on DT platforms
Date: Fri, 22 Aug 2025 15:29:52 +0000
Message-Id: <20250822153048.2287-12-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250822153048.2287-1-james.morse@arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shanker Donthineni <sdonthineni@nvidia.com>

The device-tree binding has two examples for MSC associated with
memory controllers. Add the support to discover the component_id
from the device-tree and create 'memory' RIS.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
[ morse: split out of a bigger patch, added affinity piece ]
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_devices.c | 67 ++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index a0d9a699a6e7..71a1fb1a9c75 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -62,41 +62,63 @@ static int mpam_dt_parse_resource(struct mpam_msc *msc, struct device_node *np,
 				  u32 ris_idx)
 {
 	int err = 0;
-	u32 level = 0;
-	unsigned long cache_id;
-	struct device_node *cache;
+	u32 class_id = 0, component_id = 0;
+	struct device_node *cache = NULL, *memory = NULL;
+	enum mpam_class_types type = MPAM_CLASS_UNKNOWN;
 
 	do {
+		/* What kind of MSC is this? */
 		if (of_device_is_compatible(np, "arm,mpam-cache")) {
 			cache = of_parse_phandle(np, "arm,mpam-device", 0);
 			if (!cache) {
 				pr_err("Failed to read phandle\n");
 				break;
 			}
+			type = MPAM_CLASS_CACHE;
 		} else if (of_device_is_compatible(np->parent, "cache")) {
 			cache = of_node_get(np->parent);
+			type = MPAM_CLASS_CACHE;
+		} else if (of_device_is_compatible(np, "arm,mpam-memory")) {
+			memory = of_parse_phandle(np, "arm,mpam-device", 0);
+			if (!memory) {
+				pr_err("Failed to read phandle\n");
+				break;
+			}
+			type = MPAM_CLASS_MEMORY;
+		} else if (of_device_is_compatible(np, "arm,mpam-memory-controller-msc")) {
+			memory = of_node_get(np->parent);
+			type = MPAM_CLASS_MEMORY;
 		} else {
-			/* For now, only caches are supported */
-			cache = NULL;
+			/*
+			 * For now, only caches and memory controllers are
+			 * supported.
+			 */
 			break;
 		}
 
-		err = of_property_read_u32(cache, "cache-level", &level);
-		if (err) {
-			pr_err("Failed to read cache-level\n");
-			break;
-		}
-
-		cache_id = cache_of_calculate_id(cache);
-		if (cache_id == ~0UL) {
-			err = -ENOENT;
-			break;
+		/* Determine the class and component ids, based on type. */
+		if (type == MPAM_CLASS_CACHE) {
+			err = of_property_read_u32(cache, "cache-level", &class_id);
+			if (err) {
+				pr_err("Failed to read cache-level\n");
+				break;
+			}
+			component_id = cache_of_calculate_id(cache);
+			if (component_id == ~0UL) {
+				err = -ENOENT;
+				break;
+			}
+		} else if (type == MPAM_CLASS_MEMORY) {
+			err = of_node_to_nid(np);
+			component_id = (err == NUMA_NO_NODE) ? 0 : err;
+			class_id = 255;
 		}
 
-		err = mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE, level,
-				      cache_id);
+		err = mpam_ris_create(msc, ris_idx, type, class_id,
+				      component_id);
 	} while (0);
 	of_node_put(cache);
+	of_node_put(memory);
 
 	return err;
 }
@@ -157,9 +179,14 @@ static int update_msc_accessibility(struct mpam_msc *msc)
 		cpumask_copy(&msc->accessibility, cpu_possible_mask);
 		err = 0;
 	} else {
-		err = -EINVAL;
-		pr_err("Cannot determine accessibility of MSC: %s\n",
-		       dev_name(&msc->pdev->dev));
+		if (of_device_is_compatible(parent, "memory")) {
+			cpumask_copy(&msc->accessibility, cpu_possible_mask);
+			err = 0;
+		} else {
+			err = -EINVAL;
+			pr_err("Cannot determine accessibility of MSC: %s\n",
+			       dev_name(&msc->pdev->dev));
+		}
 	}
 	of_node_put(parent);
 
-- 
2.20.1


