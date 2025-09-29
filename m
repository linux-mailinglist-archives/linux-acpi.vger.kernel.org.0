Return-Path: <linux-acpi+bounces-17400-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14190BA8B76
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686CC7B860C
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83CD2D063E;
	Mon, 29 Sep 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="X3fHrRgW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8112D0298;
	Mon, 29 Sep 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138693; cv=none; b=TRAXGaAmWNb8A9eBWMPcs6QjHRmkuCbkMYsWVq4mcx7plLlmNLG3EGsU0sdW3yB2rOBYeg1V1dmh7ICQaLMe+obrnrBdiTlj+MhUfiVKLwCHTYSS6T8JhcSa2D9OYMPpXlj4etbUFT+D9Wi+21D+M6CS9tM9kUU9s6HTSsD+sMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138693; c=relaxed/simple;
	bh=nRp17g1xjbnij/LqWRt+c8wZhAnlh0RnZ1ZS2TUNZ7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHsAxXgm91r0eOOEnmLp3id5AT+uYYFZE3e+ONh2PKISrfILeAroNy17Dvzo7B4cWLDXcQIjvLzTlvqPdBUiHAwy5S2DxMgkFW+864xo4RG+bkP6jqwVPS6obCilBTD1dhxlr3bN/y3VtR4DESLWzvBnNXzu/8sUzqZHpArt9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=X3fHrRgW; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cZx1406vxztTrb;
	Mon, 29 Sep 2025 17:37:12 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RTh9uqnCsbUsYKMXste5LqujrX180HMZlmUL39niJlg=;
	b=X3fHrRgW/ro90YYeDfZ1jNqFky1scUK8I/7N325IAnbFPhPxQ6xJIDZ2sOWb+BOS3mSsaMm1a
	whw2wfEeMsOUjCBn/ExxX50KZ0xdAVcQ0PxsG9gUJOyPpeQEcFFOBnqNvDMDDSno0BPXB06/dux
	a7prJtvPEu72eqwPwjC0YVk=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cZx1j36tRzLlSD;
	Mon, 29 Sep 2025 17:37:45 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id EB26D1A0188;
	Mon, 29 Sep 2025 17:37:55 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:55 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:55 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v1 1/9] ACPI: processor: idle: raise up log level when evaluate LPI failed
Date: Mon, 29 Sep 2025 17:37:46 +0800
Message-ID: <20250929093754.3998136-2-lihuisong@huawei.com>
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

According to ACPI spec, LPI package must be ACPI_TYPE_PACKAGE and
the count of package must be greater than 4. And the count contained
in package needs to be equal to the value of count field in LPI package.
All are illegal and return failure. It is better for these verification
to use error level log instead of debug so as to get detailed logs directly
when initialization fails.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 22b051b94a86..5acf12a0441f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -908,7 +908,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 	/* There must be at least 4 elements = 3 elements + 1 package */
 	if (!lpi_data || lpi_data->type != ACPI_TYPE_PACKAGE ||
 	    lpi_data->package.count < 4) {
-		pr_debug("not enough elements in _LPI\n");
+		pr_err("not enough elements in _LPI\n");
 		ret = -ENODATA;
 		goto end;
 	}
@@ -917,7 +917,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 
 	/* Validate number of power states. */
 	if (pkg_count < 1 || pkg_count != lpi_data->package.count - 3) {
-		pr_debug("count given by _LPI is not valid\n");
+		pr_err("count given by _LPI is not valid\n");
 		ret = -ENODATA;
 		goto end;
 	}
-- 
2.33.0


