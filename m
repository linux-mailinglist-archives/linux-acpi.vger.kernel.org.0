Return-Path: <linux-acpi+bounces-9526-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0807F9C6770
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 03:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E66B2424B
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 02:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866614BF8B;
	Wed, 13 Nov 2024 02:49:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E517C;
	Wed, 13 Nov 2024 02:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466181; cv=none; b=GnPLnIw3RzEKuQjxZjvb1gwG9uGTPn088J9A1GqT0T/iP1D6vsqnjBABqoZOkxnaRoKN59j6dciR/p26qf1WAAmyIHc/XgJ8XBT2FKLQmRajlCiuAvDE2Oyx7BtNhqKa8wqfl8IQSaLLfZ1U5G3KHmcF/K2xEWpnoew/cfwPd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466181; c=relaxed/simple;
	bh=Zjc4WHxutICboKeSESIFxhRAQwm2TMaSiKKS6KfGRqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pRZVeUeRLg6Ay5j07/5FgmZSZGU0UDI2iUMi6Gq1+IqiJMpiUiPN4lwh8w/05WuTuo8ieW626ocLZD/B++1Omet46VcWoZBe5AMJ01UKqzaLAU3DOIXOUMDJW5SiyX0G1nmW6iIkHzyJtsPVxKH9i2Zw2NDc7Tuk3/WLBGeusl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xp74F2h61z10V8h;
	Wed, 13 Nov 2024 10:47:41 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BFE61800F2;
	Wed, 13 Nov 2024 10:49:35 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 10:49:34 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <fanghao11@huawei.com>,
	<cleger@rivosinc.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH] ACPI: CPPC: fix bug that causes the value written in cpc register to be wrong.
Date: Wed, 13 Nov 2024 10:49:33 +0800
Message-ID: <20241113024933.2100519-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

With these codes, the value written in cpc register will be the result of
the OR operatiion on input value and prev_val. This will causes the value
to be wrong.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 01192fd047a6..f69ef7cc0caf 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1146,7 +1146,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			return -EFAULT;
 		}
 		val = MASK_VAL_WRITE(reg, prev_val, val);
-		val |= prev_val;
 	}
 
 	switch (size) {
-- 
2.33.0


