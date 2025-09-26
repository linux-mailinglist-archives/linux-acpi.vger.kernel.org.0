Return-Path: <linux-acpi+bounces-17356-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B737BA3D0E
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 15:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E043B0D15
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F522F6173;
	Fri, 26 Sep 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FS/SKx5K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04A2F998A
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892306; cv=none; b=MDdBzVrbzpXmivrYabDJKLHyQ/0Cc4T13QOL21M2DbR0UiTuJi8es4KGLqdk9nqdjGoJs7dgI5TSnHFYk5sbVH8Re04k8p5qQEnLuKPNIlL7U8a5YeQg/DyYoh1TJKwhvz9xY0xeI+coxtzCJNcGDvnRRA0DRbOSL06Gg1R4SdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892306; c=relaxed/simple;
	bh=yNrpERf5BIoxndB/IrDgg7F9IXcRYdRqRLfZtrmT8XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FA4wp5rLx5P/tXWA/VSQ9kMeuwP1lcPCM0RoRMwo6VCv7x7nfXA45gpRwqoqf5IyvUzQHyMF3vsYhXT3L8KjNs488Z3NNYtIFWRznX89o69srnwM3zhQyr2007b6uM8uYOQkob+3v5x8czIHt1sW1XcwLtW31uouwzHZ3UG9nJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FS/SKx5K; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57bc9775989so1975484e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892296; x=1759497096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjB3MTX3Joa1/7HOctJXxE5CXor1VUYeSlxA+suqIgI=;
        b=FS/SKx5KlPs+jWLyH4wmJlgYY2EAyt5dORj4RnuYMdbpynQ/AkDgAZJjXC9Ylt/RLC
         AosBVdJq9E1M/RmODFDre9MaRmNiRBDpP/njUiRMqbitzjlgXMrrhjUd9AbC5rsTZ4lO
         +nYyunniXwcWawYBCOPp955C6FmII0OMEjbD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892296; x=1759497096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjB3MTX3Joa1/7HOctJXxE5CXor1VUYeSlxA+suqIgI=;
        b=twXciaDZyPVnLUW6OPgkwAWVjcezGLVD0KzIFDkgpdIKb68Z75yfCNns74LzbSU6aX
         wXgtJW9mc3efU0P6TnUQNrtKMOUrMJ5zC3gIv37W6FxQkvZ2m45NkQYNwek27UerEIAl
         YVtqb2gioR78kbp3KM1JLK7LcZ1eWWtD4Fdr5EKN3qNCvywqUOjE/EXF1njv9ep1VxD1
         VfEAYxwiYGU6OcGXyRPdl4cBPaA5ALXWJ7ENwEO4PhMIodsJtGbFZ9Mi+DX4hOegm4PO
         8lLRanyEfmg7YRQAsl6lvdss6OAzAB3/JeES7L9G6TebWTSsFn3+K76ckmhUSaGbKAzr
         amgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWacjnOx9eFbIzsZcLWZIC7fASaskX0UOWIWoyYMa6AtMnCS+sr/psFLUyl3azppuHIwhzuLLVxEk33@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGMtlunwbB4cLMs1NqgiHm2e022tkabjbw1f7VZjH29/BZjCj
	kOPZpKlZMd8ySOU+dO3iLRo+X7u21/UqcQK/k9fE0IeaaFOIZ3Xa7M0/c4g8/9i5RQ==
X-Gm-Gg: ASbGncuewQ85eWcha9b22bJ4v/hyBw3LzCTR3wH/YUQST1kS2neM7hgaIVSkTIgPLGq
	aeEjnh7apNcIb9ZaVd4ubYKuFwlg2NuMzdW1ng5z9WXlICeelwTfTJzyaMWmA2V1DGTS1kEnLWY
	h0oDYFo93r5f8Gx+J1wuUpJbgoeazZF2fWl6ePM9ospepFtBuSBfxzGJhivnn9jbVC8DS8ACQ9y
	QmjOtm2G5q3N7BrP5s4ATvQ00Lr7CY1kYUt/PqzMVXOMNOufmJFKey5nEd+wiOJRh+7hUf09gUp
	fNgCQc6gdeCYkgXEMIHDVwdTPrJ5gVP4bMzYpGpbxYiaLyrT9TFlEOcuuEisF2MdfFgO4kaTrhb
	0jocZMx+2gBy6HX0IdEHYH6v2RuMpu0YxzLFj155zw06VksduAHaBw8qWo6P0LTGBJ7PDRRVhy2
	0KYYqAEod6j/ML
