Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38130704CE5
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjEPLsq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjEPLsl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:48:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6154D212B
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237693; x=1715773693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKaXqW+DRkqJGpmPjw5NP4F6Cx+mNw9LMr+YNIGyaoY=;
  b=fT2xNfSEeu3/Z8cBIchGT27/UjtJ0ITtq9RFs+IDOihhsecURwSAH+J8
   LRw6Lwy5V71UnXzAFYZeILoYWHbMuNbXy/WbOKGnkjUR0OIdpaRNMuTNV
   B0S3JLUFqyEHQTP+8W/y/2HnOPNQq3LQLID0cyOWzGwUGrb/TzbKT1cnw
   B+ocVWbCoWVwhkmU8Ams3fPCsVF0cJylGcP4gOkRYQw9QUoc3j0TZVUuC
   erUeLOCCO6TwONQsjUF9xs16GGdbUjPXH1csBgG5hchE2SkxczEj1tvo2
   bIDEDRU+y2OrwS6KCtYFZKKLel0pX9YXw2SwBD0fVdAUHeZd5XV3KN9lK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111638"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111638"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961810"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961810"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:48 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 11/34] iio/acpi-als: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:45:54 +0200
Message-Id: <20230516114617.148963-12-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230516114617.148963-1-michal.wilczynski@intel.com>
References: <20230516114617.148963-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently logic for installing notifications from ACPI devices is
implemented using notify callback in struct acpi_driver. Preparations
are being made to replace acpi_driver with more generic struct
platform_driver, which doesn't contain notify callback. Furthermore
as of now handlers are being called indirectly through
acpi_notify_device(), which decreases performance.

Call acpi_device_install_event_handler() at the end of .add() callback.
Call acpi_device_remove_event_handler() at the beginning of .remove()
callback. Change arguments passed to the notify callback to match with
what's required by acpi_device_install_event_handler().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/iio/light/acpi-als.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 2d91caf24dd0..5e200c6d91bc 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -100,10 +100,14 @@ static int acpi_als_read_value(struct acpi_als *als, char *prop, s32 *val)
 	return 0;
 }
 
-static void acpi_als_notify(struct acpi_device *device, u32 event)
+static void acpi_als_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct iio_dev *indio_dev = acpi_driver_data(device);
-	struct acpi_als *als = iio_priv(indio_dev);
+	struct acpi_device *device = data;
+	struct iio_dev *indio_dev;
+	struct acpi_als *als;
+
+	indio_dev = acpi_driver_data(device);
+	als = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev)) {
 		switch (event) {
@@ -225,7 +229,16 @@ static int acpi_als_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);
+}
+
+static void acpi_als_remove(struct acpi_device *device)
+{
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);
 }
 
 static const struct acpi_device_id acpi_als_device_ids[] = {
@@ -241,7 +254,7 @@ static struct acpi_driver acpi_als_driver = {
 	.ids	= acpi_als_device_ids,
 	.ops = {
 		.add	= acpi_als_add,
-		.notify	= acpi_als_notify,
+		.remove = acpi_als_remove,
 	},
 };
 
-- 
2.40.1

