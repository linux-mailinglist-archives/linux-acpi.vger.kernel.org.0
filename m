Return-Path: <linux-acpi+bounces-15056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FB0AFBEF5
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 02:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A37A7A8C3B
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 00:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF629D0E;
	Tue,  8 Jul 2025 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omRcSkFf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA02EEC3;
	Tue,  8 Jul 2025 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932965; cv=none; b=W9EggEiifKkqeUmgQVg5sbEWu2GWs9gdAUKbTavb6Zk7HPl27A5HgY+DixjpI1ZvBfQCL7nxU9bJ8gJdpq88oVZwgBOfur3yDrCTOytQo0YE/wN7/DKZFpUnls3pSPzmF6oU/LiQR3sEU3cGH6ye19wPdHJRzHHv0ywITJNcyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932965; c=relaxed/simple;
	bh=WOWj8fFWu0pzBgiNZaPRD2JRVEIDYA69FF8FPkP0azU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fx2/5gjMUJI8dBGSzMHk/Qde0JYTOrnZ97ap7wEIFdxs68s5XUCNPdvolUn2vEgIxTWUkHkYgRMUhxFMbDy7fUslRqK59QC1Xew9MCG2j8WNfjzkel+WcLJPwg4+fA3mFLERYmxPcUnDEXNXo76kYVHQY0vMVVmnByYd2wVp4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omRcSkFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09468C4CEE3;
	Tue,  8 Jul 2025 00:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751932963;
	bh=WOWj8fFWu0pzBgiNZaPRD2JRVEIDYA69FF8FPkP0azU=;
	h=From:To:Cc:Subject:Date:From;
	b=omRcSkFf5ZkkEYkISc+U4t8Nb/h7jyVMmpLxMa1jFswcx/4GQm+xOo0KtA+/WxNXR
	 Z8DwsRAd8JTEU7WWi7N+if0Rn281km/Fo6duRJ3Q/TWCYC4uaMvVpOkudMZjSZXj7T
	 vfthV9+Ky4yWF1nUk0CdSYJJUTXSBoo3PByjnEG4Vmxb27nm8Tdp6/HrcShx5UjnaK
	 7NttuTPXxusGGJK2Q/KhB3189ZEMe8EaT5Su1+/zesUxp/SrArD3PI7xXZfvdXj1HC
	 P4ihtDv5chi3cY8w885vRl1DVWWrSzLHpoSKsWPtcp2Y3zpWHMrU9Jnm4f7YTaoqJg
	 chN5JCQnG3dkg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 1/4] Revert "ACPI: battery: negate current when discharging"
Date: Mon,  7 Jul 2025 20:02:38 -0400
Message-Id: <20250708000241.793498-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.96
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit de1675de39aa945bad5937d1fde4df3682670639 ]

Revert commit 234f71555019 ("ACPI: battery: negate current when
discharging") breaks not one but several userspace implementations
of battery monitoring: Steam and MangoHud. Perhaps it breaks more,
but those are the two that have been tested.

Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Closes: https://lore.kernel.org/linux-acpi/87C1B2AF-D430-4568-B620-14B941A8ABA4@linux.dev/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**, this commit should be backported to stable kernel trees.

## Extensive Explanation:

### 1. **Critical Userspace Regression Fix**
This revert fixes a critical regression that breaks userspace
applications. The commit message explicitly states that the original
change "breaks not one but several userspace implementations of battery
monitoring: Steam and MangoHud." This is a clear violation of the
kernel's "no userspace regressions" rule, which is one of the most
fundamental principles in kernel development.

### 2. **Code Analysis Shows ABI Change**
Looking at the code changes:
```c
// The problematic code that was added (and is now being removed):
if (psp == POWER_SUPPLY_PROP_CURRENT_NOW &&
    (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
    acpi_battery_handle_discharging(battery)
            == POWER_SUPPLY_STATUS_DISCHARGING)
    val->intval = -val->intval;
```

This code was changing the sign of the current value when discharging,
which altered the userspace-visible ABI. Even if the original behavior
didn't match documentation, changing it broke existing applications that
depended on the long-standing behavior.

### 3. **Simple and Safe Revert**
The commit is a clean revert that:
- Removes the problematic sign negation logic
- Restores the original behavior that userspace applications expect
- Is self-contained to the `acpi_battery_get_property()` function
- Has minimal risk of introducing new issues

### 4. **Meets Stable Kernel Criteria**
According to stable kernel rules, this commit qualifies because it:
- **Fixes a real bug** that users are hitting (broken battery monitoring
  in Steam and MangoHud)
- **Is obviously correct** (it's a revert of a change that broke
  userspace)
- **Is small and contained** (only affects the ACPI battery property
  reporting)
- **Has been tested** (the reporter confirmed the issue)
- **Fixes a regression** (restores previous working behavior)

### 5. **Comparison to Similar Commits**
Looking at the historical commits marked with "Backport Status: YES",
they share similar characteristics:
- Fix actual problems affecting users
- Are relatively small and contained changes
- Don't introduce new features or architectural changes
- Focus on fixing specific issues

This revert fits perfectly into this pattern as it's fixing a specific
userspace compatibility issue without introducing any new functionality.

### 6. **Timing Considerations**
The original problematic commit (234f71555019) was from May 8, 2025, and
this revert is from July 3, 2025. If the original commit made it into
any stable releases, those stable trees would need this revert to
prevent userspace breakage.

### Conclusion:
This is a textbook example of a commit that should be backported to
stable kernels. It fixes a userspace regression, is minimal in scope,
carries very low risk, and restores previously working behavior that
applications depend on. The fact that it's a revert of a problematic
change makes it even more suitable for stable backporting.

 drivers/acpi/battery.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index cd3cbb7a36f85..e3cbaf3c3bbc1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -243,23 +243,10 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN) {
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
 			ret = -ENODEV;
-			break;
-		}
-
-		val->intval = battery->rate_now * 1000;
-		/*
-		 * When discharging, the current should be reported as a
-		 * negative number as per the power supply class interface
-		 * definition.
-		 */
-		if (psp == POWER_SUPPLY_PROP_CURRENT_NOW &&
-		    (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
-		    acpi_battery_handle_discharging(battery)
-				== POWER_SUPPLY_STATUS_DISCHARGING)
-			val->intval = -val->intval;
-
+		else
+			val->intval = battery->rate_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
-- 
2.39.5


