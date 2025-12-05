Return-Path: <linux-acpi+bounces-19435-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8DCA60C0
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 04:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2F7E301836A
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 03:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5127A28850B;
	Fri,  5 Dec 2025 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UChwGJbe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA31E572F;
	Fri,  5 Dec 2025 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906778; cv=none; b=lE10De5OoMJC/whaFMORIvCVoh85a3geRtgKXCzCSrnVTLCjdS4mb7FPZ9ZxswM3tJfMuE/iJ6K5vo+6YeX+6LN+UUMBZWxuT8/LdRr18RVoQTmyX4k7r+2fFceTWEtqyIKm39+fLpsXHRJ4jbQlon5jz20oKLvZK5oT1PdMINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906778; c=relaxed/simple;
	bh=Epvpa2owJvVaP5f+at6JugZc8mEhPiJMHBO2buzfa70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nttct7XZr9rD391T066oZCyBr4D488D2ggo8BA1K/CLsFuT8C0z+wYdjZMEmewLgyt3PxR+2vbjY3LNOkqviPapFruedMHFN0l0zvSffJv4pz2a4XA9CbggAz4wGuzj9TlXTYfJO6dfvO9/pUc2Op/qgQn+saUvZmjjBq8zXFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UChwGJbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B52C116B1;
	Fri,  5 Dec 2025 03:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764906777;
	bh=Epvpa2owJvVaP5f+at6JugZc8mEhPiJMHBO2buzfa70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UChwGJbegO3yOXgytP2j9W/R4lhUpFt003kPPyPTd0lW6K3/6M6o5S4gaIY5XTj13
	 C4Oqm/ymm03KTM0JcqlNib9+9STbI0fjiImBBAlt0X2kd7UlHgpYXMX0iciArUUh7h
	 ZUClGUkgey/ARqTcMO/RC6Ha21IHVqlwr/2ooDmUGgB5hVAZz3ilaUTW3L3CCO0pMJ
	 nlxdKWItQLhxmK+3NLcaumC4vK2wYg2xxBv+04uAmh8PyppX5/Sln9y+FdDBRF8cDy
	 9NupCsTKjEJsMahKEAKR/6Cs6fyy4L56b5IsIsuyVHknVA+vwpiAkJlaHq9dn2ONHa
	 ROxIYHJgsVeWQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] ACPI: fan: Workaround for 64-bit firmware bug
Date: Thu,  4 Dec 2025 22:52:36 -0500
Message-ID: <20251205035239.341989-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205035239.341989-1-sashal@kernel.org>
References: <20251205035239.341989-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 2e00f7a4bb0ac25ec7477b55fe482da39fb4dce8 ]

Some firmware implementations use the "Ones" ASL opcode to produce
an integer with all bits set in order to indicate missing speed or
power readings. This however only works when using 32-bit integers,
as the ACPI spec requires a 32-bit integer (0xFFFFFFFF) to be
returned for missing speed/power readings. With 64-bit integers the
"Ones" opcode produces a 64-bit integer with all bits set, violating
the ACPI spec regarding the placeholder value for missing readings.

Work around such buggy firmware implementation by also checking for
64-bit integers with all bits set when reading _FST.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
[ rjw: Typo fix in the changelog ]
Link: https://patch.msgid.link/20251007234149.2769-3-W_Armin@gmx.de
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis: ACPI fan 64-bit firmware bug workaround

### 1. COMMIT MESSAGE ANALYSIS

**Subject:** `ACPI: fan: Workaround for 64-bit firmware bug`

**Key points:**
- Addresses firmware returning 64-bit all-bits-set (0xFFFFFFFFFFFFFFFF)
  instead of the spec-compliant 32-bit placeholder (0xFFFFFFFF) for
  missing readings
- No `Cc: stable@vger.kernel.org` tag
- No `Fixes:` tag
- Signed by Rafael J. Wysocki (ACPI maintainer)
- Commit date: October 8, 2025

### 2. CODE CHANGE ANALYSIS

**Files modified:** 2 files, ~40 lines added, 7 lines removed

**Changes:**

1. **`drivers/acpi/fan.h`:**
   - Adds `#include <linux/limits.h>`
   - Adds `acpi_fan_speed_valid()` and `acpi_fan_power_valid()` inline
     helpers
   - Both check `value < U32_MAX` (catches both 0xFFFFFFFF and
     0xFFFFFFFFFFFFFFFF)

