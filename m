Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EEC31F32F
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Feb 2021 00:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBRXua (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Feb 2021 18:50:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:26831 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhBRXu3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Feb 2021 18:50:29 -0500
IronPort-SDR: VegpvOAE1S9LNahvSEGcJepxoW4r/0lrhCnNlHXDv4IFUvE99S8aLxmAW4K7EyYwdStXVpd6pd
 vRTxTgSE5KUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="163462478"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="163462478"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 15:49:48 -0800
IronPort-SDR: /RzbygKF5V8uxQ0AvjlLLQdXSE0mEBVxqN2+aLE8QoTrz76HOD25uYjdc45o+bpDazDABXvkMt
 1GBpSZz1bkpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="367723353"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga007.fm.intel.com with ESMTP; 18 Feb 2021 15:49:47 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 1/2] ACPICA: Fix race in generic_serial_bus (I2C) and GPIO op_region parameter handling
Date:   Thu, 18 Feb 2021 15:17:07 -0800
Message-Id: <20210218231708.1143640-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210218231708.1143640-1-erik.kaneda@intel.com>
References: <20210218231708.1143640-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

ACPICA commit c9e0116952363b0fa815143dca7e9a2eb4fefa61

The handling of the generic_serial_bus (I2C) and GPIO op_regions in
acpi_ev_address_space_dispatch() passes a number of extra parameters to
the address-space handler through the address-space Context pointer
(instead of using more function parameters).

The Context is shared between threads, so if multiple threads try to call
the handler for the same address-space at the same time, then
a second thread could change the parameters of a first thread while the
handler is running for the first thread.

An example of this race hitting is the Lenovo Yoga Tablet2 1015L, where
there are both attrib_bytes accesses and attrib_byte accesses to the same
address-space. The attrib_bytes access stores the number of bytes to
transfer in Context->access_length. Where as for the attrib_byte access the
number of bytes to transfer is always 1 and field_obj->Field.access_length
is unused (so 0). Both types of accesses racing from different threads
leads to the following problem:

1. Thread a. starts an attrib_bytes access, stores a non 0 value
from field_obj->Field.access_length in Context->access_length
2. Thread b. starts an attrib_byte access, stores 0 in
Context->access_length
3. Thread a. calls i2c_acpi_space_handler() (under Linux). Which
sees that the access-type is ACPI_GSB_ACCESS_ATTRIB_MULTIBYTE and
calls acpi_gsb_i2c_read_bytes(..., Context->access_length)
4. At this point Context->access_length is 0 (set by thread b.)
rather then the field_obj->Field.access_length value from thread a.
This 0 length reads leads to the following errors being logged:

 i2c i2c-0: adapter quirk: no zero length (addr 0x0078, size 0, read)
 i2c i2c-0: i2c read 0 bytes from client@0x78 starting at reg 0x0 failed, error: -95

Note this is just an example of the problems which this race can cause.
There are likely many more (sporadic) problems caused by this race.

This commit adds a new context_mutex to struct acpi_object_addr_handler
and makes acpi_ev_address_space_dispatch() take that mutex when
using the shared Context to pass extra parameters to an address-space
handler, fixing this race.

Note the new mutex must be taken *after* exiting the interpreter,
therefor the existing acpi_ex_exit_interpreter() call is moved to above
the code which stores the extra parameters in the Context.

