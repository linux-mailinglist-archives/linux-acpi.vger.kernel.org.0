Return-Path: <linux-acpi+bounces-19144-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1CDC744DB
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 14:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA9A14F53F1
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C817B33E36C;
	Thu, 20 Nov 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="urPHQq2B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017B33A71C
	for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645060; cv=none; b=dDJ4qq0iYRjykHoHZizHT8kqKnlmyooItpW5amxkX7ovV7E0FoCN248PU0uaW9VbdXsiyYiZjh1kP7QKVwAlnTeFJoC7QZGvBfhVFeoFbPM4/1Y5A90ti4g2oixykiTfbMx/dC4u3eZrJhaAzkmlGQ9cklmMFELXjyzXEptAVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645060; c=relaxed/simple;
	bh=DAh7GJYihto1rb/7izzaWNy0krHQiRwe/MsGu2gJbwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxzGrWRb6XNncLrkOq4cNmNRBJi8l8pp2faffpp4Pcbhfh29UNLM1czNJJQ/1g0dx2OPlhscIwoIRbnk4H8b+GqJAa+UruNQV4dwYAJhREtsvwM0rykGDbLP7Tk+X9GYQbekiGyIPraCCLYqTj7/bDUZiwtZX86545XmYIxjG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=urPHQq2B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso6760765e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 05:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763645054; x=1764249854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6c4R4ZR/mmanidIpFqY9K6Mkfp/rNBIc8Ut3S49/Rs=;
        b=urPHQq2BnXPoZn5GWSb+UIUlLXpVVVWHV3zO9mSeowOXZj9LK6Ft3j3cxy+yJNW11M
         SumN4RtwHCkI/DsiLmGIAKab577LyWf8QEkXMDhY9MoH2zwNN6sOjt9j61LaJuBi3wWv
         /LsOnsZJmofID0SxLrMEC6raA6s5FE4aIAP76rnyESw+J6Myu4p8LTuR+nzTWNW9ru1o
         wjzD9nlEmLh/i+EYy8iKd9ypowAM0cGs0/VEPdwtVlKxdMcDBP5HEntQuVoIWbIBg13A
         a3kUamD8B9LpqySwku5t08sQZNpi7P1Kt70z8pvEZn1yAo5hdjNey+jKCpPVtSl50TT3
         uIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645054; x=1764249854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T6c4R4ZR/mmanidIpFqY9K6Mkfp/rNBIc8Ut3S49/Rs=;
        b=XwDGiP5V0eVd62pyMCONVSInur1AcZJdU0yJ8+8pck3b+2jbJPKFSbryVa6R+/H4pG
         QAU+o4sF1Phv3XuSF/JSStBJGXBNSggmuiRjx3wwObAuf/5zYEBZjo8acVQqB1wEv42G
         AasTgZepbs/KHgJpA+LIdu4dpS2KQEi0K/LTqZc51yVPFBNNCPxS0gFhvKa4C/LgwUTF
         mNoFVbXlv9ol8SYF6fdQl/VgYPB2JdeYF67yAKLvhKVxPaHN8bBeDVAtzdUkkQP6jAT5
         FIuBHz2qvCiYFYFTevnXApaG6lo2ZDNBV7LOH+sMHcCE13Uelme0DaKAxBt5xy1GgWAW
         MRWg==
X-Forwarded-Encrypted: i=1; AJvYcCXTl0V/GVfghUoo1I648IKsWO37IZcNteMILRm2Z+qAnFWXaKEVRWXnGoxCwKOb8Avl6XTvCxbsmlGQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyhlFLqXfUSD65oOmuTypXmMLprsKKUQd7Vj1Ddj8KCnRq8dw4a
	a05RFwKQSmQ1UTZX41hxWZHWdgsgw8ryBjAVq+CBqyLHEm+OQBiUaDLmUkfB/tqzPS0=
