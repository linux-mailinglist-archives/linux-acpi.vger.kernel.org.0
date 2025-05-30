Return-Path: <linux-acpi+bounces-13989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A140AC8EEA
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 15:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72FDA47174
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 12:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF34D2620D6;
	Fri, 30 May 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbnE4Sh+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D552620C4;
	Fri, 30 May 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608847; cv=none; b=TSh1MSQ+AKdTmgiEw5hAfwMkKpjov1R4PKTQHfW2IaXN33uOJCk0Mal9kemxpm1oPxSDkPaLr+7NdtYjvgDaq1a/raRJaF1M5+o4yFm+oYMK53gsZWpw4Ve78cVuWhj/gK6KpCACHjQlz0AH7SusXaTP/B8KxS1XEggf0ht7Oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608847; c=relaxed/simple;
	bh=96mPeNIGC4RfUKmcPKwZXWn0hg6MOwcTqEcnDDd5tD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psimfWQ4xXjSScjPu/Q72EyyAEhU1ZoWZZpvPVGEwh2NL0UR4eJ5aS94AhPxqZUAw1raytpmrcCYan/lBQXsrBWqT+AS+ecYQl694gZRF02qoqN3b1Rj8dzX7FT4VC7Ri77HEKsqmaBd/870rmowHNEu3ctVSvca8WrZZwzFoqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbnE4Sh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2502CC4CEEF;
	Fri, 30 May 2025 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608847;
	bh=96mPeNIGC4RfUKmcPKwZXWn0hg6MOwcTqEcnDDd5tD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbnE4Sh+jcQJD0X4RNUw1L6MA4iABmBpFcrymfCS3aOmqKttQs08bd0UzMwHkmx++
	 sUQKq19oBR3/FHj1VoQ6+xDM4qMqONPlnnaMw/CrvwtTxncn4HWnEPqu5Ib1kgf3ZD
	 4Ah66m4H6iqBRva5zEhHiabwUPFAPMWJuDHs7dwKK2iisrq6YlSXbfnHg0MI9MRz7r
	 Gj5y1wnssIdw+ACKZCJNi0W23sAp4jdm+Sv+mes6eHMfGszrVuNcH/HYBFjryBD+Rq
	 yvV6VQ0a0V7wHiNY0wHn9oAUPsBtaUr0JdxzCvDzZ4y8sLf3rI6mH+ypDQ6GBOlMQ+
	 ifq7KiVXfj2Vg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Marheine <pmarheine@chromium.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rjw@rjwysocki.net,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 26/26] ACPI: battery: negate current when discharging
Date: Fri, 30 May 2025 08:40:12 -0400
Message-Id: <20250530124012.2575409-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124012.2575409-1-sashal@kernel.org>
References: <20250530124012.2575409-1-sashal@kernel.org>
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

From: Peter Marheine <pmarheine@chromium.org>

[ Upstream commit 234f71555019d308c6bc6f98c78c5551cb8cd56a ]

The ACPI specification requires that battery rate is always positive,
but the kernel ABI for POWER_SUPPLY_PROP_CURRENT_NOW
(Documentation/ABI/testing/sysfs-class-power) specifies that it should
be negative when a battery is discharging. When reporting CURRENT_NOW,
massage the value to match the documented ABI.

This only changes the sign of `current_now` and not `power_now` because
documentation doesn't describe any particular meaning for `power_now` so
leaving `power_now` unchanged is less likely to confuse userspace
unnecessarily, whereas becoming consistent with the documented ABI is
worth potentially confusing clients that read `current_now`.

Signed-off-by: Peter Marheine <pmarheine@chromium.org>
Link: https://patch.msgid.link/20250508024146.1436129-1-pmarheine@chromium.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and examination of the kernel
codebase, I can now provide my assessment: **YES** This commit should be
backported to stable kernel trees because: 1. **Fixes a real user-facing
bug**: The commit addresses an ABI inconsistency where ACPI battery
drivers were reporting current_now with the wrong sign. According to the
kernel's power supply ABI documentation
(Documentation/ABI/testing/sysfs-class-power), `current_now` should be
negative when discharging and positive when charging, but ACPI battery
drivers were reporting positive values always. 2. **Small and contained
fix**: The change is minimal and well-contained. It only affects the
`POWER_SUPPLY_PROP_CURRENT_NOW` case in `acpi_battery_get_property()`
function in `drivers/acpi/battery.c`. The code adds a simple check to
negate the current value only when: - Property requested is
`POWER_SUPPLY_PROP_CURRENT_NOW` (not power_now) - Battery is in
discharging state - The `acpi_battery_handle_discharging()` function
confirms it's actually discharging 3. **Follows stable rules**: This is
an important bugfix that corrects userspace-visible behavior to match
documented ABI. Applications and battery monitoring tools rely on the
documented behavior that negative current indicates discharging. 4.
**Minimal regression risk**: The change is very conservative: - Only
affects `current_now`, not `power_now` (as noted in commit message) -
Uses existing `acpi_battery_handle_discharging()` logic to double-check
the discharging state - Leaves all other battery properties unchanged 5.
**Similar pattern in similar drivers**: From the historical examples
provided, commits like "power: supply: bq27xxx: fix polarity of
current_now" and "power: supply: axp20x_battery: properly report current
when discharging" were backported with YES status for exactly the same
type of issue - fixing current sign during discharge. 6. **Affects
critical subsystem**: Battery reporting is crucial for power management,
and incorrect current direction can confuse userspace tools and
potentially impact power management decisions. The commit carefully
addresses the ABI compliance issue while minimizing risk by only
changing the sign for `current_now` during confirmed discharging states,
making it an ideal candidate for stable backporting.

 drivers/acpi/battery.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 65fa3444367a1..6a7ac34d73bda 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -243,10 +243,23 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN) {
 			ret = -ENODEV;
-		else
-			val->intval = battery->rate_now * 1000;
+			break;
+		}
+
+		val->intval = battery->rate_now * 1000;
+		/*
+		 * When discharging, the current should be reported as a
+		 * negative number as per the power supply class interface
+		 * definition.
+		 */
+		if (psp == POWER_SUPPLY_PROP_CURRENT_NOW &&
+		    (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
+		    acpi_battery_handle_discharging(battery)
+				== POWER_SUPPLY_STATUS_DISCHARGING)
+			val->intval = -val->intval;
+
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
-- 
2.39.5