Link: https://github.com/acpica/acpica/commit/c9e01169
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/acobject.h  |  1 +
 drivers/acpi/acpica/evhandler.c |  7 ++++
 drivers/acpi/acpica/evregion.c  | 64 ++++++++++++++++++++++++---------
 drivers/acpi/acpica/evxfregn.c  |  2 ++
 4 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index af47a3ffd2a4..9db5ae0f79ea 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -284,6 +284,7 @@ struct acpi_object_addr_handler {
 	acpi_adr_space_handler handler;
 	struct acpi_namespace_node *node;	/* Parent device */
 	void *context;
+	acpi_mutex context_mutex;
 	acpi_adr_space_setup setup;
 	union acpi_operand_object *region_list;	/* Regions using this handler */
 	union acpi_operand_object *next;
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index ea9485e6a475..c0cd7147a5a3 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -489,6 +489,13 @@ acpi_ev_install_space_handler(struct acpi_namespace_node *node,
 
 	/* Init handler obj */
 
+	status =
+	    acpi_os_create_mutex(&handler_obj->address_space.context_mutex);
+	if (ACPI_FAILURE(status)) {
+		acpi_ut_remove_reference(handler_obj);
+		goto unlock_and_exit;
+	}
+
 	handler_obj->address_space.space_id = (u8)space_id;
 	handler_obj->address_space.handler_flags = flags;
 	handler_obj->address_space.region_list = NULL;
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 3ed7d9ae95cf..2a3c13e97555 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -112,6 +112,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	union acpi_operand_object *region_obj2;
 	void *region_context = NULL;
 	struct acpi_connection_info *context;
+	acpi_mutex context_mutex;
+	u8 context_locked;
 	acpi_physical_address address;
 
 	ACPI_FUNCTION_TRACE(ev_address_space_dispatch);
@@ -136,6 +138,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	}
 
 	context = handler_desc->address_space.context;
+	context_mutex = handler_desc->address_space.context_mutex;
+	context_locked = FALSE;
 
 	/*
 	 * It may be the case that the region has never been initialized.
@@ -204,6 +208,23 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	handler = handler_desc->address_space.handler;
 	address = (region_obj->region.address + region_offset);
 
+	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
+			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
+			  &region_obj->region.handler->address_space, handler,
+			  ACPI_FORMAT_UINT64(address),
+			  acpi_ut_get_region_name(region_obj->region.
+						  space_id)));
+
+	if (!(handler_desc->address_space.handler_flags &
+	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
+		/*
+		 * For handlers other than the default (supplied) handlers, we must
+		 * exit the interpreter because the handler *might* block -- we don't
+		 * know what it will do, so we can't hold the lock on the interpreter.
+		 */
+		acpi_ex_exit_interpreter();
+	}
+
 	/*
 	 * Special handling for generic_serial_bus and general_purpose_io:
 	 * There are three extra parameters that must be passed to the
@@ -212,6 +233,11 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	 *   2) Length of the above buffer
 	 *   3) Actual access length from the access_as() op
 	 *
+	 * Since we pass these extra parameters via the context, which is
+	 * shared between threads, we must lock the context to avoid these
+	 * parameters being changed from another thread before the handler
+	 * has completed running.
+	 *
 	 * In addition, for general_purpose_io, the Address and bit_width fields
 	 * are defined as follows:
 	 *   1) Address is the pin number index of the field (bit offset from
@@ -221,6 +247,14 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GSBUS) &&
 	    context && field_obj) {
 
+		status =
+		    acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
+		if (ACPI_FAILURE(status)) {
+			goto re_enter_interpreter;
+		}
+
+		context_locked = TRUE;
+
 		/* Get the Connection (resource_template) buffer */
 
 		context->connection = field_obj->field.resource_buffer;
@@ -230,6 +264,14 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GPIO) &&
 	    context && field_obj) {
 
+		status =
+		    acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
+		if (ACPI_FAILURE(status)) {
+			goto re_enter_interpreter;
+		}
+
+		context_locked = TRUE;
+
 		/* Get the Connection (resource_template) buffer */
 
 		context->connection = field_obj->field.resource_buffer;
@@ -239,28 +281,15 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		bit_width = field_obj->field.bit_length;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
-			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
-			  &region_obj->region.handler->address_space, handler,
-			  ACPI_FORMAT_UINT64(address),
-			  acpi_ut_get_region_name(region_obj->region.
-						  space_id)));
-
-	if (!(handler_desc->address_space.handler_flags &
-	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
-		/*
-		 * For handlers other than the default (supplied) handlers, we must
-		 * exit the interpreter because the handler *might* block -- we don't
-		 * know what it will do, so we can't hold the lock on the interpreter.
-		 */
-		acpi_ex_exit_interpreter();
-	}
-
 	/* Call the handler */
 
 	status = handler(function, address, bit_width, value, context,
 			 region_obj2->extra.region_context);
 
+	if (context_locked) {
+		acpi_os_release_mutex(context_mutex);
+	}
+
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Returned by Handler for [%s]",
 				acpi_ut_get_region_name(region_obj->region.
@@ -277,6 +306,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		}
 	}
 
+re_enter_interpreter:
 	if (!(handler_desc->address_space.handler_flags &
 	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
 		/*
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 7672d70da850..b1ff0a8f9c14 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -201,6 +201,8 @@ acpi_remove_address_space_handler(acpi_handle device,
 
 			/* Now we can delete the handler object */
 
+			acpi_os_release_mutex(handler_obj->address_space.
+					      context_mutex);
 			acpi_ut_remove_reference(handler_obj);
 			goto unlock_and_exit;
 		}
-- 
2.29.2

