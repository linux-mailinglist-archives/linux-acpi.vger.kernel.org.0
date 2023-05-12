Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9417009C9
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbjELODI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241353AbjELODB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD341729
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900180; x=1715436180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P7ODO9EjsRSMUU+TF25N7oGxInxqbR3bwLw9wwr0pYY=;
  b=GERB+Ro14/AqgRSGslxklC4vhNl5KBvCMxecDIgYzGKcvCusmyx61z9U
   yrzMzh9uUbbKpB1EUzO6Q4m91dps0dAObIYpAnN2viCK8fi5WPeF0SIKF
   6l3vbZM2TrYJY9bEEp9ryPz7asa5ZxSarGjQ+Ji7W5LuKVSaGnIg5cFS8
   4SQRrsy6KNlVxN0FCu69wZZddCVb5Iir6DRRJzUcAjDqvxlLNWVsiIB8q
   Bt1Maot1NhX9G2JP87yZW6Tss9G6xOShTyCAclHvZJ6HHR1jn6l13pnjh
   OWEJfdq8toxwEIbGInAceElR2UmZkH935nygsZlkIbAy2rw1cJ7xp+UOg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931033"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931033"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:02:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648920"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648920"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:02:56 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 06/34] acpi/hed: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:01:54 +0200
Message-Id: <20230512140222.124868-7-michal.wilczynski@intel.com>
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
 drivers/acpi/hed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 78d44e3fe129..2a476415817f 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -42,7 +42,7 @@ EXPORT_SYMBOL_GPL(unregister_acpi_hed_notifier);
  * it is used by HEST Generic Hardware Error Source with notify type
  * SCI.
  */
-static void acpi_hed_notify(struct acpi_device *device, u32 event)
+static void acpi_hed_notify(acpi_handle handle, u32 event, void *data)
 {
 	blocking_notifier_call_chain(&acpi_hed_notify_list, 0, NULL);
 }
@@ -53,11 +53,12 @@ static int acpi_hed_add(struct acpi_device *device)
 	if (hed_handle)
 		return -EINVAL;
 	hed_handle = device->handle;
-	return 0;
+	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_hed_notify);
 }
 
 static void acpi_hed_remove(struct acpi_device *device)
 {
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_hed_notify);
 	hed_handle = NULL;
 }
 
@@ -68,7 +69,6 @@ static struct acpi_driver acpi_hed_driver = {
 	.ops = {
 		.add = acpi_hed_add,
 		.remove = acpi_hed_remove,
-		.notify = acpi_hed_notify,
 	},
 };
 module_acpi_driver(acpi_hed_driver);
-- 
2.38.1

