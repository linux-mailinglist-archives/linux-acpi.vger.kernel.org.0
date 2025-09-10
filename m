Return-Path: <linux-acpi+bounces-16625-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CF7B522A9
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DACA584132
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53100303A3C;
	Wed, 10 Sep 2025 20:43:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE130216E;
	Wed, 10 Sep 2025 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537036; cv=none; b=YHYoo0NUyWNCtPRyQevR+TMjBgaE7SgxNzqITDF3bROupBsrkzIp2B8TRp8oWeej1iOf5kRFgWYCt5UNahZtZUx0BsmmDZzKNGIghtTd+5ggGEpisCS7Ri3pFP9ixRinHAOdNe643Lvjfg4FMGX1XwwJChPV2St0ewUA0cyklik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537036; c=relaxed/simple;
	bh=r/wErF3yjFa7BVljNh0RpUp11qxWDP8PxpBepFYisIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dS2aC2sR82X0lIETnvP42WHO4yALhGoUzKjjEWtAFH+O1Nl6DGS4MiiNzxjGvbLSYf2tPKC/eBNvqmI2Wf3+cr91/X+U+OvMcdyS/DqHYvHPSHjejoraSCtfJbohivpd7ZIGtVyptV0PPmWSxHnO6JGgNsDJ0tYSJoKGR95OW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB3B41D34;
	Wed, 10 Sep 2025 13:43:45 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1F083F63F;
	Wed, 10 Sep 2025 13:43:49 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 05/29] arm64: kconfig: Add Kconfig entry for MPAM
Date: Wed, 10 Sep 2025 20:42:45 +0000
Message-Id: <20250910204309.20751-6-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250910204309.20751-1-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bulk of the MPAM driver lives outside the arch code because it
largely manages MMIO devices that generate interrupts. The driver
needs a Kconfig symbol to enable it. As MPAM is only found on arm64
platforms, the arm64 tree is the most natural home for the Kconfig
option.

This Kconfig option will later be used by the arch code to enable
or disable the MPAM context-switch code, and to register properties
of CPUs with the MPAM driver.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Dave Martin <dave.martin@arm.com>
---
Changes since v1:
 * Help text rewritten by Dave.
---
 arch/arm64/Kconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a6..4be8a13505bf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2060,6 +2060,29 @@ config ARM64_TLB_RANGE
 	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
 	  range of input addresses.
 
+config ARM64_MPAM
+	bool "Enable support for MPAM"
+	help
+	  Memory System Resource Partitioning and Monitoring (MPAM) is an
+	  optional extension to the Arm architecture that allows each
+	  transaction issued to the memory system to be labelled with a
+	  Partition identifier (PARTID) and Performance Monitoring Group
+	  identifier (PMG).
+
+	  Memory system components, such as the caches, can be configured with
+	  policies to control how much of various physical resources (such as
+	  memory bandwidth or cache memory) the transactions labelled with each
+	  PARTID can consume.  Depending on the capabilities of the hardware,
+	  the PARTID and PMG can also be used as filtering criteria to measure
+	  the memory system resource consumption of different parts of a
+	  workload.
+
+	  Use of this extension requires CPU support, support in the
+	  Memory System Components (MSC), and a description from firmware
+	  of where the MSCs are in the address space.
+
+	  MPAM is exposed to user-space via the resctrl pseudo filesystem.
+
 endmenu # "ARMv8.4 architectural features"
 
 menu "ARMv8.5 architectural features"
-- 
2.39.5


