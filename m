Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7932FD904
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 20:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392316AbhATTDX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 14:03:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50644 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392408AbhATTDV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2021 14:03:21 -0500
Received: from 89-64-80-175.dynamic.chello.pl (89.64.80.175) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 9a478b5d78da3b74; Wed, 20 Jan 2021 20:02:11 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v1 5/6] ACPI: utils: Clean up printing messages
Date:   Wed, 20 Jan 2021 20:00:32 +0100
Message-ID: <4589427.MynsCsldvn@kreacher>
In-Reply-To: <2809410.8bz27usjlQ@kreacher>
References: <2809410.8bz27usjlQ@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace all of the ACPI_DEBUG_PRINT() instances in utils.c with
pr_debug() and acpi_handle_debug(), drop the _COMPONENT and
ACPI_MODULE_NAME() definitions that are not used any more and
replace direct printk() invocations with pr_debug() calls (the log
level in there is way excessive).

Also add a special pr_fmt() definition, but this only affects the
pr_debug() messages mentioned above.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/utils.c |   56 ++++++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

Index: linux-pm/drivers/acpi/utils.c
===================================================================
--- linux-pm.orig/drivers/acpi/utils.c
+++ linux-pm/drivers/acpi/utils.c
@@ -6,6 +6,8 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  */
 
+#define pr_fmt(fmt) "ACPI: utils: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -18,24 +20,12 @@
 #include "internal.h"
 #include "sleep.h"
 
-#define _COMPONENT		ACPI_BUS_COMPONENT
-ACPI_MODULE_NAME("utils");
-
 /* --------------------------------------------------------------------------
                             Object Evaluation Helpers
    -------------------------------------------------------------------------- */
-static void
-acpi_util_eval_error(acpi_handle h, acpi_string p, acpi_status s)
+static void acpi_util_eval_error(acpi_handle h, acpi_string p, acpi_status s)
 {
-#ifdef ACPI_DEBUG_OUTPUT
-	char prefix[80] = {'\0'};
-	struct acpi_buffer buffer = {sizeof(prefix), prefix};
-	acpi_get_name(h, ACPI_FULL_PATHNAME, &buffer);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluate [%s.%s]: %s\n",
-		(char *) prefix, p, acpi_format_exception(s)));
-#else
-	return;
-#endif
+	acpi_handle_debug(h, "Evaluate [%s]: %s\n", p, acpi_format_exception(s));
 }
 
 acpi_status
@@ -53,25 +43,24 @@ acpi_extract_package(union acpi_object *
 
 	if (!package || (package->type != ACPI_TYPE_PACKAGE)
 	    || (package->package.count < 1)) {
-		printk(KERN_WARNING PREFIX "Invalid package argument\n");
+		pr_debug("Invalid package argument\n");
 		return AE_BAD_PARAMETER;
 	}
 
 	if (!format || !format->pointer || (format->length < 1)) {
-		printk(KERN_WARNING PREFIX "Invalid format argument\n");
+		pr_debug("Invalid format argument\n");
 		return AE_BAD_PARAMETER;
 	}
 
 	if (!buffer) {
-		printk(KERN_WARNING PREFIX "Invalid buffer argument\n");
+		pr_debug("Invalid buffer argument\n");
 		return AE_BAD_PARAMETER;
 	}
 
 	format_count = (format->length / sizeof(char)) - 1;
 	if (format_count > package->package.count) {
-		printk(KERN_WARNING PREFIX "Format specifies more objects [%d]"
-			      " than exist in package [%d].\n",
-			      format_count, package->package.count);
+		pr_debug("Format specifies more objects [%d] than present [%d]\n",
+			 format_count, package->package.count);
 		return AE_BAD_DATA;
 	}
 
@@ -99,10 +88,8 @@ acpi_extract_package(union acpi_object *
 				tail_offset += sizeof(char *);
 				break;
 			default:
-				printk(KERN_WARNING PREFIX "Invalid package element"
-					      " [%d]: got number, expecting"
-					      " [%c]\n",
-					      i, format_string[i]);
+				pr_debug("Invalid package element [%d]: got number, expected [%c]\n",
+					 i, format_string[i]);
 				return AE_BAD_DATA;
 			}
 			break;
@@ -123,10 +110,8 @@ acpi_extract_package(union acpi_object *
 				tail_offset += sizeof(u8 *);
 				break;
 			default:
-				printk(KERN_WARNING PREFIX "Invalid package element"
-					      " [%d] got string/buffer,"
-					      " expecting [%c]\n",
-					      i, format_string[i]);
+				pr_debug("Invalid package element [%d] got string/buffer, expected [%c]\n",
+					 i, format_string[i]);
 				return AE_BAD_DATA;
 			}
 			break;
@@ -137,19 +122,15 @@ acpi_extract_package(union acpi_object *
 				tail_offset += sizeof(void *);
 				break;
 			default:
-				printk(KERN_WARNING PREFIX "Invalid package element"
-					      " [%d] got reference,"
-					      " expecting [%c]\n",
-					      i, format_string[i]);
+				pr_debug("Invalid package element [%d] got reference, expected [%c]\n",
+					 i, format_string[i]);
 				return AE_BAD_DATA;
 			}
 			break;
 
 		case ACPI_TYPE_PACKAGE:
 		default:
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Found unsupported element at index=%d\n",
-					  i));
+			pr_debug("Unsupported element at index=%d\n", i);
 			/* TBD: handle nested packages... */
 			return AE_SUPPORT;
 		}
@@ -289,7 +270,7 @@ acpi_evaluate_integer(acpi_handle handle
 
 	*data = element.integer.value;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Return value [%llu]\n", *data));
+	acpi_handle_debug(handle, "Return value [%llu]\n", *data);
 
 	return AE_OK;
 }
@@ -363,8 +344,7 @@ acpi_evaluate_reference(acpi_handle hand
 		/* Get the  acpi_handle. */
 
 		list->handles[i] = element->reference.handle;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found reference [%p]\n",
-				  list->handles[i]));
+		acpi_handle_debug(list->handles[i], "Found in reference list\n");
 	}
 
       end:



