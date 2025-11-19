Return-Path: <linux-acpi+bounces-19098-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3458AC6E7F8
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 13:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBEC04F74B9
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41FA3612C8;
	Wed, 19 Nov 2025 12:25:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F74359712;
	Wed, 19 Nov 2025 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555143; cv=none; b=loQ90va6oAGKblRqIST/Q0yiu36Ax7Z8Z9OQuDBmxJ5Ovrks6PHJtCTeYqfjH+eQgY9f7DpfSNxLVMkld2rFG6lzIGtM3sMfkgHtDJ1OZIO9VE53b/rbv5/UjqqZwxWMgHT9AcFhCwUrGP2dc5k4nH0AOB3L+qA8kGf2nQ9O3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555143; c=relaxed/simple;
	bh=c/GJx2raEUQnNSVXPX/OkPQtMqgdSTDzAWkR0eOCeiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJEKzlWQ7hRe0UirS5oytQ7tUV9b/llsXf42g7NstN/gXtVGLYz+4Ux+d57/lURueejHatbPpPRPWI+vBvjFzfNfrtsHNJ9GG46ewjN/Il5bXrkurfmY1/gXMy7YqusJ/eJB/OrtbcnExCxdQRL6PZUbtzWki50X0jD4+KDkVZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25B73175D;
	Wed, 19 Nov 2025 04:25:33 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 44F6C3F740;
	Wed, 19 Nov 2025 04:25:35 -0800 (PST)
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
	Rohit Mathew <Rohit.Mathew@arm.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v6 24/34] arm_mpam: Probe and reset the rest of the features
Date: Wed, 19 Nov 2025 12:22:54 +0000
Message-ID: <20251119122305.302149-25-ben.horgan@arm.com>
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

MPAM supports more features than are going to be exposed to resctrl.
For partid other than 0, the reset values of these controls isn't
known.

Discover the rest of the features so they can be reset to avoid any
side effects when resctrl is in use.

PARTID narrowing allows MSC/RIS to support less configuration space than
is usable. If this feature is found on a class of device we are likely
to use, then reduce the partid_max to make it usable. This allows us
to map a PARTID to itself.

CC: Rohit Mathew <Rohit.Mathew@arm.com>
CC: Zeng Heng <zengheng4@huawei.com>
CC: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
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
Changes since v3:
enum order and commas
---
 drivers/resctrl/mpam_devices.c  | 188 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h |  18 +++
 2 files changed, 206 insertions(+)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 6dbd378acdcf..67eb0c79ca49 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -259,6 +259,15 @@ static void __mpam_part_sel(u8 ris_idx, u16 partid, struct mpam_msc *msc)
 	__mpam_part_sel_raw(partsel, msc);
 }
 
