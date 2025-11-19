Return-Path: <linux-acpi+bounces-19123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5854EC71561
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 23:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5494034F377
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 22:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD532E14D;
	Wed, 19 Nov 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="EeHoapDu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737C32B9A5
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592166; cv=none; b=Rl06DVJ7wCQcgmVS5K53k86r1WXQj9h69Xg/O5sQg3QJd8ZeAM2R0mE3V4ytMTX23hiPXRgov09MOiFZH6W8Tgh4hNvLFPisW0G0vpzNJkT/ZcqnUAFqurXnV3B09tSmV5Z7JFrg+m0SSds0WQaxXpRPoXcLfgjTv6Og2Y78DCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592166; c=relaxed/simple;
	bh=tt/IMPwEpLQecANGcddj+ukYcGqvpvlJ/TqDtm477Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiYMiQrs0HgJNTfZrvy5BXiXPQq3IqZckITn9yGZAdMoZYQOrciny9vON+F1Twu0nVgLki7/IsKhqQ3kXNXOst/4JO0vaCbv0Zm4NPUbFF5M3/uXOnN14mHsvq4NSz1lK5FsxAAjxqDfSpvoWUHl4/6KRwrpoh/K71Pk75TZ8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=EeHoapDu; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsm-006yof-1F; Wed, 19 Nov 2025 23:42:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=FJlg4ul1sq6ZIhYuGCfri+UArhKIFxhGhDxLLUHAweI=; b=EeHoapDuKaTV8lNNWBHRSinGgN
	oGrN6E8WJGCGmQ/UZ8Jwwc0T7nrGHIqcSMnb8z/cZxhehiegTm/tshgB/kN4QR4hVhN9eSZwduGls
	2PFLLd1+qwVa7We6HZ1csXYxMfEmciCyRSkMBIcruVyXpLS4RGdBf4LtH3eqk7bBBLCzERwb2FSI7
	o9AlR4YV0O87T+tBljrwFgRuuzcQHRkgp8bftdjF1VkA2yXvs/KBIROiR6KWWjhC32bk7bf+h6q1Y
	Ub+//bZuqPHi3FznD0eTSB+kOmeKwg/2l9abP2d5lW5Xu4ncplHgmJSiFao5JzXAw62EDEkir/tYT
	fSWzAu0w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsl-00080B-EF; Wed, 19 Nov 2025 23:42:35 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsd-00Fos6-6X; Wed, 19 Nov 2025 23:42:27 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <westeri@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 18/44] drivers/gpio: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:14 +0000
Message-Id: <20251119224140.8616-19-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(u16, a, b) casts an 'unsigned long' to 'u16'.
Use min(a, b) instead as it promotes the both values to int
and so cannot discard significant bits.

In this case the values should be ok.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index d441c1236d8c..83dd227dbbec 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1099,7 +1099,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		return AE_BAD_PARAMETER;
 	}
 
-	length = min_t(u16, agpio->pin_table_length, pin_index + bits);
+	length = min(agpio->pin_table_length, pin_index + bits);
 	for (i = pin_index; i < length; ++i) {
 		unsigned int pin = agpio->pin_table[i];
 		struct acpi_gpio_connection *conn;
-- 
2.39.5


