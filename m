Return-Path: <linux-acpi+bounces-15877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E35E1B2E8AE
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 01:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CCF5E5B4C
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 23:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255932DF3CC;
	Wed, 20 Aug 2025 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojKQZf6T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262D1DDC2A;
	Wed, 20 Aug 2025 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732803; cv=none; b=s8Er6GcaSA05dTAdtV8S2FULs4lSGpWhYn+gqFOacyT8yucu0SOfsYfbjNMsW1A5hrbGW18wqsR7LnqztvBW8aoe1TF+71UIIXZUmprVjkcPuw2Rwrxv9PY3wBwBSPjTopafSjdUNoBcKtwPeewx/+tUrNMDMW54ewYrpHsQY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732803; c=relaxed/simple;
	bh=Gr/ztQWBjAac+jqz97r6qaLSkv4YAlZJB/6NqCYiY0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyD208wTcHkofBgjK8MNBIBzWGjZK3TlnTTV2l5syKjwHeOllLhLm5bBMhgF5fbw/ldd04M3x5pCLpbgqeLgJ40ZinLFIhI03jXxg1DRtuwMoKm0hlmeWktriKLRFzNMUUz3hEiLrel/p1u9GJtIT/3KH/dI621k1lrD+0vCW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojKQZf6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6831C4CEE7;
	Wed, 20 Aug 2025 23:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755732802;
	bh=Gr/ztQWBjAac+jqz97r6qaLSkv4YAlZJB/6NqCYiY0A=;
	h=From:To:Cc:Subject:Date:From;
	b=ojKQZf6TDuiH6EGPKcPmDsypuQU00HarHMlQ9T8LpYhsduvUK8KUCoYVKVQV5N3Ah
	 Bx4QrfL/winJ5bMCarJgfSKnY3DgoSCN6ANzlmcF/rQKV906mfDV8WFW62EisMEuHL
	 8HY34JmUAyoNxs8YLZXtZiE9R9/R3pNk+RfKbJVEzMGF4AMVLBG4gindHIbZaXzCON
	 v7n9P/LGoA9vQN4S15J8yXtss6/IjbhywojMqHxux0GS1fNipvuY51waANvXY8uWcJ
	 bWQTVTi3edIXN3aqHUoxZcYozZVZ0a0QGRzQoCtIqnz+jiH7MEg8u4j+crU5dH3u1m
	 O1xm6K0X/TKCA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	westeri@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v5] gpiolib: acpi: Program debounce when finding GPIO
Date: Wed, 20 Aug 2025 18:33:11 -0500
Message-ID: <20250820233316.1433141-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When soc-button-array looks up the GPIO to use it calls acpi_find_gpio()
which will parse _CRS.

acpi_find_gpio.cold (drivers/gpio/gpiolib-acpi-core.c:953)
gpiod_find_and_request (drivers/gpio/gpiolib.c:4598 drivers/gpio/gpiolib.c:4625)
gpiod_get_index (drivers/gpio/gpiolib.c:4877)

The GPIO is setup basically, but the debounce information is discarded.
The platform will assert what debounce should be in _CRS, so program it
at the time it's available.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * pick up tag
---
 drivers/gpio/gpiolib-acpi-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 12b24a717e43f..6388e8e363dee 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -944,6 +944,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
+	int ret;
 
 	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
 	if (IS_ERR(desc))
@@ -957,6 +958,11 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 
 	acpi_gpio_update_gpiod_flags(dflags, &info);
 	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
+	/* ACPI uses hundredths of milliseconds units */
+	ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return desc;
 }
 
-- 
2.43.0


