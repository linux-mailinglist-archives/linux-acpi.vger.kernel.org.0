Return-Path: <linux-acpi+bounces-14070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4BACA7E6
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 03:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4239188741E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB233E431;
	Sun,  1 Jun 2025 23:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhHEbQ6m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671CA33E429;
	Sun,  1 Jun 2025 23:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821563; cv=none; b=ZpPTtqSvbpIvZQKe+XsqZ0Dxm6ofap+RJOYB6WL5VqtAUAZ4jBf7lPANFAKy1FEvgKI7UK32H7pb0OJb+OCkRMos0kHazDgcm86T/91HXdWAEe7Iv0sHvtdbuZIvBSoBCYgLmqgWwfpuwJZlarObINblp+Sb8NNDUKwbvJmj49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821563; c=relaxed/simple;
	bh=0SoWlbox1O5Ztxhv2TBlipSHvtog3stqQrMWmt265T8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MFiYfYUp+KN0VND3Z5GBy1hL64/mmC3K/IzA2uM+Dz5KG15vSGmYqxP4O31W/DbiRfBEZ3gRiqOUhVO2nSve7bhTbfSaemXkNaIc7NPk92rvn3fZ06pnc8oYVa1TodrW3oSqLSVT2exy3VpdvEaZ+h88KfWyCwP8pG/H5ELlmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhHEbQ6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322C3C4CEEE;
	Sun,  1 Jun 2025 23:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821563;
	bh=0SoWlbox1O5Ztxhv2TBlipSHvtog3stqQrMWmt265T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhHEbQ6m+xXqkasjP3Vnums1EcWglOYOgF9fcRLxofEwrqunKKD7MV+zY55ay1UnC
	 FWhNzARQyRmDkPXUiC2F6gkRubLRZJ6rebW43GLNNEFW3WivGbdatb3tTJgScTBC+f
	 8FWQqlPYRsu387WsKddQO7ywKdL65wztn6zxzYMSQjb1vYY7/x0A6khrkjBK4GsHPO
	 t/GMg8W8tnfV59czxQc7Na3Pa7nBGOG40Kdsj/kl0g728xRYkShVHmx6OFESWQ5EYM
	 c+ulm/gwhH7dYtvGJVWnk8JsLYzTCb468Oun6lEm+pRKAmOpYSAIigRp8eTP4Kf9/m
	 ndVPYha2izbGg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ahmed Salem <x0rw3ll@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 20/22] ACPICA: Avoid sequence overread in call to strncmp()
Date: Sun,  1 Jun 2025 19:45:11 -0400
Message-Id: <20250601234515.3519309-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234515.3519309-1-sashal@kernel.org>
References: <20250601234515.3519309-1-sashal@kernel.org>
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

Now I understand the issue! Let me analyze the problem: **Analysis:**
**YES** - This commit should be backported to stable kernel trees. ##
Detailed Analysis: ### The Problem: The commit fixes a **buffer overread
vulnerability** in the `ACPI_VALIDATE_RSDP_SIG` macro. The issue occurs
when: 1. `ap_is_valid_header()` accepts a `struct acpi_table_header
*table` parameter 2. `struct acpi_table_header` has a `signature` field
that is only **4 bytes** (`char signature[ACPI_NAMESEG_SIZE]` where
`ACPI_NAMESEG_SIZE = 4`) 3. The original `ACPI_VALIDATE_RSDP_SIG(a)`
macro calls `strncmp(a, ACPI_SIG_RSDP, 8)` - comparing **8 bytes** 4.
When `table->signature` (4 bytes) is passed to this macro, `strncmp`
reads **beyond the bounds** of the signature field, causing a buffer
overread ### The Fix: The new macro implementation: ```c #define
ACPI_VALIDATE_RSDP_SIG(a) (!strncmp (ACPI_CAST_PTR (char, (a)),
ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8)) ``` This
intelligently chooses the comparison length: - If `sizeof(a) < 8`, it
uses `ACPI_NAMESEG_SIZE` (4 bytes) - Otherwise, it uses the full 8 bytes
for legitimate RSDP signatures ### Why This Should Be Backported: 1.
**Security Issue**: This is a buffer overread that could potentially
lead to information disclosure or memory corruption 2. **Minimal Risk**:
The change is a small, surgical fix to a macro with clear logic 3.
**Wide Impact**: The macro is used in multiple places including: -
Kernel ACPI subsystem (`drivers/acpi/acpica/tbprint.c`, `tbxfroot.c`) -
Boot code (`arch/x86/boot/compressed/acpi.c`) - ACPI tools (userspace
tools) 4. **Compiler Warnings**: This likely fixes `-Wstringop-overread`
compiler warnings, improving code quality 5. **No Functional Change**:
The fix maintains the same intended behavior while preventing the
overread 6. **Follows Stable Rules**: This is exactly the type of
important bugfix that stable trees are meant to include ### Similar
Commit Precedent: Similar commit #3 (Status: YES) shows that ACPI
compilation warning fixes have been backported before, and this is a
more serious issue (actual buffer overread vs. just truncation
warnings). The fix addresses a real memory safety issue in a fundamental
ACPI macro used throughout the kernel, making it an excellent candidate
for stable backporting.

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


