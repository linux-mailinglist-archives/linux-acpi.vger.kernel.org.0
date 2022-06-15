Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED254D229
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 21:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351546AbiFOT47 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 15:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350481AbiFOT44 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 15:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 377CF31353
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655323014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yynx7uBPgU1LaWpk2SJ9B5CmNvk7cX/7wHodT57VRik=;
        b=QYYlLMQPwps9t+yXbf6Aycb16qqcWEtdVObohWGxFZcvoVPYZ541u16TtJZktbts3YY4RQ
        PNsrgtpYfMd+CiCsRA913MWG8qIFnP1h7J/6hqYwWdE/5egYhsxJBTRjwKK9Uxj9GKt0bO
        5lmo1LzPpscv2V851sjia/ZriXlrNnc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-DVBYUW6xNNuOFev0GvRJbg-1; Wed, 15 Jun 2022 15:56:53 -0400
X-MC-Unique: DVBYUW6xNNuOFev0GvRJbg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78334185A7A4;
        Wed, 15 Jun 2022 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3E6A2026D64;
        Wed, 15 Jun 2022 19:56:50 +0000 (UTC)
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
Subject: [RFC 1/4] ACPICA: Add an acpi_early_initialize_objects() helper
Date:   Wed, 15 Jun 2022 21:56:40 +0200
Message-Id: <20220615195643.12608-2-hdegoede@redhat.com>
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

acpi_initialize_objects() calls \_INI and \_SB.INI before executing _REG
OpRegion methods, because the _REG methods may rely on initialization
done by these _INI methods.

ACPI-2.0 says that the EC OpRegion handler must be available immediately
(like the standard default OpRegion handlers). So the OS must probe the
ECDT described EC early on and ends up calling the EC's _REG method before
calling acpi_initialize_objects().

