Return-Path: <linux-acpi+bounces-20934-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDj+IvJ2jGk6ogAAu9opvQ
	(envelope-from <linux-acpi+bounces-20934-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:32:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA5A1244B3
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EBE0303C4D8
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 12:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67AD1B4F2C;
	Wed, 11 Feb 2026 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B70wbtyn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A31862;
	Wed, 11 Feb 2026 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813104; cv=none; b=bfS893UtVS7VtiTPmNiVQ9rMFdZliDzj/67mnjKKkL+OD/fKuibe2umBE8zdJA2k+Mdc+XElDhN2HWGKdRyHyh1d7gndVYFsbymenyYirNLj0l1rxNtjr/WGeSiEN4XMZN5ROYanu7a4cvwpO3rorQIuVogAMImXVOL4Z0zP49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813104; c=relaxed/simple;
	bh=CpxYcLQgSQ62Nh4FfLlK/lVwozcMesY2hwqO990HgyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbGLo7717magH8A7RrIdQAP/HdZzo7MVQmW9RXlzecc/pozbWHz4YZsCnPFLt1dU5wHVSI0dsvP17FOaJSUBs4ggaSY+AAwVhPQ43DJJTcNjVpjSu4fF59aQTuVxKof+hsXQoQ2NNqMM4HV+MxY51+zWjT8/s5Dwak5PZ14BkXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B70wbtyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5466C2BC86;
	Wed, 11 Feb 2026 12:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770813104;
	bh=CpxYcLQgSQ62Nh4FfLlK/lVwozcMesY2hwqO990HgyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B70wbtynoSzoe4jwymVxPaKFgsgt48sSsg0QgANVTyytbWO4cWHMcBtSgvwGHkvxK
	 rCyn+BjHuD1YrxKTf/DtVTDEFzb7J5CexmfHYrNpp437BYRhpvnVR8U56Nk92ws/LZ
	 IJymAxfpdRC9u4ySpk90qSOPmkjm8nitet3ckVgcEiBYKgY7iVxfyRkMIIz1IUPdYX
	 vZU1hSzS05aHt+HjLjHJrmyTJto7rNBgYOkF4nD5ubnCzPiz8IWFFqlaMQ9pSeiskE
	 GlgU9WV3wTs4tk17zqeJCGd2JkS8TgMPIXTuf40wbmws1QlvK/IIldzZVYMp+0XOfI
	 9w1ZBWl52mfvQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ata=20=C4=B0lhan=20K=C3=B6kt=C3=BCrk?= <atailhan2006@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] ACPI: battery: fix incorrect charging status when current is zero
Date: Wed, 11 Feb 2026 07:30:25 -0500
Message-ID: <20260211123112.1330287-15-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211123112.1330287-1-sashal@kernel.org>
References: <20260211123112.1330287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20934-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DA5A1244B3
X-Rspamd-Action: no action

From: Ata İlhan Köktürk <atailhan2006@gmail.com>

[ Upstream commit bb1256e0ddc7e9e406164319769b9f8d8389f056 ]

On some laptops, such as the Huawei Matebook series, the embedded
controller continues to report "Charging" status even when the
charge threshold is reached and no current is being drawn.

This incorrect reporting prevents the system from switching to battery
power profiles, leading to significantly higher power (e.g., 18W instead
of 7W during browsing) and missed remaining battery time estimation.

Validate the "Charging" state by checking if rate_now is zero. If the
hardware reports charging but the current is zero, report "Not Charging"
to user space.

Signed-off-by: Ata İlhan Köktürk <atailhan2006@gmail.com>
[ rjw: Whitespace fix, braces added to an inner if (), new comment rewrite ]
[ rjw: Changelog edits ]
Link: https://patch.msgid.link/20260129144856.43058-1-atailhan2006@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a comprehensive picture. Let me compile my complete analysis.

---

