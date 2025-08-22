Return-Path: <linux-acpi+bounces-15911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE9B31EBF
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DBFAA2A9C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA8D238C3A;
	Fri, 22 Aug 2025 15:31:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99683214A91;
	Fri, 22 Aug 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876679; cv=none; b=o9MRDfEDgSzH3tmHugepRxDrt8may88a5eEG86xNBwT5i7DEVHo2O9Xvwcpf1VzQ6z9YLBehxxbdyF4ATBmpStzFcIfxJlNG7SBNCoO60DJKjw0UbbSUR3kBMhjIv6KAlnZtn2sv401M7EdXHrPAmJHPiKAQmutz7Do+Qip25t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876679; c=relaxed/simple;
	bh=JNA8Ju3yLzQ5/rM7Bi6nt9PNOG5Nj2I/hDTMXTvlsIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUhQ5tlcyhVEKDsYTNKytYdAKokOym0T5WjjxLKMoCfEh4HXpnWj6CMXZltmsfCDc5na8/u/sMrY7aKZ0jQidOMuGLHw74lc1YFUB0YEUMIRZ+NVyisPNvdXMxv+3U55X/MApHMtJrh9gZyHplFpnNgEW+RcGv/96ebvA+4TRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D773F15A1;
	Fri, 22 Aug 2025 08:31:08 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAA2C3F63F;
	Fri, 22 Aug 2025 08:31:11 -0700 (PDT)
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
Subject: [PATCH 02/33] drivers: base: cacheinfo: Add helper to find the cache size from cpu+level
Date: Fri, 22 Aug 2025 15:29:43 +0000
Message-Id: <20250822153048.2287-3-james.morse@arm.com>
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

MPAM needs to know the size of a cache associated with a particular CPU.
The DT/ACPI agnostic way of doing this is to ask cacheinfo.

Add a helper to do this.

Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v1:
 * Converted to kdoc.
 * Simplified helper to use get_cpu_cacheinfo_level().
---
 include/linux/cacheinfo.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 2dcbb69139e9..e12d6f2c6a57 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -148,6 +148,21 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 	return ci ? ci->id : -1;
 }
 
+/**
+ * get_cpu_cacheinfo_size() - Get the size of the cache.
+ * @cpu:      The cpu that is associated with the cache.
+ * @level:    The level of the cache as seen by @cpu.
+ *
+ * Callers must hold the cpuhp lock.
+ * Returns the cache-size on success, or 0 for an error.
+ */
+static inline unsigned int get_cpu_cacheinfo_size(int cpu, int level)
+{
+	struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, level);
+
+	return ci ? ci->size : 0;
+}
+
 #if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
 #define use_arch_cache_info()	(true)
 #else
-- 
2.20.1


