Return-Path: <linux-acpi+bounces-19533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2E3CB3042
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D908300DB8C
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112EB3254BB;
	Wed, 10 Dec 2025 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JltCuw+I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62A3254BA;
	Wed, 10 Dec 2025 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373207; cv=none; b=oYR88N/cAAU9rNsKG59E3EVJAaEt3MRmCQDDRIFd9vrFvlNlQ+X7ihHHUjtlU3AZTbveo6H+46GWeZmPNb4V4xDveCnKD0cyFqENg9WS/f9a94/cSnCfMznDGzHRoZF5tF1dz5Q54pQ7brPsQeOuLh48LfAm8qPtKxcjVoLU4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373207; c=relaxed/simple;
	bh=r4gsqwZeNsCvXZ0qw2hbCRPPOpbJOBBA6uOI0/B4YVM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uzQ9ayPri9ZWE93YaH8VZ7dRqy3O43dhEJZSfDZfM70HzfHL+4LrjE+ovpub+ZMOtkLtbY9HwSxQSxs0IW3+R6MTsp4m8YXsZTn2DgNta9hShwN7XKR5dCFH7amJmfOlAMg83+cq8YrFp8ZYNFwDVGSFd5CScZklZes8VEY9eUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JltCuw+I; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oWHRR2N5r76SY9DM7LcCcKhHeNPzrI/tPRfSgEXGeCo=;
	b=JltCuw+IY8xBIj7vyNHJrZIJteHIlyMu3+n68tbv+GvwQI7+NsWjEMHChuRJFVltQRAztcYU2
	Wedh+CaAe6t4putvqDXYY7iZa1QJ5ynKOuRGd19msABTgHpHV63gJQPpaCAE3dQj5uxZt31d7GC
	dkR9w4K8mGasc5vywcJ9kh8=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dRGfG2wPYz1cySV;
	Wed, 10 Dec 2025 21:24:38 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 43B65140142;
	Wed, 10 Dec 2025 21:26:35 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Dec
 2025 21:26:34 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <lihuisong@huawei.com>, <sudeep.holla@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
Subject: [PATCH] ACPI: PCC: Fix race condition by removing static qualifier
Date: Wed, 10 Dec 2025 21:26:34 +0800
Message-ID: <20251210132634.2050033-1-zhangpengjie2@huawei.com>
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

The variable 'ret' in acpi_pcc_address_space_setup() is currently
declared with the 'static' storage specifier. This can lead to race
conditions in a multithreaded environment.

Remove the 'static' qualifier to ensure 'ret' is allocated directly
on the stack as a local variable.

Fixes: a10b1c99e2dc ("ACPI: PCC: Setup PCC Opregion handler only if platform interrupt is available")
Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/acpi/acpi_pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 97064e943768..e3f302b9dee5 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -52,7 +52,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 	struct pcc_data *data;
 	struct acpi_pcc_info *ctx = handler_context;
 	struct pcc_mbox_chan *pcc_chan;
-	static acpi_status ret;
+	acpi_status ret;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-- 
2.33.0


