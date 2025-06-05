Return-Path: <linux-acpi+bounces-14175-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E89ACF5DB
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 19:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849C0188F496
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3310927E7D9;
	Thu,  5 Jun 2025 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V+0C9v+d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B127C14E
	for <linux-acpi@vger.kernel.org>; Thu,  5 Jun 2025 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145994; cv=none; b=F1mT3svZ91pKmSAMnJCKo8qdLy2gf1jcJHicZZkT5C2gb+oCuWhoMWRTeBYIYnArz60LubQeF0BGx/zpQ9n5/o+zYKqM0ZtFQ5pHdxYAAlzdCSiT4kbENH85R1VAPIQ4nc8/m88YZjyG9HA6KNvkaPbNSMfHkL/pSKXLkeJ7pNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145994; c=relaxed/simple;
	bh=R4NuKjk4LUn+NcJI1dWp1KbkF6gjPs2+DtnjDwx4z/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwWVdiFAgtoyJNWwq3WI47ArnqgCdy8ji9XILVbpEVVmBThZ0VlVB38Lfj/ZlNLMsUGe0UupowrwAekoXXqHKdjHZxJAOqcQMjoGmqurVD5balCZ3onJ9tPFlHhxkVAvLZT9kQZEgdNOcLtM958uaIj4KShzqVVsFzCYHv9IdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V+0C9v+d; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5535e35b059so1205512e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Jun 2025 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749145988; x=1749750788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKykJ86GJEjKAZ51EtUiBvhJS0VRnpbfEH3e5dzBR4w=;
        b=V+0C9v+d+sPzo+NIIu+xX4SgvhbNXZT1rIU/lO+otk7ArMDYMkCKVfP/HyVr7Gv7g2
         XgyTjdgtyNzyK8o98HyCCx7QsCFysvih4WgTvrcoVgdg2gXBC6HxPmrIL7x35V4oByyB
         Zw5erXMKN13T3/kcFHyctTALxIvFQWaJtsGdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145988; x=1749750788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKykJ86GJEjKAZ51EtUiBvhJS0VRnpbfEH3e5dzBR4w=;
        b=PmSFvc38AICWzS3PUa+IAco/Gft9osSYH1yvG40LlOo8/gZQ2H2Dt8qQ9U3xRd18Qx
         qsjQY/ex39cLNXCpXwAWdLs7fjEoKAgjtpDRkDN+C5TtJ0bJDGU2F+NW44rUuprLq+/Q
         lSp+4zXYiYGAxuzH/mUez7K+HJQFG/gOIWwlf/SOimfvOrU47ElIPvhu6WaBzDDOPxLA
         RdJH7LZ9MU5ioONeCKW/KE1yW9tA/3XJXWFddADqs/MumaNUo6ebt3Y1jcSWInSW7OSa
         9l8EerbmluRU4wv71vmD/S/TBa1ezm4uQx/Oxs1XzJvXwllHEhWpgnSMQMk1TIGW9ax/
         UGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUgHZUTwpcCLobe1XrsUij5lRiNtmbDxvg2CWcwDubGeDejYjyreTBKH+iqIJ6BHxcxO3buTn3Ak31@vger.kernel.org
X-Gm-Message-State: AOJu0YykfdLQKkQk44IfLFErP2yFKPhNyIlpUdI5PpPaFH0E2zFpt+yY
	xZm/bM0X6FZ541iYrpS3em4pvh9d/w9twIXmdjlxCw2mQ+bX0g6TK3u1EMWbrAxCqg==
X-Gm-Gg: ASbGncubT5l7yZXBZjsGz5ZOmt93EGb2xHBxnVmmI48S/7AF9YoG1OMc6WNXCySHYIN
	o03UcNRhWz9drgnjUAWn2ohJXG6kRjmuDJE7JuwKFKdqKIvdH3cQGYP65OAeUbm5V/9dOmdegUY
	aFz1o6ZHYasNbc2eSK2iW4bIhNQc4KvsYDHxqC5+P2cD/J/abk8GzhetmOqf24w3oXpBixkt4T+
	7fnjh5O4dlPWYrjYlfCXcXgk4EBXtNEGzMO9ruyzrm3BF7KBIunkNbQSPXe2jpry9S4EryapqnL
	eWiOZp0Ruvx4D7XgncoUMMhRiiypUqnZMO0WxgEyu6pYB74UG+S7dIYNX6xkYEWVkF7YyEaK5i1
	bqFrUtkt+KlCIG1c2EwmqmjiOSw==
X-Google-Smtp-Source: AGHT+IHp+xpg2FO63nkT7Lh5wy4seP/EyKn6xsYU+/2Jg59TJvy9YvZlmgC6AlIASMeTxBqC41J75A==
X-Received: by 2002:a05:6512:239d:b0:553:35bb:f7ba with SMTP id 2adb3069b0e04-55366bf08b7mr21355e87.11.1749145988208;
        Thu, 05 Jun 2025 10:53:08 -0700 (PDT)
Received: from ribalda.c.googlers.com (90.52.88.34.bc.googleusercontent.com. [34.88.52.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553379379c2sm2641210e87.251.2025.06.05.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:53:07 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 05 Jun 2025 17:53:03 +0000
Subject: [PATCH v2 10/12] media: uvcvideo: Add get_* functions to
 uvc_entity
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-uvc-orientation-v2-10-5710f9d030aa@chromium.org>
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

Virtual entities need to provide more values than get_cur and get_cur
for their controls. Add support for get_def, get_min, get_max and
get_res.

This is a preparation patch.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
 drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
 	if (query == UVC_GET_CUR && ctrl->entity->get_cur)
 		return ctrl->entity->get_cur(dev, ctrl->entity,
 					     ctrl->info.selector, data, len);
+	if (query == UVC_GET_DEF && ctrl->entity->get_def)
+		return ctrl->entity->get_def(dev, ctrl->entity,
+					     ctrl->info.selector, data, len);
+	if (query == UVC_GET_MIN && ctrl->entity->get_min)
+		return ctrl->entity->get_min(dev, ctrl->entity,
+					     ctrl->info.selector, data, len);
+	if (query == UVC_GET_MAX && ctrl->entity->get_max)
+		return ctrl->entity->get_max(dev, ctrl->entity,
+					     ctrl->info.selector, data, len);
+	if (query == UVC_GET_RES && ctrl->entity->get_res)
+		return ctrl->entity->get_res(dev, ctrl->entity,
+					     ctrl->info.selector, data, len);
 	if (query == UVC_GET_INFO && ctrl->entity->get_info)
 		return ctrl->entity->get_info(dev, ctrl->entity,
 					      ctrl->info.selector, data);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -261,6 +261,14 @@ struct uvc_entity {
 			u8 cs, u8 *caps);
 	int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
 		       u8 cs, void *data, u16 size);
+	int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
+		       u8 cs, void *data, u16 size);
+	int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
+		       u8 cs, void *data, u16 size);
+	int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
+		       u8 cs, void *data, u16 size);
+	int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
+		       u8 cs, void *data, u16 size);
 
 	unsigned int ncontrols;
 	struct uvc_control *controls;

-- 
2.50.0.rc0.642.g800a2b2222-goog


