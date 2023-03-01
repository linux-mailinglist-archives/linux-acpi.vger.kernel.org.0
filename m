Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146446A765B
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Mar 2023 22:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCAVuK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Mar 2023 16:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCAVuA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2023 16:50:00 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A85236FFC
        for <linux-acpi@vger.kernel.org>; Wed,  1 Mar 2023 13:49:59 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c039f859so295743707b3.21
        for <linux-acpi@vger.kernel.org>; Wed, 01 Mar 2023 13:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677707398;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpgIbXU90/hputcGUyYvUs2slzqLS52o251K2JuSVM8=;
        b=WaP00pOPIPdoTKkboEHT7Thc02cLx/1EyuvJqzfTtmWLWA1jQ7YPettxWnzX2TZ4nW
         3ZOPzjYi2AIW7hhE3FXtgR+HEl3l8QjhIDd1S0RqidjWKH3J8sP5oyIeYRCXUICPfwiv
         80TWtSEdZuCUaHNKXjmuE1Teqqmh4yRnBVe7Iz3tRKJ9qbqvIKvYBZg+wb9eLepwTDcg
         YUMb9SaMw1WyJWCu5TttIIzoEfBQRNMutAeaYMWK9fY6Xml97VcqZFGbfZdvXwPXlw5m
         dUGLd+VAEHnuULkYSsjmdc4zDZoHUfivc9i72rN6URuBLxXr5z1o/u/G6HTJngAmXsc3
         iJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677707398;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpgIbXU90/hputcGUyYvUs2slzqLS52o251K2JuSVM8=;
        b=ubWhMnPK/ZZBjh8pnqqPbmfMcKu8HfRBlzNpweji44np1zXJiIyUkCPWvUyPLWd7dr
         bdA/o1I3Qnorot6ZOVGY/uri/Sq8+TEidLkxmpscsZ3QW1g6SVt7rzVCLn2FzkxFNcXL
         b5KzFVXcxJ8/Y1ldNCXydOJK79tgG9l57TK4Zduj3P3XGedhh5/S0CPJWP/X3GI/yInk
         R4/xrWT88DlN8wzYp3qXqRIi3Smnc3L6JL2axPkOH2+xiDUtoJJl6LTcPH7/HVQNFvov
         kB95bB9P/UuIGKa+CJDlwp5T2AQRZsRTWTMoUvvmHvggFjA3APumni3AApAQNjq/8fk4
         LGNw==
X-Gm-Message-State: AO0yUKVrHEEnPlJ54fxLYJDa1XC9BjxNkXnZgvyWzNjKj4qKeXP9t28Q
        vgdnGApqveEevpp0HQxJBV+scsxw4m+Jvk0=
X-Google-Smtp-Source: AK7set82rOfXzXOZ9yj4WBRb6uaFtTB5S3WLT17i5Dm6MSyoMsbRAM5JC31qi17jLdC0x0otk/S0lMBW9GeEcZU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:debf:1aed:5c45:c92])
 (user=saravanak job=sendgmr) by 2002:a0d:fd41:0:b0:527:ad7e:8e1a with SMTP id
 n62-20020a0dfd41000000b00527ad7e8e1amr18ywf.216.1677707398396; Wed, 01 Mar
 2023 13:49:58 -0800 (PST)
Date:   Wed,  1 Mar 2023 13:49:48 -0800
In-Reply-To: <20230301214952.2190757-1-saravanak@google.com>
Message-Id: <20230301214952.2190757-2-saravanak@google.com>
Mime-Version: 1.0
References: <20230301214952.2190757-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 1/4] usb: typec: stusb160x: Remove use of fw_devlink_purge_absent_suppliers()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit 6b63376722d9 (usb: typec: stusb160x: Don't block
probing of consumer of "connector" nodes, 2021-07-16).

After recent changes to fw_devlink that ended with commit 4a032827daa8
("of: property: Simplify of_link_to_phandle()"), fw_devlink no longer
cares about the "compatible" property and figures out the correct struct
device at runtime. So, we no longer need to call
fw_devlink_purge_absent_suppliers().

Signed-off-by: Saravana Kannan <saravanak@google.com>
Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/usb/typec/stusb160x.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
index 494b371151e0..482bffeb8a8f 100644
--- a/drivers/usb/typec/stusb160x.c
+++ b/drivers/usb/typec/stusb160x.c
@@ -685,15 +685,6 @@ static int stusb160x_probe(struct i2c_client *client)
 	if (!fwnode)
 		return -ENODEV;
 
-	/*
-	 * This fwnode has a "compatible" property, but is never populated as a
-	 * struct device. Instead we simply parse it to read the properties.
-	 * This it breaks fw_devlink=on. To maintain backward compatibility
-	 * with existing DT files, we work around this by deleting any
-	 * fwnode_links to/from this fwnode.
-	 */
-	fw_devlink_purge_absent_suppliers(fwnode);
-
 	/*
 	 * When both VDD and VSYS power supplies are present, the low power
 	 * supply VSYS is selected when VSYS voltage is above 3.1 V.
-- 
2.39.2.722.g9855ee24e9-goog

