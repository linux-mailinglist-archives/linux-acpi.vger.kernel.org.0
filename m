Return-Path: <linux-acpi+bounces-17396-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2664BA8A9E
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A27D34E1436
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F14E2C235C;
	Mon, 29 Sep 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="E0KCWgMf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B882C15BF;
	Mon, 29 Sep 2025 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138688; cv=none; b=SnRlNFZTKWNbWWewp4oT5rF5bkIV2zj+nxTIMpi5UPUg9LS1XQeHvj/oO3N9OTbmAUxqyna7A4WjjLf/BTpUdo1/EfeR8MBjPetG06QVOY6GfcD5pTPhfIiBz+PZ28jXP1C59Vz8I3km87EG+UdPjyuHKxRuItygtGVUiDp80ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138688; c=relaxed/simple;
	bh=PCn+2NpYXNrTtMrEmgk/+v6MC0n2XLP6X3PNqVhZut0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzPeki9i03ASHi3dcbZahmjsfFfwtmKjPz404/VawDnrAdsqv9+wcrABmgbzS9nMf/OUvTLO8pr/x+yJkwo6g7LLbVH8Jsx5OLXvgCmLR9o2RxHm6xzIxNe8kLtI1gvEz5YlIcLXUTBA0EqlL/FRClLbK6kwhR3RnzRyLWFZias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=E0KCWgMf; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8dVWRgn/1PPWXrvTyzsdcit7ANql16CIpeq1DEA+YKo=;
	b=E0KCWgMfC3GiaFCah31QN2vXY6uWZDnp4VUO7MUz8SRnRUlBNvo7lmWAHZJjQNk2EmCuYekqu
	Vkhi3H7ZCQovMl19oRRpfG0sgxJEhzmV6XliJHoGZ/9VBoIXBSgmO2HL5xLf+dSThokAgAm7GEf
	sTZ/w/hpZ3aaLZbQva/gz1I=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cZx1W3R3lz1T4Fq;
	Mon, 29 Sep 2025 17:37:35 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id DF5D41800B1;
	Mon, 29 Sep 2025 17:37:57 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:57 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:56 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v1 5/9] ACPI: processor: idle: Add the verification of processor FFH LPI state
Date: Mon, 29 Sep 2025 17:37:50 +0800
Message-ID: <20250929093754.3998136-6-lihuisong@huawei.com>
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

Both ARM64 and RISCV architecture would validate Entry Method of LPI
state and SBI HSM or PSCI cpu suspend. Driver should return failure
if FFH of LPI state are not ok.

Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5684925338b3..b0d6b51ee363 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1264,7 +1264,7 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
 
 	dev->cpu = pr->id;
 	if (pr->flags.has_lpi)
-		return acpi_processor_ffh_lpi_probe(pr->id);
+		return 0;
 
 	return acpi_processor_setup_cpuidle_cx(pr, dev);
 }
@@ -1275,7 +1275,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
 
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


