Return-Path: <linux-acpi+bounces-18418-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59450C2A9A6
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 09:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0382D4E6EBD
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 08:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2562E092D;
	Mon,  3 Nov 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="qYLQ3JNp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A88287245;
	Mon,  3 Nov 2025 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159372; cv=none; b=FR/o2RFCdefOlEMATH/aKsgKgXRkBaqnN6mjyhdfDCh+nRh6zYSFQQrNcj5d4XJjrOv/lfUatPqTthrEsV+lS6Lk6bc+zUSPf8NnUPmo0eAH8WixtNs4ptNb4txfBsYT7ywlWwD22dnWe2LJHhzV33u3aEM1lL+Gys/nqAbOHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159372; c=relaxed/simple;
	bh=Eal9+GaBaTK8Emch51Crk0Ut0f2tDLiKgxG1ESeFIvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjVYzntqmxjLqeEsEWHkzRQgNPf0ImsQfw4tV/0+zza573TpemW4bY3rHkRp0y2AGy3HCk6AHwmhVyyGvTsXFkOZnQcsGgv815HzQiPGlSFdv0Al87cdxZkQLXyksmhBUQ0eypoZzIs8usL/115g6AHjhe4WhEja8vdbBdqWhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=qYLQ3JNp; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lJ6ifbD9CdTpPwXjFL/2uF+ta4RpaTrCFVLzkUmeufE=;
	b=qYLQ3JNp6kx3J46T2Nb7TNxDzJ6gTGSHNy4FlnlXzL/72lUbEEDrbYvdF6g6oM+7uPIHM7Oxm
	nBT0ApIAeBQhU4EA2CUPXrxtN7wBVHh5Y/XZwnleD6aW1sNtBUbBY1W5/K0OXwQP7prTqfRIboM
	YNAciNxxmEseqEXJsbQBctM=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d0Q6R01NXzpStT;
	Mon,  3 Nov 2025 16:41:19 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 33EF614020C;
	Mon,  3 Nov 2025 16:42:46 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:45 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:45 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v2 1/7] ACPI: processor: idle: Mark the state as invalid if its entry method is illegal
Date: Mon, 3 Nov 2025 16:42:38 +0800
Message-ID: <20251103084244.2654432-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251103084244.2654432-1-lihuisong@huawei.com>
References: <20251103084244.2654432-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)

According to ACPI spec, entry method in LPI sub-package must be buffer
or integer. And the entry method is very key in cpuidle. So mark the state
as invalid.

Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 341825e8ac63..9f1040eac051 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -956,6 +956,9 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 			lpi_state->entry_method = ACPI_CSTATE_INTEGER;
 			lpi_state->address = obj->integer.value;
 		} else {
+			pr_debug("Entry method of state-%d is illegal, disable it.\n",
+				 state_idx);
+			lpi_state->flags = 0;
 			continue;
 		}
 
-- 
2.33.0


