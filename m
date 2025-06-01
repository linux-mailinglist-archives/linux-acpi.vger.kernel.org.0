Return-Path: <linux-acpi+bounces-14053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB8BACA55F
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 02:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529443AC3B8
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 00:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A113024E0;
	Sun,  1 Jun 2025 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQeSfDqc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE23024DB;
	Sun,  1 Jun 2025 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821014; cv=none; b=SI7QSfG1R46Kr9ZPwgdycLzk8Fkkd8eFypNhDD9vZJqFzTduPE/5JTVFtuMA5qOV1f0j85fnuiyRQCHFyk+CcGM5pzbLx3sk4wqabU9X6P3brwDqAHzSVwRk8he774Zq3qGiueH4v1k6+aVC7AaqJ6UvV0mP8iogF/Xgkqr4WAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821014; c=relaxed/simple;
	bh=AAU/w4oB2Z9+sgiB6UX7vJSlwSYN97HaT92vPOY33JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8lY4I4R7M5tmAwH9LlBqkX3JmSf9dlJ474xpFszoTATxktCCITs85d2CyBIVBI/2jAsmgTHI76dDPGRTgF5L8tjPLiXp2Ke7CKhWxMo1UbUnLVHVcZW2RDnWPv+umCEuTxdE5Jdz8yKZ5Xcz0zTdF/amSDDV6HvsY+638QeRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQeSfDqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72981C4CEE7;
	Sun,  1 Jun 2025 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821014;
	bh=AAU/w4oB2Z9+sgiB6UX7vJSlwSYN97HaT92vPOY33JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQeSfDqc5S1VFebVIvE2dO/W6JXS5yNv0lOTP45Z1JPxh1QZm+USioRLwDCGL/BDB
	 +LjQUmVzYYsxul/3bUhHi2Fv1HrGnS8apvvYpV2DqVioLziluj8nYgadq5pAXBAT0t
	 pxP0VB23Vre1ahxFEo2xAjGjch+39+WJI2b43kXuptXmuYk8gTWSnLvSScNJclOHAH
	 56gICYmufv1cci9YdyII2Ps9QHGNLzy+1KvKCFOwZ8AGUCNYkLPzlGMC3feHLJ3BGP
	 a6ZTgIYb/rOV+i9XytRC+PCPR6QthUtY51wCPcRa9YlP5SjrH2LEP/AML/3ii1Dy4S
	 ZtvuhxxIFFzxw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 68/93] ACPI: bus: Bail out if acpi_kobj registration fails
Date: Sun,  1 Jun 2025 19:33:35 -0400
Message-Id: <20250601233402.3512823-68-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233402.3512823-1-sashal@kernel.org>
References: <20250601233402.3512823-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
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
the detailed analysis: **Bug Fix Nature**: The commit fixes a real bug
where ACPI initialization continues silently even when `acpi_kobj`
registration fails. This creates an inconsistent system state where ACPI
sysfs functionality and some drivers that depend on `acpi_kobj` will
fail later without clear indication of the root cause. **Code Change
Analysis**: - Changes `pr_debug()` to `pr_err()` for better visibility
of the failure - Returns `-ENOMEM` immediately when
`kobject_create_and_add()` fails instead of continuing - The existing
`kobject_put(acpi_kobj)` cleanup in the error path after
`acpi_bus_init()` is already present **Comparison with Similar
Commits**: This follows the exact pattern of Similar Commit #1 (Status:
YES) which added `kobject_put()` cleanup. Both commits address resource
management issues in the same function (`acpi_init`) and represent
important bugfixes with minimal risk. **Risk Assessment**: - Very low
risk - only affects the error path when kobject creation fails - Early
failure is better than silent failure leading to confusing symptoms
later - Change is contained to a single function with clear error
handling - Consistent with how other firmware subsystems handle kobject
registration failures **Stable Tree Criteria Met**: - Fixes important
bug affecting system reliability - Minimal and contained change - No
architectural modifications - Clear improvement in error handling and
debugging The commit addresses a legitimate reliability issue where ACPI
would continue initialization with a NULL `acpi_kobj`, leading to
failures in dependent subsystems that would be harder to diagnose than
an early, clear failure.

 drivers/acpi/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 16917dc3ad604..6234055d25984 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1444,8 +1444,10 @@ static int __init acpi_init(void)
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


