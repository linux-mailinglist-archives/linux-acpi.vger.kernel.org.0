Return-Path: <linux-acpi+bounces-15910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9B9B31EC4
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38152A281E6
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACF5230268;
	Fri, 22 Aug 2025 15:31:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3261225A5B;
	Fri, 22 Aug 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876673; cv=none; b=goEUFPjq227wDToVh18g5yn6pIwruM0O85vsMiBf2rHrSmipSYdoYfB6cMuM6YkPALi2KQK/2E0b22d+wP0Ij9hf5+fdjQUoABtFz6gMultUV535FS930G/Yw1pXuUjNrRUjXaUGh9KVIIAwkfYzyiU9rlI3wYLrI43CED0rrfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876673; c=relaxed/simple;
	bh=9QqXXJStw71ZU66vliOsj/UdHd+j+97HYjUzko96Bhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HsTWau6uvV86CwvdThdw2i7Ta6XD7M3YFCNvevNGpozf0AzBm8dY7xBkNY+J4hBsu35isiyAWUlW1Xmy4GpL2sjSJMJQVMxgRB0F1Av4rAaa0Rm6AIHbDxo8nM4UI0W3kZZPWtFl43D6ynqN0gjinUWFixAkL0CmqUOgGLeOxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A680827DC;
	Fri, 22 Aug 2025 08:31:02 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970AB3F63F;
	Fri, 22 Aug 2025 08:31:05 -0700 (PDT)
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
Subject: [PATCH 01/33] cacheinfo: Expose the code to generate a cache-id from a device_node
Date: Fri, 22 Aug 2025 15:29:42 +0000
Message-Id: <20250822153048.2287-2-james.morse@arm.com>
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

The MPAM driver identifies caches by id for use with resctrl. It
needs to know the cache-id when probe-ing, but the value isn't set
in cacheinfo until device_initcall().

Expose the code that generates the cache-id. The parts of the MPAM
driver that run early can use this to set up the resctrl structures
before cacheinfo is ready in device_initcall().

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Renamed cache_of_get_id() cache_of_calculate_id().
---
 drivers/base/cacheinfo.c  | 19 +++++++++++++------
 include/linux/cacheinfo.h |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 613410705a47..f6289d142ba9 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -207,11 +207,10 @@ static bool match_cache_node(struct device_node *cpu,
 #define arch_compact_of_hwid(_x)	(_x)
 #endif
 
-static void cache_of_set_id(struct cacheinfo *this_leaf,
-			    struct device_node *cache_node)
+unsigned long cache_of_calculate_id(struct device_node *cache_node)
 {
 	struct device_node *cpu;
-	u32 min_id = ~0;
+	unsigned long min_id = ~0UL;
 
 	for_each_of_cpu_node(cpu) {
 		u64 id = of_get_cpu_hwid(cpu, 0);
@@ -219,15 +218,23 @@ static void cache_of_set_id(struct cacheinfo *this_leaf,
 		id = arch_compact_of_hwid(id);
 		if (FIELD_GET(GENMASK_ULL(63, 32), id)) {
 			of_node_put(cpu);
-			return;
+			return ~0UL;
 		}
 
 		if (match_cache_node(cpu, cache_node))
 			min_id = min(min_id, id);
 	}
 
-	if (min_id != ~0) {
-		this_leaf->id = min_id;
+	return min_id;
+}
+
+static void cache_of_set_id(struct cacheinfo *this_leaf,
+			    struct device_node *cache_node)
+{
+	unsigned long id = cache_of_calculate_id(cache_node);
+
+	if (id != ~0UL) {
+		this_leaf->id = id;
 		this_leaf->attributes |= CACHE_ID;
 	}
 }
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index c8f4f0a0b874..2dcbb69139e9 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -112,6 +112,7 @@ int acpi_get_cache_info(unsigned int cpu,
 #endif
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
+unsigned long cache_of_calculate_id(struct device_node *np);
 
 /*
  * Get the cacheinfo structure for the cache associated with @cpu at
-- 
2.20.1


