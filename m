Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70E569321
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jul 2022 22:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiGFUOV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jul 2022 16:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiGFUOU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2022 16:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C330C21B1
        for <linux-acpi@vger.kernel.org>; Wed,  6 Jul 2022 13:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657138458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xfDMOGch/IV+fHWlNEOhMkFLCnf5tqI8lB1lNGVAg0=;
        b=FYUjDLmVSa5aRxDOnsHy0P8CeLuZybX5bcvi12ZAXD7QJWSB5Eq62hrbtyetzBk8c3Wpzi
        Y5L7ALYzCAU3xhoWYupYKiINMr4dJfj/Hi1yKA1231KOTmHvbvzaO9jvgtTu/YAfO8AmvG
        Q8HptdurG0i85fP5XliRCUoiEQc0Z0o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-a_mFrUyXM0mygSP06ue3iw-1; Wed, 06 Jul 2022 16:14:15 -0400
X-MC-Unique: a_mFrUyXM0mygSP06ue3iw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FE7C3C0D862;
        Wed,  6 Jul 2022 20:14:14 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD97A1415117;
        Wed,  6 Jul 2022 20:14:12 +0000 (UTC)
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
Subject: [RFC v2 1/2] ACPICA: Make address_space_handler Install and _REG execution 2 separate steps
Date:   Wed,  6 Jul 2022 22:14:09 +0200
Message-Id: <20220706201410.88244-2-hdegoede@redhat.com>
In-Reply-To: <20220706201410.88244-1-hdegoede@redhat.com>
References: <20220706201410.88244-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA pull-req: https://github.com/acpica/acpica/pull/786

ACPI-2.0 says that the EC op_region handler must be available immediately
(like the standard default op_region handlers):

Quoting from the ACPI spec version 6.3: "6.5.4 _REG (Region) ...
2. OSPM must make Embedded Controller operation regions, accessed via
the Embedded Controllers described in ECDT, available before executing
any control method. These operation regions may become inaccessible
after OSPM runs _REG(EmbeddedControl, 0)."

So the OS must probe the ECDT described EC and install the op_region handler
before calling acpi_enable_subsystem() and acpi_initialize_objects().

This is a problem because calling acpi_install_address_space_handler()
does not just install the op_region handler, it also runs the EC's _REG
method. This _REG method may rely on initialization done by the _INI
methods of one of the PCI / _SB root devices.

For the other early/default op_region handlers the op_region handler
install and the _REG execution is split into 2 separate steps:
1. acpi_ev_install_region_handlers(), called early from acpi_load_tables()
2. acpi_ev_initialize_op_regions(), called from acpi_initialize_objects()

To fix the EC op_region issue, add a new flags parameter to
acpi_install_address_space_handler() to allow doing things in
2 steps for other op_region handlers, like the EC handler, too.

To avoid having to modify all acpi_install_address_space_handler() callers,
the function is renamed to acpi_install_address_space_handler_flags() and
a static inline acpi_install_address_space_handler() is provided.

bug_link: https://bugzilla.kernel.org/show_bug.cgi?id=214899

Link: https://github.com/acpica/acpica/commit/a44f29d0
Reported-and-tested-by: Johannes Penßel <johannespenssel@posteo.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by:  <hdegoede@redhat.com>
---
 drivers/acpi/acpica/evxfregn.c | 32 +++++++++++++++++++------------
 include/acpi/acpixf.h          | 35 +++++++++++++++++++++++++---------
 include/acpi/actypes.h         |  2 ++
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 0a8372bf6a77..da6ab9ce1dc8 100644
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
@@ -37,13 +38,17 @@ ACPI_MODULE_NAME("evxfregn")
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
+					 void *context, u32 flags)
 {
 	struct acpi_namespace_node *node;
 	acpi_status status;
@@ -71,23 +76,26 @@ acpi_install_address_space_handler(acpi_handle device,
 
 	/* Install the handler for all Regions for this Space ID */
 
-	status =
-	    acpi_ev_install_space_handler(node, space_id, handler, setup,
-					  context);
-	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
+	if (!(flags & ACPI_NO_INSTALL_SPACE_HANDLER)) {
+		status =
+		    acpi_ev_install_space_handler(node, space_id, handler,
+						  setup, context);
+		if (ACPI_FAILURE(status)) {
+			goto unlock_and_exit;
+		}
 	}
 
 	/* Run all _REG methods for this address space */
-
-	acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
+	if (!(flags & ACPI_NO_EXEC__REG)) {
+		acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
+	}
 
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_install_address_space_handler)
+ACPI_EXPORT_SYMBOL(acpi_install_address_space_handler_flags)
 
 /*******************************************************************************
  *
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 67c0b9e734b6..08e8cfbed1a0 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -643,15 +643,32 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
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
+			    acpi_install_address_space_handler_flags(acpi_handle
+								     device,
+								     acpi_adr_space_type
+								     space_id,
+								     acpi_adr_space_handler
+								     handler,
+								     acpi_adr_space_setup
+								     setup,
+								     void
+								     *context,
+								     u32 flags))
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
+	return acpi_install_address_space_handler_flags(device, space_id,
+							handler, setup, context,
+							ACPI_FULL_INITIALIZATION);
+}
+
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_remove_address_space_handler(acpi_handle
 							       device,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 3491e454b2ab..aba0a86fcf1e 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -566,6 +566,8 @@ typedef u64 acpi_integer;
 #define ACPI_NO_OBJECT_INIT             0x0020
 #define ACPI_NO_DEVICE_INIT             0x0040
 #define ACPI_NO_ADDRESS_SPACE_INIT      0x0080
+#define ACPI_NO_INSTALL_SPACE_HANDLER   0x0100
+#define ACPI_NO_EXEC__REG               0x0200
 
 /*
  * Initialization state
-- 
2.36.0