## Complete Analysis: ACPI: battery: fix incorrect charging status when
current is zero

### 1. COMMIT MESSAGE ANALYSIS

The commit message clearly describes a **real-world hardware bug**
affecting the Huawei Matebook series. The symptoms are concrete and
user-visible:
- EC firmware continues reporting "Charging" even after the charge
  threshold is reached and no current flows
- This causes userspace (power management daemons, UPower, etc.) to use
  AC-plugged power profiles
- Result: 18W power draw during browsing instead of 7W (a 2.5x power
  difference!)
- Missing "remaining battery time" estimation because system thinks it's
  charging

The commit message uses the word "fix" in the subject, describes a clear
user-visible misbehavior, and was accepted by the ACPI subsystem
maintainer Rafael Wysocki who also made editorial improvements
(indicating active review).

### 2. CODE CHANGE ANALYSIS

The change is in `acpi_battery_get_property()` at the
`POWER_SUPPLY_PROP_STATUS` case. Let me examine the before and after:

**Before (line 213-214):**

```213:214:drivers/acpi/battery.c
                else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
                        val->intval = POWER_SUPPLY_STATUS_CHARGING;
```

When the EC sets the `ACPI_BATTERY_STATE_CHARGING` bit, the kernel
unconditionally reports `POWER_SUPPLY_STATUS_CHARGING` to userspace.

**After (from the diff):**

```c
                else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
                        /* Validate the status by checking the current.
*/
                        if (battery->rate_now !=
ACPI_BATTERY_VALUE_UNKNOWN &&
                            battery->rate_now == 0) {
                                /* On charge but no current (0W/0mA). */
                                val->intval =
POWER_SUPPLY_STATUS_NOT_CHARGING;
                        } else {
                                val->intval =
POWER_SUPPLY_STATUS_CHARGING;
                        }
```

The change adds a validation: when EC says "Charging" but current is
*confirmed zero* (`rate_now` is known AND equals 0), report
`NOT_CHARGING` instead.

**Safety guards in the condition:**
- `rate_now != ACPI_BATTERY_VALUE_UNKNOWN` — if rate is unknown
  (0xFFFFFFFF), preserve original "Charging" behavior. This is
  conservative.
- `rate_now == 0` — only triggers when current is truly zero, not
  negative or any other value.

