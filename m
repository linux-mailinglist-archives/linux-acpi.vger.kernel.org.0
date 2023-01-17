Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8090766DD6B
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 13:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjAQMWY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 07:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjAQMWV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 07:22:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612002BF1D;
        Tue, 17 Jan 2023 04:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673958140; x=1705494140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hG18mLyYc1176oRVzTIz/UPqRlbH7NKsdxCEPctBXyk=;
  b=SVg7tyerQRlFwSsIqFfBeBm9ta0sDehrB/xihHInEd0YymvYHxrve4Ub
   Q+V+l0IO0sy8By+NLq8dqzDAUFv+BCuksyfGeu2I+BuMt6PxD124SSzWr
   YYRzQAOTbtqbYYs45/Hu0NndLLffcr0R7Hcg13M4quonK9ond4b2sle7L
   3YPIDshXrfhnHhknaNdlNvY34ER7TXy815Fzyf1mhRYNjcNKKGFWJApZr
   977lE8+ZfjbYJ+ZqWM1+KFsMuNurL5Ffozb4MydRc9iRAvSWXHQjX4g9g
   60zzzusor4zLdNFgkYqpnKSAGaltF2/M5ha2zdiTN+H33bgACvngif8WY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410920120"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="410920120"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="727772042"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="727772042"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:17 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 11267209C7;
        Tue, 17 Jan 2023 14:22:12 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pHkzE-00AgVM-RQ; Tue, 17 Jan 2023 14:22:44 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH 6/8] ACPI: property: Rename parsed MIPI DisCo for Imaging properties
Date:   Tue, 17 Jan 2023 14:22:42 +0200
Message-Id: <20230117122244.2546597-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

MIPI DisCo for Imaging defines properties for sensor-adjacent devices such
as EEPROM, LED flash or lens VCM as either device or sub-node references.
This is compliant with existing DT definitions apart from property names.

Rename parsed MIPI-defined properties so drivers will have a unified view
of them as defined in DT and already parsed by drivers. This can be done
in-place as the MIPI-defined property strings are always longer than the
DT one. This also results in loss of constness in parser function
arguments.

Individual bindings to devices could define the references differently
between MIPI DisCo for Imaging and DT, in terms of device or sub-node
references. This will still need to be handled in the drivers themselves.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/internal.h |  1 +
 drivers/acpi/mipi.c     | 37 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/property.c | 20 +++++++++++---------
 3 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index fac87404e294c..f107094bfe16f 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -289,5 +289,6 @@ static inline void acpi_init_lpit(void) { }
 void acpi_crs_csi2_swnodes_del_free(void);
 void acpi_bus_scan_crs_csi2(acpi_handle handle);
 void acpi_init_swnodes(struct acpi_device *device);
+void acpi_properties_prepare_mipi(union acpi_object *elements);
 
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index bd09eac0a52e4..2174e03a2eafd 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -687,3 +687,40 @@ void acpi_init_swnodes(struct acpi_device *device)
 
 	device->fwnode.secondary = software_node_fwnode(ads->nodes);
 }
+
+static const struct mipi_disco_prop {
+	const char *mipi_prop;
+	const char *dt_prop;
+} mipi_disco_props[] = {
+	{ "mipi-img-lens-focus", "lens-focus" },
+	{ "mipi-img-flash-leds", "flash-leds" },
+	{ "mipi-img-clock-frequency", "clock-frequency" },
+	{ "mipi-img-led-max-current", "led-max-microamp" },
+	{ "mipi-img-flash-max-current", "flash-max-microamp" },
+	{ "mipi-img-flash-max-timeout", "flash-max-timeout-us" },
+};
+
+/**
+ * acpi_properties_prepare_mipi - Rename MIPI properties as commin DT ones
+ *
+ * @elements: ACPI object containing _DSD properties for a device node
+ *
+ * Renames MIPI-defined properties as common DT ones. The pre-requisite is that
+ * the names of all such MIPI properties are no longer than the corresponding DT
+ * ones.
+ */
+void acpi_properties_prepare_mipi(union acpi_object *elements)
+{
+	unsigned int i;
+
+	/* Replace MIPI DisCo for Imaging property names with DT equivalents. */
+	for (i = 0; i < ARRAY_SIZE(mipi_disco_props); i++) {
+		if (!strcmp(mipi_disco_props[i].mipi_prop,
+			    elements[0].string.pointer)) {
+			WARN_ON(strscpy(elements[0].string.pointer,
+					mipi_disco_props[i].dt_prop,
+					elements[0].string.length) < 0);
+			break;
+		}
+	}
+}
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 545f74673703d..92fdc2adcac3d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -121,7 +121,7 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 }
 
 static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
-					const union acpi_object *link,
+					union acpi_object *link,
 					struct list_head *list,
 					struct fwnode_handle *parent)
 {
@@ -142,7 +142,7 @@ static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
 }
 
 static bool acpi_nondev_subnode_ok(acpi_handle scope,
-				   const union acpi_object *link,
+				   union acpi_object *link,
 				   struct list_head *list,
 				   struct fwnode_handle *parent)
 {
@@ -273,22 +273,24 @@ static bool acpi_property_value_ok(const union acpi_object *value)
 	return false;
 }
 
-static bool acpi_properties_format_valid(const union acpi_object *properties)
+static bool acpi_properties_prepare(union acpi_object *properties)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < properties->package.count; i++) {
-		const union acpi_object *property;
+		union acpi_object *property = &properties->package.elements[i];
+		union acpi_object *elements = property->package.elements;
 
-		property = &properties->package.elements[i];
 		/*
 		 * Only two elements allowed, the first one must be a string and
 		 * the second one has to satisfy certain conditions.
 		 */
 		if (property->package.count != 2
-		    || property->package.elements[0].type != ACPI_TYPE_STRING
-		    || !acpi_property_value_ok(&property->package.elements[1]))
+		    || elements[0].type != ACPI_TYPE_STRING
+		    || !acpi_property_value_ok(&elements[1]))
 			return false;
+
+		acpi_properties_prepare_mipi(elements);
 	}
 	return true;
 }
@@ -520,7 +522,7 @@ static bool acpi_extract_properties(acpi_handle scope, union acpi_object *desc,
 		 * We found the matching GUID. Now validate the format of the
 		 * package immediately following it.
 		 */
-		if (!acpi_properties_format_valid(properties))
+		if (!acpi_properties_prepare(properties))
 			continue;
 
 		acpi_data_add_props(data, (const guid_t *)guid->buffer.pointer,
-- 
2.30.2

