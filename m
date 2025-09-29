Return-Path: <linux-acpi+bounces-17405-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D9BA8AF0
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32FF189EC7A
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46772D47F6;
	Mon, 29 Sep 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="mrzoYxo5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C02D3A80;
	Mon, 29 Sep 2025 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138698; cv=none; b=Ox1m6gNA//6+DpwuIBg9B00LGF4mH7XcZ1Lnpgz1HN1KX/c/mdAh+MIPeIF/9lg4aYFHpXwxhaXt5uWj6GguWqpYdsSCewmHEKD6yP+zw14Bdh65YFaYV1wyL0mV2bJYTNd4V47dgCEFv7dJoRJMq6Da521N/soD+M2Ehc+GxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138698; c=relaxed/simple;
	bh=s9pgRD/nvyiC3pYMU/ZclMD5eVITzp/+oj2PQPt/mpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReFJz0r1dCBe8f4USroe+45ylO4V4ASdMQdKbZO4tBczLvLkhoc0sz1ucCG9dc53dLANLWoJ3UDYwEevqoCS1oCrXUVBUZ90VMB3GoxQAhScmuc4fe23emA+AEqWwATz3aW1IORmepjMUkGIH+vrRQqGBnvPIVo5JNnkCMFoq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=mrzoYxo5; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from canpmsgout11.his.huawei.com (unknown [172.19.92.148])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cZx1j0cHGzvXFJ;
	Mon, 29 Sep 2025 17:37:45 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9hK46zEIfo+lO5v1S04j0fHnzaTj1dMCptjN/v2+PDI=;
	b=mrzoYxo5XHsOZuAxjCg1+uA8m4Hx5Dt3Y382K0huJE4O+9PwA9ABrbRPcCyu9FaiivgLTtrwE
	xn/7fHwny7CAa3DE2ATl/JEw75EMT7DDHgEiFQfYKOJO/XlvzIV5///PYKkj2VU0yLewt8GiI9+
	GyrXMX0R7Mv+Qwfdyr/gzyI=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZx1m2gZRzKm6W;
	Mon, 29 Sep 2025 17:37:48 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C0A471A016C;
	Mon, 29 Sep 2025 17:37:58 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:58 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:57 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v1 7/9] ACPI: processor: idle: Remove died codes about the verification of cstate count
Date: Mon, 29 Sep 2025 17:37:52 +0800
Message-ID: <20250929093754.3998136-8-lihuisong@huawei.com>
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

The acpi_processor_setup_cstates and acpi_processor_setup_cpuidle_cx will
be called after successfully obtaining the power information. These setup
functions have their own main role, but also verify the validity of cstate
count.

Actually, the acpi_processor_get_power_info_cst() will return failure
if the cstate count is zero and acpi_processor_get_power_info() will return
failure.

So the verification of cstate count in these functions are died code.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 92b231f5d514..2d672afc7498 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -732,8 +732,8 @@ static int __cpuidle acpi_idle_enter_s2idle(struct cpuidle_device *dev,
 	return 0;
 }
 
-static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
-					   struct cpuidle_device *dev)
+static void acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
+					    struct cpuidle_device *dev)
 {
 	int i, count = ACPI_IDLE_STATE_START;
 	struct acpi_processor_cx *cx;
@@ -753,14 +753,9 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 		if (count == CPUIDLE_STATE_MAX)
 			break;
 	}
-
-	if (!count)
-		return -EINVAL;
-
-	return 0;
 }
 
-static int acpi_processor_setup_cstates(struct acpi_processor *pr)
+static void acpi_processor_setup_cstates(struct acpi_processor *pr)
 {
 	int i, count;
 	struct acpi_processor_cx *cx;
@@ -822,11 +817,6 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 	}
 
 	drv->state_count = count;
-
-	if (!count)
-		return -EINVAL;
-
-	return 0;
 }
 
 static inline void acpi_processor_cstate_first_run_checks(void)
@@ -1246,7 +1236,8 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 	if (pr->flags.has_lpi)
 		return acpi_processor_setup_lpi_states(pr);
 
-	return acpi_processor_setup_cstates(pr);
+	acpi_processor_setup_cstates(pr);
+	return 0;
 }
 
 /**
@@ -1266,7 +1257,8 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
 	if (pr->flags.has_lpi)
 		return 0;
 
-	return acpi_processor_setup_cpuidle_cx(pr, dev);
+	acpi_processor_setup_cpuidle_cx(pr, dev);
+	return 0;
 }
 
 static int acpi_processor_get_power_info(struct acpi_processor *pr)
-- 
2.33.0


