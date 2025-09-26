Return-Path: <linux-acpi+bounces-17348-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6EFBA3C93
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C474C620FB7
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9302FB0AF;
	Fri, 26 Sep 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ek5B5R6n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07642F6175
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892298; cv=none; b=QN/fEd63c8UJEagjnmVL1q00rDhI1VuoOR543pvXzOsBHFiDu4L8HwZ+ja0/8lf3t1NMaiiNEOyo+Cjp/5Xl319HPjQ+IAVsjHEmVf4w9bek6ZEHqlnANvi68zjDU2PxOriS2Z1TigfDQyuA6IMkwNvYiY8XP0RfIsLNvs6m2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892298; c=relaxed/simple;
	bh=80G8sSF8+f0UAG0XdkLdvNrCi6HOOZflBRDxb6bYpC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghERM+KBVbMnmsrazGG/4VYY4CT46gxwE0cjVBJXV58vgfzdisdWhkALr5FbDUGIC/xRV56wTZCS7lsRRuVhyafxrNeUH/7AQXl2M4f7hy4qeVAM8NAjBp8iJ/AqY+DfQDVJX7E5/WmHqcg1mXIlVuyUDq8s40VhYkxniEl8z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ek5B5R6n; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57f1b88354eso2214391e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892292; x=1759497092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LO+ZRHeTAK51LRbge1abR5CWq6P2opiI+XHVYGi/IpE=;
        b=Ek5B5R6n55TSnFKW0GuBypFweQw8X4sOVkixEjA4uyqhsvIn6ccW6DzZmT/t1ZxIpq
         KV4V0Le5Yd95VxYU1TIFCUhpW5v7iogHPO1YvW182Iee7j/QfExD7vmseSG/CWTsRX+7
         g6EV2uP4aswmFDEfn316QTgEvYGOIMVCsu7bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892292; x=1759497092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO+ZRHeTAK51LRbge1abR5CWq6P2opiI+XHVYGi/IpE=;
        b=YQqLqDbXa4m4ZkhneaAs7IiwC8njY1GxnV9NfohtO6CsMp+lHYm/ZN+oyu8L2xlDMl
         tllwpxTIqCSsvt9Pb+9wJIEiNeup541B/DO3xauCzi3fflXDdCwV4M659Vt5siXGVDPr
         eWhdGaPsMIGOvDWnzf//i2+8iS/E+7SHdGAAXVkyMBa5CDnj3IhddgIrnreM2JpEJJZ7
         6N9BVOud9Opye7xrNLTsZJQhmLMUMUfTcnrvNTwg3rueO6+zUcOUG0ywgNUORIGXH2Sd
         uDrRiTmHcbiwG4VDwTDEwaHZmz8cHDZ6Pyzha7YkoXTmddGT9maCtVI3io7su1+bd2JH
         5Ibg==
X-Forwarded-Encrypted: i=1; AJvYcCXbPJtBS87YPoQDkpdms4aFbpxy9Feschyg4xQxc8Unh6/mIq59vMDUSJSDrk/aKZA3OJwH1cH840ab@vger.kernel.org
X-Gm-Message-State: AOJu0YwYrSNGLdNCky8UnaCfgyQgq7L9IqMSfYZxl5gsnhFDEWOTfZbQ
	tpZ9Ha5X3ec1DzUY+WTDlp+GTy1Q0DwwRdOtFmv4E9YYhw027no3lc2dsLw8XVoWyw==
X-Gm-Gg: ASbGncuXruBpFDbMYctokakq3gnM01jYCVLYXUY6iUyPBC4QmDGFw097zlmxTB0F2vL
	rDrQmIF1qaItkMdEFwGjowrKpzIihtFsijH7cpIUvNEOxAd+OHNgV4Pkyfx+E6FNFq2t+AQwb4D
	NRmhslw2d8odoAlswczQb0msR1+Z2WXSTJDwVs6eQ9/ajmtFSQl1yDVN2bld+ypJLZm5FjrfDhn
	i4z4QN6jxPuF47RX9OR/TvoULv2I8eYCIq+NGlXtF0CKph+AowIYqSix1ieBzIKgwooWY+YCwrW
	7HgGcWxAGNPqUALRhK/LVB885uyubV7tX+a/VYmsnFbhq9o2T3TfVMXWcIcATrUN77Vevvjm+Xb
	cSZ9itVs4mWWPcDIQPoYGPW8xkWInF7dJowqvjrSJJvpLIgTCBSk1164dFrq3XXMgN0n19CkoKB
	EoTw==
