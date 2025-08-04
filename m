Return-Path: <linux-acpi+bounces-15492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9466EB197C6
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 02:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEC63B8848
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 00:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032F919755B;
	Mon,  4 Aug 2025 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPTdXtb7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28813B5A9;
	Mon,  4 Aug 2025 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267390; cv=none; b=qScVdttauyoAoxdpHfFtcK0JZ0Xw6RtmUV6ps8ajVB5shGVrRWa51Uzp6RHGrWca53PtDsur3En2vAtXFVWllugQJAEuPTEIzYdxyvXBnIrlWbOfcE6PHqj/aXs0my73GmaSoQgGo5cHtPxzcyLKUrYMeW/UYL0EkP+zaFzZAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267390; c=relaxed/simple;
	bh=91WQJzO0/8B1MAGCDa6vdYWD9+ywd2CT1zwdvugA6oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHIyeNwYa8RM/9Cqmc5Zu+6BkR5HXdc/eNho9Hde7sjx1sPqFOf/I9CoEIN59DWHHR5fjk72S0gAKaHeOS0Cz8fSLUNByuN8/3KpgQFsuI2wf8Sj8Ov0c+IrcczAQR4hOsPqlcuGh9YxecIDK+68aDKfLq1tH2YQxvG0A17ZeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPTdXtb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D3BC4CEEB;
	Mon,  4 Aug 2025 00:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267390;
	bh=91WQJzO0/8B1MAGCDa6vdYWD9+ywd2CT1zwdvugA6oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPTdXtb7f2jNzQSWNnN9vCnsNTrWpceAiMYVaWKDAjBZMCNjFlNO2kJGtg5G8dK9e
	 9bT+FsBlUXKEWdw3CoVbpmKqTZ6ZEKuiOs8FM0xFTKK5QMqjkyictthlec6IK+DapK
	 l5kJxJprYPD/uZmBFfRsnidaleXp9juBOFYRsqnx+kUTYsmKf4fd0ZruZOgGZMgbQk
	 rPp3OW0iW/cvF5C1cMvBMe/UcpQqOP7UK4xRcYJYj2KtEAu5tCsPMifgAUCD/7Svg2
	 wncEGs5uyfH+Bb2rHIGVv0d0lycoJGWL43cWMQzaRKkAf79xt4SxSnNUwoPL7ttHmu
	 CABkrGvgdQp/Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	ira.weiny@intel.com,
	dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com,
	Smita.KoralahalliChannabasappa@amd.com,
	xueshuai@linux.alibaba.com,
	mingo@kernel.org,
	peterz@infradead.org,
	bp@alien8.de,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 47/80] ACPI: APEI: GHES: add TAINT_MACHINE_CHECK on GHES panic path
Date: Sun,  3 Aug 2025 20:27:14 -0400
Message-Id: <20250804002747.3617039-47-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002747.3617039-1-sashal@kernel.org>
References: <20250804002747.3617039-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.9
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
index fe9bd27367ee..ce9b8e8a5d09 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1099,6 +1099,8 @@ static void __ghes_panic(struct ghes *ghes,
 
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
+
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
 	if (!panic_timeout)
-- 
2.39.5


