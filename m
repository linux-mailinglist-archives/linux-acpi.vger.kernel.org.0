Return-Path: <linux-acpi+bounces-14057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E762ACA62C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 02:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04511888AF9
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 00:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC563126BF;
	Sun,  1 Jun 2025 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiV6oEC3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4565270557;
	Sun,  1 Jun 2025 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821172; cv=none; b=CsiVfyGj6t6O3kPZVEuYsMvTcuwg68XAOBGqWLI2LEYWqNDPukHBHEHbrxx6V7Q8ucMyxpvuEvYfH3fQ6LhT3m5ho7fs1C04bbnyZWV5mv8k8m021f/kKyQe7IaYqXJAy39rCl6koMCk4IBmv2RrtI7Dp6P0SAoXfmk3D5FmmIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821172; c=relaxed/simple;
	bh=zTPcpGbcq5SyvY1+6KvqL+siGPDSBDEUD08VzkymeTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GiX4kxFjuDV5x8YrT9T+hzx7FZJfv8vbQtMay957LxPr/4dOv0gb5QWhOveYKzoyehbeZ/Zgz8Uc/HpTTQysQQJmBejF849Ay5h8UD2vzvGPRxTvSZqRjgKErONd+WJNJL6GoPPRKNb9OMMmr9Z02ui8iqwZdl50FixxbW37Y8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiV6oEC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D5BC4CEEE;
	Sun,  1 Jun 2025 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821171;
	bh=zTPcpGbcq5SyvY1+6KvqL+siGPDSBDEUD08VzkymeTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AiV6oEC3Pz0tvn/oHFGZnWU4y+CgHpKh1o26Yol1re4w65OcHE5+LWhrzS1HBypDS
	 kR2nHrYnQ/v+3/O4hpAglWPZkAnjfxlzKYPjnMU104wHf5RMKrZmN+e9RTZ5JR0Uvk
	 rZ5ykybVBpl23jTA1KY/W6/ZvsxOxcNizjdFiGKvcZ9i1nSRA+5sZzMBFOEDT6ywNk
	 GhN05gLxyMyfVJRknzex4YcRVcMevzJ1R1nlTBYW63rUS6tWThY1EVzz1+V8qSf56N
	 KDEMSsAqlFC6T17unPLeZWu4qvrqLjXDb1jM7TYNm264VEgB7LFEM3kkQUXLIu7RPK
	 1Sc29j2AMSNMg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 45/66] ACPI: bus: Bail out if acpi_kobj registration fails
Date: Sun,  1 Jun 2025 19:37:22 -0400
Message-Id: <20250601233744.3514795-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233744.3514795-1-sashal@kernel.org>
References: <20250601233744.3514795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
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


