Return-Path: <linux-acpi+bounces-16134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F47B39AE3
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 13:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040AF560A14
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F135130E0E0;
	Thu, 28 Aug 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omqWf+bk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437330BBA5;
	Thu, 28 Aug 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378925; cv=none; b=Lu3ruVaeP8rj06MiBk1PIYrPXPf6dgMTR8yMgwUg9/j+qM/IGSV9EhZAUBGAHy9PkP4gJ+CwlEuCeebr/nIFhM4y6wr3V2GQxFALlDmORi74H0D1kQf6Bia7UZDW1ruB12vwA/5BE1e0MMZnuS4RawFpuiNhUNUFlLcnTyXzuSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378925; c=relaxed/simple;
	bh=oVhq1BnzHltu6MYAZKU0miuwxHCzawaJs4s8iYb7sfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JseHQBYVLZU3ut/x7vmjwbjr6uDMRepnDFHls15djfEyzp7my9mm9hdWJt4s2x3IuB/qiR8hIivgpw49bSkHa9SnIUQq/UznF20BcZNCjHzi8MEL5vov4XHX49rf9R7eBmsA2+IFx8IM6AaqSYep7zKKhYVB2+VvFn5F6ByJSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omqWf+bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5381AC4CEEB;
	Thu, 28 Aug 2025 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756378925;
	bh=oVhq1BnzHltu6MYAZKU0miuwxHCzawaJs4s8iYb7sfM=;
	h=From:To:Cc:Subject:Date:From;
	b=omqWf+bksS3wgZQrkQ4/ofQO5bRwa9MaU09r/3tJ98Z5MpPzBuRJ3DJPnusPA4Sso
	 otNz2SPQvj0ZqQ28RIsdTI2a4zYCAFQH/cbl0TsMkfUYDc0s9HhPSpLGnEMHwYd9hB
	 fmgVmm+OIuV5icRbvjJcdImHFJGSgiSPLr+2ZpTdzxiDUGabkbzKMlM3oCLBIOd61M
	 jcJKnYPblpPy8uOF/aPExF0MNRhpQKTSqkjp8VsK69yLPK1IuhrvW1MzqVzjkn901L
	 u7UnZr7HpMcQUgeoxFQINFFvPQYA+Tc3ZgKEN2DwWcekpuZWf6mQ+fo38Ud4QaOSOc
	 npwySVjHv9fMQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1] ACPI: thermal: Get rid of a dummy local variable
Date: Thu, 28 Aug 2025 13:02:01 +0200
Message-ID: <13851842.uLZWGnKmhe@rafael.j.wysocki>
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

The second argument of acpi_bus_update_power() can be NULL, so drop the
power_state dummy local variable in acpi_thermal_resume() used just for
avoiding passing NULL as the second argument to that function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -924,7 +924,7 @@
 static int acpi_thermal_resume(struct device *dev)
 {
 	struct acpi_thermal *tz;
-	int i, j, power_state;
+	int i, j;
 
 	if (!dev)
 		return -EINVAL;
@@ -939,10 +939,8 @@
 		if (!acpi_thermal_trip_valid(acpi_trip))
 			break;
 
-		for (j = 0; j < acpi_trip->devices.count; j++) {
-			acpi_bus_update_power(acpi_trip->devices.handles[j],
-					      &power_state);
-		}
+		for (j = 0; j < acpi_trip->devices.count; j++)
+			acpi_bus_update_power(acpi_trip->devices.handles[j], NULL);
 	}
 
 	acpi_queue_thermal_check(tz);




