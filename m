Return-Path: <linux-acpi+bounces-18422-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37EC2A9BF
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 09:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1143A777B
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9980B2E5B2A;
	Mon,  3 Nov 2025 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="gAJ391/P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9AB2E426B;
	Mon,  3 Nov 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159377; cv=none; b=Xpu/7n1i3dtgKa+e1rxfyQsPzgjPyVanzcsi5MfU3NJiAxzQMEriRq2n+v3aN/L/FI2p8IS5NlkjK959VA7t9s+5oT51kKd8DqoqQdd2sUR7ufoWwTgvEqNAcHBfaEhb/pzy0Eu1mHQmfIhVhYOn24bVg8MNXQ2NZncTlGPS1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159377; c=relaxed/simple;
	bh=SrTU/8kb4iQzJ+XiiFzJWXGiLT6UPjVKBLZwQajTtqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpsrCBw3ES/2MhuSecMpqj+nSSbgY/ac0Onfowrb+NYiRa9r+cbVF7IO0WUqMnFBY1Tdi7A5zD78VcJZzn4ACFZ0CLu+rAvFGyaj/Uv5NzxlxgnsuViHpavFRxp4IURV3C2ZceV25jInk+FD4lu9jSZ/VKs4nzMw19gu/PRsku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=gAJ391/P; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oFzlct61x2Y7EyyS5RO9ssZbpkuYYkewIZ1by74biZc=;
	b=gAJ391/PYfmFMlT/dhFaZWPPSyRXKtnX9vxVBFhkTJOOv+JuDxTxSNxpxpNGe4RnAtNaL5uUj
	3GMv2R+XATGFaiGEMsDgAoE9z2Jr+CQ993obkPvG++ggM00v3dXQ8bZoLwoQ/UH6wwz0cCQQ/3D
	3cUqtHhOSQszNJfWY+0xKYA=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d0Q6G5pvYz12LJp;
	Mon,  3 Nov 2025 16:41:10 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 76BA5180080;
	Mon,  3 Nov 2025 16:42:47 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:47 +0800
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
Subject: [PATCH v2 4/7] ACPI: processor: idle: Disable ACPI idle if get power information failed in power notify
Date: Mon, 3 Nov 2025 16:42:41 +0800
Message-ID: <20251103084244.2654432-5-lihuisong@huawei.com>
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

The old states may not be usable any more if get power information
failed in power notify. The ACPI idle should be disabled entirely.

Fixes: f427e5f1cf75 ("ACPI / processor: Get power info before updating the C-states")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index c73df5933691..4627b00257e6 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1317,6 +1317,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 	int cpu;
 	struct acpi_processor *_pr;
 	struct cpuidle_device *dev;
+	int ret = 0;
 
 	if (disabled_by_idle_boot_param())
 		return 0;
@@ -1345,8 +1346,18 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 			cpuidle_disable_device(dev);
 		}
 
-		/* Populate Updated C-state information */
-		acpi_processor_get_power_info(pr);
+		/*
+		 * Populate Updated C-state information
+		 * The same idle state is used for all CPUs, cpuidle of all CPUs
+		 * should be disabled.
+		 */
+		ret = acpi_processor_get_power_info(pr);
+		if (ret) {
+			pr_err("Get processor-%u power information failed, disable cpuidle of all CPUs\n",
+			       pr->id);
+			goto release_lock;
+		}
+
 		acpi_processor_setup_cpuidle_states(pr);
 
 		/* Enable all cpuidle devices */
@@ -1354,18 +1365,19 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
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
 			}
 		}
+release_lock:
 		cpuidle_resume_and_unlock();
 		cpus_read_unlock();
 	}
 
-	return 0;
+	return ret;
 }
 
 void acpi_processor_register_idle_driver(void)
-- 
2.33.0


