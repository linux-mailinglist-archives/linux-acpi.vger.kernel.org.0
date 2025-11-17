Return-Path: <linux-acpi+bounces-18961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B937C656D8
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C994366A01
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE99E33BBB0;
	Mon, 17 Nov 2025 17:03:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEAF33B6F5;
	Mon, 17 Nov 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398994; cv=none; b=CoyyXPbSTlajhEWSPbEsztvMvsgFBuYBC+VHHesVZUAQtepeZydQB89Qya2Z8qQ0K/nTGR+scLKbtXuWv2T1/fjB1vApEDSdq4nDWjeffE9+nNlYlHQvFYqjTiwdEKgHZAelVwsVtT6Nmax2lSVCiVjcT7XNwYeiwuRiMQ8nDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398994; c=relaxed/simple;
	bh=He9ceTXXwWOYPCz54Cv2c2d1gSJrCuIoegXgDHbkH9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teG5sPHUymN2QPV9YN+FA17Du8QPhvk33+sNNqpF4Awin09uto0dhuG+pHwsu3b644kiU6n7n3hk4BySIzQT1nV2xsPl9tNch9fcSe00E+nUMoLqdmorX3MsCcK9OByot3GdpgtPWQVT4caf6ro+D4viPAwqejvkCk5zTLXoAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13C8E1692;
	Mon, 17 Nov 2025 09:03:05 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B6663F66E;
	Mon, 17 Nov 2025 09:03:07 -0800 (PST)
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
Subject: [PATCH v5 30/34] arm_mpam: Use long MBWU counters if supported
Date: Mon, 17 Nov 2025 17:00:09 +0000
Message-ID: <20251117170014.4113754-31-ben.horgan@arm.com>
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
Cc: Peter Newman <peternewman@google.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v3:
Peter:
Fix type checking, use mpam_feat_msmon_mbwu_<n>counter
Reset/configuration order of long counters
---
 drivers/resctrl/mpam_devices.c | 145 ++++++++++++++++++++++++++++-----
 1 file changed, 126 insertions(+), 19 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index c371a22147b7..af0cd44c7517 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -905,6 +905,50 @@ struct mon_read {
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
+
+	pr_warn("Failed to read a stable value\n");
+	return MSMON___L_NRDY;
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
@@ -931,7 +975,9 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 			*flt_val |= FIELD_PREP(MSMON_CFG_CSU_FLT_XCL, ctx->csu_exclude_clean);
 
 		break;
-	case mpam_feat_msmon_mbwu:
+	case mpam_feat_msmon_mbwu_31counter:
+	case mpam_feat_msmon_mbwu_44counter:
+	case mpam_feat_msmon_mbwu_63counter:
 		*ctl_val |= MSMON_CFG_MBWU_CTL_TYPE_MBWU;
 
 		if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ris->props))
@@ -953,7 +999,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 		*ctl_val = mpam_read_monsel_reg(msc, CFG_CSU_CTL);
 		*flt_val = mpam_read_monsel_reg(msc, CFG_CSU_FLT);
 		break;
-	case mpam_feat_msmon_mbwu:
+	case mpam_feat_msmon_mbwu_31counter:
+	case mpam_feat_msmon_mbwu_44counter:
+	case mpam_feat_msmon_mbwu_63counter:
 		*ctl_val = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
 		*flt_val = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
 		break;
@@ -966,6 +1014,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 static inline void clean_msmon_ctl_val(u32 *cur_ctl)
 {
 	*cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
+
+	if (FIELD_GET(MSMON_CFG_x_CTL_TYPE, *cur_ctl) == MSMON_CFG_MBWU_CTL_TYPE_MBWU)
+		*cur_ctl &= ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;
 }
 
 static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
@@ -984,12 +1035,17 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 		mpam_write_monsel_reg(msc, CSU, 0);
 		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
 		break;
-	case mpam_feat_msmon_mbwu:
+	case mpam_feat_msmon_mbwu_31counter:
+	case mpam_feat_msmon_mbwu_44counter:
+	case mpam_feat_msmon_mbwu_63counter:
 		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
 		/* Counting monitors require NRDY to be reset by software */
