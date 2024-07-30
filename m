Return-Path: <linux-acpi+bounces-7156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D76D942358
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 01:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1E02855BA
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 23:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C57D191F8C;
	Tue, 30 Jul 2024 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="mWT+LnCY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28160192B79;
	Tue, 30 Jul 2024 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381209; cv=none; b=cWZ32sT842C931oTqU4zIS+K8p8Jll/5EakEYGXzB8uPa6AfeoSiBlbFC3iFEoKAMP6bjVbLk4CvyqXXw7AkU7rTFcdernr9Q4o0ei7N+iSVH4noqgALxe+wewoMN5wiWBjXl0iJa1jWbXHKOrMZ0ELTDCGB/wKeUlxmk8BwDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381209; c=relaxed/simple;
	bh=+Igrn3YHKKDduHZRjsbpHipGVP0H7ZrPakV8Vvm3yM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSttXKIx0uQlmNK2uirS47ZVVdlmw037pPZqxeScd4z+fWvDGdsh6ATStMLsAHjAYg93sA7XkVgHWfRDcwVP1wwPT9q82h+ZHSGfKgjK2fixqEQaZtoXpQsJg88PqPif3XJduBAWHLrW0WMQ9H+K01B1oCkrSUPKn67TSROqCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=mWT+LnCY; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 4C5AC100002;
	Wed, 31 Jul 2024 01:56:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1722380187; bh=PqddTe+P5ky+cShWwTOgAT+7APBFNLskDUN2Tg6jGhg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=mWT+LnCY42lepv13X/X2gn0BM7qn7I/A3WBm2Xf1vMUzCVAkzGDF2STUOE838brN8
	 WDDKm76XMTVrZZTuoj/n+kx+4zVXaYptP2ii+vh7OlOkv1pu9xkPzotTekVEOoLn4U
	 kG102IIrEMYumVacDcgZ96Te7MVHNvWa/LvUSyzfpxD2b3XIMnkruDykHZrxoq0VAG
	 t8v+Kz8tDJNXbYWN7BJJD97UnjxSBA8mpyZWCsVbGE87ynTVl44K990WGvl7X3PY7A
	 jJyfavqRBdBgT4PlGjyEPNO0jxZMXqKyuNX5THR/jzLSfA2gjwKizC5lXSk3/45gYf
	 VohPllA0Mt0TQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed, 31 Jul 2024 01:54:31 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 01:54:10 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Rajmohan Mani <rajmohan.mani@intel.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Andy Shevchenko
	<andy@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Andy
 Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] ACPI / PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()
Date: Wed, 31 Jul 2024 01:53:39 +0300
Message-ID: <20240730225339.13165-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240705113434.17249-1-amishin@t-argos.ru>
References: 
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
X-KSMG-AntiSpam-Lua-Profiles: 186797 [Jul 30 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/30 22:04:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/30 18:43:00 #26185698
X-KSMG-AntiVirus-Status: Clean, skipped

In tps68470_pmic_opregion_probe() pointer 'dev' is compared to NULL which
is useless.

Fix this issue by removing unneeded check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e13452ac3790 ("ACPI / PMIC: Add TI PMIC TPS68470 operation region driver")
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
v1->v2:
  - Add Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
    (https://lore.kernel.org/all/Zokw6XRZxv0YqIiZ@kekkonen.localdomain/)
  - Update log message and its level as suggested by Andy
    (https://lore.kernel.org/all/CAHp75Vefw5FB1mK8v-FJ5MBeSo_N9fgiAFPdYw2w_OCX5UxrAA@mail.gmail.com/)

 drivers/acpi/pmic/tps68470_pmic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pmic/tps68470_pmic.c b/drivers/acpi/pmic/tps68470_pmic.c
index ebd03e472955..0d1a82eeb4b0 100644
--- a/drivers/acpi/pmic/tps68470_pmic.c
+++ b/drivers/acpi/pmic/tps68470_pmic.c
@@ -376,10 +376,8 @@ static int tps68470_pmic_opregion_probe(struct platform_device *pdev)
 	struct tps68470_pmic_opregion *opregion;
 	acpi_status status;
 
-	if (!dev || !tps68470_regmap) {
-		dev_warn(dev, "dev or regmap is NULL\n");
-		return -EINVAL;
-	}
+	if (!tps68470_regmap)
+		return dev_err_probe(dev, -EINVAL, "regmap is missing\n");
 
 	if (!handle) {
 		dev_warn(dev, "acpi handle is NULL\n");
-- 
2.30.2