X-Google-Smtp-Source: AGHT+IHWNSHIhM8+wxqoK25vYQcpiuX3y8F3tCAqdPjxFUiAxRPF90tmVAHpAHEn0gJRDF4m3ruBAg==
X-Received: by 2002:a05:6512:234f:b0:57b:7c83:d33b with SMTP id 2adb3069b0e04-582d34eab93mr2494739e87.47.1758892296391;
        Fri, 26 Sep 2025 06:11:36 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:36 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:35 +0000
Subject: [PATCH v3 11/12] media: uvcvideo: Use current_value for read-only
 controls
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-11-6dc2fa5b4220@chromium.org>
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
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

For read-only controls that do not support GET_MIN, GET_DEF, GET_MAX or
GET_RES use the current value of the control or a constant number if the
current value is not available.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 76 +++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 017165a5c94459f1befd4c08f85a2017c58d61e6..e99fdf4bafbea662556798fe345a48b9ffd8467b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1548,6 +1548,50 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
 	return ~0;
 }
 
+static s64 uvc_queryctrl_single_boundary(struct uvc_video_chain *chain,
+					 struct uvc_control *ctrl,
+					 struct uvc_control_mapping *mapping,
+					 u8 op)
+{
+	static const u32 query_types[][3] = {
+		{UVC_CTRL_FLAG_GET_DEF, UVC_GET_DEF, UVC_CTRL_DATA_DEF},
+		{UVC_CTRL_FLAG_GET_MIN, UVC_GET_MIN, UVC_CTRL_DATA_MIN},
+		{UVC_CTRL_FLAG_GET_MAX, UVC_GET_MAX, UVC_CTRL_DATA_MAX},
+		{UVC_CTRL_FLAG_GET_RES, UVC_GET_RES, UVC_CTRL_DATA_RES},
+	};
+	int idx = -1;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(query_types); i++) {
+		if (op == query_types[i][1]) {
+			idx = i;
+			break;
+		}
+	}
+	if (WARN_ON(idx == -1))
+		return 0;
+
+	if (ctrl->info.flags & query_types[idx][0]) {
+		return uvc_mapping_get_s32(mapping, query_types[idx][1],
+					   uvc_ctrl_data(ctrl,
+							 query_types[idx][2]));
+	}
+
+	/* Use 1 as the default step value.  */
+	if (op == UVC_GET_RES)
+		return 1;
+
+	/* Read-only controls can use GET_CUR as min, max and def. */
+	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) &&
+	    (ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) &&
+	    __uvc_ctrl_load_cur(chain, ctrl) == 0) {
+		return uvc_mapping_get_s32(mapping, UVC_GET_CUR,
+				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
+	}
+
+	/* Otherwise, use 0 as last resource. */
+	return 0;
+}
+
 /*
  * Maximum retry count to avoid spurious errors with controls. Increasing this
  * value does no seem to produce better results in the tested hardware.
@@ -1573,11 +1617,9 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 			return ret;
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF)
-		v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
-				UVC_GET_DEF, uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
-	else
-		v4l2_ctrl->default_value = 0;
+	v4l2_ctrl->default_value =
+		uvc_queryctrl_single_boundary(chain, ctrl, mapping,
+					      UVC_GET_DEF);
 
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_MENU:
@@ -1608,23 +1650,17 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 		break;
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
-		v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
-	else
-		v4l2_ctrl->minimum = 0;
+	v4l2_ctrl->minimum =
+		uvc_queryctrl_single_boundary(chain, ctrl, mapping,
+					      UVC_GET_MIN);
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
-		v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
-	else
-		v4l2_ctrl->maximum = 0;
+	v4l2_ctrl->maximum =
+		uvc_queryctrl_single_boundary(chain, ctrl, mapping,
+					      UVC_GET_MAX);
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
-		v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
-	else
-		v4l2_ctrl->step = 0;
+	v4l2_ctrl->step =
+		uvc_queryctrl_single_boundary(chain, ctrl, mapping,
+					      UVC_GET_RES);
 
 	return 0;
 }

-- 
2.51.0.536.g15c5d4f767-goog


