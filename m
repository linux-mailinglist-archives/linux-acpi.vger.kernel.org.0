Return-Path: <linux-acpi+bounces-16771-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A635B5575F
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D35175E54
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC33376BC;
	Fri, 12 Sep 2025 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdsDzi+B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D1833470A;
	Fri, 12 Sep 2025 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707600; cv=none; b=KgLSPo5ZkSK/UHwR4MnAcZpdwi6Bpl6H03zakDTLaqbVGg+czk0uU2/wzoJCn2yEFPo+IHWvZNlE21aR2fxAPef+essc4aQGFCy3YfEHW3jjNlCgETYLFYg6EOkwK8zgQ5iYPlg/FkvbH5IuKruhY7GZdPknxrUqPzH9NbiZdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707600; c=relaxed/simple;
	bh=nWogzhpEzBLFEYQIKQTtxHTp4y2Pt5Fko01GhFprUaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGJ/eNe3I/fadkkMsC23HnQi1fkDE37FgAkQ0cH3/lJJptdLONqSg35Yig27CAvA8+qAo6J4W1R6AkPFo02eZ7vkJ1XwW3yy3y5GUuOcBduilQPp4VODh1fed0fyjXHUlEqCFKtmvjmEQFEjiLFSdPFGo/4xBKeBngcl3DQQqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdsDzi+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD45EC4CEF9;
	Fri, 12 Sep 2025 20:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707600;
	bh=nWogzhpEzBLFEYQIKQTtxHTp4y2Pt5Fko01GhFprUaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdsDzi+BfsjxYBL9vuSKV9+KD46X55Z1eqy5qNj5drN82G+bCAIPOkf8xLlC0YTsd
	 EiLMHC+/uxq3KWtobZ9iywrY47eBBvbVR6C7t3JklzI2CxkBzDnpKBAXQN9Jp0jb3T
	 cH90j6nowM8QMQ02GPldseR2H6JB+bjY17WcpSPdwLUuWn/PBI4WlnnG37HvxgUb5X
	 +Zc5lri2mHITuWHse81u0J5EzpAohD+kmHNRzur3MtMrwGv0krtcfP+Pw0+OhxVw0V
	 K1HqirW2D3PrrfbjKAQZ+H0t1zIIWA+HL7ag97NlKQ3u6+WCLlK79WtnW3J8bxQ9uM
	 eMvaurWiqBpHQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 09/16] ACPICA: dispatcher: Use acpi_ds_clear_operands() in
 acpi_ds_call_control_method()
Date: Fri, 12 Sep 2025 22:00:17 +0200
Message-ID: <3848043.MHq7AAxBmi@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2021361.PYKUYFuaPT@rafael.j.wysocki>
References: <2021361.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Hans de Goede <hansg@kernel.org>

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
---
 drivers/acpi/acpica/dsmethod.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index fef6fb29ece4..e707a7036802 100644
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





