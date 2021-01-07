Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F52ED0CD
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbhAGNap (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbhAGNaV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C26C0612A0;
        Thu,  7 Jan 2021 05:29:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m5so5625907wrx.9;
        Thu, 07 Jan 2021 05:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4LIW4MB4DYuf2GVBILX/WTBF6BG/L5/LBpgo0CMtvE=;
        b=Ft28SCrVEV1JRlz9LIK0NfwhNyC8MEA+F3Ey1tfTsBjh+TTAeshn7WZgeX5f//1BWa
         X3MFweb2tDPGrsDjN503HuY/ixeblJWFA2cetk2y7ekytPr2fKPsL06+Hs4E4TDRijX3
         ZlSHOshNwfwu5wDn3l46qUhiJrfXkcx3Mw+HmdsS5wZzojKnQnoABEFnIh9QHKDH7Pj3
         EpTC8fKLEjG3HBkzPmd9Ie3MKJVLMxXCJSbi+SYquBf1+miNC0qvC02wNlVApNxu3Sqx
         9O9IDqBUYluv0ajAsPbQEUxvzBGjOQshEJELuMf34v1ABgEAQmR0qGe+UgDFH59/Kk83
         SOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4LIW4MB4DYuf2GVBILX/WTBF6BG/L5/LBpgo0CMtvE=;
        b=f5UMki2w9mJVhqvdSvZxYYvex3i5DijbpoO/HiujE10/kkTKBVFgsbiQHmUDVKBiPR
         vIGSEZ2pqZkIlTNMDTLJmzI4zKferyL+xTkms0jZDT7xBREk0WotyQVJaZqTjV/r/r3T
         K27D4x9kwmWc1xda0dTz8RwQ3TalxCvfRG5GMnNbQpl9GhlL24wsk0aXfCHxyNHwWIyI
         4kvXz1J6j5/MFgNU6Dvhd9l6QiTXqVx5NbkVvuBgqZy55GSSVvtq0UwXH77KWIVRFOMb
         X8i7M7GsoJKDlv3/Vsrx97CpizIyQBmQ/+SlQRn0hRYY5PPZUv7agZc5xH/4rcomcFz9
         e/4g==
X-Gm-Message-State: AOAM53014mi4eEmW0Ildep00RctDI0Ym6EbGf6i3xs8j65nA22tPt+xi
        LhL17xdRodSL+7BtbQFXNesYSOaZ34CKKb1P
X-Google-Smtp-Source: ABdhPJyjIwn1lQYwbDQxIn6a62ow4KuEJhY+V+ty7ajlxzUVJS3hqQRWPs9SZDqPUa5rxaGu5A3i1g==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr8960851wrs.220.1610026153011;
        Thu, 07 Jan 2021 05:29:13 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:29:12 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, mchehab@kernel.org,
        sergey.senozhatsky@gmail.com
Cc:     yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 14/15] media: v4l2-fwnode: Include v4l2_fwnode_bus_type
Date:   Thu,  7 Jan 2021 13:28:37 +0000
Message-Id: <20210107132838.396641-15-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
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
Changes in v5:

	- Changed commit subject

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
index 6d026dadbf98..e7ad95365a40 100644
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

