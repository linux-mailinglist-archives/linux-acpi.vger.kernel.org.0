Return-Path: <linux-acpi+bounces-6775-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFA792880B
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 13:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE3A283D8F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 11:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6E149C51;
	Fri,  5 Jul 2024 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="OCjZowWY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206411482F3;
	Fri,  5 Jul 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179388; cv=none; b=Bt0/r5TX0Gizh2QNd4AdXXQhaH24UpBInqkF8CJ1QR6MaexuCD47z+6Lj0Lmde3vpWS3k0f/u+IIJbE9PMybNT92Un7JiCEOSZeIqn9CqLR5UYN3xlX1YUKHnx1r4I2bi5g4eNp1ldvi1UaHPdk9aee7IZgqmM6ppcZh082MK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179388; c=relaxed/simple;
	bh=aA6UMx8bvIXjhEaoc3nKBlWMNp5+O3VwjJAQjwXbQ20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uc+FHRIHp5ymO8eX7WdGGmy0KyiTVSnQG3Ou59oJZazBKzkb2E6bZKDnO/kqShsPQle0UVkOgm5ytaBw5MirZ2nawV+4Cs+Rf8Ilmwa3tLmT41LaPWJ9Li98fNEVHFtjwlnOOCUOo8h8tvkHoir028B0J+rFGAwNl/j/IHwYyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=OCjZowWY; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id C393C100003;
	Fri,  5 Jul 2024 14:36:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720179363; bh=fukh/qCjpOhKPdOYyMdzZj28hZQbEnqAxEmvW5BRgK8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=OCjZowWYV37LAF5SYn/KmciBh1pRlgFDyH2CTIyYDdB/Zokip7QhupzE976GPXDIj
	 EV547UkCqBjs6dRLbhhL5SUEDc2Yjs2h5H0dra1T33lUHDeDj6MuJ/7arLRkZlTQ6E
	 iVG+szzVWGMNycYWytMxMv8Es5YaUC6vSNFl7oA8Q1N64ieA29qPaIg2h/UahURC7m
	 SDNJZg9lIhzkvUN29IS3w5Duibs6lhApx+G7vUWlrBvcgUZbi0C/4XHb0U2naMCErL
	 SO6GH60DX13LajkgMeIdVQNk56IE6C49/EmW+r61C9pKF1W0JfBU+Uu1517ypV9xAm
	 8heQZvwQoKSgw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri,  5 Jul 2024 14:35:08 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 5 Jul 2024
 14:34:48 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Rajmohan Mani <rajmohan.mani@intel.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Andy Shevchenko
	<andy@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] ACPI / PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()
Date: Fri, 5 Jul 2024 14:34:34 +0300
Message-ID: <20240705113434.17249-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 186342 [Jul 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/05 10:17:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/05 10:39:00 #25854340
X-KSMG-AntiVirus-Status: Clean, skipped

In tps68470_pmic_opregion_probe() pointer 'dev' is compared to NULL which
is useless.

Fix this issue by removing unneeded check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e13452ac3790 ("ACPI / PMIC: Add TI PMIC TPS68470 operation region driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/acpi/pmic/tps68470_pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pmic/tps68470_pmic.c b/drivers/acpi/pmic/tps68470_pmic.c
index ebd03e472955..f8de8d0a528b 100644
--- a/drivers/acpi/pmic/tps68470_pmic.c
+++ b/drivers/acpi/pmic/tps68470_pmic.c
@@ -376,7 +376,7 @@ static int tps68470_pmic_opregion_probe(struct platform_device *pdev)
 	struct tps68470_pmic_opregion *opregion;
 	acpi_status status;
 
-	if (!dev || !tps68470_regmap) {
+	if (!tps68470_regmap) {
 		dev_warn(dev, "dev or regmap is NULL\n");
 		return -EINVAL;
 	}
-- 
2.30.2


