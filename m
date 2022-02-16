Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C4A4B9426
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Feb 2022 23:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiBPWxh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Feb 2022 17:53:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiBPWxf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2022 17:53:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9CD2271E3;
        Wed, 16 Feb 2022 14:53:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k1so5803252wrd.8;
        Wed, 16 Feb 2022 14:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymD5PEE4EIPkNYey9FwlcOTsDz20fQv3wKVbQGJvVn8=;
        b=d2BJFyQX2jTq84lilJnuwiZX+qpIJGo/wvV8qKnOg+nppJqOauKj2V1MvojsiaVuRl
         7+tuNWbfgeVgZdIIApy2jYU7VsGcgQGtDrn7dUxk3Wvt3BBGBmEOmOY2l4RtjWIEVNVH
         XjJfBGAeQ5Tu0RV7smEgJrrz7Asub7FW5Qu00LGKxfK+TS4170s7uzv6rzhCWa/CM1vM
         D2qkRwEl6pko/AvenI25kz2dUo2U4Nj49AhqcCL6mHu5MQt2RW4bqFeTkhTfh+gSIkQr
         P+r/5UJqvpLHxdf+HztRE62/a74/6hXSs4MDozliPvGi9/7ZpZIbcJA5V4Xw4sTklest
         pS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymD5PEE4EIPkNYey9FwlcOTsDz20fQv3wKVbQGJvVn8=;
        b=Tanje8KdZfLI9FiNYmxZYcKND2by2Xz05AmDP4yh/lTiWwElE8qZCV6dW0H1zziu19
         mAZ/OlyipSZz5YtuWaNRV/+gLTTCsiWLh1EBYZ9E8nX4N2AVG8+3SyTqta3kUKqv7eQu
         BbFZE85dD7n0S/MJa8bRveI89mD0mSJ3owo5C+OYj1AEzijigT3819SdLRh/sbN8EDN5
         h6hf9oyg3QNK9LxzgzHqRhSU1zH7a1JdtbPavsoVgK3zThdVJjoUwc3tdBWXZbzQGsuR
         94HPdiu7yCke305oY8lix0KuqOvCRfoi7ZePX5I6KGQaNpB9hBv9OrQoJk1Wnq35AuJg
         bQLw==
X-Gm-Message-State: AOAM533QFk90mAa1sDZMBe4NhrO4y0S9sEI0m5btaTm9mwiVmqV0FNhh
        my0jzmOvGOdS45sgm3ljeQStIKfv935SwA==
X-Google-Smtp-Source: ABdhPJxAJsVzGYVFT5Uz7uvmZhGj2ikMV3Cx0krBQzE16aRZZ1cabFMpVv4qLV/fJ8iPgCfi7s3lsA==
X-Received: by 2002:adf:ce83:0:b0:1e5:78e4:3a72 with SMTP id r3-20020adfce83000000b001e578e43a72mr136313wrn.279.1645052001083;
        Wed, 16 Feb 2022 14:53:21 -0800 (PST)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id o125sm182539wme.37.2022.02.16.14.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:53:20 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH 1/6] ACPI: scan: Add acpi_dev_get_next_consumer_dev()
Date:   Wed, 16 Feb 2022 22:52:59 +0000
Message-Id: <20220216225304.53911-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216225304.53911-1-djrscally@gmail.com>
References: <20220216225304.53911-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In commit b83e2b306736 ("ACPI: scan: Add function to fetch dependent of ACPI
device") we added a means of fetching the first device to declare itself
dependent on another ACPI device in the _DEP method. One assumption
in that patch was that there would only be a single consuming device,
but this has not held.

Extend the functionality by adding a new function that fetches the
next consumer of a supplier device. We can then simplify the original
function by simply calling the new one.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/acpi/scan.c     | 47 ++++++++++++++++++++++++++++++++++-------
 include/acpi/acpi_bus.h |  2 ++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4463c2eda61e..b3ed664ee1cb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2256,9 +2256,21 @@ static void acpi_bus_attach(struct acpi_device *device, bool first_pass)
 		device->handler->hotplug.notify_online(device);
 }
 
-static int acpi_dev_get_first_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
+static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
 {
-	struct acpi_device *adev;
+	struct acpi_device *adev = *(struct acpi_device **)data;
+
+	/*
+	 * If we're passed a 'previous' consumer device then we need to skip
+	 * any consumers until we meet the previous one, and then NULL @data
+	 * so the next one can be returned.
+	 */
+	if (adev) {
+		if (dep->consumer == adev->handle)
+			*(struct acpi_device **)data = NULL;
+
+		return 0;
+	}
 
 	adev = acpi_bus_get_acpi_device(dep->consumer);
 	if (adev) {
@@ -2389,23 +2401,42 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
 EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
 
 /**
- * acpi_dev_get_first_consumer_dev - Return ACPI device dependent on @supplier
+ * acpi_dev_get_next_consumer_dev - Return the next adev dependent on @supplier
  * @supplier: Pointer to the dependee device
+ * @start: Pointer to the current dependent device
  *
- * Returns the first &struct acpi_device which declares itself dependent on
+ * Returns the next &struct acpi_device which declares itself dependent on
  * @supplier via the _DEP buffer, parsed from the acpi_dep_list.
  *
  * The caller is responsible for putting the reference to adev when it is no
  * longer needed.
  */
-struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier)
+struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
+						   struct acpi_device *start)
 {
-	struct acpi_device *adev = NULL;
+	struct acpi_device *adev = start;
 
 	acpi_walk_dep_device_list(supplier->handle,
-				  acpi_dev_get_first_consumer_dev_cb, &adev);
+				  acpi_dev_get_next_consumer_dev_cb, &adev);
 
-	return adev;
+	acpi_dev_put(start);
+	return adev == start ? NULL : adev;
+}
+EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
+
+/**
+ * acpi_dev_get_first_consumer_dev - Return ACPI device dependent on @supplier
+ * @supplier: Pointer to the dependee device
+ *
+ * Returns the first &struct acpi_device which declares itself dependent on
+ * @supplier via the _DEP buffer, parsed from the acpi_dep_list.
+ *
+ * The caller is responsible for putting the reference to adev when it is no
+ * longer needed.
+ */
+struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier)
+{
+	return acpi_dev_get_next_consumer_dev(supplier, NULL);
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_first_consumer_dev);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ca88c4706f2b..8b06fef04722 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -720,6 +720,8 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const ch
 
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
+struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
+						   struct acpi_device *start);
 struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier);
 struct acpi_device *
 acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);
-- 
2.25.1

