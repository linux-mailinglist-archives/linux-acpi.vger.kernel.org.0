Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6DE5F3216
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Oct 2022 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJCOmh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Oct 2022 10:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJCOmb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Oct 2022 10:42:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848172B26F
        for <linux-acpi@vger.kernel.org>; Mon,  3 Oct 2022 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664808149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUCeuDNApK3B7dNCjojESQmQ3ap7zN7M5/26lVXR4kw=;
        b=McPqDVmvS4RNNINJJfAGCoD8Qabi2gA0eqW78PrLY0UJFm/4sTxrXwigrdl2zksz67M5eh
        sOC5ihVvGZJTRb+jhx4SubrLQeBan5c9bqAy8x2vnCWKZFTUPmSOyCFvh7IbRzy/APhXGY
        6OyfLUnJLiA6rLqxkBCT+3iKI41VWFg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-38dvb9jkOkGOoAlKZaLOaQ-1; Mon, 03 Oct 2022 10:42:24 -0400
X-MC-Unique: 38dvb9jkOkGOoAlKZaLOaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 917883C14844;
        Mon,  3 Oct 2022 14:42:23 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DB0F40EFB00;
        Mon,  3 Oct 2022 14:42:20 +0000 (UTC)
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
Subject: [RFC v3 2/4] ACPICA: Allow address_space_handler Install and _REG execution as 2 separate steps
Date:   Mon,  3 Oct 2022 16:42:12 +0200
Message-Id: <20221003144214.345279-3-hdegoede@redhat.com>
In-Reply-To: <20221003144214.345279-1-hdegoede@redhat.com>
References: <20221003144214.345279-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit ead772dd15412719e033617966ec7e3a14bd4d89

ACPI-2.0 says that the EC op_region handler must be available immediately
(like the standard default op_region handlers):

Quoting from the ACPI spec version 6.3: "6.5.4 _REG (Region) ...
2. OSPM must make Embedded Controller operation regions, accessed via
the Embedded Controllers described in ECDT, available before executing
any control method. These operation regions may become inaccessible
after OSPM runs _REG(EmbeddedControl, 0)."

So the OS must probe the ECDT described EC and install the OpRegion hdlr
before calling acpi_enable_subsystem() and acpi_initialize_objects().

This is a problem because calling acpi_install_address_space_handler()
does not just install the op_region handler, it also runs the EC's _REG
method. This _REG method may rely on initialization done by the _INI
methods of one of the PCI / _SB root devices.

For the other early/default op_region handlers the op_region handler
install and the _REG execution is split into 2 separate steps:
1. acpi_ev_install_region_handlers(), called early from acpi_load_tables()
2. acpi_ev_initialize_op_regions(), called from acpi_initialize_objects()

To fix the EC op_region issue, add 2 bew functions:
1. acpi_install_address_space_handler_no_Reg()
2. acpi_execute_reg_methods()
to allow doing things in 2 steps for other op_region handlers,
like the EC handler, too.

Note that the comment describing acpi_ev_install_region_handlers() even has
an alinea describing this problem. Using the new methods allows users
to avoid this problem.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214899
Link: https://github.com/acpica/acpica/commit/ead772dd
Reported-and-tested-by: Johannes Penßel <johannespenssel@posteo.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/evxfregn.c | 92 +++++++++++++++++++++++++++++++---
 include/acpi/acpixf.h          | 10 ++++
 2 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 0a8372bf6a77..a5c19f46ec17 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -20,13 +20,14 @@ ACPI_MODULE_NAME("evxfregn")
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_install_address_space_handler
+ * FUNCTION:    acpi_install_address_space_handler_internal
  *
  * PARAMETERS:  device          - Handle for the device
  *              space_id        - The address space ID
  *              handler         - Address of the handler
  *              setup           - Address of the setup function
  *              context         - Value passed to the handler on each access
+ *              Run_reg         - Run _REG methods for this address space?
  *
  * RETURN:      Status
  *
@@ -37,13 +38,16 @@ ACPI_MODULE_NAME("evxfregn")
  * are executed here, and these methods can only be safely executed after
  * the default handlers have been installed and the hardware has been
  * initialized (via acpi_enable_subsystem.)
+ * To avoid this problem pass FALSE for Run_Reg and later on call
+ * acpi_execute_reg_methods() to execute _REG.
  *
  ******************************************************************************/
-acpi_status
-acpi_install_address_space_handler(acpi_handle device,
-				   acpi_adr_space_type space_id,
-				   acpi_adr_space_handler handler,
-				   acpi_adr_space_setup setup, void *context)
+static acpi_status
+acpi_install_address_space_handler_internal(acpi_handle device,
+					    acpi_adr_space_type space_id,
+					    acpi_adr_space_handler handler,
+					    acpi_adr_space_setup setup,
+					    void *context, u8 run_reg)
 {
 	struct acpi_namespace_node *node;
 	acpi_status status;
@@ -80,14 +84,40 @@ acpi_install_address_space_handler(acpi_handle device,
 
 	/* Run all _REG methods for this address space */
 
-	acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
+	if (run_reg) {
+		acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
+	}
 
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
 
+acpi_status
+acpi_install_address_space_handler(acpi_handle device,
+				   acpi_adr_space_type space_id,
+				   acpi_adr_space_handler handler,
+				   acpi_adr_space_setup setup, void *context)
+{
+	return acpi_install_address_space_handler_internal(device, space_id,
+							   handler, setup,
+							   context, TRUE);
+}
+
 ACPI_EXPORT_SYMBOL(acpi_install_address_space_handler)
+acpi_status
+acpi_install_address_space_handler_no_reg(acpi_handle device,
+					  acpi_adr_space_type space_id,
+					  acpi_adr_space_handler handler,
+					  acpi_adr_space_setup setup,
+					  void *context)
+{
+	return acpi_install_address_space_handler_internal(device, space_id,
+							   handler, setup,
+							   context, FALSE);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_install_address_space_handler_no_reg)
 
 /*******************************************************************************
  *
@@ -228,3 +258,51 @@ acpi_remove_address_space_handler(acpi_handle device,
 }
 
 ACPI_EXPORT_SYMBOL(acpi_remove_address_space_handler)
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_execute_reg_methods
+ *
+ * PARAMETERS:  device          - Handle for the device
+ *              space_id        - The address space ID
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Execute _REG for all op_regions of a given space_id.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_execute_reg_methods(acpi_handle device, acpi_adr_space_type space_id)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_execute_reg_methods);
+
+	/* Parameter validation */
+
+	if (!device) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Convert and validate the device handle */
+
+	node = acpi_ns_validate_handle(device);
+	if (node) {
+
+		/* Run all _REG methods for this address space */
+
+		acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
+	} else {
+		status = AE_BAD_PARAMETER;
+	}
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_execute_reg_methods)
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3fde274c465b..9c1021dcd270 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -652,6 +652,16 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 							       acpi_adr_space_setup
 							       setup,
 							       void *context))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_install_address_space_handler_no_reg
+			    (acpi_handle device, acpi_adr_space_type space_id,
+			     acpi_adr_space_handler handler,
+			     acpi_adr_space_setup setup,
+			     void *context))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_execute_reg_methods(acpi_handle device,
+						     acpi_adr_space_type
+						     space_id))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_remove_address_space_handler(acpi_handle
 							      device,
-- 
2.37.3

