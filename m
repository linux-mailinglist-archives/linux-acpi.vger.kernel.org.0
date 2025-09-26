Return-Path: <linux-acpi+bounces-17346-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27CBBA3C5A
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 15:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3D81C0067F
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DB32F6581;
	Fri, 26 Sep 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fbfy3VJj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413412F60CA
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892294; cv=none; b=mJWIuZh+X62ystPP3LO/9FiXE3TvXTA4xooGKaAYFe4k5b/mqBqdJgC56hSsraVHeW8B3DxqfjEhIYkWAmI9vm+gWFLIpbJE9JlTOrEyE/g/mt3Uw6hLANd7NE2LiQsY/4Ytl9ZU6uxSACTESE/MeiUDn6cwVDJKs4FRTcbNzec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892294; c=relaxed/simple;
	bh=fN1yQSZa9dGNYApiBN9DJ0yzGqYY3io2zaEeifTv+AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oo20ruUDHxWr6IurYgbwXk4cs5yW+d49v6AVsEgx8h+OMv2A4wMqT8WJgDP90wXiJT73L3M0n585VkX0WEiqSnRhmRprhOg0kcIhb48lDWuyRbJnGPjMnCD8tsa8cspxQgRrSlefW3yy67ZeSbZPuyEY/A6fydS6N7daCvE7K60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fbfy3VJj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso2221495e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892290; x=1759497090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuHd6eGYommvO3UskpqEqtJdP8+N3udV7UPBSp5lsjc=;
        b=fbfy3VJjC1yaYytPKZzTYRVoy+OCnUkOEtEIUZ3x3cYqigUyyXha5Va4UzDiOILmAI
         z/9bf24ITk1PxUsoK1WCTsDg7wY0GXAeUPCKIViGPcEP9BCiaDJ+LwEYvb6cDV8LIwkb
         D5w2rHp5jiXapkSCe1hEBuefH3fRV5/UiEHiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892290; x=1759497090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuHd6eGYommvO3UskpqEqtJdP8+N3udV7UPBSp5lsjc=;
        b=OHVgbKHSDttkpcnL8xkcfmXjraMFkQphcOg+Z9+QUjOyySk0tAWL4HFmIkkT9fWGeH
         IcQGtWmxxHCShMAXBmB5ICfY1tkQ8M9OoCrNbmPP82ab4gD3+ObiodoPjfbUfvI/3GEw
         J20gQrQdfW8jPsrGXGe4VobvuvdMpkBF/CGd8x2U3+usIRH/LeT/HgkWyxLS69B0Tp0D
         O4dfEiwFS5SZGCwaHt+vKlgcQWT7Gb/XcDKBQhKLPmkcGTXf8EVeMXz2+Hi14Mb2QCJH
         KURFmyOs8l0ghQ0fmSjUTtf371iEARE+KAIMXauBhqH3+CJ8SMzRqbzIZH0B9u/fiVnq
         C+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMLcj6xYpIo6c4k+Xv4GLX6gzU3hZKIlao9uLc5cEk55bLs7RlMl4EAvyzUxVK93Xz7Jl7oqkNSnBs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6EokwvUm2B5p6w6lBqiUEkpbrsdkOziuCXh1RhqXMVrj5F8uC
	tjVxad/+ROC5+mB0T6442M3MKcWEu+zfAPyPR3YshfdwKYrjTs/1FDjyQ3tpXZO4gQ==
X-Gm-Gg: ASbGncvvNSV4q5zDxUJF9yAv2fjJVnOxFfmvbaRkwM8jZ2Gb2U/ccM/LApHBnkPre11
	AGI6OF+BSlCbpfIqt+/R3/8eUpddNHg27gkbiOUChEvJsJk78il8G3hiq+LXDpWuMwIJMl5kgEq
	AM7zIPPIGIuNmcpl7rPHCfVbiFJuvrh7nHCqpRQBE1bNh3fJsMQBSzvkqd/352ZXB+8lpN9LDzU
	IryG37w3eRP8j0uq0WhuXz3wmjMU/8G3rHHSz7vR7ektALn9jkOLjbq0Mq0SAx0EirnpB/yb03x
	81tihm5QO6/RwHZ6pt7okl8DuKdkRAvNNqSI2mzQsuc5B0whllJQevqIdHL+xeki+x7zPN7qnOv
	+WUz0txyqRAzkq4uXQxgf2Uu5aQPNcisQ1FVHTvMj3tFy8FNQMxZ1UnD750SJlRwV9zLyBvonh1
	ObDcrWtHxEaeL6UkQWV3W4qYM=
X-Google-Smtp-Source: AGHT+IGBibbMbWnp4wsYYpcAZc4iOvKmHvOhd0/KxBOtu8sk83ypjF+oQ0w3P1LE9KQVYZ/8hnbPDg==
X-Received: by 2002:a05:6512:61b1:b0:57c:2474:3743 with SMTP id 2adb3069b0e04-582d2f24dbfmr2344139e87.32.1758892290146;
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:25 +0000
Subject: [PATCH v3 01/12] media: uvcvideo: Always set default_value
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-1-6dc2fa5b4220@chromium.org>
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
In-Reply-To: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
To: Hans de Goede <hansg@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

If the control does not support GET_DEF, the field default_value will be
left uninitialized during queryctrl.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Cc: stable@vger.kernel.org
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 2905505c240c060e5034ea12d33b59d5702f2e1f..a869257e9b7c07eaa7d725d107bd1cb57d3c7377 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1542,10 +1542,11 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 			return ret;
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF)
 		v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
 				UVC_GET_DEF, uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
-	}
+	else
+		v4l2_ctrl->default_value = 0;
 
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_MENU:

-- 
2.51.0.536.g15c5d4f767-goog


