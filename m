Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCA06CD767
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjC2KKT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 06:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjC2KKL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 06:10:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B48468E;
        Wed, 29 Mar 2023 03:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680084605; x=1711620605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GHy945d5K+XuXB2osjg/kL6H844bbEPqoNXKHXpzLKs=;
  b=lAkTuF7IsRlbB3nDShs8/vuEfB9ZAPiepwFfC3O6PCyaWnafxf3xQdtJ
   PcNCB5UXe5cCdPs62+fz1rVKLWyl/euPWZp6MkiuR8JTKUq5L1QKcAIAl
   j+GR04LuYTN25t2rkncBUPQ7A3NSYlm27MDg8LfmkhT+B414ED+UpGG1K
   bhguYSZ7bNB7+KYmhZ5rtz6MEzfcBXtfO0UBW4SnnggizdVL4EmyHNgxa
   MC4PfylhTnVjcax2VtZZLhc+EBZj7ru382J/OvC3yBLNMLy1/+iQTqELB
   MD1xFtZ8M+COtLz4H1DM4kzzwAYWuj2/ID1k/UdorAbiFFUyf2z6J6gLU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343256254"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343256254"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 03:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773517738"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="773517738"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 03:10:03 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 088D6122636;
        Wed, 29 Mar 2023 13:09:59 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v8 08/10] ACPI: property: Rename parsed MIPI DisCo for Imaging properties
Date:   Wed, 29 Mar 2023 13:09:49 +0300
Message-Id: <20230329100951.1522322-9-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/acpi/mipi.c     | 36 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/property.c | 22 ++++++++++++----------
 3 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 36799cde281c..ef5af9fd9ffa 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -318,5 +318,6 @@ void acpi_bus_scan_check_crs_csi2(acpi_handle handle, struct acpi_scan_context *
 void acpi_bus_scan_crs_csi2_release(struct list_head *crs_csi2_handles);
 void acpi_bus_scan_crs_csi2(struct acpi_scan_context_csi2 *ctx);
 void acpi_init_swnodes(struct acpi_device *device);
+void acpi_properties_prepare_mipi(union acpi_object *elements);
 
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index 0232cc123ead..576301b9bb89 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -714,3 +714,39 @@ void acpi_init_swnodes(struct acpi_device *device)
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
+	char *e0 = elements[0].string.pointer;
+	unsigned int i;
+
+	/* Replace MIPI DisCo for Imaging property names with DT equivalents. */
+	for (i = 0; i < ARRAY_SIZE(mipi_disco_props); i++) {
+		if (!strcmp(mipi_disco_props[i].mipi_prop, e0)) {
+			WARN_ON(strscpy(e0, mipi_disco_props[i].dt_prop,
+					elements[0].string.length) < 0);
+			break;
+		}
+	}
+}
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 1892787e73a6..541bda2c118f 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -127,7 +127,7 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 }
 
 static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
-					const union acpi_object *link,
+					union acpi_object *link,
 					struct list_head *list,
 					struct fwnode_handle *parent)
 {
@@ -148,7 +148,7 @@ static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
 }
 
 static bool acpi_nondev_subnode_ok(acpi_handle scope,
-				   const union acpi_object *link,
+				   union acpi_object *link,
 				   struct list_head *list,
 				   struct fwnode_handle *parent)
 {
@@ -292,22 +292,24 @@ static bool acpi_property_value_ok(const union acpi_object *value)
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
@@ -539,7 +541,7 @@ static bool acpi_extract_properties(acpi_handle scope, union acpi_object *desc,
 		 * We found the matching GUID. Now validate the format of the
 		 * package immediately following it.
 		 */
-		if (!acpi_properties_format_valid(properties))
+		if (!acpi_properties_prepare(properties))
 			continue;
 
 		acpi_data_add_props(data, (const guid_t *)guid->buffer.pointer,
-- 
2.30.2