+static void __mpam_intpart_sel(u8 ris_idx, u16 intpartid, struct mpam_msc *msc)
+{
+	u32 partsel = FIELD_PREP(MPAMCFG_PART_SEL_RIS, ris_idx) |
+		      FIELD_PREP(MPAMCFG_PART_SEL_PARTID_SEL, intpartid) |
+		      MPAMCFG_PART_SEL_INTERNAL;
+
+	__mpam_part_sel_raw(partsel, msc);
+}
+
 int mpam_register_requestor(u16 partid_max, u8 pmg_max)
 {
 	guard(spinlock)(&partid_max_lock);
@@ -656,10 +665,34 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 	struct mpam_msc *msc = ris->vmsc->msc;
 	struct device *dev = &msc->pdev->dev;
 	struct mpam_props *props = &ris->props;
+	struct mpam_class *class = ris->vmsc->comp->class;
 
 	lockdep_assert_held(&msc->probe_lock);
 	lockdep_assert_held(&msc->part_sel_lock);
 
+	/* Cache Capacity Partitioning */
+	if (FIELD_GET(MPAMF_IDR_HAS_CCAP_PART, ris->idr)) {
+		u32 ccap_features = mpam_read_partsel_reg(msc, CCAP_IDR);
+
+		props->cmax_wd = FIELD_GET(MPAMF_CCAP_IDR_CMAX_WD, ccap_features);
+		if (props->cmax_wd &&
+		    FIELD_GET(MPAMF_CCAP_IDR_HAS_CMAX_SOFTLIM, ccap_features))
+			mpam_set_feature(mpam_feat_cmax_softlim, props);
+
+		if (props->cmax_wd &&
+		    !FIELD_GET(MPAMF_CCAP_IDR_NO_CMAX, ccap_features))
+			mpam_set_feature(mpam_feat_cmax_cmax, props);
+
+		if (props->cmax_wd &&
+		    FIELD_GET(MPAMF_CCAP_IDR_HAS_CMIN, ccap_features))
+			mpam_set_feature(mpam_feat_cmax_cmin, props);
+
+		props->cassoc_wd = FIELD_GET(MPAMF_CCAP_IDR_CASSOC_WD, ccap_features);
+		if (props->cassoc_wd &&
+		    FIELD_GET(MPAMF_CCAP_IDR_HAS_CASSOC, ccap_features))
+			mpam_set_feature(mpam_feat_cmax_cassoc, props);
+	}
+
 	/* Cache Portion partitioning */
 	if (FIELD_GET(MPAMF_IDR_HAS_CPOR_PART, ris->idr)) {
 		u32 cpor_features = mpam_read_partsel_reg(msc, CPOR_IDR);
@@ -682,6 +715,31 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 		props->bwa_wd = FIELD_GET(MPAMF_MBW_IDR_BWA_WD, mbw_features);
 		if (props->bwa_wd && FIELD_GET(MPAMF_MBW_IDR_HAS_MAX, mbw_features))
 			mpam_set_feature(mpam_feat_mbw_max, props);
+
+		if (props->bwa_wd && FIELD_GET(MPAMF_MBW_IDR_HAS_MIN, mbw_features))
+			mpam_set_feature(mpam_feat_mbw_min, props);
+
+		if (props->bwa_wd && FIELD_GET(MPAMF_MBW_IDR_HAS_PROP, mbw_features))
+			mpam_set_feature(mpam_feat_mbw_prop, props);
+	}
+
+	/* Priority partitioning */
+	if (FIELD_GET(MPAMF_IDR_HAS_PRI_PART, ris->idr)) {
+		u32 pri_features = mpam_read_partsel_reg(msc, PRI_IDR);
+
+		props->intpri_wd = FIELD_GET(MPAMF_PRI_IDR_INTPRI_WD, pri_features);
+		if (props->intpri_wd && FIELD_GET(MPAMF_PRI_IDR_HAS_INTPRI, pri_features)) {
+			mpam_set_feature(mpam_feat_intpri_part, props);
+			if (FIELD_GET(MPAMF_PRI_IDR_INTPRI_0_IS_LOW, pri_features))
+				mpam_set_feature(mpam_feat_intpri_part_0_low, props);
+		}
+
+		props->dspri_wd = FIELD_GET(MPAMF_PRI_IDR_DSPRI_WD, pri_features);
+		if (props->dspri_wd && FIELD_GET(MPAMF_PRI_IDR_HAS_DSPRI, pri_features)) {
+			mpam_set_feature(mpam_feat_dspri_part, props);
+			if (FIELD_GET(MPAMF_PRI_IDR_DSPRI_0_IS_LOW, pri_features))
+				mpam_set_feature(mpam_feat_dspri_part_0_low, props);
+		}
 	}
 
 	/* Performance Monitoring */
@@ -706,6 +764,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 
 				mpam_set_feature(mpam_feat_msmon_csu, props);
 
+				if (FIELD_GET(MPAMF_CSUMON_IDR_HAS_XCL, csumonidr))
+					mpam_set_feature(mpam_feat_msmon_csu_xcl, props);
+
 				/* Is NRDY hardware managed? */
 				hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, CSU);
 				if (hw_managed)
@@ -727,6 +788,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 			if (props->num_mbwu_mon)
 				mpam_set_feature(mpam_feat_msmon_mbwu, props);
 
+			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumon_idr))
+				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
+
 			/* Is NRDY hardware managed? */
 			hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
 			if (hw_managed)
@@ -738,6 +802,21 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 			 */
 		}
 	}
+
+	/*
+	 * RIS with PARTID narrowing don't have enough storage for one
+	 * configuration per PARTID. If these are in a class we could use,
+	 * reduce the supported partid_max to match the number of intpartid.
+	 * If the class is unknown, just ignore it.
+	 */
+	if (FIELD_GET(MPAMF_IDR_HAS_PARTID_NRW, ris->idr) &&
+	    class->type != MPAM_CLASS_UNKNOWN) {
+		u32 nrwidr = mpam_read_partsel_reg(msc, PARTID_NRW_IDR);
+		u16 partid_max = FIELD_GET(MPAMF_PARTID_NRW_IDR_INTPARTID_MAX, nrwidr);
+
+		mpam_set_feature(mpam_feat_partid_nrw, props);
+		msc->partid_max = min(msc->partid_max, partid_max);
+	}
 }
 
 static int mpam_msc_hw_probe(struct mpam_msc *msc)
