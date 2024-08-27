Return-Path: <linux-acpi+bounces-7867-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62CD96073E
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 12:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521D71F23969
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 10:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2146D19CCED;
	Tue, 27 Aug 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="A7dVKZS7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0719B5BD;
	Tue, 27 Aug 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753782; cv=none; b=iREQ8dzXeuyL3UgCDjFKGmymdQuP8hEWnsm1JbDT7xSotLcygG5O6KyHORK8pkUok86TN18Zp/Rsm/UFwK93YybMzyYoz6ykNh5ZtCI1YSkOIn95Q6DDmET2Inj1pddvJak3k/Vzo27yywBeMNwDKClXDoLG4ra3OexOG5W6dXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753782; c=relaxed/simple;
	bh=R4ZcETLHOcjxkaOMGG2oTsofi0bsTHLpm/fSPdmsWNo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W3z0N2vvKke8KSX3KLx+1ExBl1Aa7liaE24xO2CgKrL5r5ZzajH6r5RAr7HDX3Lu4RFWEZiAVmK5T5mTZtUATvNALaQry+s+0hCEYemAZRsictvX1R64MWi+A6hdrjb9me4ZqvsToT93N/62EKQ8HK57clyd2scW0TeLKARiU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=A7dVKZS7; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id E490C100004;
	Tue, 27 Aug 2024 13:15:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1724753757; bh=QSOzToFe3VsIvYXRK9kk0KZjv46qYSFsNGD5tA0zwBE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=A7dVKZS7+2yVR/bzZe4RLJa0zF2t2fBDuwO9fTxxYQBWscv18dnZaNNHry3E4FqdG
	 uTtdXyx7H3CpUK2qwdt3gi/IjXovFDme97KK5tBsLbPMR/wR+XFVdkhabjIA3qs1AP
	 cMB8jDF1ygqiVlfJ8qxyq8ww13Kcb2cEV9NiuwCAfIN/VcXdfMMomEPU7T9edj6fQu
	 nXDZrrJbLUAPHjIlW1GBBm5s6eYgopsEdQM/80pdyRCsYjDoEXL93zFLWyE079cV2i
	 9OWBbJL8TTDib4NioRIuw+Zrqy8zp2wYwv/+QR11n07AV5eglEGq/tnYwXp3tH8VAr
	 051jD1hxUOQXw==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 27 Aug 2024 13:13:16 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 13:12:55 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Fu Wei <fu.wei@linaro.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] acpi/arm64: Adjust error handling procedure in gtdt_parse_timer_block()
Date: Tue, 27 Aug 2024 13:12:39 +0300
Message-ID: <20240827101239.22020-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187358 [Aug 27 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/27 07:21:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/08/27 08:02:00 #26443905
X-KSMG-AntiVirus-Status: Clean, skipped

In case of error in gtdt_parse_timer_block() invalid 'gtdt_frame'
will be used in 'do {} while (i-- >= 0 && gtdt_frame--);' statement block
because do{} block will be executed even if 'i == 0'.

Adjust error handling procedure by replacing 'i-- >= 0' with 'i-- > 0'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a712c3ed9b8a ("acpi/arm64: Add memory-mapped timer support in GTDT driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/acpi/arm64/gtdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index c0e77c1c8e09..eb6c2d360387 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -283,7 +283,7 @@ static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
 		if (frame->virt_irq > 0)
 			acpi_unregister_gsi(gtdt_frame->virtual_timer_interrupt);
 		frame->virt_irq = 0;
-	} while (i-- >= 0 && gtdt_frame--);
+	} while (i-- > 0 && gtdt_frame--);
 
 	return -EINVAL;
 }
-- 
2.30.2


