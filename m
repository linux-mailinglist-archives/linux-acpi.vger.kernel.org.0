Return-Path: <linux-acpi+bounces-12930-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E86A83372
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 23:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283273B8C38
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 21:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78D218AA3;
	Wed,  9 Apr 2025 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KghPBYDD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF2215198;
	Wed,  9 Apr 2025 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234531; cv=none; b=HCuSJJwS77Majv8glzmHnj+nDFjVZDhrneSonfve7deM9J8o8ioFxYX4VKG+S61ayxXDOT/P32h9cvh4R4bGpF63z5nZ0EVdGuBs3RStF8gx18v6+/FFeoKMIqqF3tLXW1DnX9z7CT/S28MkC53in/5HTBv7Mg85TKBk72JuYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234531; c=relaxed/simple;
	bh=4C2llIc6MRWz7oxIXggt2aY05cutgy16/vBskbmzpNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZPVjVRXKYDImb62jfW31u79BbwlZuCoE7CgyjjfSxcF6Ddxfcm01aYD714/7zGhWZ2FdXEtNsQirgk54dRW3flEL62CS4+hvZRWN98BhZMsWh5rs68eldkI9ojgMA6O/XFQQB6K6nl9JXo7gZp7SoW/OdhzuwsRWRFHSiFIcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KghPBYDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B36C4CEEB;
	Wed,  9 Apr 2025 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744234530;
	bh=4C2llIc6MRWz7oxIXggt2aY05cutgy16/vBskbmzpNk=;
	h=From:To:Cc:Subject:Date:From;
	b=KghPBYDD8+srk6yKKCgjrs9KKzLL5/zrxOymNjm0HV+oAD4Os7Lt441bWKRfCTFYT
	 o7Z4SK3MbJv4Nn3MCxRL4QrLk6o81jvLGqgKQqwq/IGUH+81EnLHhFfb/l1LrHRpF3
	 ZpG+IiD7htF2akhthr3tfMtpWs960laHGuI6UYWZsefduc59CeSb/RrOewMMAWyhJ3
	 iW15Vq4RHJlKN8o/Xj612XLr9+m6dx0849bFV5/WyNd/6E+Bou/B5Up60jtNcMis9N
	 bmDAkcibRaU2FajKrZwZFCEgBbVO5/w/cS6kUztin1K1K1LUKfV+MND7enxhUcN7LW
	 bh4luU2Al76oQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] pinctrl: amd: Fix use of undeclared identifier 'pinctrl_amd_s2idle_dev_ops'
Date: Wed,  9 Apr 2025 16:35:21 -0500
Message-ID: <20250409213521.2218692-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

`pinctrl_amd_s2idle_dev_ops` is hidden under both `CONFIG_ACPI` and
`CONFIG_PM_SLEEP` so the functions that use it need the same scope.

Adjust checks to look for both.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-lkp@intel.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index b6fafed79b289..472a5aed4cd05 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -1209,7 +1209,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpio_dev);
 	acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
-#ifdef CONFIG_ACPI
+#if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
 	acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
 #endif
 
@@ -1230,7 +1230,7 @@ static void amd_gpio_remove(struct platform_device *pdev)
 
 	gpiochip_remove(&gpio_dev->gc);
 	acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
-#ifdef CONFIG_ACPI
+#if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
 	acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
 #endif
 }
-- 
2.43.0


