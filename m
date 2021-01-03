Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10C2E8EE7
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbhACXOZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbhACXOV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:14:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F34CC0617A5;
        Sun,  3 Jan 2021 15:13:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id e25so17229581wme.0;
        Sun, 03 Jan 2021 15:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuYF72cpGLsFt6xkx6NosOoUfo6Q9qWMJHO4jAGYAWk=;
        b=CUrYzqSBjQEGZc/bE5Gx2KNYd3uFasbyA1/bcXXBaZV6ByJNyoAnt4XJDgNg9f2DjQ
         W66kCZgAa3mVJyOISElc0N5VYmJCDC0Arq90VAx+K4wvDhxp/VU2MRRkD7Yn4c7mzIVT
         nFT8+Reuh8cshVzwuRiZfYqLGMAYtOEIDnU13DvtlXs9egosOl83suORs4V8Iqsp1kHs
         JpJqu822a8lZ9Zy7piMv+yuMy9xbafp1MgTuiw0d7q7C35MOFOuNwCsjHGB1W59C3ZoT
         VdspvfPxwAqbxrVvPltzg1gbZzSHAAbOp0MU9pPor/PlC80pv6A8ZverwpsoiYSVIdQc
         LO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuYF72cpGLsFt6xkx6NosOoUfo6Q9qWMJHO4jAGYAWk=;
        b=jxyVJ4HfDOeOIpm7DXGlAZJlNlD9ds4fr6PbGpbCokgvfZoCkkUWNFF8AzMW5K6xhY
         DlanF5r38obKi+9iVdmorRprxIuadLJwAWfJUJv357t286x2iZy4Mlgw+qX00XfnL6xt
         ochVN5ImSrkavelHqufGDXHNupX8jkMEFlab4Pg2t4los43DQ1C6fDK0HqQoX+/Ubwye
         Sf6KxbPNAa0/eQbKAtBcv4zhiKDi268kzHnFSgcyb/nU+8xt7tWj4OcQdrt32Vx5TRvl
         QCAQhY5hHphTNYu74OdUtGvZps5q8Ga2c74bDwdQQNLvNmS/xYMMc7t99S90cMGw8P4W
         pVug==
X-Gm-Message-State: AOAM5312y2uQXyQdIgQPr/dgrO0QgySk29YkAimUYTAaMS5IL/jo/H2L
        XIIkcdhDZLw8PSvnOrxImi3FhxJamaXYBame
X-Google-Smtp-Source: ABdhPJym1qNaECX9uwk7A3d3UimQMmo74WVgO+zzOTj3KJrCOFCk1fk0/j6k4rCbN6baWYww0IpovQ==
X-Received: by 2002:a1c:3d55:: with SMTP id k82mr23982928wma.57.1609715592283;
        Sun, 03 Jan 2021 15:13:12 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:13:11 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org
Cc:     lenb@kernel.org, yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 14/15] include: media: v4l2-fwnode: Include v4l2_fwnode_bus_type
Date:   Sun,  3 Jan 2021 23:12:34 +0000
Message-Id: <20210103231235.792999-15-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

V4L2 fwnode bus types are enumerated in v4l2-fwnode.c, meaning they aren't
available to the rest of the kernel. Move the enum to the corresponding
header so that I can use the label to refer to those values.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v4:

	- Dropped the trailing comma from NR_OF_V4L2_FWNODE_BUS_TYPE

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
index 4365430eea6f..77fd6a3ec308 100644
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
+ * @V4L2_FWNODE_BUS_TYPE_BT656: BT.656 video format bus-type
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
+	NR_OF_V4L2_FWNODE_BUS_TYPE
+};
+
 /**
  * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
  * @fwnode: pointer to the endpoint's fwnode handle
-- 
2.25.1

