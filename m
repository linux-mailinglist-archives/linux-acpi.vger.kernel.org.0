Return-Path: <linux-acpi+bounces-8050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF85E9674D8
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 06:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97091286557
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 04:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6414F9F1;
	Sun,  1 Sep 2024 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MtHlbcCl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415A149C6E
	for <linux-acpi@vger.kernel.org>; Sun,  1 Sep 2024 04:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725163656; cv=none; b=nLiBOKcDDaN+OH/+ly7x99Aufnzjr/Gc8Gqk8fUm/VscA9+Qhaa3o02BJl9NTHJ+djIbVCBC9vBCih7ibWFFIrtqzNE6EEjFdDSFHmXAiGNsPaGD8SwKH4Qv3OWJQcHwUFmd/BfmujKp4OX8Lr42l8y09qEk+5qwpxhxIm9ZH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725163656; c=relaxed/simple;
	bh=bHSm/FEpQTjOcYpuqVvRWkTQn5fPAWRWSsjkb7Wydpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rsyza4fCPno0BnAonkLBqoKkcIhHONam3FdocEeIk+0G32ulFzNFVjTk7DSelmF/Dr1rgLdcwHv+sAFdLZk5w79VSwWiLXSjLOpujDZYt/sPF8qS4x1b43r0Sno9IPqM/QkvjAy1rYn1m+rlhDkWTSV6P0OGQhWHOSNanbVaHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MtHlbcCl; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so2275528a12.3
        for <linux-acpi@vger.kernel.org>; Sat, 31 Aug 2024 21:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725163652; x=1725768452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM6GJPpKkvUSSBy7VkQZRdWnaSLWrHTVpkTkbaZHopw=;
        b=MtHlbcCln3qEnn2YtZXv+ZqXeEHbB4jdFtfytehXtjGGEHJImtraFeHMN6oLL/exax
         r0/bqu2GH9wacI9D96XovObBerMDmkRKMisuIKjjJUh6tOMldqJy9eesKPPrbTMiliy+
         g7rM0713DkY3N2+/GQc79Tw32l5uIQ3gs4xdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725163652; x=1725768452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM6GJPpKkvUSSBy7VkQZRdWnaSLWrHTVpkTkbaZHopw=;
        b=pAl+SBiiVKFm8e5jxDj6AzvHeFOZg+sgBjhTkJaEBP8ei/p4Fj9SrKpC/mi7PHSAIc
         Bw++CnO3V5q6Mh9gHaVOvbto2SN6t/NpCxHtDly3ZzPcS41/smY4PaCgzY8oS5WTVP09
         M0T9w2lSiVmTfsF3NPCsWGjFC5/pBlRO+SwPD6QFuNGIJ0/5qbpfHc6kQKXQIUVbniW9
         l6iRN9sUQgxwHRt4J4N4a/bTPgtgrJQB5JBlstHQcJp4QKIM8Lez0yedAl5O7Co5ndIi
         nFbclHcGrCQdGBI2HMrbpKy9XbRJ6pH6M/pSTKwnfmm3AecgLP+rrzNATWxhehMarBEu
         28zQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZONbDCe3BFUBp5nEVeMBB7neAeKQvPUlHWKZqOz5FyLaax0HioBICtT5MM8L9vsiiPVEoCeP8Kds@vger.kernel.org
X-Gm-Message-State: AOJu0YwysYu+XBEzutJE4y342QKaNpTNRPkEtBXe+7gnp8vqfjG4MjRK
	Yya7O7JyUNu3zduhRJclFlNzJ6XzqD6ps/HIE2qWTHYYqxdcuyfAXo2znSNylw==
X-Google-Smtp-Source: AGHT+IEBZFVJryLmpEcn+rd/P1ffgAono4nzaKo7Lu5B6szTV31kzRn9qLEAbPf1ik2MymYrUHGCHA==
X-Received: by 2002:a17:903:41cf:b0:205:489d:2b22 with SMTP id d9443c01a7336-205489d2dd3mr38959905ad.23.1725163652216;
        Sat, 31 Aug 2024 21:07:32 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2056595564fsm3120865ad.229.2024.08.31.21.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 21:07:31 -0700 (PDT)
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
	"Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 14/18] dt-bindings: Move google,cros-ec-typec binding to usb
Date: Sat, 31 Aug 2024 21:06:52 -0700
Message-ID: <20240901040658.157425-15-swboyd@chromium.org>
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

This binding is about USB type-c control. Move the binding to the usb
directory as it's a better home than chrome.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml     | 2 +-
 .../bindings/{chrome => usb}/google,cros-ec-typec.yaml        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/{chrome => usb}/google,cros-ec-typec.yaml (90%)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index aac8819bd00b..c991626dc22b 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -99,7 +99,7 @@ properties:
   gpio-controller: true
 
   typec:
-    $ref: /schemas/chrome/google,cros-ec-typec.yaml#
+    $ref: /schemas/usb/google,cros-ec-typec.yaml#
 
   ec-pwm:
     $ref: /schemas/pwm/google,cros-ec-pwm.yaml#
diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/usb/google,cros-ec-typec.yaml
similarity index 90%
rename from Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
rename to Documentation/devicetree/bindings/usb/google,cros-ec-typec.yaml
index 9f9816fbecbc..365523a63179 100644
--- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
+++ b/Documentation/devicetree/bindings/usb/google,cros-ec-typec.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec.yaml#
+$id: http://devicetree.org/schemas/usb/google,cros-ec-typec.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Google Chrome OS EC(Embedded Controller) Type C port driver.
+title: Google ChromeOS Embedded Controller (EC) USB type-c port driver
 
 maintainers:
   - Benson Leung <bleung@chromium.org>
-- 
https://chromeos.dev


