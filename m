Return-Path: <linux-acpi+bounces-14050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C4ACA48C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 02:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFD8188BD51
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 00:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6B299922;
	Sun,  1 Jun 2025 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3OeDJJL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66D2676D3;
	Sun,  1 Jun 2025 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820820; cv=none; b=r5G/ObC9mwT09svyMg6C2LJEneqlA1Jr7wV9FbIEEvrLi044z/CEb+qc1N9MPBhTfoqM5ZvLj/CcDW+PvRJvYg0DsXVDQ1wVmE7GpdI4dBhbf+Ty9+jfO37AZ/MaPOwHJ0uSSpuxlK3Nl6qaphAiXoM2+OBKw4QqBonA3dtZzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820820; c=relaxed/simple;
	bh=XRHEWhgqj6nLkAZAodbWHQagGGUd+jA0JtzRnx1/B6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/6AUpGRu/uFFIJjrimbWoBVqbA4RgcfTyUbB4yeXb3beCsy3EbnltV1q3bt8T6vuyuMxfu1drhmIdR8aPbv0enMhRPF66nqy1TftkNkcv8uwd04NfjlSQuMFz7/KTduCP1NgylfJlrpcyWPAl/PN0X01ikLLO8VB+yEmMeuZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3OeDJJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A92C4CEEE;
	Sun,  1 Jun 2025 23:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820820;
	bh=XRHEWhgqj6nLkAZAodbWHQagGGUd+jA0JtzRnx1/B6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F3OeDJJLN1/5Sf4e0Ugz5xS9mXGGXmaEZQRJLBLiTKtq3/hb9+QqIsVA96pTVJFx7
	 oDRrDE/zO36rdSvEMMuQ+PnHwyy5wTVCbYva6xduNPnsXRnbTyUxubhYS/sTEt9kwL
	 1wAE28bIdY6TrHv69RAxhwGn10jvn5m391j2WCL+k36hHrZnKYopmQGGuRMr5brh72
	 3LMtBcDEBxZ5a8rKSc+XbPOzcw7Gu0e55r7/KoJ7Fe0DYTQhpLV21mK5Xe1Hb4lPJ0
	 7RoZH+pHRq25RGgHaDun1TzSZ1q7vxt+SvZewzxegrhYn4BF9wXSTpSOgPNk6G1788
	 feaFPuRZc2PTA==
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
Subject: [PATCH AUTOSEL 6.14 091/102] ACPICA: Avoid sequence overread in call to strncmp()
Date: Sun,  1 Jun 2025 19:29:23 -0400
Message-Id: <20250601232937.3510379-91-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
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
index 80767e8bf3ad4..d323dfffa4bfc 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -527,7 +527,7 @@ typedef u64 acpi_integer;
 
 /* Support for the special RSDP signature (8 characters) */
 
-#define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, 8))
+#define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
 #define ACPI_MAKE_RSDP_SIG(dest)        (memcpy (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))
 
 /* Support for OEMx signature (x can be any character) */
-- 
2.39.5


