Return-Path: <linux-acpi+bounces-18520-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D90C348D7
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 09:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0E764F4A6B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 08:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1742DF3DA;
	Wed,  5 Nov 2025 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SAWC/G85"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340902DEA8C
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332481; cv=none; b=F6eRKWfXBhh0p+kx1wTL3qoYnXecIvHMf5zWTpZMBDJ2JW6IZDGHoV3JAA9s2FHJPeESOaQb1UTyWjZ+9HqNNhxSfPlIhnW2JgvMd4xCZG/e01uW7cDAJ9wPUCqu6dLWBIzwvqzzyT1O/Db6yXsyjlVweFfPz8OXTngho19Fkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332481; c=relaxed/simple;
	bh=KzXWYFedYyI8UG+nwQx/rQYPGeNs0qKtqKI3x4qG4cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hje2JWm5wYfD42oY4tbHhOgDbyjBQZ+wqkbwVT1RCCPKo92EFI/Ie5eCN6AiHmgdCRnrpieqgdFc25VCF811XilCuFXb2VN3PC8oKMita5OKjYJ6NDP1jyGi27K242HkLsMqLfv76a6cqOyzcP47h9I9jhj2rok3Lgae7I0a17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SAWC/G85; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so2652715e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 00:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762332477; x=1762937277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMbjX960Vd0zTJ6ycxKDpuXM+QwZlwVzJthScjlDZlY=;
        b=SAWC/G85VJvzBAB5oHgDCqWgDxslpflqEeywMYaPlrz72CPM4zWJFUqQVZ8tNG1JON
         628NVK05dle1ReclGlEXFzYqQiY1unpoXUgzcSTATVHaOfJ2/FeH/riUVeC29OeA/Iig
         zodxaEGvtDigRg7WLHJl4gquXyrxf+X/2wPH8vAHKsMt9dxz4LUlcIrHajjr1VWTgitQ
         LPGmgZ3rq3cLWmLTIH27WHleLOa35c964LrIiA5GOoykyU7WcTe4ZTH0Tv1YoBo0aHa8
         yZEXO/YYLy/urL0P8dfV8KfVtnwX6zDrxI88l4FDxL5IFkviWyz8PDwaTJXWPb3mnYJX
         fSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332477; x=1762937277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMbjX960Vd0zTJ6ycxKDpuXM+QwZlwVzJthScjlDZlY=;
        b=f0r45O6vlmFw+A8mfJr4akrOw72cdT8wyzaP1z7SM3utcOZ411P5T/AeK3lFEK8RTS
         45mYAIT7Wg450O2L2tZshFNQX5wNUhhFLT8UiHAgyxaUIF+CJouEhDfjUpfTR9VHne8Q
         WnlKFP0buV+4mshl4dplQNJBY8oYTSlF6xG50AyOp+88YYtA1aZdLJe1XH+E4tOHWoh0
         +3tQE4b5XpRWq3Lb1JvzjeYW1XDRYb93+Vl4sRdc3vPzI2ntJJ8pvYpVuyxpFwN5taXe
         3tKr2E/2eMPEwu+Fs+uzJB4kCr5pjcIVNHrMgO9SqpwUh9QpKRVRB8Pmub0OAkYMF7di
         hwvA==
X-Forwarded-Encrypted: i=1; AJvYcCVFGKPpVAVfUiJbp9Cwqy9KxI5+k4EQR1R2g9hNq+6ikShrFSFfEKes8flkSHmpB3hBiTkWUAHjrGIv@vger.kernel.org
X-Gm-Message-State: AOJu0YwD7gFD/uYVqA7ZbE1LVQ7Rx9PkaJDrkcg6Y1I2Zy2ULvU7iaNx
	wl7kQNes2NHwWADtclZ5jHUt6JpqQXIq3cTYSCXaS4G7LCpoGd5omSvtfazajGtI8Qs=
