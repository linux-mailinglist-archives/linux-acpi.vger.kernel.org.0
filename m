Return-Path: <linux-acpi+bounces-15603-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F2B227C1
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD95756739C
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E338D27876E;
	Tue, 12 Aug 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqOjisd/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C4277009;
	Tue, 12 Aug 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003436; cv=none; b=IBa2T+YeBtFlx7wvO3dBh2BtpSlykt8rOQ/wCLqVMxTupTlJbQc9DMUIHk1yKeam/N3FPJTjtOgIVgvrH1Pc8xqLpWhSm3wHaAtg/O7XD613R+6eX3qSBtmHYQhaeb9Mq5rHlzq90CqKZqyn6ooPO8igmNmuqKJ9Kad1ta8H4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003436; c=relaxed/simple;
	bh=aaXUK4iUjo0o36xAlS2K6590asc4FE0myOp8eDO8tVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SeEWF19u+gqJ4GqbDQ1Yl+HyJ62OB/PewjUrrE7umagQ4Wk5+BFhvxO1MgU5eKbYKmzcrQzLm2YvBALhd+U+XboSa8hZ2Wdw9bdnyhtUMKZgQFXiO36V8YDlwEn79X6R3SLu77el7v1jGFCgTld8BEtKfcRdN0xvkkG627q7DOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqOjisd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CECC4CEF0;
	Tue, 12 Aug 2025 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755003436;
	bh=aaXUK4iUjo0o36xAlS2K6590asc4FE0myOp8eDO8tVE=;
	h=From:To:Cc:Subject:Date:From;
	b=CqOjisd/OnDMEhnSDOpVbXb66W3Mf/QqkZSbqKMlPuT3BShvsHJx+60WFb+hj0q/w
	 3bFvYVhmLeUIAs6vWIHrkiVLMVUqdciK6b+UnfWR5SGCdJ+NGCfSYdzAgtYgrHkYzR
	 PKCXi88yz7Yrce1iUES0a8ziozIrhfxNA0IE4d1zWg6OyKX9gxgwKU8zvjGndFtRcD
	 o/23/lvD5NawDKbe2MFxNz+qfpJ+/PFEp3SJfpLz3gNKvGVl1JegKzGwGlW8+nL7Gl
	 eQntFWRCfwRU/69Rc7USB92hdfNcK6vgedjJEoTDRltMKM7QYJuzOghAjXL+P1ukYN
	 CKiN/6i3UT4JA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Jiayi Li <lijiayi@kylinos.cn>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1] ACPI: processor: perflib: Move problematic pr->performance check
Date: Tue, 12 Aug 2025 14:57:06 +0200
Message-ID: <2801421.mvXUDI8C0e@rafael.j.wysocki>
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

Commit d33bd88ac0eb ("ACPI: processor: perflib: Fix initial _PPC limit
application") added a pr->performance check that prevents the frequency
QoS request from being added when the given processor has no performance
object.  Unfortunately, this causes a WARN() in freq_qos_remove_request()
to trigger on an attempt to take the given CPU offline later because the
frequency QoS object has not been added for it due to the missing
performance object.

Address this by moving the pr->performance check before calling
acpi_processor_get_platform_limit() so it only prevents a limit from
being set for the CPU if the performance object is not present.  This
way, the frequency QoS request is added as it was before the above
commit and it is present all the time along with the CPU's cpufreq
policy regardless of whether or not the CPU is online.

Fixes: d33bd88ac0eb ("ACPI: processor: perflib: Fix initial _PPC limit application")
Tested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_perflib.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -180,7 +180,7 @@
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 		int ret;
 
-		if (!pr || !pr->performance)
+		if (!pr)
 			continue;
 
 		/*
@@ -197,6 +197,9 @@
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
 
+		if (!pr->performance)
+			continue;
+
 		ret = acpi_processor_get_platform_limit(pr);
 		if (ret)
 			pr_err("Failed to update freq constraint for CPU%d (%d)\n",