X-Google-Smtp-Source: AGHT+IEKOz9hLF8FHkWrsyP0/Z6mTRW5uekYu6y0CaJ96qJRiudQJlAsNVVlhQMiizZElwgvlCzXEQ==
X-Received: by 2002:a05:6512:b12:b0:57a:310:66a8 with SMTP id 2adb3069b0e04-582d35df2d7mr2404401e87.55.1758892291516;
        Fri, 26 Sep 2025 06:11:31 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:27 +0000
Subject: [PATCH v3 03/12] media: v4l: fwnode: Support ACPI's _PLD for
 v4l2_fwnode_device_parse
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-3-6dc2fa5b4220@chromium.org>
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

Currently v4l2_fwnode_device_parse() obtains the orientation and
rotation via fwnode properties.

Extend the function to support as well ACPI devices with _PLD info.

We give a higher priority to fwnode, because it might contain quirks
injected via swnodes.

Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 84 ++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index cb153ce42c45d69600a3ec4e59a5584d7e791a2a..4110f64d3277e652473f991fb58d191862f98eb0 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -15,6 +15,7 @@
  * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
  */
 #include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -807,16 +808,69 @@ int v4l2_fwnode_connector_add_link(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_connector_add_link);
 
-int v4l2_fwnode_device_parse(struct device *dev,
-			     struct v4l2_fwnode_device_properties *props)
+static int v4l2_fwnode_device_parse_acpi(struct device *dev,
+					 struct v4l2_fwnode_device_properties *props)
+{
+	struct acpi_pld_info *pld;
+	int ret = 0;
+
+	if (!is_acpi_device_node(dev_fwnode(dev)))
+		return 0;
+
+	if (!acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld)) {
+		acpi_handle_debug(ACPI_HANDLE(dev), "cannot obtain _PLD\n");
+		return 0;
+	}
+
+	if (props->orientation == V4L2_FWNODE_PROPERTY_UNSET) {
+		switch (pld->panel) {
+		case ACPI_PLD_PANEL_FRONT:
+			props->orientation = V4L2_FWNODE_ORIENTATION_FRONT;
+			break;
+		case ACPI_PLD_PANEL_BACK:
+			props->orientation = V4L2_FWNODE_ORIENTATION_BACK;
+			break;
+		case ACPI_PLD_PANEL_TOP:
+		case ACPI_PLD_PANEL_LEFT:
+		case ACPI_PLD_PANEL_RIGHT:
+		case ACPI_PLD_PANEL_UNKNOWN:
+			props->orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
+			break;
+		default:
+			acpi_handle_warn(ACPI_HANDLE(dev),
+					 "invalid panel %u in _PLD\n",
+					 pld->panel);
+			ret = -EINVAL;
+			goto done;
+		}
+	}
+
+	if (props->rotation == V4L2_FWNODE_PROPERTY_UNSET) {
+		switch (pld->rotation) {
+		case 0 ... 7:
+			props->rotation = pld->rotation * 45;
+			break;
+		default:
+			acpi_handle_warn(ACPI_HANDLE(dev),
+					 "invalid rotation %u in _PLD\n",
+					 pld->rotation);
+			ret = -EINVAL;
+			goto done;
+		}
+	}
+
+done:
+	ACPI_FREE(pld);
+	return ret;
+}
+
+static int v4l2_fwnode_device_parse_of(struct device *dev,
+				       struct v4l2_fwnode_device_properties *props)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	u32 val;
 	int ret;
 
-	memset(props, 0, sizeof(*props));
-
-	props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
 	ret = fwnode_property_read_u32(fwnode, "orientation", &val);
 	if (!ret) {
 		switch (val) {
@@ -833,7 +887,6 @@ int v4l2_fwnode_device_parse(struct device *dev,
 		dev_dbg(dev, "device orientation: %u\n", val);
 	}
 
-	props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
 	ret = fwnode_property_read_u32(fwnode, "rotation", &val);
 	if (!ret) {
 		if (val >= 360) {
@@ -847,6 +900,25 @@ int v4l2_fwnode_device_parse(struct device *dev,
 
 	return 0;
 }
+
+int v4l2_fwnode_device_parse(struct device *dev,
+			     struct v4l2_fwnode_device_properties *props)
+{
+	int ret;
+
+	memset(props, 0, sizeof(*props));
+
+	props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
+	props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
+
+	/* Start by looking into swnodes and DT. */
+	ret = v4l2_fwnode_device_parse_of(dev, props);
+	if (ret)
+		return ret;
+
+	/* Let's check the ACPI table. */
+	return v4l2_fwnode_device_parse_acpi(dev, props);
+}
 EXPORT_SYMBOL_GPL(v4l2_fwnode_device_parse);
 
 /*

-- 
2.51.0.536.g15c5d4f767-goog


