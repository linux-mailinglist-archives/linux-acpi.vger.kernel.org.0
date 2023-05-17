Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD17061F3
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjEQH7D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjEQH6c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F93C06
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310308; x=1715846308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKaXqW+DRkqJGpmPjw5NP4F6Cx+mNw9LMr+YNIGyaoY=;
  b=gzZKaMhUanQRlABORPLbu6HP10BGQBeFJqTiBQwojeKu+kAgG4ngOo32
   XlcjVThu21G9ZN2ZiDNoY6WdlY58pofZhmGwp2q975XKVmHVnqrKtoPzi
   CUINErKKqnRdPoMEL5S3lEv7YVp16ozInU5Sn4ZrxmWjZzAdxfkoRumAp
   O7TWd/aovjYb8jGtZUmqLshdNcVFrJhIhlCZAA00KAQSZNzRoJA/T0/GZ
   ys6pJfidJZyd7gNw5SjCx1OYagyS+mM1RzmIE2sg/Cx40E8iUWAfBrg9m
   V1VbA+6C8hZ7wACs2OqMa0Tx9CYaDztHYx2MCBMceyWnDjwe84PmbOlw+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105410"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105410"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877346"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877346"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:13 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 11/34] iio/acpi-als: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:01 +0200
Message-Id: <20230517075724.153992-12-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230517075724.153992-1-michal.wilczynski@intel.com>
References: <20230517075724.153992-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

