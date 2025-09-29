Return-Path: <linux-acpi+bounces-17398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A6BA8ABC
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A96F16EA2A
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AEC28CF77;
	Mon, 29 Sep 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="G5ZzCj2y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04A2C3272;
	Mon, 29 Sep 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138692; cv=none; b=OowUTBYVjSAAdRxymaF91di9ALzx+y9b9Bn4uqFtDfoEMK9uB0dgaR7Sq+mvjcLcFQ+FwNoJe7PuxFUuBobvlDGDvBaHgx2nsTQeqL327jFnacXDOlK1dgu8DIJiLm0gdqo4tx3NY932m2aVrLjNRGVqs/al2VPOulbuRzLBYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138692; c=relaxed/simple;
	bh=tubl72UhDrFHQVJsm/Yz9qp/H+Ga2SHiF+48nRsljmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f23j+h3eLirqEdagZJT/I1/xNB0Te1XDqPUlTEYzVVl+TA47vLolLlv3EWoj+HToTM0cz0ZtUm5hzQXqkxDEMOp7YuehNjmpsPB8aFFo+IkQgBQfDkWsGe4dIJtUYujesePiuxB2qG1WrA1lFE5EyFX5z2sSY2Ghii2DVuvw9U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=G5ZzCj2y; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tNDOWXHGWI4bT/ATvsza4bIqskro5wdK9eUa6kqQ8n4=;
	b=G5ZzCj2yANq6y40ZHll+Q18smpMQAysWPMm6YZxIeSeZ0V5MUNdGtMFba+XibdE0OWDbkxV4u
	VSHc1AW9mpnDzK9UJorlxSoxyOjpspDp6cET4fQJ5Ueo3RPAUFWRbONstCK2Sv4TrpaoGWAGX94
	NHnmafIaZRKy0SMXmN/RQDg=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cZx1q2QbQzmVl6;
	Mon, 29 Sep 2025 17:37:51 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id C76F01800CF;
	Mon, 29 Sep 2025 17:38:01 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
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
Subject: [PATCH v1 6/9] ACPI: processor: idle: Do not change power states if get power info failed
Date: Mon, 29 Sep 2025 17:37:51 +0800
Message-ID: <20250929093754.3998136-7-lihuisong@huawei.com>
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

Driver will update power states when processor power states have been
changed. To prevent any other abnormal issues, here add the verification
for the result of getting power information, don't change power states
and one error log when get power information failed.

Fixes: f427e5f1cf75 ("ACPI / processor: Get power info before updating the C-states")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index b0d6b51ee363..92b231f5d514 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1315,6 +1315,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 	int cpu;
 	struct acpi_processor *_pr;
 	struct cpuidle_device *dev;
+	int ret = 0;
 
 	if (disabled_by_idle_boot_param())
 		return 0;
@@ -1344,16 +1345,20 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 		}
 
 		/* Populate Updated C-state information */
-		acpi_processor_get_power_info(pr);
-		acpi_processor_setup_cpuidle_states(pr);
+		ret = acpi_processor_get_power_info(pr);
+		if (ret)
+			pr_err("Get processor-%u power information failed.\n",
+			       pr->id);
+		else
+			acpi_processor_setup_cpuidle_states(pr);
 
 		/* Enable all cpuidle devices */
 		for_each_online_cpu(cpu) {
 			_pr = per_cpu(processors, cpu);
 			if (!_pr || !_pr->flags.power_setup_done)
 				continue;
-			acpi_processor_get_power_info(_pr);
-			if (_pr->flags.power) {
+			ret = acpi_processor_get_power_info(_pr);
+			if (!ret && _pr->flags.power) {
 				dev = per_cpu(acpi_cpuidle_device, cpu);
 				acpi_processor_setup_cpuidle_dev(_pr, dev);
 				cpuidle_enable_device(dev);
@@ -1363,7 +1368,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 		cpus_read_unlock();
 	}
 
-	return 0;
+	return ret;
 }
 
 void acpi_processor_register_idle_driver(void)
-- 
2.33.0


