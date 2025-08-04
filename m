Return-Path: <linux-acpi+bounces-15504-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E8B19967
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 02:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E863F3BB840
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 00:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D419F461;
	Mon,  4 Aug 2025 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1njtAsc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784E1D555;
	Mon,  4 Aug 2025 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267976; cv=none; b=JiC0VgrRoRPVZnqrr1bfZOv+k4GM8xu5wbjIEo/ozFs/tL4ETcbUeE7k/+21rOQcjdRdyQbNT8Jy9PGbPGiH5ao9VVTifZ4HtqAL/tyoNgAVlK+K1Rv0DfN1LcNIIwMwG6sOt9+I+xdSlcd0xmuVFqtSwsTKBHx5pNOjvDoB+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267976; c=relaxed/simple;
	bh=5fT2R4pTTADu3dHSazqtQcTZ50GGTqQePYe5IJhbyo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rX4F3kqFm3fIhS9f9rgH8s+NtkLC1vAQKrdeIGctIz+RKyFfvUNp+w/O0Cc7tRxkkZ3vujasOCA98xkCsC3Jx4WDqFFeqG/zFsQzBpDgnM9SUFIe4h6Or5ciUNb6OxojkYDmLYZhPnrIglotb8aY6RzVh5Q04sqI+oUv8vFshO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1njtAsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5037DC4CEF8;
	Mon,  4 Aug 2025 00:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267976;
	bh=5fT2R4pTTADu3dHSazqtQcTZ50GGTqQePYe5IJhbyo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1njtAsc7sARMVRTq2nqkARK5hz2U76uy7eCFCMpZlGC7aRMtbp6QafyaTdnDS5i1
	 qrA4Hb7+JjQ2aSz1A7Qy3mx15gg3t7VM8a2+P5/dcB8kAhIin1x+jDkLyakg4oqyfS
	 BTV1M3KHCNdUp+kBkO8a5lZ+BkQFTgYCtGNe4dh1UoOTLIwbPLLCpaxPEyPxqObl9a
	 6DJgDVorpkl3yUAD+v1YTAoJRHmXrno5e56GTfVmE1mV540nKIpPZi7N8ujWKEy92V
	 iOP25Re76HNut0Jc6BHdyec7qXG301J0TOb/lLcZO5B9kBGJnHMnXoNxrFe+lxwyQQ
	 TTlICwQHSV7JQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhu Qiyu <qiyuzhu2@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 20/44] ACPI: PRM: Reduce unnecessary printing to avoid user confusion
Date: Sun,  3 Aug 2025 20:38:25 -0400
Message-Id: <20250804003849.3627024-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003849.3627024-1-sashal@kernel.org>
References: <20250804003849.3627024-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.189
Content-Transfer-Encoding: 8bit

From: Zhu Qiyu <qiyuzhu2@amd.com>

[ Upstream commit 3db5648c4d608b5483470efc1da9780b081242dd ]

Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
handler and context") introduced non-essential printing "Failed to find
VA for GUID: xxxx, PA: 0x0" which may confuse users to think that
something wrong is going on while it is not the case.

According to the PRM Spec Section 4.1.2 [1], both static data buffer
address and ACPI parameter buffer address may be NULL if they are not
needed, so there is no need to print out the "Failed to find VA ... "
in those cases.

Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf # [1]
Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>
Link: https://patch.msgid.link/20250704014104.82524-1-qiyuzhu2@amd.com
[ rjw: Edits in new comments, subject and changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

## Bug Fix for User-Visible Issue
The commit fixes false warning messages that were confusing users. The
original commit 088984c8d54c (which was already backported to stable
with "Cc: All applicable <stable@vger.kernel.org>") introduced an
unconditional warning in `efi_pa_va_lookup()`:

```c
pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
```

This warning was printed even when the physical address (PA) was
legitimately 0/NULL, which according to the PRM specification is valid
for both `static_data_buffer_address` and `acpi_param_buffer_address`
when they are not needed.

## Small and Contained Fix
The fix is minimal and surgical:
1. Removes the unconditional warning from `efi_pa_va_lookup()`
2. Adds conditional warnings only when addresses are non-zero but lookup
   fails:
   - For handler_addr: warns if lookup fails (this should never be zero)
   - For static_data_buffer_addr: only warns if
     `handler_info->static_data_buffer_address` is non-zero but lookup
     fails
   - For acpi_param_buffer_addr: only warns if
     `handler_info->acpi_param_buffer_address` is non-zero but lookup
     fails

## Regression Fix
Since the problematic commit 088984c8d54c has been backported to v6.12
stable kernels, this fix addresses a regression in stable trees where
users are seeing confusing warning messages for legitimate NULL
addresses.

## Low Risk
The change:
- Does not modify any functional behavior
- Only adjusts when warning messages are printed
- Has no architectural changes or side effects
- Is confined to the ACPI PRM subsystem

## Clear Benefit
The fix eliminates user confusion from false warnings while maintaining
proper warnings for actual error conditions (when a non-zero address
fails lookup).

Given that the original problematic commit is in stable kernels and this
is a targeted fix for that regression with minimal risk, it clearly
meets the stable backporting criteria.

 drivers/acpi/prmt.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 890c74c52beb..6290ed84c595 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -85,8 +85,6 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 		}
 	}
 
-	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
-
 	return 0;
 }
 
@@ -142,13 +140,37 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
 		th->handler_addr =
 			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
+		/*
+		 * Print a warning message if handler_addr is zero which is not expected to
+		 * ever happen.
+		 */
+		if (unlikely(!th->handler_addr))
+			pr_warn("Failed to find VA of handler for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->handler_address);
 
 		th->static_data_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+		/*
+		 * According to the PRM specification, static_data_buffer_address can be zero,
+		 * so avoid printing a warning message in that case.  Otherwise, if the
+		 * return value of efi_pa_va_lookup() is zero, print the message.
+		 */
+		if (unlikely(!th->static_data_buffer_addr && handler_info->static_data_buffer_address))
+			pr_warn("Failed to find VA of static data buffer for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->static_data_buffer_address);
 
 		th->acpi_param_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
 
+		/*
+		 * According to the PRM specification, acpi_param_buffer_address can be zero,
+		 * so avoid printing a warning message in that case.  Otherwise, if the
+		 * return value of efi_pa_va_lookup() is zero, print the message.
+		 */
+		if (unlikely(!th->acpi_param_buffer_addr && handler_info->acpi_param_buffer_address))
+			pr_warn("Failed to find VA of acpi param buffer for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->acpi_param_buffer_address);
+
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;
-- 
2.39.5


