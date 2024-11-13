Return-Path: <linux-acpi+bounces-9540-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365299C6CF3
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 11:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB5CB28D88
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4BD1FDFB7;
	Wed, 13 Nov 2024 10:33:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D961FB899;
	Wed, 13 Nov 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494003; cv=none; b=M0InlW62WyxeidHqIThX9fXoqSPZrtZJkr6PmPXbd3UnNt/iYerSjND2aK0vXwIWIZ825tc0CPdkN7ZYkfafL6D5EEsSM0ZTMEmcUODlIGZAO4IOufY/zG/hVtQT3evVcxOm/6TXQISFGGFzTVeItwvqNLlJmbPuHbQ+CHpHIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494003; c=relaxed/simple;
	bh=Q4d7SiemIqtlpCnkH0I7Ablx+w5Z6SYsYQwD7gTSe1k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMxND0JuXmoZOGYQq1wWniIJeGBLm3W+d44cAXKCkX3tZeu75/1wLMGByn1bE0ct+/NgTw2pEWO/FEkISYyzxFNdsRmnSpfsksRkZr6EnqHcHzc0Tr0QvDcbyuo3qP/hZFaqrC2WU8K94u29vtNrLfEJb2eIqnLUatsBqdMHpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XpKM83Lszz10V9g;
	Wed, 13 Nov 2024 18:31:16 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B68C11800CF;
	Wed, 13 Nov 2024 18:33:10 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 18:33:10 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <fanghao11@huawei.com>,
	<cleger@rivosinc.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH] ACPI: CPPC: Fix cpc register setting issue.
Date: Wed, 13 Nov 2024 18:33:09 +0800
Message-ID: <20241113103309.761031-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Since commit 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage"), CPC
registers cannot be changed from 1 to 0. It turns out that there is an
extra OR after MASK_VAL_WRITE(), which has already ORed prev_val with the
register mask. Remove the extra OR to fix the problem.

Fixes: 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1a40f0514eaa..c1f3568d0c50 100644
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


