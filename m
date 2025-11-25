Return-Path: <linux-acpi+bounces-19235-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 711DAC83974
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 07:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6DE94E8D74
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 06:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC502FABE7;
	Tue, 25 Nov 2025 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="RfPfc8Dp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B22C21C7;
	Tue, 25 Nov 2025 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053544; cv=none; b=PNO7dOngrXkUM8dA54GVon3oTsmDxprRcPrtp6aT6YuYMLAye0T/XbGV1FBR/FzaWuBrJGoXJ10+Pjoxyx7XRkjeleGmakktBLUi+MeusR7Rq77R9Em2bhBoLis/C4UIJ9IwgFSKrSL972LnffFc42i8VQyGni+tCam3Sa4dnSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053544; c=relaxed/simple;
	bh=Y4986uSkO70VUb/bKs9P/E0H3k+yaQmVdnmPk8bBMRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koiUexeCPaF/8ZIQ3xdt191ONYe8MDLGe2OqrbsjQnSuglU6/jLK6zoNWaJ4I7R1R/t19mucBT9JJuZXtGUmFLRgKKdPoDoP5WT2BKp1kLnE7Rs46cHqG00KycYb5n9qBcGl1evWkC7VGBof5xaYG3p1+SKqXHJClwlRohoRxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=RfPfc8Dp; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BpwmJwKgwjilnCt+D3rfzgG+NYb8ghDGEaR2ajjjLoA=;
	b=RfPfc8Dp3WDEeBY7goMGJKL3NPsoCfdKKU3vKBRaURv9MxZmCHXuWlAxJW810gpgZrgDtkXLs
	v+WxNrkYPd9sW20F6scNlQXLYJFIS+QCguirjT5e4533kuclgMacKt0LcmjYMcci8C1DDoriI1M
	atPLTr/6YpcuYP99UM5YI+U=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dFtcm4jH1z12LCr;
	Tue, 25 Nov 2025 14:50:48 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id F1B5714027A;
	Tue, 25 Nov 2025 14:52:12 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 14:52:11 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 25 Nov 2025 14:52:10 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH 1/3] ACPI: processor: idle: Relocate and verify acpi_processor_ffh_lpi_probe
Date: Tue, 25 Nov 2025 14:52:08 +0800
Message-ID: <20251125065210.3670266-2-lihuisong@huawei.com>
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

The platform used LPI need check if the LPI support and the entry
method is valid by the acpi_processor_ffh_lpi_probe(). But the return
of acpi_processor_ffh_lpi_probe() in acpi_processor_setup_cpuidle_dev()
isn't verified by any caller.

What's more, acpi_processor_get_power_info() is a more logical place for
verifying the validity of FFH LPI than acpi_processor_setup_cpuidle_dev().
So move acpi_processor_ffh_lpi_probe() from the latter to the former and
verify its return.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5f86297c8b23..cdf86874a87a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1252,7 +1252,7 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
 
 	dev->cpu = pr->id;
 	if (pr->flags.has_lpi)
-		return acpi_processor_ffh_lpi_probe(pr->id);
+		return 0;
 
 	acpi_processor_setup_cpuidle_cx(pr, dev);
 	return 0;
@@ -1264,7 +1264,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
 
 	ret = acpi_processor_get_lpi_info(pr);
 	if (ret)
-		ret = acpi_processor_get_cstate_info(pr);
+		return acpi_processor_get_cstate_info(pr);
+
+	if (pr->flags.has_lpi) {
+		ret = acpi_processor_ffh_lpi_probe(pr->id);
+		if (ret)
+			pr_err("Processor FFH LPI state is invalid.\n");
+	}
 
 	return ret;
 }
-- 
2.33.0


