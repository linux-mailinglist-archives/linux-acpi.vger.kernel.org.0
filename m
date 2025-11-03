Return-Path: <linux-acpi+bounces-18423-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37E5C2A9DD
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 09:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664041890743
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C97B2E62DC;
	Mon,  3 Nov 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="oAFcVA2t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29A2E1C64;
	Mon,  3 Nov 2025 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159378; cv=none; b=lLrvpsy1vDW3FJWoVPdU+Wmf0Uvb6KHBtPolDdEElxss2k94nmq8yutmEkSUTqGZ8E/7JQqhS/839hcshMrP7Bq8dDvWw0byCUSHzlEaDKs6GdiLQX6786FaTNLs7xgbAPl8oBoxrkzJvgAM9I2MvqMHV88kgM7uOjbqTvx4tVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159378; c=relaxed/simple;
	bh=LYgldWbWOanLHXis0kehus6JhqHIHKJNZrxXSi7e1Jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THJK5LDL27Hr9b+D3bOG8aJ6JmT/YZtNxnSun3qtrvMw38lm2GNfX2FJaVaKeX4NJKNF58kEjPFbR4qvE9byJEd6duSPEseZ1io9yMcNVrbhz0ZG5m/ti9Y0XTzdzSO+C6SW3RVJoBDfJrqITrnkM8vom5JG55acqjMppMZug5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=oAFcVA2t; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=079+V7X5gZkn1b6Q2N26Tvjw+scW8RqMFN0AFmVQDCs=;
	b=oAFcVA2tm/AfSDmY9JNBEv2q6dJzTk2PxcCXK0vn7/2XONb7tetaUY/1bFo/zOJRYILETOr6W
	nGF3wXBKdwAOJMIuVODhXHliwgpcPLg+CLejPr4qA2j5AFw8EDXEzLK7Z6nF5RonzIURtap9V1s
	1I53SYUkFhOCZPGCd0JhUpI=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d0Q6J3R9zz1prLb;
	Mon,  3 Nov 2025 16:41:12 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 139FA1402C1;
	Mon,  3 Nov 2025 16:42:47 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:46 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:46 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v2 3/7] ACPI: processor: idle: Relocate and verify acpi_processor_ffh_lpi_probe
Date: Mon, 3 Nov 2025 16:42:40 +0800
Message-ID: <20251103084244.2654432-4-lihuisong@huawei.com>
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

The platform used LPI need check if the LPI support and the entry
method is valid by the acpi_processor_ffh_lpi_probe(). But the return
of acpi_processor_ffh_lpi_probe() in acpi_processor_setup_cpuidle_dev()
isn't verified by any caller.

What's more, acpi_processor_get_power_info() is a more logical place for
verifying the validity of FFH LPI than acpi_processor_setup_cpuidle_dev().
So move acpi_processor_ffh_lpi_probe() from the latter to the former and
verify its return.

Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5213a545fa78..c73df5933691 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1266,7 +1266,7 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
 
 	dev->cpu = pr->id;
 	if (pr->flags.has_lpi)
-		return acpi_processor_ffh_lpi_probe(pr->id);
+		return 0;
 
 	return acpi_processor_setup_cpuidle_cx(pr, dev);
 }
@@ -1277,7 +1277,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
 
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


