Return-Path: <linux-acpi+bounces-15966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD50EB31F6C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D90A1D07DE8
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A9E34DCDD;
	Fri, 22 Aug 2025 15:36:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7810B238C3A;
	Fri, 22 Aug 2025 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876989; cv=none; b=i12Vn9+Z357F0hCRKq+0cKfsFRiusZjvTNTEFZBF79+K8fRKk+oXxJ2tXeUwksth1tNtx9SV0n5elhISzuNbWdFo9gA+oyPz4VN1L4giuDcM2N+abbJtVAZye38cXPLXIYVCMr8vXHSg3i2AH+f+pcATETKzgNp/6NC5FWiNFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876989; c=relaxed/simple;
	bh=TihBLORAFE4lrQMsSm4i/TF11ZiZA36p7IhI3+Wg0d4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6Y7Mg1GlgEbSDBAoBOBkJFJQmu6ZUPXuB9NbRo6v7pfT0GUXkHYFlG6tIx6SIJE6miV4Hdg7VZVrrexmiNJcTG0+qko1I7ifvFEFKTBEWxDqpQxqOVMzVbPQ2OY6Y+je4fp9Y9wit/YtEBPMDXhlws8CukVArSikk4TIWZA/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCFA415A1;
	Fri, 22 Aug 2025 08:36:19 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEDE13F63F;
	Fri, 22 Aug 2025 08:36:22 -0700 (PDT)
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
Subject: [PATCH 23/33] arm_mpam: Use a static key to indicate when mpam is enabled
Date: Fri, 22 Aug 2025 15:30:38 +0000
Message-Id: <20250822153048.2287-58-james.morse@arm.com>
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

Once all the MSC have been probed, the system wide usable number of
PARTID is known and the configuration arrays can be allocated.

After this point, checking all the MSC have been probed is pointless,
and the cpuhp callbacks should restore the configuration, instead of
just resetting the MSC.

Add a static key to enable this behaviour. This will also allow MPAM
to be disabled in repsonse to an error, and the architecture code to
enable/disable the context switch of the MPAM system registers.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 8 ++++++++
 drivers/resctrl/mpam_internal.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 210d64fad0b1..b424af666b1e 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -33,6 +33,8 @@
 
 #include "mpam_internal.h"
 
+DEFINE_STATIC_KEY_FALSE(mpam_enabled); /* TODO: move to arch code */
+
 /*
  * mpam_list_lock protects the SRCU lists when writing. Once the
  * mpam_enabled key is enabled these lists are read-only,
@@ -1039,6 +1041,9 @@ static int mpam_discovery_cpu_online(unsigned int cpu)
 	struct mpam_msc *msc;
 	bool new_device_probed = false;
 
+	if (mpam_is_enabled())
+		return 0;
+
 	mutex_lock(&mpam_list_lock);
 	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
 		if (!cpumask_test_cpu(cpu, &msc->accessibility))
@@ -1835,6 +1840,7 @@ static void mpam_enable_once(void)
 		return;
 	}
 
+	static_branch_enable(&mpam_enabled);
 	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
 
 	printk(KERN_INFO "MPAM enabled with %u partid and %u pmg\n",
@@ -1902,6 +1908,8 @@ static irqreturn_t mpam_disable_thread(int irq, void *dev_id)
 	}
 	mutex_unlock(&mpam_cpuhp_state_lock);
 
+	static_branch_disable(&mpam_enabled);
+
 	mpam_unregister_irqs();
 
 	idx = srcu_read_lock(&mpam_srcu);
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index c9418c9cf9f2..3476ee97f8ac 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -8,6 +8,7 @@
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
+#include <linux/jump_label.h>
 #include <linux/llist.h>
 #include <linux/mailbox_client.h>
 #include <linux/mutex.h>
@@ -15,6 +16,13 @@
 #include <linux/sizes.h>
 #include <linux/srcu.h>
 
+DECLARE_STATIC_KEY_FALSE(mpam_enabled);
+
+static inline bool mpam_is_enabled(void)
+{
+	return static_branch_likely(&mpam_enabled);
+}
+
 /*
  * Structures protected by SRCU may not be freed for a surprising amount of
  * time (especially if perf is running). To ensure the MPAM error interrupt can
-- 
2.20.1


