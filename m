Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50842DDBFF
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbgLQXoj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732282AbgLQXog (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:44:36 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E061C0617B0;
        Thu, 17 Dec 2020 15:43:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e25so577361wme.0;
        Thu, 17 Dec 2020 15:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Y7dtEvdcKPvLmik/Dt9S23LzcoiYY1794f++x+MfCQ=;
        b=JPrmEJbHxNUecfqssmn8/wie5GeVJTxzyA/rn6Rl4j5dA+Lp0GclYozolxTQAz9m58
         HuHSCOz9dq0rYQO+kdhNjQ2Y5pBrA77mmOnDnSzLbo0RxurHLK+O9G/M2be+fgqhKlxl
         CrhN+wkvm31vU3J9xq+CJPtk66L172qvISTu9m6mBb32vWOS9CDLnR2XnYWXu7gQz98f
         8u4FZgL89rzEpfz711/RLQ08FMkrpi9wIAcH+OYcHM0Dh7A81XYiLLX0UI4YkXlYZQzL
         As2eJubSy6izXowULubnqZvgwUL27qhshq+vpa/z0YJfFtBPqTcejDuTFPlx2gkcEQxO
         b+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Y7dtEvdcKPvLmik/Dt9S23LzcoiYY1794f++x+MfCQ=;
        b=Q5B0n7uNG/Emwkgcz0G1p/tiELboFg2w7i/uA/1jruYgazvoj1gcr+uu8Zb3SuB+93
         7ltan9bq8jgKLwGFcGZ+v9KyFk/Miqq86JxHSylZGc5e5ocXTXfwRQvtn9jOXLpVwlPV
         L00ZlVox9HKaV0ai/JPJzqlho2oVuFHtSulr85oK0ke2p1zNFWmGLj6jaXW3roPFicCf
         Np8zPI9jv1Mak22tALJL1KJbA6wT2dOGJYfoSfIJXT56K4M2sFYeXjnWLeF8/R3/WN1W
         hW9zy6NG6oFSZZJA+FqvrypDCNuC7yFA06/ZXBjAnft5aRn8hSH8+75vMLefkG+rlCOL
         otYA==
X-Gm-Message-State: AOAM533Pv1qLl+K5s0XUk9aAdRUdV47b3BhIw9semWm7DSTuLd/7G+0l
        5bolZFmhwChcCymwKdUrE/Vwu1GlOmxw8Kjg
X-Google-Smtp-Source: ABdhPJxmzGNcdXzky8V04Y/R7C6fI9UL+BpxeY8jBfOHtNyfV7IujbyAyvSd9OUYOSgSlAgwTPjM6g==
X-Received: by 2002:a1c:2188:: with SMTP id h130mr1569720wmh.176.1608248634800;
        Thu, 17 Dec 2020 15:43:54 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:43:54 -0800 (PST)
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
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 02/12] property: Return true in fwnode_device_is_available for NULL ops
Date:   Thu, 17 Dec 2020 23:43:27 +0000
Message-Id: <20201217234337.1983732-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
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
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

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

