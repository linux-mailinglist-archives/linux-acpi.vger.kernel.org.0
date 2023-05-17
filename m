Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FCE7061FE
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjEQH7P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjEQH6e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD3A4225
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310312; x=1715846312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FeWTR1TcYGn2nHZn1Di77iaxrb5GIaXYv/p/XtxkbXs=;
  b=UF8CyPbzHj+uuB5xo9ivoGOVg+JcUEtAyvrsq8+xSCghA9c7sP56/ZNw
   2eAcLk9XQlPycU0zdd0V0xY0OINHu1H/4ay4iPBG4hXl+mW9yZmbRXKSr
   n+tCXonMGjz54GBUvtPzrwclF9Jf76d2X731MdhBJyvKF+gWzRqMqSZFb
   ZMpNRjih3taXNNaRLrn87o1DByUCvBAByi2o5QQM9l40W2urMOG3w7igS
   hIZVhaSaDE97MgefHAIMzCF074hLPmG0yCqG0XNSzyqX/UqwnQA5cBLP3
   RISurdy/GuQebGTZqOtp1cwmeS2tUZwpwbXnTcod5N2uHstxpIBnpx2e1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105462"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105462"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877437"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877437"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:28 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 21/34] platform/x86/fujitsu-laptop: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:11 +0200
Message-Id: <20230517075724.153992-22-michal.wilczynski@intel.com>
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
 drivers/platform/x86/fujitsu-laptop.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 085e044e888e..e270660c0762 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -136,6 +136,8 @@ struct fujitsu_laptop {
 
 static struct acpi_device *fext;
 
+static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data);
+
 /* Fujitsu ACPI interface function */
 
 static int call_fext_func(struct acpi_device *device,
@@ -839,7 +841,12 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	if (ret)
 		goto err_free_fifo;
 
-	return 0;
+	ret = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						acpi_fujitsu_laptop_notify);
+	if (ret)
+		goto err_free_fifo;
+
+	return ret;
 
 err_free_fifo:
 	kfifo_free(&priv->fifo);
@@ -851,6 +858,8 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
 {
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_fujitsu_laptop_notify);
+
 	fujitsu_laptop_platform_remove(device);
 
 	kfifo_free(&priv->fifo);
@@ -889,13 +898,16 @@ static void acpi_fujitsu_laptop_release(struct acpi_device *device)
 	}
 }
 
-static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
+static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct fujitsu_laptop *priv;
 	unsigned long flags;
 	int scancode, i = 0;
 	unsigned int irb;
 
+	priv = acpi_driver_data(device);
+
 	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
 		acpi_handle_info(device->handle, "Unsupported event [0x%x]\n",
 				 event);
@@ -963,7 +975,6 @@ static struct acpi_driver acpi_fujitsu_laptop_driver = {
 	.ops = {
 		.add = acpi_fujitsu_laptop_add,
 		.remove = acpi_fujitsu_laptop_remove,
-		.notify = acpi_fujitsu_laptop_notify,
 		},
 };
 
-- 
2.40.1

