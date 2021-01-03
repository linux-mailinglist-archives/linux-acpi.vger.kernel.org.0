Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF612E8ED1
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbhACXNj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbhACXNi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:13:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E49C0613CF;
        Sun,  3 Jan 2021 15:12:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t16so30019256wra.3;
        Sun, 03 Jan 2021 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tj4Vv1U/qJ+vwgqOcBhuEivdNVXX0IsLutn8hXTWDbY=;
        b=p3rjX7HmnF65UhEdD56od5UHLtxBRibFTZIWUCJrAL+dBk+7mBkjgd20fvuhlZkI9F
         TiSLMhoCGey/BNXa+039H9LjFh3+gznRnDLe+deWiyJy1ZrX86Sq45vuyg4xyEj9SEVR
         J3qAYzEt6bUgKA3ppXo1fEF7Pp+GolmTQ4FS+FyYBWjT5nOA38cJsEQhuiBnee2SVAw6
         pSD2wJmLJKYZAvV9NrhypriWPJ/YgsXTY14fapHHFO4EkmGcrDSIghxtGZmOAQbKMZel
         lL2JvbUhvXWvUiLu34EMr9dmMLeUEAjTYZXmRlBbMx11UJXcI5Mk3MlXz9AsfrZ3lE0a
         cZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tj4Vv1U/qJ+vwgqOcBhuEivdNVXX0IsLutn8hXTWDbY=;
        b=LRH1df/I8gFQfKlrddA0tJC7MrvggT3VSxHkKGFPvy3QDevGfk+ZWQpQWampB+cd/u
         uKkM0el+Wit2Yy/9NxvtyaKh2rwfr3U5X9Z1HezgeIm7/wPYPtI2PGG/uyUIw03MGLuN
         26TtJ2h/KZHBOjo0+vmnW588uxC7HHTCiNIDbOF2qDbMOJC3tY7foEpJOOO9NWQJ1zip
         7hF8U9MCO6WGyNPiSy39YUjUPZNjh3jMs1yK1oZ6xZ8hetdrIkGwHVvpMRQ1opvmQFnY
         K3n2PmKpWBS14ffRYT3gH+S8JRKa1wGaiE1DKj1Pg8iWK3CFYoCrihXSd7Q9QQ+3+WdL
         1fLw==
X-Gm-Message-State: AOAM532dcfhbKYN/pRyi86lBB93Ll2cA1u49Ky9hxHZAwNHIUOCyj1fY
        sYO2Y86LMSnV0DSLOJYJ+Z/k+A0PecEmkrKn
X-Google-Smtp-Source: ABdhPJxTB559nKKcXdsTL/70LIjZpgm3qPEjtdwtBTp81FlH78B9cBOEvpqfFjWekttiRYLrjfECcg==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr76331149wrr.69.1609715576468;
        Sun, 03 Jan 2021 15:12:56 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:12:55 -0800 (PST)
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 02/15] media: ipu3-cio2: Add headers that ipu3-cio2.h is direct user of
Date:   Sun,  3 Jan 2021 23:12:22 +0000
Message-Id: <20210103231235.792999-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Add headers that ipu3-cio2.h is direct user of.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Daniel Scally <djrscally@gmail.com>
Tested-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v4:

	- Incorporated so it can be used in a later patch - thanks Andy.
	  Not sure if this needs my Signed-off-by since I didn't write
	  any part of it. checkpatch.pl --strict doesn't complain at its
	  absence so I'm going with no; but let me know if I'm wrong.

 drivers/media/pci/intel/ipu3/ipu3-cio2.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.h b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
index ccf0b85ae36f..62187ab5ae43 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
@@ -4,8 +4,26 @@
 #ifndef __IPU3_CIO2_H
 #define __IPU3_CIO2_H
 
+#include <linux/bits.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 
+#include <asm/page.h>
+
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+#include <media/videobuf2-core.h>
+#include <media/videobuf2-v4l2.h>
+
+struct cio2_fbpt_entry;		/* defined here, after the first usage */
+struct pci_dev;
+
 #define CIO2_NAME					"ipu3-cio2"
 #define CIO2_DEVICE_NAME				"Intel IPU3 CIO2"
 #define CIO2_ENTITY_NAME				"ipu3-csi2"
-- 
2.25.1

