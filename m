Return-Path: <linux-acpi+bounces-20230-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E72D5D191F5
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 14:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A28A43011FAB
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F15738FF0B;
	Tue, 13 Jan 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFBIn8Kb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052118B0A;
	Tue, 13 Jan 2026 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311524; cv=none; b=NAaZRljejQYQVED33Ehs7ec/ZJv5qn45HtzkjClNflOD9oMFrBW0IqCO2jPAgIEf5/1XZPWQVeyu0P4AgqKFOLR4BvQS1INAjMbg3M/jn995Nq5JlQLUsGnhMTIVuLxqt1dN7M52hxPP75sGW6wd52FAbsUmfp+If0VMz1fCmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311524; c=relaxed/simple;
	bh=MBaw2R/jcxAXEIy/qN0L18PjZY/mSDLRsy/NYwhiOBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p6OvcIC/IAE6xp56vy+sTCx0Tsbc9fRwCqU0Ot9V2BbnO6cITZ1SiIUEI/iVzp6Q4crUGnmf9uTMEJCecp88MVaFg/bkoq14TUShoot5P4Ad876VdVrWwlJwnhWFMUFBmwmV/tq+g6UmBQ149WCA8AT6DGdo31gu5nyuPgSmo24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFBIn8Kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B54C116C6;
	Tue, 13 Jan 2026 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768311523;
	bh=MBaw2R/jcxAXEIy/qN0L18PjZY/mSDLRsy/NYwhiOBc=;
	h=From:To:Cc:Subject:Date:From;
	b=XFBIn8KbeWunzDjhJIrBg/9UpTepZ8VMJVR5CGYBX2kBnNtPMaiOT3R5mOAhAC/j/
	 HWZC0o+WyNo3MGzn10Gd0Zv77ylvNV1OYURIUnWuo+nDoT7cMK7avbrGC5tRGNa+n6
	 odzncKfmqR6QBL6xHoKuPjDUCEOqHtJCdQslBFY2QYGqZgUx/T1i1vnGpODSO7yo6k
	 vEr4/tg+sTz3SGBZ9WLwZHDMsm+cgTtbq2S/qBFGuJAf24X2gpard8mjKuyUVARTS6
	 zofxXd/XYwzEW/q3f8pmhhl/MWY5Mlu1UTaHqlzQp3VaI7efGdQxsgB2iHfFTsJQtW
	 LaDqU3VbasB5g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v1] ACPI: PM: Adjust messages regarding postponed ACPI PM
Date: Tue, 13 Jan 2026 14:38:41 +0100
Message-ID: <5969819.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The debug messages added by commit f7599be2bb76 ("ACPI: PM: postpone
bringing devices to D0 unless we need them") in acpi_subsys_resume_early()
and acpi_subsys_resume() are not quite accurate because what is postponed
is not just a transition to D0, but also an adjustment of the device's
wakeup setting (which may involve disabling a GPE among other things).
Moreover, these messages don't even mention ACPI.

Rephrase them and adjust the style to match other messages in device_pm.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1251,7 +1251,7 @@ static int acpi_subsys_resume_early(stru
 		return 0;
 
 	if (pm && !pm->resume_early) {
-		dev_dbg(dev, "postponing D0 transition to normal resume stage\n");
+		dev_dbg(dev, "Postponing ACPI PM to normal resume stage\n");
 		return 0;
 	}
 
@@ -1273,7 +1273,7 @@ static int acpi_subsys_resume(struct dev
 	int ret = 0;
 
 	if (!dev_pm_skip_resume(dev) && pm && !pm->resume_early) {
-		dev_dbg(dev, "executing postponed D0 transition\n");
+		dev_dbg(dev, "Applying postponed ACPI PM\n");
 		ret = acpi_dev_resume(dev);
 	}
 