@@ -837,12 +916,28 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 				      struct mpam_config *cfg)
 {
+	u32 pri_val = 0;
+	u16 cmax = MPAMCFG_CMAX_CMAX;
 	struct mpam_msc *msc = ris->vmsc->msc;
 	struct mpam_props *rprops = &ris->props;
+	u16 dspri = GENMASK(rprops->dspri_wd, 0);
+	u16 intpri = GENMASK(rprops->intpri_wd, 0);
 
 	mutex_lock(&msc->part_sel_lock);
 	__mpam_part_sel(ris->ris_idx, partid, msc);
 
+	if (mpam_has_feature(mpam_feat_partid_nrw, rprops)) {
+		/* Update the intpartid mapping */
+		mpam_write_partsel_reg(msc, INTPARTID,
+				       MPAMCFG_INTPARTID_INTERNAL | partid);
+
+		/*
+		 * Then switch to the 'internal' partid to update the
+		 * configuration.
+		 */
+		__mpam_intpart_sel(ris->ris_idx, partid, msc);
+	}
+
 	if (mpam_has_feature(mpam_feat_cpor_part, rprops) &&
 	    mpam_has_feature(mpam_feat_cpor_part, cfg)) {
 		if (cfg->reset_cpbm)
@@ -871,6 +966,35 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 			mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
 	}
 
+	if (mpam_has_feature(mpam_feat_mbw_prop, rprops) &&
+	    mpam_has_feature(mpam_feat_mbw_prop, cfg))
+		mpam_write_partsel_reg(msc, MBW_PROP, 0);
+
+	if (mpam_has_feature(mpam_feat_cmax_cmax, rprops))
+		mpam_write_partsel_reg(msc, CMAX, cmax);
+
+	if (mpam_has_feature(mpam_feat_cmax_cmin, rprops))
+		mpam_write_partsel_reg(msc, CMIN, 0);
+
+	if (mpam_has_feature(mpam_feat_cmax_cassoc, rprops))
+		mpam_write_partsel_reg(msc, CASSOC, MPAMCFG_CASSOC_CASSOC);
+
+	if (mpam_has_feature(mpam_feat_intpri_part, rprops) ||
+	    mpam_has_feature(mpam_feat_dspri_part, rprops)) {
+		/* aces high? */
+		if (!mpam_has_feature(mpam_feat_intpri_part_0_low, rprops))
+			intpri = 0;
+		if (!mpam_has_feature(mpam_feat_dspri_part_0_low, rprops))
+			dspri = 0;
+
+		if (mpam_has_feature(mpam_feat_intpri_part, rprops))
+			pri_val |= FIELD_PREP(MPAMCFG_PRI_INTPRI, intpri);
+		if (mpam_has_feature(mpam_feat_dspri_part, rprops))
+			pri_val |= FIELD_PREP(MPAMCFG_PRI_DSPRI, dspri);
+
+		mpam_write_partsel_reg(msc, PRI, pri_val);
+	}
+
 	mutex_unlock(&msc->part_sel_lock);
 }
 
@@ -1308,6 +1432,18 @@ static bool mpam_has_bwa_wd_feature(struct mpam_props *props)
 		return true;
 	if (mpam_has_feature(mpam_feat_mbw_max, props))
 		return true;
+	if (mpam_has_feature(mpam_feat_mbw_prop, props))
+		return true;
+	return false;
+}
+
+/* Any of these features mean the CMAX_WD field is valid. */
+static bool mpam_has_cmax_wd_feature(struct mpam_props *props)
+{
+	if (mpam_has_feature(mpam_feat_cmax_cmax, props))
+		return true;
+	if (mpam_has_feature(mpam_feat_cmax_cmin, props))
+		return true;
 	return false;
 }
 
@@ -1366,6 +1502,23 @@ static void __props_mismatch(struct mpam_props *parent,
 		parent->bwa_wd = min(parent->bwa_wd, child->bwa_wd);
 	}
 
