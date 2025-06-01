Return-Path: <linux-acpi+bounces-14049-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D61ACA466
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 02:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7564188CA3E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 00:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDE295504;
	Sun,  1 Jun 2025 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lStmVk60"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8AD2951DF;
	Sun,  1 Jun 2025 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820787; cv=none; b=fwffnsgCBcBeDhFCkDLxKePzWXb5KYjgsDHArhtzwBXBi9KN3IGUkSoP8SfBGl9i6di8CrJwn3cOuTBCnjF8OvgiRDHk8prTsIafIFT14/RFo8CLoiBNy6rJU1G5mLAYuGyCdDSNU5nBijo4zEdlNyvvHVtY9uRqzhFLpKJox6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820787; c=relaxed/simple;
	bh=JrFiIa0aVNDgppSre2V1u5GhTFUo3wKv9edxo9b/NtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kLtHbd1P9a2zK8PJ+kMWDPd/7GphbRpCVsEztCV2jjBo8MCr0iBX7RoyP/UGsYEXUUO2r8mvC9tpG46PFWOaaO0UJzRnwj4Ywjo6z1O8feTfM2TU57g0eDZIXrCzD3zXV7TtAfZ8kd7Y7V3x4oc1744I5n4cHys9XZ8ED1ODSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lStmVk60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A42C4CEE7;
	Sun,  1 Jun 2025 23:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820787;
	bh=JrFiIa0aVNDgppSre2V1u5GhTFUo3wKv9edxo9b/NtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lStmVk60f+W1MbvQMUPKOx7llI0aeWRm/uhKRFSz9Db8OMXmUP2O2J4Rtju8oW8eN
	 VPQzvuk4EyucsKJ9UagIX32JLUDHlflg0DiwaFBc/h9NuhrebZBLWxin8lc8b7B7zN
	 i78Ths8E2XDNvS2q6gi4Fc59OxncoJr4/+mNzRG4EHuxuhTnyeDwBSnutlieG5Y42C
	 MyXYEqxjMHuOn5cEi4cq0ArqAJL6Ov9aLAzZzsMiefU3kXTR6J2bIA9frKFh7D8brV
	 ZIrmhuzb3/cKoj/8fYTS9EFwZCvDSE5xPFVg/9QrPxd9BGv8MYyZoQBQvlE4UND95O
	 F+2KfO49FlNJg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 075/102] ACPI: bus: Bail out if acpi_kobj registration fails
Date: Sun,  1 Jun 2025 19:29:07 -0400
Message-Id: <20250601232937.3510379-75-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
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
index 058910af82bca..c2ab2783303f2 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1446,8 +1446,10 @@ static int __init acpi_init(void)
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


