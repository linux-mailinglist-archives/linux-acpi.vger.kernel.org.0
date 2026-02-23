Return-Path: <linux-acpi+bounces-21053-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P6PE4tznGmcGAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21053-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:34:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75848178C7A
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB0E23034B02
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF762EBDFA;
	Mon, 23 Feb 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf8Md06/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2222EAB61;
	Mon, 23 Feb 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860830; cv=none; b=EztXPDwNrzHpp2iR2yRr0e+rReeRta+VeEHfI7T0VXLiVnIhvFcvWdZfZ1H+Cf7J+LpgEvvmh2zyk+gmQjDuuZtgOabaU2T5UqnMmwRQTrF1gnk+GQbQJ0lF82cRxqedwpnoFATresleKD/ds6V4mgbTBM0YMi52oay1km9AU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860830; c=relaxed/simple;
	bh=KUh/wdz4o/ak+NTW79FlOzH8EePib+aTr/uBTxCk+IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdoaM0ZfsCOxXoEyqofAC61/xwKvZcbpobc9kEDo8xtvzQ3Vz/aDhKruMOHKJjLRCkdJvfY4gK+jstAdanOazz+tLSRwIQWQ0qRZJaCeXD2tO+3/jVebGNXPylu4DDSSW6J9Z12g76qUB7VTA2RrvjU0W+bPdeCOk4TGT716RPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf8Md06/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3831C116D0;
	Mon, 23 Feb 2026 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860830;
	bh=KUh/wdz4o/ak+NTW79FlOzH8EePib+aTr/uBTxCk+IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pf8Md06/Q/l8qVSOoeCOVhy1dRTHrIG1aJ11y2r6uj6BEOdRy/mguEjrB/FvCaNUq
	 wf0e3+iPhd0DW0eHFscsQPNgRk5yJFf6utdOzXbwDhL4zEsBJY42MUjpLFG0EZq7WG
	 TnPC8rwTaYDiB6lmM7yeqcbEPyUDSVNe5+tzGW0FDQP45gM/+S1elPD8DneDZuDwAM
	 3pFiJZMbaBv07nWoPHfvG1FljKX/I6O/TLvO2f8IypJFdiMeoZ8fsBeqVQXiK6Qj1I
	 ENLdnma+td7XkLxqHBav67DLDIt9PRyF3S0+ws7mVJfLT5Lve666GL5wnppLAUVgMU
	 ewlhjSuVEaxtw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 7/8] rtc: cmos: Drop PNP device support
Date: Mon, 23 Feb 2026 16:32:29 +0100
Message-ID: <2355012.iZASKD2KPV@rafael.j.wysocki>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21053-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75848178C7A
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Previous changes effectively prevented PNP devices from being created
for the CMOS RTC on x86 with ACPI.

Although in principle a CMOS RTC PNP device may exist on an x86 system
without ACPI (that is, an x86 system where there is no ACPI at all, not
one booted with ACPI disabled), such systems were there in the field ~30
years ago and most likely they would not be able to run a contemporary
Linux kernel.

For the above reasons, drop the PNP device support from the rtc-cmos
driver.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/rtc/rtc-cmos.c | 113 +++--------------------------------------
 1 file changed, 8 insertions(+), 105 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 7457f42fd6f0..9ac5bab846c1 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1370,85 +1370,6 @@ static int __maybe_unused cmos_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(cmos_pm_ops, cmos_suspend, cmos_resume);
 
