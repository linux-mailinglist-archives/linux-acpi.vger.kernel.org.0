Return-Path: <linux-acpi+bounces-803-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E051C7D1410
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE00282569
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A261EA66
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43419BAC
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 14:49:55 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E539D5E;
	Fri, 20 Oct 2023 07:49:53 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id c1f2dbc25c6b1047; Fri, 20 Oct 2023 16:49:52 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9CC00667008;
	Fri, 20 Oct 2023 16:49:51 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] ACPI: property: Support using strings in reference properties
Date: Fri, 20 Oct 2023 16:35:40 +0200
Message-ID: <2932408.e9J7NaK4W3@kreacher>
In-Reply-To: <2187487.irdbgypaU6@kreacher>
References: <2187487.irdbgypaU6@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to allow referencing data nodes directly, which is not possible
currently, add support for representing references in device properties
as strings (relative or absolute name paths).  For example, after this
change, the "mipi-img-flash-leds" property in the ASL snippet below will
be treated as a proper reference to the LED0 object under LEDD.

 Package ()
 {
     "mipi-img-flash-leds",  "\\_SB.PCI0.I2C2.LEDD.LED0",
 }

 Device (LEDD)
 {
     Name (_DSD, Package ()  // _DSD: Device-Specific Data
     {
         ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b"), /* Hierarchical Data Extension */,
         Package ()
         {
             Package ()
             {
                 "mipi-img-flash-led-0", 
                 "LED0",
             }
         },
     })
     Name (LED0, Package ()  // _DSD: Device-Specific Data
     {
         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties */,
         Package ()
         {
             Package ()
             {
                 "mipi-img-max-current", 
                 1000000,
             }
         }
     })
 }

Also remove the mechanism allowing data nodes to be referenced
indirectly, with the help of an object reference pointing to the
"ancestor" device and a path relative to it (this mechanism is not
expected to be in use in any production platform firmware in the field).

Note that this change allows also using strings for referencing device
objects, in addition to object references that have been supported
already.

While at it, add pr_fmt() macro to prefix printouts and update
copyright.

Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/property.c |  102 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 82 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -2,14 +2,17 @@
 /*
  * ACPI device specific properties support.
  *
- * Copyright (C) 2014, Intel Corporation
+ * Copyright (C) 2014 - 2023, Intel Corporation
  * All rights reserved.
  *
  * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
  *          Darren Hart <dvhart@linux.intel.com>
  *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *          Sakari Ailus <sakari.ailus@linux.intel.com>
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/export.h>
@@ -801,27 +804,15 @@ static int acpi_get_ref_args(struct fwno
 	u32 nargs = 0, i;
 
 	/*
-	 * Find the referred data extension node under the
-	 * referred device node.
-	 */
-	for (; *element < end && (*element)->type == ACPI_TYPE_STRING;
-	     (*element)++) {
-		const char *child_name = (*element)->string.pointer;
-
-		ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode, child_name);
-		if (!ref_fwnode)
-			return -EINVAL;
-	}
-
-	/*
 	 * Assume the following integer elements are all args. Stop counting on
-	 * the first reference or end of the package arguments. In case of
-	 * neither reference, nor integer, return an error, we can't parse it.
+	 * the first reference (possibly represented as a string) or end of the
+	 * package arguments. In case of neither reference, nor integer, return
+	 * an error, we can't parse it.
 	 */
 	for (i = 0; (*element) + i < end && i < num_args; i++) {
 		acpi_object_type type = (*element)[i].type;
 
-		if (type == ACPI_TYPE_LOCAL_REFERENCE)
+		if (type == ACPI_TYPE_LOCAL_REFERENCE || type == ACPI_TYPE_STRING)
 			break;
 
 		if (type == ACPI_TYPE_INTEGER)
@@ -845,6 +836,44 @@ static int acpi_get_ref_args(struct fwno
 	return 0;
 }
 
+static struct fwnode_handle *acpi_parse_string_ref(const struct fwnode_handle *fwnode,
+						   const char *refstring)
+{
+	acpi_handle scope, handle;
+	struct acpi_data_node *dn;
+	struct acpi_device *device;
+	acpi_status status;
+
+	if (is_acpi_device_node(fwnode)) {
+		scope = to_acpi_device_node(fwnode)->handle;
+	} else if (is_acpi_data_node(fwnode)) {
+		scope = to_acpi_data_node(fwnode)->handle;
+	} else {
+		pr_debug("Bad node type for node %pfw\n", fwnode);
+		return NULL;
+	}
+
+	status = acpi_get_handle(scope, refstring, &handle);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(scope, "Unable to get an ACPI handle for %s\n",
+				  refstring);
+		return NULL;
+	}
+
+	device = acpi_fetch_acpi_dev(handle);
+	if (device)
+		return acpi_fwnode_handle(device);
+
+	status = acpi_get_data_full(handle, acpi_nondev_subnode_tag,
+				    (void **)&dn, NULL);
+	if (ACPI_FAILURE(status) || !dn) {
+		acpi_handle_debug(handle, "Subnode not found\n");
+		return NULL;
+	}
+
+	return &dn->fwnode;
+}
+
 /**
  * __acpi_node_get_property_reference - returns handle to the referenced object
  * @fwnode: Firmware node to get the property from
@@ -887,6 +916,7 @@ int __acpi_node_get_property_reference(c
 	const union acpi_object *element, *end;
 	const union acpi_object *obj;
 	const struct acpi_device_data *data;
+	struct fwnode_handle *ref_fwnode;
 	struct acpi_device *device;
 	int ret, idx = 0;
 
@@ -910,16 +940,30 @@ int __acpi_node_get_property_reference(c
 
 		args->fwnode = acpi_fwnode_handle(device);
 		args->nargs = 0;
+
+		return 0;
+	case ACPI_TYPE_STRING:
+		if (index)
+			return -ENOENT;
+
+		ref_fwnode = acpi_parse_string_ref(fwnode, obj->string.pointer);
+		if (!ref_fwnode)
+			return -EINVAL;
+
+		args->fwnode = ref_fwnode;
+		args->nargs = 0;
+
 		return 0;
 	case ACPI_TYPE_PACKAGE:
 		/*
 		 * If it is not a single reference, then it is a package of
-		 * references followed by number of ints as follows:
+		 * references, followed by number of ints as follows:
 		 *
 		 *  Package () { REF, INT, REF, INT, INT }
 		 *
-		 * The index argument is then used to determine which reference
-		 * the caller wants (along with the arguments).
+		 * Here, REF may be either a local reference or a string. The
+		 * index argument is then used to determine which reference the
+		 * caller wants (along with the arguments).
 		 */
 		break;
 	default:
@@ -947,6 +991,24 @@ int __acpi_node_get_property_reference(c
 			if (ret < 0)
 				return ret;
 
+			if (idx == index)
+				return 0;
+
+			break;
+		case ACPI_TYPE_STRING:
+			ref_fwnode = acpi_parse_string_ref(fwnode,
+							   element->string.pointer);
+			if (!ref_fwnode)
+				return -EINVAL;
+
+			element++;
+
+			ret = acpi_get_ref_args(idx == index ? args : NULL,
+						ref_fwnode, &element, end,
+						num_args);
+			if (ret < 0)
+				return ret;
+
 			if (idx == index)
 				return 0;
 




