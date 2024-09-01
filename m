Return-Path: <linux-acpi+bounces-8047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA53A9674CC
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 06:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488591F21E45
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C00149000;
	Sun,  1 Sep 2024 04:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jNrnS3/H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F337143738
	for <linux-acpi@vger.kernel.org>; Sun,  1 Sep 2024 04:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725163649; cv=none; b=gnDeBAtBwF12qsnrFOy9M31bZ+lRjy7BHpVET60Y6JnDCQuXoi4pv4PgO1/Y5Hqb1jLy0gAdmdcS0PA5tGejHC3H9ItMMgS+ySwu9Jth5Z8wsSUsgxBmQAT1wrP/W1hm1Lr4Oy+u65REO7C0W1Vt0eIDGM3DH8L4kjYEum74FVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725163649; c=relaxed/simple;
	bh=+zyMv3RGe6S6LrOSBHIbaRGTiGQgsHff7zfMdzmNV+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPK+uN9VDOjgQeNruUhwpKmjEfWXm+I1Og+20ySgrXUlnSwUaQEc6ez+EGQF2ApM8oB5WxcXdIlFDNSJempE+j9A0JFNyLIfu9jNabyicoFRb3YztmQLyrT3EhchlP0w3v1d7WlyvG5OP1P0Tuk40pLDwayGk8TeX2nmqVi3nUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jNrnS3/H; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2021c03c13aso25461285ad.1
        for <linux-acpi@vger.kernel.org>; Sat, 31 Aug 2024 21:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725163646; x=1725768446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmo3/yU2P8LsM22CtkppGBhBN/HDkEIQ1oKrtDKPQrs=;
        b=jNrnS3/HimaxMvA3EauzTnFPMy4sOxxrLLNN5813raFgVRZYY1qX8ylHvu9IaU38iD
         pbltwDKot7MWvEox1riPfx4nq2Y1D+n/3iXi+tlr432FTyz63lUt20kWzzsISvm9TqWB
         JAx3l2ZY9eJz3ye8fCsK34DKIbf9igs925XNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725163646; x=1725768446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmo3/yU2P8LsM22CtkppGBhBN/HDkEIQ1oKrtDKPQrs=;
        b=Do0N53j5OGAOdBevKgWNVT9to4sooxhcS7zuLO/7EFXD3JJ0v7mkZk0tCF3jxp1Ohq
         3pn9OO1fMwfTB2Mqv8Cl9FECWEKzdaQ45TQCLh5BREm+cnBX8A/tbX0OkOyKnaKwIQNl
         8WCeYMIbMuRxizuPD/XWa5WZDyE/Nda3jzroDmTaaLAPPptexoBBrfRY3gX5QUianDzG
         YLNvz+Ibc1vR2Yr1wLzY75xW5F4/CIps9L9WHT+a/v6zF8bmIG7T7e9P2ChrAWisdgyf
         CmEs3+Yd5uhTkG0+BkODp6dJWYVImr5iOqpWozrfiqGWwBcQ7pFHEIm37FsMHG1h1S8h
         PpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyaFudBvLt/jXbapJKKmm+X3ls67e3K6l86gb1OxSCocmsqypNx1JaBp9Mm6No5A/aPjN/sQFQX+vs@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6af1lqbxs5MNqoOP5VHrA2jFBfS+4zs8W4uQdZyOM9stVkUs
	IbS/VBoXtlO4px5PFx97ubcKSpWgOdUfk34Q0p4se7t9A8cAPxAeNXWlhlMlCw==
X-Google-Smtp-Source: AGHT+IGkEvNKrwf9vzljH1qmOoDG+G58iNPsfXL5CyX8XTHyhIjQ2Mn1eF6oxR0BUcemUEp0so8ADQ==
X-Received: by 2002:a17:903:181:b0:1fb:2ebc:d17a with SMTP id d9443c01a7336-205286bb7cemr101990685ad.23.1725163645599;
        Sat, 31 Aug 2024 21:07:25 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-205155338bcsm47111615ad.177.2024.08.31.21.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 21:07:25 -0700 (PDT)
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
Subject: [PATCH v4 11/18] device property: Add remote endpoint to devcon matcher
Date: Sat, 31 Aug 2024 21:06:49 -0700
Message-ID: <20240901040658.157425-12-swboyd@chromium.org>
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

When a single DT node has a graph connected to more than one
usb-c-connector node we can't differentiate which typec switch
registered for the device is associated with the USB connector because
the devcon matcher code assumes a 1:1 relationship between remote node
and typec switch. Furthermore, we don't have a #typec-switch-cells
property so there can only be one node per typec switch.

