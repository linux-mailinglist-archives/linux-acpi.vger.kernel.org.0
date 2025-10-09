Return-Path: <linux-acpi+bounces-17680-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EEDBC9EBC
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAEFC354274
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3412ECD34;
	Thu,  9 Oct 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZQT2jSY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E6220F2C;
	Thu,  9 Oct 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025488; cv=none; b=PIsgoa1yNbL5gKb8Ao3HLWfJeU3xK3EYw3vLIap3ZgoeyT2S0i47zHbwNmzWBwqMjllaAXvxl4CN93N/hlZv+dfVc1MFdRqTi6xUyCQJL6S9Wuqpnel7S67yG1DUMMFVRYcMxiCKh+RP27ZFbMacic8pJiQ3LR2N69jsLRps2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025488; c=relaxed/simple;
	bh=6vkLwtVEp5iZ/fddGeer+JB26ijRhHCLJZ0FnDiFV8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgOFpBac3KZSRU0qVyDyXyWuZjnMJECBnAnCWnlWyoDnQHh7jFSOdxLRaDlaisflshq+JSuJse5ZIsMLD+gDIpyZAtQ7ZLSdNeocQ+FKr87bBeZJxcfDl7fFrA5isU5R4TAYs3kgvCOeTYDZtJSSbSnXIQtj49Jw54DKd+FsMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZQT2jSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38998C4CEE7;
	Thu,  9 Oct 2025 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025487;
	bh=6vkLwtVEp5iZ/fddGeer+JB26ijRhHCLJZ0FnDiFV8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZQT2jSY/8MM17nbyGSvHdSUr9rh4M89+k31Rc9chfmwWdaiuHsmNCXmt41lSgk7f
	 eY6bfz8tAK3S7+ewWHWkvRhFUrp8sBElQYqjURUFBkj3R5A5hX4o3U3YgWjX0SrA+O
	 vHVYPP+A5lpKabbypSUi5jW3nSbz9Fbz3Yf2y8/s9/N/rdaRsqDNY+eAFV9TMkwBhz
	 uGaxXhQIRqATxOmYp4569byvWyguytAe/r62iUEKFVghujOHBE/kiUdrCxaTOIJWt6
	 o2yKpSdtbzbR9eGzmIaZo4LeC6Gau13oA159rwqBfXJfk1M4WZr6ZJO//zoeTqOaUg
	 ozuBOjtu6QyEw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.17-5.4] ACPICA: dispatcher: Use acpi_ds_clear_operands() in acpi_ds_call_control_method()
Date: Thu,  9 Oct 2025 11:54:36 -0400
Message-ID: <20251009155752.773732-10-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hansg@kernel.org>

[ Upstream commit e9dff11a7a50fcef23fe3e8314fafae6d5641826 ]

When deleting the previous walkstate operand stack
acpi_ds_call_control_method() was deleting obj_desc->Method.param_count
operands. But Method.param_count does not necessarily match
this_walk_state->num_operands, it may be either less or more.

After correcting the for loop to check `i < this_walk_state->num_operands`
the code is identical to acpi_ds_clear_operands(), so just outright
replace the code with acpi_ds_clear_operands() to fix this.

Link: https://github.com/acpica/acpica/commit/53fc0220
Signed-off-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- Current cleanup in `drivers/acpi/acpica/dsmethod.c:517` and
  `drivers/acpi/acpica/dsmethod.c:549` only drops
  `obj_desc->method.param_count` operands after a call, so when firmware
  supplies extra arguments the additional entries in
  `this_walk_state->operands[]` keep their references alive even though
  `num_operands` is reset—this leaks AML temporaries and can strand
  namespace refs on every invocation.
- The call path copies every resolved operand up to the NULL terminator
  into the callee (`drivers/acpi/acpica/dsmthdat.c:175`), and ACPICA
  already anticipates AML that passes too many parameters
  (`drivers/acpi/acpica/nsarguments.c:222`-`245`), so the leak is
  triggered by real-world firmware and grows with each mis-specified
  call.
- Replacing the open-coded loop with
  `acpi_ds_clear_operands(this_walk_state)` uses the existing helper
  that already removes all `num_operands` entries
  (`drivers/acpi/acpica/dsutils.c:383`-`400`) and matches the cleanup
  used in other dispatcher paths
  (`drivers/acpi/acpica/dswexec.c:440`-`452`); git history shows the
  buggy pattern has existed since the original ACPICA import, so the fix
  is self-contained and low risk for all supported branches.

Next step: queue this patch for the stable ACPICA backport stream so
kernels inheriting the long-standing leak can be corrected.

 drivers/acpi/acpica/dsmethod.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index fef6fb29ece4d..e707a70368026 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -546,14 +546,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 	 * Delete the operands on the previous walkstate operand stack
 	 * (they were copied to new objects)
 	 */
-	for (i = 0; i < obj_desc->method.param_count; i++) {
-		acpi_ut_remove_reference(this_walk_state->operands[i]);
-		this_walk_state->operands[i] = NULL;
-	}
-
-	/* Clear the operand stack */
-
-	this_walk_state->num_operands = 0;
+	acpi_ds_clear_operands(this_walk_state);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 			  "**** Begin nested execution of [%4.4s] **** WalkState=%p\n",
-- 
2.51.0


