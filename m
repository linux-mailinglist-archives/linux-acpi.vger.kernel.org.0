Return-Path: <linux-acpi+bounces-20936-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGjhNtp2jGk6ogAAu9opvQ
	(envelope-from <linux-acpi+bounces-20936-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:32:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A31C124466
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FEF2301706A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 12:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EDC1A9FA4;
	Wed, 11 Feb 2026 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDP6A3Z2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489E194AD7;
	Wed, 11 Feb 2026 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813129; cv=none; b=sQ7iTEONIU7i4Z2EtgjeJlcuKFM9odrdxAv29PDgIiqgsfraCg/7Ial8753vimXNwwMj3ln9qM6ECTmfn+1H1f9RMt9XDlx0GmTG8UwyJn7R0cnngxJhYeCC+ACuI2DUEOmZNWDCoIHSdQn45fKVV60O74LUTF2Zi9d7SXFG6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813129; c=relaxed/simple;
	bh=Uk510mEDj+GY7I1ongoJg5xxsKqWMBWmEKzcmdm94jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJhAIGwFw+yiwkn1azrXBMMg8ch2l0buaVvJrQQf2nxNSM7KFXtHcv84WFGW69Uc6cFIrEtkFrlWKQTF/fWPgutxRvHhXVTIxGCTDNinpRYH4moBBg/Lj3/zu8F0nB8wKBobnGNs1RteTKATBzyCT3R1bRNsbHLNUv4XipCKIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDP6A3Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9D4C4CEF7;
	Wed, 11 Feb 2026 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770813129;
	bh=Uk510mEDj+GY7I1ongoJg5xxsKqWMBWmEKzcmdm94jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDP6A3Z2mv5M0jIyxTPUE+gRyWZnPq6Oz0YjBMd/obiYqwztnSSAO0E23QyEzaHtR
	 dQBEl9Ru+s+GOUZmSVs8CizLYmN4N9FMCLWWap5VDP112DK+G3BYkwusN1Vf61HntI
	 UmkFD14BPlFaqWv8jnhR9xai4f9Xj5W5Vh1gESsf2PphJsGOUqaWrLoQVImNE9yKyc
	 Qp5JBahZB+1o13JmSkJzpNHXG05Kv19mKbGtK8Ei8cIcF9ArhMB9Cwf+B1v7s2ZQiY
	 1ZrlUA38votD+8p+S5+P4HkmGXIECvkuSJh3+cwa/zAs6wZrTvCDMg/CBLk2eUjDwH
	 W0rN2s0ML0BxA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.19-5.10] ACPICA: Abort AML bytecode execution when executing AML_FATAL_OP
Date: Wed, 11 Feb 2026 07:30:36 -0500
Message-ID: <20260211123112.1330287-26-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211123112.1330287-1-sashal@kernel.org>
References: <20260211123112.1330287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.de,intel.com,kernel.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20936-lists,linux-acpi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,gmx.de:email]
X-Rspamd-Queue-Id: 9A31C124466
X-Rspamd-Action: no action

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 026ad376a6a48538b576f3589331daa94daae6f0 ]

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
Link: https://patch.msgid.link/3325491.5fSG56mABF@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a thorough analysis.

---

## Complete Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit addresses a clear specification violation in ACPICA's
handling of the AML `Fatal()` operator. The ACPI specification states
that when `AML_FATAL_OP` is executed, the OS should log the fatal error
and shut down. Windows complies by entering a BSoD (Blue Screen of
Death), which effectively halts AML execution. However, ACPICA's Linux
implementation of `acpi_os_signal()` merely prints `"Fatal opcode
executed\n"` and returns `AE_OK`, after which the AML interpreter
continues executing subsequent bytecode.

The commit author (Armin Wolf) explicitly states that BIOS
implementations may assume `Fatal()` does not return - this is a
reasonable assumption based on the spec and Windows behavior. Continuing
to execute AML code after a Fatal() is a real correctness bug.

### 2. CODE CHANGE ANALYSIS

The change is in a single file `drivers/acpi/acpica/exoparg3.c` and
touches only the `acpi_ex_opcode_3A_0T_0R` function. The diff has three
substantive changes:

**a) Stack allocation instead of heap allocation (minor fix +
cleanup):**

Old code:

```51:84:drivers/acpi/acpica/exoparg3.c
        struct acpi_signal_fatal_info *fatal;
        // ...
        fatal = ACPI_ALLOCATE(sizeof(struct acpi_signal_fatal_info));
        if (fatal) {
                fatal->type = (u32) operand[0]->integer.value;
                fatal->code = (u32) operand[1]->integer.value;
                fatal->argument = (u32) operand[2]->integer.value;
        }
        /* Always signal the OS! */
        status = acpi_os_signal(ACPI_SIGNAL_FATAL, fatal);
```

