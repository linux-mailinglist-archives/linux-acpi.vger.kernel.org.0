Return-Path: <linux-acpi+bounces-18312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FBEC18D0B
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 08:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6C43A8716
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 07:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43917C9E;
	Wed, 29 Oct 2025 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="G8u1pPmy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97171253B71;
	Wed, 29 Oct 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724637; cv=none; b=WSkTH1tMeKBhWX2+3SgeP/sSO8yhAM+DUjch2tVCF9nUwCKOThP0vbPgj4+D0kxnlBOTQi3YBLuctM7Vuqi7L3ZFF3q56XTb/25iK5XyK+zp5WMyCXFsrD4CUBAWOwIXmcsRL0MHK4c6MFx9o6Mw5PqQNmwe8pV1iteSn7PjPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724637; c=relaxed/simple;
	bh=BnieqDTxwZRLojF8KFRHEnkoQdu0ao8unONoocRfQnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1Maaia0lkcSw3FEL7ITMvQWiRkMvNDSR/+unvzNSxVPWb3Vz95JNrx1zDBcdfS9zQKGUGyImrOa1BXLX4aa6/pNcxMP11AgXkwRPp2M/CnuT1lFlR5lQTRQgi0YGQAzHXFu62pgmMjtvFkiqGOSrgxnXZKsxYoqW/pJeXNARqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=G8u1pPmy; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=z1vyOpOhp4uD5m84f0sJub6GwUG0B1xwG+9pVCSYuwI=;
	b=G8u1pPmy1fO2CL371jWqpD3qax41pRC3q692WFthDSvTFEGBGEfdqp93EKbEsFHDco9m7lPEg
	VIRGQq9RsxpaYg0AhQc1dDuThF4fs/P4Kf98IMGnBf/vGWAgeyDWLMj/U1PJsKTTaHgGIZSaA18
	4ZiLQs9zEfQLbAb/Y6ubeHs=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cxKM55ZVvz12LFQ;
	Wed, 29 Oct 2025 15:56:33 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 073C7180491;
	Wed, 29 Oct 2025 15:57:11 +0800 (CST)
Received: from huawei.com (10.50.87.109) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 15:57:09 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <ben.horgan@arm.com>, <james.morse@arm.com>
CC: <amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <carl@os.amperecomputing.com>,
	<catalin.marinas@arm.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gregkh@linuxfoundation.org>, <gshan@redhat.com>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <jonathan.cameron@huawei.com>, <kobak@nvidia.com>,
	<lcherian@marvell.com>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <zengheng4@huawei.com>
Subject: [PATCH v2] arm64/mpam: Clean MBWU monitor overflow bit
Date: Wed, 29 Oct 2025 15:56:55 +0800
Message-ID: <20251029075655.3284280-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017185645.26604-25-james.morse@arm.com>
References: <20251017185645.26604-25-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The MSMON_MBWU register accumulates counts monotonically forward and
would not automatically cleared to zero on overflow. The overflow portion
is exactly what mpam_msmon_overflow_val() computes, there is no need to
additionally subtract mbwu_state->prev_val.

Before invoking write_msmon_ctl_flt_vals(), the overflow bit of the
MSMON_MBWU register must first be read to prevent it from being
inadvertently cleared by the write operation.

Finally, use the overflow bit instead of relying on counter wrap-around
to determine whether an overflow has occurred, that avoids the case where
a wrap-around (now > prev_val) is overlooked. So with this, prev_val no
longer has any use and remove it.

CC: Ben Horgan <ben.horgan@arm.com>
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/resctrl/mpam_devices.c  | 22 +++++++++++++++++-----
 drivers/resctrl/mpam_internal.h |  3 ---
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 0dd048279e02..db4cec710091 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1039,7 +1039,6 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);

 		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
-		mbwu_state->prev_val = 0;

 		break;
 	default:
@@ -1062,6 +1061,16 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type)
 	}
 }

+static bool read_msmon_mbwu_is_overflow(struct mpam_msc *msc)
+{
+	u32 ctl;
+
+	ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
+	return ctl & (MSMON_CFG_x_CTL_OFLOW_STATUS |
+		      MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L) ?
+		      true : false;
+}
+
 /* Call with MSC lock held */
 static void __ris_msmon_read(void *arg)
 {
@@ -1069,6 +1078,7 @@ static void __ris_msmon_read(void *arg)
 	bool config_mismatch;
 	struct mon_read *m = arg;
 	u64 now, overflow_val = 0;
+	bool mbwu_overflow = false;
 	struct mon_cfg *ctx = m->ctx;
 	bool reset_on_next_read = false;
 	struct mpam_msc_ris *ris = m->ris;
@@ -1091,6 +1101,7 @@ static void __ris_msmon_read(void *arg)
 			reset_on_next_read = mbwu_state->reset_on_next_read;
 			mbwu_state->reset_on_next_read = false;
 		}
+		mbwu_overflow = read_msmon_mbwu_is_overflow(msc);
 	}

 	/*
@@ -1103,8 +1114,10 @@ static void __ris_msmon_read(void *arg)
 	config_mismatch = cur_flt != flt_val ||
 			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);

-	if (config_mismatch || reset_on_next_read)
+	if (config_mismatch || reset_on_next_read) {
 		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
+		mbwu_overflow = false;
+	}

 	switch (m->type) {
 	case mpam_feat_msmon_csu:
@@ -1138,10 +1151,9 @@ static void __ris_msmon_read(void *arg)
 		mbwu_state = &ris->mbwu_state[ctx->mon];

 		/* Add any pre-overflow value to the mbwu_state->val */
-		if (mbwu_state->prev_val > now)
-			overflow_val = mpam_msmon_overflow_val(m->type) - mbwu_state->prev_val;
+		if (mbwu_overflow)
+			overflow_val = mpam_msmon_overflow_val(m->type);

-		mbwu_state->prev_val = now;
 		mbwu_state->correction += overflow_val;

 		/* Include bandwidth consumed before the last hardware reset */
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 4f25681b56ab..8837c0cd7b0c 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -226,9 +226,6 @@ struct msmon_mbwu_state {
 	bool		reset_on_next_read;
 	struct mon_cfg	cfg;

-	/* The value last read from the hardware. Used to detect overflow. */
-	u64		prev_val;
-
 	/*
 	 * The value to add to the new reading to account for power management,
 	 * and shifts to trigger the overflow interrupt.
--
2.25.1


