Return-Path: <linux-acpi+bounces-18529-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4410FC34E7F
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 10:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5532A4F3A92
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC382FE584;
	Wed,  5 Nov 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="dOb1GiqP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A742FDC49;
	Wed,  5 Nov 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335419; cv=none; b=fzgHpDtYUSt0QoseZNdxBsVGpEMA7iZ5IKBKKghpfEPjhHJZ1KgRqkndmK9T1Q+53wE0Z6Zi62f6ES/n3WZBlidfCZ5hctNRAog0FVAkgKAyQrAbKwoW9xhg2AnaQNyouSNK7x+qsldfSao6aT0IIbHdYQIAhI97oiCZfGB4ERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335419; c=relaxed/simple;
	bh=WkNwxOmVHunca/CPwSbsQlkfV5vLETX0Pq9aqTANTIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0Uv9xPRqHO8iMXagyk45gxt7EB6DJ22YtuHLzd5xMYqbLwxLQ3a01uaJWLrDaMHwyREW1DncqdXzs+aMQ/RgDXCWSo5wANFOZvp9G1iD1Md87wYxYUFLGt9SftIgwd3p7DCxlAE4WYaV1X4zLMT50/fLrnSgKAViBHSdgyZBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=dOb1GiqP; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Hap/jbJjIkWJVkUV8jOZ8XG03gN3kTQaTImYf5IdjoM=;
	b=dOb1GiqPEMZAN5xCJZPQQXpKZTnfYMf/xnB88c134KFeb5GumXrA+H0k5luT+jI42UpTgsJUq
	XxymePEs+VSzDrXa8hKnmIFR3y4uB/O0emLlJD7qKm8ZRa5walQhtryNe0xvmSVDe/6Q+LPEU8T
	e7+R5DTsSvU2YQb/fHBZTnM=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d1gCj6N5XzLlSM;
	Wed,  5 Nov 2025 17:35:13 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C1B8E18001B;
	Wed,  5 Nov 2025 17:36:48 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 17:36:48 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 17:36:48 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH] ACPI: processor: idle: Remove useless codes about the verification of cstate count
Date: Wed, 5 Nov 2025 17:36:47 +0800
Message-ID: <20251105093647.3557248-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
index 341825e8ac63..22909fccf0b1 100644
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
@@ -1241,7 +1231,8 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 	if (pr->flags.has_lpi)
 		return acpi_processor_setup_lpi_states(pr);
 
-	return acpi_processor_setup_cstates(pr);
+	acpi_processor_setup_cstates(pr);
+	return 0;
 }
 
 /**
@@ -1261,7 +1252,8 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
 	if (pr->flags.has_lpi)
 		return acpi_processor_ffh_lpi_probe(pr->id);
 
-	return acpi_processor_setup_cpuidle_cx(pr, dev);
+	acpi_processor_setup_cpuidle_cx(pr, dev);
+	return 0;
 }
 
 static int acpi_processor_get_power_info(struct acpi_processor *pr)
-- 
2.33.0


