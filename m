Return-Path: <linux-acpi+bounces-11053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8631AA316AE
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 21:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE4A3A6BB8
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310BE26158B;
	Tue, 11 Feb 2025 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCNT6rVb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE126562F;
	Tue, 11 Feb 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305956; cv=none; b=Vc7u2ftLS99SUbRrnCywhjEBJcTlKA0ifBtVLtk7fhfhiAKyNDi5gXbZjFh1LqvxZk5j8My6Vvv2tvM8+tGYgROFbWAd+PAKxNHj3KfWSIWeSpvHcPCKiY8BCpgq+Zk+6WG9CrrDWq4aSAsfYY9jJRvQ4/k5l0suB++5KOuIf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305956; c=relaxed/simple;
	bh=YwqbFY8kQo+k/M9mG0aEQqMh0W+Fv1ls/QqF2dj3uBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iY41b1iMccz0wMgQ7QFcjj/QKQkxfXPPfcuPr7x8Nhxv+I869zvLYujSJ/3Ix4bvalJzIgo24QcvqS+yuV63YCYN+/RJbD5/Zt4FuUaMQrqWygqEgxLRvbQeX0wVKM88dzXn7oYW/CsQotwHa5qsrP/H+SkGglu76cC1qMNK8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCNT6rVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A97C4CEDD;
	Tue, 11 Feb 2025 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739305954;
	bh=YwqbFY8kQo+k/M9mG0aEQqMh0W+Fv1ls/QqF2dj3uBU=;
	h=From:To:Cc:Subject:Date:From;
	b=NCNT6rVbUC215i2jkP9u2t0CEQ7Y/gw5BzRB51yr6RqQJ6DKuR+P4jRZaH/eXR/WS
	 peHPKNiMdqWxnPiRh63tAPyfCxyE1j6mIqLagZd3rLYYKdFs52sTWxQt++YX2tJCAf
	 uJAVY70EMhaRzhMBAbTKANfmfjT/nEYrxgB/Un+1Z1s6ugT6d2ZVyq4pADeIeZLgGg
	 G+GDwai0SZuNfl04LUgvtESUtKSSPQxDs+7fIfFhId+m6t9h+1aOkVoxfpGqNaASCX
	 06r8o2/zXAOn+w9eGaH2lkN47NuIUjSP5x+3HDpFIbElOOiPzTqoKT4ulBU0pRIU6x
	 M/BdAodAMPfNw==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	westeri@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl
Cc: stable@vger.kernel.org,
	Delgan <delgan.py@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: Add a quirk for Acer Nitro ANV14
Date: Tue, 11 Feb 2025 14:32:01 -0600
Message-ID: <20250211203222.761206-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Spurious immediate wake up events are reported on Acer Nitro ANV14. GPIO 11 is
specified as an edge triggered input and also a wake source but this pin is
supposed to be an output pin for an LED, so it's effectively floating.

Block the interrupt from getting set up for this GPIO on this device.

Cc: stable@vger.kernel.org
Reported-and-tested-by: Delgan <delgan.py@gmail.com>
Close: https://gitlab.freedesktop.org/drm/amd/-/issues/3954
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpio/gpiolib-acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 1f9fe50bba005..f7746c57ba76a 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1689,6 +1689,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "PNP0C50:00@8",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from GPIO 11
+		 * Found in BIOS 1.04
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3954
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Acer Nitro V 14"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "AMDI0030:00@11",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.43.0