This may lead to the EC _REG method not working properly e.g.
on a "Lenovo IdeaPad 5 15ITL05" \_SB.PC00.LPCB.EC0._REG gets
evaluated before \_SB.PC00._INI and that _REG contains:

    If ((OSYS == 0x07DF))
    {
        Local0 = 0x06
    }

    If ((Acquire (LFCM, 0xA000) == Zero))
    {
        OSTY = Local0
        ...

With OSTY being a SystemMemory OpRegion field, due to the _INI running
too late, Local0 stays at 0. Causing OSTY to be set to 0 instead of 6,
which causes the brightness up/down keys to not work, see:
https://bugzilla.kernel.org/show_bug.cgi?id=214899

Factor out the early (root) object _INI calls into a new
acpi_early_initialize_objects() helper. The OS code can then call this
before executing the EC's _REG method so that it will work properly.

Note that if the OS code uses acpi_early_initialize_objects(),
then it must also pass the new ACPI_NO_EARLY_DEVICE_INIT flag
to acpi_initialize_objects() to avoid the _INI methods getting
evaluated twice.

Without this flag acpi_initialize_objects() will still do the
early object _INI calls as before. So by itself this patch does
not cause any functional changes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/acnamesp.h |   2 +
 drivers/acpi/acpica/nsinit.c   | 166 ++++++++++++++++++++-------------
 drivers/acpi/acpica/utxfinit.c |  21 +++++
 include/acpi/acpixf.h          |   2 +
 include/acpi/actypes.h         |   3 +-
 5 files changed, 127 insertions(+), 67 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 7b27b9cc5916..4c8196adb98e 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -56,6 +56,8 @@
  */
 acpi_status acpi_ns_initialize_objects(void);
 
+acpi_status acpi_ns_early_initialize_devices(void);
+
 acpi_status acpi_ns_initialize_devices(u32 flags);
 
 acpi_status
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 3e6207ad18d8..f5364d44fdb8 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -86,6 +86,59 @@ acpi_status acpi_ns_initialize_objects(void)
 	return_ACPI_STATUS(AE_OK);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_early_initialize_devices
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      acpi_status
+ *
+ * DESCRIPTION: Call _INI on various root devices, this must be done
+ *              before any other evaluations as those might depend on this.
+ *
+ ******************************************************************************/
+static acpi_string const acpi_ns_early_init_paths[] = {
+	/* Global \_INI method. Provided for Windows compatibility (Vista+),
+	 * not part of the ACPI specification. */
+	ACPI_NS_ROOT_PATH,
+	/* There appears to be a strict order requirement for \_SB._INI,
+	 * which should be evaluated before any _REG evaluations. */
+	"\\_SB",
+};
+
+acpi_status acpi_ns_early_initialize_devices(void)
+{
+	struct acpi_evaluate_info *info;
+	acpi_status status;
+	acpi_handle handle;
+	int i;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "[Init] Initializing Early ACPI Devices\n"));
+
+	info = ACPI_ALLOCATE(sizeof(struct acpi_evaluate_info));
+	if (!info)
+		return AE_NO_MEMORY;
+
+	for (i = 0; i < ARRAY_SIZE(acpi_ns_early_init_paths); i++) {
+		status = acpi_get_handle(NULL, acpi_ns_early_init_paths[i], &handle);
+		if (!ACPI_SUCCESS(status))
+			continue;
+
+		memset(info, 0, sizeof(struct acpi_evaluate_info));
+		info->prefix_node = handle;
+		info->relative_pathname = METHOD_NAME__INI;
+		info->parameters = NULL;
+		info->flags = ACPI_IGNORE_RETURN_VALUE;
+
+		acpi_ns_evaluate(info);
+	}
+
+	ACPI_FREE(info);
+	return AE_OK;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_initialize_devices
@@ -105,12 +158,41 @@ acpi_status acpi_ns_initialize_objects(void)
 acpi_status acpi_ns_initialize_devices(u32 flags)
 {
 	acpi_status status = AE_OK;
-	struct acpi_device_walk_info info;
-	acpi_handle handle;
 
 	ACPI_FUNCTION_TRACE(ns_initialize_devices);
 
+	if (!(flags & (ACPI_NO_DEVICE_INIT | ACPI_NO_EARLY_DEVICE_INIT))) {
+		status = acpi_ns_early_initialize_devices();
+		if (ACPI_FAILURE(status))
+			goto error_exit;
+	}
+
+	/*
+	 * Run all _REG methods
+	 *
+	 * Note: Any objects accessed by the _REG methods will be automatically
+	 * initialized, even if they contain executable AML (see the call to
+	 * acpi_ns_initialize_objects below).
+	 *
+	 * Note: According to the ACPI specification, we actually needn't execute
+	 * _REG for system_memory/system_io operation regions, but for PCI_Config
+	 * operation regions, it is required to evaluate _REG for those on a PCI
+	 * root bus that doesn't contain _BBN object. So this code is kept here
+	 * in order not to break things.
+	 */
+	if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "[Init] Executing _REG OpRegion methods\n"));
+
+		status = acpi_ev_initialize_op_regions();
+		if (ACPI_FAILURE(status)) {
+			goto error_exit;
+		}
+	}
+
 	if (!(flags & ACPI_NO_DEVICE_INIT)) {
+		struct acpi_device_walk_info info;
+
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "[Init] Initializing ACPI Devices\n"));
 
@@ -143,68 +225,6 @@ acpi_status acpi_ns_initialize_devices(u32 flags)
 			goto error_exit;
 		}
 
