Return-Path: <linux-acpi+bounces-15496-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7FB19846
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 02:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB553AC524
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408418FC86;
	Mon,  4 Aug 2025 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGy3q2ZG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971435957;
	Mon,  4 Aug 2025 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267576; cv=none; b=dKk0rJ5Z+b97ADX9W9N/rT8RS2tHgIEa2vI5RKHvqyjJVswkrrg1tfjn4EEf0PwS+7wJRpzIUAHtI5mPzO2mCHG94u/87nOgooQPpZLlMS0urcVjbhgWrZ9DCWVKl3ZROnaKVXYl+XsMvbZZIBS5hWvsdgtSpMB+EI/Meq54MQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267576; c=relaxed/simple;
	bh=0kf+eGk6S4jp1wEUtI7igVO6a3lsu/bpCp1RhAw6MrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/AbskvceFrIZtrDSbzwt/Y8pYQsOq0pp3Qk5pk+BPW6Qm9JkRFwwwBZU1+8D55KMsCja5/+oT7rdrcAGMOfn0gzzn3/BLEiLXVAlHM11q7AhjW3Uc0jUdt9LkhkWIZHCLYRNCvB+EnbA8Hyq9SsqiQBnx2Dz2oDU8d7LKEeQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGy3q2ZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EC5C4CEEB;
	Mon,  4 Aug 2025 00:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267576;
	bh=0kf+eGk6S4jp1wEUtI7igVO6a3lsu/bpCp1RhAw6MrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGy3q2ZGXa4L6XiE5ztkNlQJpVz5tGw40QjXlbBl3HxbqXKtzejZ2PxArh5hktCPX
	 lJ9X4LfeqvwOd84RDEw6fT0qUlrqnG9vcC6FrCH9P6545yHr3l5lOpiTXhNPCmWmuq
	 NUdzxQgcddkbpoxYgF8ouqQcfyuHY6D58aKpQX8QXB5tvU2YrHK3m5p7N4xbTPpLOV
	 1ZxcGjMvczpAauSU5u+3lKoC3+8HE+u8xxxfMq2HhMI4WLAGn5q9skT8aY3wnARZol
	 GoX7coL8Zxnp5ieTxbQh2PIYun+yBBHWYRB9PZlOf1s46uKESnLpqG2DQ6SkY6PGEK
	 wIJu5ndVuGpPg==
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
	xueshuai@linux.alibaba.com,
	Smita.KoralahalliChannabasappa@amd.com,
	quic_hyiwei@quicinc.com,
	u.kleine-koenig@baylibre.com,
	bp@alien8.de,
	peterz@infradead.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 40/69] ACPI: APEI: GHES: add TAINT_MACHINE_CHECK on GHES panic path
Date: Sun,  3 Aug 2025 20:30:50 -0400
Message-Id: <20250804003119.3620476-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003119.3620476-1-sashal@kernel.org>
References: <20250804003119.3620476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.41
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
index 94e3d3fe11ae..91f9267c07ea 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -996,6 +996,8 @@ static void __ghes_panic(struct ghes *ghes,
 
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
+
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
 	if (!panic_timeout)
-- 
2.39.5


