Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7C12360A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 20:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfLQTzC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 14:55:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:56006 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfLQTzB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 14:55:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 11:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="217624416"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2019 11:54:59 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Elia Geretto <elia.f.geretto@gmail.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 2/5] ACPICA: Disassembler: create buffer fields in ACPI_PARSE_LOAD_PASS1
Date:   Tue, 17 Dec 2019 11:35:20 -0800
Message-Id: <20191217193523.20204-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217193523.20204-1-erik.kaneda@intel.com>
References: <20191217193523.20204-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 29cc8dbc5463a93625bed87d7550a8bed8913bf4

create_buffer_field is a deferred op that is typically processed in
load pass 2. However, disassembly of control method contents walk the
parse tree with ACPI_PARSE_LOAD_PASS1 and AML_CREATE operators are
processed in a later walk. This is a problem when there is a control
method that has the same name as the AML_CREATE object. In this case,
any use of the name segment will be detected as a method call rather
than a reference to a buffer field. If this is detected as a method
call, it can result in a mal-formed parse tree if the control methods
have parameters.

This change in processing AML_CREATE ops earlier solves this issue by
inserting the named object in the ACPI namespace so that references
to this name would be detected as a name string rather than a method
call.

Link: https://github.com/acpica/acpica/commit/29cc8dbc
Reported-by: Elia Geretto <elia.f.geretto@gmail.com>
Tested-by: Elia Geretto <elia.f.geretto@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/dsfield.c |  2 +-
 drivers/acpi/acpica/dswload.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index faa38a22263a..ae713d746c8b 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -243,7 +243,7 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
  * FUNCTION:    acpi_ds_get_field_names
  *
  * PARAMETERS:  info            - create_field info structure
- *  `           walk_state      - Current method state
+ *              walk_state      - Current method state
  *              arg             - First parser arg for the field name list
  *
  * RETURN:      Status
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index c88fd31208a5..4bcf15bf03de 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -410,6 +410,27 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "Op=%p State=%p\n", op,
 			  walk_state));
 
+	/*
+	 * Disassembler: handle create field operators here.
+	 *
+	 * create_buffer_field is a deferred op that is typically processed in load
+	 * pass 2. However, disassembly of control method contents walk the parse
+	 * tree with ACPI_PARSE_LOAD_PASS1 and AML_CREATE operators are processed
+	 * in a later walk. This is a problem when there is a control method that
+	 * has the same name as the AML_CREATE object. In this case, any use of the
+	 * name segment will be detected as a method call rather than a reference
+	 * to a buffer field.
+	 *
+	 * This earlier creation during disassembly solves this issue by inserting
+	 * the named object in the ACPI namespace so that references to this name
+	 * would be a name string rather than a method call.
+	 */
+	if ((walk_state->parse_flags & ACPI_PARSE_DISASSEMBLE) &&
+	    (walk_state->op_info->flags & AML_CREATE)) {
+		status = acpi_ds_create_buffer_field(op, walk_state);
+		return_ACPI_STATUS(status);
+	}
+
 	/* We are only interested in opcodes that have an associated name */
 
 	if (!(walk_state->op_info->flags & (AML_NAMED | AML_FIELD))) {
-- 
2.21.0

