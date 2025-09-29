Return-Path: <linux-acpi+bounces-17399-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C504BA8B7C
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E5A17B85C0
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18102D0629;
	Mon, 29 Sep 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="eLvwV85r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936B2D0608;
	Mon, 29 Sep 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138693; cv=none; b=h4hycMLG2rc1hfqW4DqMQaeAQv3O0sG0z+/oE/Puxjhfdop6JufSbhxHSsO9jKiYofuZKOc7pvtC7X2ko1LBcpnMu7QP6IDeMeiSX4cvxNZFjLF6A+XTPRJGyld7suuxPfjK6lYmxVN9qZg2r0ZOn31Gk07BC8yomGPPbvFxGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138693; c=relaxed/simple;
	bh=zFOGrE/CYGwsYYDxIIzhVvqiouFsHkdPFeW73i51xdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxwT/qR01DCXiHy67bue6/VRmztebcmTtdl5y5ac7sTUkSdFWkYbrcpLtGObQW49i/4fvIrr8evb2NiasXuScBNAuxF0/kxWKOwJ/Q9gVaXdz1xiOq0AcBASXQHhkpY9dEmATYtNn/DIXtBL49l0xoNc23gag14tEcVN2YarUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=eLvwV85r; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cZx1B1418ztTsd;
	Mon, 29 Sep 2025 17:37:18 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rxoQ4li/dhzz7C7GNyqjThebbNS6Z9DLrv4WnFBVJxE=;
	b=eLvwV85r7/Cg3cS6yGcXSBVav1los6s18AXMlK1k5mB18LqCauQYbs2IIMm/qjJYKYnWxj+QL
	IPkjqBrr36F8Xz2WCTR6Kzh6mksMZ24mW4cmyfCGsY3EjHdlt1q+2v6MorVh7yPmtE3VUOz5oF8
	R0COosYACcshfdbdSA24TeY=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cZx1q2JyFzLlSk;
	Mon, 29 Sep 2025 17:37:51 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id CE0941800D0;
	Mon, 29 Sep 2025 17:38:01 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:59 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:58 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v1 9/9] ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_dev to void
Date: Mon, 29 Sep 2025 17:37:54 +0800
Message-ID: <20250929093754.3998136-10-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250929093754.3998136-1-lihuisong@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
index 9f456a6fa584..1c9f2911ef6c 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1246,18 +1246,17 @@ static void acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
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


