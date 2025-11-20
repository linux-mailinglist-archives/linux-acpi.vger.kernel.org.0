Return-Path: <linux-acpi+bounces-19141-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB98C74310
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 14:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5B28D30B51
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23F833A6ED;
	Thu, 20 Nov 2025 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1gnhub9n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D432D0DF
	for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645055; cv=none; b=M57Uq3BzBKmJ7FM+nfowGKTZX4myq9nwOJt2Rk4S3h3eg5p4kerR8GTtzGEXBqjjfMyoA43EDtlu/l3Ur+l3jpR73niHGVhFWYEi/D7TZtoCbcfm8iI4EvxqaweLNtl7bDwlxN67B38/Va5Jwb06u809/PZM4mv+uGEgM+qt+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645055; c=relaxed/simple;
	bh=BuYgFAZZbSpKpsTYQp01UrI9oIh6Sp0S2u9ZSteIe18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbjgakJQsw4e6wVExroSgpq1y2k0DV8mCxUP+bGAeNU7x9M6D7GlzF2NdV14xvXEOWiHu1df0A7JF2q1VvAjI1MdIV/22euTVgHldhQTxgjjGQTZbsG3k8/9X4f/SBb9KrsygV8Ic1GWYQccg7fJZ4CA6XDNEU22E9qa45wqkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1gnhub9n; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47118259fd8so7365185e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 05:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763645049; x=1764249849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQJ9XtNto1bKDWFPhkt3LB0ixKNziS3EmuJ1JwgvOg0=;
        b=1gnhub9nNeSENnNr22G9g668JeQvD2+abmtSdy3y3/mCCa1478iRtA0MZrq1h+xNPj
         quxAV4I/MzVlguv74mVwfVaMf2pl1dyq2E8ADo0uJ1AqTFV+hysrEBlqGu7MsfMUllpK
         neCit+ZNfQcR89FezWtNp8Lc/olNjSEP5gQ2WGJF9HvRaAsx6msx9UOHYlVBF8pu/0j+
         v/8oPlS0PyIHwhqcJmqvh2ABVaGTqt1UwYVfTbLYDsa1FE6zPE1qtSBLKBgEsazZhLQM
         gDL5O4FXHyok64kOyG2Fi4K29556q+l8lgWF6YD/lk4ChZAFCY+W138P/CER5tNqvjYr
         imoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645049; x=1764249849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQJ9XtNto1bKDWFPhkt3LB0ixKNziS3EmuJ1JwgvOg0=;
        b=CiEO3Dlon3iWOJo3a3tVgSRTWXJjYfsQFxIrN+/n1fwL4mcVG/vvE8Xtq8t/9DaTdq
         3tMOPL5x7FroJ+lk4zadmuTTbMxM8GUlXwan/50ULFzBAH4DXGvlEUJVrym3jJvZw89+
         nsZw+0IPoA8p0+vM4kSulrpz0itNldNxRW7XBPPBq9WxbuXn1Rgh2ZIQNwohLjLt+GFJ
         jwbFtbdi6kB1pxF0D6aja7FcjTveWOS41ew91CSEwv6cQ/D6IbLJQ0wBYKqpqcJ4hntw
         6JL1eRGaoWv/YLgSIwHIPWCTFOZZYzutO4hZKpCHj7ZqMXuAifjxsaAy9/7c8Mh7d+G9
         42HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgsBrfn/G84Uqr6mh07P+1iIg6dP/0h1W1OJMKbaCcDeTyonx3vx2/1BTaBz8kOkEgCbuJ3eXpDF4H@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6x9SmVBQQXIsu10RQS9gZtWD3fcsXg7KOWdh6FHogGmU6I97
	X6sryRBxUrkCsVc1YvnwPKF/+mZDdoFmRdaFCL5tlVdAIKefYO9C/SwRNwS6IALt1/Q=