X-Gm-Gg: ASbGncsLOIarJJwtMic1jWWF4VZLzEy7sclnnALoDqnwpCy26PewvAiSDRhh6F3t6gh
	5pbYj3veuBb4EQ1V4AWPt31A5DVLN6vj65WOnwMec/wp5fwtVtgWUpWwrpBMx3Hi5+l6NCiRkhM
	g0kSYdT4Qe15z8S+OLuKaHgNJEnw6pFY0rFjuW2s58gugvXSQdL/OuJ8aN3+Ihlq4BWcYmXxQ5V
	Wr0pMqO+7oyHQyobUGJZgYTE8RcLwvV3wtiMDxmSJTEBXLj1zp+lFbavXpeS6omayZMvkTuj9JR
	pHxmqZDP2oHPmSFZ3j9ANQ7oj1Lglf8JIP2K8gTQsiHm0f0BvlivJN2uCM/lzzlXmLqNNi/UdFc
	QnxLcbXADwsgdgzZI2Esx3f+uCnMoknTlQk22a9LitBLX/KviLIHdmBDX19Km1RtDN7nN7wqoZX
	U5/ZM=
X-Google-Smtp-Source: AGHT+IFF7rV6uBva+BQRyBrCj38/4077uancqKeUXViRLWTSQtvD46FVILY+Uc8Srf05smNtarypTw==
X-Received: by 2002:a05:600c:1c02:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-477b9e377cemr28611695e9.23.1763645054075;
        Thu, 20 Nov 2025 05:24:14 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc72dsm46762935e9.1.2025.11.20.05.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:24:13 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 14:23:59 +0100
Subject: [PATCH v7 4/9] spi: cs42l43: Use actual ACPI firmware node for
 chip selects
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-reset-gpios-swnodes-v7-4-a100493a0f4b@linaro.org>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
In-Reply-To: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Mark Brown <broonie@kernel.org>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4326;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=d76VHZwIwnB+K4dfBzZLwy1CDep3KCUqEcn4QrJ+rFU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHxZzNvrgBP2H3ds0pVhTuGe6OzgZgzq1W6R0L
 /mn/TbtxyCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaR8WcwAKCRAFnS7L/zaE
 wxXbD/0SblSbNyyKOZkdAfFJSkmxgHZXxNFq3JE7HL0wgdCi0AO66QupG/HPcKXjULfDqHhCGwd
 4Kjne31/UiQLfV4KublOc+BgyLqpUB8TyFdDpjBVo6sFTKUi+ZsFURo7zYDLtY6ngMIkF4SAqjx
 vEKdX/5ipoqSxKY8ZuYceFNcy53UC7Zo41qPOSz5ZNgB9+aWlx/DxTpztI1sC2ljYROdeEtPcd7
 T8se4oUz8DvyzCxNyFa/cJ/Xa20jmqNH7ELcKGG2gixZfJScOFak5rdnxUPPG0yq/RpkuSANFIU
 8Lqn638HDK2hH0lgEpJ2XqCi/4pEZGCeFIDf23LF6Tz4d2tO/LAIgfcEwy0SbzbR7RxQVT9qJeD
 ktQWF4LQ1th9Cg1Oz8e+vovSyTbSKZh1c5entNqpyk9VqcHpLKltFXF98Sx4JCr9aEH9NaOmCwF
 jPExra5JKYuRn6RkI3/0otuXH7sqEY7CWSCjP7Aw3JH1QsMAI/b/jArv90+WqjpMlmFt9Z23ilo
 ZP7J7mxpg5tjXd9OcTNU/ztnRyvBSmd/g+KXBrVlWMMXaXTx4Ous1Upj4XxDBS4+kIhZ9Z4oy8B
 Ky67aBRO8dFoMYwv+LfLT7OXtOobdvnqiVa1DMiUZpRLP7s5k9Z2o3uyjvVt4jGcnWbdhgoRzMg
 8pldvv8LYKz0nHw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Charles Keepax <ckeepax@opensource.cirrus.com>

