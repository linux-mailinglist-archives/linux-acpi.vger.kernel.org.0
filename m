Return-Path: <linux-acpi+bounces-14511-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B80AAE5AE4
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 06:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B227D446881
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 04:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2422B59D;
	Tue, 24 Jun 2025 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMDE6AkR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F84221DB9;
	Tue, 24 Jun 2025 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738305; cv=none; b=m6ZUaW9w+7oXXQJbLvnY2ajox216vB+JjpSeHY9I2LMFaxSlx9SF9OErtBRgJ3bKzKfmdLynd4nL9dXkoCYTbW3ja3TiMfPiLisoAKFW9uhNcbhwHhBbpc5saUN0pnlcOM6HBvm3L6/FDxIY06OrR/pnn4hk2Qhf8AMKmpIHXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738305; c=relaxed/simple;
	bh=Kf71vhcrmq8fE3Zkm3PfO/mFyGND7bBMzabvYo515e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TBG12U7ZOmL2giYl63nrteM+d/4jT8ww8o6/O7ZqCQjXmb9c0rpdNlMOCGpsAQibE1k/zaephK3sPkqhBsHdhopVtv/8PwwSDyqHzW5elomi2e5DsxsEnu6JdLyBqN2E4Sc5Pv2Iq8xZF4R8+wEwJhl+jUOuW8s843cavw+Uu7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMDE6AkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51912C4CEF0;
	Tue, 24 Jun 2025 04:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750738304;
	bh=Kf71vhcrmq8fE3Zkm3PfO/mFyGND7bBMzabvYo515e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMDE6AkRSGuA89dvyUuJW9XqvHw5uXZbQ8/AObfyPE/TYltWwy7V6s7fOUrLY+fhf
	 T9n/Dv8pgxtUWpGB5X0VbxxkTiCU+kZEhXZOEEcAou6pbAL9c8u1pmo1TextL1FHjb
	 fz+TK6MKZ7z6JujgT5sU+WSjUH/DEbjNrhio3IRP32df8tx6hyE0hvpbu/RH0YMsRY
	 Ilm+4jyDYgTSlyuSt93JOARP9vhTnlYiL37SEiUXR9kQuGHCJVXcqQK+A9iMPo9ASD
	 gOwSHX90FgR5IQWxe4SEivMY7uqcjtaRTWgbTHWXXrQjLask0/T3yu4uoZeP+K1dAh
	 Au3N6wYzuemnA==
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
Subject: [PATCH AUTOSEL 6.15 18/20] ACPICA: Refuse to evaluate a method if arguments are missing
Date: Tue, 24 Jun 2025 00:11:17 -0400
Message-Id: <20250624041120.83191-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624041120.83191-1-sashal@kernel.org>
References: <20250624041120.83191-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.3
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
index e809c2aed78ae..a232746d150a7 100644
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


