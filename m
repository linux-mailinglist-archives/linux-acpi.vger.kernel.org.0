Return-Path: <linux-acpi+bounces-14006-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8E7AC8F59
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 15:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E4F1BA0E49
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05263274642;
	Fri, 30 May 2025 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFpmGXYl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5F2741D3;
	Fri, 30 May 2025 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608899; cv=none; b=Wx0R9fA8Mxg4GYaGfCLM2xtiPgbt11n17xyNJQ+y+QA3tFe1yI5kLybS/LXmPW8i+fOlEZTEirprXzxq2vJ26P2oCVBkvwB6RdJD8H9JCvsNluD8G3DlTFNM7IaGnwDomSeVCc8NwmgPPTyQwapITXlgrA6BqZPtS+Z42BuQVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608899; c=relaxed/simple;
	bh=rjpar9TYqG7jVXukYFvRGIrGJD2KtT6Lt6wPL9nnHE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsyQ74cv5NitzgxTd6x0sQHP5+xQPE4XXZflHLEnHj4/7Obv+eUIbklFQ4qi+WimxI41pClmRXtJn8g9WXoWnvKfKpC2Wx0JYXpCaGWOabvhldN8fpKREemDZbyRgaudlRPMstcm7dVzQZObIGjmHqVFZ4+cRgtl51mzLliTldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFpmGXYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CADC4CEF0;
	Fri, 30 May 2025 12:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608899;
	bh=rjpar9TYqG7jVXukYFvRGIrGJD2KtT6Lt6wPL9nnHE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFpmGXYljb6LwqDSDzFZVHaR6tD1KA49zoRAJQoUEhWY7qoqD82Nr0fGF+UIDC2tr
	 mTWaMsOBIMLf0IdqBP3jxvUY9l30zxofInXBTlXzUIHxbIeo4UXy7M1+hpuH5mXJrj
	 BRD3XfAvyRc9UzepZUz0LP8xVRODohwPt3qlHwG8CS9xZ8MPRKFOdY8hJKYf7pPwLK
	 sHiqJQB365D2hHBZo5Ip68UFBjB1JCgW8yXiHhz+8as8p+2jiqP44Dk0aAi4jczxEy
	 5u6vVnoq10FQxCoHfyOe/wji7Xd5YUCSbtzMUNz+mGOn6NyNUrpPtQSeufsv4aXwNj
	 yC3AJ3dWswgEg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rjw@rjwysocki.net,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/11] ACPI: bus: Bail out if acpi_kobj registration fails
Date: Fri, 30 May 2025 08:41:25 -0400
Message-Id: <20250530124131.2576650-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124131.2576650-1-sashal@kernel.org>
References: <20250530124131.2576650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.184
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 94a370fc8def6038dbc02199db9584b0b3690f1a ]

The ACPI sysfs code will fail to initialize if acpi_kobj is NULL,
together with some ACPI drivers.

Follow the other firmware subsystems and bail out if the kobject
cannot be registered.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://patch.msgid.link/20250518185111.3560-2-W_Armin@gmx.de
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Code Change Analysis The commit changes the
behavior in `acpi_init()` when `kobject_create_and_add("acpi",
firmware_kobj)` fails: **Before:** - If `acpi_kobj` creation fails, only
prints a debug message and continues execution - The function proceeds
to initialize ACPI subsystems with a NULL `acpi_kobj` - This leads to
potential crashes/failures in other ACPI components **After:** - If
`acpi_kobj` creation fails, prints an error message and returns
`-ENOMEM` - Prevents initialization of ACPI subsystems with a NULL
`acpi_kobj` - Follows proper error handling patterns ## Evidence from
Kernel Code Investigation From examining the kernel repository, I found
multiple critical usages of `acpi_kobj` that would fail catastrophically
if it's NULL: 1. **drivers/acpi/sysfs.c:514**:
`kobject_create_and_add("tables", acpi_kobj)` - NULL parent causes
undefined behavior 2. **drivers/acpi/sysfs.c:924**:
`sysfs_create_group(acpi_kobj, &interrupt_stats_attr_group)` - NULL
kobject crashes 3. **drivers/acpi/platform_profile.c**: Multiple
`sysfs_notify(acpi_kobj, ...)` calls that would crash with NULL 4.
**drivers/acpi/platform_profile.c**: `sysfs_create_group(acpi_kobj,
&platform_profile_group)` would fail ## Backport Criteria Assessment ✅
**Fixes a real bug**: Yes - prevents crashes when kobject creation fails
✅ **Small and contained**: Yes - only 4 lines changed in one function ✅
**Clear side effects**: Yes - prevents ACPI initialization on memory
allocation failure ✅ **No architectural changes**: Yes - just proper
error handling ✅ **Critical subsystem**: Yes - ACPI is core kernel
infrastructure ✅ **Minimal regression risk**: Yes - only affects rare
failure path ✅ **Follows stable rules**: Yes - important bugfix with
minimal risk ## Comparison with Historical Examples This commit closely
matches **Similar Commit #1** (Status: YES) which also: - Fixed error
handling in ACPI initialization code - Added proper cleanup/error
handling when kobject operations fail - Was considered suitable for
backporting The commit differs significantly from the "NO" examples
which were: - Code cleanup/style changes (Similar Commits #2, #3, #4) -
Refactoring without fixing actual bugs (Similar Commit #4) ## Risk
Assessment **Low Risk**: The change only affects the extremely rare case
where `kobject_create_and_add()` fails due to memory allocation failure.
In such cases: - **Current behavior**: System continues with broken
ACPI, leading to crashes - **New behavior**: ACPI initialization fails
cleanly, system may still boot without ACPI ## Conclusion This is a
critical bug fix that prevents crashes in ACPI subsystems when memory
allocation fails during boot. It transforms undefined behavior/crashes
into clean failure handling, making it an ideal candidate for stable
backporting.

 drivers/acpi/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9bc5bc5bc359b..ea63b8f272892 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1335,8 +1335,10 @@ static int __init acpi_init(void)
 	}
 
 	acpi_kobj = kobject_create_and_add("acpi", firmware_kobj);
-	if (!acpi_kobj)
-		pr_debug("%s: kset create error\n", __func__);
+	if (!acpi_kobj) {
+		pr_err("Failed to register kobject\n");
+		return -ENOMEM;
+	}
 
 	init_prmt();
 	result = acpi_bus_init();
-- 
2.39.5


