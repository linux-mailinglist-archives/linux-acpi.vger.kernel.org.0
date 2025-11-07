Return-Path: <linux-acpi+bounces-18653-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A08C3FF22
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 13:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7003134F850
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 12:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD4C32C937;
	Fri,  7 Nov 2025 12:37:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F1320CC2;
	Fri,  7 Nov 2025 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519076; cv=none; b=Vg2xJSimv0l9tUxzupGJz12Cd7scckLIAiO5qaw9q5qSebmINYfV1iuZPDJiHxpTeTB0K1ZyJ78XLWF1g8cDD/1gsAXuV2y35OTh0X0LrXkdIEBYXrtRWfLuJ/OEK1A4mDlP9pQrrjk+zu+aD1IfjPA+Ko8BNNpaUYSYVM8SUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519076; c=relaxed/simple;
	bh=jS5CqKJ88zY/tuVY5narOdQKecf9/diuai9hdjdly8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruz4tqZWXc5+diEFxglLoYasgMS/OLHo706K6oi/8jG6Wx4a+d/bVzWQnoRvDFjV1ipBzuyDLupeavuwYAVKPtFAgZsAh9XfojVizTrjuk5HLsrVVJIAFNHyv3CPWm8xrg4+Bn1YWem1TtncHbxi8tS9hq4tbOgxd1fcHqCsgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E7161A2D;
	Fri,  7 Nov 2025 04:37:47 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC06C3F66E;
	Fri,  7 Nov 2025 04:37:49 -0800 (PST)
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
	Zeng Heng <zengheng4@huawei.com>
Subject: [PATCH 28/33] arm_mpam: Consider overflow in bandwidth counter state
Date: Fri,  7 Nov 2025 12:34:45 +0000
Message-ID: <20251107123450.664001-29-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the overflow status bit to track overflow on each bandwidth counter
read and add the counter size to the correction when overflow is detected.

This assumes that only a single overflow has occurred since the last read
of the counter. Overflow interrupts, on hardware that supports them could
be used to remove this limitation.

Cc: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 24 ++++++++++++++++++++++--
 drivers/resctrl/mpam_internal.h |  3 ++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 2d1cef824b8e..eea082dfcddc 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -986,11 +986,18 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 	}
 }
 
+static u64 mpam_msmon_overflow_val(enum mpam_device_features type)
+{
+	/* TODO: scaling, and long counters */
+	return BIT_ULL(hweight_long(MSMON___VALUE));
+}
+
 static void __ris_msmon_read(void *arg)
 {
 	u64 now;
 	bool nrdy = false;
 	bool config_mismatch;
+	bool overflow;
 	struct mon_read *m = arg;
 	struct mon_cfg *ctx = m->ctx;
 	struct mpam_msc_ris *ris = m->ris;
@@ -1012,13 +1019,20 @@ static void __ris_msmon_read(void *arg)
 	 * This saves waiting for 'nrdy' on subsequent reads.
 	 */
 	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
+	overflow = cur_ctl & MSMON_CFG_x_CTL_OFLOW_STATUS;
+
 	clean_msmon_ctl_val(&cur_ctl);
 	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
 	config_mismatch = cur_flt != flt_val ||
 			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
 
-	if (config_mismatch)
+	if (config_mismatch) {
 		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
+		overflow = false;
+	} else if (overflow) {
+		mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
+				      cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS);
+	}
 
 	switch (m->type) {
 	case mpam_feat_msmon_csu:
@@ -1038,7 +1052,13 @@ static void __ris_msmon_read(void *arg)
 
 		mbwu_state = &ris->mbwu_state[ctx->mon];
 
-		/* Include bandwidth consumed before the last hardware reset */
+		if (overflow)
+			mbwu_state->correction += mpam_msmon_overflow_val(m->type);
+
+		/*
+		 * Include bandwidth consumed before the last hardware reset and
+		 * a counter size increment for each overflow.
+		 */
 		now += mbwu_state->correction;
 		break;
 	default:
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 1f2b04b7703e..7c99d4f3dc9c 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -209,7 +209,8 @@ struct msmon_mbwu_state {
 	struct mon_cfg	cfg;
 
 	/*
-	 * The value to add to the new reading to account for power management.
+	 * The value to add to the new reading to account for power management,
+	 * and overflow.
 	 */
 	u64		correction;
 
-- 
2.43.0


