Return-Path: <linux-acpi+bounces-15973-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18683B31F79
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65C01D2553E
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B72882DE;
	Fri, 22 Aug 2025 15:37:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC82882B2;
	Fri, 22 Aug 2025 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877030; cv=none; b=USOSTHcEZhDIGBHpbVl2y488WO4L+MAwRRyRnyTiiVVr8kwyMSv3FKBvWL82bxLarMV+p6612eieNO4VPZO8f/NSWyFW9gFbMhqRb24nIJhxrYfyYv0iGHAXRQIv/vea9Yu+dXi6Lkf4azq1ZwO3BNSpP1BjO6y7Ai3Mjd/+kWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877030; c=relaxed/simple;
	bh=s+tKsbJi/c/NTyvZ20R8uRUL3GNh8OK2lBvLuotvBO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCxuvY4MBZDFtoC4ULHXB+YGGwngVKZbBdFbmx7EN8uTnzcBhQLlkVFwUbTYcBcFSFc0mktGFQnigT9zeZN3cHKCBoHy0WpZ++wWADSjhhR0TKJE0d3wBnDSW1KCoD5u3z6dBY/NpUKp3R13k/s2mLUup66cHX3WZYciaIBkWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3F1D27B5;
	Fri, 22 Aug 2025 08:36:59 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3ADE3F63F;
	Fri, 22 Aug 2025 08:37:02 -0700 (PDT)
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
Subject: [PATCH 30/33] arm_mpam: Use long MBWU counters if supported
Date: Fri, 22 Aug 2025 15:30:45 +0000
Message-Id: <20250822153048.2287-65-james.morse@arm.com>
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

From: Rohit Mathew <rohit.mathew@arm.com>

If the 44 bit (long) or 63 bit (LWD) counters are detected on probing
the RIS, use long/LWD counter instead of the regular 31 bit mbwu
counter.

Only 32bit accesses to the MSC are required to be supported by the
spec, but these registers are 64bits. The lower half may overflow
into the higher half between two 32bit reads. To avoid this, use
a helper that reads the top half multiple times to check for overflow.

Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
[morse: merged multiple patches from Rohit]
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since RFC:
 * Commit message wrangling.
 * Refer to 31 bit counters as opposed to 32 bit (registers).
---
 drivers/resctrl/mpam_devices.c | 89 ++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 2ab7f127baaa..8fbcf6eb946a 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1002,6 +1002,48 @@ struct mon_read {
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
@@ -1058,6 +1100,7 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 static void clean_msmon_ctl_val(u32 *cur_ctl)
 {
 	*cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
+	*cur_ctl &= ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;
 }
 
 static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
@@ -1080,7 +1123,11 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 	case mpam_feat_msmon_mbwu:
 		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
-		mpam_write_monsel_reg(msc, MBWU, 0);
+		if (mpam_ris_has_mbwu_long_counter(m->ris))
+			mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
+		else
+			mpam_write_monsel_reg(msc, MBWU, 0);
+
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
 
 		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
@@ -1095,8 +1142,13 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 
 static u64 mpam_msmon_overflow_val(struct mpam_msc_ris *ris)
 {
-	/* TODO: scaling, and long counters */
-	return GENMASK_ULL(30, 0);
+	/* TODO: implement scaling counters */
+	if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, &ris->props))
+		return GENMASK_ULL(62, 0);
+	else if (mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props))
+		return GENMASK_ULL(43, 0);
+	else
+		return GENMASK_ULL(30, 0);
 }
 
 /* Call with MSC lock held */
@@ -1138,10 +1190,24 @@ static void __ris_msmon_read(void *arg)
 		now = FIELD_GET(MSMON___VALUE, now);
 		break;
 	case mpam_feat_msmon_mbwu:
-		now = mpam_read_monsel_reg(msc, MBWU);
-		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
-			nrdy = now & MSMON___NRDY;
-		now = FIELD_GET(MSMON___VALUE, now);
+		/*
+		 * If long or lwd counters are supported, use them, else revert
+		 * to the 31 bit counter.
+		 */
+		if (mpam_ris_has_mbwu_long_counter(ris)) {
+			now = mpam_msc_read_mbwu_l(msc);
+			if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
+				nrdy = now & MSMON___NRDY_L;
+			if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, rprops))
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
@@ -1433,8 +1499,13 @@ static int mpam_save_mbwu_state(void *arg)
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
 		cfg->pmg = FIELD_GET(MSMON_CFG_MBWU_FLT_PMG, cur_flt);
-- 
2.20.1


