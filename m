Return-Path: <linux-acpi+bounces-13991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB022AC8ECB
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 14:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99355502E33
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46424262FEA;
	Fri, 30 May 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POEy3eKj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886622FDE8;
	Fri, 30 May 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608850; cv=none; b=dEg36UF+ObwBHGGf7RnbCcySw4M0eAEAxKGMewyjZdEJB81M9ve8lRsdoK/9v1AUUUsY6LfEeuaTxcRCds/o5BkOr+j2yEuMshKHrfUZwRMDEoYLuPAVSEDVQCLxf587cbwuXWBM5IETPv3+TUz20KX7KJVftRZxCj5Kf0QlVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608850; c=relaxed/simple;
	bh=16wZIjI3rM+SR9jJf6FfDXb7wOEnVPcIjK1MwsxP91c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mh+P+fbaN53+kp+s7XPN8t+bLusd4/TYeRImlqrpc2zdfZlsnpZBXcayBQ4Oca570BelL5t8cG+X609RfI07NaqXxzG1Pzs74xDaG3cyYDM6PhfrIg7WqQ88X3hAapwFCeY+2nvo59cnuFWgkVf1hMFiOB1+S1YJrfGpFaqwX44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POEy3eKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69D5C4CEE9;
	Fri, 30 May 2025 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608850;
	bh=16wZIjI3rM+SR9jJf6FfDXb7wOEnVPcIjK1MwsxP91c=;
	h=From:To:Cc:Subject:Date:From;
	b=POEy3eKjCTwBQcrnqzwyyeMqLn86wJrWKzrN+o+pTLyV5EB3AkZ5lG0rggm3n+XTC
	 NhXaXhP9z48GJjSxzQcg6GEqCxlSIe0G28gZjlIoQPaJOe33NCYacwMaS71vf1wCml
	 uPyVDsi2dcT1+H/06UhAMCiuVde8P+jwUcMnhrHwWvZXsGoQid/vijx2WOxTiNg/V7
	 WTFMEi0hl042eqIXfpwq4fJ1C0Cd5+LSUY29q8NktIpb+DAMTaNiiez60/sv6ZvDVA
	 GKDccnGxEj132NSVTRUDW4g5dcOV22hHasdFPd8msAf/EMGymoZac0aARP46y1P392
	 K1d08zF7QyOoQ==
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
Subject: [PATCH AUTOSEL 6.6 01/18] ACPICA: fix acpi operand cache leak in dswstate.c
Date: Fri, 30 May 2025 08:40:30 -0400
Message-Id: <20250530124047.2575954-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Seunghun Han <kkamagui@gmail.com>

[ Upstream commit 156fd20a41e776bbf334bd5e45c4f78dfc90ce1c ]

ACPICA commit 987a3b5cf7175916e2a4b6ea5b8e70f830dfe732

I found an ACPI cache leak in ACPI early termination and boot continuing case.

When early termination occurs due to malicious ACPI table, Linux kernel
terminates ACPI function and continues to boot process. While kernel terminates
ACPI function, kmem_cache_destroy() reports Acpi-Operand cache leak.

Boot log of ACPI operand cache leak is as follows:
>[    0.585957] ACPI: Added _OSI(Module Device)
>[    0.587218] ACPI: Added _OSI(Processor Device)
>[    0.588530] ACPI: Added _OSI(3.0 _SCP Extensions)
>[    0.589790] ACPI: Added _OSI(Processor Aggregator Device)
>[    0.591534] ACPI Error: Illegal I/O port address/length above 64K: C806E00000004002/0x2 (20170303/hwvalid-155)
>[    0.594351] ACPI Exception: AE_LIMIT, Unable to initialize fixed events (20170303/evevent-88)
>[    0.597858] ACPI: Unable to start the ACPI Interpreter
>[    0.599162] ACPI Error: Could not remove SCI handler (20170303/evmisc-281)
>[    0.601836] kmem_cache_destroy Acpi-Operand: Slab cache still has objects
>[    0.603556] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc5 #26
>[    0.605159] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS virtual_box 12/01/2006
>[    0.609177] Call Trace:
>[    0.610063]  ? dump_stack+0x5c/0x81
>[    0.611118]  ? kmem_cache_destroy+0x1aa/0x1c0
>[    0.612632]  ? acpi_sleep_proc_init+0x27/0x27
>[    0.613906]  ? acpi_os_delete_cache+0xa/0x10
>[    0.617986]  ? acpi_ut_delete_caches+0x3f/0x7b
>[    0.619293]  ? acpi_terminate+0xa/0x14
>[    0.620394]  ? acpi_init+0x2af/0x34f
>[    0.621616]  ? __class_create+0x4c/0x80
>[    0.623412]  ? video_setup+0x7f/0x7f
>[    0.624585]  ? acpi_sleep_proc_init+0x27/0x27
>[    0.625861]  ? do_one_initcall+0x4e/0x1a0
>[    0.627513]  ? kernel_init_freeable+0x19e/0x21f
>[    0.628972]  ? rest_init+0x80/0x80
>[    0.630043]  ? kernel_init+0xa/0x100
>[    0.631084]  ? ret_from_fork+0x25/0x30
>[    0.633343] vgaarb: loaded
>[    0.635036] EDAC MC: Ver: 3.0.0
>[    0.638601] PCI: Probing PCI hardware
>[    0.639833] PCI host bridge to bus 0000:00
>[    0.641031] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> ... Continue to boot and log is omitted ...

