Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E548D2E8ED2
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbhACXNm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbhACXNj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:13:39 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00113C0613D3;
        Sun,  3 Jan 2021 15:12:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e25so17227486wme.0;
        Sun, 03 Jan 2021 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5CmQK7n7fIa42/kxgVjPB5vSMpy+eK0UJ45bTDYT3w=;
        b=L68Dtu99GZSzyEUw97+BvjStiRh0VnG5AazWm3i+B4D4LxYzNK/LWAqd+jWNDZQjop
         lvLQv2WsYhD6ZyPaYy3BqKEGSimKlgjQtXyvmSf5E3r1g/oOGHSRZp5JzP12CV6i1lZ5
         UnPL0VTzOm0cu9z+tqw6TmzuSV78yIXokLBum1EdGUltOAmkMeLLTogV5HeO99h5zfN4
         KUbIt4JRYh4ll1YvZ1TBMgDOU4qVjYEruj1MOK7po+QnzMPT2YRBjtXbrx+BIcj+pgZk
         qR8rCXIc0IOIJ5yC9UpsmCpqDggFCRU/xy9JTW2YjAn+qHrMSmaqicFbFa2DlfOsseeN
         HXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5CmQK7n7fIa42/kxgVjPB5vSMpy+eK0UJ45bTDYT3w=;
        b=oruUrCXl3nQYnUw0/xDGlGEY7/CgZnnbG/W8yNQU3lD2WAvpFFys2dAcMRyGeWkw30
         mOHIZwF7kp5tjH5tTk9e2sjSKWuEZQU1yxKhFOLsPmEu/uti73dlx3JXfYr28GMCRG0R
         rYjALXrYifv71val/2ppai5KcC8+l80+xVkPlZ7UZ8iSMPdZM7vSA4X98tTWa/DS9Jhn
         RQ8qUAIyEh2Wanc+UK1YN7nkzG8smBIMhvzZpaj7vzZ9SXphX8HR2tI04k0PTJNkshZk
         1QDJU4TZaS153ZzcGxDWM6GD50r0LoY27tafPB/XE9RWSPwOjdObQ5vgvXnqxuegJAqg
         fmyA==
X-Gm-Message-State: AOAM533vevDjyfhsCfhs1bWu5EwMkwh+eEBgwLucRlnmYKhfRW/CAYhl
        7FOkXO10dMm04CCZ36MnEoGmazRLj9xFfClP
X-Google-Smtp-Source: ABdhPJzMmr87aF+mgPwWYM2mr1hOkGlX8oX3wVGQ3Nyk3zFOaqgTTFIoReozHyKaZ3JhNvIIWkh2MQ==
X-Received: by 2002:a1c:7909:: with SMTP id l9mr24607043wme.120.1609715577782;
        Sun, 03 Jan 2021 15:12:57 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:12:57 -0800 (PST)
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
Subject: [PATCH v4 03/15] property: Return true in fwnode_device_is_available for NULL ops
Date:   Sun,  3 Jan 2021 23:12:23 +0000
Message-Id: <20210103231235.792999-4-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some types of fwnode_handle do not implement the device_is_available()
check, such as those created by software_nodes. There isn't really a
meaningful way to check for the availability of a device that doesn't
actually exist, so if the check isn't implemented just assume that the
"device" is present.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v4:

	- None

 drivers/base/property.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4c43d30145c6..bc9c634df6df 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -785,9 +785,15 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
 /**
  * fwnode_device_is_available - check if a device is available for use
  * @fwnode: Pointer to the fwnode of the device.
+ *
+ * For fwnode node types that don't implement the .device_is_available()
+ * operation, this function returns true.
  */
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
+	if (!fwnode_has_op(fwnode, device_is_available))
+		return true;
+
 	return fwnode_call_bool_op(fwnode, device_is_available);
 }
 EXPORT_SYMBOL_GPL(fwnode_device_is_available);
-- 
2.25.1

