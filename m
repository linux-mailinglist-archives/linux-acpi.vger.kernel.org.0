Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6D2E2347
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgLXBKx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgLXBKt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:49 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2EAC0611CE;
        Wed, 23 Dec 2020 17:09:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k10so366365wmi.3;
        Wed, 23 Dec 2020 17:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RN4eZW0P5zJGQ+ExnLjE8F4o1z5DWe8tjmYcqAjmd8g=;
        b=Z6KH8ThAa3j0w+iK1ZWRecYUgVX8cXs+S51zqeJ/CN878vHMwmwiEqMENCQ4xAG2eN
         3Fbe72iHm8xFtQGOVWN6S+7i67QHptesp0QbE+X71pJgcbUHGeZQ4eC50Afixx1M2hle
         EG842ywAsfa/K/W2nqMP2SwZaOCPi1sWTZVstX5GW5nWIkJm4/BpBT4mX/sUyLj3EgI7
         a2cxNPJ3M+UzY74EEf10CLOTxP+Y4rhSRtHNgf7TrYyVce1solCdF8fqtC4hnKx/TVjy
         1c2kchPO2KOFyiyD9erRtCixY9OSER3jbNmQr+Wl0ToOSWFSaJZuZfzvK19xTU8NooMW
         ul5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RN4eZW0P5zJGQ+ExnLjE8F4o1z5DWe8tjmYcqAjmd8g=;
        b=Jt1zIPu7tQU3ryw+bUeJ0zhar2bJx+IhtXDE+evmjf1fbKez0aoZ0sGTOSR5MAdLMo
         7KC0oCVM5TOKYAJaSPa6aEuUIGUNmnXjmVofiZQAfmmqfPKS9oTF4Hmx7oL1KydHnWyD
         xy2B5DezhWmph5M5wyJJbk5vTZ/2k6Wf62SZKleCpBdniXq9p25WkFk7nA0CN1YCzvIk
         LZhDRY17uvTR4YzOsHy5zmGyAU1+O9UbBQMEkB7Zt57zib5qBjWO7iTsTb2ja1ghgy6/
         allfgb55Sl6/4a6etZRFdS99+jX/Jpdnd/qJyUOv4nLLf7Gj3B/+Qbr+1ZAYCYSOImoK
         JDug==
X-Gm-Message-State: AOAM5307gBn6qdcKs60AV5fab43nB9c+kbnItyTEHPGfUy5A6CalcU6y
        jhvUnmsVnCFm1h7IWxpsXuA5vkTAMsGw7pUL
X-Google-Smtp-Source: ABdhPJzJmNQdMwNpl7s31MtXZuCE6vhgnmsG9jR4VzJsq0ZYiSdT3Fafrgp5fgpG01d9QefPnL0fAg==
X-Received: by 2002:a1c:dc87:: with SMTP id t129mr1977147wmg.52.1608772179190;
        Wed, 23 Dec 2020 17:09:39 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:38 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: [PATCH v3 13/14] include: media: v4l2-fwnode: Include v4l2_fwnode_bus_type
Date:   Thu, 24 Dec 2020 01:09:06 +0000
Message-Id: <20201224010907.263125-14-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

V4L2 fwnode bus types are enumerated in v4l2-fwnode.c, meaning they aren't
available to the rest of the kernel. Move the enum to the corresponding
header so that I can use the label to refer to those values.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v3
	- Patch introduced

 drivers/media/v4l2-core/v4l2-fwnode.c | 11 -----------
 include/media/v4l2-fwnode.h           | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 5353e37eb950..c1c2b3060532 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -28,17 +28,6 @@
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
-enum v4l2_fwnode_bus_type {
-	V4L2_FWNODE_BUS_TYPE_GUESS = 0,
-	V4L2_FWNODE_BUS_TYPE_CSI2_CPHY,
-	V4L2_FWNODE_BUS_TYPE_CSI1,
-	V4L2_FWNODE_BUS_TYPE_CCP2,
-	V4L2_FWNODE_BUS_TYPE_CSI2_DPHY,
-	V4L2_FWNODE_BUS_TYPE_PARALLEL,
-	V4L2_FWNODE_BUS_TYPE_BT656,
-	NR_OF_V4L2_FWNODE_BUS_TYPE,
-};
-
 static const struct v4l2_fwnode_bus_conv {
 	enum v4l2_fwnode_bus_type fwnode_bus_type;
 	enum v4l2_mbus_type mbus_type;
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index 4365430eea6f..d306a28bda96 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -213,6 +213,28 @@ struct v4l2_fwnode_connector {
 	} connector;
 };
 
+/**
+ * enum v4l2_fwnode_bus_type - Video bus types defined by firmware properties
+ * @V4L2_FWNODE_BUS_TYPE_GUESS: Default value if no bus-type fwnode property
+ * @V4L2_FWNODE_BUS_TYPE_CSI2_CPHY: MIPI CSI-2 bus, C-PHY physical layer
+ * @V4L2_FWNODE_BUS_TYPE_CSI1: MIPI CSI-1 bus
+ * @V4L2_FWNODE_BUS_TYPE_CCP2: SMIA Compact Camera Port 2 bus
+ * @V4L2_FWNODE_BUS_TYPE_CSI2_DPHY: MIPI CSI-2 bus, D-PHY physical layer
+ * @V4L2_FWNODE_BUS_TYPE_PARALLEL: Camera Parallel Interface bus
+ * @V4L2_FWNODE_BUS_TYPE_BT656: BT656 video format bus-type
+ * @NR_OF_V4L2_FWNODE_BUS_TYPE: Number of bus-types
+ */
+enum v4l2_fwnode_bus_type {
+	V4L2_FWNODE_BUS_TYPE_GUESS = 0,
+	V4L2_FWNODE_BUS_TYPE_CSI2_CPHY,
+	V4L2_FWNODE_BUS_TYPE_CSI1,
+	V4L2_FWNODE_BUS_TYPE_CCP2,
+	V4L2_FWNODE_BUS_TYPE_CSI2_DPHY,
+	V4L2_FWNODE_BUS_TYPE_PARALLEL,
+	V4L2_FWNODE_BUS_TYPE_BT656,
+	NR_OF_V4L2_FWNODE_BUS_TYPE,
+};
+
 /**
  * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
  * @fwnode: pointer to the endpoint's fwnode handle
-- 
2.25.1

