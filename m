Return-Path: <linux-acpi+bounces-18947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4513C656E1
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF84B3497A2
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD930148B;
	Mon, 17 Nov 2025 17:01:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C82FB601;
	Mon, 17 Nov 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398917; cv=none; b=fgZu0hUPWzbYQVJVCLKkssw325PK0UCotRSolRIWLYR3LAKf8i/N3xSnrtqJg1TnsZjZ3rK5prNnGUW/pL0LQVQ6Gg8PysNF7lWIGKwd0U4ALyIlblhILa79ayY6djWd+3J03jRRHGncJiDNSHSEG1VbX2fs689j7zoz5u5/NsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398917; c=relaxed/simple;
	bh=NsNR+x5Nh1FkQjGEz07uPA7DjauvQQPSX/jPeOEEZzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dhakfjiv47YaCw8NN6oXIaUa/rKrbgYzy+a1ticxz8Wpe+gAnySz21bkZRpthB4DjQx6IDnowSMQ84QmNfdyM4UjwEuT3jk+45Fs9c1oLjByjI9EwI05+aR0SJWs/vEuaxCY/CifSPiIlJ5CJ04RJBdc7mu9to2AdJ44NBE+7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD244FEC;
	Mon, 17 Nov 2025 09:01:47 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2215A3F66E;
	Mon, 17 Nov 2025 09:01:50 -0800 (PST)
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
	Dave Martin <Dave.Martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v5 16/34] arm_mpam: Probe the hardware features resctrl supports
Date: Mon, 17 Nov 2025 16:59:55 +0000
Message-ID: <20251117170014.4113754-17-ben.horgan@arm.com>
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

Expand the probing support with the control and monitor types
we can use with resctrl.

CC: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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
Changes since v3:
Drop the =0 in the enum (Jonathan)
---
 drivers/resctrl/mpam_devices.c  | 149 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h |  33 +++++++
 2 files changed, 182 insertions(+)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index b0374dea1727..574093c8e95a 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -170,6 +170,22 @@ static inline void _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 va
 
 #define mpam_write_partsel_reg(msc, reg, val)  _mpam_write_partsel_reg(msc, MPAMCFG_##reg, val)
 
+static inline u32 _mpam_read_monsel_reg(struct mpam_msc *msc, u16 reg)
+{
+	mpam_mon_sel_lock_held(msc);
+	return __mpam_read_reg(msc, reg);
+}
+
+#define mpam_read_monsel_reg(msc, reg) _mpam_read_monsel_reg(msc, MSMON_##reg)
+
+static inline void _mpam_write_monsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
+{
+	mpam_mon_sel_lock_held(msc);
+	__mpam_write_reg(msc, reg, val);
+}
+
+#define mpam_write_monsel_reg(msc, reg, val)   _mpam_write_monsel_reg(msc, MSMON_##reg, val)
+
 static u64 mpam_msc_read_idr(struct mpam_msc *msc)
 {
 	u64 idr_high = 0, idr_low;
@@ -548,6 +564,133 @@ static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
 	return ERR_PTR(-ENOENT);
 }
 
