Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD242ED0BA
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbhAGN3x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbhAGN3i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:29:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C27C0612F6;
        Thu,  7 Jan 2021 05:28:57 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g25so4927857wmh.1;
        Thu, 07 Jan 2021 05:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6C6kuEO6ZOy8iBiVf6SkIqCFNPL2B2+QHOoh8Z905lA=;
        b=jGE2yeAj7Gyp1cOJclHkNVfF3QY4E8qJU8VO0AYdqNgszGSyFyIuviiq5BjwGiDfck
         fpYSuEcbJGOM/j58eNei83+dFhxnZJ5/BOvoYRovOM9XlFJIjOjnwkVmIFrQi3+4bqq6
         Z7jEJcSTYw5rT5V1DMG/uT5UbMEk/DP1O/UbpMfiKy6ijipE9m9uj4VGMwwClMJkBgiX
         NCxqUa5+gnt4aFZDnbeRejodLZYfaBmm32qwnQdBo4TBABMxn3jELaXTjCWnoryGmOwB
         cUOHvs2Xa9BFFCVYOMOTDpfQDjveDWnzi99nnIf9CwoXbhzSMzlFnlSWXEd4ioHXm3C6
         TmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6C6kuEO6ZOy8iBiVf6SkIqCFNPL2B2+QHOoh8Z905lA=;
        b=A1igGgQ4rrbqEvdXdmkGyjZnuU9fbShpvSbcsYHvOejMhMMB+yPbIUxmFp+K9VGoGB
         /MvrUWEtyirWI1UgJhhLCNwXmKOMTWK+XCnRhGUyE7Wp8jsUCpvCOs3tdyxfBtLsLOFL
         wFivMfpm5c6RApeJVBugbCW95P+40ecWUixe+X6n426LWT9IL8f2bnhc0WmM6mgytn+p
         GnOfTRwUq5+RIChntMINSDd57lCKZT8cX6lIKYGDoxGdqPVHUtoeWmCvPjuke/tOGK/B
         KMkv694m1fyIjui5BtNnjhHl/AbGz2PbAhUCQgL+pS6pbK3OYTBQq9X7WI8uNdSuWdJ6
         oA6w==
X-Gm-Message-State: AOAM532xNDb4WRMOUA+DMrn6x2wVCddEx41+UhzfZ299AI3rGPB8xdEd
        /B1oU806QY9dOnW1x1kfapCmkSD6Gz2Snv0F
X-Google-Smtp-Source: ABdhPJyABZO3JssHe1Fthw9hYtFczcA33XfMYIFFbi3qTfZWf/IOkh7oWwi2ee0Cmckbzx5doLkAbg==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr8065254wml.106.1610026136322;
        Thu, 07 Jan 2021 05:28:56 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:28:55 -0800 (PST)
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 02/15] media: ipu3-cio2: Add headers that ipu3-cio2.h is direct user of
Date:   Thu,  7 Jan 2021 13:28:25 +0000
Message-Id: <20210107132838.396641-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
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
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v5:

	- Added my Signed-off-by this time, apparently I need to do that.

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

