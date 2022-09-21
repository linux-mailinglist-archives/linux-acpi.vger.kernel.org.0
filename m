Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEE75E5686
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 01:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiIUXEv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 19:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiIUXEu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 19:04:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B559250;
        Wed, 21 Sep 2022 16:04:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so221926wma.2;
        Wed, 21 Sep 2022 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tkaw2t+B6c8owIS12c7Onfy2EYjl3zBqJf7jdOufviU=;
        b=ovRk512mAT3JaTZrcrWoImvW967ZusXKdeRAgRrmPL6KnAQRpelyZ+OtTDkxiebRv3
         KOkTBEzZr7lE2mPXpo9QAxKGqsSZdKn21HrWEp7/CT4TSnhX5qWehcEpqYv/rOJylNY5
         LC83R3EDC4R2+i9PB8ST84CRLTriBcHi6I7herocyVnD59f4M7xlCbAUcd+GX5aNJrSS
         zFykrmaTVcOR3vB4Sn2MMw4x84CLgVkVdmBDRotmy5X3qdqtnDw05iIxUn1J6KxY4/o7
         s2X9uXT5dTBAVw5NJFXI8i0vdaSV7azk+82tXnwTAxAGMOo8SOYzLyEEJIHgBTBM1RVN
         S/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tkaw2t+B6c8owIS12c7Onfy2EYjl3zBqJf7jdOufviU=;
        b=tojWTjuevYmX7398yIg1LwOkXQihkO1C8v+9geIgF7si/4WFYeM1FHp5t8Tp2yPt1m
         xbxtL3kGHhb+Up7ET4EClwOItkU3q4ssUVp5pDnRFEpZjCeoJCrG24xDCOFo3gahrBZm
         bvvYFnbDm+6BaKVdYWNKylG5Xa4aFQcOHWMkskcRgMFK4UlzX9Mb66cUsRaRIz2523X2
         YO8tnvBJH4DH9WSYJbgLIIATyt6lfKWK4ixKxb7RQxzJBSmgyo0Lmj6WmaJ58WjL7c05
         GNw/TIOkh0EdAIUIs16Ixhv2x7cDxLPSKyNLrKtJZ6n0GiBeCE+1yqu1jE4UdtS6rH/b
         jpgg==
X-Gm-Message-State: ACrzQf1MQPy7V9Bw+mzd8Dw2o5ulsNeKMDk7nbHrbjpkJDEPtrG/Zoyo
        PIuXLnooX2JYO5P/V1UOlVVfic6Tlp8=
X-Google-Smtp-Source: AMsMyM6o+RRn5VBV9VRWvNHeuhGkxt4ZBle80NX757tRkycoaINK/ebVYXrfEy6U0yy21gvbCweInA==
X-Received: by 2002:a05:600c:3585:b0:3b4:a308:1581 with SMTP id p5-20020a05600c358500b003b4a3081581mr7612070wmq.77.1663801487659;
        Wed, 21 Sep 2022 16:04:47 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id x12-20020adfffcc000000b0022ac672654dsm3519252wrs.58.2022.09.21.16.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:04:47 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v3 1/5] ACPI: scan: Add acpi_dev_get_next_consumer_dev()
Date:   Thu, 22 Sep 2022 00:04:35 +0100
Message-Id: <20220921230439.768185-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921230439.768185-1-djrscally@gmail.com>
References: <20220921230439.768185-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes since v2:

	- Separated adev_p and adev instead of relying on a cast (Rafael)
	- Used a separate if block to check for adev == start in
	  acpi_dev_get_next_consumer_dev() (Rafael)

 drivers/acpi/scan.c                         | 40 +++++++++++++++------
 drivers/platform/x86/intel/int3472/common.c |  2 +-
 include/acpi/acpi_bus.h                     |  4 ++-
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 42cec8120f18..12ac2f3ae5d2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2235,9 +2235,22 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	return 0;
 }
 
-static int acpi_dev_get_first_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
+static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
 {
-	struct acpi_device *adev;
+	struct acpi_device **adev_p = data;
+	struct acpi_device *adev = *adev_p;
+
+	/*
+	 * If we're passed a 'previous' consumer device then we need to skip
+	 * any consumers until we meet the previous one, and then NULL @data
+	 * so the next one can be returned.
+	 */
+	if (adev) {
+		if (dep->consumer == adev->handle)
+			*adev_p = NULL;
+
+		return 0;
+	}
 
 	adev = acpi_bus_get_acpi_device(dep->consumer);
 	if (adev) {
@@ -2368,25 +2381,32 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
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
+
+	acpi_dev_put(start);
+
+	if (adev == start)
+		return NULL;
 
 	return adev;
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
index e7d27373ff71..bf0886dca6eb 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -736,7 +736,9 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const ch
 
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