2. **`drivers/acpi/fan_hwmon.c`:**
   - Removes `FAN_SPEED_UNAVAILABLE` and `FAN_POWER_UNAVAILABLE` macros
   - Replaces equality checks (`== FAN_SPEED_UNAVAILABLE`) with
     validation calls (`!acpi_fan_speed_valid()`)
   - Updates 3 locations: `is_visible()` power check, `hwmon_read()`
     speed check, `hwmon_read()` power check

**Technical mechanism:**
- ACPI spec requires 0xFFFFFFFF (32-bit) for missing readings
- Some firmware uses "Ones" ASL opcode with 64-bit integers, producing
  0xFFFFFFFFFFFFFFFF
- Current code only checks for 0xFFFFFFFF, so the 64-bit value is
  treated as valid
- Impact: incorrect readings (e.g., 18446744073709551615) reported via
  hwmon

**Why the fix works:**
- `speed < U32_MAX` correctly rejects both 0xFFFFFFFF and
  0xFFFFFFFFFFFFFFFF
- Returns `-ENODEV` (not available) instead of `-EOVERFLOW` for missing
  readings
- Centralizes validation logic

### 3. CLASSIFICATION

**Type:** Bug fix (firmware workaround)

**Exception category:** Hardware/firmware quirk/workaround — allowed in
stable per stable-kernel-rules

**Not a new feature:** Only improves validation; no new APIs or behavior
changes

### 4. SCOPE AND RISK ASSESSMENT

**Scope:**
- Small, localized change
- Only affects hwmon interface validation
- No architectural changes

**Risk:**
- Very low
- Defensive validation that doesn't change behavior for correct firmware
- Simple bounds check (`< U32_MAX`)
- No new code paths or complex logic

**Potential concerns:**
- `fan_attr.c` still prints `fst.speed` directly without validation
  (different code path, not addressed here)
- Overflow check (`fst.speed > LONG_MAX`) would catch it but returns the
  wrong error code

### 5. USER IMPACT

**Who is affected:**
- Users with buggy ACPI firmware returning 64-bit placeholder values
- Users relying on hwmon for fan monitoring

**Severity:**
- Medium — causes incorrect readings, not crashes
- Monitoring tools may show invalid values
- User confusion from huge numbers

**Real-world impact:**
- Fixes a real firmware bug
- Improves error semantics (ENODEV vs EOVERFLOW)

### 6. STABILITY INDICATORS

**Testing:**
- No explicit `Tested-by:` or `Reviewed-by:` tags
- Signed by ACPI maintainer (Rafael J. Wysocki)

**Age:**
- Commit is recent (October 2025)
- No indication of long-term testing in mainline

### 7. DEPENDENCY CHECK

**Critical dependency:**
- Requires hwmon support (`drivers/acpi/fan_hwmon.c`)
- Hwmon support added in commit `35c50d853adc0` (May 2024, "ACPI: fan:
  Add hwmon support")

**Backport implications:**
- Only applies to stable trees that have hwmon support
- For trees without hwmon, this commit doesn't apply (no functional
  impact)
- If hwmon exists, the fix applies cleanly

**Other dependencies:**
- `linux/limits.h` (U32_MAX) — standard header, available in all stable
  trees
- No other code dependencies

### 8. STABLE KERNEL RULES COMPLIANCE

**Meets criteria:**
1. Obviously correct — simple bounds check
2. Fixes a real bug — incorrect readings from buggy firmware
3. Important issue — affects monitoring accuracy
4. Small and contained — ~40 lines, 2 files
5. No new features — only validation improvement
6. Applies cleanly — straightforward change

**Exception applies:**
- Hardware/firmware workaround — explicitly allowed

**Missing signals:**
- No `Cc: stable@vger.kernel.org` tag
- No `Fixes:` tag
- No bug report link in commit message

### 9. RISK VS BENEFIT TRADE-OFF

**Benefits:**
- Fixes incorrect readings from buggy firmware
- Improves error semantics
- Low risk, defensive change
- Better compatibility with non-compliant firmware

**Risks:**
- Very low — simple validation logic
- No behavior change for correct firmware
- No new code paths

**Verdict:** Benefits outweigh risks

### 10. ADDITIONAL CONSIDERATIONS

**Incomplete fix:**
- `fan_attr.c:show_fan_speed()` still prints `fst.speed` without
  validation
