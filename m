Return-Path: <linux-acpi+bounces-13993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C64AC8EDD
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 14:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 784C67A4611
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A5266F1E;
	Fri, 30 May 2025 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTLHDhjQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB256266F0D;
	Fri, 30 May 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608861; cv=none; b=taSJenrc2ULyexTcU2VBMAXElyjq3E4dmImudT9tnYQqguJzyq0AnTN31ZT8WXvCTrMVNzojJvpLGkXeQkB19pJPaDPJKjgdVAUngbF/vJWoIv3qKL+nermG8bScpn68+SLQiMdx5DoB8dpDS8DZzlORcTTJd5N3trQLfiQ7bOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608861; c=relaxed/simple;
	bh=hmWFCRTnmI9+sqngAp403FtuSrQ/QuIKwuybvV2ts6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfJd/pUmT5/emLQwcSwyo6xo1a++IxZK+ei2RJlP5UUNDXipnSnMHuErkevLjonjI5dSbb3T0vtuSOwrjqk4nImxg75VwDxTZBpoHJjIBlsT7kC19mMsaYeIvxHW/2QN+QSx2gbBpV/+44OtBooX6G1xwydk5HSqQcBxLO/dTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTLHDhjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E07C4CEEB;
	Fri, 30 May 2025 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608861;
	bh=hmWFCRTnmI9+sqngAp403FtuSrQ/QuIKwuybvV2ts6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tTLHDhjQEzEtfHzGToR6FFmzov8RPqXxz1oU0SPdns7vYtVPfvVmrZZUhL+F4WmdV
	 5EkpA0E1rM7MQuvbkUE6Ahw84EelhfuO824L40U4U1YbcSoPhEkVG0Kxyfd+vFBwBr
	 S3sMVH6pnEKVnIaDHotg0/pAiXFMUzj59q8RgA0DJM2q0L1MYG9EDHTO73fJ51aqxX
	 P653A2wqAU94KVsilRi3A0F6sqaOAFq6DrsNdQ4kW8clBeffNGrxsqBfgK5qckF0O9
	 DLRzC7Ab3awVVjqHyYJGkRE8aCd5w0IBkAKrd7iolqB0n7l+72O4jXYD8j/dNetmJs
	 0nlDntRSVzw8Q==
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
Subject: [PATCH AUTOSEL 6.6 10/18] ACPI: bus: Bail out if acpi_kobj registration fails
Date: Fri, 30 May 2025 08:40:39 -0400
Message-Id: <20250530124047.2575954-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124047.2575954-1-sashal@kernel.org>
References: <20250530124047.2575954-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
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
index a4aa53b7e2bb3..645464f02363f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1396,8 +1396,10 @@ static int __init acpi_init(void)
 	}
 
 	acpi_kobj = kobject_create_and_add("acpi", firmware_kobj);
-	if (!acpi_kobj)
-		pr_debug("%s: kset create error\n", __func__);
+	if (!acpi_kobj) {
+		pr_err("Failed to register kobject\n");
+		return -ENOMEM;
+	}
 
 	init_prmt();
 	acpi_init_pcc();
-- 
2.39.5