**Syntactic correctness of the if/else chain:**
The nested `if/else` with explicit braces is a complete statement, so
the outer `else if` chain parses correctly. The subsequent `else if
(CHARGE_LIMITING)` attaches to the outer chain, not the inner if. This
is safe and was explicitly reviewed by Rafael (who noted "braces added
to an inner if()").

### 3. PRECEDENT: EXACT SAME PATTERN EXISTS FOR DISCHARGING

This fix is the **direct mirror** of an existing, well-established
workaround. The `acpi_battery_handle_discharging()` function (added in
commit `19fffc8450d43`, v4.18, 2018) does the exact same thing for the
discharging case:

```183:195:drivers/acpi/battery.c
static int acpi_battery_handle_discharging(struct acpi_battery *battery)
{
        /*
  - Some devices wrongly report discharging if the battery's charge
    level
  - was above the device's start charging threshold atm the AC adapter
  - was plugged in and the device thus did not start a new charge cycle.
         */
        if ((battery_ac_is_broken || power_supply_is_system_supplied())
&&
            battery->rate_now == 0)
                return POWER_SUPPLY_STATUS_NOT_CHARGING;

        return POWER_SUPPLY_STATUS_DISCHARGING;
}
```

The logic is analogous:
- **Discharging handler**: EC says "discharging" + AC connected +
  current is 0 → report "Not Charging"
- **New charging fix**: EC says "charging" + current is 0 → report "Not
  Charging"

The discharging handler has been in mainline since 2018 (v4.18) and is
well-proven. The new fix follows the identical reasoning.

### 4. CLASSIFICATION

This is a **hardware quirk/workaround** for buggy EC firmware behavior.
This falls squarely in the "quirks and workarounds" exception category
for stable trees. The pattern of ECs misreporting battery state is well-
documented in this driver (see the discharging handler, the
`battery_ac_is_broken` quirk, the notification delay quirk, etc.).

### 5. SCOPE AND RISK ASSESSMENT

- **Size**: ~7 lines of actual logic change in a single file
- **Files touched**: 1 (`drivers/acpi/battery.c`)
- **Risk**: Very low
  - Only affects the `POWER_SUPPLY_PROP_STATUS` property report
  - Only changes behavior when `rate_now` is known to be exactly 0
  - When `rate_now` is unknown, behavior is unchanged
  - No new APIs, no new module parameters, no new userspace interfaces
  - Uses only existing constants and fields that have been present since
    v4.18+
  - The change is conservative — it only transforms "Charging" to "Not
    Charging", not to anything unexpected

### 6. USER IMPACT

- **Directly affected**: Huawei Matebook series users (and potentially
  other laptops with similar EC firmware behavior)
- **Severity of the bug**: Moderate-to-high — incorrect battery status
  causes:
  - 2.5x higher power consumption (power profiles stuck on AC mode)
  - Missing battery time estimation
  - Misleading UI indicators
- **Impact scope**: Anyone using ACPI battery reporting with charge
  thresholds on affected hardware

### 7. DEPENDENCY CHECK

- `rate_now` field: present since the beginning of `struct acpi_battery`
- `ACPI_BATTERY_VALUE_UNKNOWN`: defined as `0xFFFFFFFF`, present since
  early kernel versions
- `POWER_SUPPLY_STATUS_NOT_CHARGING`: present since v2.6.24+
- No dependency on other uncommitted patches

**Context differences for older stable trees:**
- **6.12.y+**: Applies cleanly (has
  `ACPI_BATTERY_STATE_CHARGE_LIMITING`)
- **6.6.y and older**: Trivial context adjustment needed (missing the
  `CHARGE_LIMITING` line), but the actual change is identical. The patch
  would need a minor backport adaptation.

### 8. STABILITY INDICATORS

- Accepted by the ACPI subsystem maintainer (Rafael J. Wysocki) who
  actively reviewed and polished the patch
- The Link points to patch.msgid.link, indicating it went through the
  standard mailing list review process
- Rafael's edits (whitespace fix, braces, comment rewrite, changelog
  edits) show careful review

### 9. POTENTIAL CONCERNS

- **Could this misfire?**: Only if a device reports `rate_now == 0`
  while actually charging. But if current is truly zero, no charge is
  flowing — so "Not Charging" is semantically correct regardless of what
  the EC claims.
- **Could it break something?**: The only behavioral change is
  "Charging" → "Not Charging" when current is confirmed zero. No
  application should depend on "Charging" status when actual current is
  zero.
- **Regression risk**: Extremely low given the conservative conditions.

### Summary

This commit fixes a real, user-reported hardware bug where incorrect
"Charging" status causes significantly higher power consumption (18W vs
7W) on Huawei Matebook laptops. The fix is small (7 lines), contained to
a single file, uses only existing APIs/fields, follows an identical
well-proven pattern already in the driver since 2018 (the discharging
handler), was reviewed by the subsystem maintainer, and has essentially
zero regression risk. It meets all stable kernel criteria: obviously
correct, fixes a real bug, small and contained, no new features.

**YES**

 drivers/acpi/battery.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 34181fa52e937..4b28ef79e6ac8 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -211,7 +211,14 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
 			val->intval = acpi_battery_handle_discharging(battery);
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			/* Validate the status by checking the current. */
+			if (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
+			    battery->rate_now == 0) {
+				/* On charge but no current (0W/0mA). */
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			} else {
+				val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			}
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else if (acpi_battery_is_charged(battery))
-- 
2.51.0


