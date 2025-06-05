Return-Path: <linux-acpi+bounces-14170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD4ACF5CA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B3C18849C4
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B4627AC3C;
	Thu,  5 Jun 2025 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mAIbvnSb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564427A123
	for <linux-acpi@vger.kernel.org>; Thu,  5 Jun 2025 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145990; cv=none; b=EyZH1D3NGG1mN8FjzFisCFVluFZILYMg31G2Y3ArcCS0hDOH8NsbboEd4+con/CDehUHVPfXfPlTflJiiHnEUuE4fOxOGf4Vwl8qEC21zwsiJW5qfU+53aXvo/reJQdJMZaBbvLPq0CNkvh4iGFJh6Fp+0mc/VMaKnorN8hD/Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145990; c=relaxed/simple;
	bh=HkpzCJY6QMUo/A2tmF9l8NRgkFwGl+Bw/RVcSwiZ3nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXOfxUoLnhb8t5VfNmg0zIBuInsRX9nNoazhcq0zUp5UL7+ZWjyKH7ozalDHO6KylwaVKHprfR3sPI5ylPdOeati3h/B093+Lgq2qzqll7gzShnrVGa2CeANBUWM0C8HftfEK0egE3FJXnAQSVANG/Qi521yTPNGPvEEZEZTZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mAIbvnSb; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5532f9ac219so1512588e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Jun 2025 10:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749145985; x=1749750785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAddCa1zo14U93p/hxz3tXNuMoufL4dFoj1aELCNFac=;
        b=mAIbvnSbSujXriDone/jjS4I6hRdXbCA6Sb+MUaRuNWkIv0C+UTJskIZwnosB21vDQ
         GM5uBqOYGmjZmzBvzcWO3BRwgYvDA47BfeHSLZnpiQTPE8wlGEXSrIfXPI+cTZjNueI2
         ac8/+2ZXhvKnXpb3IYUEHaoCIdg3h+8EuvdfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145985; x=1749750785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAddCa1zo14U93p/hxz3tXNuMoufL4dFoj1aELCNFac=;
        b=AdLFxp93qxwUWloFamhKix4SxSt8KqrxwfeHMUZuKMsWlZtOJTrehh9cQtVGOteIWs
         7kl/CAB4FcEnS0AmhjBVVsGvuqBUEbzsisBzmnLBr9IBU0zXROqsSj46rX3uYGuWMURK
         5+nCde70PHGBMLU87kJqMcqHVqySx+TQVe1HiOe1yRNv8NGW2Fgbx9CJBE2OGyO2UtaV
         fNgf0ogTldIbpmNKOZ6ThiiSAotRlSAOPs6/JpxDAcb8swpUgdpD5jwId4lV/4n2uk9V
         yK0a/jcYz6DsQ01pLEKm4mcV7nGbnZrsDjlKmZjzTRmvcAQ4n6hKxbKDGQjBUcohJxaA
         IVOw==
X-Forwarded-Encrypted: i=1; AJvYcCVHkuGq6hcj4Tvo4c9dXZl60WBNjLm7rxR9cZlau9AbWFtGNx+Hz5OCxhNrIfb1wsd9sSuGYLqHlKKh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+PomDuLNdLD8ftTeLeRQjmeBgBUwzW2WB23qDgiRm2TboQK1D
	lhqtjMbrve8VzWCxHNXRFiOwaa2SoL9eQoQxmeJnBgghoFFDoV/H2xnSByHwQkmoWQ==
X-Gm-Gg: ASbGnct3iUDJU3yTHU1KV/bCsYD6RNVzy0LY3qKYKTrkAx2ahCvnCxx8SaDV0RrBhtR
	4jhtH39LqjlM7ts7KR6vT1ddQ0C8sGRsPzgiKAjOdllvHaFgAGvuJous8U/kZ5rViKUrkeKeOX5
	5+TPwfp01E4cpiBjcou+jMjI8JkjaeCRSjxi6EHUCPBA3ydJL5Wk2iJQFilDIj5Ne4rPjs6pDkU
	afq3NwkyRAXUdnvmZXZg17ibT6FRxwd1MqDD3I3WiIcWYg17Rx+w26RCCjlZMXL7z9B5NMeOxQ0
	Y7tscW1VqjXLohXkgn2Z1xrjnkXMuQCd+b3pkLah7yE19HPL2npwu8K4YydiSfBRbHQkHjjCFjd
	FcRU0/gMeKZh+wC+gvCJs76F1cg==
X-Google-Smtp-Source: AGHT+IEuQ3DoWfSTvrnWbXmxFE5uIRwAzd3dzxpPZvGceJdrS5ZQ7/hUcchLBDj/wBd6vU9oMBKPzQ==
X-Received: by 2002:a05:6512:3e0f:b0:553:30fc:cedf with SMTP id 2adb3069b0e04-55366c1ee9emr20515e87.38.1749145984851;
        Thu, 05 Jun 2025 10:53:04 -0700 (PDT)
Received: from ribalda.c.googlers.com (90.52.88.34.bc.googleusercontent.com. [34.88.52.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553379379c2sm2641210e87.251.2025.06.05.10.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:53:04 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 05 Jun 2025 17:52:57 +0000
Subject: [PATCH v2 04/12] media: ipu-bridge: Use v4l2_fwnode_device_parse
 helper
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-uvc-orientation-v2-4-5710f9d030aa@chromium.org>
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

v4l2_fwnode_device_parse now supports acpi devices as well. Use the
helper instead of re-implement the logic.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 83e682e1a4b77d9d97b2988750732d0b7c9087b3..020aa52f590d66b6d333adc56ebfb9ab0561db51 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -253,36 +253,16 @@ static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
 
 static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_device *adev)
 {
-	enum v4l2_fwnode_orientation orientation;
-	struct acpi_pld_info *pld = NULL;
+	struct v4l2_fwnode_device_properties props;
+	int ret;
 
-	if (!acpi_get_physical_device_location(ACPI_PTR(adev->handle), &pld)) {
-		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
+	ret = v4l2_fwnode_device_parse(ADEV_DEV(adev), &props);
+	if (!ret || props.rotation == V4L2_FWNODE_PROPERTY_UNSET) {
+		dev_warn(ADEV_DEV(adev), "Using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
 	}
 
-	switch (pld->panel) {
-	case ACPI_PLD_PANEL_FRONT:
-		orientation = V4L2_FWNODE_ORIENTATION_FRONT;
-		break;
-	case ACPI_PLD_PANEL_BACK:
-		orientation = V4L2_FWNODE_ORIENTATION_BACK;
-		break;
-	case ACPI_PLD_PANEL_TOP:
-	case ACPI_PLD_PANEL_LEFT:
-	case ACPI_PLD_PANEL_RIGHT:
-	case ACPI_PLD_PANEL_UNKNOWN:
-		orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
-		break;
-	default:
-		dev_warn(ADEV_DEV(adev), "Unknown _PLD panel val %d\n",
-			 pld->panel);
-		orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
-		break;
-	}
-
-	ACPI_FREE(pld);
-	return orientation;
+	return props.orientation;
 }
 
 int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)

-- 
2.50.0.rc0.642.g800a2b2222-goog


