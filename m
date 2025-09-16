Return-Path: <linux-acpi+bounces-17016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FD5B59746
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 15:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1A217A4E1
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE822C2AA2;
	Tue, 16 Sep 2025 13:17:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB515A8;
	Tue, 16 Sep 2025 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028651; cv=none; b=cwMJuB36AyQDSFHsBF0LBlttzY27Q3WcN68qRvSQ07s0Zbq0Nq0oAgOUKwPwsNp65Q+5Ja/4lzVNrSUqmjFDaxHb+rBTltzlaBLwPCq5HeQ18Msw4stzl8cgPM2uwHJbF1u//TXm+rCsY+JByidguH1elOBrY0zTnAhpgv72B0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028651; c=relaxed/simple;
	bh=PjMRw6sHcOYLHYj8pf9QThXIPuDyUQgrjK8mOkIlPtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1YaVx71EBArO/c2rkTVatDTVNoC4lTu+jKQQMlikEdZ8d1Ky3qr9pFADYreLz6Fs2aC+CSqKdhtw0g0jIjIoq4+zS425/9QxFxp9I90ueuOq36fLmezgXminu0Qt2+T+EByUGLqCYOPCAmn9PjH/K2PmUnDMWuaW1nXMnMqhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cR2Pp2WdlzRkJN;
	Tue, 16 Sep 2025 21:12:46 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id C7BA91402EB;
	Tue, 16 Sep 2025 21:17:23 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 21:17:22 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>
CC: <amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <guohanjun@huawei.com>,
	<jonathan.cameron@huawei.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, <zengheng4@huawei.com>
Subject: [PATCH] arm_mpam: Try reading again if MPAM instance returns not ready
Date: Tue, 16 Sep 2025 21:17:17 +0800
Message-ID: <20250916131717.2980875-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250910204309.20751-7-james.morse@arm.com>
References: <20250910204309.20751-7-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100008.china.huawei.com (7.202.181.222)

After updating the monitor configuration, the first read of the monitoring
result requires waiting for the "not ready" duration before an effective
value can be obtained.

Because a component consists of multiple MPAM instances, after updating the
configuration of each instance, should wait for the "not ready" period of
per single instance before the valid monitoring value can be obtained, not
just wait for once interval per component.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
It's fine to merge this patch directly into patch 7 of the responding
patchset.
---
 drivers/resctrl/mpam_devices.c | 36 +++++++++++++++-------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 2962cd018207..e79a46646863 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1183,11 +1183,14 @@ static void __ris_msmon_read(void *arg)
 	}

 	*m->val += now;
+	m->err = 0;
 }

 static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
 {
 	int err, idx;
+	bool read_again;
+	u64 wait_jiffies;
 	struct mpam_msc *msc;
 	struct mpam_vmsc *vmsc;
 	struct mpam_msc_ris *ris;
@@ -1198,10 +1201,22 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)

 		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
 			arg->ris = ris;
+			read_again = false;
+again:

 			err = smp_call_function_any(&msc->accessibility,
 						    __ris_msmon_read, arg,
 						    true);
+			if (arg->err == -EBUSY && !read_again) {
+				read_again = true;
+
+				wait_jiffies = usecs_to_jiffies(comp->class->nrdy_usec);
+				while (wait_jiffies)
+					wait_jiffies = schedule_timeout_uninterruptible(wait_jiffies);
+
+				goto again;
+			}
+
 			if (!err && arg->err)
 				err = arg->err;
 			if (err)
@@ -1218,9 +1233,7 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
 int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 		    enum mpam_device_features type, u64 *val)
 {
-	int err;
 	struct mon_read arg;
-	u64 wait_jiffies = 0;
 	struct mpam_props *cprops = &comp->class->props;

 	might_sleep();
@@ -1237,24 +1250,7 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 	arg.val = val;
 	*val = 0;

-	err = _msmon_read(comp, &arg);
-	if (err == -EBUSY && comp->class->nrdy_usec)
-		wait_jiffies = usecs_to_jiffies(comp->class->nrdy_usec);
-
-	while (wait_jiffies)
-		wait_jiffies = schedule_timeout_uninterruptible(wait_jiffies);
-
-	if (err == -EBUSY) {
-		memset(&arg, 0, sizeof(arg));
-		arg.ctx = ctx;
-		arg.type = type;
-		arg.val = val;
-		*val = 0;
-
-		err = _msmon_read(comp, &arg);
-	}
-
-	return err;
+	return _msmon_read(comp, &arg);
 }

 void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
--
2.25.1


