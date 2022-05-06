Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34451D85E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392211AbiEFNCW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392208AbiEFNCW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989363516
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841915; x=1683377915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BRsEBnKg3OuAt/OYFEsvgzGX9Vw6DHxSrTbSVZJyRF0=;
  b=jXNn4y9K3s8LqjQihPRemTNkz0V4+Kj6Rx3Kc7NokdklJ1mM5mcuFfGb
   2/1yDFnPLFYfSeQMxEDN+N0eStk6KULBvm5aRMvycEZGSaFa1aRtEWMnA
   HQMdc2j3Hp20Lx0+bVavWaCiTtuL9SQlODSj6T8nGk7b6g0HR9GnTnbcf
   RNF7Ih5n+kssq8GY/Hekk1O253fjCjNqFkWZxuEnDqwQ8AflkSJUm5QEy
   5vFwYZ/3oATSZxCxCkA3iJRr81qFKXkFI/AjJo6eromms9oO49giqgpNi
   mXXnFcO5v6dX41DL+QZ6MA0riTgrfUGCVy+5wZJPoMPFodQDdmy+BRGw/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268064810"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268064810"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="621813783"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:34 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 0058120F73;
        Fri,  6 May 2022 15:58:29 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480s-JY; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 10/11] ACPI: property: Add support for parsing buffer property UUID
Date:   Fri,  6 May 2022 16:00:24 +0300
Message-Id: <20220506130025.984026-11-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for newly added buffer property UUID, as defined in the DSD
guide.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 141 ++++++++++++++++++++++++++++++++++++----
 include/acpi/acpi_bus.h |   3 +-
 include/linux/acpi.h    |   2 +-
 3 files changed, 131 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 2205612fd6e98..d3f6d95e0fb19 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -55,14 +55,19 @@ static const guid_t ads_guid =
 	GUID_INIT(0xdbb8e3e6, 0x5886, 0x4ba6,
 		  0x87, 0x95, 0x13, 0x19, 0xf5, 0x2a, 0x96, 0x6b);
 
+static const guid_t buffer_prop_guid =
+	GUID_INIT(0xedb12dd0, 0x363d, 0x4085,
+		  0xa3, 0xd2, 0x49, 0x52, 0x2c, 0xa1, 0x60, 0xc4);
+
 static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
-					   const union acpi_object *desc,
+					   union acpi_object *desc,
 					   struct acpi_device_data *data,
 					   struct fwnode_handle *parent);
