Return-Path: <linux-acpi+bounces-18429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2EFC2AC6F
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2CF3ACA30
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B9A2D8781;
	Mon,  3 Nov 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JWtpCIPI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11C2EBBB3
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162543; cv=none; b=B29B6lhQoXSsCiPGpmvYOtGebz9Jp5oCBY5fqiUqkoci/ULdvzWXs5+0QSmq9WLiw+Ma7mU/AQ8QDftEX8zIYPgGN5dXiVR0BQqvm+kFqMP1dGhKTGsm5R2lSSDlthA0cgqtj9iAxq85da4uISVPT8JPkrc6GxUH9Fl4hMI5Gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162543; c=relaxed/simple;
	bh=HTd4iZaPRKiVM5g3i5e6EDps+IClJtoB1LFevsHD4CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnspSVPW1FLAOP9dummJXKJH6VZD+Pdiglb+1nXLD17zzvzOB0sO8B71cLsPG+jozZHRrCT9ShYdn0eyQN5dv60zEMwo3X/3OHiiCwScc8AyYXcvGxlFJ9SqtpB8QZDr7slGJkJtdaXlweWqr3pmwWNeXugXmaNOayhKvXrWkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JWtpCIPI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso2884337f8f.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 01:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162540; x=1762767340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MR9/q1uejjwqNisgWS/5bEtUBR0CMunjlT9KIpTJamk=;
        b=JWtpCIPIuRvgg4Sg13FMlCyblxReTvVv2jm73Kmk/EwGjo3NZZY/+EzVhbc9cjAKkU
         nXoOP+YtehM/qX6yAY/Ci6diSaxW2gCHcuDOHqbsSiGChBW6bprtUfcXafQQ7heK66x6
         Yu0EwMo/UM57YX9IB1otdeM8MHBMotRoZYwCx55ndLXQnFpLhxh84uiMhvjsYz9C/3m7
         iFXjvKQBU8Dv/YzGaOlJ6bTucGZLHAckDeCNpczEntObRa43Lsc3mdC1vetVUIYcbNnS
         HaEnp3Bfj1GJoSZKtZr7/TXFeolVuor+mLXAK5192HeybFMuMJ6huOUm3ugeR21Ydrqp
         Pj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162540; x=1762767340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR9/q1uejjwqNisgWS/5bEtUBR0CMunjlT9KIpTJamk=;
        b=t9k+WJ1oCfj7T0/4kxvEHIKaBrSCVR74SUgVPPha8J55dkhH8xI9VRZToP2qD4saL3
         2Rqi7l2xPtnSTBFQSIbtNVVjxF64gBJCiLiA+QO1L8E1OB9j7llQ8IIP7m4SHfi//aOU
         cgp+l3RW8hDKfTcAWS6P9Vkk8Z5r06vf4WMLyyh+JD3qVLqWr2iv3qTszdbCH5hkVWbC
         jnyvqw3EyLDN2n8l692sDrGa7LBLNT0TqJlEBkfyxrVrNPl9q3tdJjsYqaTyP2PC/Fdq
         /WVNfRDNYNcSxCtBTNc7RRt+fSK2IOH5WXjAZooNt+AaWkZQ4+I7Vi3uO+kM33E2bqjO
         REMg==
X-Forwarded-Encrypted: i=1; AJvYcCV5zLMZ3sQuYfGGr1906jnxUGmyN4l+qZM2XVwD/oL/g9AghlR2FJr4w6Vf8mAClk1KkgwFEh2uE6CN@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVeX1tM7PIA13DlVP7gav7fEvdJV87NPQnmLO4IkRYORFhvNf
	J5BlIg6RkHAzGak1kUQVNa1gBwqKVPM7vOVqz2L3uX2JA1fwn3wP3vCYkZx6dNuG72g=
