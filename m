Return-Path: <linux-acpi+bounces-21327-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGV1J/UrqGkgpQAAu9opvQ
	(envelope-from <linux-acpi+bounces-21327-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 13:56:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F41D1FFE84
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 13:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2E54305431C
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3741B189F43;
	Wed,  4 Mar 2026 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSXKrDYF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436A73463;
	Wed,  4 Mar 2026 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628949; cv=none; b=l/s3XlGykjJDYFLB+eUcZ8igStwfRlo2Lb8/JgbKjzcJ7f5eEtvuEc7QhEMyK3RrAxhakHVeNsDpolYdyVs7/l03xgf7pujQ5Ux0tpp9otpLn+FXVMr/db1GAbNbatD0IvRUx+BFNOHRkRjq0pXU8wyhvJuPJXG76jvmJsBST3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628949; c=relaxed/simple;
	bh=LLgqkgDiaPgn6snhIalKa89fIsH0nKVR5i3m1HJp24I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m4xSDqvSk5Z0bGwACIUnSx+UarmK7RbJ+vMBi32lJzcqCwohJIYfTjNnKj/0F7PvjQJq/BwXC818duaDqzR+KrJTPmKUq810KRfjID86Evh9g36rBmm3o/bwFUsGK8V19n//PtsjMKx4sY6L7vjus9dBsLytly3xvspHgQU18UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSXKrDYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D5CC19423;
	Wed,  4 Mar 2026 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772628948;
	bh=LLgqkgDiaPgn6snhIalKa89fIsH0nKVR5i3m1HJp24I=;
	h=From:To:Cc:Subject:Date:From;
	b=TSXKrDYF99PjUStTAwMfcjbBtry1ntRp/1OSGJ+yHRTtpqCjJ7Sjcu36UoLY8+6kC
	 sVp7+w52JwEbtn3ryZwDRSM/Y8q1ytxwfIG62iTswOFyWutGndWu5p8Lp84nyipHeX
	 Oj3DV7ktDTTvQyHh56YTAFBBsxjObnAtp+3naoRQkWfsWBJ/o+iLdQh5EEwhA+ruk1
	 Zv4wuIo6XT5g/JqOn7Hbu2mDg+N5+kXKX4dEnLOa4wQnO40aBnU2WES5InIkcIb8Nx
	 zM2fUrGtN3MqecyiP4eosdtx45uyQ25AHRXLkC9dw/K0QIDuC5PmCwVFhU3dCWELv2
	 pn4wumo1sLXAA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
Subject:
 [PATCH v2] rtc: cmos: Use platform_get_irq_optional() in
 cmos_platform_probe()
Date: Wed, 04 Mar 2026 13:55:43 +0100
Message-ID: <12857714.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4F41D1FFE84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21327-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The rtc-cmos driver can live without an IRQ and returning an error
code from platform_get_irq() is not a problem for it in general, so
make it call platform_get_irq_optional() in cmos_platform_probe()
instead of platform_get_irq() to avoid a confusing error message
printed by the latter if an IRQ cannot be found for index 0, which
is possible on x86 platforms.

Additionally, on x86, if the IRQ is not defined and the system has
a legacy PIC, hardcode it to RTC_IRQ, which should be safe then (and
which is what the dropped PNP code did).

Fixes: d15f1c2e413e ("ACPI: PNP: Drop CMOS RTC PNP device support")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/linux-acpi/20260303060752.GA2749263@ax162/
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Added tags, edited changelog

This is linux-next material.

---
 drivers/rtc/rtc-cmos.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1423,9 +1423,18 @@ static int __init cmos_platform_probe(st
 		resource = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	else
 		resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0) {
 		irq = -1;
+#ifdef CONFIG_X86
+		/*
+		 * On some x86 systems, the IRQ is not defined, but it should
+		 * always be safe to hardcode it on systems with a legacy PIC.
+		 */
+		if (nr_legacy_irqs())
+			irq = RTC_IRQ;
+#endif
+	}
 
 	return cmos_do_probe(&pdev->dev, resource, irq);
 }




