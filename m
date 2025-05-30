Return-Path: <linux-acpi+bounces-14007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95358AC8F70
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 15:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7275D1884BAB
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC922749DE;
	Fri, 30 May 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azsrb5PD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD42749C5;
	Fri, 30 May 2025 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608901; cv=none; b=jt+kOTgqzY5wP100w/zKzrt4Yv66ykxAJanZfOe/rd1jq9NqzhIgmlnHfwecfc0cqOpFvmtLm6s1VF/VXHMz9AgrhqkrAJvlSxdSbZEeD1z6uNBj2qMINlGu/cQeHtBYK6x3k6LvIEvTlBqcuw6fWPXYMv618W0u/AxByB46tpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608901; c=relaxed/simple;
	bh=65bzQ8XRXWobLMJjt9WM/CT3eM7AX7PlR5sdrOtEras=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfbe8h++QkW4g5teSOvDXtpVlLmYPomu/bE6rn7gWREfMbpF0TKDEbBXO9qT+h0FM850tfBiK2TKQFXww20bARsKa1xMAA66ru/mXa9+4sHDmde/vquCDL7Jmn6eXpNcsx2Zxy5md8L511Zpjyxam0qfNR9sJg4fJr4SxZ4326g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azsrb5PD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8777C4CEE9;
	Fri, 30 May 2025 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608900;
	bh=65bzQ8XRXWobLMJjt9WM/CT3eM7AX7PlR5sdrOtEras=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azsrb5PDEMlCqIi3HF9DT92C3WS2l7lD5ogw9ePocD3WTJ10lf5P4WLBTnxedzf+e
	 D+hciS5MzbnnP+hFMC7mqGkx11Sp0p1eyL+x5ODk8j894QmiN0Ph/O9G84Ce5Rxee/
	 MpMYsiru5XNK7k8a/HrorwGOT9+AruZ0YVsunqIbytOtswEodr6w2J1RiR4+pTi/nM
	 qpvWNzBUUHZPlgFnSkz7HqiVUJAF9QAk/3PK0fwViohfUTEkCrm9kOvJVC+4eesw5C
	 uosCb8A2IkvX+UYXAeKldwy/lC5QTikoFY2UZoyjC7/BAxyxVcuGb+d1AV27L0uVlf
	 SezN+JnzCSNHQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Seunghun Han <kkamagui@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	erik.schmauss@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	devel@acpica.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/11] ACPICA: fix acpi parse and parseext cache leaks
Date: Fri, 30 May 2025 08:41:26 -0400
Message-Id: <20250530124131.2576650-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124131.2576650-1-sashal@kernel.org>
References: <20250530124131.2576650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.184
Content-Transfer-Encoding: 8bit

From: Seunghun Han <kkamagui@gmail.com>

[ Upstream commit bed18f0bdcd6737a938264a59d67923688696fc4 ]

ACPICA commit 8829e70e1360c81e7a5a901b5d4f48330e021ea5

I'm Seunghun Han, and I work for National Security Research Institute of
South Korea.

I have been doing a research on ACPI and found an ACPI cache leak in ACPI
early abort cases.

Boot log of ACPI cache leak is as follows:
[    0.352414] ACPI: Added _OSI(Module Device)
[    0.353182] ACPI: Added _OSI(Processor Device)
[    0.353182] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.353182] ACPI: Added _OSI(Processor Aggregator Device)
[    0.356028] ACPI: Unable to start the ACPI Interpreter
[    0.356799] ACPI Error: Could not remove SCI handler (20170303/evmisc-281)
[    0.360215] kmem_cache_destroy Acpi-State: Slab cache still has objects
[    0.360648] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #10
[    0.361273] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS
virtual_box 12/01/2006
[    0.361873] Call Trace:
[    0.362243]  ? dump_stack+0x5c/0x81
[    0.362591]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.362944]  ? acpi_sleep_proc_init+0x27/0x27
[    0.363296]  ? acpi_os_delete_cache+0xa/0x10
[    0.363646]  ? acpi_ut_delete_caches+0x6d/0x7b
[    0.364000]  ? acpi_terminate+0xa/0x14
[    0.364000]  ? acpi_init+0x2af/0x34f
[    0.364000]  ? __class_create+0x4c/0x80
[    0.364000]  ? video_setup+0x7f/0x7f
[    0.364000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.364000]  ? do_one_initcall+0x4e/0x1a0
[    0.364000]  ? kernel_init_freeable+0x189/0x20a
[    0.364000]  ? rest_init+0xc0/0xc0
[    0.364000]  ? kernel_init+0xa/0x100
[    0.364000]  ? ret_from_fork+0x25/0x30

I analyzed this memory leak in detail. I found that “Acpi-State” cache and
“Acpi-Parse” cache were merged because the size of cache objects was same
slab cache size.