-static bool acpi_extract_properties(const union acpi_object *desc,
+static bool acpi_extract_properties(acpi_handle handle,
+				    union acpi_object *desc,
 				    struct acpi_device_data *data);
 
-static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
+static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 					acpi_handle handle,
 					const union acpi_object *link,
 					struct list_head *list,
@@ -81,7 +86,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
 	INIT_LIST_HEAD(&dn->data.properties);
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
-	result = acpi_extract_properties(desc, &dn->data);
+	result = acpi_extract_properties(handle, desc, &dn->data);
 
 	if (handle) {
 		acpi_handle scope;
@@ -156,7 +161,7 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
 }
 
 static bool acpi_add_nondev_subnodes(acpi_handle scope,
-				     const union acpi_object *links,
+				     union acpi_object *links,
 				     struct list_head *list,
 				     struct fwnode_handle *parent)
 {
@@ -164,7 +169,7 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 	int i;
 
 	for (i = 0; i < links->package.count; i++) {
-		const union acpi_object *link, *desc;
+		union acpi_object *link, *desc;
 		acpi_handle handle;
 		bool result;
 
@@ -204,7 +209,7 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 }
 
 static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
-					   const union acpi_object *desc,
+					   union acpi_object *desc,
 					   struct acpi_device_data *data,
 					   struct fwnode_handle *parent)
 {
@@ -212,7 +217,8 @@ static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
 
 	/* Look for the ACPI data subnodes GUID. */
 	for (i = 0; i < desc->package.count; i += 2) {
-		const union acpi_object *guid, *links;
+		const union acpi_object *guid;
+		union acpi_object *links;
 
 		guid = &desc->package.elements[i];
 		links = &desc->package.elements[i + 1];
@@ -325,7 +331,7 @@ static bool acpi_is_property_guid(const guid_t *guid)
 
 struct acpi_device_properties *
 acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
-		    const union acpi_object *properties)
+		    union acpi_object *properties)
 {
 	struct acpi_device_properties *props;
 
@@ -377,7 +383,103 @@ static int acpi_tie_nondev_subnodes(struct acpi_device_data *data)
 	return 0;
 }
 
-static bool acpi_extract_properties(const union acpi_object *desc,
+static void acpi_data_add_buffer_props(acpi_handle handle,
+				       struct acpi_device_data *data,
+				       union acpi_object *properties)
+{
+	struct acpi_device_properties *props;
+	union acpi_object *package;
+	size_t alloc_size;
+	unsigned int i;
+	u32 *count;
+
+	if (check_mul_overflow((size_t)properties->package.count,
+			       sizeof(*package) + sizeof(void *),
+			       &alloc_size) ||
+	    check_add_overflow(sizeof(*props) + sizeof(*package), alloc_size,
+			       &alloc_size)) {
+		acpi_handle_warn(handle,
+				 "can't allocate memory for %u buffer props",
+				 properties->package.count);
+		return;
+	}
+
+	props = kvzalloc(alloc_size, GFP_KERNEL);
+	if (!props)
+		return;
+
+	props->guid = &buffer_prop_guid;
+	props->bufs = (void *)(props + 1);
+	props->properties = (void *)(props->bufs + properties->package.count);
+
+	/* Outer package */
+	package = props->properties;
+	package->type = ACPI_TYPE_PACKAGE;
+	package->package.elements = package + 1;
+	count = &package->package.count;
+	*count = 0;
+
+	/* Inner packages */
+	package++;
+
+	for (i = 0; i < properties->package.count; i++) {
+		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
+		union acpi_object *property = &properties->package.elements[i];
+		union acpi_object *prop, *obj, *buf_obj;
+		acpi_status status;
+
+		if (property->type != ACPI_TYPE_PACKAGE ||
+		    property->package.count != 2) {
+			acpi_handle_warn(handle,
+					 "buffer property %u has %u entries\n",
+					 i, property->package.count);
+			continue;
+		}
+
+		prop = &property->package.elements[0];
+		obj = &property->package.elements[1];
+
+		if (prop->type != ACPI_TYPE_STRING ||
+		    obj->type != ACPI_TYPE_STRING) {
+			acpi_handle_warn(handle,
+					 "wrong object types %u and %u\n",
+					 prop->type, obj->type);
+			continue;
+		}
+
+		status = acpi_evaluate_object_typed(handle, obj->string.pointer,
+						    NULL, &buf,
+						    ACPI_TYPE_BUFFER);
+		if (ACPI_FAILURE(status)) {
+			acpi_handle_warn(handle,
+					 "can't evaluate \"%s\" as buffer\n",
+					 obj->string.pointer);
+			continue;
+		}
+
+		package->type = ACPI_TYPE_PACKAGE;
+		package->package.elements = prop;
+		package->package.count = 2;
+
+		buf_obj = buf.pointer;
+
+		/* Replace the string object with a buffer object */
+		obj->type = ACPI_TYPE_BUFFER;
+		obj->buffer.length = buf_obj->buffer.length;
+		obj->buffer.pointer = buf_obj->buffer.pointer;
+
+		props->bufs[i] = buf.pointer;
+		package++;
+		(*count)++;
+	}
+
+	if (*count)
+		list_add(&props->list, &data->properties);
+	else
+		kvfree(props);
+}
+
+static bool acpi_extract_properties(acpi_handle scope, union acpi_object *desc,
 				    struct acpi_device_data *data)
 {
 	int i;
@@ -387,7 +489,8 @@ static bool acpi_extract_properties(const union acpi_object *desc,
 
 	/* Look for the device properties GUID. */
 	for (i = 0; i < desc->package.count; i += 2) {
-		const union acpi_object *guid, *properties;
+		const union acpi_object *guid;
+		union acpi_object *properties;
 
 		guid = &desc->package.elements[i];
 		properties = &desc->package.elements[i + 1];
@@ -401,6 +504,12 @@ static bool acpi_extract_properties(const union acpi_object *desc,
 		    properties->type != ACPI_TYPE_PACKAGE)
 			break;
 
+		if (guid_equal((guid_t *)guid->buffer.pointer,
+			       &buffer_prop_guid)) {
+			acpi_data_add_buffer_props(scope, data, properties);
+			continue;
+		}
+
 		if (!acpi_is_property_guid((guid_t *)guid->buffer.pointer))
 			continue;
 
@@ -447,7 +556,7 @@ void acpi_init_properties(struct acpi_device *adev)
 	if (ACPI_FAILURE(status))
 		goto out;
 
-	if (acpi_extract_properties(buf.pointer, &adev->data)) {
+	if (acpi_extract_properties(adev->handle, buf.pointer, &adev->data)) {
 		adev->data.pointer = buf.pointer;
 		if (acpi_of)
 			acpi_init_of_compatible(adev);
@@ -477,8 +586,14 @@ static void acpi_free_device_properties(struct list_head *list)
 	struct acpi_device_properties *props, *tmp;
 
 	list_for_each_entry_safe(props, tmp, list, list) {
+		u32 i;
+
 		list_del(&props->list);
-		kfree(props);
+		/* Buffer data properties were separately allocated */
+		if (props->bufs)
+			for (i = 0; i < props->properties->package.count; i++)
+				ACPI_FREE(props->bufs[i]);
+		kvfree(props);
 	}
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b44aaffedb914..8df984013ee71 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -344,8 +344,9 @@ struct acpi_device_physical_node {
 
 struct acpi_device_properties {
 	const guid_t *guid;
-	const union acpi_object *properties;
+	union acpi_object *properties;
 	struct list_head list;
+	void **bufs;
 };
 
 /* ACPI Device Specific Data (_DSD) */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d7136d13aa442..a411bae44b7e2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1204,7 +1204,7 @@ static inline bool acpi_dev_has_props(const struct acpi_device *adev)
 
 struct acpi_device_properties *
 acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
-		    const union acpi_object *properties);
+		    union acpi_object *properties);
 
 int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
 		       void **valptr);
-- 
2.30.2

