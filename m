Return-Path: <linux-acpi+bounces-18953-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0871C65568
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D0A3929B39
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01197303A34;
	Mon, 17 Nov 2025 17:02:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308532F60B3;
	Mon, 17 Nov 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398950; cv=none; b=pUsVwdE3cmt12tri4c3vMu6F2by5/i7OxiuM1KQIlub+h7cfrf4uSGWl3BVEAXBtId1TnVxKVsLCZS8zbSZzrfsnD0K5QSlDX7C/r5WOfoBs7KT1CVIemQZTp+QEb1l8prLxA8AOmtXW/tmDVUw05POTUJOXARlaJb2vkzPhOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398950; c=relaxed/simple;
	bh=AIXgpa+LPLJRcCHBmzHFv/9w2qAwyQZdNlaUoSj86cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYvCLoYY2jVa4mzkPq7mS7PPldOToU/1PB+Z4HK6KGL/U578iCrIH8hkuTJjph8ojZYFD27oIoflgzrvU5ySwV7ksGTLTVm1krOZzwQN0yRB7+J68wjqzFSks5XmdDNKQOEyCvl5CBfnxF67Z1LnuT73xXJyy/ZtjRp3G2PFUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1400EFEC;
	Mon, 17 Nov 2025 09:02:21 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 599143F66E;
	Mon, 17 Nov 2025 09:02:23 -0800 (PST)
From: Ben Horgan <ben.horgan@arm.com>
To: james.morse@arm.com
Cc: amitsinght@marvell.com,
	baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com,
	bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com,
	catalin.marinas@arm.com,
	dakr@kernel.org,
	dave.martin@arm.com,
	david@redhat.com,
	dfustini@baylibre.com,
	fenghuay@nvidia.com,
	gregkh@linuxfoundation.org,
	gshan@redhat.com,
	guohanjun@huawei.com,
	jeremy.linton@arm.com,
	jonathan.cameron@huawei.com,
	kobak@nvidia.com,
	lcherian@marvell.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	peternewman@google.com,
	quic_jiles@quicinc.com,
	rafael@kernel.org,
	robh@kernel.org,
	rohit.mathew@arm.com,
	scott@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com,
	will@kernel.org,
	xhao@linux.alibaba.com,
	Ben Horgan <ben.horgan@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>
Subject: [PATCH v5 22/34] arm_mpam: Use a static key to indicate when mpam is enabled
Date: Mon, 17 Nov 2025 17:00:01 +0000
Message-ID: <20251117170014.4113754-23-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117170014.4113754-1-ben.horgan@arm.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

Once all the MSC have been probed, the system wide usable number of
PARTID is known and the configuration arrays can be allocated.

After this point, checking all the MSC have been probed is pointless,
and the cpuhp callbacks should restore the configuration, instead of
just resetting the MSC.

Add a static key to enable this behaviour. This will also allow MPAM
to be disabled in response to an error, and the architecture code to
enable/disable the context switch of the MPAM system registers.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 12 ++++++++++++
 drivers/resctrl/mpam_internal.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index adcde470067c..359c7ddc20bc 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -29,6 +29,8 @@
 
 #include "mpam_internal.h"
 
+DEFINE_STATIC_KEY_FALSE(mpam_enabled); /* This moves to arch code */
+
 /*
  * mpam_list_lock protects the SRCU lists when writing. Once the
  * mpam_enabled key is enabled these lists are read-only,
@@ -936,6 +938,9 @@ static int mpam_discovery_cpu_online(unsigned int cpu)
 	struct mpam_msc *msc;
 	bool new_device_probed = false;
 
+	if (mpam_is_enabled())
+		return 0;
+
 	guard(srcu)(&mpam_srcu);
 	list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
 				 srcu_read_lock_held(&mpam_srcu)) {
@@ -1471,6 +1476,10 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 	/* Disable this interrupt. */
 	mpam_disable_msc_ecr(msc);
 
+	/* Are we racing with the thread disabling MPAM? */
+	if (!mpam_is_enabled())
+		return IRQ_HANDLED;
+
 	/*
 	 * Schedule the teardown work. Don't use a threaded IRQ as we can't
 	 * unregister the interrupt from the threaded part of the handler.
@@ -1605,6 +1614,7 @@ static void mpam_enable_once(void)
 		return;
 	}
 
+	static_branch_enable(&mpam_enabled);
 	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline,
 				      "mpam:online");
 
@@ -1671,6 +1681,8 @@ void mpam_disable(struct work_struct *ignored)
 	}
 	mutex_unlock(&mpam_cpuhp_state_lock);
 
+	static_branch_disable(&mpam_enabled);
+
 	mpam_unregister_irqs();
 
 	idx = srcu_read_lock(&mpam_srcu);
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 3002c8e6cabc..c6937161877a 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
+#include <linux/jump_label.h>
 #include <linux/llist.h>
 #include <linux/mutex.h>
 #include <linux/srcu.h>
@@ -20,6 +21,13 @@
 
 struct platform_device;
 
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
2.43.0


