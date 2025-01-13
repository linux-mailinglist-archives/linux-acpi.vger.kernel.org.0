Return-Path: <linux-acpi+bounces-10550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C3A0B785
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 13:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0AA3A102C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DC922A4C6;
	Mon, 13 Jan 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JIUBdYPQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590C22CF28;
	Mon, 13 Jan 2025 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772765; cv=none; b=OjM9hYdoEiYEFyd4ZQPkUO1WW6EukZVFeXsC1so+RIFMswrQak8wUHMBBx6HTLgQJq0q4DP6featcEGPAAFfaLdZP2qyuHEUyzJd2UH4rW5J0xs0KKIiOs01ef7Dxu2EV3JmuX07YyWyF7vIV+oYj3u3SQ7Uz4m3wOqDgQDUKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772765; c=relaxed/simple;
	bh=8L2Bx6wyTsiMLFizzFAiv9h+iFO4RdTLh5spizOVB70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWKrMNFdo2p/zNRccqlYEnX7WwnWNlyoHy0pHgXpwiNGKHcbtoWXvE723xQXHRbFk+16Juh/rPGj+m4Uie2R4UHTe/FimPl1sH6ZetU/pczdQT+rjliDIz7uYNT1j69lDwpsXNJyFc9x1JM9AUVgKgEHxhnMXbrBHB2u7nTU7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JIUBdYPQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 951E940E0269;
	Mon, 13 Jan 2025 12:52:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WEKjoHmI4xWX; Mon, 13 Jan 2025 12:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736772758; bh=0UNV0bQTKwtwldy5i3LLGz/9XmmOjJYU/JIbccn+3jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIUBdYPQuY760k6lvoOdVL3UgnZ1b14nIz91SId0ofB9dFVMiso9zi3OL2zwCgDKx
	 wSiCbW4N6l2Eo7NcyLIn8duCJ1giO+hNJ5Xm78E5scprXOrJICvWT8fpnniDo3uv5U
	 UFjfoOC2iW4s7aWAyTYs8ahYnOevtDr0fbnZInRHI8xp9tyehtz2JSiKahMPn3javw
	 WxP+g3ozK5c9y2+CwGenXWX/CyQNElq2lQkR8o4k13GNyHTJkmXsR44wezOLPGihfD
	 2LOQePY69ewACorW8+J5hikH0/q8YKKRF7P/QqDbMQR5HjSQJnBRSFZZDdXeRDiVLe
	 JoLFxjQFO5QCnCWk74IYhHyUuH1U6FGM4Fq0HN3/fc1VNclhz5lE2jJnCFDlOuwKve
	 o4ovGEsgsh3lXmT33wLgzI89FOQ7FAWsf2GPgLrtjOQRR78C/n/iP+9xFndZg9QgPG
	 014ElUDZdecvqlZiC4KTTMp119cF7yMZiz51QEzj9bEmCfJUsssJ77Kd7cQVLgnjE1
	 rpm9jrPZtJ34OxthCLT2u0qlk0chDHZq7cFwtIh8mog2yFh9JGuveLMY47TtA8ADjL
	 v3uGVbliHsGSLwj+9WXGWkT8R0NfxLFBbrpNhyfXWif4pXYkB0C5Y7YW1BN6ir/SWH
	 pyIL4fMGpW7py3qH0gd9M5L8=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E058840E01F9;
	Mon, 13 Jan 2025 12:52:24 +0000 (UTC)
Date: Mon, 13 Jan 2025 13:52:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	Feng Tang <feng.tang@linux.alibaba.com>, rafael@kernel.org,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] APEI: GHES: Have GHES honor the panic= setting
Message-ID: <20250113125224.GFZ4UMiNtWIJvgpveU@fat_crate.local>
References: <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
 <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
 <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
 <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
 <Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local>
 <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>
 <87ikqydja9.fsf@DESKTOP-5N7EMDA>
 <20250102083509.GAZ3ZPvcUhl9v6Kbp_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250102083509.GAZ3ZPvcUhl9v6Kbp_@fat_crate.local>

The GHES driver overrides the panic= setting by force-rebooting the
system after a fatal hw error has been reported. The intent being that
such an error would be reported earlier.

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
Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
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

