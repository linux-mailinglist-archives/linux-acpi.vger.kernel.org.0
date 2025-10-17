Return-Path: <linux-acpi+bounces-17923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891CBEB52C
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480907C077D
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A0337B9D;
	Fri, 17 Oct 2025 18:59:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E833C53C;
	Fri, 17 Oct 2025 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727567; cv=none; b=iMY9QuAKsPuv9N6SYdNCbq7OXiLKKSkWENEBIcRyR5JUJJ3w6cjXGkTjd3T8V+HKb8HjaFJP6rcVEBtw0CcusrwmshqI6lBq2PD7MfCwJkcXPcLyckeOgXgB0AIGAXUEF38E0W/9jhriGD/uIIiGr1Ow9eU5FNL5khF4vEifTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727567; c=relaxed/simple;
	bh=an7L7zevAegGfdWDz/9tb667WyGhWvHkQ92vFDswzwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhTToeGCMePgAJA0saK5DQ8CexzI9nOFt9fTbhDgce4JlpZTMeZzhDepfNWNZJ2Y00vADv+7x1Qc5/4xrOibLd83miMwNhuxysdMn25aZMCX6KPfRyvSBIdg19ruRU7MCKcxIAyTGig/CX7Uk30rJmcuVoZjoplwooMsSW5oNxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D3772720;
	Fri, 17 Oct 2025 11:59:17 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372213F66E;
	Fri, 17 Oct 2025 11:59:20 -0700 (PDT)
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
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v3 26/29] arm_mpam: Use long MBWU counters if supported
Date: Fri, 17 Oct 2025 18:56:42 +0000
Message-Id: <20251017185645.26604-27-james.morse@arm.com>
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

From: Rohit Mathew <rohit.mathew@arm.com>

Now that the larger counter sizes are probed, make use of them.

Callers of mpam_msmon_read() may not know (or care!) about the different
counter sizes. Allow them to specify mpam_feat_msmon_mbwu and have the
driver pick the counter to use.

Only 32bit accesses to the MSC are required to be supported by the
spec, but these registers are 64bits. The lower half may overflow
into the higher half between two 32bit reads. To avoid this, use
a helper that reads the top half multiple times to check for overflow.

Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
[morse: merged multiple patches from Rohit, added explicit counter selection ]
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v2:
 * Removed mpam_feat_msmon_mbwu as a top-level bit for explicit 31bit counter
   selection.
 * Allow callers of mpam_msmon_read() to specify mpam_feat_msmon_mbwu and have
   the driver pick a supported counter size.
 * Rephrased commit message.

Changes since v1:
 * Only clear OFLOW_STATUS_L on MBWU counters.

Changes since RFC:
 * Commit message wrangling.
 * Refer to 31 bit counters as opposed to 32 bit (registers).
---
 drivers/resctrl/mpam_devices.c | 134 ++++++++++++++++++++++++++++-----
 1 file changed, 116 insertions(+), 18 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index f4d07234ce10..c207a6d2832c 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -897,6 +897,48 @@ struct mon_read {
 	int				err;
 };
 
+static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
+{
+	return (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, &ris->props) ||
+		mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props));
+}
+
+static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
+{
+	int retry = 3;
+	u32 mbwu_l_low;
+	u64 mbwu_l_high1, mbwu_l_high2;
+
+	mpam_mon_sel_lock_held(msc);
+
+	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
+	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
+
+	mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
+	do {
+		mbwu_l_high1 = mbwu_l_high2;
+		mbwu_l_low = __mpam_read_reg(msc, MSMON_MBWU_L);
+		mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
+
+		retry--;
+	} while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);
+
+	if (mbwu_l_high1 == mbwu_l_high2)
+		return (mbwu_l_high1 << 32) | mbwu_l_low;
+	return MSMON___NRDY_L;
+}
+
+static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
+{
+	mpam_mon_sel_lock_held(msc);
+
+	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
+	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
+
+	__mpam_write_reg(msc, MSMON_MBWU_L, 0);
+	__mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
+}
+
 static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 				   u32 *flt_val)
 {
@@ -924,7 +966,9 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 					       ctx->csu_exclude_clean);
 
 		break;
-	case mpam_feat_msmon_mbwu:
+	case mpam_feat_msmon_mbwu_31counter:
+	case mpam_feat_msmon_mbwu_44counter:
+	case mpam_feat_msmon_mbwu_63counter:
 		*ctl_val |= MSMON_CFG_MBWU_CTL_TYPE_MBWU;
 
 		if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ris->props))
@@ -946,7 +990,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 		*ctl_val = mpam_read_monsel_reg(msc, CFG_CSU_CTL);
 		*flt_val = mpam_read_monsel_reg(msc, CFG_CSU_FLT);
 		return;
-	case mpam_feat_msmon_mbwu:
+	case mpam_feat_msmon_mbwu_31counter:
+	case mpam_feat_msmon_mbwu_44counter:
+	case mpam_feat_msmon_mbwu_63counter:
 		*ctl_val = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
 		*flt_val = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
 		return;
@@ -959,6 +1005,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 static void clean_msmon_ctl_val(u32 *cur_ctl)
 {
 	*cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
+
+	if (FIELD_GET(MSMON_CFG_x_CTL_TYPE, *cur_ctl) == MSMON_CFG_MBWU_CTL_TYPE_MBWU)
+		*cur_ctl &= ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;
 }
 
 static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
@@ -978,10 +1027,15 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 		mpam_write_monsel_reg(msc, CSU, 0);
 		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
 		break;
-	case mpam_feat_msmon_mbwu:
+	case mpam_feat_msmon_mbwu_44counter:
+	case mpam_feat_msmon_mbwu_63counter:
+		mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
+		fallthrough;
+	case mpam_feat_msmon_mbwu_31counter:
 		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
 		mpam_write_monsel_reg(msc, MBWU, 0);
