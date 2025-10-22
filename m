Return-Path: <linux-acpi+bounces-18100-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0271BFC5C6
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 16:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4BA34FABE0
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694E7347BDE;
	Wed, 22 Oct 2025 13:58:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03126ED20;
	Wed, 22 Oct 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141485; cv=none; b=GpyYm78O1vNxiPTG/lXysOy5+ysp44NpGXowAH6avtqfOrxTl7pjTUwjXOep2zHDldUkhITsoDYP5FP2VgXvmED7fnZVD+fyGTWIY7GjznfVUj2/i77Pxcq5pw5AZjVH0WvUMkaDdFylbEjaiHU7pKnShtLB7chXQkQeIMDDAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141485; c=relaxed/simple;
	bh=JT5aKwM0EBYZEgnaxnSZYP8/pGxWk8u1Z6pbRgS/E+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbXNaLWjQa24ygD7ezBySPGnkDTar8jh3NsA8GvCyoLH4Yr2OF5UVVkSIGK4T2OcDcBSKBpuglRd3TxtwgU/bzL8flhGkVPhgO3cHi19LLqALMk1BIm/AoSdVz81gK8WOhZ/pNPEYgJpQhoCLaV+pgVYNQ8ajJohWq1euDfeQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cs9BD26RTzJsbZ;
	Wed, 22 Oct 2025 21:34:28 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id CDDD018006C;
	Wed, 22 Oct 2025 21:39:19 +0800 (CST)
Received: from huawei.com (10.50.87.109) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 22 Oct
 2025 21:39:18 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>
CC: <amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
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
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, <zengheng4@huawei.com>,
	<wangkefeng.wang@huawei.com>
Subject: [PATCH mpam mpam/snapshot/v6.14-rc1] arm64/mpam: Fix MBWU monitor overflow handling
Date: Wed, 22 Oct 2025 21:39:13 +0800
Message-ID: <20251022133913.629859-1-zengheng4@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Bandwidth counters need to run continuously to correctly reflect the
bandwidth. When reading the previously configured MSMON_CFG_MBWU_CTL,
software must recognize that the MSMON_CFG_x_CTL_OFLOW_STATUS bit may
have been set by hardware because of the counter overflow.

The existing logic incorrectly treats this bit as an indication that the
monitor configuration has been changed and consequently zeros the MBWU
statistics by mistake.

Also fix the handling of overflow amount calculation. There's no need to
subtract mbwu_state->prev_val when calculating overflow_val.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/resctrl/mpam_devices.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 0dd048279e02..06f3ec9887d2 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1101,7 +1101,8 @@ static void __ris_msmon_read(void *arg)
 	clean_msmon_ctl_val(&cur_ctl);
 	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
 	config_mismatch = cur_flt != flt_val ||
-			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
+			 (cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS) !=
+			 (ctl_val | MSMON_CFG_x_CTL_EN);
 
 	if (config_mismatch || reset_on_next_read)
 		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
@@ -1138,8 +1139,9 @@ static void __ris_msmon_read(void *arg)
 		mbwu_state = &ris->mbwu_state[ctx->mon];
 
 		/* Add any pre-overflow value to the mbwu_state->val */
-		if (mbwu_state->prev_val > now)
-			overflow_val = mpam_msmon_overflow_val(m->type) - mbwu_state->prev_val;
+		if (mbwu_state->prev_val > now &&
+		   (cur_ctl & MSMON_CFG_x_CTL_OFLOW_STATUS))
+			overflow_val = mpam_msmon_overflow_val(ris);
 
 		mbwu_state->prev_val = now;
 		mbwu_state->correction += overflow_val;
-- 
2.25.1


