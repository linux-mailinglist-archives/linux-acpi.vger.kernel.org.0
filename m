Return-Path: <linux-acpi+bounces-17347-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8518BA3C6C
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 15:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C311687A8
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87D2F83B7;
	Fri, 26 Sep 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W3fnMtY7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30F2F60CF
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892295; cv=none; b=ulhYWdlMZDJ+lKtPu/rRO/4mOElAtZyzgRjpRWoq48YgGOM63Eol4pumVnW3Orem3tXc/xYsZjBL7nU1yc/at4rGgH+2xuNNJ5GPnJcFo2tMO3QKcH5qlGJ3NMfPwpdrlv4NLq98Fq6iB7xakWtcjwq38MK4H25c8NKPHh8miCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892295; c=relaxed/simple;
	bh=HOaXKeMMBeof7Hx+tzoNDTO3vGlaHvg7CjV+p573b/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ERBXdVt9175gyY+rZpilLlBKXdNXz0Srab6nh0YR19jvAbABq39pFvM7bEsRBkI3ry5q+F/KpHi3LOZykMwTzUDkYUWQm1FxqXd2ScGPrsUbPgaQRhHdrIFFrjxjZhp9vQg6NbE9gXpc0piinDa+FNpeiUg1jEHd5EM1inX2Zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W3fnMtY7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso2509489e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892291; x=1759497091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zavqbvAJpl+vVyZ8ZvtBFYz19hBaBOc/P6wczkVBqDY=;
        b=W3fnMtY7RjqTLLDo7fzH9PJwwFjlLgWOiWVpSz3GM1AcM9VAqRpDxKfOEdmKVo4S2I
         XBdaLHBPk4EAGufl1mBMbGd292pNFTULimhrWJkJMQQgXTCgMozzhgjL+Qz66suCxhmd
         lahvQdfpNYueP2CVJHkP2abV3KmqPkBb2i+VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892291; x=1759497091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zavqbvAJpl+vVyZ8ZvtBFYz19hBaBOc/P6wczkVBqDY=;
        b=orGXzsuRJhCfKDUjU3NzJ9BmCeH3wmYeRzMkY2Udfi5A5ihHj6Pj/hVV5ew7AxSumS
         kMoS8NcaNxKaFGhc7FEnsb3mRUb8gvOaHTeGBV6tMeK7UvPdOU86jc+2iknJxU4ggtc4
         DBxnKN+KYC1ryEasharbhxZCbIzOYeTLF41glC+0JsM9dYsrlu92qIhl3ofouf2qSsrH
         Vqvzykkzf0GssROETQ2H+PCHrYCieR3yQM0VKd418SCwSHrc8pqVvAcIoqn/Xm70eoNH
         EWxWJ9IDlasVrlBIyfIZnICBTas+QJeyD7Wb0262gi7HNUPNAv5torQY77v6ofTIEic5
         Jhvg==
X-Forwarded-Encrypted: i=1; AJvYcCWP5tdyp0gl+6dyYdk+fsnlNCZk50NkTyQWbl05ugxCkcNJNNQxA0Uatv9zm0mDooB6e0ZNTEjaP7hK@vger.kernel.org
X-Gm-Message-State: AOJu0YyVB+A1GU4iSrMnRx6VWlyeI0P6ut7XfuPU+tamUWOxlzkMJV4P
	uxzM2ey715tLaWaji4jj/HX7kEAwkAWTop7y6/DLbFKL+gVoEhfkqHTJ/0Wi99Klzw==
X-Gm-Gg: ASbGnctL3Slbj6WzAQXJ/3NliUO1mPtpAUscs4D99JBy8h1NJGhBpg6XndwaB7J/zHO
	J/Ide4wrsEw0eq4ioBVFsSIqV2niwmNJmok1V2CCVihAq4FQarUVxPCLCQtdLwbSY5obKqJy9gB
	oZVL2wQCRTbHAh5pd1ueJ1T7S1BHODLdrxAISYOsgjgZ+zIGJnKjwGKFtmG9rWO2M2UkB4GBfj2
	JjTwk/LISCY4cyYifyy28JoVbl8SgBKkSbkXwHF+X+uqRZyt+MxdpXn1aYRAwhRnINFjWOquv7r
	58pq83x2tYuxWJkjmcTPpgOqLmf0IhTk8Vj8aBWGcIQRH44grYTavBY3snbnX5qyEyzmN2JootI
	OHdqQjs+D4KZowmY+YylEbScZAvZWqZ4CVA8EI4mCeFftPrvOjrnMDZ6Hw84oXfUUPp2TRKW7Q8
	yEdCjTVQ7bRCGt
X-Google-Smtp-Source: AGHT+IGYNymib7YkYpDINQtE5FTKayVP9W8HaNUBBncx14Dot8LXrbwZoz7D11yG6qpiPKpfo0xmbQ==
X-Received: by 2002:a05:6512:b27:b0:55f:435e:36bd with SMTP id 2adb3069b0e04-582cd97cc3dmr2187251e87.0.1758892290687;
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:26 +0000
Subject: [PATCH v3 02/12] media: uvcvideo: Set a function for
 UVC_EXT_GPIO_UNIT
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-2-6dc2fa5b4220@chromium.org>
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

All media entities need a proper function. Otherwise a warning is shown
in dmesg:
uvcvideo 1-1:1.0: Entity type for entity GPIO was not initialized!

Please note that changes in virtual entities will not be considered a
uAPI change.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index 3823ac9c8045b3ad8530372fd38983aaafbd775d..ee1007add243036f68b7014ca621813e461fa73d 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -85,6 +85,7 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 			break;
 		case UVC_VC_PROCESSING_UNIT:
 		case UVC_VC_EXTENSION_UNIT:
+		case UVC_EXT_GPIO_UNIT:
 			/* For lack of a better option. */
 			function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
 			break;
@@ -105,7 +106,6 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 		case UVC_OTT_DISPLAY:
 		case UVC_OTT_MEDIA_TRANSPORT_OUTPUT:
 		case UVC_EXTERNAL_VENDOR_SPECIFIC:
-		case UVC_EXT_GPIO_UNIT:
 		default:
 			function = MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
 			break;

-- 
2.51.0.536.g15c5d4f767-goog


