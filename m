Return-Path: <linux-acpi+bounces-14056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E7ACA581
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 02:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EE13AB62D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 00:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DF43064B1;
	Sun,  1 Jun 2025 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn71wUI6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA293064AA;
	Sun,  1 Jun 2025 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821048; cv=none; b=mSgJyA4t/3Z3uwTtw8ooyEJp1VdSwVsX2ijYFoLo8LK/w08GKOj0oItquz4BEqKDpa2pJvNulXMSDxthpdJqPkScbwBP2ZS9rlU7WeU84JTTZTNTK4J2wISxqBDhCSJWmeaZQUOqFz31u+JAgsRmQZ6GQ/73MU82JTOarq/KPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821048; c=relaxed/simple;
	bh=rzCGwEc2YdPZtiHNdWI3V3mDMKQzINOoa1AQ2ErAIBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMH0yfRWPPqej8EJhdCqAR5WpgO4bLkg6X7472K3y/p9NGQayYePO3QID/kbuajnqCJwBpkfMAfjh5eUZBYYI2f8MvEB5LPlwwz93gThXeLfqoUArNGuAQjf9yF1zKKmV9FwmBZPSFMYnsa7OY1yBXqk7oDbF1CrHGtBDjr1L9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn71wUI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4CDC4CEE7;
	Sun,  1 Jun 2025 23:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821048;
	bh=rzCGwEc2YdPZtiHNdWI3V3mDMKQzINOoa1AQ2ErAIBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jn71wUI65XNOz9LYU/CV18Nq8LjQzUKxbaHaO6AhEONKrhaO3D6ukfL1Fq3T41Avu
	 Zfts6jqZo45jwDg76HVo4LhxoKGMQeJwunq4X51S+9XGdN1adhoA4uUPEW8TxOyWVu
	 YdHIKBpBY2fNNlsdO+xGhMInynnDN5PI6Kyx2zf5dmv+lLJLorjQCgWggwkEQdpjqr
	 xesJS9EV6KfmI+3eAK5npWjJP8rjGO9YP2fD609l0RhyjXA25GEeDHfDVi8SVQBVQr
	 oLYEdfXD94GazRJesm69BgjayzBltDfETX1PBnQrQiNKAadYguBd0Zm7F2+tnLbbsW
	 9lxxw7OF48MJQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 85/93] ACPI: EC: Add device to acpi_ec_no_wakeup[] qurik list
Date: Sun,  1 Jun 2025 19:33:52 -0400
Message-Id: <20250601233402.3512823-85-sashal@kernel.org>
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
index e614e4bef9ea1..a813bc97cf425 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2329,6 +2329,12 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
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


