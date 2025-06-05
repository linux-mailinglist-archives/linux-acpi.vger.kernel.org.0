Return-Path: <linux-acpi+bounces-14179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D9ACF5F2
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 19:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F4A7A8492
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E398C27FD48;
	Thu,  5 Jun 2025 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zo+alpBC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45BA27CCCD
	for <linux-acpi@vger.kernel.org>; Thu,  5 Jun 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145996; cv=none; b=QZn69BYmckqruQJIoRasHoQ8M3TXKF6GhhGfI773VM0cINdRxD7NWyZ5hPkYgiDnb34F021H0z54J3ZMKLDbqwKPXUx7X0LAUN6iU6rKtVWDdkPi1YuWqdJfk8jZLoc+DXiEAuA2oDFsVB6I0KUKnmSLHzlkG2o4ovBKPn7ouGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145996; c=relaxed/simple;
	bh=ud/yG1CR5QNIjOMJtgHhzLjfPGyRK5X2yNstenoh6F0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9uLqcTx/jEibd+vEMlmKdKxy4xXA1cI+OhirZQnM6igJj6TxQHlCaZCAguXzPwWbpdVAPE4qpbLGwVl4G23al6lkVs1c/4bG1CvEK3xD3c2+8sXzeU3ho9+/dlzB/zx80phQ/7fOuc6+yLyk69q5fSYtG/EonOwS8QxZmw9gGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zo+alpBC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5534edc646dso1388092e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Jun 2025 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749145989; x=1749750789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9Qke5DC9C5R7oeoSiHKicNykKWx9HQwgMxvcWAUcsQ=;
        b=Zo+alpBC9ydAquWIpW+tcw7w9hjbZzS3WB0v4tV40PZFbtfrQA1Cmtckr2j8Krk+za
         f/A75+JcseniPbhdkoDdrYYQbkmzdx08B52fi0TIXzLMrNU4LxRF5FOOTDMQNfyQdwiQ
         hDMcCBsfKo7IkwzxdgV6Crsjoi/fEZyEDyF2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145989; x=1749750789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9Qke5DC9C5R7oeoSiHKicNykKWx9HQwgMxvcWAUcsQ=;
        b=KScs3hKarEeyIjZncMRLDiOLDgVRa5AT8NmBvph1Rqn4KOWGKlT8B5Wv/ggYvcmweC
         l43mIJZES/9x5TqxC0NIVB2SsMvsHWFMxgs4p66L2yX50mnXx0SA+Mm488jWQwXgOjr0
         EpH8hw5IWiw15QUJpK3CRuhDXdfASb4e9kGxuNZn8pCjBhiSm3+c7xWp0C10vDcA4TU4
         Qx3fOzUWlkPS+o2I9Y+oNYf9ym3Qfdi9kK8r0UiD0x9cSibdfsVn2sBvmcwq3pVALP2J
         +RrRgvwsuSp+s30Xb45iIeM0+kOysZhVmg+1gh05oqE7SHRWDwyBI1mQ6zsIAXd8UY0r
         Rvqw==
X-Forwarded-Encrypted: i=1; AJvYcCVtk7ro8mFuT6d6art2ikrmYwm3aJrLi8FdU+1xPlZnroqcLOrIVDMxNcWZA9vIyx+GDim2iC0DAfDn@vger.kernel.org
X-Gm-Message-State: AOJu0YwEI+uLfaK9T3ErOhDwK7t+TltUE5/8Y6RyU1VmkrutiIu2Qkuz
	Ezr+CeXOdeJVrBx8otnbAxAzPXcoORj7N+plvab8bG/jAxJ+c3NhdQ6t82putu3AXg==
X-Gm-Gg: ASbGnctSazUol2w1/vjtWBoaPDUSZLx5kVJuaqR+1saagtg8fXNqXZiXqkIZnWzV3NQ
	L5Z5MxOjGFRHJGB+4T6TIrUVWjsQxHYqx7ZIllPtZLRTUTgea07rLrU1u3zo1Yc3NWALR07C/vy
	aveS67fsh4oB4hdwk9rjpmYfKDLJ8hAkAKECUb27xYbMpbpyY96cH9YW1Cjzxk7sX8/Gij6zl+r
	/b5zNOVwgBL/7y1cBKkFAbWm9y2k4sAPmSO/+UhkGjnO5S2mHe0ftg9pHX49atMsEIw7LxTm3yH
	jbwrQUkJs2HFqHjyVyu/zjtWW8PPrjAQi/GrPFC6O/ZlgqRAO5n2Dmh7swQgpuJCzUoCvP/93Ds
	rniXQMJHy8KGbxQeb5AbkZgT7vQ==
X-Google-Smtp-Source: AGHT+IGkU0Qv4tzSIKsGHyevtVEeWEZfFr7MOjKvYk6divFF106BKU0YcQGNBaigtq0IO3jXnttxCg==
X-Received: by 2002:a05:6512:3da7:b0:553:2698:99c0 with SMTP id 2adb3069b0e04-55366c0e612mr15721e87.36.1749145989470;
        Thu, 05 Jun 2025 10:53:09 -0700 (PDT)
Received: from ribalda.c.googlers.com (90.52.88.34.bc.googleusercontent.com. [34.88.52.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553379379c2sm2641210e87.251.2025.06.05.10.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:53:08 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 05 Jun 2025 17:53:05 +0000
Subject: [PATCH v2 12/12] media: uvcvideo: Do not create MC entities for
 virtual entities
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-uvc-orientation-v2-12-5710f9d030aa@chromium.org>
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

Neither the GPIO nor the SWENTITY entities form part of the device
pipeline. We just create them to hold emulated uvc controls.

When the device initializes, a warning is thrown by the v4l2 core:
uvcvideo 1-1:1.0: Entity type for entity SWENTITY was not initialized!

There are no entity function that matches what we are doing here, and
it does not make to much sense to create a function for entities that
do not really exist.

Do not create MC entities for them and pretend nothing happened here.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index d1a652ef35ec34801bd39a5124b834edf838a79e..2dbeb4ab0c4c8cc763ff2dcd2d836a50f3c6a040 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -72,6 +72,16 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 {
 	int ret;
 
+	/*
+	 * Do not initialize virtual entities, they do not really exist
+	 * and are not connected to any other entities.
+	 */
+	switch (UVC_ENTITY_TYPE(entity)) {
+	case UVC_EXT_GPIO_UNIT:
+	case UVC_SWENTITY_UNIT:
+		return 0;
+	}
+
 	if (UVC_ENTITY_TYPE(entity) != UVC_TT_STREAMING) {
 		u32 function;
 

-- 
2.50.0.rc0.642.g800a2b2222-goog