- This commit only fixes hwmon, not sysfs attributes
- Not a blocker for backport, but a limitation

**Error code improvement:**
- Current code would return `-EOVERFLOW` for 0xFFFFFFFFFFFFFFFF
- Fix returns `-ENODEV` (more accurate)

**Firmware compatibility:**
- Works with both spec-compliant and buggy firmware
- No regressions expected

### FINAL ASSESSMENT

**Should this be backported to stable?** YES

**Reasoning:**
1. Fixes a real bug affecting users with buggy firmware
2. Small, contained, low-risk change
3. Qualifies as a firmware workaround (allowed exception)
4. Improves error handling semantics
5. No new features or APIs
6. Applies cleanly to trees with hwmon support

**Recommendations:**
- Backport to stable trees that include hwmon support (likely 6.6.y and
  newer)
- For older trees without hwmon, not applicable (no functional impact)
- Consider fixing `fan_attr.c` in a follow-up commit

**YES**

 drivers/acpi/fan.h       | 33 +++++++++++++++++++++++++++++++++
 drivers/acpi/fan_hwmon.c | 10 +++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index bedbab0e8e4e9..0d73433c38892 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -11,6 +11,7 @@
 #define _ACPI_FAN_H_
 
 #include <linux/kconfig.h>
+#include <linux/limits.h>
 
 #define ACPI_FAN_DEVICE_IDS	\
 	{"INT3404", }, /* Fan */ \
@@ -60,6 +61,38 @@ struct acpi_fan {
 	struct device_attribute fine_grain_control;
 };
 
+/**
+ * acpi_fan_speed_valid - Check if fan speed value is valid
+ * @speeed: Speed value returned by the ACPI firmware
+ *
+ * Check if the fan speed value returned by the ACPI firmware is valid. This function is
+ * necessary as ACPI firmware implementations can return 0xFFFFFFFF to signal that the
+ * ACPI fan does not support speed reporting. Additionally, some buggy ACPI firmware
+ * implementations return a value larger than the 32-bit integer value defined by
+ * the ACPI specification when using placeholder values. Such invalid values are also
+ * detected by this function.
+ *
+ * Returns: True if the fan speed value is valid, false otherwise.
+ */
+static inline bool acpi_fan_speed_valid(u64 speed)
+{
+	return speed < U32_MAX;
+}
+
+/**
+ * acpi_fan_power_valid - Check if fan power value is valid
+ * @power: Power value returned by the ACPI firmware
+ *
+ * Check if the fan power value returned by the ACPI firmware is valid.
+ * See acpi_fan_speed_valid() for details.
+ *
+ * Returns: True if the fan power value is valid, false otherwise.
+ */
+static inline bool acpi_fan_power_valid(u64 power)
+{
+	return power < U32_MAX;
+}
+
 int acpi_fan_get_fst(acpi_handle handle, struct acpi_fan_fst *fst);
 int acpi_fan_create_attributes(struct acpi_device *device);
 void acpi_fan_delete_attributes(struct acpi_device *device);
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index 4b2c2007f2d7f..47a02ef5a6067 100644
--- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -15,10 +15,6 @@
 
 #include "fan.h"
 
-/* Returned when the ACPI fan does not support speed reporting */
-#define FAN_SPEED_UNAVAILABLE	U32_MAX
-#define FAN_POWER_UNAVAILABLE	U32_MAX
-
 static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan, u64 control)
 {
 	unsigned int i;
@@ -77,7 +73,7 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
 			 * when the associated attribute should not be created.
 			 */
 			for (i = 0; i < fan->fps_count; i++) {
-				if (fan->fps[i].power != FAN_POWER_UNAVAILABLE)
+				if (acpi_fan_power_valid(fan->fps[i].power))
 					return 0444;
 			}
 
@@ -106,7 +102,7 @@ static int acpi_fan_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_fan:
 		switch (attr) {
 		case hwmon_fan_input:
-			if (fst.speed == FAN_SPEED_UNAVAILABLE)
+			if (!acpi_fan_speed_valid(fst.speed))
 				return -ENODEV;
 
 			if (fst.speed > LONG_MAX)
@@ -134,7 +130,7 @@ static int acpi_fan_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			if (!fps)
 				return -EIO;
 
-			if (fps->power == FAN_POWER_UNAVAILABLE)
+			if (!acpi_fan_power_valid(fps->power))
 				return -ENODEV;
 
 			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
-- 
2.51.0


