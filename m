Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814A032B444
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353010AbhCCE4h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:56:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448003AbhCBNyj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Mar 2021 08:54:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92F7C64F8F;
        Tue,  2 Mar 2021 11:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614686293;
        bh=avu/wHJwQk3SxYRJtAs0aM9ch/ucK/66o3cMo9Q8Gz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUsPVMDPhqwNqQcWW/oY8YnEo5YEU6UObfcyg2HFjTorcka5UCT+wm2rWnO5IgAYh
         imqbCCB7fc8DQ4RaaT6D56hQWR1oCKNE5lcf4Et/I9sOAORepa4KGdxVZ7aRpf93Ja
         JLib/9e0IJKzf+vLhP86vaVepDDbnxA57oxKtbwdUPjmbqH7hpu691knMvLUimGCY9
         uBerrz6AsW7nXgTmm2ZT76as1eTmGlRz7fRW94JrpWhIZMva2R5lvOpRe5Y+Hyr3us
         q9aZVDk+DSktKWZkQ0hvpY1bIYB2gcT/8fT8OnYAMzQ5QbqMNZYFAUL2wKuAuw7pLC
         AobySAUYDirGA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH AUTOSEL 5.4 18/33] ACPICA: Fix race in generic_serial_bus (I2C) and GPIO op_region parameter handling
Date:   Tue,  2 Mar 2021 06:57:34 -0500
Message-Id: <20210302115749.62653-18-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115749.62653-1-sashal@kernel.org>
References: <20210302115749.62653-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit c27f3d011b08540e68233cf56274fdc34bebb9b5 ]

ACPICA commit c9e0116952363b0fa815143dca7e9a2eb4fefa61

The handling of the generic_serial_bus (I2C) and GPIO op_regions in
acpi_ev_address_space_dispatch() passes a number of extra parameters
to the address-space handler through the address-space Context pointer
(instead of using more function parameters).

The Context is shared between threads, so if multiple threads try to
call the handler for the same address-space at the same time, then
a second thread could change the parameters of a first thread while
the handler is running for the first thread.

An example of this race hitting is the Lenovo Yoga Tablet2 1015L,
where there are both attrib_bytes accesses and attrib_byte accesses
to the same address-space. The attrib_bytes access stores the number
of bytes to transfer in Context->access_length. Where as for the
attrib_byte access the number of bytes to transfer is always 1 and
field_obj->Field.access_length is unused (so 0). Both types of
accesses racing from different threads leads to the following problem:

 1. Thread a. starts an attrib_bytes access, stores a non 0 value
    from field_obj->Field.access_length in Context->access_length

 2. Thread b. starts an attrib_byte access, stores 0 in
    Context->access_length

 3. Thread a. calls i2c_acpi_space_handler() (under Linux). Which
    sees that the access-type is ACPI_GSB_ACCESS_ATTRIB_MULTIBYTE
    and calls acpi_gsb_i2c_read_bytes(..., Context->access_length)

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
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/acobject.h  |  1 +
 drivers/acpi/acpica/evhandler.c |  7 ++++
 drivers/acpi/acpica/evregion.c  | 64 ++++++++++++++++++++++++---------
 drivers/acpi/acpica/evxfregn.c  |  2 ++
 4 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 8def0e3d690f..b0b9bb31c336 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -283,6 +283,7 @@ struct acpi_object_addr_handler {
 	acpi_adr_space_handler handler;
 	struct acpi_namespace_node *node;	/* Parent device */
 	void *context;
+	acpi_mutex context_mutex;
 	acpi_adr_space_setup setup;
 	union acpi_operand_object *region_list;	/* Regions using this handler */
 	union acpi_operand_object *next;
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 3ef4e27995f0..78550f5004c9 100644
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
index 45dc797df05d..50782033012b 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -111,6 +111,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	union acpi_operand_object *region_obj2;
 	void *region_context = NULL;
 	struct acpi_connection_info *context;
+	acpi_mutex context_mutex;
+	u8 context_locked;
 	acpi_physical_address address;
 
 	ACPI_FUNCTION_TRACE(ev_address_space_dispatch);
@@ -135,6 +137,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	}
 
 	context = handler_desc->address_space.context;
+	context_mutex = handler_desc->address_space.context_mutex;
+	context_locked = FALSE;
 
 	/*
 	 * It may be the case that the region has never been initialized.
@@ -203,6 +207,23 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
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
@@ -211,6 +232,11 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
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
@@ -220,6 +246,14 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
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
@@ -229,6 +263,14 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
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
@@ -238,28 +280,15 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
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
@@ -276,6 +305,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		}
 	}
 
+re_enter_interpreter:
 	if (!(handler_desc->address_space.handler_flags &
 	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
 		/*
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 47265b073e6f..6e0d2a98c4ad 100644
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
2.30.1

