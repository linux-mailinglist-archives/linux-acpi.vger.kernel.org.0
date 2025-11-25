Return-Path: <linux-acpi+bounces-19232-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C24C83956
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 07:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CB1534D23E
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4822C326F;
	Tue, 25 Nov 2025 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="mTKv4s4M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049682C15BC;
	Tue, 25 Nov 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053538; cv=none; b=cf+gKYZyaRVxjdzKa1MxdrYjpOCzQU9PoDGaesJ8l274WpPdptYJ+ngCh9dlmZQLge8ZvAZMRkWlz3ASpff+7uv+a3qrLQX+Z5GBMibAuQ5QX8RSrtp8R6YpOUk+8TIrJAwO7nAfNyY6NV80k7VW4/kvkISPkgDVCQ0/f/7unFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053538; c=relaxed/simple;
	bh=B7eIWZ0Vi5QPTUPLso5aARqPsgT6mO+S+j76mX/yPfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps/ciDKIYhRLnaHYta2AiOdBH28Q8Gfe/HAf+PXqqcTuEEPq/ZoAlt9gDc9bhOPk+S15T+zv4/XKUEAUuB9/EBIhBVxPqhTlHkchsBoYuPNFOI+mJnW0QE4j0p4GSqqL6UEgvyONQZEOL0dt8mzMqFF5M3RkYrsmQwkAKhw1KKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=mTKv4s4M; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wOortYuY6DV1U7dDZftsCYS9EeGP8NK9wfPNEvENjig=;
	b=mTKv4s4MFHi3qmwwFCjIkMSiy3wPt26C6rKgp9OIZO69XMEDOBVvXxwwo05zP0Ofi2eqSxf35
	jji9adNStxxTtzZdmHKu2B2nh4F1LCHHesKkdc2wTszWTXz8oRHQxhK8T4IV5JxLf5joo/8tYPd
	571pMjLoedNugdfk/D5HiK0=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dFtby6QqtzpTRf;
	Tue, 25 Nov 2025 14:50:06 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DA4F14027D;
	Tue, 25 Nov 2025 14:52:12 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 14:52:12 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 25 Nov 2025 14:52:11 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH 2/3] ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_dev to void
Date: Tue, 25 Nov 2025 14:52:09 +0800
Message-ID: <20251125065210.3670266-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251125065210.3670266-1-lihuisong@huawei.com>
References: <20251125065210.3670266-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Notice that the acpi_processor_setup_cpuidle_dev() don't need to
return any value because their callers don't check them anyway
and the function doesn't fail to execute.
So redefine the function to void.

No intentional functional impact.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index cdf86874a87a..2804fa91c1ec 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1244,18 +1244,17 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
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


