Return-Path: <linux-acpi+bounces-10548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F9A0B6C1
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328563A94D0
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658422A4F6;
	Mon, 13 Jan 2025 12:21:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A595A22AE7B;
	Mon, 13 Jan 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770886; cv=none; b=qDVRrnLv4rak+lhEbQJ9PuE8dzPOuGNV8Uu+MmJJqKLci0zd/Fi5igPljyh3kSR2AQFzMUMpDZNM7LaV9HEXpZpLaLX9rN3ULiaFnEV+OwCzejS7x3aFADCt/bWj0P2lOfFx+utSGwma1wIsQATUXsKat0epI09b73h6reY7kfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770886; c=relaxed/simple;
	bh=zekOdi6n3VYMxHGrckuhAG8bsTJ3kkcv6UwM1qs/lgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/4xxALigUsBsk7kfsRPSeg0OPWduJd+KVE6OWKPH050W16rN0YLqn82Gfyr9ozahM+hT28QDkxoQ/iVtTfQ53c4ojrC9uzjC1LEme2jywGF4euppvs9QoJHGzDDzn4cOrFCSXz30mVgdotLgUjhV/G5eLSpEPtaZBpE9R7FpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YWrs24b89z22l71;
	Mon, 13 Jan 2025 20:18:46 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 265111401F4;
	Mon, 13 Jan 2025 20:21:07 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jan 2025 20:21:06 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<hepeng68@huawei.com>, <fanghao11@huawei.com>
Subject: [PATCH v4 1/6] ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro
Date: Mon, 13 Jan 2025 20:20:59 +0800
Message-ID: <20250113122104.3870673-2-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
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

Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is an optional one.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f193e713825a..6454b469338f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -129,6 +129,12 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 #define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?		\
 				!!(cpc)->cpc_entry.int_value :		\
 				!IS_NULL_REG(&(cpc)->cpc_entry.reg))
+
+/* These indicate optional of the per-cpu cpc_regs[]. */
+#define REG_OPTIONAL (0b111111100011111010000)
+
+#define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx)))
+
 /*
  * Arbitrary Retries in case the remote processor is slow to respond
  * to PCC commands. Keeping it high enough to cover emulators where
-- 
2.33.0


