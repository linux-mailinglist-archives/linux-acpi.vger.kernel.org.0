Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9F2E2334
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgLXBKU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgLXBKG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A5CC0617A6;
        Wed, 23 Dec 2020 17:09:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k10so366120wmi.3;
        Wed, 23 Dec 2020 17:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4tk1Bevx+jHiB4szN/k2Lq1XHl7fOtbHhHNJ2QDs2k=;
        b=XLcgqrbs+4Aj1XYSCIY+f4/Z9i7LBKAhxpgMW437fxN5Z1MOHv0h55eLqTdzUqFUml
         slf/VUmjy317dT/h/qba1mHSGHbkDW9LIuaReD3T74Dzj5XEbBOdOdrBvkq0/49HR2H+
         KK0N8kluDU0kNE0DwLcFqDzJlvg0fEPB3Tej2uYJcud0sDkOVv4oGDbu0+TN37s2yHBn
         JbnMC1FVd+OYh9xB9yNxHVfnKmF8f6iXGyVYqkCo2NzDcuUVjJsC4RGAP5ra/lWNIC5H
         cQXdCir/PPO0yx9K+f85Xbl3af950X/sfwWMNJuy6dW6U3n7sKu4swQJ81pEwbvQ//rr
         amkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4tk1Bevx+jHiB4szN/k2Lq1XHl7fOtbHhHNJ2QDs2k=;
        b=oR09WBZZ6UiqAaLpCPagfZAK9tDSAV8BS3bEAQtv+1J7qxfeItXL5v+QPwPqUJ30Jg
         cOM04HO6jynmRxq4w2+4jhIHCTKkZk4JHRvJ8y5WR1+PxCQ42+TK0NdPgA8gGpVt6Q5y
         qvTFwzmxEP0GaNToXDfE1Z/XlZ2X8ebeZJWtp+9usGQLM2HdDnGrxV+YD7dQ3Jc+oYao
         J7EC3jFagic0yHn7QveZeapT8dxmh1zZFzum67VVtFqMB8bxfqRUkqEi8NEruWXK+35x
         jJiSUpRuVM3Wcz/Y+ZjYvjsX0Ts3mLLmqgFmm0Ou4JT9ko6sUqymIUfrVouBiZCUnLtw
         D08Q==
X-Gm-Message-State: AOAM533P2T65Ur/WVNo3iCwqFpEBz7OjBVsNZN9r+QWrtMZUsuNTN2XL
        Ef33pfKEukircBUhy+lDuQFrxhipwK6AdBoH
X-Google-Smtp-Source: ABdhPJxrxQ/O15e7DsB06zUQeo9YSmyrKKeIAZxCSBknmLIOhegQtC1p2X7y86yeVDvfdLgC8BDcKw==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr1963590wmh.88.1608772164385;
        Wed, 23 Dec 2020 17:09:24 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:23 -0800 (PST)
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
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 02/14] property: Return true in fwnode_device_is_available for NULL ops
Date:   Thu, 24 Dec 2020 01:08:55 +0000
Message-Id: <20201224010907.263125-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
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
Changes in v3
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