X-Gm-Gg: ASbGnctjA+fIX2I99q+ZesPR9ULi/cKt1h+IBiOxYrg1XgyDWj9BBXXLzmrmMSkgAin
	jmrOf9hu5MW/js81gHi1dnPzca6lZVsM/jNzjIQKHJ+Z8HlDa+y9P/8eFF5Q60i1zMEfITNUO7J
	fFH6zqFMYLTzoEg9OZExOrfNA7XldUIGq7h3EezngkdWT460GU2AtDFx30EElKwPOAJirUzZ8bw
	pfvy2TLgr3l49lodfAm8Cgf++5XF5RZW/WxWG13XE1pW3aGu6BJd5wmIhe1gwGxsOfppaz3btFV
	i/m543Ayps0apoLsas2lwSYCENM8cbN3iCKf3alLMAykyvHjFrSNVDVMGwmxGvgt6p5KaFOgFm/
	/sNPgXc2u+PinP8Wj7TJGoSFKprfWb8nyChjsDz+NvmodbcW7xkk3QF17NcU9GwCSXKqBLQ==
X-Google-Smtp-Source: AGHT+IEm1noGATV9vo77sBfbVn3t28IHXH12mmVOJj8+v+ygz6vRHUxeGWcOZsqfv1MqUiJKLnPRmg==
X-Received: by 2002:a05:600c:4e48:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-4775c726664mr22898955e9.11.1762332477386;
        Wed, 05 Nov 2025 00:47:57 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4e71:8371:5a52:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9315936f8f.34.2025.11.05.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:47:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 05 Nov 2025 09:47:33 +0100
Subject: [PATCH v5 2/8] software node: increase the reference of the swnode
 by its fwnode
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-reset-gpios-swnodes-v5-2-1f67499a8287@linaro.org>
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
In-Reply-To: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=963;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=HX7JTQgb7mODwXNdQkxhPlBcCXEZwyahgSTpWNcaNnE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCw8xBBL2/0lTTWj/7+vn9oeWymkUprFuMHnnD
 FlduvwOM7GJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQsPMQAKCRARpy6gFHHX
 cuOOEACWdTdaOA3U0T9wTAblJlBn/1MxQztCaK0sk1RD7rwR+yBrKVNINJ4MT62K6lpUnpTDRnK
 2vY5c2d6qV0IvoD0FCPNq3bpmg9w4OZ6a56JH+rSAUeGb5iypx1j0bdsJStaYMOiQLTudqcKL74
 HXg/iNPMYdZsVqJgx2lVNBkaYF8b7atR1NkIgaUwof7nhyxOHo3EwcnyZJFGrVdV/Es7i9RE4eH
 KGDnOjSLT1jgIkvSbs7QRKiUJM6N9mtpVKR/kEeeR6BaOtvoTI+GlxRUwCPv06wsKY/Jt8mWBMI
 jpx+umcbtckEe+HMQ7bS2MnqQju06xnrXb4IVLfHHdVc2CYW4INgZi+vpkHf3hvWa7AK+q+Z5MD
 XQZNYe2CJVnh4yc6+H1430BJfxf/E5YL6NfksP+ezTVtpKWt7b5vm3nqq7Ke5H/MCg3uhCjq+/6
 DNJw+tkDasBH4NAA1Ufz3IEk7tzMxrADj2HU8k3aPeMR7Du5FTgoxI1hGw/+HQ/xl4kElGxbPwE
 3TueUPj5C6SbI7qUGQ1oQFSbNRefSl1lL8wtFA42f0AT3g27ljfOFrAh30PMmCJLrmt2DdjrWps
 lrDVeNvfKLjpTu9BHoYA/uj8Gm9qkbX6JwZDyaYWIhHJdSUEIMq3BLUAqv3ZZM25vTD2KxIx5cU
 NoGQzsVJwtV4aCA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference other kinds of firmware nodes,
the node in args will no longer necessarily be a software node so bump
its reference count using its fwnode interface.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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


