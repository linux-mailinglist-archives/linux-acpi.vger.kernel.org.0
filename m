Return-Path: <linux-acpi+bounces-15936-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D594FB31F2B
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6526648223
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782F025A35A;
	Fri, 22 Aug 2025 15:33:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49361D9663;
	Fri, 22 Aug 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876821; cv=none; b=YOADF3pfTxXgNg7DV2BmBwPuNuWo9DkPIpkCJ9MSLc4w8Hlq5BAJCLwHIyBfb9BdsgSYMYnQBR8Ebv/DHIy293lQ8bcsN85xMnsK0IweyVIB1AFYqqye5mdADTEv73x1B05gEMIrTgfrgf9yU3tBGFSNMB45iGO6OeaBXUnqpuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876821; c=relaxed/simple;
	bh=oXrYh29R4LWpJvmEOZSsBz66JvUIuR0f8iHNaITVlwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vdl1lyc+AQsJM75slsi8XpscY0RabQO77WITrVEzx3Hey2whHrFOfzeoaGsCDVDDrN6cVbeiw4ab+Ikf/Ose0ZV52MfxlzbRbZ/elnmfYRtAAbqT73qfBN8kIJSlKZsuXwXKg6VLfda22p6p0tFwW/Dri6m4Zz1npynunIxOsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C71BE27B5;
	Fri, 22 Aug 2025 08:33:30 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8DC93F63F;
	Fri, 22 Aug 2025 08:33:33 -0700 (PDT)
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
Subject: [PATCH 27/33] arm_mpam: Add mpam_msmon_read() to read monitor value
Date: Fri, 22 Aug 2025 15:30:08 +0000
Message-Id: <20250822153048.2287-28-james.morse@arm.com>
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

Reading a monitor involves configuring what you want to monitor, and
reading the value. Components made up of multiple MSC may need values
from each MSC. MSCs may take time to configure, returning 'not ready'.
The maximum 'not ready' time should have been provided by firmware.

Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
not ready, then wait the full timeout value before trying again.

CC: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 222 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h |  18 +++
 2 files changed, 240 insertions(+)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index e7e00c632512..9ce771aaf671 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -973,6 +973,228 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 	return 0;
 }
 
