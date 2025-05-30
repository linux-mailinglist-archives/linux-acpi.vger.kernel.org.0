Return-Path: <linux-acpi+bounces-14005-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28000AC8F4A
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 15:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFFEA45F8A
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A227147B;
	Fri, 30 May 2025 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXPPbwa4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303827146D;
	Fri, 30 May 2025 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608896; cv=none; b=Jbq6BPYScF3MRRQmeUr2OxACg5IXWlOFouOBRW7PjOVeUuIe03mMgwFFN8VBtSqTlaW+4X/6ZCV0fW8D8GSFG6VLi2auLQuPxM/YTxvauJjF88B4c5VQdsbez/IL4ZEBgcSPsgW9pTE6KQqJetTY7y4Rg9geK2vtIxP1nwHdCvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608896; c=relaxed/simple;
	bh=gYapoPMJvRop3xXBueJTc6uyQoriYNo6RJmdlM4p6Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=opQWa1USxHmvCe2Pdj6vQDnjzFVN4Qmcq5ZutREGzvQsqpOVzGFrdnItiAwqhsdesX8frR4bCJQuJjwiwuI0wKJDm3+lwyQHSP3KnvQL3yp5Avgfz7QunnA4xdl7RWMjt5tO6nmpqLmt1AbKc6Oy6sr9+hXvesdyjjiVLrgjYFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXPPbwa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E694C4CEF0;
	Fri, 30 May 2025 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608896;
	bh=gYapoPMJvRop3xXBueJTc6uyQoriYNo6RJmdlM4p6Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXPPbwa4z6Hs5pCFE0a3Xgh2bq70gyJLExwGFgO0ceSJnFty9NYBxE76LhOnEjsBe
	 Drar67fmcwI6c76M3rqTZOVGQIbhR8eIW4cMrEvDZ0kOl2TC418mM5NpRcKgMFeffz
	 chRHzoXhGgoWA6H/y3D0KXexUcko89ohxw8bbwEH3TU6urZdNkUTghEcfKkBz/kUpV
	 dxA4P6i/zsOh134XsVavWvaNR0oRhK/JYyCPzBfO3n0ncHyN4/z9PYy631p4FUVXzM
	 LoZMxszI6UbeKtAJXi3kpOYaitxcFfiX+Sv2EzDt1AgRhNq5HP5BjW+JCy9rgFdRiv
	 Tl1j0iKdsZS1w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ahmed Salem <x0rw3ll@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	erik.schmauss@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	devel@acpica.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/11] ACPICA: Avoid sequence overread in call to strncmp()
Date: Fri, 30 May 2025 08:41:23 -0400
Message-Id: <20250530124131.2576650-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124131.2576650-1-sashal@kernel.org>
References: <20250530124131.2576650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.184
Content-Transfer-Encoding: 8bit

From: Ahmed Salem <x0rw3ll@gmail.com>

[ Upstream commit 64b9dfd0776e9c38d733094859a09f13282ce6f8 ]

ACPICA commit 8b83a8d88dfec59ea147fad35fc6deea8859c58c

ap_get_table_length() checks if tables are valid by
calling ap_is_valid_header(). The latter then calls
ACPI_VALIDATE_RSDP_SIG(Table->Signature).

ap_is_valid_header() accepts struct acpi_table_header as an argument, so
the signature size is always fixed to 4 bytes.

The problem is when the string comparison is between ACPI-defined table
signature and ACPI_SIG_RSDP. Common ACPI table header specifies the
Signature field to be 4 bytes long[1], with the exception of the RSDP
structure whose signature is 8 bytes long "RSD PTR " (including the
trailing blank character)[2]. Calling strncmp(sig, rsdp_sig, 8) would
then result in a sequence overread[3] as sig would be smaller (4 bytes)
than the specified bound (8 bytes).

As a workaround, pass the bound conditionally based on the size of the
signature being passed.

Link: https://uefi.org/specs/ACPI/6.5_A/05_ACPI_Software_Programming_Model.html#system-description-table-header [1]
Link: https://uefi.org/specs/ACPI/6.5_A/05_ACPI_Software_Programming_Model.html#root-system-description-pointer-rsdp-structure [2]
Link: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wstringop-overread [3]
Link: https://github.com/acpica/acpica/commit/8b83a8d8
Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/2248233.Mh6RI2rZIc@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Detailed Analysis: ### The Problem The commit fixes a **buffer overread
vulnerability** in the `ACPI_VALIDATE_RSDP_SIG` macro. The issue occurs
when: 1. **Context**: The macro `ACPI_VALIDATE_RSDP_SIG(a)` calls
`strncmp(ACPI_CAST_PTR(char, (a)), ACPI_SIG_RSDP, 8)` 2. **Problem**:
When `a` points to a standard ACPI table header (4 bytes signature), but
the comparison tries to read 8 bytes for RSDP validation ("RSD PTR "),
it reads 4 bytes beyond the allocated signature field 3. **Impact**:
This causes a sequence overread that can be detected by tools like GCC's
`-Wstringop-overread` and security-focused architectures like
CHERI/Morello ### The Fix The fix changes line 530 in
`include/acpi/actypes.h`: ```c // Before: #define
ACPI_VALIDATE_RSDP_SIG(a) (!strncmp (ACPI_CAST_PTR (char, (a)),
ACPI_SIG_RSDP, 8)) // After: #define ACPI_VALIDATE_RSDP_SIG(a) (!strncmp
(ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ?
ACPI_NAMESEG_SIZE : 8)) ``` This conditionally limits the comparison to
`ACPI_NAMESEG_SIZE` (4 bytes) when the source is smaller than 8 bytes,
preventing the overread. ### Why This Should Be Backported: 1.
**Security Fix**: This addresses a buffer overread that could be
exploited or cause crashes on security-hardened systems 2. **Small &
Contained**: The fix is a single line change to a macro definition with
minimal risk 3. **Widespread Usage**: The macro is used in multiple
critical ACPI code paths: - `drivers/acpi/acpica/tbprint.c` (kernel ACPI
table printing) - `tools/power/acpi/tools/acpidump/apdump.c` (ACPI
debugging tools) - Various other ACPI validation functions 4. **No
Architectural Changes**: This doesn't change functionality, just
prevents unsafe memory access 5. **Compiler Warning Fix**: Resolves
build warnings with newer GCC versions using `-Wstringop-overread` ###
Comparison with Historical Commits: - **Similar to Commit #3 (YES)**:
Like the "disable -Wstringop-truncation" commit, this fixes compiler
warnings related to string operations, but this one actually fixes the
underlying safety issue rather than just suppressing warnings - **Unlike
Commits #1,#2,#4,#5 (NO)**: Those were either pure code cleanup,
debugging improvements, or infrastructure changes without security
implications ### Risk Assessment: - **Minimal Risk**: The fix only
affects boundary condition handling in string comparison - **No
Functional Impact**: Normal RSDP validation still works correctly for
valid 8-byte signatures - **Improves Safety**: Prevents potential memory
safety violations on hardened systems This is exactly the type of small,
safe, security-focused bugfix that stable trees are designed for.

 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index cefbb7ad253e0..ea50b9c469c9d 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -524,7 +524,7 @@ typedef u64 acpi_integer;
 
 /* Support for the special RSDP signature (8 characters) */
 
-#define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, 8))
+#define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
 #define ACPI_MAKE_RSDP_SIG(dest)        (memcpy (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))
 
 /* Support for OEMx signature (x can be any character) */
-- 
2.39.5


