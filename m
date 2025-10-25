Return-Path: <linux-acpi+bounces-18216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326EC08E80
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Oct 2025 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBBC4045B8
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Oct 2025 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C42E62A1;
	Sat, 25 Oct 2025 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="pI2Ce4vy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657635898;
	Sat, 25 Oct 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761384887; cv=none; b=PGGLFvC3BmgfzBt0yUz6CZh5YgckH3K9B5MMViH67DdKzDgNIDn1J+lKt+kiVBLSKEFsnCdXCs3KcjcsvcwitdFuoy0o8VgQor2XI9W+vXdo2c+AIFJYzMT+nyYngUheKgouFuMU8kHTrDs0MusEKeuUIa4zWFOSqTV3jom26Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761384887; c=relaxed/simple;
	bh=LV8sGQ71xsL085epJdSMDWxSQ/YnHemUNu6BoJUcrfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOmF2v5hU/c9aBU2oCAcBtSr8wUrvPgkp2Rmz9fzieOG73NACqyD8vVk8XHRXrcRdQyEZ4Ow3F8idzLok/kd8ldof0pi8rb6unBMhhPlAN1K74a0VC8OWFkSODV1W/CjCUy7OMmAAWgkhXcQWNts2ZnB5dMrF6wbchb/fRqNR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=pI2Ce4vy; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lKlFKPFWui0rBF7JkALPT4rV4/6BtprmXI6qCc+ucnA=;
	b=pI2Ce4vySPQvfHaznAABDEnVBnVP5iKVw+xG5yvYh+bN0vv24/CP7qMoFWYrpqHsj4RYoRu3X
	z+fZXrVao8Lu/FXvBQzyK53O5TTEzH7KrybEvJkIUlmqabHGNXmO4OIA1AuIUmiQNXe9URANqOy
	cc8GcvVx4i33G4OQvyLozkU=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4ctvjW3FDSz1prLt;
	Sat, 25 Oct 2025 17:34:07 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FCA6180087;
	Sat, 25 Oct 2025 17:34:34 +0800 (CST)
Received: from huawei.com (10.50.87.109) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 25 Oct
 2025 17:34:32 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <ben.horgan@arm.com>, <james.morse@arm.com>
CC: <zengheng4@huawei.com>, <amitsinght@marvell.com>,
	<baisheng.gao@unisoc.com>, <baolin.wang@linux.alibaba.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <gshan@redhat.com>,
	<guohanjun@huawei.com>, <jeremy.linton@arm.com>,
	<jonathan.cameron@huawei.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <sunnanyong@huawei.com>, <tan.shaopeng@fujitsu.com>,
	<wangkefeng.wang@huawei.com>, <will@kernel.org>, <xhao@linux.alibaba.com>
Subject: [PATCH] arm64/mpam: Clean MBWU monitor overflow bit
Date: Sat, 25 Oct 2025 17:34:28 +0800
Message-ID: <20251025093428.1379218-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a3e95937-b0c7-020e-d52d-7189d2540f8f@huawei.com>
References: <a3e95937-b0c7-020e-d52d-7189d2540f8f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The MSMON_MBWU register accumulates counts monotonically forward and
would not automatically cleared to zero on overflow. The overflow portion
is exactly what mpam_msmon_overflow_val() computes, there is no need to
additionally subtract mbwu_state->prev_val.

Before invoking write_msmon_ctl_flt_vals(), the overflow bit of the
MSMON_MBWU register must first be read to prevent it from being
inadvertently cleared by the write operation. Then, before updating the
monitor configuration, the overflow bit should be cleared to zero.

Finally, use the overflow bit instead of relying on counter wrap-around
to determine whether an overflow has occurred, that avoids the case where
a wrap-around (now > prev_val) is overlooked.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/resctrl/mpam_devices.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 0dd048279e02..575980e3a366 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1062,6 +1062,21 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type)
 	}
 }
 
+static bool read_msmon_mbwu_is_overflow(struct mpam_msc *msc)
+{
+	u32 ctl;
+	bool overflow;
+
+	ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
+	overflow = ctl & MSMON_CFG_x_CTL_OFLOW_STATUS ? true : false;
+
+	if (overflow)
+		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl &
+				     ~MSMON_CFG_x_CTL_OFLOW_STATUS);
+
+	return overflow;
+}
+
 /* Call with MSC lock held */
 static void __ris_msmon_read(void *arg)
 {
@@ -1069,6 +1084,7 @@ static void __ris_msmon_read(void *arg)
 	bool config_mismatch;
 	struct mon_read *m = arg;
 	u64 now, overflow_val = 0;
+	bool mbwu_overflow = false;
 	struct mon_cfg *ctx = m->ctx;
 	bool reset_on_next_read = false;
 	struct mpam_msc_ris *ris = m->ris;
@@ -1091,6 +1107,7 @@ static void __ris_msmon_read(void *arg)
 			reset_on_next_read = mbwu_state->reset_on_next_read;
 			mbwu_state->reset_on_next_read = false;
 		}
+		mbwu_overflow = read_msmon_mbwu_is_overflow(msc);
 	}
 
 	/*
@@ -1138,8 +1155,8 @@ static void __ris_msmon_read(void *arg)
 		mbwu_state = &ris->mbwu_state[ctx->mon];
 
 		/* Add any pre-overflow value to the mbwu_state->val */
-		if (mbwu_state->prev_val > now)
-			overflow_val = mpam_msmon_overflow_val(m->type) - mbwu_state->prev_val;
+		if (mbwu_overflow)
+			overflow_val = mpam_msmon_overflow_val(m->type);
 
 		mbwu_state->prev_val = now;
 		mbwu_state->correction += overflow_val;
-- 
2.25.1


