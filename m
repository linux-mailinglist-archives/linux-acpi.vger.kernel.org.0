Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A94E88BC
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Mar 2022 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiC0QPf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Mar 2022 12:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiC0QPe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Mar 2022 12:15:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C83286EA;
        Sun, 27 Mar 2022 09:13:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h23so17035359wrb.8;
        Sun, 27 Mar 2022 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+FhRc7KgAfPCLtqzrVvCY/1ZFWM7ONidYWxxdL5dd8=;
        b=QCb1Mj/vwpfX9vwr60BaT0jWLWOxTdbAaz7fX34nKWOM6q+nxQbAREWHTZIDynYv17
         HEgNCWHfQ8OpHfuXfzAaxRlKBPw/97tZmlcjwjuLWbZm1GMFYFNsxkmnsto5GlFb3KZ6
         37FvUFK/s27pDvezCj/hM6B4lWc1Gvmt6hzRgXcHxOUl77jRx/XNkCYq2otQFrWc4R3Z
         shd+qA8ovzULgh2XuNm6Uu5VvGjsRKeh3TA8JlsR7CBhKyECf6zmm2PZQKyGfkxEiNyL
         fDHDg6wuv7kE8lSa6Wa1MRFd3H46/VCecSQtUfrQaFBuPoii3piu7fnIg1pa4yzjFqFN
         wKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+FhRc7KgAfPCLtqzrVvCY/1ZFWM7ONidYWxxdL5dd8=;
        b=FWvCEPrsdV1NHOziHRqD+jWyk2rYIypFX/BVkymX33khl1qtzZmCQ55ln4ZKor5UHf
         5xmNCXPvnyBNHkvzevk7Kxt2fMRfeP8zNVsHSkaXu6TABw6QgoZ9u4iZ2sOVQlrOkL8C
         Lvwwm9UUURMbLC2eYZhiN834uv4uHlAUaZIv9kcQZTxT4HgnqqoW2tSQ6FgdhO+tr5GC
         +y6mGx2pBHOYnYOu6S7g3qA0FtU5RJYirakH4aMWvuM+mtqliibGAO+mq2Vfhfb8uQ09
         gZDJ1eFHtyvfsx3kDoSv9tpgpoC+lqY0NUm2KW/xVMF9LQqWKBUR8VSPZ3wbBitnsb62
         TfJA==
X-Gm-Message-State: AOAM532TskKo6lRLVpU+rLGAnVW47TDy1wrbCmJvJI6Tv27jAricCKnq
        d8OMzObdja+qz8Pbb0rNd6UBDocpK70=
X-Google-Smtp-Source: ABdhPJxf9ssoXELvzGRtdGYfg5LVFmgJBjqFPwAibpmWdBspmgcIajJ21JgroEVUnStLmXyKhnum6w==
X-Received: by 2002:adf:f20f:0:b0:203:fc73:a9a0 with SMTP id p15-20020adff20f000000b00203fc73a9a0mr18190442wro.418.1648397634354;
        Sun, 27 Mar 2022 09:13:54 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id k2-20020a1ca102000000b0038c78fdd59asm13764924wme.39.2022.03.27.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:13:54 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v2 1/5] ACPI: scan: Add acpi_dev_get_next_consumer_dev()
Date:   Sun, 27 Mar 2022 17:13:40 +0100
Message-Id: <20220327161344.50477-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220327161344.50477-1-djrscally@gmail.com>
References: <20220327161344.50477-1-djrscally@gmail.com>
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

In commit b83e2b306736 ("ACPI: scan: Add function to fetch dependent
of ACPI device") we added a means of fetching the first device to
declare itself dependent on another ACPI device in the _DEP method.
One assumption in that patch was that there would only be a single
consuming device, but this has not held.

Replace that function with a new function that fetches the next consumer
of a supplier device. Where no "previous" consumer is passed in, it
behaves identically to the original function.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- Removed acpi_dev_get_first_consumer_dev() entirely

 drivers/acpi/scan.c                         | 37 +++++++++++++++------
 drivers/platform/x86/intel/int3472/common.c |  2 +-
 include/acpi/acpi_bus.h                     |  4 ++-
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 010ef0b28374..8797e4a33674 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2215,9 +2215,21 @@ static void acpi_bus_attach(struct acpi_device *device, bool first_pass)
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
@@ -2348,25 +2360,28 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
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
- * The caller is responsible for putting the reference to adev when it is no
- * longer needed.
+ * If the returned adev is not passed as @start to this function, the caller is
+ * responsible for putting the reference to adev when it is no longer needed.
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
 }
-EXPORT_SYMBOL_GPL(acpi_dev_get_first_consumer_dev);
+EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
 
 /**
  * acpi_bus_scan - Add ACPI device node objects in a given namespace scope.
diff --git a/drivers/platform/x86/intel/int3472/common.c b/drivers/platform/x86/intel/int3472/common.c
index 77cf058e4168..9db2bb0bbba4 100644
--- a/drivers/platform/x86/intel/int3472/common.c
+++ b/drivers/platform/x86/intel/int3472/common.c
@@ -62,7 +62,7 @@ int skl_int3472_get_sensor_adev_and_name(struct device *dev,
 	struct acpi_device *sensor;
 	int ret = 0;
 
-	sensor = acpi_dev_get_first_consumer_dev(adev);
+	sensor = acpi_dev_get_next_consumer_dev(adev, NULL);
 	if (!sensor) {
 		dev_err(dev, "INT3472 seems to have no dependents.\n");
 		return -ENODEV;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 2f93ecf05dac..cdc726d251b6 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -696,7 +696,9 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const ch
 
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
-struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier);
+struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
+						   struct acpi_device *start);
+
 struct acpi_device *
 acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);
 struct acpi_device *
-- 
2.25.1