+/*
+ * IHI009A.a has this nugget: "If a monitor does not support automatic behaviour
+ * of NRDY, software can use this bit for any purpose" - so hardware might not
+ * implement this - but it isn't RES0.
+ *
+ * Try and see what values stick in this bit. If we can write either value,
+ * its probably not implemented by hardware.
+ */
+static bool _mpam_ris_hw_probe_hw_nrdy(struct mpam_msc_ris *ris, u32 mon_reg)
+{
+	u32 now;
+	u64 mon_sel;
+	bool can_set, can_clear;
+	struct mpam_msc *msc = ris->vmsc->msc;
+
+	if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
+		return false;
+
+	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, 0) |
+		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
+	_mpam_write_monsel_reg(msc, mon_reg, mon_sel);
+
+	_mpam_write_monsel_reg(msc, mon_reg, MSMON___NRDY);
+	now = _mpam_read_monsel_reg(msc, mon_reg);
+	can_set = now & MSMON___NRDY;
+
+	_mpam_write_monsel_reg(msc, mon_reg, 0);
+	now = _mpam_read_monsel_reg(msc, mon_reg);
+	can_clear = !(now & MSMON___NRDY);
+	mpam_mon_sel_unlock(msc);
+
+	return (!can_set || !can_clear);
+}
+
+#define mpam_ris_hw_probe_hw_nrdy(_ris, _mon_reg)			\
+	_mpam_ris_hw_probe_hw_nrdy(_ris, MSMON_##_mon_reg)
+
+static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
+{
+	int err;
+	struct mpam_msc *msc = ris->vmsc->msc;
+	struct device *dev = &msc->pdev->dev;
+	struct mpam_props *props = &ris->props;
+
+	lockdep_assert_held(&msc->probe_lock);
+	lockdep_assert_held(&msc->part_sel_lock);
+
+	/* Cache Portion partitioning */
+	if (FIELD_GET(MPAMF_IDR_HAS_CPOR_PART, ris->idr)) {
+		u32 cpor_features = mpam_read_partsel_reg(msc, CPOR_IDR);
+
+		props->cpbm_wd = FIELD_GET(MPAMF_CPOR_IDR_CPBM_WD, cpor_features);
+		if (props->cpbm_wd)
+			mpam_set_feature(mpam_feat_cpor_part, props);
+	}
+
+	/* Memory bandwidth partitioning */
+	if (FIELD_GET(MPAMF_IDR_HAS_MBW_PART, ris->idr)) {
+		u32 mbw_features = mpam_read_partsel_reg(msc, MBW_IDR);
+
+		/* portion bitmap resolution */
+		props->mbw_pbm_bits = FIELD_GET(MPAMF_MBW_IDR_BWPBM_WD, mbw_features);
+		if (props->mbw_pbm_bits &&
+		    FIELD_GET(MPAMF_MBW_IDR_HAS_PBM, mbw_features))
+			mpam_set_feature(mpam_feat_mbw_part, props);
+
+		props->bwa_wd = FIELD_GET(MPAMF_MBW_IDR_BWA_WD, mbw_features);
+		if (props->bwa_wd && FIELD_GET(MPAMF_MBW_IDR_HAS_MAX, mbw_features))
+			mpam_set_feature(mpam_feat_mbw_max, props);
+	}
+
+	/* Performance Monitoring */
+	if (FIELD_GET(MPAMF_IDR_HAS_MSMON, ris->idr)) {
+		u32 msmon_features = mpam_read_partsel_reg(msc, MSMON_IDR);
+
+		/*
+		 * If the firmware max-nrdy-us property is missing, the
+		 * CSU counters can't be used. Should we wait forever?
+		 */
+		err = device_property_read_u32(&msc->pdev->dev,
+					       "arm,not-ready-us",
+					       &msc->nrdy_usec);
+
+		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_CSU, msmon_features)) {
+			u32 csumonidr;
+
+			csumonidr = mpam_read_partsel_reg(msc, CSUMON_IDR);
+			props->num_csu_mon = FIELD_GET(MPAMF_CSUMON_IDR_NUM_MON, csumonidr);
+			if (props->num_csu_mon) {
+				bool hw_managed;
+
+				mpam_set_feature(mpam_feat_msmon_csu, props);
+
+				/* Is NRDY hardware managed? */
+				hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, CSU);
+				if (hw_managed)
+					mpam_set_feature(mpam_feat_msmon_csu_hw_nrdy, props);
+			}
+
+			/*
+			 * Accept the missing firmware property if NRDY appears
+			 * un-implemented.
+			 */
+			if (err && mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy, props))
+				dev_err_once(dev, "Counters are not usable because not-ready timeout was not provided by firmware.");
+		}
+		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_MBWU, msmon_features)) {
+			bool hw_managed;
+			u32 mbwumon_idr = mpam_read_partsel_reg(msc, MBWUMON_IDR);
+
+			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumon_idr);
+			if (props->num_mbwu_mon)
+				mpam_set_feature(mpam_feat_msmon_mbwu, props);
+
+			/* Is NRDY hardware managed? */
+			hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
+			if (hw_managed)
+				mpam_set_feature(mpam_feat_msmon_mbwu_hw_nrdy, props);
+
+			/*
+			 * Don't warn about any missing firmware property for
+			 * MBWU NRDY - it doesn't make any sense!
+			 */
+		}
+	}
+}
+
 static int mpam_msc_hw_probe(struct mpam_msc *msc)
 {
 	u64 idr;
@@ -591,6 +734,12 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 		mutex_unlock(&mpam_list_lock);
 		if (IS_ERR(ris))
 			return PTR_ERR(ris);
+		ris->idr = idr;
+
+		mutex_lock(&msc->part_sel_lock);
+		__mpam_part_sel(ris_idx, 0, msc);
+		mpam_ris_hw_probe(ris);
+		mutex_unlock(&msc->part_sel_lock);
 	}
 
 	spin_lock(&partid_max_lock);
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index b62ee55e1ed5..09c27000234d 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -5,12 +5,14 @@
 #define MPAM_INTERNAL_H
 
 #include <linux/arm_mpam.h>
+#include <linux/bitmap.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
 #include <linux/llist.h>
 #include <linux/mutex.h>
 #include <linux/srcu.h>
 #include <linux/spinlock.h>
+#include <linux/srcu.h>
 #include <linux/types.h>
 
 #define MPAM_MSC_MAX_NUM_RIS	16
@@ -110,6 +112,33 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
 	raw_spin_lock_init(&msc->_mon_sel_lock);
 }
 
+/* Bits for mpam features bitmaps */
+enum mpam_device_features {
+	mpam_feat_cpor_part,
+	mpam_feat_mbw_part,
+	mpam_feat_mbw_min,
+	mpam_feat_mbw_max,
+	mpam_feat_msmon,
+	mpam_feat_msmon_csu,
+	mpam_feat_msmon_csu_hw_nrdy,
+	mpam_feat_msmon_mbwu,
+	mpam_feat_msmon_mbwu_hw_nrdy,
+	MPAM_FEATURE_LAST
+};
+
+struct mpam_props {
+	DECLARE_BITMAP(features, MPAM_FEATURE_LAST);
+
+	u16			cpbm_wd;
+	u16			mbw_pbm_bits;
+	u16			bwa_wd;
+	u16			num_csu_mon;
+	u16			num_mbwu_mon;
+};
+
+#define mpam_has_feature(_feat, x)	test_bit(_feat, (x)->features)
+#define mpam_set_feature(_feat, x)	set_bit(_feat, (x)->features)
+
 struct mpam_class {
 	/* mpam_components in this class */
 	struct list_head	components;
@@ -149,6 +178,8 @@ struct mpam_vmsc {
 	/* mpam_msc_ris in this vmsc */
 	struct list_head	ris;
 
+	struct mpam_props	props;
+
 	/* All RIS in this vMSC are members of this MSC */
 	struct mpam_msc		*msc;
 
@@ -160,6 +191,8 @@ struct mpam_vmsc {
 
 struct mpam_msc_ris {
 	u8			ris_idx;
+	u64			idr;
+	struct mpam_props	props;
 
 	cpumask_t		affinity;
 
-- 
2.43.0