On some systems the cs42l43 has amplifiers attached to its SPI
controller that are not properly defined in ACPI. Currently
software nodes are added to support this case, however, the chip
selects for these devices are specified using a hack. A software
node is added with the same name as the pinctrl driver, as the
look up was name based, this allowed the GPIO look up to return
the pinctrl driver even though the swnode was not owned by it.
This was necessary as the swnodes did not support directly
linking to real firmware nodes.

Since commit e5d527be7e69 ("gpio: swnode: don't use the swnode's
name as the key for GPIO lookup") changed the lookup to be
fwnode based this hack will no longer find the pinctrl driver,
resulting in the driver not probing. There is no pinctrl driver
attached to the swnode itself. But other patches did add support
for linking a swnode to a real fwnode node [1]. As such the hack
is no longer needed, so switch over to just passing the real
fwnode for the pinctrl property to avoid any issues.

Link: https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org/ [1]
Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
Cc: stable+noautosel@kernel.org # Don't backport, previous approach works, fix relies on swnode changes
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[Bartosz:
  - remove unneeded Fixes: tag,
  - use PROPERTY_ENTRY_REF_ARRAY() instead of PROPERTY_ENTRY_REF_ARRAY_LEN()]
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spi-cs42l43.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 14307dd800b744fee17edd864688a68c65666c68..4b6b65f450a86c238ba0c66e03462c775d12b8cd 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -52,20 +52,6 @@ static struct spi_board_info amp_info_template = {
 	.mode			= SPI_MODE_0,
 };
 
-static const struct software_node cs42l43_gpiochip_swnode = {
-	.name			= "cs42l43-pinctrl",
-};
-
-static const struct software_node_ref_args cs42l43_cs_refs[] = {
-	SOFTWARE_NODE_REFERENCE(&cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_LOW),
-	SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
-};
-
-static const struct property_entry cs42l43_cs_props[] = {
-	PROPERTY_ENTRY_REF_ARRAY("cs-gpios", cs42l43_cs_refs),
-	{}
-};
-
 static int cs42l43_spi_tx(struct regmap *regmap, const u8 *buf, unsigned int len)
 {
 	const u8 *end = buf + len;
@@ -324,11 +310,6 @@ static void cs42l43_release_of_node(void *data)
 	fwnode_handle_put(data);
 }
 
-static void cs42l43_release_sw_node(void *data)
-{
-	software_node_unregister(&cs42l43_gpiochip_swnode);
-}
-
 static int cs42l43_spi_probe(struct platform_device *pdev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
@@ -391,6 +372,15 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
 
 	if (nsidecars) {
+		struct software_node_ref_args args[] = {
+			SOFTWARE_NODE_REFERENCE(fwnode, 0, GPIO_ACTIVE_LOW),
+			SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
+		};
+		struct property_entry props[] = {
+			PROPERTY_ENTRY_REF_ARRAY("cs-gpios", args),
+			{ }
+		};
+
 		ret = fwnode_property_read_u32(xu_fwnode, "01fa-spk-id-val", &spkid);
 		if (!ret) {
 			dev_dbg(priv->dev, "01fa-spk-id-val = %d\n", spkid);
@@ -403,17 +393,7 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 						     "Failed to get spk-id-gpios\n");
 		}
 
-		ret = software_node_register(&cs42l43_gpiochip_swnode);
-		if (ret)
-			return dev_err_probe(priv->dev, ret,
-					     "Failed to register gpio swnode\n");
-
-		ret = devm_add_action_or_reset(priv->dev, cs42l43_release_sw_node, NULL);
-		if (ret)
-			return ret;
-
-		ret = device_create_managed_software_node(&priv->ctlr->dev,
-							  cs42l43_cs_props, NULL);
+		ret = device_create_managed_software_node(&priv->ctlr->dev, props, NULL);
 		if (ret)
 			return dev_err_probe(priv->dev, ret, "Failed to add swnode\n");
 	} else {

-- 
2.51.0