X-Gm-Gg: ASbGnctTCilie6LpCFolqrl7w1ZnZcBrCbknCKqV2lccdifrHRlO5PlkXKcYzainKjj
	W8FXWx7cktAAYKUGPhNyaJJWJdOMDKPFZvQzdx/EUVjTdaIGUlTo6CYC8jxj72pLPTGnuMd9TpU
	YRYAyBGTlBc4BqedZqzdVPQKBvi/OskxWfvWk9JQbjd3bAru94Hguf2aZtAhZ2Nh1rjMukSA1Ql
	qFvs3+WZoocljqt2MPkFeGe0BtuO+Nf0hxw5+FAdHx0vlAs2KoZz04FVlekpobBUwnH0fDPQwqi
	Ld1DxJHU6/jghiWpZmKLCOeuCDelhsCuN5ab3Wyl6+0x7sH98zxNHN0iHV7UBHaNuDXbNf/o046
	Ji3xb2u4PrAb90Kl5PHG46wIfpG6kLSLGYF3tG2XU7LKo2irGQEcoT3nK0BMdIe+eNd//ajrG9O
	JFsrk=
X-Google-Smtp-Source: AGHT+IHe1VrYNEFSKnVFZzn6eN9xcn49No4MD91AWIJrNPyNSPzr4/CBgBGVsemdF8hxk1ZXqq5v+Q==
X-Received: by 2002:a05:600c:4704:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-477b8a9ab58mr28905855e9.27.1763645048920;
        Thu, 20 Nov 2025 05:24:08 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc72dsm46762935e9.1.2025.11.20.05.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:24:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 14:23:56 +0100
Subject: [PATCH v7 1/9] software node: read the reference args via the
 fwnode API
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-reset-gpios-swnodes-v7-1-a100493a0f4b@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=T/cLF5pkEYUrhB0PpULA+kEHdrTrynh6SpnU2EG+2zI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHxZyq1RhLZnYaknhB1KZ4rmSbfeSyk4JclFra
 WwoR2OkXHSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaR8WcgAKCRAFnS7L/zaE
 w497D/4lHaTdMweES9UKFCv/L+yKEDQDbLoma2l27haxeLwUNmH0ThjalHneW6hHUvAJ00D0omM
 tQhDnOOsXRxFbWaX+AF7SGzct6S1vMpC141rRabE/dEOyEbQPxcUMEQqCxZoakJoh8gKmvvl3Pk
 HRwLJO1bsiozYXRhwwVdXqlMdob2UEp3X/hW9SCxwCoXAGSiKyg3ZTS6njxVPSvxqDNgh4ai6qg
 Gd4+mO1htF54C6V+thRwG274xE7UcoyV0sQWseE9L68I7tDga+WPGstkblKAB9etgWvE5OvUL4h
 SueuDW28Rol9RWn9W9wc9ZTN3vyoeBtR5leuLv7B3IpHxF0wzu9X8bFXGLY71OJ+Eor+y4zRWmo
 X99ipgf3dle7ixTqcXBi1Z+u8mHHQ8aZi7KQWX6tjlQLQp32wPhRfrU+wo+cV14MlksFrKMcyJQ
 lkkc7HWZiIYcEYMC7n7mMYp3nfITe4g4wEK1AGIgXVNrE0VuaLybfqVw4rCXpQ30lvhNr7lLtWm
 3ppsRU9iweLn18D4YOG+is76DHa1nhWoOpedE6JTEdEriIAMaduiRPQlUl9rtQtWiwGG6PVRg/z
 5VSKvIf7rFG9TAoOTjMcyWN1cyDJMjK+rCOWxv82QR4N2J1Ayjtpi2Uh9FmetW6sdrqTOEH6FVg
 EzNEpn/Oak+xpUQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference all kinds of firmware nodes,
the refnode here will no longer necessarily be a software node so read
its proprties going through its fwnode implementation.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index be1e9e61a7bf4d1301a3e109628517cfd9214704..016a6fd12864f2c81d4dfb021957f0c4efce4011 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,9 +540,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	if (nargs_prop) {
-		error = property_entry_read_int_array(ref->node->properties,
-						      nargs_prop, sizeof(u32),
-						      &nargs_prop_val, 1);
+		error = fwnode_property_read_u32(refnode, nargs_prop, &nargs_prop_val);
 		if (error)
 			return error;
 

-- 
2.51.0


