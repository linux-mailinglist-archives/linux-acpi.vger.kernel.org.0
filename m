Return-Path: <linux-acpi+bounces-17352-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A9CBA3CC9
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 15:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FECB62351E
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323622FC03F;
	Fri, 26 Sep 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BmGX5Z0P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469822F7AB6
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892301; cv=none; b=shPweu8otfx0h4G2Pupy3X76F6A9RXSncy89VahvGsGuFkaGzdXzGYkjIMAYtOYWsbw28X5JXb/5VGsiJFOhJLBuOopW6fy9WgsJS5Gw6xNS3UBta+lRbC4Qxvpy4rWgLq9JEjltK/j4mg57gHX/L3xgZZ0H6fCMdbZywHATIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892301; c=relaxed/simple;
	bh=7+uj94r/7LeT/xAkBfTGJ8aSRCSPNzAL0fCA+D8DD2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6CobseOcy5GRUoCRWjM5nlyNmB40aVLNLoiVNdUtkzISI7PuvIuVNMfZvzLyPjBCSa9+4le0Tl1nMjqAaChhdShovGwOB/CweJVrmkDY+lXvfx8p+zBXMa3bqZ2PPAv3rZU7hPZZUwALLhBtxDqAZ9SH7ZXpduVUy5kWSihQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BmGX5Z0P; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57afc648b7dso2642389e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892294; x=1759497094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCy6Bk8e0KycgUL3e8TXrZ2btc+fiyl+rPdd78IS8Is=;
        b=BmGX5Z0PvX78ztmXsmk/MgO7YHO5kshdUTFo6L3WtxQhR3b37olVG9YSfVpI3QmYAI
         EhK0fDcsUSUO3HgE8vLcFK4A664M8X+Bzz0LHtyT64tXMPIS3PsEW6oAJDGLJiSNZl7E
         dXCAQzyq95/E8D537XqgOO3WqhOEOUoH1rkh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892294; x=1759497094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCy6Bk8e0KycgUL3e8TXrZ2btc+fiyl+rPdd78IS8Is=;
        b=DQNEaZlgTkpStIi4j53ej0lz/jUr6o7Vg6tRvOyFXRX6O1d7BmdREMNGnJfkbnUXVR
         00Bf73fx7q2ezKI6fQoWc2vX2TjPP+tgk7jvz4H3ct6aeNvRw0VIJBQP3Hy6gkTXMqFJ
         QAEGOWMcyDkCOzw7r/5Etacnl94gqNGA+MrRdAydilLoIEgtairYEqdDrp61g1qIEdud
         bbpd1N1d5XorDDBdl/DZNgi+lht27N9sxrXHRLQ5BLsseyba8CNZprMaFi2BRoy/DJ2y
         9/Un/PmM/+2IeY4EpwiVdQjUojcxRnYrMCCqXY7cQhP+bffeJRlk91KfS0tn/wca7Wro
         emRw==
X-Forwarded-Encrypted: i=1; AJvYcCWBdpH/25EgdEmtvKZvM0CpAaK94AXi71DKgUKWlrbkLMt7PgL9w6XV35mtWi9jrqKSpQ9mxAfu2mgK@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXBN4fmY4vZ52zgd5HPW7JWNOUxY6NkePm8UIhFoWJsyr+55g
	Y6p7zg7ZBEibbTJ4HeyrsUJoxwa5Idqy9RmOqEPGTOz0bMLrnsjxuCb85ZehVKcBeQ==
X-Gm-Gg: ASbGncsTX6jUxZfbvvG/5D/odzDDzeLdRK4UXASMKEdmyUwSBAcIoU11c5RFyDO+Q8w
	PmyEAu2eAaEdefm8JMoyINbXtO7BK/iYCzAZ1XEiTSyoYZQUGFZ1thyyIiOK6J6jluILKsduRx9
	SOEZ0NI5B+QWeGLd9lOvMrszQFKj18JDNbWv6ioyms19pdTHISh/Em0DVfPB6SNHwzdcMNd7jI5
	/NNwR5Em1AX8XjjV6eeAgK8Nw06ifsIDm1Xwm0RUuxdCkjPDmN7Y6Xrjqg/fU/G/vGb0ZBulkIK
	wqF5PtmDqfH0V9JulEdt+hilfnh3SfBPMi+/q9zt2KurBiRjV6ECyqkQJYSqged+ixaOjSnyfsr
	POAYid2GmzsIbVUtk75R2skxt9YEe59gbAgyxHAT3gVyV28WKbEeRQ2irYhh6m5Dg9NEHmLquxc
	Wviw==
X-Google-Smtp-Source: AGHT+IFSULi7NpOrywI1NGNOQUbBJbkaKZRrtRNyEnHKO4o1kB5FT5TGBNkhNPYRfI8ePxwjL+x0fg==
X-Received: by 2002:a05:6512:15a9:b0:57a:2be1:d773 with SMTP id 2adb3069b0e04-582d406b8a4mr1982976e87.53.1758892293940;
        Fri, 26 Sep 2025 06:11:33 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:33 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:31 +0000
Subject: [PATCH v3 07/12] dt-bindings: media: Add usb-camera-module
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-7-6dc2fa5b4220@chromium.org>
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

For fixed cameras modules the OS needs to know where they are mounted.
This information is used to determine if images need to be rotated or
not.

ACPI has a property for this purpose, which is parsed by
acpi_get_physical_device_location():
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#pld-physical-location-of-device

In DT we have similar properties for video-interface-devices called
orientation and rotation:
Documentation/devicetree/bindings/media/video-interface-devices.yaml

Add a new schema that combines usb/usb-device.yaml and
media/video-interface-devices.yaml

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 .../bindings/media/usb-camera-module.yaml          | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/usb-camera-module.yaml b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e4ad6f557b9151751522e49b72ae6584deb0c7ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/usb-camera-module.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB Camera Module
+
+maintainers:
+  - Ricardo Ribalda <ribalda@chromium.org>
+
+description: |
+  This schema allows for annotating auxiliary information for fixed camera
+  modules. This information enables the system to determine if incoming frames
+  require rotation, mirroring, or other transformations. It also describes the
+  module's relationship with other hardware elements, such as flash LEDs or
+  Voice Coil Motors (VCMs).
+
+allOf:
+  - $ref: /schemas/usb/usb-device.yaml#
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+properties:
+  reg:
+    maxItems: 1
+
+required:
+  - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    usb@11270000 {
+        reg = <0x11270000 0x1000>;
+        interrupts = <0x0 0x4e 0x0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        device@1 {
+            compatible = "usb123,4567";
+            reg = <2>;
+            orientation = <0>;
+            rotation = <90>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ee8cb2db483f6a5e96b62b6f2edd05b1427b69f5..1503502a3aed2625e8ff488456ccd7305cc74ba7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26258,6 +26258,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 W:	http://www.ideasonboard.org/uvc/
 T:	git git://linuxtv.org/media.git
+F:	Documentation/devicetree/bindings/media/usb-camera-module.yaml
 F:	Documentation/userspace-api/media/drivers/uvcvideo.rst
 F:	Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
 F:	Documentation/userspace-api/media/v4l/metafmt-uvc.rst

-- 
2.51.0.536.g15c5d4f767-goog


