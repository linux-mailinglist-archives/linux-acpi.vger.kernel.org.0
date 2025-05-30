Return-Path: <linux-acpi+bounces-14016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5CAC8F46
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 15:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40FD500592
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49128001A;
	Fri, 30 May 2025 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDp5m5dC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C916280017;
	Fri, 30 May 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608927; cv=none; b=DL3XFzBqHzUl6eHkFRNplKDlltZfTesMa/kAQ/rqELcPOGviZz5NOl+M9qMXMxsTv8EvFOosWU01v/tIvao4jvuPnEulp5r1oBLc3EgD5miIyjqmzO2eLezWIscK+jmGOB0ErkbQGetzPqITjecrMJFIM1B46W7QDrzdyPQosNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608927; c=relaxed/simple;
	bh=MortJCx6L3UCY/40doyLPQPqzHDtTmpZg2firvX0YZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=orD1Wf1heVzAnt4qw7AT50z/U00Sm1o4kF3Y33IDWGtDI//d35X2OmVgwRg/lAtALASUGwAiTcLFdeDQrztyV6Fe3mgwPODXhKs0S468TBzk0efv57IvOoV4N6giTS+dwSQ6MyT5me6BByNzAQ1zCKi4FFwWnzIKVichfqpGffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDp5m5dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF66EC4CEEB;
	Fri, 30 May 2025 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608926;
	bh=MortJCx6L3UCY/40doyLPQPqzHDtTmpZg2firvX0YZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDp5m5dCMbv1bgoNBGrZls5qTqtnAiMZ8jWcC9DyjaF37AVUpZ+mLVN5KprAfnx0i
	 VzMahnGMUx0wPdJkujlUZXcNGoIasBXXiiOnmN3eYJTTQbjMOdZcxCxPNJRLA/ZgFM
	 rupdKN2X+nWZ5N29VktIFl1XVwE3Jbi+ELyHMLutDam+cnWdGwlMvE879quKrPY2TE
	 ETBzElZgDhFo4Ek181V/ownvHxdRj9rgnvAIWK1nLvpgauCXkFP2oQyACF49ITHQbm
	 agMj4E5qYET6/gjpFZq+PhiR5nbhlXvuBmDqgzVWumwwNdLDd6wTiOmxczp7i71YBi
	 GFixB6sHtkwyA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ahmed Salem <x0rw3ll@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rjw@rjwysocki.net,
	lenb@kernel.org,
	robert.moore@intel.com,
	erik.schmauss@intel.com,
	linux-acpi@vger.kernel.org,
	devel@acpica.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/6] ACPICA: Avoid sequence overread in call to strncmp()
Date: Fri, 30 May 2025 08:41:59 -0400
Message-Id: <20250530124203.2577122-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124203.2577122-1-sashal@kernel.org>
References: <20250530124203.2577122-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index ff5fecff51167..f931312cf51a1 100644
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