I finally found “Acpi-Parse” cache and “Acpi-parse_ext” cache were leaked
using SLAB_NEVER_MERGE flag in kmem_cache_create() function.

Real ACPI cache leak point is as follows:
[    0.360101] ACPI: Added _OSI(Module Device)
[    0.360101] ACPI: Added _OSI(Processor Device)
[    0.360101] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.361043] ACPI: Added _OSI(Processor Aggregator Device)
[    0.364016] ACPI: Unable to start the ACPI Interpreter
[    0.365061] ACPI Error: Could not remove SCI handler (20170303/evmisc-281)
[    0.368174] kmem_cache_destroy Acpi-Parse: Slab cache still has objects
[    0.369332] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #8
[    0.371256] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS
virtual_box 12/01/2006
[    0.372000] Call Trace:
[    0.372000]  ? dump_stack+0x5c/0x81
[    0.372000]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.372000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.372000]  ? acpi_os_delete_cache+0xa/0x10
[    0.372000]  ? acpi_ut_delete_caches+0x56/0x7b
[    0.372000]  ? acpi_terminate+0xa/0x14
[    0.372000]  ? acpi_init+0x2af/0x34f
[    0.372000]  ? __class_create+0x4c/0x80
[    0.372000]  ? video_setup+0x7f/0x7f
[    0.372000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.372000]  ? do_one_initcall+0x4e/0x1a0
[    0.372000]  ? kernel_init_freeable+0x189/0x20a
[    0.372000]  ? rest_init+0xc0/0xc0
[    0.372000]  ? kernel_init+0xa/0x100
[    0.372000]  ? ret_from_fork+0x25/0x30
[    0.388039] kmem_cache_destroy Acpi-parse_ext: Slab cache still has objects
[    0.389063] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #8
[    0.390557] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS
virtual_box 12/01/2006
[    0.392000] Call Trace:
[    0.392000]  ? dump_stack+0x5c/0x81
[    0.392000]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.392000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.392000]  ? acpi_os_delete_cache+0xa/0x10
[    0.392000]  ? acpi_ut_delete_caches+0x6d/0x7b
[    0.392000]  ? acpi_terminate+0xa/0x14
[    0.392000]  ? acpi_init+0x2af/0x34f
[    0.392000]  ? __class_create+0x4c/0x80
[    0.392000]  ? video_setup+0x7f/0x7f
[    0.392000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.392000]  ? do_one_initcall+0x4e/0x1a0
[    0.392000]  ? kernel_init_freeable+0x189/0x20a
[    0.392000]  ? rest_init+0xc0/0xc0
[    0.392000]  ? kernel_init+0xa/0x100
[    0.392000]  ? ret_from_fork+0x25/0x30

When early abort is occurred due to invalid ACPI information, Linux kernel
terminates ACPI by calling acpi_terminate() function. The function calls
acpi_ut_delete_caches() function to delete local caches (acpi_gbl_namespace_
cache, state_cache, operand_cache, ps_node_cache, ps_node_ext_cache).

But the deletion codes in acpi_ut_delete_caches() function only delete
slab caches using kmem_cache_destroy() function, therefore the cache
objects should be flushed before acpi_ut_delete_caches() function.

"Acpi-Parse" cache and "Acpi-ParseExt" cache are used in an AML parse
function, acpi_ps_parse_loop(). The function should complete all ops
using acpi_ps_complete_final_op() when an error occurs due to invalid
AML codes.
However, the current implementation of acpi_ps_complete_final_op() does not
complete all ops when it meets some errors and this cause cache leak.

This cache leak has a security threat because an old kernel (<= 4.9) shows
memory locations of kernel functions in stack dump. Some malicious users
could use this information to neutralize kernel ASLR.

To fix ACPI cache leak for enhancing security, I made a patch to complete all
ops unconditionally for acpi_ps_complete_final_op() function.

I hope that this patch improves the security of Linux kernel.

Thank you.