The old code had a subtle bug: if `ACPI_ALLOCATE` fails, `fatal` is
NULL, but the code still calls `acpi_os_signal(ACPI_SIGNAL_FATAL, NULL)`
because the comment says "Always signal the OS!" The current Linux
`acpi_os_signal()` doesn't dereference `info` for the FATAL case, so it
doesn't crash, but it's incorrect. The new code uses a stack variable
(12 bytes), eliminating both the allocation failure path and the
unnecessary heap allocation.

**b) Return AE_ERROR instead of AE_OK (the core fix):**

Old code: returns whatever `acpi_os_signal()` returns, which is `AE_OK`
on Linux (confirmed by reading `drivers/acpi/osl.c:1402`). This means
execution continues.

New code: always returns `AE_ERROR` via `return_ACPI_STATUS(AE_ERROR)`.

When `AE_ERROR` is returned, the dispatch in `acpi_ds_exec_end_op`
propagates the error to `acpi_ds_method_error()`, which will abort the
AML method execution. This correctly stops the interpreter from
executing AML bytecode that the BIOS developer assumed would be
unreachable.

**c) Better error logging:**

Changed from `ACPI_DEBUG_PRINT` (which only prints at debug level) to
`ACPI_BIOS_ERROR` (which always prints as a BIOS error). This ensures
the fatal error is always visible in kernel logs, which is important for
diagnosing BIOS issues.

**d) Removal of cleanup label (pure cleanup):**

The `cleanup:` label and `status` variable are removed in favor of
direct returns from each case. This is a mechanical cleanup with no
behavioral impact.

### 3. BUG MECHANISM AND IMPACT

The bug mechanism is clear: when ACPI BIOS code calls `Fatal()`, the AML
interpreter on Linux continues executing subsequent bytecode. This is
dangerous because:

1. **BIOS developers may write code assuming Fatal() never returns**
   (just like Windows BSoDs). Code after `Fatal()` may be uninitialized,
   nonsensical, or rely on undefined state. Executing such code could
   cause:
   - Writes to arbitrary ACPI registers
   - Undefined behavior in the AML interpreter
   - System instability, hangs, or crashes

2. **The Fatal() operator exists to signal critical BIOS errors.**
   Ignoring this signal and continuing is fundamentally wrong behavior.

3. The Linux `acpi_os_signal()` implementation at
   `drivers/acpi/osl.c:1382-1403` is a no-op that just prints a message
   and returns `AE_OK`. This makes the bug always trigger on Linux when
   Fatal() is encountered.

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed:** Net reduction of ~11 lines (the diff shows -29/+17
  in the ACPICA upstream). Very small.
- **Files touched:** 1 file (`drivers/acpi/acpica/exoparg3.c`)
- **Complexity:** Very low - straightforward change from `AE_OK` to
  `AE_ERROR` return, plus stack variable.
- **Subsystem:** ACPICA - the core ACPI interpreter. This is widely used
  on all x86 systems and increasingly on ARM.
- **Regression risk:** Very low. The `Fatal()` operator is extremely
  rarely used in real-world BIOS code - it's the nuclear option for BIOS
  developers. The change only affects behavior when a BIOS explicitly
  invokes `Fatal()`, and in that case, aborting execution is the correct
  behavior per spec. No correctly written BIOS should rely on code
  executing after `Fatal()`.

### 5. UPSTREAM PROVENANCE

The commit originates from the ACPICA project itself (link to
`github.com/acpica/acpica/commit/d516c7758ba6`) and is signed off by
Rafael J. Wysocki, the Linux ACPI maintainer. This is a well-reviewed,
authoritative fix from the component's upstream project.

### 6. DEPENDENCIES

The only new include is `#include <acpi/acoutput.h>` for the
`ACPI_BIOS_ERROR` macro. This header file exists in all stable kernel
trees (it's a core ACPICA header). The `ACPI_BIOS_ERROR` macro has been
available since at least Linux 3.x. No other dependencies exist.

### 7. SUMMARY

| Criterion | Assessment |
|-----------|------------|
| Fixes a real bug | Yes - continued execution after Fatal() violates
ACPI spec |
| Obviously correct | Yes - returning error to abort after Fatal() is
clearly correct |
| Small and contained | Yes - single file, ~20 net line changes |
| No new features | Correct - pure behavior fix |
| Risk of regression | Very low - only affects Fatal() path, which is
very rare |
| Applies to stable | Yes - the affected code exists unchanged in all
stable trees |
| Dependencies | None beyond existing ACPICA headers |

The fix addresses a real correctness bug that could cause unpredictable
system behavior when BIOS firmware triggers a Fatal() operator. It's
small, self-contained, comes from upstream ACPICA, and carries minimal
regression risk. The secondary fixes (NULL pointer to `acpi_os_signal`,
better logging) are also valuable.

**YES**

 drivers/acpi/acpica/exoparg3.c | 46 +++++++++++++---------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index bf08110ed6d25..c8c8c4e49563e 100644
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


