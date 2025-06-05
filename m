Return-Path: <linux-acpi+bounces-14173-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C22ACF5D1
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 19:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE57E1889E85
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB7E27D763;
	Thu,  5 Jun 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I1VnEq3T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC427A931
	for <linux-acpi@vger.kernel.org>; Thu,  5 Jun 2025 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145991; cv=none; b=lyYoUZ0QmDqt0Fh7A2VuCFDfEr6hQX77+1C303NSYYWSukKfJdvWV0bCJ2GmGim5enbh3y6McPc9XI/CUMakdmfbF0fLqTONseof7qsu0ssplTbHeZO0kCOMKtZCqzZp6WhoYgYXdQJQJnGUic5x2Zr2169ZZr0Tsa6CPG2PIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145991; c=relaxed/simple;
	bh=NngJ6Yx0t8C9t8P4XXbFrpgjfgvwAkcfBnBpT4lxGFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qlM2OTCJw5AVeqXc7kkoiv9OwZt4+g3chHQfpWrM5sLfpaCWFnW5eZtFDV0+Pb3781I2z3u+IpEnUxK4/g+YXRuf3SZ6nubLmW7nrAPR1m7XMFQCoY95utrLdgi0ctISpLIen/AmEutIs/551SXmwvk9u6r0pAKakbHd+r1PvQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I1VnEq3T; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55350d0eedeso1399641e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 05 Jun 2025 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749145986; x=1749750786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ar8+oEy28CepxnVsr2jEiRDXTfDok/weLPLs5Z9kVHA=;
        b=I1VnEq3T8ddqhvoQ5NQEukgf98kgl7JFV0+hJFR08RpOZNJJecr1c0dpbMFgc2cV05
         0qvwE/NiO1qE7Mp+j7Wh7nVnDoL2Ul0nM8dMnVCvPQiR8V5swuaCtKPfusjdb1M3GaMR
         wlX1GOuM584IpO1TFQgHjYERmMzoyas7NAhKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145986; x=1749750786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ar8+oEy28CepxnVsr2jEiRDXTfDok/weLPLs5Z9kVHA=;
        b=JORwSSqjcBTpihB9PQVBbVJf2qF06UrBtaWysKENQrgRgM+Q2MCZce1+rqNZQbmZ1a
         HMjaSUzoU2vL8wCZjzFtqjFRlnnPrZFAHoj3TV/4B6l6Kn3kH+xGpVa9NM/jEpaX0JYa
         yjHgVsS6PIg4Z6RkMh6qytRopMt88ff1DbTUcHxPikiXdeQ5RQk81VEZhLn6QQz4RmE+
         bFkbaxxqQ993926M5EyzJsRrV2tfvWFuZEWPbuPgBrHSigQ6z2ev0wPa9+YJL0bHqBV7
         rRh3vJ2oJAO27GKto5i46l5Zyi5jIW/dtkIqRU0LIA+NbGZOg3PO0ITEsV8jF5QyUL8E
         myxA==
X-Forwarded-Encrypted: i=1; AJvYcCUeNUimqar3ikHwIBMIIGKRyCdrQAH+PjbIzg70QKbDJ6xIzONmWfMw72fW2pPGfM1M3lSp1Pb6oH0k@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6WwZ+ELXd0UqMBeAwhdHN9serf3/U/M7PiQX7Wj5cM9sNa4X
	W9Vj4Coz21q9RjmhCGep7yQDH+VB83khy3odNjHmpr5Wi+7A/XWhahl3akaNCErBJg==
X-Gm-Gg: ASbGncvxSEYNjjyIQi0ujSlmyKx2p2XH4DZaFgPAWCAsu42qNujo91NltAdDEXwDssu
	DRxs+NLLAI9ilk01d2zeS2EuNYyD0Oa37oqak1biAFpdjkMZ6cKyjm/moGhyQWVslLHdh7BC2pE
	Dn0UkpYXdfCkoL/Al23bipvJ5eVDyMefyH9JTjYuS+/tzzwMtVDpLeMG+P5HmHIvi0sB61bK8wU
	4llvnEfya7Vzj8uLEhWP9hSLzT4l08h9exkngFRpzulsyuEfzvF2u/m4GNwRQy1uEoe8ljdfI/Z
	UtE38PVvsCkiqoKdC4AvMYhKxLB8m3cmqcA4cZcKvUfJzC3jPI/aUUJ/3BlKutCJMuRgA9D6HPD
	ORKIVMSLB3IKJ3zS3Huuk8wmBYEMaqPttgRcq
X-Google-Smtp-Source: AGHT+IGuo9eAuj3/ZulUgVYVuEINR6TV4aJnWcXikBTGTDNlZ8YqpVl3rERmqVeHdcMBB1locGc5IA==
X-Received: by 2002:a05:6512:2242:b0:553:3892:5ec3 with SMTP id 2adb3069b0e04-55366c354f4mr16249e87.46.1749145985864;
        Thu, 05 Jun 2025 10:53:05 -0700 (PDT)
Received: from ribalda.c.googlers.com (90.52.88.34.bc.googleusercontent.com. [34.88.52.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553379379c2sm2641210e87.251.2025.06.05.10.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:53:05 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 05 Jun 2025 17:52:59 +0000
Subject: [PATCH v2 06/12] dt-bindings: usb: usb-device: Add orientation and
 rotation
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-uvc-orientation-v2-6-5710f9d030aa@chromium.org>
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

For some devices, such as cameras, the OS needs to know where they are
mounted.

ACPI has a property for this purpose, which is parsed by
acpi_get_physical_device_location():
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#pld-physical-location-of-device

In DT we have similar properties for video-interface-devices called
orientation and rotation:
Documentation/devicetree/bindings/media/video-interface-devices.yaml

Add rotation and orientation for usb-devices that matches the already
existing properties of video-interface-devices.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/devicetree/bindings/usb/usb-device.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-device.yaml b/Documentation/devicetree/bindings/usb/usb-device.yaml
index c676956810331b81f11f3624340fc3e612c98315..a44eb24c657993f88145377a4706ec419b6cd998 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-device.yaml
@@ -44,6 +44,14 @@ properties:
       - minimum: 1
         maximum: 255
 
+  orientation:
+    description: If present, specifies the orientation of the usb device.
+    $ref: /schemas/media/video-interface-devices.yaml#/properties/orientation
+
+  rotation:
+    description: If present, specifies the rotation of the usb device.
+    $ref: /schemas/media/video-interface-devices.yaml#/properties/rotation
+
   "#address-cells":
     description: should be 1 for hub nodes with device nodes,
       should be 2 for device nodes with interface nodes.
@@ -103,6 +111,8 @@ examples:
         device@2 {
             compatible = "usb123,4567";
             reg = <2>;
+            orientation = <0>;
+            rotation = <90>;
         };
 
         device@3 {

-- 
2.50.0.rc0.642.g800a2b2222-goog


