Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A788115145
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2019 14:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLFNqL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Dec 2019 08:46:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34453 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFNqL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Dec 2019 08:46:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so7859541wrr.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Dec 2019 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pchhA+Qd735SiSghx5b7/GfwHxZh3fNBHhqJYmqBUkQ=;
        b=rQLHkO7IRCw5XPQn/IUAVnExx5nXAsdqEWsTnS4ch1KjpjqMl16TC0P9iDdQ2D8hT3
         Z+EPLj7cs1cKQdWsjbGO7rZqrxlWkGOKnAqWux4G2Sw4m09Xzth8mPG7s2VDSNk278dx
         0imU8O7oY+UK+iO+a3RO3FB/2yqxoc+Q+uroWwbF2DPFw9u5f/s66DQvpMKPt+iHjHJi
         2oaZqs9M41GUTwDIN7Yk9ymiE4rqasPdSRD4oqAsPxwEpRvq8d6hqs3PG17Xvj9qAtdC
         VSYPpZhNVWOzOTRC1QU9DiyjNo67stkqkdx1eJ2koG++8HnVmjkcRJNtH8TM9AHRYWeT
         9FfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pchhA+Qd735SiSghx5b7/GfwHxZh3fNBHhqJYmqBUkQ=;
        b=llFS5O4jk+U7v9JdRgWiuGgjVk9qZiekcQ4mrJchM6Z1UwEVih8BfsEnPTNdkf+rRG
         WWuxIE+K94PWjVDsCs4DNDrqknp98II5wjdyqdb6fuNv/YTQldnU917dcUNnuK1mPRiS
         szDEmYInNVDWXZaenb9E4jVfpyE4VT9zL0bhQL8GYUGFruzUR5CadlLDDGlkKGnxaDFj
         J1f9XK80ngGZOazCF23+piOuT4tGk6IUIBUsuTAgcjtjb6HsdPtysb1yu6bd7sR4Fu+R
         tW6kxFP8UY2AmVq4jSejmtYM+qY5qQbQqp723U+IQHQaxT5q6zNUU3EancS0HBTQ3GS1
         tMfg==
X-Gm-Message-State: APjAAAVtb/sYu1NQIW+SDFkzuJE5upyXU6BeU0IgyVaFodvHFmFtJ9+l
        pFDPvrOJuOGafFM/hM87EO8=
X-Google-Smtp-Source: APXvYqx8sqfPPsfpm2+eiqI2Seer6sXLfQEMVv4iUfw28oPb8JZme60gTk6C+7UqZ6BnZtMGSeT2Nw==
X-Received: by 2002:a5d:5267:: with SMTP id l7mr16973781wrc.84.1575639969373;
        Fri, 06 Dec 2019 05:46:09 -0800 (PST)
Received: from xws.fritz.box (pD9E5AB28.dip0.t-ipconnect.de. [217.229.171.40])
        by smtp.gmail.com with ESMTPSA id w8sm3732001wmm.0.2019.12.06.05.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 05:46:08 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] ACPICA: Dispatcher: always generate buffer objects for ASL create_field() operator
Date:   Fri,  6 Dec 2019 14:45:44 +0100
Message-Id: <20191206134544.963913-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Microsoft AML interpreter always creates Buffer objects via the
create_field() operator. Linux currently does this only when the field
size is larger than the maximum integer width. This causes problems with
the DSDT of Microsoft Surface devices.

These devices determine the success of a function call by the type
returned from it. On success, a Buffer object is expected, on failure an
Integer containing an error code. This buffer object is created with a
dynamic size via the create_field() operator. Due to the difference in
behavior, Buffer values of small size are however converted to Integers
and thus interpreted by the DSDT as the method having failed, whereas in
reality it succeeded.

This is actually not a bug in the kernel, but rather Microsoft not
conforming with the ACPI specification.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
Description to be expanded.

This is a re-submit with changes as requested in
    PROBLEM: Calling ObjectType on buffer field reports type integer
---
 drivers/acpi/acpica/acobject.h |  3 ++-
 drivers/acpi/acpica/dsopcode.c |  2 ++
 drivers/acpi/acpica/exfield.c  | 15 ++++++++++++---
 3 files changed, 16 insertions(+), 4 deletions(-)

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
index 10f32b62608e..4632055121cd 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -217,6 +217,8 @@ acpi_ds_init_buffer_field(u16 aml_opcode,
 	}
 
 	obj_desc->buffer_field.buffer_obj = buffer_desc;
+	obj_desc->buffer_field.is_create_field =
+		aml_opcode == AML_CREATE_FIELD_OP;
 
 	/* Reference count for buffer_desc inherits obj_desc count */
 
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index d3d2dbfba680..7a4521f5ab3e 100644
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
 
@@ -154,14 +155,22 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
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
 
-		/* Field is too large for an Integer, create a Buffer instead */
+		/*
+		 * Field is either too large for an Integer or created by the
+		 * create_field() operator, so we need to create a Buffer.
+		 */
 
 		buffer_desc = acpi_ut_create_buffer_object(buffer_length);
 		if (!buffer_desc) {
-- 
2.24.0