X-Gm-Gg: ASbGncuAzoO4HS1i+7kzpFSmaVmZENHgG8jUxyNq76g4oSXBlhg/A6ZnVU6xKLzMFAg
	3L6LLieOOMnYFsBH11R1/yUsjDFy22at+oCRKbtIYjrzAmmtnJP5IpZucBdGAEzVpVNa6Qznh6V
	5uHKLluHAY1lR0Uz+vvRNzd4IW1Q8aNroeHkzNarx3viqlgV5x/So559S+f9UzZSxHpLXUQqj+J
	BIirAvA9JOw/gYjaiEs3y4asrj5LeTFZxelHU/gxWvmGneNMfKotu8AYe2Z72+c1XtqTutaFdyt
	XXzGUYztuhVsf3RWqUISc/YlwmwAFDHPheBVNSVPyzDeaNrDLeak5VaNi5HYCdFDdfL8wzasAsy
	jYucOt4ZRd+wO+Vm/Hj/ONd+PrEAGN17r/CN0nmgLj83e+feYlJkMXSoUjcI9KJnv2paAN/DWLd
	6iucJl
X-Google-Smtp-Source: AGHT+IHRSTk2bASAi6bSlqK3LuaAJPm8yPphUV6iZEA60aV9YtfO6Vgj8NiJ0oWGdqgc/FbytjRbkQ==
X-Received: by 2002:a05:6000:2882:b0:429:c6ba:d94e with SMTP id ffacd0b85a97d-429c6bada73mr6241828f8f.12.1762162539894;
        Mon, 03 Nov 2025 01:35:39 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:22 +0100
Subject: [PATCH v4 02/10] software node: increase the reference of the
 swnode by its fwnode
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-2-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=905;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=cWEXsl3g7Qga/+zqwiTnXs07zQEFM6f4IiHgGDiKRrI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdk+HcXSqYzV6wtK2hDXg7D6GqjdHCZYrzNH
 mNXIIVvAOWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZAAKCRARpy6gFHHX
 ciivD/9xjHtYcd33CT4tvDonwQ66b0vfxLxMbHV/nO11V92tOAvwAjfGw/ojqixgfmPdF7Am0uQ
 Im9zZSwkQpWnJqhA7DRQ1sJMNmh8o06kZYqSCkFJHicAYFtfJ6dWQYriuT5C26OuUkFxMPi5TuH
 7Ak2d6zirsj8qZQZHY9oq2etd4D5ifDwFk6tOYNa5V6D9Rig/YC6WQ8H5nL2C8KbFmgQ/TDkwTq
 i0IpO3k7U93Qdef+NUsvbyOisc9epzhm+1QykzdTFx1rutfkuEZbgN8chSP6HKlNcUkjOkdwgG4
 FcMAAvJa2i0Hk/ulvK5PRd4xEnKpZja2+5ogMxt8+2egEtXLVfRzh4YMuRsJF2cf+Ioza9OsmOS
 6r3fwUH6/I9xBk6y+zJdfCiHYw8879CtKBYz5rEeAm8HWJx1sbOxSyZ3b6VeQPccMIM5kgcQSMo
 bxM2HJxErbnCovM1w+K7k1YavCJdDpAZS9NWOEXk6xtyc+Epw8/PgjVDrOQfBaYd3XH+u9IrsG+
 MSXxk9NjcSaWhb2ppu04meUK2XIsOapbRE1e33Ak/dGj8bmDY5DsP/M2ih9j5GHaJCkvqA15HU0
 hbnNfbr6h9tILvvJQE6b02v59X9+vID4kWCnnsGpB9I50RkIJ//+G0itWtI9z2rAy3uPjgwv9yj
 RDPiRSETNW3Z2eA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference other kinds of firmware nodes,
the node in args will no longer necessarily be a software node so bump
its reference count using its fwnode interface.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 016a6fd12864f2c81d4dfb021957f0c4efce4011..6b1ee75a908fbf272f29dbe65529ce69ce03a021 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -553,7 +553,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (!args)
 		return 0;
 
-	args->fwnode = software_node_get(refnode);
+	args->fwnode = fwnode_handle_get(refnode);
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)

-- 
2.51.0


