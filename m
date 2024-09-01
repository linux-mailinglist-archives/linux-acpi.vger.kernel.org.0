Return-Path: <linux-acpi+bounces-8039-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BBD9674AC
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 06:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FFC1C210F2
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 04:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29381745F2;
	Sun,  1 Sep 2024 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WJTLa3qo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6344A4DA00
	for <linux-acpi@vger.kernel.org>; Sun,  1 Sep 2024 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725163632; cv=none; b=JOXfcEkOpyFWiXwWD0E6rmpT+YyT3AgCuOtcUIHWg790JXcgafjZeIq0u8SsGZhwizTbyKyMjRvlrMQuIZokglJDeWQJxHosDsefkQf8/FTP5k9nk049rrAUoebGq2gf4OFHiyuog8XntPFyfsvUQzKP1e7MVR3e0diAHLPGzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725163632; c=relaxed/simple;
	bh=aDCeN3nN9nRcFYme+ATD3OdKxYtiWgyuQ3zp7dza4rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KohmTsdU8MyPXnnZCc75iyI2A3PwOtQd63DgJW4qoIpWqAjdbn/RU4SgdpAmkmv23ACVuVSj6fUzCQgz142vy1dQXZs86dXTeLw7UySzyXsrZ8IvF9i01JkX/PhPzYhd8tcUEe5d8jEFTGbtiwOzu7RdCEhp9EnGpxCA22y+EQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WJTLa3qo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-714187df604so2471278b3a.1
        for <linux-acpi@vger.kernel.org>; Sat, 31 Aug 2024 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725163629; x=1725768429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5JhzkdOpb5d78Mk6klz+de8MRC1bwTsy8AL/60ewZg=;
        b=WJTLa3qoyk0o8c8bwUolzy0fd7V/v74p6T3zDATul4ZbEYLBTXuQeWy4vQC1oKPTVm
         oyBVmGEzoj8ncVtbDcdvxB18H4y9aL+dsRdcWGnK8MiyIq6uXdOHVkoxfcWirgDaFtRO
         rFeVGLMbcQfwGlIuWGPm7LC3NYi4f15QmIxLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725163629; x=1725768429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5JhzkdOpb5d78Mk6klz+de8MRC1bwTsy8AL/60ewZg=;
        b=bEntkvObtKKlA7GhVpnnBl5KuDkLCIPXk2RwGwwkmb5VG9Zjr5PJCwOarTg8ubUTUO
         KWWN2SWqcGc96fAsZorPANe9qLwNf/56oRoD7mHptTRrWsj+NayTOPAshYeCUSaXO2vG
         p3Ssy7V4OEFAOHdb98u5ssLYPi+LLE2pZPin/UpVkef0HxLbhxUUq58LJmZ+uDvL3pWf
         vVEkLqD487Cm+4QYLhMGt00Vmh+UnIWqpo3osemagl/To6Y1u1Sv66JDlUBpMAJJ6qNy
         i+W7IVtbq07m2J5FVIvCOLZosbw2FUAPSMStPBbhlwJkOJPJiyXFAvO09+bO8XaU7Uwf
         a2/A==
X-Forwarded-Encrypted: i=1; AJvYcCVdKiFKoEgOB6258cBR/qNvFcLejsBQ5qYPbSaoTphb7vyBuDRof6pit++tbnonBWswUHs4cFEMtBqX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZzTBJnzsX+N/0ftUsecnlTRxWkQvPQJj2x5BDHgbv2GzYf5f
	kfHb/yadseCQP1gcRYFEfPrkfzDy9DoI52wXvLYTzVMxo9vteAr2Qn9DfWiG9A==
X-Google-Smtp-Source: AGHT+IH443VeMjk4kx1Ih8MoClHHt+0Hz48LB1+P16Pb5YXD9rscHzWsBcV2jb1oYKBn+g57FtSFdA==
X-Received: by 2002:a05:6a21:9211:b0:1cc:e0de:c75a with SMTP id adf61e73a8af0-1cce1613874mr11265457637.8.1725163628444;
        Sat, 31 Aug 2024 21:07:08 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7d22e9d4b77sm4590630a12.79.2024.08.31.21.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 21:07:08 -0700 (PDT)
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
Subject: [PATCH v4 03/18] usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n
Date: Sat, 31 Aug 2024 21:06:41 -0700
Message-ID: <20240901040658.157425-4-swboyd@chromium.org>
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

Ease driver development by adding stubs for the typec_switch APIs when
CONFIG_TYPEC=n. Copy the same method used for the typec_mux APIs to be
consistent.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/usb/typec_mux.h | 43 +++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 2489a7857d8e..efb5ed32b813 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -3,6 +3,7 @@
 #ifndef __USB_TYPEC_MUX
 #define __USB_TYPEC_MUX
 
+#include <linux/err.h>
 #include <linux/property.h>
 #include <linux/usb/typec.h>
 
@@ -24,16 +25,13 @@ struct typec_switch_desc {
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
@@ -42,6 +40,41 @@ void typec_switch_unregister(struct typec_switch_dev *sw);
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


