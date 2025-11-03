Return-Path: <linux-acpi+bounces-18425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86322C2A9E6
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 09:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5419E18925AE
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED632E7BCE;
	Mon,  3 Nov 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="eQk8loMt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316FF2E62B9;
	Mon,  3 Nov 2025 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159379; cv=none; b=CkWXlT3zP0heZQsBXaJo1otu5l7aYZ9eFUcU8moWb/ZQlCDDVk2oIblBpMWixgIuIwBpz+RvNq/BeVP2RbfMdcMe1tNPZOeae+4JjbK20MeHjojU3VWY82Kyo+sgwbkiMTfuoq3AsywWjmENgH3ofFTpAHGUZ0tAJA36Yfmdqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159379; c=relaxed/simple;
	bh=FpI1U6+LSrImKj5yJbC3JbtvCb9JrCxDUrMJy8x2q70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfB2F2pJjiu7briKjQKAyiiih/7QxqCVGuUlGAsudOVLFVXsPN2vA6eAvs8YZnan19RbiKPUWHQX0k+u6JfrJtKaf7vgSNcljTIYD/0xaWo7tG8726tfzhXuY7FdTuvaCu2Svy2eF0IGTkGDFQ+IWPlupcGgSNWfK+21pRmb0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=eQk8loMt; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lYn04A0PNhNxpV/CFYWHsfLmTyXgv8vwZHaF7oFVV/Y=;
	b=eQk8loMtGE3Frl7BTUJivn9kSDLvaJ4OMz48g8g54CTcIKHTA/ATZ+MCEoRWqgxYS+lRbwjBU
	xkndrqX+FuPRN8aGleo7BOg2Yj/8C8dHXrUw4Q9fqx+8zmfN/ZLe65cJ67VNAnFUwNsH6CoxTpO
	BMCJtQwrB3Y04sd4txviFHI=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d0Q6H75M1z12LGF;
	Mon,  3 Nov 2025 16:41:11 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id A961D147B64;
	Mon,  3 Nov 2025 16:42:48 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:48 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:47 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v2 7/7] ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_dev to void
Date: Mon, 3 Nov 2025 16:42:44 +0800
Message-ID: <20251103084244.2654432-8-lihuisong@huawei.com>
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

Notice that the acpi_processor_setup_cpuidle_dev() don't need to
return any value because their callers don't check them anyway.
So redefine the function to void.

No intentional functional impact.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 46614cf1ae8b..2ae51c42f544 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1248,18 +1248,17 @@ static void acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
  * @pr: the ACPI processor
  * @dev : the cpuidle device
  */
-static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
-					    struct cpuidle_device *dev)
+static void acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
+					     struct cpuidle_device *dev)
 {
 	if (!pr->flags.power_setup_done || !pr->flags.power || !dev)
-		return -EINVAL;
+		return;
 
 	dev->cpu = pr->id;
 	if (pr->flags.has_lpi)
-		return 0;
+		return;
 
 	acpi_processor_setup_cpuidle_cx(pr, dev);
-	return 0;
 }
 
 static int acpi_processor_get_power_info(struct acpi_processor *pr)
-- 
2.33.0


