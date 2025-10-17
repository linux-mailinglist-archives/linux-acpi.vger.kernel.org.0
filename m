Return-Path: <linux-acpi+bounces-17918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D3BEB511
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 21:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD0D6E7155
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F3533B947;
	Fri, 17 Oct 2025 18:59:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32588337BB3;
	Fri, 17 Oct 2025 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727543; cv=none; b=DzKGR/JKBat2I6K3PZ4nAQVrviKuxRKXE6iZ0XUEmRRxwwlvUNsuX7EYKwxsHhgllFiIDxuQZiw+K5LFAqN6gPRM4YwO3rhTOYTjN+s853S+Br8G8gOGB563d0679KM1eusVTSjX9yNqxRL6ZZ/yrVuQwNuvUzABbVMxgZB3o8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727543; c=relaxed/simple;
	bh=gG3r5a0gia/BSkGiHIXSAzfyXYv5lcR8VH12WspFZLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cm/XwpZjT9Qi+iXZM8qKtkhg9IGRjJFK5e2mXFi2kgaeYOFyCCoD8Gy26mA5v+OXFXyGwUs6YSXB8i+yH5M8gtXJAV07klFzKh1pHKlD+lyQ2WXY8hViAs3RF4kamQFiCXCjpd2Z3sx38YztHKo9LlImfRtckhb8eGMIbjTTvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A26601595;
	Fri, 17 Oct 2025 11:58:50 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B0813F66E;
	Fri, 17 Oct 2025 11:58:53 -0700 (PDT)
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
	Danilo Krummrich <dakr@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Rohit Mathew <Rohit.Mathew@arm.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v3 21/29] arm_mpam: Probe and reset the rest of the features
Date: Fri, 17 Oct 2025 18:56:37 +0000
Message-Id: <20251017185645.26604-22-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251017185645.26604-1-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v2:
 * Moved some enum definitions in here.
 * Whitespace.

Changes since v1:
 * Added reset for cassoc.
 * Added detection of CSU XCL.
---
 drivers/resctrl/mpam_devices.c  | 188 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h |  22 +++-
 2 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index e990ef67df5b..19cc87aba51a 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -229,6 +229,15 @@ static void __mpam_part_sel(u8 ris_idx, u16 partid, struct mpam_msc *msc)
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
@@ -650,10 +659,34 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
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
@@ -676,6 +709,31 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
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
@@ -700,6 +758,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 
 				mpam_set_feature(mpam_feat_msmon_csu, props);
 
+				if (FIELD_GET(MPAMF_CSUMON_IDR_HAS_XCL, csumonidr))
+					mpam_set_feature(mpam_feat_msmon_csu_xcl, props);
+
 				/* Is NRDY hardware managed? */
 				hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, CSU);
 				if (hw_managed)
@@ -721,6 +782,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 			if (props->num_mbwu_mon)
 				mpam_set_feature(mpam_feat_msmon_mbwu, props);
 
+			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumon_idr))
+				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
+
 			/* Is NRDY hardware managed? */
 			hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
 			if (hw_managed)
@@ -732,6 +796,21 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
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
@@ -831,12 +910,28 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
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
@@ -863,6 +958,35 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	    mpam_has_feature(mpam_feat_mbw_max, cfg))
 		mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
 
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
 
@@ -1297,6 +1421,18 @@ static bool mpam_has_bwa_wd_feature(struct mpam_props *props)
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
 
@@ -1355,6 +1491,23 @@ static void __props_mismatch(struct mpam_props *parent,
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
@@ -1374,6 +1527,41 @@ static void __props_mismatch(struct mpam_props *parent,
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
index 2f2a7369107b..00edee9ebc6c 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -139,16 +139,30 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
 
 /* Bits for mpam features bitmaps */
 enum mpam_device_features {
-	mpam_feat_cpor_part = 0,
+	mpam_feat_cmax_softlim,
+	mpam_feat_cmax_cmax,
+	mpam_feat_cmax_cmin,
+	mpam_feat_cmax_cassoc,
+	mpam_feat_cpor_part,
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
-	MPAM_FEATURE_LAST
+	mpam_feat_partid_nrw,
+	MPAM_FEATURE_LAST,
 };
 
 struct mpam_props {
@@ -157,6 +171,10 @@ struct mpam_props {
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
2.39.5


