Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1A77009C7
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbjELODH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241380AbjELODB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE76197
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900179; x=1715436179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2GbV0P1CvPEQGkReiS1XP+SO7s2AdGYiVfzqGrM4eXI=;
  b=ILZDEDL+RiZu0cVE7rFPeFB279k/4c2pG2rKWobINUqECCa7uR/PZVeh
   2lbT8WsdASwDATouAc+fZW0ojINxLcNxWySOZctt5jy2tnu2EuNph0edQ
   VAUEW0rjCwk4JEri94obBSyOmbU3oBzNEYwJydmrcEhIGbEA0bAOnIEXD
   Q4d0LeoHenqOsA2ViDEPx5yuGZlom4ZPa3iZE4mhBu/OUVTVHJsF9IQCr
   lOnxrWQpitZuC4UdNXrYPbzY9UT6pPEpq7R60G9NHM+ylMLywFxVNF5oU
   LzfQ5GOWabUs5CrGKXCUXV/qWccyIOIhqxRmoRiXIBqMyGY+3HzucpCZC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931022"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931022"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648907"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648907"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:02:49 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 03/34] acpi/video: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:01:51 +0200
Message-Id: <20230512140222.124868-4-michal.wilczynski@intel.com>
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
 drivers/acpi/acpi_video.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 62f4364e4460..c94f36f14980 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -77,7 +77,7 @@ static DEFINE_MUTEX(video_list_lock);
 static LIST_HEAD(video_bus_head);
 static int acpi_video_bus_add(struct acpi_device *device);
 static void acpi_video_bus_remove(struct acpi_device *device);
-static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
+static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
 
 /*
  * Indices in the _BCL method response: the first two items are special,
@@ -104,7 +104,6 @@ static struct acpi_driver acpi_video_bus = {
 	.ops = {
 		.add = acpi_video_bus_add,
 		.remove = acpi_video_bus_remove,
-		.notify = acpi_video_bus_notify,
 		},
 };
 
@@ -1527,12 +1526,15 @@ static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
 				  acpi_osi_is_win8() ? 0 : 1);
 }
 
-static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
+static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_video_bus *video = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct acpi_video_bus *video;
 	struct input_dev *input;
 	int keycode = 0;
 
+	video = acpi_driver_data(device);
+
 	if (!video || !video->input)
 		return;
 
@@ -2053,7 +2055,12 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 	acpi_video_bus_add_notify_handler(video);
 
-	return 0;
+	error =  acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						    acpi_video_bus_notify);
+	if (error)
+		goto err_put_video;
+
+	return error;
 
 err_put_video:
 	acpi_video_bus_put_devices(video);
@@ -2075,6 +2082,7 @@ static void acpi_video_bus_remove(struct acpi_device *device)
 
 	video = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_video_bus_notify);
 	mutex_lock(&video_list_lock);
 	list_del(&video->entry);
 	mutex_unlock(&video_list_lock);
-- 
2.38.1

