Return-Path: <linux-acpi+bounces-20229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8310D191E6
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 14:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 784773014BD6
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA503904EC;
	Tue, 13 Jan 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcAZXn31"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11838FF0B;
	Tue, 13 Jan 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311417; cv=none; b=R8lMCdOcBHMu69A6f2ohCJxlkCFxGrLMYwXlRaKuyksQ86tD127D3GIVgcB7oXUo4ZtmhDH7hrj7XosqNrXxg1UOGoXeSfi8Go3h96IDWKcAO4e5LCR3FXxVsjniPgxn9sAoD/vA77KuSxgKN5A3+F1ZOx7quXguHlXfb7BpyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311417; c=relaxed/simple;
	bh=IXvx5aXrBcUXshtJXld2okFqAwlbZa5hJRy3jy9dF+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nQmWoob8AmnFk05TThc3yXkP3wzN+occyiRhK6HL+TLDuEQMFtLExpDni7EvcdysZkaB54dKIbeOXZM2revn20bIcCTu36P4VdPiBmBpm/0VnKMooLUmHJ0mKAGjgXiqB1S6HVcEF3KEdlLjeMCNyfrnfYaFhxuWJhmXLdOo2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcAZXn31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CCCC16AAE;
	Tue, 13 Jan 2026 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768311417;
	bh=IXvx5aXrBcUXshtJXld2okFqAwlbZa5hJRy3jy9dF+w=;
	h=From:To:Cc:Subject:Date:From;
	b=tcAZXn31bkLBlcigInta1oir746tMWc6W1LBfKVnR3Y6CrzCBk72qV4vbD+6J62Ek
	 uhn3E2kveTtrVeQFNB2Dmnhtp4RBdtFXv2uECqGilwEig4Zs7yY3vMS98KYQMx7h95
	 DY150KkW33ZyWW9zEei24+RBcW4rzB6fRh7wyFigROeDjYcBS+FQvw2oZlG1vPddvt
	 78Bf6owUYSQxgqJlA8wUtq8f10mgxqQgVaMcbTeG0CpnB/yHwRmu5jWGEb2LQFtTC9
	 9Nou0d6TpmnDdC8lHdElzX+qdfwB88InhfZoqtCW+zt4DUkybmDjqrYsHnGlORInpP
	 K4qkExKffiJpA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1] ACPI: PM: s2idle: Add module parameter for LPS0 constraints
 checking
Date: Tue, 13 Jan 2026 14:36:54 +0100
Message-ID: <2827214.mvXUDI8C0e@rafael.j.wysocki>
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

Commit 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when
needed") attempted to avoid useless evaluation of LPS0 _DSM Function 1
in lps0_device_attach() because pm_debug_messages_on might never be set
(and that is the case on production systems most of the time), but it
turns out that LPS0 _DSM Function 1 is generally problematic on some
platforms and causes suspend issues to occur when pm_debug_messages_on
is set now.

In Linux, LPS0 _DSM Function 1 is only useful for diagnostics and only
in the cases when the system does not reach the deepest platform idle
state during suspend-to-idle for some reason.  If such diagnostics is
not necessary, evaluating it is a loss of time, so using it along with
the other pm_debug_messages_on diagnostics is questionable because the
latter is expected to be suitable for collecting debug information even
during production use of system suspend.

For this reason, add a module parameter called check_lps0_constraints
to control whether or not the list of LPS0 constraints will be checked
in acpi_s2idle_prepare_late_lps0() and so whether or not to evaluate
LPS0 _DSM Function 1 (once) in acpi_s2idle_begin_lps0().

Fixes: 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when needed")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/s2idle.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -28,6 +28,10 @@ static bool sleep_no_lps0 __read_mostly;
 module_param(sleep_no_lps0, bool, 0644);
 MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
 
+static bool check_lps0_constraints __read_mostly;
+module_param(check_lps0_constraints, bool, 0644);
+MODULE_PARM_DESC(check_lps0_constraints, "Check LPS0 device constraints");
+
 static const struct acpi_device_id lps0_device_ids[] = {
 	{"PNP0D80", },
 	{"", },
@@ -515,7 +519,7 @@ static struct acpi_scan_handler lps0_han
 
 static int acpi_s2idle_begin_lps0(void)
 {
-	if (lps0_device_handle && !sleep_no_lps0 && pm_debug_messages_on &&
+	if (lps0_device_handle && !sleep_no_lps0 && check_lps0_constraints &&
 	    !lpi_constraints_table) {
 		if (acpi_s2idle_vendor_amd())
 			lpi_device_get_constraints_amd();
@@ -540,7 +544,7 @@ static int acpi_s2idle_prepare_late_lps0
 	if (!lps0_device_handle || sleep_no_lps0)
 		return 0;
 
-	if (pm_debug_messages_on)
+	if (check_lps0_constraints)
 		lpi_check_constraints();
 
 	/* Screen off */




