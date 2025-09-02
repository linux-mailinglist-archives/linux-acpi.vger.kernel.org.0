Return-Path: <linux-acpi+bounces-16276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE747B3FFE7
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 14:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354755445E6
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 12:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05737303C87;
	Tue,  2 Sep 2025 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiuGxnBk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B15288C20;
	Tue,  2 Sep 2025 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814916; cv=none; b=b1T0z+Us6GcRJTa7ag4esSOT/cOJD28rOBPXBUDl8DZDBHO/2pa4lTcfTlLwHTXEmjx4n0p0GhXf+wPqpWPolqBI62w7fYwUrjrLQJpgcdut39H3FilV4/870TbAr4WVgsGQL43uirwD3nNVyr4aT6QAZXu0LFHJ37fTs6zhD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814916; c=relaxed/simple;
	bh=ZPf10cXY2km1B/FVleWiffi1jphCqVPdfHT9UPrkwwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JpweuvdkdgLuvPf8YvvyUpqpajwpchEn8+P+Ut5asTwDVOY1Tdi0d0wW3+nNbk58kCbazKhrG1EjQL3DtjF64ufvu6ahoqQ0/77t3Tfm4yGnE7NqiSeEzxpFroCX0DzhDqU+wihYlkzZnI8fK12eB5fOkA8B9unRH2FDMnRt3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiuGxnBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B238C4CEED;
	Tue,  2 Sep 2025 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756814916;
	bh=ZPf10cXY2km1B/FVleWiffi1jphCqVPdfHT9UPrkwwo=;
	h=From:To:Cc:Subject:Date:From;
	b=oiuGxnBk/8quYXPsfzqBm7ce0j/ZCGpRAyoCPjWmIPvVWTkDxk9Fc88foovL2DSlm
	 ZnHsFZ/ZZH/m3lfYUJ9V4Fmtgi6QmfaInaEtFFtbRYWBJ8OtVB4FCTCuaeZTGyTTcO
	 f8vxmer0gi1hUohvgWQPO6/kZwnpyi65XNLj2axScHn3K2OQLEesu+h9umUYgwvnNj
	 pXVDavGkq19mn3SqhXufvOouCB2kAgJ6Ach+eMGW4qPgU1A0tTJRzwmnOI0bygkuGZ
	 hLs8Ci+33AtMLwB0Yp6/FWkDYpnbyt/hHb1fVnUeq6PPMveHaC190aEAjYWZaV8sN6
	 Avi1h+ec0TDBQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Amit Chaudhari <amitchaudhari@mac.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	westeri@kernel.org,
	andriy.shevchenko@linux.intel.com,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16] gpiolib: acpi: Add quirk for ASUS ProArt PX13
Date: Tue,  2 Sep 2025 08:08:12 -0400
Message-ID: <20250902120833.1342615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[ Upstream commit 23800ad1265f10c2bc6f42154ce4d20e59f2900e ]

The ASUS ProArt PX13 has a spurious wakeup event from the touchpad
a few moments after entering hardware sleep.  This can be avoided
by preventing the touchpad from being a wake source.

Add to the wakeup ignore list.

Reported-by: Amit Chaudhari <amitchaudhari@mac.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4482
Tested-by: Amit Chaudhari <amitchaudhari@mac.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://lore.kernel.org/20250814183430.3887973-1-superm1@kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis of this commit and the context, here
is my assessment:

**Backport Status: YES**

## Extensive Analysis:

### 1. **Nature of the Fix**
This commit fixes a real hardware bug - spurious wakeup events from the
touchpad on the ASUS ProArt PX13 laptop. The code change adds a DMI-
based quirk entry to the `gpiolib_acpi_quirks` table in
`/home/sasha/linux/drivers/gpio/gpiolib-acpi-quirks.c:350-359`, which
instructs the GPIO subsystem to ignore wake events from the specific
touchpad GPIO pin (`ASCP1A00:00@8`).

### 2. **符合稳定内核规则 (Meets Stable Kernel Rules)**
According to `/home/sasha/linux/Documentation/process/stable-kernel-
rules.rst`:
- **Fixes a real bug**: Yes - spurious wakeups are a real hardware issue
  that impacts users' ability to use sleep/suspend effectively (lines
  18-19 of rules)
- **Obviously correct and tested**: Yes - the fix is straightforward
  (adding a quirk entry), has been tested by the reporter (Amit
  Chaudhari), and reviewed by Mika Westerberg
- **Size constraint**: The patch is only ~20 lines with context, well
  under the 100-line limit
- **Already in mainline**: Yes - commit
  23800ad1265f10c2bc6f42154ce4d20e59f2900e

### 3. **Historical Precedent**
Multiple similar commits for spurious wakeup quirks have been backported
to stable:
- Commit `805c74eac8cb3` (GPD G1619-04 touchpad wakeup) - explicitly
  marked with `Cc: stable@vger.kernel.org`
- Commit `782eea0c89f7d` (Clevo NL5xNU) - marked with `Cc:
  stable@vger.kernel.org`
- Commit `a69982c37cd05` (Clevo NH5xAx) - marked with `Cc:
  <stable@vger.kernel.org> # v6.1+`

### 4. **Code Structure Analysis**
The change follows the exact same pattern as other quirk entries in the
file:
```c
.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
    .ignore_wake = "ASCP1A00:00@8",
},
```
This is a data-only addition to an existing quirk table - no logic
changes, no new code paths, minimal regression risk.

### 5. **User Impact**
The bug causes spurious wakeups "a few moments after entering hardware
sleep", which:
- Prevents proper system suspend/sleep functionality
- Drains battery life on laptops
- Disrupts user workflow
- Is a clear hardware-specific issue that cannot be worked around by
  users

### 6. **Risk Assessment**
- **Extremely low risk**: The change only affects systems that match the
  specific DMI strings (ASUSTeK COMPUTER INC. + ProArt PX13)
- **No impact on other systems**: DMI matching ensures this quirk only
  applies to the affected hardware
- **Well-established mechanism**: The ignore_wake infrastructure is
  mature and widely used

### 7. **Backporting Considerations**
While this specific commit wasn't explicitly marked with `Cc: stable`,
it follows the exact same pattern as commits that were. The commit has
already been picked up by Sasha Levin's stable tree (as shown in the `[
Upstream commit ]` tag in the local repository), suggesting the stable
maintainers recognize its importance.

The fix is self-contained, requires no prerequisites, and can be cleanly
applied to any kernel version that has the `gpiolib-acpi-quirks.c` file
structure (introduced in commit `92dc572852ddc`).

### Conclusion
This is a textbook example of a stable-appropriate fix: it addresses a
specific hardware bug affecting real users, uses a well-established
quirk mechanism, has zero impact on unaffected systems, and follows the
exact pattern of previously backported fixes for identical issues on
different hardware.

 drivers/gpio/gpiolib-acpi-quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index c13545dce3492..bfb04e67c4bc8 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -344,6 +344,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@8",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 5.35
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/4482
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt PX13"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "ASCP1A00:00@8",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.50.1


