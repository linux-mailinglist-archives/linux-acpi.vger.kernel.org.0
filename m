Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681A754D22C
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 21:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350481AbiFOT5L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 15:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354552AbiFOT5H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 15:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD47633EA6
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655323021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EllYvUf+BqeGIFNzhqo9UeQvV9ROTX24PLrW916RQIQ=;
        b=NTrKB7DnOeczyPZmgXgcSmDGdRJSzOxWY+eyJoD7QcI0XyIkas3Q2sNHEPCpusFbXwHxIW
        /JbLo/HGwrLchGsUfAWBCDDo+psYQBcMwwqyVxyQ9zU4GuJwsPfNVY//U9XVsXzZbBLwFM
        uNAxNYFKJf3qnBfgULkgZfw/ysBMvps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-sutnA9lUPBinVqcT2idJKw-1; Wed, 15 Jun 2022 15:56:56 -0400
X-MC-Unique: sutnA9lUPBinVqcT2idJKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB20183397C;
        Wed, 15 Jun 2022 19:56:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6607D2026D64;
        Wed, 15 Jun 2022 19:56:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        =?UTF-8?q?Johannes=20Pen=C3=9Fel?= <johannespenssel@posteo.net>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: [RFC 3/4] ACPICA: Make address-space-handler install and _REG execution 2 separate steps
Date:   Wed, 15 Jun 2022 21:56:42 +0200
Message-Id: <20220615195643.12608-4-hdegoede@redhat.com>
In-Reply-To: <20220615195643.12608-1-hdegoede@redhat.com>
References: <20220615195643.12608-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI-2.0 says that the EC OpRegion handler must be available immediately
(like the standard default OpRegion handlers). So the OS must probe the
ECDT described EC and install the OpRegion handler before calling
acpi_enable_subsystem() and acpi_initialize_objects().

This is a problem because calling acpi_install_address_space_handler()
does not just install the OpRegion handler, it also runs the EC's _REG
method. This _REG method may rely on initialization done by the _INI
methods of one of the PCI / _SB root devices.

This _REG depends on _INI problem can be fixed by calling the new
acpi_early_initialize_objects() function before probing the EC.
But on some boards (e.g. Lenovo X1C8) the root devices _INI method
relies on the EC OpRegion so executing the _INI methods before
registering the EC OpRegion handler leads to errors there.

For the default OpRegion handlers the ACPICA code solves these ordering
issues by splitting the Opregion handler install and the _REG execution
into 2 separate steps:
1. acpi_ev_install_region_handlers(), called early from acpi_load_tables()
2. acpi_ev_initialize_op_regions(), called from acpi_initialize_objects()

To fix the similar EC OpRegion issues, add a new flags parameter to
acpi_install_address_space_handler() to allow doing things in 2 steps
for the EC OpRegion handler too.

This will allow using the following initialization order to fix things:

1. acpi_load_tables()
2. probe EC, call acpi_install_address_space_handler(ACPI_NO_EXEC__REG)
3. acpi_enable_subsystem()
4. acpi_early_initialize_objects()
5. call acpi_install_address_space_handler(ACPI_NO_INSTALL_SPACE_HANDLER) to
   run the EC's _REG method
6. acpi_initialize_objects(ACPI_NO_EARLY_DEVICE_INIT)

To avoid having to modify all acpi_install_address_space_handler() callers,
the function is renamed to acpi_install_address_space_handler_flags() and
a static inline acpi_install_address_space_handler() is provided.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214899
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/evxfregn.c | 32 +++++++++++++++++++-------------
 include/acpi/acpixf.h          | 33 ++++++++++++++++++++++++---------
 include/acpi/actypes.h         |  2 ++
 3 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 0a8372bf6a77..ed79615fb844 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -27,6 +27,7 @@ ACPI_MODULE_NAME("evxfregn")
  *              handler         - Address of the handler
  *              setup           - Address of the setup function
  *              context         - Value passed to the handler on each access
+ *              flags           - Flags
  *
  * RETURN:      Status
  *
@@ -37,13 +38,18 @@ ACPI_MODULE_NAME("evxfregn")
  * are executed here, and these methods can only be safely executed after
  * the default handlers have been installed and the hardware has been
  * initialized (via acpi_enable_subsystem.)
+ * To avoid this problem pass the ACPI_NO_EXEC__REG flag and
+ * later call this function again with ACPI_NO_INSTALL_SPACE_HANDLER to
+ * execute _REG.
  *
  ******************************************************************************/
 acpi_status
-acpi_install_address_space_handler(acpi_handle device,
-				   acpi_adr_space_type space_id,
-				   acpi_adr_space_handler handler,
-				   acpi_adr_space_setup setup, void *context)
+acpi_install_address_space_handler_flags(acpi_handle device,
+					 acpi_adr_space_type space_id,
+					 acpi_adr_space_handler handler,
+					 acpi_adr_space_setup setup,
+					 void *context,
+					 u32 flags)
 {
 	struct acpi_namespace_node *node;
 	acpi_status status;
@@ -70,24 +76,24 @@ acpi_install_address_space_handler(acpi_handle device,
 	}
 
 	/* Install the handler for all Regions for this Space ID */
-
-	status =
-	    acpi_ev_install_space_handler(node, space_id, handler, setup,
-					  context);
-	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
+	if (!(flags & ACPI_NO_INSTALL_SPACE_HANDLER)) {
+		status =
+		    acpi_ev_install_space_handler(node, space_id, handler, setup,
+						  context);
+		if (ACPI_FAILURE(status))
+			goto unlock_and_exit;
 	}
 
 	/* Run all _REG methods for this address space */
-
-	acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
+	if (!(flags & ACPI_NO_EXEC__REG))
+		acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
 
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_install_address_space_handler)
+ACPI_EXPORT_SYMBOL(acpi_install_address_space_handler_flags)
 
 /*******************************************************************************
  *
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 4b8d19f48071..7116fc2d42a7 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -645,15 +645,30 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 							acpi_notify_handler
 							handler))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_install_address_space_handler(acpi_handle
-								device,
-								acpi_adr_space_type
-								space_id,
-								acpi_adr_space_handler
-								handler,
-								acpi_adr_space_setup
-								setup,
-								void *context))
+			     acpi_install_address_space_handler_flags(acpi_handle
+								      device,
+								      acpi_adr_space_type
+								      space_id,
+								      acpi_adr_space_handler
+								      handler,
+								      acpi_adr_space_setup
+								      setup,
+								      void *context,
+								      u32 flags))
+static ACPI_INLINE acpi_status acpi_install_address_space_handler(acpi_handle
+								  device,
+								  acpi_adr_space_type
+								  space_id,
+								  acpi_adr_space_handler
+								  handler,
+								  acpi_adr_space_setup
+								  setup,
+								  void *context)
+{
+	return acpi_install_address_space_handler_flags(
+			device, space_id, handler, setup, context,
+			ACPI_FULL_INITIALIZATION);
+}
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_remove_address_space_handler(acpi_handle
 							       device,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index e377b7daec54..6042c50ad1ee 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -567,6 +567,8 @@ typedef u64 acpi_integer;
 #define ACPI_NO_DEVICE_INIT             0x0040
 #define ACPI_NO_EARLY_DEVICE_INIT       0x0080
 #define ACPI_NO_ADDRESS_SPACE_INIT      0x0100
+#define ACPI_NO_INSTALL_SPACE_HANDLER   0x0200
+#define ACPI_NO_EXEC__REG               0x0400
 
 /*
  * Initialization state
-- 
2.36.0

