Return-Path: <linux-acpi+bounces-9607-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B84EC9CFB08
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 00:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71D8B32CCC
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 23:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732D21953B0;
	Fri, 15 Nov 2024 23:11:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C733414F9D9;
	Fri, 15 Nov 2024 23:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712293; cv=none; b=QLjQblsfk4EGfQisYbQPC8l3rkBW5Ad5cXMG+zLJ2vWFiYMMLOLxAFolnZv5o1OeaB1KjNeQ/E4/KzOvuLO41KQaF1VzME9FwGe4H6iDivNmZmP6RblbnouXaKPGKluuUoE1O6p0i123hU/T8CK5mLn0iLUcGapoWy1sWqkVnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712293; c=relaxed/simple;
	bh=X2uV+UlO+oeyFtpTc37ncoYBy0ncSnOv9AW0Udtr1Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RGdRHHiCFkqw7f0hNGIYhgefgAJF4eeDKawl6R0NAcyhe26ZHQeRpv9a4KbmkWqnPrGuNYahIDV0bpPRdrD1wvzfvH7QF2lSIX3toMexfoZGFS1Oq3JdEvLz9xTl3OIEZ1d7Gr4rwi04WcHo+UgStmSCQrEZgN/IFqjWnBfhCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: fS/R+NUcSEOLb7sKlcNqOA==
X-CSE-MsgGUID: 3wzlmOXjTQSDY9VKTxIn9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="35499991"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="35499991"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 15:11:31 -0800
X-CSE-ConnectionGUID: 1o93KFeCQwyDEy9ptvPpIA==
X-CSE-MsgGUID: VXddfeRZQx2L/9zWnIh/Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="88694780"
Received: from gargmani-mobl1.amr.corp.intel.com (HELO lenb-Thinkpad-T16-Gen-3.mynetworksettings.com) ([10.124.221.226])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 15:11:28 -0800
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org
Cc: anna-maria@linutronix.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	frederic@kernel.org,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Todd Brandt <todd.e.brandt@intel.com>
Subject: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
Date: Fri, 15 Nov 2024 18:11:13 -0500
Message-ID: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Replace msleep() with usleep_range() in acpi_os_sleep().

This has a significant user-visible performance benefit
on some ACPI flows on some systems.  eg. Kernel resume
time of a Dell XPS-13-9300 drops from 1943ms to 1127ms (42%).

usleep_range(min, min) is used because there is scant
opportunity for timer coalescing during ACPI flows
related to system suspend, resume (or initialization).

ie. During these flows usleep_range(min, max) is observed to
be effectvely be the same as usleep_range(max, max).

Similarly, msleep() for long sleeps is not considered because
these flows almost never have opportunities to coalesce
with other activity on jiffie boundaries, leaving no
measurably benefit to rounding up to jiffie boundaries.

Background:

acpi_os_sleep() supports the ACPI AML Sleep(msec) operator,
and it must not return before the requested number of msec.

Until Linux-3.13, this contract was sometimes violated by using
schedule_timeout_interruptible(j), which could return early.

Since Linux-3.13, acpi_os_sleep() uses msleep(),
which doesn't return early, but is still subject
to long delays due to the low resolution of the jiffie clock.

Linux-6.12 removed a stray jiffie from msleep: commit 4381b895f544
("timers: Remove historical extra jiffie for timeout in msleep()")
The 4ms savings is material for some durations,
but msleep is still generally too course. eg msleep(5)
on a 250HZ system still takes 11.9ms.

System resume performance of a Dell XPS 13 9300:

Linux-6.11:
msleep HZ 250	2460 ms

Linux-6.12:
msleep HZ 250	1943 ms
msleep HZ 1000	1233 ms
usleep HZ 250	1127 ms
usleep HZ 1000	1130 ms

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216263
Signed-off-by: Len Brown <len.brown@intel.com>
Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
Tested-by: Todd Brandt <todd.e.brandt@intel.com>
---
 drivers/acpi/osl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 70af3fbbebe5..daf87e33b8ea 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -607,7 +607,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
 
 void acpi_os_sleep(u64 ms)
 {
-	msleep(ms);
+	u64 us = ms * USEC_PER_MSEC;
+
+	usleep_range(us, us);
 }
 
 void acpi_os_stall(u32 us)
-- 
2.43.0


