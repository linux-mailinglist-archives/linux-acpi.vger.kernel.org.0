Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81F91D4548
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 07:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgEOFfM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 01:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbgEOFfL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 May 2020 01:35:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CF6C05BD0B
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2020 22:35:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h129so1416781ybc.3
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2020 22:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RUCHt3IUTaAuIZ5RcDy4DbI7lEInPDSWSCSV1x0aJWU=;
        b=NNmMCJFsnc8QFuD5OYt292G7roqEzHRNUYulBcoESHwmzCM16suaXcwxL7JDzWuXay
         Dz81ANTMnpkXBwhmnbiMvHbNioUQM/0Jpu3HXydj063az53GvyNz/ybUZi60vtEftqsX
         5y3CuDlXPN0VWTHOizdO8em6WneEBZOh05j/7gzZ+EyL4MN+N+nBFKGcWK9B06gY26KJ
         EGI22WFBwOcvhbXCvYFfJ+BLuzRTTJq8pGhTf0uMvGUdpHIb43ZqlK9z+ik7oP4ePFz0
         M6M70Lurbci12BP0XFdJqAvYdNFGYV/6XA+xhipiiPq+tnAWLrAKkNFkoATNHlcwVIG2
         kS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RUCHt3IUTaAuIZ5RcDy4DbI7lEInPDSWSCSV1x0aJWU=;
        b=tZtQqwdJL5SDIk3yZGGauDgTrPrVJLN/CGTb/Ox0UPNsibJCgKypIc/27RXTVaLdCV
         q+4QPBWahKV6seNW2EjqvHD85WDO3/M7JJhFN6yhiT5pRj8tZ/+bvASViPfNVjPARjrP
         Q72SzKyhAdmWuA7F+tLExniX5j+uqs9FcntITXqYVRwyoEvx0LeyYeaLV15Aoy6Xf3vi
         RStG3igqE3pPshe4NAHXBTaYko6Lenc+ielJuxyIWCJU+gjgECR3BSfaUB0WaAysbd6D
         3ty//qZTlfsVdROidNvRHvyFGEuWTrooZ6JUM0aQW0+8cUKjaITm9J38KGWekyqnL/sn
         NDOw==
X-Gm-Message-State: AOAM530KY1iIA4jLbQgy1in8LDYiNpK/Ta9Yhc82u1zuiGQoy46Banha
        Jvd5JjA3sBju7brTtMPHizo2i1ARdWhMUnc=
X-Google-Smtp-Source: ABdhPJz5Il4KBtVez3mKTqB6IUL3C6pYb+iGjAt2GhlZ7PEp1DIpmYHxcPfv+5v4AeIr7I9PrnjCEiAD3DCPmSY=
X-Received: by 2002:a25:ba8b:: with SMTP id s11mr2591447ybg.310.1589520908664;
 Thu, 14 May 2020 22:35:08 -0700 (PDT)
Date:   Thu, 14 May 2020 22:34:58 -0700
In-Reply-To: <20200515053500.215929-1-saravanak@google.com>
Message-Id: <20200515053500.215929-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1 2/4] driver core: Look for waiting consumers only for a
 fwnode's primary device
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ji Luo <ji.luo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 4dbe191c046e ("driver core: Add device links from fwnode only for
the primary device") skipped linking a fwnode's secondary device to
the suppliers listed in its fwnode.

However, a fwnode's secondary device can't be found using
get_dev_from_fwnode(). So, there's no point in trying to see if devices
waiting for suppliers might want to link to a fwnode's secondary device.

This commit removes that unnecessary step for devices that aren't a
fwnode's primary device and also moves the code to a more appropriate
part of the file.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b454aae64b5..f585d92e09d0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1173,6 +1173,21 @@ static bool fw_devlink_is_permissive(void)
 	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
 }
 
+static void fw_devlink_link_device(struct device *dev)
+{
+	int fw_ret;
+
+	device_link_add_missing_supplier_links();
+
+	if (fw_devlink_flags && fwnode_has_op(dev->fwnode, add_links)) {
+		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
+		if (fw_ret == -ENODEV && !fw_devlink_is_permissive())
+			device_link_wait_for_mandatory_supplier(dev);
+		else if (fw_ret)
+			device_link_wait_for_optional_supplier(dev);
+	}
+}
+
 /* Device links support end. */
 
 int (*platform_notify)(struct device *dev) = NULL;
@@ -2407,7 +2422,7 @@ int device_add(struct device *dev)
 	struct device *parent;
 	struct kobject *kobj;
 	struct class_interface *class_intf;
-	int error = -EINVAL, fw_ret;
+	int error = -EINVAL;
 	struct kobject *glue_dir = NULL;
 	bool is_fwnode_dev = false;
 
@@ -2524,16 +2539,8 @@ int device_add(struct device *dev)
 	 * waiting consumers can link to it before the driver is bound to the
 	 * device and the driver sync_state callback is called for this device.
 	 */
-	device_link_add_missing_supplier_links();
-
-	if (fw_devlink_flags && is_fwnode_dev &&
-	    fwnode_has_op(dev->fwnode, add_links)) {
-		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
-		if (fw_ret == -ENODEV && !fw_devlink_is_permissive())
-			device_link_wait_for_mandatory_supplier(dev);
-		else if (fw_ret)
-			device_link_wait_for_optional_supplier(dev);
-	}
+	if (is_fwnode_dev)
+		fw_devlink_link_device(dev);
 
 	bus_probe_device(dev);
 	if (parent)
-- 
2.26.2.761.g0e0b3e54be-goog

