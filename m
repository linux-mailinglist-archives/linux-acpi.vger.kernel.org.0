Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8966A68F20C
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 16:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjBHP3S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 10:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjBHP24 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 10:28:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4851146148;
        Wed,  8 Feb 2023 07:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675870133; x=1707406133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJJmVn2nGAN1e8bLKZaQHIlnJEwEonzHOFevWD1ROkA=;
  b=SoFN/qhNrI+ZmoiwNMhn2nFPU4XRgqJgzgOcMTh8Asd9R9ryyQ13Sn4m
   qYeXGr7IIFVLbiJt7qFaI6qWk3xsz4TbE3uGwv3NGIq+DARu/wayltc8b
   qhExsI9b/+4yUoXaXABxiCDMwk2q4JLqzaPSoH/WVjOau+z0sSaJ9CnaM
   xuf9VpnWm1hjz/5VVJa+0oXhrbqIwMREwe0X+EDnTbD8pDjtPTqBvxgKS
   KhAWN3GrZfxpivI116oXamPqIXYKy3caRsToqJvYu/BuHY50pTAz1yOU9
   oACxg+UePZduPMGcYPzzBZJDbrDdAL90lAF7M7/h3b06A3pvznnoaLXAQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310182300"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310182300"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="617237847"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="617237847"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:49 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 155DE12243E;
        Wed,  8 Feb 2023 17:28:42 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPmMr-00CrAS-I5; Wed, 08 Feb 2023 17:28:17 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v4 6/8] ACPI: property: Rename parsed MIPI DisCo for Imaging properties
Date:   Wed,  8 Feb 2023 17:28:05 +0200
Message-Id: <20230208152807.3064242-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
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
 drivers/acpi/property.c | 22 ++++++++++++----------
 3 files changed, 50 insertions(+), 10 deletions(-)

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
index 584c08c2b8989..a0d0d539ab1f0 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -725,3 +725,40 @@ void acpi_init_swnodes(struct acpi_device *device)
 	primary = acpi_fwnode_handle(device);
 	primary->secondary = software_node_fwnode(ads->nodes);
 }
+
+static const struct mipi_disco_prop {
+	const char *mipi_prop;
+	const char *dt_prop;
+} mipi_disco_props[] = {
+	{ "mipi-img-lens-focus",	"lens-focus" },
+	{ "mipi-img-flash-leds",	"flash-leds" },
+	{ "mipi-img-clock-frequency",	"clock-frequency" },
+	{ "mipi-img-led-max-current",	"led-max-microamp" },
+	{ "mipi-img-flash-max-current",	"flash-max-microamp" },
+	{ "mipi-img-flash-max-timeout",	"flash-max-timeout-us" },
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
index 4db7701aeaf5c..af9cb849a73ac 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -124,7 +124,7 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 }
 
 static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
-					const union acpi_object *link,
+					union acpi_object *link,
 					struct list_head *list,
 					struct fwnode_handle *parent)
 {
@@ -145,7 +145,7 @@ static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
 }
 
 static bool acpi_nondev_subnode_ok(acpi_handle scope,
-				   const union acpi_object *link,
+				   union acpi_object *link,
 				   struct list_head *list,
 				   struct fwnode_handle *parent)
 {
@@ -276,22 +276,24 @@ static bool acpi_property_value_ok(const union acpi_object *value)
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
-		if (property->package.count != 2
-		    || property->package.elements[0].type != ACPI_TYPE_STRING
-		    || !acpi_property_value_ok(&property->package.elements[1]))
+		if (property->package.count != 2 ||
+		    elements[0].type != ACPI_TYPE_STRING ||
+		    !acpi_property_value_ok(&elements[1]))
 			return false;
+
+		acpi_properties_prepare_mipi(elements);
 	}
 	return true;
 }
@@ -523,7 +525,7 @@ static bool acpi_extract_properties(acpi_handle scope, union acpi_object *desc,
 		 * We found the matching GUID. Now validate the format of the
 		 * package immediately following it.
 		 */
-		if (!acpi_properties_format_valid(properties))
+		if (!acpi_properties_prepare(properties))
 			continue;
 
 		acpi_data_add_props(data, (const guid_t *)guid->buffer.pointer,
-- 
2.30.2

