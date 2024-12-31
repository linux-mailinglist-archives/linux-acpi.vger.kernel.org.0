Return-Path: <linux-acpi+bounces-10337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEE49FEF0F
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 12:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A46C3A28E8
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CD118C910;
	Tue, 31 Dec 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C7v4sEkp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A612114;
	Tue, 31 Dec 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735643621; cv=none; b=Hp8yaXr42gUH1IDJG476bHEsXT8AHrSS8cbBnsB2F3efFnYlubeh/OK+AeIO6BAcAZrjW/uDanjDDM+h/zAs2EJRWK0m37t+pKkI82SPlvBr+lSb34urYFLZLqRxkXbxIBWN/Msf+J0ZrxACyDcTtYe96LSXASpKyDc07AcUU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735643621; c=relaxed/simple;
	bh=J2d6pX3xdW4FFTYsjL3xvqRB4HqQomRxwsu1i74XYnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3lnaNoZUN5Vp66GdQEBlRgrAp3tXREZS42pm3wTctAd3ZKT3TzjtNreKpTj8maCGRc+YlSTa3KY4sC13ie3GEjbCk+C8UiMxrKTmYtejAIUIvyKiZq+N7AEJ7FRWDPmrVr2zJBhqoXuBAV6l7Ua4k1hKMvbZbsrAIhZh4HMdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C7v4sEkp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C7A5D40E02C1;
	Tue, 31 Dec 2024 11:13:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IxnVCNbyni0L; Tue, 31 Dec 2024 11:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735643612; bh=wUAjNaXP3ii9pxf7eVMROyfJiOqacwObfDBT1kx6Bqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7v4sEkp2tKPay9RjwLe/mk/1UUOi2qrlJLdCllPt3a8PHL8dS0MoiNBl5S5pC8qu
	 vOdEmPU88Xp3sBUkNUHpOK6PgLK87kMdVy8jmYW9ClYDbjIbw/ffaiCPA9sRuKcG20
	 SVDY2tTtT929ucy+pKy2znIWF322bbcrDZHz64Rc5XsHOZAH1mK6OcVzzp+xxdZq7a
	 eN6fXhE4dhirUwsS3g7nf7Qr+Rk+wYZXJRzyKnAt207F+KBzNoJQK13ut53zPA6Qmh
	 ic8ZRMd8QsTAvCD/9HWM2k/QfuIbyZ29ENLzue1WuHkt6x1f1iARFPeEh2iGj2KTcJ
	 X8y4Qy8gzkTvfFghxnVn9KqqFbttwG+U7C4J0mkc6Wc1/CEVV8ju/AfsqX7mY+c72w
	 XqImRnz1rRP8MxmlRgaFA/vTm9N4FFRTlF1wCLe18BmvIoamwSSBEEDamVYqxKGRLt
	 c0PSCMyGQIXaH6IktLZTvwXmPwwonUy4v+V6IzV/ohjCbIDhRRE0gzSkpZOeXoQOn1
	 m+d0EP3kvhyauQak41kdPGTwYSV7S5A7157fWGmZjn/kDdwchhewYF6bqDponJUfyp
	 f1/5ejdELDughcz0vOLDerT3bEq4MeU/nk9fTMq8wQu/ewDWaWfEwwufso0nKKfk1u
	 JJdU0oMf7RJFZrteekRSC5h8=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5EEF440E0269;
	Tue, 31 Dec 2024 11:13:20 +0000 (UTC)
Date: Tue, 31 Dec 2024 12:13:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>, rafael@kernel.org,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] acpi/ghes: Make ghes_panic_timeout adjustable as a
 parameter
Message-ID: <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>
References: <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
 <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
 <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
 <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
 <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
 <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
 <Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local>

On Tue, Dec 31, 2024 at 06:15:59PM +0800, Feng Tang wrote:
> Thanks for the hint! IIUC, you are mentioning the set_arch_panic_timeout().
> One thing is, most ARCHs' default timeout is 0, while in our case, the user
> will also set 'panic=0' :), so we can't easily detect if the 0 is the user-set
> value or the OS default one. Originally I even thought about adding a flag
> of 'timeout_user_changed'.  Any suggestion?

Ok, enough talking. Let's get concrete:

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 31 Dec 2024 12:03:55 +0100
Subject: [PATCH] APEI: GHES: Have GHES honor the panic= setting

The GHES driver overrides the panic= setting by rebooting the system
after a fatal hw error has been reported. The intent being that such an
error would be hopefully written out faster on non-volatile storage for
later inspection.

However, this is not optimal when a hard-to-debug issue requires long
time to reproduce and when that happens, the box will get rebooted after
30 seconds and thus destroy the whole hw context of when the error
happened.

So rip out the default GHES panic timeout and honor the global one.

In the panic disabled (panic=0) case, the error will still be logged to
dmesg for later inspection and if panic after a hw error is really
required, then that can be controlled the usual way - use panic= on the
cmdline or set it in the kernel .config's CONFIG_PANIC_TIMEOUT.

Reported-by: Feng Tang <feng.tang@linux.alibaba.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/acpi/apei/ghes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 07789f0b59bc..b72772494655 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -173,8 +173,6 @@ static struct gen_pool *ghes_estatus_pool;
 static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
-static int ghes_panic_timeout __read_mostly = 30;
-
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -983,14 +981,16 @@ static void __ghes_panic(struct ghes *ghes,
 			 struct acpi_hest_generic_status *estatus,
 			 u64 buf_paddr, enum fixed_addresses fixmap_idx)
 {
+	const char *msg = GHES_PFX "Fatal hardware error";
+
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
-	/* reboot to log the error! */
 	if (!panic_timeout)
-		panic_timeout = ghes_panic_timeout;
-	panic("Fatal hardware error!");
+		pr_emerg("%s but panic disabled\n", msg);
+
+	panic(msg);
 }
 
 static int ghes_proc(struct ghes *ghes)
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

