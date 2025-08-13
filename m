Return-Path: <linux-acpi+bounces-15631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB005B24787
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 12:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69536681AAE
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D292F530B;
	Wed, 13 Aug 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNXckvA6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE572F0C47;
	Wed, 13 Aug 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081546; cv=none; b=Y4pwsSlSUDbjVQ/BMqgvi1vIl8+AD3Dbub/eGGSM7XNwys2kZS3pyGFomC/WpD6NLYu8voOilWZ84EsbQCPtXeCdeFgFhDXE+yzAHTtJTSPOpdQBza7VQT4MHv/jR0GHBr55UHgdX28BV14/oBR6+wR2q6T4bdYKYvH4Tk5bIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081546; c=relaxed/simple;
	bh=aXoBFKPVtOLDSWQLuAWRKFBkuFwU5jnleTaoiI3kTS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CTu3KTb6NOBvI4Hg1IOOBHWxAMwpL5Ve4gWhOOdlBFArpOjw5cDB6nDzEcnROH/3e7PNh3nzJucKzAwm8T3EiSv40glTx4DHLH01K/2uflrJNEtcBF4vovlnmw3tYke7L4Vl1Q9a7fj/4QMcqz7OnS5cd4L0BFy7tbIPqc36CiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNXckvA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9E3C4CEEB;
	Wed, 13 Aug 2025 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755081546;
	bh=aXoBFKPVtOLDSWQLuAWRKFBkuFwU5jnleTaoiI3kTS0=;
	h=From:To:Cc:Subject:Date:From;
	b=LNXckvA6e3lIz9Q5Um9v6u260QtFN3sj2/AXIlsiTs5cnZTIalABRpobZMw/t2bB+
	 p4VMFl/C4llF1w1gQK0N6kefQUuvbqIlPY5pkbAieJCiFx7U7kymbHP2ay7sc8sfhY
	 Wz53QTaWgaDhUgAlxWPhngCj5x2bHnIfv5dzGJRDADWg2bMiKabTwJ68j/0zoxQm/+
	 Renj5H50OsdwbMkDJyS92p7InEyhlf7BvlYYhwtWOyWjgDXhAtpzomFi2aeMv+WwV7
	 Mmqw3KHCMt8evfH5b8Ug1ImyxzPh/uOFNPgqFmJ+7eDIb3WuGUrW90ctoSq2VZEilk
	 gEBYopnMQK9eQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject:
 [PATCH v1] ACPI: processor: idle: Eliminate static variable flat_state_cnt
Date: Wed, 13 Aug 2025 12:38:58 +0200
Message-ID: <10715991.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of using static variable flat_state_cnt to pass data between
functions involved in the _LPI information processing, pass the current
number of "flattened" idle states to flatten_lpi_states() and make it
return the updated number of those states.  At the same time, use a
local variable called state_count to store the number of "flattened"
idle states found so far in acpi_processor_get_lpi_info().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -998,11 +998,6 @@
 	return ret;
 }
 
-/*
- * flat_state_cnt - the number of composite LPI states after the process of flattening
- */
-static int flat_state_cnt;
-
 /**
  * combine_lpi_states - combine local and parent LPI states to form a composite LPI state
  *
@@ -1045,9 +1040,10 @@
 	curr_level->composite_states[curr_level->composite_states_size++] = t;
 }
 
-static int flatten_lpi_states(struct acpi_processor *pr,
-			      struct acpi_lpi_states_array *curr_level,
-			      struct acpi_lpi_states_array *prev_level)
+static unsigned int flatten_lpi_states(struct acpi_processor *pr,
+				       unsigned int flat_state_cnt,
+				       struct acpi_lpi_states_array *curr_level,
+				       struct acpi_lpi_states_array *prev_level)
 {
 	int i, j, state_count = curr_level->size;
 	struct acpi_lpi_state *p, *t = curr_level->entries;
@@ -1087,7 +1083,7 @@
 	}
 
 	kfree(curr_level->entries);
-	return 0;
+	return flat_state_cnt;
 }
 
 int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
@@ -1102,6 +1098,7 @@
 	acpi_handle handle = pr->handle, pr_ahandle;
 	struct acpi_device *d = NULL;
 	struct acpi_lpi_states_array info[2], *tmp, *prev, *curr;
+	unsigned int state_count;
 
 	/* make sure our architecture has support */
 	ret = acpi_processor_ffh_lpi_probe(pr->id);
@@ -1114,14 +1111,13 @@
 	if (!acpi_has_method(handle, "_LPI"))
 		return -EINVAL;
 
-	flat_state_cnt = 0;
 	prev = &info[0];
 	curr = &info[1];
 	handle = pr->handle;
 	ret = acpi_processor_evaluate_lpi(handle, prev);
 	if (ret)
 		return ret;
-	flatten_lpi_states(pr, prev, NULL);
+	state_count = flatten_lpi_states(pr, 0, prev, NULL);
 
 	status = acpi_get_parent(handle, &pr_ahandle);
 	while (ACPI_SUCCESS(status)) {
@@ -1143,18 +1139,19 @@
 			break;
 
 		/* flatten all the LPI states in this level of hierarchy */
-		flatten_lpi_states(pr, curr, prev);
+		state_count = flatten_lpi_states(pr, state_count, curr, prev);
 
 		tmp = prev, prev = curr, curr = tmp;
 
 		status = acpi_get_parent(handle, &pr_ahandle);
 	}
 
-	pr->power.count = flat_state_cnt;
 	/* reset the index after flattening */
-	for (i = 0; i < pr->power.count; i++)
+	for (i = 0; i < state_count; i++)
 		pr->power.lpi_states[i].index = i;
 
+	pr->power.count = state_count;
+
 	/* Tell driver that _LPI is supported. */
 	pr->flags.has_lpi = 1;
 	pr->flags.power = 1;