+struct mon_read {
+	struct mpam_msc_ris		*ris;
+	struct mon_cfg			*ctx;
+	enum mpam_device_features	type;
+	u64				*val;
+	int				err;
+};
+
+static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
+				   u32 *flt_val)
+{
+	struct mon_cfg *ctx = m->ctx;
+
+	switch (m->type) {
+	case mpam_feat_msmon_csu:
+		*ctl_val = MSMON_CFG_CSU_CTL_TYPE_CSU;
+		break;
+	case mpam_feat_msmon_mbwu:
+		*ctl_val = MSMON_CFG_MBWU_CTL_TYPE_MBWU;
+		break;
+	default:
+		return;
+	}
+
+	/*
+	 * For CSU counters its implementation-defined what happens when not
+	 * filtering by partid.
+	 */
+	*ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
+
+	*flt_val = FIELD_PREP(MSMON_CFG_MBWU_FLT_PARTID, ctx->partid);
+	if (m->ctx->match_pmg) {
+		*ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
+		*flt_val |= FIELD_PREP(MSMON_CFG_MBWU_FLT_PMG, ctx->pmg);
+	}
+
+	if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ris->props))
+		*flt_val |= FIELD_PREP(MSMON_CFG_MBWU_FLT_RWBW, ctx->opts);
+}
+
+static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
+				    u32 *flt_val)
+{
+	struct mpam_msc *msc = m->ris->vmsc->msc;
+
+	switch (m->type) {
+	case mpam_feat_msmon_csu:
+		*ctl_val = mpam_read_monsel_reg(msc, CFG_CSU_CTL);
+		*flt_val = mpam_read_monsel_reg(msc, CFG_CSU_FLT);
+		break;
+	case mpam_feat_msmon_mbwu:
+		*ctl_val = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
+		*flt_val = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
+		break;
+	default:
+		return;
+	}
+}
+
+/* Remove values set by the hardware to prevent apparant mismatches. */
+static void clean_msmon_ctl_val(u32 *cur_ctl)
+{
+	*cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
+}
+
+static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
+				     u32 flt_val)
+{
+	struct mpam_msc *msc = m->ris->vmsc->msc;
+
+	/*
+	 * Write the ctl_val with the enable bit cleared, reset the counter,
+	 * then enable counter.
+	 */
+	switch (m->type) {
+	case mpam_feat_msmon_csu:
+		mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
+		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
+		mpam_write_monsel_reg(msc, CSU, 0);
+		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
+		break;
+	case mpam_feat_msmon_mbwu:
+		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
+		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
+		mpam_write_monsel_reg(msc, MBWU, 0);
+		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
+		break;
+	default:
+		return;
+	}
+}
+
+/* Call with MSC lock held */
+static void __ris_msmon_read(void *arg)
+{
+	u64 now;
+	bool nrdy = false;
+	struct mon_read *m = arg;
+	struct mon_cfg *ctx = m->ctx;
+	struct mpam_msc_ris *ris = m->ris;
+	struct mpam_props *rprops = &ris->props;
+	struct mpam_msc *msc = m->ris->vmsc->msc;
+	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
+
+	if (!mpam_mon_sel_inner_lock(msc)) {
+		m->err = -EIO;
+		return;
+	}
+	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, ctx->mon) |
+		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
+	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
+
+	/*
+	 * Read the existing configuration to avoid re-writing the same values.
+	 * This saves waiting for 'nrdy' on subsequent reads.
+	 */
+	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
+	clean_msmon_ctl_val(&cur_ctl);
+	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
+	if (cur_flt != flt_val || cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN))
+		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
+
+	switch (m->type) {
+	case mpam_feat_msmon_csu:
+		now = mpam_read_monsel_reg(msc, CSU);
+		if (mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy, rprops))
+			nrdy = now & MSMON___NRDY;
+		break;
+	case mpam_feat_msmon_mbwu:
+		now = mpam_read_monsel_reg(msc, MBWU);
+		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
+			nrdy = now & MSMON___NRDY;
+		break;
+	default:
+		m->err = -EINVAL;
+		break;
+	}
+	mpam_mon_sel_inner_unlock(msc);
+
+	if (nrdy) {
+		m->err = -EBUSY;
+		return;
+	}
+
+	now = FIELD_GET(MSMON___VALUE, now);
+	*m->val += now;
+}
+
+static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
+{
+	int err, idx;
+	struct mpam_msc *msc;
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc_ris *ris;
+
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
+		msc = vmsc->msc;
+
+		mpam_mon_sel_outer_lock(msc);
+		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
+			arg->ris = ris;
+
+			err = smp_call_function_any(&msc->accessibility,
+						    __ris_msmon_read, arg,
+						    true);
+			if (!err && arg->err)
+				err = arg->err;
+			if (err)
+				break;
+		}
+		mpam_mon_sel_outer_unlock(msc);
+		if (err)
+			break;
+	}
+	srcu_read_unlock(&mpam_srcu, idx);
+
+	return err;
+}
+
+int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
+		    enum mpam_device_features type, u64 *val)
+{
+	int err;
+	struct mon_read arg;
+	u64 wait_jiffies = 0;
+	struct mpam_props *cprops = &comp->class->props;
+
+	might_sleep();
+
+	if (!mpam_is_enabled())
+		return -EIO;
+
+	if (!mpam_has_feature(type, cprops))
+		return -EOPNOTSUPP;
+
+	memset(&arg, 0, sizeof(arg));
+	arg.ctx = ctx;
+	arg.type = type;
+	arg.val = val;
+	*val = 0;
+
+	err = _msmon_read(comp, &arg);
+	if (err == -EBUSY && comp->class->nrdy_usec)
+		wait_jiffies = usecs_to_jiffies(comp->class->nrdy_usec);
+
+	while (wait_jiffies)
+		wait_jiffies = schedule_timeout_uninterruptible(wait_jiffies);
+
+	if (err == -EBUSY) {
+		memset(&arg, 0, sizeof(arg));
+		arg.ctx = ctx;
+		arg.type = type;
+		arg.val = val;
+		*val = 0;
+
+		err = _msmon_read(comp, &arg);
+	}
+
+	return err;
+}
+
 static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 {
 	u32 num_words, msb;
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 4981de120869..76e406a2b0d1 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -309,6 +309,21 @@ struct mpam_msc_ris {
 	struct mpam_garbage	garbage;
 };
 
+/* The values for MSMON_CFG_MBWU_FLT.RWBW */
+enum mon_filter_options {
+	COUNT_BOTH	= 0,
+	COUNT_WRITE	= 1,
+	COUNT_READ	= 2,
+};
+
+struct mon_cfg {
+	u16                     mon;
+	u8                      pmg;
+	bool                    match_pmg;
+	u32                     partid;
+	enum mon_filter_options opts;
+};
+
 static inline int mpam_alloc_csu_mon(struct mpam_class *class)
 {
 	struct mpam_props *cprops = &class->props;
@@ -361,6 +376,9 @@ void mpam_disable(struct work_struct *work);
 int mpam_apply_config(struct mpam_component *comp, u16 partid,
 		      struct mpam_config *cfg);
 
+int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
+		    enum mpam_device_features, u64 *val);
+
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
 
-- 
2.20.1


