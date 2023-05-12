Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17D7009CE
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbjELODT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbjELODI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF1D197
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900187; x=1715436187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rJgaY1FU/75lBv6vEcB+hMPhB8HcWGYocSjNGF+hErU=;
  b=G8FQJFwaJ4uemB2tvovHOTls0S7n9vwGJ4J43p12SJ5uL3ul46V13Xft
   /+mZlA3BQnZmyCpIK6kIjlsqICx6t25MCMa7TNhtR2Ztu4LazebO2LYAS
   B7wV0JerxQhsRvQvKk/K3l76f7LJAgmt9y5gUZg89s0D1YCxYkg7wjZx5
   BZIn9/Bdn8ZgBzrryMvLRtTsxlWip9OfGZ/wd4qWpABTdqXeApRvPD3FT
   ZQNHpk6WTHKH2UCSynK0bCZQNZpWqA5D67H7T0c4ddSc7rUKk1cv7zh5p
   pTrVsiwumcHmKABPZuK+wF+OnLoJ2sLzoQWEody0jfl0aGCYEmCd9fZNf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931073"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931073"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648941"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648941"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:05 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 11/34] iio/acpi-als: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:01:59 +0200
Message-Id: <20230512140222.124868-12-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512140222.124868-1-michal.wilczynski@intel.com>
References: <20230512140222.124868-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/iio/light/acpi-als.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 2d91caf24dd0..cf97b717650d 100644
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
@@ -225,9 +229,18 @@ static int acpi_als_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
+	ret = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static void acpi_als_remove(struct acpi_device *device)
+{
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);
+}
+
 static const struct acpi_device_id acpi_als_device_ids[] = {
 	{"ACPI0008", 0},
 	{},
@@ -241,7 +254,7 @@ static struct acpi_driver acpi_als_driver = {
 	.ids	= acpi_als_device_ids,
 	.ops = {
 		.add	= acpi_als_add,
-		.notify	= acpi_als_notify,
+		.remove = acpi_als_remove,
 	},
 };
 
-- 
2.38.1

