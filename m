Return-Path: <linux-acpi+bounces-7681-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E459577B4
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 00:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583F91F22135
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 22:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF91E3CC2;
	Mon, 19 Aug 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ePdLa7Xc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3241E2131
	for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107127; cv=none; b=nUxjOOo7eQJm51p0PS86S2UB9pz491c3tpM8W+XLkBDxmUmGgx8whXP/Dgyq3le5XslebyHiBXYuShfK0B+ryNlSsxA+cNwp5UZ6Dy3pNuve+p70EtVU7wZsNWjm0rVDtTs2EWn8eNjWz9ni15CKaK143FYI+zoJfeScIsCx0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107127; c=relaxed/simple;
	bh=hmBdC6OuP0fFMyUtA27W3obsdBheUiPiVi+Dyq4Fm3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kt8T0HODthNEiGh67bf5uq6V14wJVf0QlGp4gKkrI2l+8G85RW9fPRTUjGsjiRT11msUYUNKs+XvMwY1F4Zp/R2uM3XCSoa5M0vSlNlN6UvQlonl28xp7b2cAk89eMJCAi7rPLkI2sJKKhsuPCHxOueO5HU7s/hAhwwDxb8uups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ePdLa7Xc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7126d62667bso2828534b3a.3
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 15:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724107124; x=1724711924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjBNYQFa86nn8t+X15a2kIDQUg5jYzam5K2eZ8YJJCA=;
        b=ePdLa7XcIVPNhQinKCFS4ITvYsMkVautP+zrmeNMl3a2U8Il4eNRRylSlgdzMYHl+o
         oAZq9lyFS1HlsNzQQVtklCAm5NFo/ZudmzbMfd3lSZcoYGXYEJMOkcPbdm8fOUJIHLQd
         6+2Kuz52DX5vdqdojuu9lBevY1KFbQpNk79ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724107124; x=1724711924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjBNYQFa86nn8t+X15a2kIDQUg5jYzam5K2eZ8YJJCA=;
        b=WKavvGLTPfO5mJh8smCghqbVCO+S0dRyGeLDfZj/oUVVxwoVezV7WWCbu7w/4lbXHC
         2x88oIuh3SB7oS7L1xmir2H/Iob060R+K1FbzSCOmv5q5wMd0QbacfP13YkoQUFWLAkf
         GqyQi+IYFerNasSoINXJtiDaRVOzdYOEq0MPIFA51wY413fMGsxaisjq8AQV7+kckU2Y
         INRLi8/mi3McCrXucN5h6C61KuO6YdT7DZhpPJdTQkiYESL+8UXgrcz0lgkWWOqqEzHJ
         PeYPtzS9+29pQAV8q21gaGcgI3xLNpbraHgW5A1ItWW1BDsL0F/dyvFYBw1rpkrM4nRn
         +oZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVstO0Juw9Rxd+xJuUEAKuQ6q0RAJMl5MAlFysXpovh4HQ6v3p8wuEpuRk4nYqMPFx1xNkKOosspPSXC5nFbgUdN+qV6ns+vPkpdA==
X-Gm-Message-State: AOJu0YxHAps5G6N5Q/CGMEvMr4y2nsm+yKySCobF9hWrEHpgBs3FucEg
	Ht37Sm8mbUyYpc18s4/tqMnH1z1FFl/MonCGVTIkheHoM9ibfDDuuzxga/8y7w==
X-Google-Smtp-Source: AGHT+IHN/xP/IACjD57PXeDLdL97bMvELyNSW6GYvHFV5SlTTara1vBX1rN2aloQvAb4+mpkicUw5g==
X-Received: by 2002:a05:6a21:150b:b0:1c4:bbb8:5050 with SMTP id adf61e73a8af0-1c90502ae63mr11606193637.37.1724107123237;
        Mon, 19 Aug 2024 15:38:43 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7c6b61c6bb5sm7011137a12.33.2024.08.19.15.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 15:38:42 -0700 (PDT)
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
Subject: [PATCH v3 03/17] usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n
Date: Mon, 19 Aug 2024 15:38:17 -0700
Message-ID: <20240819223834.2049862-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240819223834.2049862-1-swboyd@chromium.org>
References: <20240819223834.2049862-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ease driver development by adding stubs for the typec_switch APIs when
CONFIG_TYPEC=n. Copy the same method used for the typec_mux APIs to be
consistent.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/usb/typec_mux.h | 42 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 2489a7857d8e..094585205264 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -24,16 +24,13 @@ struct typec_switch_desc {
 	void *drvdata;
 };
 
+#if IS_ENABLED(CONFIG_TYPEC)
+
 struct typec_switch *fwnode_typec_switch_get(struct fwnode_handle *fwnode);
 void typec_switch_put(struct typec_switch *sw);
 int typec_switch_set(struct typec_switch *sw,
 		     enum typec_orientation orientation);
 
-static inline struct typec_switch *typec_switch_get(struct device *dev)
-{
-	return fwnode_typec_switch_get(dev_fwnode(dev));
-}
-
 struct typec_switch_dev *
 typec_switch_register(struct device *parent,
 		      const struct typec_switch_desc *desc);
@@ -42,6 +39,41 @@ void typec_switch_unregister(struct typec_switch_dev *sw);
 void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data);
 void *typec_switch_get_drvdata(struct typec_switch_dev *sw);
 
+#else
+
+static inline struct typec_switch *
+fwnode_typec_switch_get(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+static inline void typec_switch_put(struct typec_switch *sw) {}
+static inline int typec_switch_set(struct typec_switch *sw,
+		     enum typec_orientation orientation)
+{
+	return 0;
+}
+
+static inline struct typec_switch_dev *
+typec_switch_register(struct device *parent,
+		      const struct typec_switch_desc *desc)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline void typec_switch_unregister(struct typec_switch_dev *sw) {}
+
+static inline void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data) {}
+static inline void *typec_switch_get_drvdata(struct typec_switch_dev *sw)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+#endif /* CONFIG_TYPEC */
+
+static inline struct typec_switch *typec_switch_get(struct device *dev)
+{
+	return fwnode_typec_switch_get(dev_fwnode(dev));
+}
+
 struct typec_mux_state {
 	struct typec_altmode *alt;
 	unsigned long mode;
-- 
https://chromeos.dev


