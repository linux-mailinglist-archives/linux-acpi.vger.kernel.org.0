Return-Path: <linux-acpi+bounces-14515-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8C7AE5B5F
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 06:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A511BC261A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 04:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BC62550A3;
	Tue, 24 Jun 2025 04:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFs8X1Ic"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024F254B09;
	Tue, 24 Jun 2025 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738392; cv=none; b=iAfEMzH8eD/PVqUb6Y6udvFGorX9IRNYZeOsMnBOvmAqCtUZ6QIBQgS8uTvhG0yNJKPWE/F69iKN52lgsvtRi/LTDRdeIReyJSVe6rKFQBnHqaLr4YJsqKivSKj8JHe2IROYja2022BQ9rGEDCFUCsiST74T6wWewz0mIFBV9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738392; c=relaxed/simple;
	bh=z8RoNipoxt+hGp68bWV6ktZ0Z8Nsug9Dhl+xVDY3zW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1xIqjpdWjH/9dz+b5FTgfdTTwliJgZjRejIjRz37WgG16VIp2t0zwkPx4I58VEy7p/edAaq2DDfm3HbPPCUN1n+wGZClo+Phv+hfeQaU9aM00wYeAIjvEeYJEFd5TeXAlJIr6i7Vf5+63jI0yecqyghaXdG1J+PjDBVpLiWTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFs8X1Ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28486C4CEE3;
	Tue, 24 Jun 2025 04:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750738391;
	bh=z8RoNipoxt+hGp68bWV6ktZ0Z8Nsug9Dhl+xVDY3zW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFs8X1IcJqXIjZrZ1enHiGul1SvLmusNdU6IwvYbMAtXs8y1ZCZH16CzH5kvz1YXt
	 MROSZoOHp9jgKYnrJDkG/8+wMe+BfSv2u3DHpvuU4abY5KliXmTbf8V0JC7iz83SCP
	 NyymBRIT8ZPnY8oc886DJYpjXNPb7TOCCxH/wwTnmK/DFxzNYtXI+3e8LP1EjKtAwl
	 vAIIpgJrpt2zkKTC1gg16fpkGOJvRvQ5qGNYM7bqV81I3jsiEm0rP70SoV68UwYvSE
	 PzuDRlxymAuRb23z2mYi67DF+Ts0VwVwNFaobEsMZeuEH25Sa9DfAi4iazaLmaeoCR
	 klzv+XS1r4rTA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Williams <peter@newton.cx>,
	Hans de Goede <hansg@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 09/11] ACPICA: Refuse to evaluate a method if arguments are missing
Date: Tue, 24 Jun 2025 00:12:57 -0400
Message-Id: <20250624041259.84940-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624041259.84940-1-sashal@kernel.org>
References: <20250624041259.84940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.185
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 6fcab2791543924d438e7fa49276d0998b0a069f ]

As reported in [1], a platform firmware update that increased the number
of method parameters and forgot to update a least one of its callers,
caused ACPICA to crash due to use-after-free.

Since this a result of a clear AML issue that arguably cannot be fixed
up by the interpreter (it cannot produce missing data out of thin air),
address it by making ACPICA refuse to evaluate a method if the caller
attempts to pass fewer arguments than expected to it.

Closes: https://github.com/acpica/acpica/issues/1027 [1]
Reported-by: Peter Williams <peter@newton.cx>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Tested-by: Hans de Goede <hansg@kernel.org> # Dell XPS 9640 with BIOS 1.12.0
Link: https://patch.msgid.link/5909446.DvuYhMxLoT@rjwysocki.net
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Key Reasons for Backporting:

### 1. **Critical Security Bug - Use-After-Free**
The commit message explicitly states this fixes a use-after-free
vulnerability that causes ACPICA to crash. Use-after-free bugs are
severe security issues that can lead to:
- System crashes and denial of service
- Potential arbitrary code execution
- Memory corruption

### 2. **Real-World Impact**
The commit references an actual bug report with a specific
hardware/firmware scenario:
- Platform firmware update increased method parameters
- Firmware forgot to update at least one caller
- This caused a real crash on actual hardware (Dell XPS 9640 with BIOS
  1.12.0)
- The bug has been reported, tested, and verified by multiple people

### 3. **Small, Focused Fix**
The code change is minimal and surgical:
```c
+       if (this_walk_state->num_operands <
obj_desc->method.param_count) {
+               ACPI_ERROR((AE_INFO, "Missing argument for method
[%4.4s]",
+                           acpi_ut_get_node_name(method_node)));
+
+               return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
+       }
```
This adds a simple bounds check before method execution, which is
exactly the type of defensive programming that should be in stable
kernels.

### 4. **Prevents Memory Corruption**
Looking at the surrounding code (specifically line 542 in the original):
```c
for (i = 0; i < obj_desc->method.param_count; i++) {
    acpi_ut_remove_reference(this_walk_state->operands[i]);
    this_walk_state->operands[i] = NULL;
}
```
Without the check, if `num_operands < param_count`, this loop would
access beyond the valid operands, causing use-after-free.

### 5. **Clear Error Handling**
The fix properly returns `AE_AML_UNINITIALIZED_ARG`, which is an
existing ACPICA error code specifically designed for this scenario
("Method tried to use an uninitialized argument"). This maintains API
compatibility.

### 6. **No Architectural Changes**
The commit:
- Doesn't introduce new features
- Doesn't change existing behavior for valid code
- Only adds validation to prevent crashes from invalid AML
- Is confined to the ACPICA subsystem

### 7. **Firmware Bug Mitigation**
This is a defensive fix against firmware bugs, which is exactly the type
of robustness stable kernels need. The kernel should not crash due to
firmware mistakes.

## Comparison with Similar Commits:

Unlike the similar commits shown (which were mostly about improving
error messages or cosmetic changes), this commit:
- Fixes an actual crash/security issue
- Has been reported and tested on real hardware
- Prevents memory corruption
- Is not just a theoretical improvement

This aligns perfectly with stable kernel rules: important bug fixes with
minimal risk that improve system stability and security.

 drivers/acpi/acpica/dsmethod.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index ee1832ba39a24..132ab74935be8 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -483,6 +483,13 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 		return_ACPI_STATUS(AE_NULL_OBJECT);
 	}
 
+	if (this_walk_state->num_operands < obj_desc->method.param_count) {
+		ACPI_ERROR((AE_INFO, "Missing argument for method [%4.4s]",
+			    acpi_ut_get_node_name(method_node)));
+
+		return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
+	}
+
 	/* Init for new method, possibly wait on method mutex */
 
 	status =
-- 
2.39.5


