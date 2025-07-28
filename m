Return-Path: <linux-acpi+bounces-15333-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF5B13550
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51F8174F11
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 07:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE57221FD2;
	Mon, 28 Jul 2025 07:06:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3A220F5A;
	Mon, 28 Jul 2025 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686380; cv=none; b=a8t8EdNq0VTTAjWTIImHtbHbm9jyIvGF54kBlxAscfFirkQjnvmNsY/4fC0avWbsjdq7nruJqu4++DPdkAMznR/jWWp3ZrdM3wXZnq5hxWBWx33QX9qVcrwNTLUrflwYmbRLsrtMpvkMTuba4TcKrywfS6c85aN+9w0A7GgX8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686380; c=relaxed/simple;
	bh=84NdIQM9I08cUMS6JZR6UxDUpM8LmBSzPTZgAWeHlkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdrPB/7jZZ82twGHKUYnWfd5o4X2xQwas24IhdJdZnUjdvknU9VjmLnS8qUFdPZPcsI/DlxTuvZ8l0Oa4rIlhEHcRbjbRekYndsmRNoK1ANUS0ddFhFBPbSKvC8XOoc9rFuR7YE29zT/v6fhviMmBP1D7CFmTs1nRlRsX8V6zuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4br8bG70Flz2RW0v;
	Mon, 28 Jul 2025 15:03:54 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 90848140276;
	Mon, 28 Jul 2025 15:06:14 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 15:06:14 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 15:06:13 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v3 1/2] ACPI: processor: idle: Fix memory leak when register cpuidle device failed
Date: Mon, 28 Jul 2025 15:06:11 +0800
Message-ID: <20250728070612.1260859-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250728070612.1260859-1-lihuisong@huawei.com>
References: <20250728070612.1260859-1-lihuisong@huawei.com>
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

The cpuidle device's memory has been leaked when register cpuidle
device failed in acpi_processor_power_init().

Fixes: 3d339dcbb56d ("cpuidle / ACPI : move cpuidle_device field out of the acpi_processor_power structure")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2c2dc559e0f8..031738390f2d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1405,6 +1405,8 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 		if (retval) {
 			if (acpi_processor_registered == 0)
 				cpuidle_unregister_driver(&acpi_idle_driver);
+			kfree(dev);
+			per_cpu(acpi_cpuidle_device, pr->id) = NULL;
 			return retval;
 		}
 		acpi_processor_registered++;
-- 
2.33.0


