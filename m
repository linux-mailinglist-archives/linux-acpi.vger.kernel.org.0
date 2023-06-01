Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B251C719EB4
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjFANqd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjFANqc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:46:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7961113D;
        Thu,  1 Jun 2023 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627191; x=1717163191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W6T4p4GhAjFrSW5KHP0koG6NdvXPbgd8/6BK9bkG2as=;
  b=E/wCS1FnNm6EQ1NLYrh8oiTW8AhwkWnBdILbiGgZeJQJFmIJ4BtNDSMu
   od8R7OoiOYF8mWecHONKrCw3ktMBcvAXKQ/soM/zGLJvSk2rrtXWGjzaM
   WKpaBbRNWa75tcorFMnsUorXwK+DkQTh7KHDsVr1A9l964vQtxR/8JU53
   dzHP/AruZ5qUMHl7qsP0NMGdrzPnyn05IIAZnY/Ao0y1AW7qKosVd9BEs
   cUTspA6zQe5z1vdJRPFr+3BQHyeTMlWhNaWKQTK+dY4xRgLYgEbSeHNjb
   PEpwx9ZCa+BJ0szC7RgS46nLgH8Rhf+u5g8cEro6mAPjBCi19dsjvCwD+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068875"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068875"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881602159"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881602159"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:14 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 30/35] platform/x86/xo15-ebook: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:33 +0200
Message-Id: <20230601131739.300760-31-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230601131739.300760-3-michal.wilczynski@intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/platform/x86/xo15-ebook.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 391f7ea4431e..57d143e06d65 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -56,8 +56,9 @@ static int ebook_send_state(struct acpi_device *device)
 	return 0;
 }
 
-static void ebook_switch_notify(struct acpi_device *device, u32 event)
+static void ebook_switch_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	switch (event) {
 	case ACPI_FIXED_HARDWARE_EVENT:
 	case XO15_EBOOK_NOTIFY_STATUS:
@@ -134,6 +135,10 @@ static int ebook_switch_add(struct acpi_device *device)
 		device_set_wakeup_enable(&device->dev, true);
 	}
 
+	error = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, ebook_switch_notify);
+	if (error)
+		goto err_free_input;
+
 	return 0;
 
  err_free_input:
@@ -147,6 +152,7 @@ static void ebook_switch_remove(struct acpi_device *device)
 {
 	struct ebook_switch *button = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, ebook_switch_notify);
 	input_unregister_device(button->input);
 	kfree(button);
 }
@@ -158,7 +164,6 @@ static struct acpi_driver xo15_ebook_driver = {
 	.ops = {
 		.add = ebook_switch_add,
 		.remove = ebook_switch_remove,
-		.notify = ebook_switch_notify,
 	},
 	.drv.pm = &ebook_switch_pm,
 };
-- 
2.40.1