Link: https://github.com/acpica/acpica/commit/8829e70e
Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/2363774.ElGaqSPkdT@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees based on
comprehensive analysis of both the commit message and code changes: ##
Security Impact Analysis The commit fixes a critical **memory cache leak
that poses a security threat**: - The leak exposes kernel function
memory locations in stack dumps on older kernels (≤ 4.9) - This
information can be exploited to neutralize **kernel ASLR** (Address
Space Layout Randomization) - The researcher specifically mentions this
creates a security vulnerability that malicious users could exploit ##
Bug Analysis The commit addresses **"Acpi-Parse" and "Acpi-ParseExt"
cache leaks** that occur during ACPI early abort scenarios: 1. **Root
Cause**: In `acpi_ps_complete_final_op()`, when errors occur during AML
parsing, the function would exit early without properly cleaning up all
parse operations 2. **Leak Mechanism**: The original code had multiple
early return paths that bypassed the cleanup loop, leaving parse cache
objects unfreed 3. **Trigger Conditions**: Invalid/malicious ACPI tables
causing parse errors ## Code Changes Analysis The fix in
`drivers/acpi/acpica/psobject.c` is **well-contained and minimal**:
**Key changes:** 1. **Eliminates early returns**: Replaces immediate
`return_ACPI_STATUS()` calls with flag setting (`ascending = FALSE`) 2.
**Ensures complete cleanup**: All ops are now processed through
`acpi_ps_complete_this_op()` unconditionally 3. **Preserves error
reporting**: Uses `return_status` to track the first/most important
error while continuing cleanup 4. **Maintains logic flow**: The cleanup
loop now always runs to completion, preventing cache leaks **Specific
improvements:** - Lines 674-701: Instead of immediate return on
`AE_CTRL_TERMINATE`, sets `ascending = FALSE` and continues - Lines
704-712: On parse failures, sets `ascending = FALSE` and continues
instead of returning early - Lines 715-719: Always calls
`acpi_ps_complete_this_op()` and tracks errors without early exit ##
Backport Suitability Assessment **✅ Meets stable tree criteria:** 1.
**Important bug fix**: Fixes memory leaks with security implications 2.
**Minimal risk**: Changes are confined to error handling paths in ACPI
parser 3. **Small and contained**: Only 50 lines changed in a single
function 4. **No architectural changes**: Preserves existing API and
behavior 5. **Clear regression prevention**: Ensures proper resource
cleanup in error cases **✅ Historical precedent**: The kernel tree shows
**multiple similar ACPI cache leak fixes by the same security
researcher** (Seunghun Han) that were backported: - `3b2d69114fef` -
"ACPICA: Namespace: fix operand cache leak" - `97f3c0a4b057` - "ACPICA:
acpi: acpica: fix acpi operand cache leak in nseval.c" **✅ Risk
assessment:** - **Low regression risk**: Only affects error paths during
ACPI parse failures - **No functional changes**: Normal ACPI parsing
behavior unchanged - **Defensive programming**: Makes cleanup more
robust without changing success paths The commit represents a textbook
example of a stable-tree appropriate fix: it addresses an important
security-related memory leak with minimal, well-contained changes that
improve robustness without introducing new functionality or
architectural modifications.

 drivers/acpi/acpica/psobject.c | 52 ++++++++++------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index e4420cd6d2814..8fd191b363066 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -636,7 +636,8 @@ acpi_status
 acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  union acpi_parse_object *op, acpi_status status)
 {
-	acpi_status status2;
+	acpi_status return_status = status;
+	u8 ascending = TRUE;
 
 	ACPI_FUNCTION_TRACE_PTR(ps_complete_final_op, walk_state);
 
@@ -650,7 +651,7 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  op));
 	do {
 		if (op) {
-			if (walk_state->ascending_callback != NULL) {
+			if (ascending && walk_state->ascending_callback != NULL) {
 				walk_state->op = op;
 				walk_state->op_info =
 				    acpi_ps_get_opcode_info(op->common.
@@ -672,49 +673,26 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 				}
 
 				if (status == AE_CTRL_TERMINATE) {
-					status = AE_OK;
-
-					/* Clean up */
-					do {
-						if (op) {
-							status2 =
-							    acpi_ps_complete_this_op
-							    (walk_state, op);
-							if (ACPI_FAILURE
-							    (status2)) {
-								return_ACPI_STATUS
-								    (status2);
-							}
-						}
-
-						acpi_ps_pop_scope(&
-								  (walk_state->
-								   parser_state),
-								  &op,
-								  &walk_state->
-								  arg_types,
-								  &walk_state->
-								  arg_count);
-
-					} while (op);
-
-					return_ACPI_STATUS(status);
+					ascending = FALSE;
+					return_status = AE_CTRL_TERMINATE;
 				}
 
 				else if (ACPI_FAILURE(status)) {
 
 					/* First error is most important */
 
-					(void)
-					    acpi_ps_complete_this_op(walk_state,
-								     op);
-					return_ACPI_STATUS(status);
+					ascending = FALSE;
+					return_status = status;
 				}
 			}
 
-			status2 = acpi_ps_complete_this_op(walk_state, op);
-			if (ACPI_FAILURE(status2)) {
-				return_ACPI_STATUS(status2);
+			status = acpi_ps_complete_this_op(walk_state, op);
+			if (ACPI_FAILURE(status)) {
+				ascending = FALSE;
+				if (ACPI_SUCCESS(return_status) ||
+				    return_status == AE_CTRL_TERMINATE) {
+					return_status = status;
+				}
 			}
 		}
 
@@ -724,5 +702,5 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 
 	} while (op);
 
-	return_ACPI_STATUS(status);
+	return_ACPI_STATUS(return_status);
 }
-- 
2.39.5