Support multiple USB typec switches exposed by one node by passing the
remote endpoint node in addition to the remote node to the devcon
matcher function (devcon_match_fn_t). With this change, typec switch
drivers can register switches with the device node pointer for a graph
endpoint so that they can support more than one typec switch if
necessary. Either way, a DT property like 'mode-switch' is always in the
graph's parent node and not in the endpoint node.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: <linux-usb@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/property.c     |  7 +++++--
 drivers/usb/roles/class.c   |  4 ++--
 drivers/usb/typec/mux.c     |  8 ++++++++
 drivers/usb/typec/retimer.c |  7 ++++++-
 include/linux/property.h    | 11 +++++++----
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 837d77e3af2b..621de33f2956 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1284,6 +1284,7 @@ static unsigned int fwnode_graph_devcon_matches(const struct fwnode_handle *fwno
 {
 	struct fwnode_handle *node;
 	struct fwnode_handle *ep;
+	struct fwnode_handle *remote_ep;
 	unsigned int count = 0;
 	void *ret;
 
@@ -1299,7 +1300,9 @@ static unsigned int fwnode_graph_devcon_matches(const struct fwnode_handle *fwno
 			continue;
 		}
 
-		ret = match(node, con_id, data);
+		remote_ep = fwnode_graph_get_remote_endpoint(ep);
+		ret = match(node, remote_ep, con_id, data);
+		fwnode_handle_put(remote_ep);
 		fwnode_handle_put(node);
 		if (ret) {
 			if (matches)
@@ -1329,7 +1332,7 @@ static unsigned int fwnode_devcon_matches(const struct fwnode_handle *fwnode,
 		if (IS_ERR(node))
 			break;
 
-		ret = match(node, NULL, data);
+		ret = match(node, NULL, NULL, data);
 		fwnode_handle_put(node);
 		if (ret) {
 			if (matches)
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index d7aa913ceb8a..d8bd5071d9d8 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -121,8 +121,8 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
 
-static void *usb_role_switch_match(const struct fwnode_handle *fwnode, const char *id,
-				   void *data)
+static void *usb_role_switch_match(const struct fwnode_handle *fwnode, const struct fwnode_handle *endpoint,
+				   const char *id, void *data)
 {
 	struct device *dev;
 
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index f420185e36e3..9ddb6ec54325 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -33,6 +33,7 @@ static int switch_fwnode_match(struct device *dev, const void *fwnode)
 }
 
 static void *typec_switch_match(const struct fwnode_handle *fwnode,
+				const struct fwnode_handle *endpoint,
 				const char *id, void *data)
 {
 	struct device *dev;
@@ -55,6 +56,9 @@ static void *typec_switch_match(const struct fwnode_handle *fwnode,
 	 */
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				switch_fwnode_match);
+	if (!dev)
+		dev = class_find_device(&typec_mux_class, NULL, endpoint,
+				switch_fwnode_match);
 
 	return dev ? to_typec_switch_dev(dev) : ERR_PTR(-EPROBE_DEFER);
 }
@@ -299,6 +303,7 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
 }
 
 static void *typec_mux_match(const struct fwnode_handle *fwnode,
+			     const struct fwnode_handle *endpoint,
 			     const char *id, void *data)
 {
 	struct device *dev;
@@ -316,6 +321,9 @@ static void *typec_mux_match(const struct fwnode_handle *fwnode,
 
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				mux_fwnode_match);
+	if (!dev)
+		dev = class_find_device(&typec_mux_class, NULL, endpoint,
+					mux_fwnode_match);
 
 	return dev ? to_typec_mux_dev(dev) : ERR_PTR(-EPROBE_DEFER);
 }
diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
index b519fcf358ca..ee4e6312c2d9 100644
--- a/drivers/usb/typec/retimer.c
+++ b/drivers/usb/typec/retimer.c
@@ -22,7 +22,9 @@ static int retimer_fwnode_match(struct device *dev, const void *fwnode)
 	return is_typec_retimer(dev) && device_match_fwnode(dev, fwnode);
 }
 
-static void *typec_retimer_match(const struct fwnode_handle *fwnode, const char *id, void *data)
+static void *typec_retimer_match(const struct fwnode_handle *fwnode,
+				 const struct fwnode_handle *endpoint,
+				 const char *id, void *data)
 {
 	struct device *dev;
 
@@ -31,6 +33,9 @@ static void *typec_retimer_match(const struct fwnode_handle *fwnode, const char
 
 	dev = class_find_device(&retimer_class, NULL, fwnode,
 				retimer_fwnode_match);
+	if (!dev)
+		dev = class_find_device(&retimer_class, NULL, endpoint,
+					retimer_fwnode_match);
 
 	return dev ? to_typec_retimer(dev) : ERR_PTR(-EPROBE_DEFER);
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 797b1eeda7d2..72a89cd410db 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -510,22 +510,25 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 /**
  * devcon_match_fn_t - device connection match function
  * @fwnode: Remote connection's device node
+ * @endpoint: Remote connection's endpoint node
  * @con_id: Identifier for the connection
  * @data: Match function caller specific data
  *
  * Implement a callback with this function signature to search a fwnode's
  * connections for a match with a function like device_connection_find_match().
  * This function will be called possibly multiple times, once for each
- * connection. The match function should inspect the @fwnode to look for a
- * match. The @con_id and @data provided are the same as the @con_id and @data
- * arguments passed to the functions that take a devcon_match_fn_t argument.
+ * connection. The match function should inspect the connection's @fwnode
+ * and/or @endpoint to look for a match. The @con_id and @data provided are the
+ * same as the @con_id and @data arguments passed to the functions that take a
+ * devcon_match_fn_t argument.
  *
  * Note: This function can be called multiple times.
  *
  * Return: Pointer to match or NULL if no match found.
  */
 typedef void *(*devcon_match_fn_t)(const struct fwnode_handle *fwnode,
-				   const char *con_id, void *data);
+				   const struct fwnode_handle *endpoint,
+				   const char *id, void *data);
 
 void *fwnode_connection_find_match(const struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
-- 
https://chromeos.dev


