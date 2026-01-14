Return-Path: <linux-acpi+bounces-20306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C21D1EDF2
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A2393055E11
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DBE39B496;
	Wed, 14 Jan 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1lwLlEP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BC399008;
	Wed, 14 Jan 2026 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394542; cv=none; b=KHB2jxqVqua7UlZAtwRT2qEWOsG2PW/0b0NdiWyEd/MzHEf0ws1Ewjy6qFt4+EyR8RK8gDr1jZ/TzBlmPkx0FjbhGruqmyRhPB7PHDJE4MZvkfLcEUwlCb4l9cnRtQrBrqqoXmwI4r/Q+QSXACVXHKXRmHzrdNVVUmdMnqAZ9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394542; c=relaxed/simple;
	bh=t3Csh20MThd1EnDMzhZq50J9gjVedvO6yJoRtJkzamQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aopMz9j9ZEglWyPjmpibAJR9Ma7Za0LA55UmW9yQVUp01Nq/n+umAma8LD0peJ167rKo84c5MIDG/aOF1Dk6bCx65k8fUCmPoKcGeQ+3PY6lpdHVnfva59Xe4HRDQUnFHh+RWmZuK5lBgROfrK2zMBkdrWSlupZXv9p+hNvLnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1lwLlEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9E6C4CEF7;
	Wed, 14 Jan 2026 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394538;
	bh=t3Csh20MThd1EnDMzhZq50J9gjVedvO6yJoRtJkzamQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1lwLlEP6LwuHmTVuJE7qsmifdvmjFRzGgnytvCVDZillvM0c34n1YWytmZtVtpFZ
	 xXBJz5HrMqN/SBKtRGJgr40f50PyaNjwrnoBL07XK0c6rbkDAKjbCPrS3zb4cdsGy5
	 2Eklal6N5TDigSDhWosUuLeesSbA7bCbicpWSbMO3EvJZvwn9en2irlLx1l1dwJgC/
	 LrhAFHU/V/NhipF98hP52BwUxs60M9+dyTdLe84Uf5HjOVyIYkWAzRfyaUpc1/9T7a
	 VI9+6fKxml+ydJw/3XR/+HMSOiVgMsfPjiom2z8Oeo2rjbLK+3L30HdPT53jeOOU73
	 ahF90fclelWOg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 11/26] ACPICA: Abort AML bytecode execution when executing
 AML_FATAL_OP
Date: Wed, 14 Jan 2026 13:25:33 +0100
Message-ID: <3325491.5fSG56mABF@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12822121.O9o76ZdvQC@rafael.j.wysocki>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Armin Wolf <W_Armin@gmx.de>

The ACPI specification states that when executing AML_FATAL_OP,
the OS should log the fatal error event and shutdown in a timely
fashion.

Windows complies with this requirement by immediatly entering a
Bso_d, effectively aborting the execution of the AML bytecode in
question.

ACPICA however might continue with the AML bytecode execution
should acpi_os_signal() simply return AE_OK. This will cause issues
because ACPI BIOS implementations might assume that the Fatal()
operator does not return.

Fix this by aborting the AML bytecode execution in such a case
by returning AE_ERROR. Also turn struct acpi_signal_fatal_info into a
local variable because of its small size (12 bytes) and to ensure
that acpi_os_signal() always receives valid information about the
fatal ACPI BIOS error.

Link: https://github.com/acpica/acpica/commit/d516c7758ba6
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/exoparg3.c | 46 +++++++++++++---------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index bf08110ed6d2..c8c8c4e49563 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -10,6 +10,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acinterp.h"
+#include <acpi/acoutput.h>
 #include "acparser.h"
 #include "amlcode.h"
 
@@ -51,8 +52,7 @@ ACPI_MODULE_NAME("exoparg3")
 acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 {
 	union acpi_operand_object **operand = &walk_state->operands[0];
-	struct acpi_signal_fatal_info *fatal;
-	acpi_status status = AE_OK;
+	struct acpi_signal_fatal_info fatal;
 
 	ACPI_FUNCTION_TRACE_STR(ex_opcode_3A_0T_0R,
 				acpi_ps_get_opcode_name(walk_state->opcode));
@@ -60,28 +60,23 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 	switch (walk_state->opcode) {
 	case AML_FATAL_OP:	/* Fatal (fatal_type fatal_code fatal_arg) */
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "FatalOp: Type %X Code %X Arg %X "
-				  "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n",
-				  (u32)operand[0]->integer.value,
-				  (u32)operand[1]->integer.value,
-				  (u32)operand[2]->integer.value));
-
-		fatal = ACPI_ALLOCATE(sizeof(struct acpi_signal_fatal_info));
-		if (fatal) {
-			fatal->type = (u32) operand[0]->integer.value;
-			fatal->code = (u32) operand[1]->integer.value;
-			fatal->argument = (u32) operand[2]->integer.value;
-		}
+		fatal.type = (u32)operand[0]->integer.value;
+		fatal.code = (u32)operand[1]->integer.value;
+		fatal.argument = (u32)operand[2]->integer.value;
 
-		/* Always signal the OS! */
+		ACPI_BIOS_ERROR((AE_INFO,
+				 "Fatal ACPI BIOS error (Type 0x%X Code 0x%X Arg 0x%X)\n",
+				 fatal.type, fatal.code, fatal.argument));
 
-		status = acpi_os_signal(ACPI_SIGNAL_FATAL, fatal);
+		/* Always signal the OS! */
 
-		/* Might return while OS is shutting down, just continue */
+		acpi_os_signal(ACPI_SIGNAL_FATAL, &fatal);
 
-		ACPI_FREE(fatal);
-		goto cleanup;
+		/*
+		 * Might return while OS is shutting down, so abort the AML execution
+		 * by returning an error.
+		 */
+		return_ACPI_STATUS(AE_ERROR);
 
 	case AML_EXTERNAL_OP:
 		/*
@@ -93,21 +88,16 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 		 * wrong if an external opcode ever gets here.
 		 */
 		ACPI_ERROR((AE_INFO, "Executed External Op"));
-		status = AE_OK;
-		goto cleanup;
+
+		return_ACPI_STATUS(AE_OK);
 
 	default:
 
 		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 
-		status = AE_AML_BAD_OPCODE;
-		goto cleanup;
+		return_ACPI_STATUS(AE_AML_BAD_OPCODE);
 	}
-
-cleanup:
-
-	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
-- 
2.51.0





