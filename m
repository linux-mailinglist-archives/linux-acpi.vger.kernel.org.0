Return-Path: <linux-acpi+bounces-15500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49095B198AB
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 02:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B240E3B9B42
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 00:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CB7192B90;
	Mon,  4 Aug 2025 00:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llxn3MPB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE629A2;
	Mon,  4 Aug 2025 00:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267738; cv=none; b=VMZ59SDXA2h6DEDCGnqjugvCCZrkq428W/ihq9/deq0/IzC+BOPLoI4CpefcWr76r+Mvu6oH4qibgrrycwg2ekY7jJ8MqBnYHbKUgX+AI6ixt5Z3CD77BJ/HHbv/lbVNm5YrQO2TlGpaMYM3vf90Xylh7UdE7DEcupIBELWXFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267738; c=relaxed/simple;
	bh=O5L2DRVRfguleWwQFioGujeGlo/Kl5N2G3uASTyCixU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLgROaKoQAMqbqux/08U441Luv1VvLVZqUAPv3ORMhosH4FqSOtOdXtyI1myhooC/F8HDg+91+p5xgNOXaz28EgTmBnuLpyZuMFr1t9QCdBc/ZXJcC61dwLapd142e3pqa0F2vasllK3F0MwCu4uYQ/Xh2YsYgWjxSEvKq7daj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llxn3MPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F4EC4CEF0;
	Mon,  4 Aug 2025 00:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267736;
	bh=O5L2DRVRfguleWwQFioGujeGlo/Kl5N2G3uASTyCixU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llxn3MPB7c2viT54SHZ6IMD1af519nVB7TUGEotxnPuLSq3F9QO7jZlGXTyPgh3zE
	 MD0M35/EgNIA4GctzAm4YJ7i6a/89f59QF5792hi1LDnTgT9DkS8mnv2o1EBlrF+N3
	 1PUPcoIWL0Ts5ZbUuO1c4UEfhKRmSZjkulRziPTNQAqb7M044TaZZTKlCsMmv4WJyi
	 kZB7MnFqBJgLqO0ebIa5H+kYSi+dyvVvPr8EEY9HrQkAqJDlHRiREh/zJ/HwvMH0bD
	 UmRCAqJtW0gI86VPuuK777C48A4EOStA77QSgJAYAuNxR8knsdvryZND70v4uUUiUP
	 UgFu520AtXMlg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	xueshuai@linux.alibaba.com,
	Smita.KoralahalliChannabasappa@amd.com,
	u.kleine-koenig@baylibre.com,
	peterz@infradead.org,
	mingo@kernel.org,
	bp@alien8.de,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 34/59] ACPI: APEI: GHES: add TAINT_MACHINE_CHECK on GHES panic path
Date: Sun,  3 Aug 2025 20:33:48 -0400
Message-Id: <20250804003413.3622950-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003413.3622950-1-sashal@kernel.org>
References: <20250804003413.3622950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 4734c8b46b901cff2feda8b82abc710b65dc31c1 ]

When a GHES (Generic Hardware Error Source) triggers a panic, add the
TAINT_MACHINE_CHECK taint flag to the kernel. This explicitly marks the
kernel as tainted due to a machine check event, improving diagnostics
and post-mortem analysis. The taint is set with LOCKDEP_STILL_OK to
indicate lockdep remains valid.

At large scale deployment, this helps to quickly determine panics that
are coming due to hardware failures.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://patch.msgid.link/20250702-add_tain-v1-1-9187b10914b9@debian.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of this commit, here is my assessment:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real diagnostic issue**: The commit adds the
   TAINT_MACHINE_CHECK flag when GHES (Generic Hardware Error Source)
   triggers a panic. This is important for post-mortem analysis at
   scale, as explicitly stated in the commit message: "At large scale
   deployment, this helps to quickly determine panics that are coming
   due to hardware failures."

2. **Small and contained change**: The patch adds only a single line of
   code (`add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);`) in the
   `__ghes_panic()` function at drivers/acpi/apei/ghes.c:1091. This
   meets the stable kernel rule of being under 100 lines.

3. **Obviously correct**: The change follows established kernel
   patterns. Looking at the grep results, other machine check handlers
   already use this same pattern:
   - arch/x86/kernel/cpu/mce/core.c:1640
   - arch/powerpc/kernel/mce.c:332
   - arch/x86/kernel/cpu/mce/p5.c:40
   - arch/x86/kernel/cpu/mce/winchip.c:24

4. **No architectural changes**: This is purely a diagnostic improvement
   that adds taint information without changing any functionality or
   behavior of the GHES panic path.

5. **Minimal risk**: The change uses LOCKDEP_STILL_OK flag, indicating
   that lockdep remains valid after the taint, which is the safer option
   compared to LOCKDEP_NOW_UNRELIABLE used in some other machine check
   paths.

6. **Real benefit for users**: For organizations running Linux at scale,
   being able to quickly identify hardware-related panics through the
   taint flag provides significant operational value for triaging
   issues.

The commit meets all the stable kernel criteria: it's small, obviously
correct, fixes a real diagnostic limitation that affects users
(especially at scale), and has been reviewed by Tony Luck who is a
recognized maintainer in the RAS (Reliability, Availability, and
Serviceability) subsystem.

 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 22db720b128b..ec364c254112 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -912,6 +912,8 @@ static void __ghes_panic(struct ghes *ghes,
 
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
+
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
 	if (!panic_timeout)
-- 
2.39.5


