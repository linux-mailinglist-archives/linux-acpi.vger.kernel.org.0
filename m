Return-Path: <linux-acpi+bounces-8038-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EFF9674A2
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 06:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9361F21E69
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 04:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF154D8B9;
	Sun,  1 Sep 2024 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aNzUSEg9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A33BBC2
	for <linux-acpi@vger.kernel.org>; Sun,  1 Sep 2024 04:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725163629; cv=none; b=JnQNVTXbLtgkFpGD/yPlQXDKRZsWmpMdu8+XZUcJyPkI6Auu5I/cmtrMHfakthqs2oXYcjJqXHmFDetBTjGjuFsSruTaQ+SIto/YeHgj7OES9hHIcnLaxyQN2A7yyDPRWU0MZhmGuoXG7i6Sir/C8gLH2ty3l4T/Ms3GgBXdFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725163629; c=relaxed/simple;
	bh=pZ7ktacniNaKMda1L3Z6XilrG7hHXha97/67GYjaAzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uu0FTUxeO8k5j0lHtEroXcGukQooYAHfQ/8JlgHXpEJDcaaqvABYfsEKpI1WbHR7Rm7Qwv2GIYoyvncbyQ85xtRH3BOI/ZMreNc22gPhjFTWi11EE1CguJMZPBhicPyOVQPev/1JBHN35OaXhkLs3fCzttJNjvza/bAtXDp6xMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aNzUSEg9; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5dfad5a9c21so1282564eaf.0
        for <linux-acpi@vger.kernel.org>; Sat, 31 Aug 2024 21:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725163626; x=1725768426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsT6Pyy4WdREZdfc6RLc4+Jmxiv/uouJ028bXKINCs8=;
        b=aNzUSEg9pnhOYvMbwY8uXM54dt3waMRYHfrCn1Q9WYJddI6w/2XUMqHZfn+hD7X/jM
         lQgdXnWHpGftkb9CtOPfsVrIiTuwcKPpYTmLqrggWePT5ix1sh8JfHbOteFezbhim9vZ
         3IxaMeNrDJ1daKoVHjUtcGdi4q8V+zH4zzQpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725163626; x=1725768426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsT6Pyy4WdREZdfc6RLc4+Jmxiv/uouJ028bXKINCs8=;
        b=wPjeJiaXxp1PBmMkv0oHKSa4xU9ebFZVFrxbxcXIuvBDXdI9ZOkAnG7AUipyO0+eqF
         jydh8l7AeBZCuLiDyuqf05uWpJLKlYLbdxaI3kLK30kO4blE2Eu9RNJIBKM5JuDqeUU6
         YqddkhUMZ4PQolNpM64w4e19hj8273OYz1xopuD2AiXFfl9XiveEQzneHbfPBBrklI0J
         uWbb6OkrAb+7k/kLHzomIzr7Tegi6eDF3n7lSu6trnbFZFJWnfAvGtrIYEqJwfzmPG86
         7+nEXv76ymvwlg2B3eXL8TRxC7Y76gE0qO6R1AgzHwS3MD3pGAe+ELxziasT+aVbQYKy
         SYnw==
X-Forwarded-Encrypted: i=1; AJvYcCUv2jZWLNzfUb8hv8tSZYMjoyaN0V+Fqek/RTV0u8qseWH3rlbHsJPG+72d50yv0+n4n1uOmVtbM+eJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vlHXqee2XfnkgTKR7I5gB2cIIgQfCVcTg9TmhJowWqCmdA5s
	JNEEVRs0aS1hjoxOZ8P+CphgcDH7DJ2BqcEYXPQ+WlJsAQWwbyjpb/+DnPIooQ==
X-Google-Smtp-Source: AGHT+IHtz1LVfFf3gG+hTwV6UQ2tt7nrnC8wrXqjk3Bxp7NafXmwM2C1wRlTdUffnPNfcbRmXcHwSg==
X-Received: by 2002:a05:6358:24aa:b0:1ac:65e7:919b with SMTP id e5c5f4694b2df-1b603beb8afmr1222369855d.6.1725163626398;
        Sat, 31 Aug 2024 21:07:06 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-715e56d78e4sm4847550b3a.163.2024.08.31.21.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 21:07:06 -0700 (PDT)
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
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 02/18] drm/bridge: Verify lane assignment is going to work during atomic_check
Date: Sat, 31 Aug 2024 21:06:40 -0700
Message-ID: <20240901040658.157425-3-swboyd@chromium.org>
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

Verify during drm_atomic_bridge_check() that the lane assignment set in
a bridge's atomic_check() callback is going to be satisfied by the
previous bridge. If the next bridge is requiring something besides the
default 1:1 lane assignment on its input then there must be an output
lane assignment on the previous bridge's output. Otherwise the next
bridge won't get the lanes assigned that it needs.

Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: <dri-devel@lists.freedesktop.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/drm_bridge.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index bd18c1e91dee..e350248ba5c2 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -860,6 +860,10 @@ static int drm_atomic_bridge_check(struct drm_bridge *bridge,
 				   struct drm_crtc_state *crtc_state,
 				   struct drm_connector_state *conn_state)
 {
+	u8 num_input_lanes, num_output_lanes = 0;
+	const struct drm_lane_cfg *input_lanes;
+	unsigned int i;
+
 	if (bridge->funcs->atomic_check) {
 		struct drm_bridge_state *bridge_state;
 		int ret;
@@ -873,12 +877,25 @@ static int drm_atomic_bridge_check(struct drm_bridge *bridge,
 						  crtc_state, conn_state);
 		if (ret)
 			return ret;
+		num_output_lanes = bridge_state->output_bus_cfg.num_lanes;
 	} else if (bridge->funcs->mode_fixup) {
 		if (!bridge->funcs->mode_fixup(bridge, &crtc_state->mode,
 					       &crtc_state->adjusted_mode))
 			return -EINVAL;
 	}
 
+	input_lanes = drm_bridge_next_bridge_lane_cfg(bridge,
+						      crtc_state->state,
+						      &num_input_lanes);
+	/*
+	 * Ensure this bridge is aware that the next bridge wants to
+	 * reassign lanes.
+	 */
+	for (i = 0; i < num_input_lanes; i++) {
+		if (i != input_lanes[i].logical && !num_output_lanes)
+			return -ENOTSUPP;
+	}
+
 	return 0;
 }
 
-- 
https://chromeos.dev


