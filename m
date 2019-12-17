Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6009812360B
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 20:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfLQTzC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 14:55:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:56006 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbfLQTzC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 14:55:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 11:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="217624420"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2019 11:54:59 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 4/5] ACPICA: Dispatcher: always generate buffer objects for ASL create_field() operator
Date:   Tue, 17 Dec 2019 11:35:22 -0800
Message-Id: <20191217193523.20204-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217193523.20204-1-erik.kaneda@intel.com>
References: <20191217193523.20204-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Maximilian Luz <luzmaximilian@gmail.com>

ACPICA commit 79a466b64e6af36cc83102f05915e56cb7dd89ab

According to table 19-419 of the ACPI 6.3 specification, buffer_fields
created using the ASL create_field() Operator have been treated as
integers if the buffer_field is small enough to fit inside of an ASL
integer (32-bits or 64-bits depending on the definition block
revision). If they are larger, buffer fields are treated as ASL
Buffer objects. However, this is not true for other AML interpreter
implementations.

It has been discovered that other AML interpreters always treat
buffer fields created by create_field() as a buffer regardless of the
length of the buffer field.

More specifically, the Microsoft AML interpreter always treats buffer
fields created by the create_field() operator as buffer. ACPICA
currently does this only when the field size is larger than the
maximum integer width. This causes problems with AML code shipped in
Microsoft Surface devices.

More details:

The control methods in these devices determine the success of an ASL
control method execution by examining the type resulting from storing
a buffer field created by a create_field() operator. On success, a
Buffer object is expected, on failure an Integer containing an error
code. This buffer object is created with a dynamic size via the
create_field() operator. Due to the difference in behavior, Buffer
values of small size are however converted to Integers and thus
interpreted by the control method as having failed, whereas in
reality it succeeded. Below is an example of a control method called
TEST that illustrates this behavior.

Method (CBUF) // Create a Buffer field
{
    /*
     * Depending on the value of RAND, ACPICA interpreter will treat
     * BF00 as an integer or buffer.
     */
    create_field (BUFF, 0, RAND, BF00)
    return (BF00)
}

Method (TEST)
{
    /*
     * Storing the value returned by CBUF to local0 will result in
     * implicit type conversion outlined in the ACPI specification.
     *
     * ACPICA will treat local0 like an ASL integer if RAND is less
     * than or equal to 64 or 32 (depending on the definition_block
     * revision). If RAND is greater, it will be treated like an ASL
     * buffer. Other implementations treat local0 like an ASL buffer
     * regardless of the value of RAND.
     */
    local0 = CBUF()

    /*
     * object_type of 0x03 represents an ASL Buffer
     */
    if (object_type (Local0) != 0x03)
    {
        // Error on ACPICA if RAND is small enough
    }
    else
    {
        /*
         * Success on APICA if RAND is large enough
         * Other implementations always take this path because local0
         * is always treated as a buffer.
         */
    }
}

This change prohibits the previously mentioned integer conversion to
match other AML interpreter implementations (Microsoft) that do not
conform to the ACPI specification.

Link: https://github.com/acpica/acpica/commit/79a466b6
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/acobject.h |  3 ++-
 drivers/acpi/acpica/dsopcode.c |  2 ++
 drivers/acpi/acpica/exfield.c  | 10 ++++++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 8def0e3d690f..10154a8157ec 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -260,7 +260,8 @@ struct acpi_object_index_field {
 /* The buffer_field is different in that it is part of a Buffer, not an op_region */
 
 struct acpi_object_buffer_field {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *buffer_obj;	/* Containing Buffer object */
+	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u8 is_create_field;	/* Special case for objects created by create_field() */
+	union acpi_operand_object *buffer_obj;	/* Containing Buffer object */
 };
 
 /******************************************************************************
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 10f32b62608e..2488218f8562 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -217,6 +217,8 @@ acpi_ds_init_buffer_field(u16 aml_opcode,
 	}
 
 	obj_desc->buffer_field.buffer_obj = buffer_desc;
+	obj_desc->buffer_field.is_create_field =
+	    aml_opcode == AML_CREATE_FIELD_OP;
 
 	/* Reference count for buffer_desc inherits obj_desc count */
 
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index d3d2dbfba680..633417650f3d 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -96,7 +96,8 @@ acpi_ex_get_protocol_buffer_length(u32 protocol_id, u32 *return_length)
  * RETURN:      Status
  *
  * DESCRIPTION: Read from a named field. Returns either an Integer or a
- *              Buffer, depending on the size of the field.
+ *              Buffer, depending on the size of the field and whether if a
+ *              field is created by the create_field() operator.
  *
  ******************************************************************************/
 
@@ -154,12 +155,17 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 	 * the use of arithmetic operators on the returned value if the
 	 * field size is equal or smaller than an Integer.
 	 *
+	 * However, all buffer fields created by create_field operator needs to
+	 * remain as a buffer to match other AML interpreter implementations.
+	 *
 	 * Note: Field.length is in bits.
 	 */
 	buffer_length =
 	    (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->field.bit_length);
 
-	if (buffer_length > acpi_gbl_integer_byte_width) {
+	if (buffer_length > acpi_gbl_integer_byte_width ||
+	    (obj_desc->common.type == ACPI_TYPE_BUFFER_FIELD &&
+	     obj_desc->buffer_field.is_create_field)) {
 
 		/* Field is too large for an Integer, create a Buffer instead */
 
-- 
2.21.0

