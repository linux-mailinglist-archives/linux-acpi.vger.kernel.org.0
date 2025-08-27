Return-Path: <linux-acpi+bounces-16121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C35B3892F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 20:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267DD3AF736
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D8225762;
	Wed, 27 Aug 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="MVpLRtR4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58113E41A;
	Wed, 27 Aug 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317659; cv=none; b=siv+OCGCbwIOG9wTbXkpKtkzwJS1jAiny53Di7LWiOagMz6D64YAWRsRNjxY6TNXzQSx7wsj/rTQTvAn5PiWEe9I4n3TvRjemHkm7BSvhVeRFXNh8+hP1Bc+1Oo9Ix2zIOJYevt6v9qoJ36NAc4GEt/QfjbxqCNK6zMIe4mxqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317659; c=relaxed/simple;
	bh=sWCGTZe2jXvPtA8z2lu570Aoie8t2QFzT5hY5nOrwfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1Ri5rs5kQJ5W+V7Gao9KvhJHzyz5G8T1PUPQ9FkWTvIEaOIHKIs4tOtF3QCG1DbM1bI8qX8urg2RskNor88orptXzNpHeElZX183VpSWnIIv/oa6pea3p5r/HDYFC6j3h+aFW5LCOCTV5hZqO3ThxU6K4dorW4m3u4vXJegZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=MVpLRtR4; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id BA9CD4935F;
	Wed, 27 Aug 2025 21:00:55 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id D1F18491B2;
	Wed, 27 Aug 2025 21:00:54 +0300 (EEST)
Received: from antheas-z13 (x5996a855.customers.hiper-net.dk [89.150.168.85])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 46B711FF6EE;
	Wed, 27 Aug 2025 21:00:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756317654;
	bh=mAfJYfiIgzNvgbEcVv2Z96v/vZoKteB0l8ih2gQ1320=; h=From:To:Subject;
	b=MVpLRtR4iwD1M9ubl2FuzG299pfztxD02lRHoDZxEZzC1+SjyevrgNNmC6HXDHu0u
	 M2Ycbdk9otUWK4sUL9L/ETL3QEUB/K2l17lITN3NLx2fDUZLTT/qA6ON0d/inHOvTd
	 715zFxn+qarC+XTPIHU0VicAVQZnRU7Jw5dc6KLwvSsHheqgMHW70wgWgCbPnwiDjR
	 t039h6jzC/Q4mNR3p2Wt+OMuj4vdrx9aXmomqOiChLCugjVKJJP6EeIr8KbgMqvjqr
	 qw0bo38hNPNhH5CtVO70958YBKSV/nM61UfxhBhkEljWLaL0YyCMAZ6yftciozJfH4
	 kRkCkNF4lGciw==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.85) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-gpio@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
Date: Wed, 27 Aug 2025 19:58:42 +0200
Message-ID: <20250827175842.3697418-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175631765413.1413749.7209228509442678446@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Same issue as G1619-04 in commit 805c74eac8cb ("gpiolib: acpi: Ignore
touchpad wakeup on GPD G1619-04"), Strix Point lineup uses 05.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index c13545dce349..bb63138c4b5b 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -317,6 +317,18 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "PNP0C50:00@8",
 		},
 	},
+	{
+		/*
+		 * Same as G1619-04. New model.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1619-05"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "PNP0C50:00@8",
+		},
+	},
 	{
 		/*
 		 * Spurious wakeups from GPIO 11

base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0



