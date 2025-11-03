Return-Path: <linux-acpi+bounces-18424-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0320C2A9D7
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 09:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B61A3A6697
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE11F2E6CBE;
	Mon,  3 Nov 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="RcEMTawm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F222E06E6;
	Mon,  3 Nov 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159378; cv=none; b=XhPWf+iqgtVhiNIf2w4kqdOQkMGiToRXGV8yxQUyGFiT8nY58folijGESkQ0B6Oc1ADaIhtnL9mrWpxJqcPjGVq/yapTZdrggGi9dsPbbAdWpPjuqJYNXZJULuTDpm+UdcWq9OzUTDQESCJaY9amR2x2wVSc6MCvAW35GZAH7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159378; c=relaxed/simple;
	bh=u3S0YqaPiukq1MO5JyFqnxDlliPYd2O+Vs6ceRh+qgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaRaUli8J4oobLLY/ZimaxRTVKCXzVjbo9IeG0AET82kpnuibY5/BWIWaFsGJCQsz268Panp/yJ7/Ih0/iq2VOy1QV7L44NruYuVVn61IXb4e8sAdaL/vFeke8Ad601KT0+/lLIcUiBtp4OjKNv3qZjf3a3FzGTpEAOdC54fETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=RcEMTawm; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k6HdZuklKtItzJNpeBo5TkJT3OTYEJ2G6Mws+jU0bsU=;
	b=RcEMTawmurRjTFGW5IK4lRaEwSZvdGReCM7vRJMhlcokYTTt6uN28BIi6QmpeoUP0BRnD8VNY
	AhRALEzOgwhqipf4YlPkS2p8MU2n6m+7k4qgul2cvr7LFQ80vhcCqSrbB+cxQjCU4Yfbz2POGXP
	TmYVEz+1uZOdRQ31BfDuC60=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d0Q6M49krz1K9Vy;
	Mon,  3 Nov 2025 16:41:15 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E7E35140277;
	Mon,  3 Nov 2025 16:42:47 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:47 +0800
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
Subject: [PATCH v2 5/7] ACPI: processor: idle: Remove useless codes about the verification of cstate count
Date: Mon, 3 Nov 2025 16:42:42 +0800
Message-ID: <20251103084244.2654432-6-lihuisong@huawei.com>
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

The acpi_processor_setup_cstates and acpi_processor_setup_cpuidle_cx will
be called after successfully obtaining the power information. These setup
functions have their own main role, but also verify the validity of cstate
count.

Actually, the acpi_processor_get_power_info_cst will return failure if the
cstate count is zero and acpi_processor_get_power_info will return failure.

So the verification of cstate count in these functions are useless.

No intentional functional impact.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4627b00257e6..1f332f02d273 100644
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
@@ -1248,7 +1238,8 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 	if (pr->flags.has_lpi)
 		return acpi_processor_setup_lpi_states(pr);
 
-	return acpi_processor_setup_cstates(pr);
+	acpi_processor_setup_cstates(pr);
+	return 0;
 }
 
 /**
@@ -1268,7 +1259,8 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
 	if (pr->flags.has_lpi)
 		return 0;
 
-	return acpi_processor_setup_cpuidle_cx(pr, dev);
+	acpi_processor_setup_cpuidle_cx(pr, dev);
+	return 0;
 }
 
 static int acpi_processor_get_power_info(struct acpi_processor *pr)
-- 
2.33.0