-		mpam_write_monsel_reg(msc, MBWU, 0);
+		if (m->type == mpam_feat_msmon_mbwu_31counter)
+			mpam_write_monsel_reg(msc, MBWU, 0);
+		else
+			mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
 		break;
 	default:
 		pr_warn("Unexpected monitor type %d\n", m->type);
@@ -998,8 +1054,17 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 
 static u64 mpam_msmon_overflow_val(enum mpam_device_features type)
 {
-	/* TODO: scaling, and long counters */
-	return BIT_ULL(hweight_long(MSMON___VALUE));
+	/* TODO: implement scaling counters */
+	switch (type) {
+	case mpam_feat_msmon_mbwu_63counter:
+		return BIT_ULL(hweight_long(MSMON___LWD_VALUE));
+	case mpam_feat_msmon_mbwu_44counter:
+		return BIT_ULL(hweight_long(MSMON___L_VALUE));
+	case mpam_feat_msmon_mbwu_31counter:
+		return BIT_ULL(hweight_long(MSMON___VALUE));
+	default:
+		return 0;
+	}
 }
 
 static void __ris_msmon_read(void *arg)
@@ -1029,7 +1094,12 @@ static void __ris_msmon_read(void *arg)
 	 * This saves waiting for 'nrdy' on subsequent reads.
 	 */
 	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
-	overflow = cur_ctl & MSMON_CFG_x_CTL_OFLOW_STATUS;
+
+	if (mpam_feat_msmon_mbwu_31counter == m->type)
+		overflow = cur_ctl & MSMON_CFG_x_CTL_OFLOW_STATUS;
+	else if (mpam_feat_msmon_mbwu_44counter == m->type ||
+		 mpam_feat_msmon_mbwu_63counter == m->type)
+		overflow = cur_ctl & MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;
 
 	clean_msmon_ctl_val(&cur_ctl);
 	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
@@ -1041,7 +1111,9 @@ static void __ris_msmon_read(void *arg)
 		overflow = false;
 	} else if (overflow) {
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
-				      cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS);
+				      cur_ctl &
+				      ~(MSMON_CFG_x_CTL_OFLOW_STATUS |
+					MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L));
 	}
 
 	switch (m->type) {
@@ -1051,11 +1123,24 @@ static void __ris_msmon_read(void *arg)
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
+				nrdy = now & MSMON___L_NRDY;
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
@@ -1118,13 +1203,26 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
 	return any_err;
 }
 
+static enum mpam_device_features mpam_msmon_choose_counter(struct mpam_class *class)
+{
+	struct mpam_props *cprops = &class->props;
+
+	if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, cprops))
+		return mpam_feat_msmon_mbwu_63counter;
+	if (mpam_has_feature(mpam_feat_msmon_mbwu_44counter, cprops))
+		return mpam_feat_msmon_mbwu_44counter;
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
 
@@ -1134,6 +1232,9 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 	if (!mpam_has_feature(type, cprops))
 		return -EOPNOTSUPP;
 
+	if (type == mpam_feat_msmon_mbwu)
+		type = mpam_msmon_choose_counter(class);
+
 	arg = (struct mon_read) {
 		.ctx = ctx,
 		.type = type,
@@ -1142,8 +1243,8 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 	*val = 0;
 
 	err = _msmon_read(comp, &arg);
-	if (err == -EBUSY && comp->class->nrdy_usec)
-		wait_jiffies = usecs_to_jiffies(comp->class->nrdy_usec);
+	if (err == -EBUSY && class->nrdy_usec)
+		wait_jiffies = usecs_to_jiffies(class->nrdy_usec);
 
 	while (wait_jiffies)
 		wait_jiffies = schedule_timeout_uninterruptible(wait_jiffies);
@@ -1282,12 +1383,13 @@ static int mpam_restore_mbwu_state(void *_ris)
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
@@ -1322,8 +1424,13 @@ static int mpam_save_mbwu_state(void *arg)
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
2.43.0


