Return-Path: <linux-acpi+bounces-14167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E60ACF5BD
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 19:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A82F189AD20
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A83A27A92A;
	Thu,  5 Jun 2025 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZVkCRHEm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E0279780
	for <linux-acpi@vger.kernel.org>; Thu,  5 Jun 2025 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145987; cv=none; b=ArP2Cx6HwOTxnt4aQ2IIUZA3qavB5xtCbAyy/gF1clCeBRE4RQLC350gHWVlofRZykThHESwMaTUMt8+tLFbvjyPnyZxfxvQlVZQtqBNNTCLLIZacq7zkaa5yZ2O0y/PMUIaDXmtr54HGsnYGWMZBlT/E5E9IAflFJJLpXvz1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145987; c=relaxed/simple;
	bh=tewb45+dzAe3tLBQsQaB+O4zKZphuKqtE9IM4Y6OX9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ukBX1//XAVUy3Y6fgUdHtAyJ2HCYtgAd/mgpvXhvCiAvzU9ijfYr92E1A/jJ3NIfK0sujwcpnPCO45u8dtIrOPtXPLD5O4BpcYZsNg4g0ehhKLTLCJ0xiBBkc9KZqTMDjoCGq7rbYv74dn8cXiPdYaswBiR7Vrp4SuWUf6JTxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZVkCRHEm; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553644b8f56so638727e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Jun 2025 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749145983; x=1749750783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2bzjHeaOe4XJQH7wCz0q9lsz5fFHI+NR6J/UEFEZdQ=;
        b=ZVkCRHEmBSMwAVs2r4H6mCqw7kB5h/HMviCkeWJwBrW4ZC8SnUK2Ug2FJB9zOV/PRa
         3yprm3m92Yf3jKNQHX2hv+vxVW36LQN/Qx2gkIo6Xf8evy9FIF6EVPgBXSp+IZObtOSz
         OWYhDVEBzWScLF1rid461YU5MTRNttPiSBucI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145983; x=1749750783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2bzjHeaOe4XJQH7wCz0q9lsz5fFHI+NR6J/UEFEZdQ=;
        b=dozErgpMvrwYXdrkBonI3Hi0qMYeCvdv4uzSWppSMDyeF30JRCc06WlWBn9Er54BcG
         zFJFKJhJnBstkuWxaNY4D7YAmxOzsygdyQRGxALpAyi21ELsq/kYFF+G/m9xmA1izr4Z
         XA3PWRfy4WLI6qcrAjFJIw1p8N+ISTjgcJRgjXZCMZPrqiFOcxgNRrjxdYylOWKLPMyR
         UmfkwhFxTZII0rezcfD5SDfuZ/X5lgwfOqrmu+uGZGZZy8HyglZI1IPUbuvA/pn9/gL5
         SojJ16egF+1KtWHtAmZICujnAGgYs+emLY70RCMYZ1T3LzEGsb86L5KYEgiVXolfW1tg
         fvBg==
X-Forwarded-Encrypted: i=1; AJvYcCXu4R0pv2mydv9g1YhFj/+5iTmqFosx3xHF0hF2QT1ZnV03ykTjo5RCmz/MPWJXJm2lnK8EIjSkQpC9@vger.kernel.org
X-Gm-Message-State: AOJu0YyKzF+vXEUjwVX1ME6rQYE++e/EwQ2i4H1GPSKR+sBYNzjRRN9J
	bZrqjjSz+4aC8w4TvlyuN2tbm53zuNL3q/ip74OtimfaLKNgGt8L6kxjlpxZKuRMOw==
X-Gm-Gg: ASbGncu3ZJ4N27nv61vNosFxANPQtwEUYsnROw7f2JWhVlE6JEurLQXDtd3zHbXgT5s
	54ZCG6oBciwyP6VHoUcy1BU7LainzHwhz66XKOzWBU6VHr/gQTcl0KVfW6h6VyImhRsiW3FfDRT
	VpovaV3ZnjtBH0yZI28T2fHMAQQdoiCE6d4dp/uEkdSqqe+Rj1gY3pij+LLAZslPuYLnmGU7+K6
	C591/D7lJaCqoR+1oUajcyRo97xRdbp2Vu5C9v6dUQPYLujqYBY+roY/xwBkBO425pUkS9/kZO1
	AmkoHxh6W7NEd4hbzpk9ltjrcKAvusR1a8utpo15Zo/iMP8vVXV0oQRzH/5N7B8P9z4427amdYV
	oPvXYUpmsEaFVVSWFgVqeuNLUDg==
X-Google-Smtp-Source: AGHT+IGl548xQa/vsHY27xBCLqMA/WtFSSEsFfeQt2Dzb0VNl43ck1yHu+ccC0nfMKcjxfgnvusB5Q==
X-Received: by 2002:a05:6512:1248:b0:553:2cc1:2bb4 with SMTP id 2adb3069b0e04-55366bd49dcmr18752e87.12.1749145983043;
        Thu, 05 Jun 2025 10:53:03 -0700 (PDT)
Received: from ribalda.c.googlers.com (90.52.88.34.bc.googleusercontent.com. [34.88.52.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553379379c2sm2641210e87.251.2025.06.05.10.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:53:02 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 05 Jun 2025 17:52:54 +0000
Subject: [PATCH v2 01/12] media: uvcvideo: Always set default_value
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-uvc-orientation-v2-1-5710f9d030aa@chromium.org>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
In-Reply-To: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

If the control does not support GET_DEF, the field default_value will be
left uninitialized during queryctrl.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 44b6513c526421943bb9841fb53dc5f8e9f93f02..47e8ccc39234d1769384b55539a21df07f3d57c7 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1497,6 +1497,8 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
 		v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
 				UVC_GET_DEF, uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
+	} else {
+		v4l2_ctrl->default_value = 0;
 	}
 
 	switch (mapping->v4l2_type) {

-- 
2.50.0.rc0.642.g800a2b2222-goog


