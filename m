Return-Path: <linux-acpi+bounces-21054-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLOwKEZ0nGmcGAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21054-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:37:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E004178D50
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A32D30094F9
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1302F39B9;
	Mon, 23 Feb 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huqVQ6Ik"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEA12ED15D;
	Mon, 23 Feb 2026 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860834; cv=none; b=GYa1DDAe+Bhg9JB53XJxJ3zgGOYep7qekA1MeUMC7JsNiJZbOZKbRdzIKp+IaR+/H9plSgwN1nIjM4Ht2s7w33hXnhZSaof+Xv0YiGU8t7OAfK4dl/QeeMJkz7UvC+DpsrjdEtdDrfGs8ustZEqnG4uF93WY89AAb4HRfx2MNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860834; c=relaxed/simple;
	bh=Ufzp8Tax/XN6GRzoAArGc4ZHLmHcX/nHrE2dRsFMiuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZkA0rS8X/aWXyNNWVs/VrTP2EGGnEqPI6qFTW0S1OLTFdOnQSiultQI6a39tjFqJ1O2DXRjF756P2OgMOOEZNfFHuqZl2WVGuFY91vhZF1UemAq7HoIin2cKh4iOU5AE/laraApPZEWbK1mKeHKjupPJZJfmMLkrnNqEP7YnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huqVQ6Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892DBC116D0;
	Mon, 23 Feb 2026 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860833;
	bh=Ufzp8Tax/XN6GRzoAArGc4ZHLmHcX/nHrE2dRsFMiuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huqVQ6IkcUXhnaTFz9jjV632NlJcUux432SgRYmKPpD4UqNjSkzkk6vXEr2BaakzD
	 6AsDTp09LVUFnQbu7d5XE2+Lh6jkpcS/SZHZYZIT5xFY3tEU9441d9tlp2twTHPsx1
	 cUHvF8zUUQGtNVzWCOhIjpJxjoMWrcOw4L7e4VpBMGEJtur+J6fTAjdCiHCIEHVK5w
	 VoLXn8HRvJgGoYzrSU+aNC3sibbEBcYZKWj4eq6T8Y656xr+yYXG5/Qs57b3I9wn0x
	 f8i2VxDC2rgNkJHo2uhbT3FDD34IAWP5EGpA3AC4LVwT+YEeomQpW4tVvhbPMM13zj
	 VMo95vPvSmoGg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 6/8] x86: rtc: Drop PNP device check
Date: Mon, 23 Feb 2026 16:31:49 +0100
Message-ID: <8660687.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5983325.DvuYhMxLoT@rafael.j.wysocki>
References: <5983325.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21054-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 1E004178D50
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Previous changes effectively prevented PNP devices from being created
for the CMOS RTC on x86 with ACPI.

Although in principle a CMOS RTC PNP device may exist on an x86 system
without ACPI (that is, an x86 system where there is no ACPI at all, not
one booted with ACPI disabled), such systems were there in the field ~30
years ago and most likely they would not be able to run a contemporary
Linux kernel.

For the above reasons, drop the PNP device check from add_rtc_cmos().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/rtc.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index b112178e8185..314b062a15de 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -6,7 +6,6 @@
 #include <linux/platform_device.h>
 #include <linux/mc146818rtc.h>
 #include <linux/export.h>
-#include <linux/pnp.h>
 
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
@@ -134,19 +133,6 @@ static struct platform_device rtc_device = {
 
 static __init int add_rtc_cmos(void)
 {
-#ifdef CONFIG_PNP
-	static const char * const ids[] __initconst =
-	    { "PNP0b00", "PNP0b01", "PNP0b02", };
-	struct pnp_dev *dev;
-	int i;
-
-	pnp_for_each_dev(dev) {
-		for (i = 0; i < ARRAY_SIZE(ids); i++) {
-			if (compare_pnp_id(dev->id, ids[i]) != 0)
-				return 0;
-		}
-	}
-#endif
 	if (cmos_rtc_platform_device_present)
 		return 0;
 
@@ -154,8 +140,7 @@ static __init int add_rtc_cmos(void)
 		return -ENODEV;
 
 	platform_device_register(&rtc_device);
-	dev_info(&rtc_device.dev,
-		 "registered platform RTC device (no PNP device found)\n");
+	dev_info(&rtc_device.dev, "registered fallback platform RTC device\n");
 
 	return 0;
 }
-- 
2.51.0





