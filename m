Return-Path: <linux-acpi+bounces-14064-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BE3ACA6DD
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 03:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6933BD60A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 00:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CEE29E150;
	Sun,  1 Jun 2025 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt4m5yB6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6D29E148;
	Sun,  1 Jun 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821336; cv=none; b=boE3ISXQnSuqhSk8g6vyWUPVB3hAxtQif4pixSNjl32PRRsuuzxGMc5joXWz3J0QCYmGAzK8BzsjBzumC5FkT6PYW7OlWUm74kJfG1OaWlytbazKp9vBgYgE8WB/fhEVzDid5CzZlRRha+hSVgQ8GwTmXts1ka2sQl+zjx3zMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821336; c=relaxed/simple;
	bh=GuRYgMuhOEHIQd1ewVz5mpVClBmua5DLxTgZILBULzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H31P7tL7XvsN7B0gnpmLQDuSj3vVu2GZOZeT6lYyZ9Q0z+OlOjGoFtJhyjV7PKZvuRJGAifRQH2kOAcqgglL102jR4KS1ibRn1iutYnXswZZi0gMgOWqq6U8hMPRM26osD6cVEppREL8g5W9wOuCXpJuKQzkAb/PHGX10JGlYcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt4m5yB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903AEC4CEF1;
	Sun,  1 Jun 2025 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821334;
	bh=GuRYgMuhOEHIQd1ewVz5mpVClBmua5DLxTgZILBULzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rt4m5yB6AK3G/VCaSy/Ttfl8HWSup/PK2fMO0mFiWWtqdq20MZQ4nzgZ91VszU8+x
	 qwF7x/HWZ0Ru2/RhItQ5DWgsLEsHvCu/9fXOL+XZLz6eNfrY0J97TMzzgIw+WOQUp6
	 3h0VGvhWpbV+aa28iD1iTxbLFgQv4ExmIlpfZSh3H9KCRADbNHvLvW5UfpKu+9IsLO
	 QDx+IysDKYYs7D//zoUOScYZ5jDzpUDDQOW0uwYwg32Pe3sKEX+9AqadllwzPWE0Dx
	 02/P5KWNea9hsrx+IUk/NLIkBoaPTYb41/TSbH8u9d3o63uoT9DUqV8TraGumqBZcp
	 Hpuj9+nHcr2lw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 54/58] ACPI: EC: Add device to acpi_ec_no_wakeup[] qurik list
Date: Sun,  1 Jun 2025 19:40:07 -0400
Message-Id: <20250601234012.3516352-54-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234012.3516352-1-sashal@kernel.org>
References: <20250601234012.3516352-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.140
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Werner Sembach <wse@tuxedocomputers.com>

[ Upstream commit 9cd51eefae3c871440b93c03716c5398f41bdf78 ]

Add the TUXEDO InfinityBook Pro AMD Gen9 to the acpi_ec_no_wakeup[]
quirk list to prevent spurious wakeups.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Link: https://patch.msgid.link/20250508111625.12149-1-wse@tuxedocomputers.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

The search failed because this is the current version in the kernel
tree, but the commit we're analyzing hasn't been applied yet. Let me
analyze this commit based on the information provided. ## Analysis
**YES** This commit should be backported to stable kernel trees. ###
Detailed Analysis: **1. Nature of the Fix:** The commit adds the "TUXEDO
InfinityBook Pro AMD Gen9" laptop to the `acpi_ec_no_wakeup[]` DMI quirk
list. This is a targeted fix for spurious wakeups from suspend-to-idle
(s2idle) caused by EC (Embedded Controller) interrupts on a specific
laptop model. **2. Code Changes:** The change is minimal and surgical: -
Adds a single new DMI entry to an existing quirk table - Uses
`DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx")` to identify the specific device -
Includes a comment identifying the device clearly - No functional code
logic changes - only data structure modification **3. Comparison with
Historical Similar Commits:** Looking at the historical commits
provided: - **Similar Commit #1 (NO):** Added HP ZHAN 66 Pro - marked as
NO for backporting - **Similar Commit #2 (YES):** Fixed ThinkPad X1
Carbon 6th DMI matching - marked as YES - **Similar Commit #3 (NO):**
Added ThinkPad X1 Yoga 3rd - marked as NO - **Similar Commit #4 (YES):**
GPIO quirk for GPD G1619-04 with `Cc: stable@vger.kernel.org` - marked
as YES - **Similar Commit #5 (YES):** Removed duplicate entry - marked
as YES **4. Stable Tree Criteria Assessment:** ✅ **Fixes important user-
visible bug:** Spurious wakeups significantly impact user experience and
battery life ✅ **Small and contained change:** Only adds one DMI table
entry, no logic changes ✅ **Low risk of regression:** DMI quirks are
device-specific and don't affect other systems ✅ **Well-tested
pattern:** The `acpi_ec_no_wakeup` mechanism is well-established and
widely used ✅ **Critical subsystem appropriately handled:** ACPI EC is
critical but this change is isolated to one device **5. Risk
Assessment:** - **Risk to target device:** Minimal - disables EC wakeup
which is the intended behavior to fix spurious wakeups - **Risk to other
devices:** None - DMI matching is device-specific - **Risk of
regression:** Very low - follows established pattern used by many other
laptop models **6. Precedent Analysis:** The pattern shows that while
some individual device additions were marked as NO (commits #1 and #3),
those that include proper documentation, clear problem statements, or
fix significant user issues tend to be marked YES (commits #2, #4, #5).
This commit includes a clear problem statement ("prevent spurious
wakeups") and follows the exact same pattern as successful backports.
**7. User Impact:** Spurious wakeups during suspend-to-idle directly
impact: - Battery life (system doesn't stay in low-power state) - User
experience (unexpected wake-ups) - Power management effectiveness This
is exactly the type of user-facing power management issue that stable
trees aim to address. The commit is an ideal candidate for backporting:
it's a small, safe, device-specific fix for a real user problem that
follows well-established patterns with minimal risk.

 drivers/acpi/ec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5776987390907..15148513b050d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2288,6 +2288,12 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		// TUXEDO InfinityBook Pro AMD Gen9
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
+		},
+	},
 	{ },
 };
 
-- 
2.39.5