-		/*
-		 * Execute the "global" _INI method that may appear at the root.
-		 * This support is provided for Windows compatibility (Vista+) and
-		 * is not part of the ACPI specification.
-		 */
-		info.evaluate_info->prefix_node = acpi_gbl_root_node;
-		info.evaluate_info->relative_pathname = METHOD_NAME__INI;
-		info.evaluate_info->parameters = NULL;
-		info.evaluate_info->flags = ACPI_IGNORE_RETURN_VALUE;
-
-		status = acpi_ns_evaluate(info.evaluate_info);
-		if (ACPI_SUCCESS(status)) {
-			info.num_INI++;
-		}
-
-		/*
-		 * Execute \_SB._INI.
-		 * There appears to be a strict order requirement for \_SB._INI,
-		 * which should be evaluated before any _REG evaluations.
-		 */
-		status = acpi_get_handle(NULL, "\\_SB", &handle);
-		if (ACPI_SUCCESS(status)) {
-			memset(info.evaluate_info, 0,
-			       sizeof(struct acpi_evaluate_info));
-			info.evaluate_info->prefix_node = handle;
-			info.evaluate_info->relative_pathname =
-			    METHOD_NAME__INI;
-			info.evaluate_info->parameters = NULL;
-			info.evaluate_info->flags = ACPI_IGNORE_RETURN_VALUE;
-
-			status = acpi_ns_evaluate(info.evaluate_info);
-			if (ACPI_SUCCESS(status)) {
-				info.num_INI++;
-			}
-		}
-	}
-
-	/*
-	 * Run all _REG methods
-	 *
-	 * Note: Any objects accessed by the _REG methods will be automatically
-	 * initialized, even if they contain executable AML (see the call to
-	 * acpi_ns_initialize_objects below).
-	 *
-	 * Note: According to the ACPI specification, we actually needn't execute
-	 * _REG for system_memory/system_io operation regions, but for PCI_Config
-	 * operation regions, it is required to evaluate _REG for those on a PCI
-	 * root bus that doesn't contain _BBN object. So this code is kept here
-	 * in order not to break things.
-	 */
-	if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "[Init] Executing _REG OpRegion methods\n"));
-
-		status = acpi_ev_initialize_op_regions();
-		if (ACPI_FAILURE(status)) {
-			goto error_exit;
-		}
-	}
-
-	if (!(flags & ACPI_NO_DEVICE_INIT)) {
-
 		/* Walk namespace to execute all _INIs on present devices */
 
 		status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
@@ -497,6 +517,21 @@ acpi_ns_find_ini_methods(acpi_handle obj_handle,
 	return (AE_OK);
 }
 
+static u8 acpi_ns_is_early_init_device(struct acpi_namespace_node *device_node)
+{
+	char path[ACPI_PATH_SEGMENT_LENGTH + 2];
+	int i;
+
+	acpi_ns_build_normalized_path(device_node, path, sizeof(path), TRUE);
+
+	for (i = 0; i < ARRAY_SIZE(acpi_ns_early_init_paths); i++) {
+		if (!strcmp(path, acpi_ns_early_init_paths[i]))
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_init_one_device
@@ -630,8 +665,7 @@ acpi_ns_init_one_device(acpi_handle obj_handle,
 	 * Note: We know there is an _INI within this subtree, but it may not be
 	 * under this particular device, it may be lower in the branch.
 	 */
-	if (!ACPI_COMPARE_NAMESEG(device_node->name.ascii, "_SB_") ||
-	    device_node->parent != acpi_gbl_root_node) {
+	if (!acpi_ns_is_early_init_device(device_node)) {
 		ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
 				(ACPI_TYPE_METHOD, device_node,
 				 METHOD_NAME__INI));
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index f2acec3a0ee3..4396ec7f1246 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -193,6 +193,27 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u32 flags)
 
 ACPI_EXPORT_SYMBOL_INIT(acpi_enable_subsystem)
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_early_initialize_objects
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Call _INI on various root objects, this must be done before
+ *              any other AML evaluations as those might depend on this.
+ *              This is automatically called by acpi_initialize_objects(),
+ *              unless ACPI_NO_EARLY_DEVICE_INIT is passed.
+ *
+ ******************************************************************************/
+acpi_status ACPI_INIT_FUNCTION acpi_early_initialize_objects(void)
+{
+	return acpi_ns_early_initialize_devices();
+}
+
+ACPI_EXPORT_SYMBOL_INIT(acpi_early_initialize_objects)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_initialize_objects
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 67c0b9e734b6..4b8d19f48071 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -410,6 +410,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
 			     acpi_initialize_subsystem(void))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
 			     acpi_enable_subsystem(u32 flags))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
+			     acpi_early_initialize_objects(void))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
 			     acpi_initialize_objects(u32 flags))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 3491e454b2ab..e377b7daec54 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -565,7 +565,8 @@ typedef u64 acpi_integer;
 #define ACPI_NO_HANDLER_INIT            0x0010
 #define ACPI_NO_OBJECT_INIT             0x0020
 #define ACPI_NO_DEVICE_INIT             0x0040
-#define ACPI_NO_ADDRESS_SPACE_INIT      0x0080
+#define ACPI_NO_EARLY_DEVICE_INIT       0x0080
+#define ACPI_NO_ADDRESS_SPACE_INIT      0x0100
 
 /*
  * Initialization state
-- 
2.36.0