I analyzed this memory leak in detail and found acpi_ds_obj_stack_pop_and_
delete() function miscalculated the top of the stack. acpi_ds_obj_stack_push()
function uses walk_state->operand_index for start position of the top, but
acpi_ds_obj_stack_pop_and_delete() function considers index 0 for it.
Therefore, this causes acpi operand memory leak.

This cache leak causes a security threat because an old kernel (<= 4.9) shows
memory locations of kernel functions in stack dump. Some malicious users
could use this information to neutralize kernel ASLR.

I made a patch to fix ACPI operand cache leak.

Link: https://github.com/acpica/acpica/commit/987a3b5c
Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/4999480.31r3eYUQgx@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees based on
the following analysis: ## Analysis of the Commit **1. Bug Fix Nature**:
This commit fixes a clear memory leak bug in the ACPICA subsystem. The
issue occurs when `acpi_ds_create_operands()` encounters an error during
operand creation and needs to clean up allocated operands. **2. Root
Cause**: The core issue is a mismatch between how operands are pushed
and popped from the stack: - `acpi_ds_obj_stack_push()` uses
`walk_state->operand_index` to track the current position -
`acpi_ds_obj_stack_pop_and_delete()` incorrectly assumes operands start
at index 0 - This causes incomplete cleanup when errors occur, leading
to memory leaks **3. Code Analysis**: The fix correctly addresses the
issue by: - Tracking the original operand count (`prev_num_operands`) -
Calculating the correct number of operands to clean up
(`new_num_operands`) - Setting `walk_state->num_operands = i` before
cleanup to ensure proper indexing - Restoring the original operand count
after cleanup **4. Security Implications**: The commit message
explicitly mentions this is a security issue - the memory leak can
expose kernel function addresses in older kernels (≤4.9), potentially
defeating ASLR. This elevates the importance beyond a simple memory
leak. **5. Pattern Consistency**: This follows the exact same pattern as
other ACPICA operand cache leak fixes that were successfully backported
(commits `97f3c0a4b057`, `2915f16bdce2`, etc.), all authored by the same
developer addressing similar issues. **6. Stability Characteristics**: -
**Small and contained**: Only 8 lines of actual logic changes - **Clear
error path**: Only affects cleanup during error conditions - **No
behavioral changes**: No impact on normal operation - **Low regression
risk**: Only modifies error handling paths **7. Backport Suitability
Criteria**: - ✅ Fixes important bug affecting users (memory leak) - ✅
Small, contained fix with minimal risk - ✅ No architectural changes - ✅
Addresses security concern (ASLR bypass potential) - ✅ Follows
established patterns for ACPICA fixes - ✅ Critical kernel subsystem
(ACPI) **8. Historical Precedent**: The similar commits in the reference
examples (Similar Commits #1, #2, #3) all have "Backport Status: YES"
and address nearly identical ACPICA operand cache leak issues with
similar fixes and commit message patterns. This commit meets all
criteria for stable tree backporting: it's an important bugfix, has
minimal regression risk, affects a critical subsystem, and follows
established patterns for similar fixes that were previously backported.

 drivers/acpi/acpica/dsutils.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index fb9ed5e1da89d..2bdae8a25e084 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -668,6 +668,8 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	union acpi_parse_object *arguments[ACPI_OBJ_NUM_OPERANDS];
 	u32 arg_count = 0;
 	u32 index = walk_state->num_operands;
+	u32 prev_num_operands = walk_state->num_operands;
+	u32 new_num_operands;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_create_operands, first_arg);
@@ -696,6 +698,7 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 
 	/* Create the interpreter arguments, in reverse order */
 
+	new_num_operands = index;
 	index--;
 	for (i = 0; i < arg_count; i++) {
 		arg = arguments[index];
@@ -720,7 +723,11 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	 * pop everything off of the operand stack and delete those
 	 * objects
 	 */
-	acpi_ds_obj_stack_pop_and_delete(arg_count, walk_state);
+	walk_state->num_operands = i;
+	acpi_ds_obj_stack_pop_and_delete(new_num_operands, walk_state);
+
+	/* Restore operand count */
+	walk_state->num_operands = prev_num_operands;
 
 	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %u", index));
 	return_ACPI_STATUS(status);
-- 
2.39.5


