Return-Path: <linux-acpi+bounces-8026-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B56966D92
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Aug 2024 02:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEA8284C0F
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Aug 2024 00:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F833FE;
	Sat, 31 Aug 2024 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="JYfRxNux"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7213A13AF9
	for <linux-acpi@vger.kernel.org>; Sat, 31 Aug 2024 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725064988; cv=none; b=dKuEzDxUR2n7lZEXvhdzAEm1uw8Kv+sukBVzynWV352/pu/oJ6utZG7IQBMK3AODVPwQ0HLcfOJ/sVfkEGPpt5zkDt6g1VjV7ajc8AF6uWLK+/n99WGKUb484H/SM24AZzcqBGBFQZR2hXLg1D/A+SIZCqLTZyxSB/YHVQ2QzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725064988; c=relaxed/simple;
	bh=x2YW7fn7RQrodtpnzt/wf/L3XuvCkcImwXBcjs4OG9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2JkQL9z0oh43hd7+2aRkko/qd7R7YqDjJLj5rdGw0Oro7c/LAjK1Ui1BoxTQK0ztgdm6Ho7j288iAyfo1Ybgw5srME7ebWWVpV1X5SItdlPxF33NFwla2kDA6JmyAFWSFyMFtQtoHQetm0uM7dbbYbnsPd6xMV3NQSO57VHb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=JYfRxNux; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 12723 invoked by uid 988); 31 Aug 2024 00:36:20 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sat, 31 Aug 2024 02:36:20 +0200
From: David Bauer <mail@david-bauer.net>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Cc: mpearson-lenovo@squebb.ca
Subject: [PATCH] ACPI: EC: add quirk for Lenovo X13 G4 (AMD)
Date: Sat, 31 Aug 2024 02:36:10 +0200
Message-ID: <20240831003610.89970-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-3) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=x2YW7fn7RQrodtpnzt/wf/L3XuvCkcImwXBcjs4OG9k=;
	b=JYfRxNuxizTwY4omJ7rDS3l9SLD/0IgZJ4JSsqX1xqwzBziaFOVnKdyvVgM4NwFtSCOn9ikV56
	UyJXnI80+1HSq8fmIWa6ysdWAFW0XYJn0hXFr87AohIo4aDLeAGDyAK8+wAoe1BkQwQ0jxblR/ZE
	Oi5loxodDPFno2TAi7wYtI28U9I1snC5ZcB3TTgMoTN4mmkaddx2wabKcqbNkGgW3jOxMJ4D6CXU
	xS8q+wiWX8KoWA3RFeESygHWXQtM9770qU7nJYLNkxLow1Nkc1VVGM2jEeSHPbPBtI1fgp/rxCWG
	u5NJZko5Cjqj7k2YP1IGRLC/3PvECzgh66ayF/9tF4ast9C9FUORPEAom02I/CKNfuVA8FtcP/Px
	C5bw2Ip4AYUtEPx6FVVl/UiYivr7qj+xE/YUzvbOpi2+C89TrijumEZalZ2vvNE23q97XhGtOoey
	suq+KPY7D/C1Y0SJ5e8RRARgztPiUKkgPG+0WWW0qL9PnBf9PhQ81QkD2pj4WSG6ve5xS2XV2H7x
	uz7RMm7PG/+4p7r88rnfpu8jgPZ7FmDHt9yBcMbefD4/XFmgZOrF38YlKNsRNFNlch7fTYR6vCxD
	r0QBWkKP4W+WC85TZiI4gzhJ+wvGDQYNSzAS2bpum9Pnj5PEYxCLhGnn/iU5cUvvVaWHnR1hdzbz
	s=

This adds a quirk for the Lenovo X13 Gen 4 AMD platform.

If booted without the kernel-parameter acpi.ec_no_wakeup=1 the system
will resume from sleep upon change of AC state. Unplugging or plugging
the power cable thus wakes the system from suspend.

Disabling wakeups from the embedded controller fixes this behavior.
Resuming by opening the lid stays functional.

Only apply this fix for the AMD version, as it is unknown if the Intel
platform is also affected.

This was observed on a system with the following BIOS / EC software:
BIOS: 1.28 (R29ET54W)
EC: 1.31 (R29HT55W)

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/acpi/ec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 38d2f6e6b12b..f00cdcf06eb8 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2252,6 +2252,13 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			/* ThinkPad X13 Gen 4 (AMD) */
+			DMI_MATCH(DMI_PRODUCT_SKU, "LENOVO_MT_21J3_BU_Think_FM_ThinkPad X13 Gen 4"),
+		},
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-- 
2.45.2