+
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
 
 		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
@@ -993,10 +1047,19 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 	}
 }
 
-static u64 mpam_msmon_overflow_val(struct mpam_msc_ris *ris)
+static u64 mpam_msmon_overflow_val(enum mpam_device_features type)
 {
-	/* TODO: scaling, and long counters */
-	return GENMASK_ULL(30, 0);
+	/* TODO: implement scaling counters */
+	switch (type) {
+	case mpam_feat_msmon_mbwu_63counter:
+		return GENMASK_ULL(62, 0);
+	case mpam_feat_msmon_mbwu_44counter:
+		return GENMASK_ULL(43, 0);
+	case mpam_feat_msmon_mbwu_31counter:
+		return GENMASK_ULL(30, 0);
+	default:
+		return 0;
+	}
 }
 
 /* Call with MSC lock held */
@@ -1037,11 +1100,24 @@ static void __ris_msmon_read(void *arg)
 			nrdy = now & MSMON___NRDY;
 		now = FIELD_GET(MSMON___VALUE, now);
 		break;
-	case mpam_feat_msmon_mbwu:
-		now = mpam_read_monsel_reg(msc, MBWU);
-		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
-			nrdy = now & MSMON___NRDY;
-		now = FIELD_GET(MSMON___VALUE, now);
+	case mpam_feat_msmon_mbwu_31counter:
+	case mpam_feat_msmon_mbwu_44counter:
+	case mpam_feat_msmon_mbwu_63counter:
+		if (m->type != mpam_feat_msmon_mbwu_31counter) {
+			now = mpam_msc_read_mbwu_l(msc);
+			if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
+				nrdy = now & MSMON___NRDY_L;
+
+			if (m->type == mpam_feat_msmon_mbwu_63counter)
+				now = FIELD_GET(MSMON___LWD_VALUE, now);
+			else
+				now = FIELD_GET(MSMON___L_VALUE, now);
+		} else {
+			now = mpam_read_monsel_reg(msc, MBWU);
+			if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
+				nrdy = now & MSMON___NRDY;
+			now = FIELD_GET(MSMON___VALUE, now);
+		}
 
 		if (nrdy)
 			break;
@@ -1050,7 +1126,7 @@ static void __ris_msmon_read(void *arg)
 
 		/* Add any pre-overflow value to the mbwu_state->val */
 		if (mbwu_state->prev_val > now)
-			overflow_val = mpam_msmon_overflow_val(ris) - mbwu_state->prev_val;
+			overflow_val = mpam_msmon_overflow_val(m->type) - mbwu_state->prev_val;
 
 		mbwu_state->prev_val = now;
 		mbwu_state->correction += overflow_val;
@@ -1106,13 +1182,26 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
 	return any_err;
 }
 
+static enum mpam_device_features mpam_msmon_choose_counter(struct mpam_class *class)
+{
+	struct mpam_props *cprops = &class->props;
+
+	if (mpam_has_feature(mpam_feat_msmon_mbwu_44counter, cprops))
+		return mpam_feat_msmon_mbwu_44counter;
+	if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, cprops))
+		return mpam_feat_msmon_mbwu_63counter;
+
+	return mpam_feat_msmon_mbwu_31counter;
+}
+
 int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 		    enum mpam_device_features type, u64 *val)
 {
 	int err;
 	struct mon_read arg;
 	u64 wait_jiffies = 0;
-	struct mpam_props *cprops = &comp->class->props;
+	struct mpam_class *class = comp->class;
+	struct mpam_props *cprops = &class->props;
 
 	might_sleep();
 
@@ -1129,9 +1218,12 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 	};
 	*val = 0;
 
+	if (type == mpam_feat_msmon_mbwu)
+		type = mpam_msmon_choose_counter(class);
+
 	err = _msmon_read(comp, &arg);
-	if (err == -EBUSY && comp->class->nrdy_usec)
-		wait_jiffies = usecs_to_jiffies(comp->class->nrdy_usec);
+	if (err == -EBUSY && class->nrdy_usec)
+		wait_jiffies = usecs_to_jiffies(class->nrdy_usec);
 
 	while (wait_jiffies)
 		wait_jiffies = schedule_timeout_uninterruptible(wait_jiffies);
@@ -1293,12 +1385,13 @@ static int mpam_restore_mbwu_state(void *_ris)
 	int i;
 	struct mon_read mwbu_arg;
 	struct mpam_msc_ris *ris = _ris;
+	struct mpam_class *class = ris->vmsc->comp->class;
 
 	for (i = 0; i < ris->props.num_mbwu_mon; i++) {
 		if (ris->mbwu_state[i].enabled) {
 			mwbu_arg.ris = ris;
 			mwbu_arg.ctx = &ris->mbwu_state[i].cfg;
-			mwbu_arg.type = mpam_feat_msmon_mbwu;
+			mwbu_arg.type = mpam_msmon_choose_counter(class);
 
 			__ris_msmon_read(&mwbu_arg);
 		}
@@ -1333,8 +1426,13 @@ static int mpam_save_mbwu_state(void *arg)
 		cur_ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
 
-		val = mpam_read_monsel_reg(msc, MBWU);
-		mpam_write_monsel_reg(msc, MBWU, 0);
+		if (mpam_ris_has_mbwu_long_counter(ris)) {
+			val = mpam_msc_read_mbwu_l(msc);
+			mpam_msc_zero_mbwu_l(msc);
+		} else {
+			val = mpam_read_monsel_reg(msc, MBWU);
+			mpam_write_monsel_reg(msc, MBWU, 0);
+		}
 
 		cfg->mon = i;
 		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
-- 
2.39.5


