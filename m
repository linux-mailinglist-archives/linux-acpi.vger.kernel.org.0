Return-Path: <linux-acpi+bounces-19099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D4C6E804
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 13:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 178274F4455
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F4361DA9;
	Wed, 19 Nov 2025 12:25:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA0D35971B;
	Wed, 19 Nov 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555148; cv=none; b=dBI4EjZdGW7AKEHZDhf8+s8xgpeQgGyN705bT17FMqIISdZ+gYqoezfgojw1kQ63zysdirSKco6dlKDvq3ObErq0uxP4+XWyLnMbNQaxz2OL20Io7VFQMKB3/M+Vq333NChjHt4OTdMqpjkjnHZtCIIQApSnQ8JHcQqKaQnPrLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555148; c=relaxed/simple;
	bh=v3bc6zZ67dZwSzzHJS+iPWde4mvICO8XPppwy3Snrxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7k3HtLkAKUt6Up5zTW/bDN4Konsw8SgBOj2sKghDf8KHxZ9NmA22z0fUolS7Bmm/A7xvmFPlU7daUj32JhM5uvSKdKR+VFHfBEN0teqHj8YymIdyvU69gmAfvouse0DBGwVVh2MTe5Rz73NwMvQODeT/GOwoms4rOpPNueBNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AC8814BF;
	Wed, 19 Nov 2025 04:25:38 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 024C43F740;
	Wed, 19 Nov 2025 04:25:40 -0800 (PST)
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
	reinette.chatre@intel.com,
	Ben Horgan <ben.horgan@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>
Subject: [PATCH v6 25/34] arm_mpam: Add helpers to allocate monitors
Date: Wed, 19 Nov 2025 12:22:55 +0000
Message-ID: <20251119122305.302149-26-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119122305.302149-1-ben.horgan@arm.com>
References: <20251119122305.302149-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

MPAM's MSC support a number of monitors, each of which supports
bandwidth counters, or cache-storage-utilisation counters. To use
a counter, a monitor needs to be configured. Add helpers to allocate
and free CSU or MBWU monitors.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 drivers/resctrl/mpam_devices.c  |  2 ++
 drivers/resctrl/mpam_internal.h | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 67eb0c79ca49..a7ba07ac5a2f 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -305,6 +305,8 @@ mpam_class_alloc(u8 level_idx, enum mpam_class_types type)
 	class->level = level_idx;
 	class->type = type;
 	INIT_LIST_HEAD_RCU(&class->classes_list);
+	ida_init(&class->ida_csu_mon);
+	ida_init(&class->ida_mbwu_mon);
 
 	list_add_rcu(&class->classes_list, &mpam_classes);
 
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 618e5355a95e..8bbc67df6d97 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -200,6 +200,9 @@ struct mpam_class {
 	/* member of mpam_classes */
 	struct list_head	classes_list;
 
+	struct ida		ida_csu_mon;
+	struct ida		ida_mbwu_mon;
+
 	struct mpam_garbage	garbage;
 };
 
@@ -279,6 +282,38 @@ struct mpam_msc_ris {
 	struct mpam_garbage	garbage;
 };
 
+static inline int mpam_alloc_csu_mon(struct mpam_class *class)
+{
+	struct mpam_props *cprops = &class->props;
+
+	if (!mpam_has_feature(mpam_feat_msmon_csu, cprops))
+		return -EOPNOTSUPP;
+
+	return ida_alloc_max(&class->ida_csu_mon, cprops->num_csu_mon - 1,
+			     GFP_KERNEL);
+}
+
+static inline void mpam_free_csu_mon(struct mpam_class *class, int csu_mon)
+{
+	ida_free(&class->ida_csu_mon, csu_mon);
+}
+
+static inline int mpam_alloc_mbwu_mon(struct mpam_class *class)
+{
+	struct mpam_props *cprops = &class->props;
+
+	if (!mpam_has_feature(mpam_feat_msmon_mbwu, cprops))
+		return -EOPNOTSUPP;
+
+	return ida_alloc_max(&class->ida_mbwu_mon, cprops->num_mbwu_mon - 1,
+			     GFP_KERNEL);
+}
+
+static inline void mpam_free_mbwu_mon(struct mpam_class *class, int mbwu_mon)
+{
+	ida_free(&class->ida_mbwu_mon, mbwu_mon);
+}
+
 /* List of all classes - protected by srcu*/
 extern struct srcu_struct mpam_srcu;
 extern struct list_head mpam_classes;
-- 
2.43.0