-/*----------------------------------------------------------------*/
-
-/* On non-x86 systems, a "CMOS" RTC lives most naturally on platform_bus.
- * ACPI systems always list these as PNPACPI devices, and pre-ACPI PCs
- * probably list them in similar PNPBIOS tables; so PNP is more common.
- *
- * We don't use legacy "poke at the hardware" probing.  Ancient PCs that
- * predate even PNPBIOS should set up platform_bus devices.
- */
-
-#ifdef	CONFIG_PNP
-
-#include <linux/pnp.h>
-
-static int cmos_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
-{
-	int irq;
-
-	if (pnp_port_start(pnp, 0) == 0x70 && !pnp_irq_valid(pnp, 0)) {
-		irq = 0;
-#ifdef CONFIG_X86
-		/* Some machines contain a PNP entry for the RTC, but
-		 * don't define the IRQ. It should always be safe to
-		 * hardcode it on systems with a legacy PIC.
-		 */
-		if (nr_legacy_irqs())
-			irq = RTC_IRQ;
-#endif
-	} else {
-		irq = pnp_irq(pnp, 0);
-	}
-
-	return cmos_do_probe(&pnp->dev, pnp_get_resource(pnp, IORESOURCE_IO, 0), irq);
-}
-
-static void cmos_pnp_remove(struct pnp_dev *pnp)
-{
-	cmos_do_remove(&pnp->dev);
-}
-
-static void cmos_pnp_shutdown(struct pnp_dev *pnp)
-{
-	struct device *dev = &pnp->dev;
-	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
-
-	if (system_state == SYSTEM_POWER_OFF) {
-		int retval = cmos_poweroff(dev);
-
-		if (cmos_aie_poweroff(dev) < 0 && !retval)
-			return;
-	}
-
-	cmos_do_shutdown(cmos->irq);
-}
-
-static const struct pnp_device_id rtc_ids[] = {
-	{ .id = "PNP0b00", },
-	{ .id = "PNP0b01", },
-	{ .id = "PNP0b02", },
-	{ },
-};
-MODULE_DEVICE_TABLE(pnp, rtc_ids);
-
-static struct pnp_driver cmos_pnp_driver = {
-	.name		= driver_name,
-	.id_table	= rtc_ids,
-	.probe		= cmos_pnp_probe,
-	.remove		= cmos_pnp_remove,
-	.shutdown	= cmos_pnp_shutdown,
-
-	/* flag ensures resume() gets called, and stops syslog spam */
-	.flags		= PNP_DRIVER_RES_DO_NOT_CHANGE,
-	.driver		= {
-			.pm = &cmos_pm_ops,
-	},
-};
-
-#endif	/* CONFIG_PNP */
-
 #ifdef CONFIG_OF
 static const struct of_device_id of_cmos_match[] = {
 	{
@@ -1543,45 +1464,27 @@ static struct platform_driver cmos_platform_driver = {
 	}
 };
 
-#ifdef CONFIG_PNP
-static bool pnp_driver_registered;
-#endif
 static bool platform_driver_registered;
 
 static int __init cmos_init(void)
 {
-	int retval = 0;
+	int retval;
 
-#ifdef	CONFIG_PNP
-	retval = pnp_register_driver(&cmos_pnp_driver);
-	if (retval == 0)
-		pnp_driver_registered = true;
-#endif
+	if (cmos_rtc.dev)
+		return 0;
 
-	if (!cmos_rtc.dev) {
-		retval = platform_driver_probe(&cmos_platform_driver,
-					       cmos_platform_probe);
-		if (retval == 0)
-			platform_driver_registered = true;
-	}
+	retval = platform_driver_probe(&cmos_platform_driver, cmos_platform_probe);
+	if (retval)
+		return retval;
 
-	if (retval == 0)
-		return 0;
+	platform_driver_registered = true;
 
-#ifdef	CONFIG_PNP
-	if (pnp_driver_registered)
-		pnp_unregister_driver(&cmos_pnp_driver);
-#endif
-	return retval;
+	return 0;
 }
 module_init(cmos_init);
 
 static void __exit cmos_exit(void)
 {
-#ifdef	CONFIG_PNP
-	if (pnp_driver_registered)
-		pnp_unregister_driver(&cmos_pnp_driver);
-#endif
 	if (platform_driver_registered)
 		platform_driver_unregister(&cmos_platform_driver);
 }
-- 
2.51.0





