Return-Path: <linux-acpi+bounces-8048-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A106E9674D1
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 06:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C09B21B4F
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 04:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD00C149E05;
	Sun,  1 Sep 2024 04:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jqDSt4Mz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45E3145A06
	for <linux-acpi@vger.kernel.org>; Sun,  1 Sep 2024 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725163651; cv=none; b=bSVjkyb7IADuSoNO332LS+vtnNFjkHuv+aPBSll6IXguftfTwt/wVjccxnUhONQ/3L/J/qzIgupEGvlL1seRo5Vz7yD75vVL1FVGCywwrNeywBspQhVo0CgaV5XiWaFa0hzcRGimw1y5pRabHbDNNSNQ0LwG+U2dDd3xxovXyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725163651; c=relaxed/simple;
	bh=aHxbXooyxcUO5JwBCTNyqni3GmuKJP5ay9S/7oeiMaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHW4GmmgFkbpX47J00nRXTLnHXHX/SPuhls8fpaaVxCmFfzTx9K5N372CROdBFd5YX9NiPgoEQSvQTWpy27W7RWoIZXjfu6fCfAXr7pMCcaKDZBN43I1y6SIHh4hMkLRX7BU+Tj2COrUniI5D9j4ngZnxNWfaPksPPg0ykyq8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jqDSt4Mz; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39f51371baeso2861995ab.3
        for <linux-acpi@vger.kernel.org>; Sat, 31 Aug 2024 21:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725163648; x=1725768448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVAbaFTBXgnW+fAYVEBW9D2cgqLAHsvQgjfJBzfAY3s=;
        b=jqDSt4Mz/biw9kj12Y2zxy1j2029nTuT14V9Hb6g5SLODgcCJDIGRQW8bH9n0OCQXV
         wjbMhdMDAmjjmSDPDiDQi1uapih5tpg6sMoVRNU/Gl9dQBx5JDx+ksRyPUEQup8nHyHj
         gVed2iWGCP0QwN2vTUCTW5TIdDbASSI2lVjX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725163648; x=1725768448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVAbaFTBXgnW+fAYVEBW9D2cgqLAHsvQgjfJBzfAY3s=;
        b=NpiAoCrB846fzGkHS5BzPD2GhQAGST9o3i9hEyQ4q2ukDzUJSdmSuqdYPMn/DR2hfA
         Qe26EDMs770e83gMaUK+9VcQFkGqAZ7fcEUa+8AL+6z3u8YJB4JKF8QzFZgElm691R4m
         LeTOUU3pkGPS57UUdI5xkCOI+Ltb14rrkMu3MTr4OMQ3v6DervsctT3ljPtwgVUe6UMh
         jqGRuWVg8IRkxmQX7XlQWpxrMCHkT5MejQ0+4A0WnaIRhRaadByBe0wuqJI3kEV3lXz9
         JvSW0pXrCt43WH5rgbnlQ8LKB9GenmWm9Rg4L2UyXVqYF3r/dYsYRcVi3arPMOO+BYbO
         oA7g==
X-Forwarded-Encrypted: i=1; AJvYcCXoKy2Rmhu1DrF7xZj4d2dO5UcJh9qPCAjRQgZTSrlTf28tX2OvXfkOT7FA1gjdMV0B0jSbBLmrod5H@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUxlEGKfjOJG+mcsCLYs5ZIyFo6u2Is1G+/2BzYhMlCzHbIQv
	J+LUSeJ0Ek/Jq1LdDO1EHVjoQKa3DdJ7k9T8qBxrGFXh1ygdFmPokfy6cETm/g==
X-Google-Smtp-Source: AGHT+IFsOTewMNJ0BJt0tAvMG/AJBfDBb9as9o8BHiOu5PQfrktxWGnHk+Ahlp9K/S8f1Bq4n28w/g==
X-Received: by 2002:a05:6e02:1c42:b0:39f:5646:97da with SMTP id e9e14a558f8ab-39f56469978mr14867835ab.20.1725163647832;
        Sat, 31 Aug 2024 21:07:27 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7d22e9d77f2sm5333884a12.89.2024.08.31.21.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 21:07:27 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Guenter Roeck <groeck@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH v4 12/18] dt-bindings: usb-switch: Extract endpoints to defs
Date: Sat, 31 Aug 2024 21:06:50 -0700
Message-ID: <20240901040658.157425-13-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240901040658.157425-1-swboyd@chromium.org>
References: <20240901040658.157425-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the usb-switch endpoint bindings to defs so that they can be reused
by other bindings. Future users of this binding will have more than one
type-c output node when they're muxing a single DP signal to more than
one usb-c-connector. Add an example to show how this binding can be used
and accelerate binding checks.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../devicetree/bindings/usb/usb-switch.yaml   | 74 +++++++++++++++----
 1 file changed, 61 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-switch.yaml b/Documentation/devicetree/bindings/usb/usb-switch.yaml
index da76118e73a5..f5dc7e23b134 100644
--- a/Documentation/devicetree/bindings/usb/usb-switch.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-switch.yaml
@@ -35,9 +35,12 @@ properties:
     $ref: /schemas/graph.yaml#/properties/ports
     properties:
       port@0:
-        $ref: /schemas/graph.yaml#/properties/port
-        description:
-          Super Speed (SS) Output endpoint to the Type-C connector
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+
+        properties:
+          endpoint:
+            $ref: '#/$defs/usbc-out-endpoint'
 
       port@1:
         $ref: /schemas/graph.yaml#/$defs/port-base
@@ -47,16 +50,7 @@ properties:
 
         properties:
           endpoint:
-            $ref: /schemas/graph.yaml#/$defs/endpoint-base
-            unevaluatedProperties: false
-            properties:
-              data-lanes:
-                $ref: /schemas/types.yaml#/definitions/uint32-array
-                minItems: 1
-                maxItems: 8
-                uniqueItems: true
-                items:
-                  maximum: 8
+            $ref: '#/$defs/usbc-in-endpoint'
 
 oneOf:
   - required:
@@ -65,3 +59,57 @@ oneOf:
       - ports
 
 additionalProperties: true
+
+$defs:
+  usbc-out-endpoint:
+    $ref: /schemas/graph.yaml#/$defs/endpoint-base
+    description: Super Speed (SS) output endpoint to a type-c connector
+    unevaluatedProperties: false
+
+  usbc-in-endpoint:
+    $ref: /schemas/graph.yaml#/$defs/endpoint-base
+    description: Super Speed (SS) input endpoint from the Super Speed PHY
+    unevaluatedProperties: false
+    properties:
+      data-lanes:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 8
+        uniqueItems: true
+        items:
+          maximum: 8
+
+examples:
+  # A USB orientation switch which flips the pin orientation
+  # for a usb-c-connector node.
+  - |
+    device {
+      orientation-switch;
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          endpoint {
+            remote-endpoint = <&usb_c_connector>;
+          };
+        };
+
+        port@1 {
+          reg = <1>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          endpoint {
+            remote-endpoint = <&usb_ss_phy>;
+          };
+        };
+      };
+    };
+
+...
-- 
https://chromeos.dev


