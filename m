Return-Path: <linux-acpi+bounces-19532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E1CB3024
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D06DD305C820
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AE031E0EA;
	Wed, 10 Dec 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PJgDdlVl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EE1F3BA4;
	Wed, 10 Dec 2025 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372956; cv=none; b=g5fRD0XvP0RrroKHM2now4kNz05/Iyj1BuwDd8mCG+xmR2Z6FonTMBQrT5++/gvtmKYburYJR8O+2Ys484xP7GjuQusH5Qd9E5djIrPUL6GaOC6rkPDRr36J7vJ2kpDot+1Vf3NS1C7hfXZ0EPdV2/nvLRzDpcw4DKNzfrXphlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372956; c=relaxed/simple;
	bh=uA6pspcMdyBlVw2LUfLXSRy/M11QN6NDIJoyPWyS8y8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QTSFBh53rHGC8g2HX1ptIlN0f0gRY2u2bnrsCjOjk2rbBPUOGKSUdbYpgsL/5K7W2qWi8mxTL6seDBezQvSEv2nW3Q2hCZo6RzkhKq2tTbiBL13cCWsTjq5ZPU4d8zXPjVPvZesxZNmCglWOovb/MHE3OM3Kzqx1eFD4q0xgFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PJgDdlVl; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uG19g+zE76VkgZXz/kaqI7HCogznnjrlYP3lQjZOz6s=;
	b=PJgDdlVlfM0lumg31OW/b80ouzP8ms34sz12fYUJI4uGCoat6A1TrL3eyH2pAlw46BUxVkWC6
	MAoNUwdOPaFKhN6IWFHE/LOWS9Go6ey1HGTZb51SU7bQRB7cXLll4+7e63wJycUYsPSZexEOYOz
	cCbKj39Z5q1gl8utBwMZYJU=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dRGYX0nVXzKm4G;
	Wed, 10 Dec 2025 21:20:32 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C6B6140142;
	Wed, 10 Dec 2025 21:22:29 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Dec
 2025 21:22:28 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>,
	<srinivas.pandruvada@linux.intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
Subject: [PATCH] ACPI: CPPC: Fix missing PCC check for guaranteed
Date: Wed, 10 Dec 2025 21:22:27 +0800
Message-ID: <20251210132227.1988380-1-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr200004.china.huawei.com (7.202.195.241)

the current implementation overlooks the 'guaranteed_perf'
register in this check.

If the Guaranteed Performance register is located in the PCC
subspace, the function currently attempts to read it without
acquiring the lock and without sending the CMD_READ doorbell
to the firmware. This can result in reading stale data.

Fixes: 29523f095397 ("ACPI / CPPC: Add support for guaranteed performance")
Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3bdeeee3414e..e66e20d1f31b 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1366,7 +1366,8 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	/* Are any of the regs PCC ?*/
 	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
 		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
-		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg)) {
+		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) ||
+		CPC_IN_PCC(guaranteed_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
-- 
2.33.0