+	if (alias && !mpam_has_cmax_wd_feature(parent) && mpam_has_cmax_wd_feature(child)) {
+		parent->cmax_wd = child->cmax_wd;
+	} else if (MISMATCHED_HELPER(parent, child, mpam_has_cmax_wd_feature,
+				     cmax_wd, alias)) {
+		pr_debug("%s took the min cmax_wd\n", __func__);
+		parent->cmax_wd = min(parent->cmax_wd, child->cmax_wd);
+	}
+
+	if (CAN_MERGE_FEAT(parent, child, mpam_feat_cmax_cassoc, alias)) {
+		parent->cassoc_wd = child->cassoc_wd;
+	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_cmax_cassoc,
+				   cassoc_wd, alias)) {
+		pr_debug("%s cleared cassoc_wd\n", __func__);
+		mpam_clear_feature(mpam_feat_cmax_cassoc, parent);
+		parent->cassoc_wd = 0;
+	}
+
 	/* For num properties, take the minimum */
 	if (CAN_MERGE_FEAT(parent, child, mpam_feat_msmon_csu, alias)) {
 		parent->num_csu_mon = child->num_csu_mon;
@@ -1385,6 +1538,41 @@ static void __props_mismatch(struct mpam_props *parent,
 					   child->num_mbwu_mon);
 	}
 
+	if (CAN_MERGE_FEAT(parent, child, mpam_feat_intpri_part, alias)) {
+		parent->intpri_wd = child->intpri_wd;
+	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_intpri_part,
+				   intpri_wd, alias)) {
+		pr_debug("%s took the min intpri_wd\n", __func__);
+		parent->intpri_wd = min(parent->intpri_wd, child->intpri_wd);
+	}
+
+	if (CAN_MERGE_FEAT(parent, child, mpam_feat_dspri_part, alias)) {
+		parent->dspri_wd = child->dspri_wd;
+	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_dspri_part,
+				   dspri_wd, alias)) {
+		pr_debug("%s took the min dspri_wd\n", __func__);
+		parent->dspri_wd = min(parent->dspri_wd, child->dspri_wd);
+	}
+
+	/* TODO: alias support for these two */
+	/* {int,ds}pri may not have differing 0-low behaviour */
+	if (mpam_has_feature(mpam_feat_intpri_part, parent) &&
+	    (!mpam_has_feature(mpam_feat_intpri_part, child) ||
+	     mpam_has_feature(mpam_feat_intpri_part_0_low, parent) !=
+	     mpam_has_feature(mpam_feat_intpri_part_0_low, child))) {
+		pr_debug("%s cleared intpri_part\n", __func__);
+		mpam_clear_feature(mpam_feat_intpri_part, parent);
+		mpam_clear_feature(mpam_feat_intpri_part_0_low, parent);
+	}
+	if (mpam_has_feature(mpam_feat_dspri_part, parent) &&
+	    (!mpam_has_feature(mpam_feat_dspri_part, child) ||
+	     mpam_has_feature(mpam_feat_dspri_part_0_low, parent) !=
+	     mpam_has_feature(mpam_feat_dspri_part_0_low, child))) {
+		pr_debug("%s cleared dspri_part\n", __func__);
+		mpam_clear_feature(mpam_feat_dspri_part, parent);
+		mpam_clear_feature(mpam_feat_dspri_part_0_low, parent);
+	}
+
 	if (alias) {
 		/* Merge features for aliased resources */
 		bitmap_or(parent->features, parent->features, child->features, MPAM_FEATURE_LAST);
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index b8fdbd7ab7a5..618e5355a95e 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -143,14 +143,28 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
 /* Bits for mpam features bitmaps */
 enum mpam_device_features {
 	mpam_feat_cpor_part,
+	mpam_feat_cmax_softlim,
+	mpam_feat_cmax_cmax,
+	mpam_feat_cmax_cmin,
+	mpam_feat_cmax_cassoc,
 	mpam_feat_mbw_part,
 	mpam_feat_mbw_min,
 	mpam_feat_mbw_max,
+	mpam_feat_mbw_prop,
+	mpam_feat_intpri_part,
+	mpam_feat_intpri_part_0_low,
+	mpam_feat_dspri_part,
+	mpam_feat_dspri_part_0_low,
 	mpam_feat_msmon,
 	mpam_feat_msmon_csu,
+	mpam_feat_msmon_csu_capture,
+	mpam_feat_msmon_csu_xcl,
 	mpam_feat_msmon_csu_hw_nrdy,
 	mpam_feat_msmon_mbwu,
+	mpam_feat_msmon_mbwu_capture,
+	mpam_feat_msmon_mbwu_rwbw,
 	mpam_feat_msmon_mbwu_hw_nrdy,
+	mpam_feat_partid_nrw,
 	MPAM_FEATURE_LAST
 };
 
@@ -160,6 +174,10 @@ struct mpam_props {
 	u16			cpbm_wd;
 	u16			mbw_pbm_bits;
 	u16			bwa_wd;
+	u16			cmax_wd;
+	u16			cassoc_wd;
+	u16			intpri_wd;
+	u16			dspri_wd;
 	u16			num_csu_mon;
 	u16			num_mbwu_mon;
 };
-- 
2.43.0


