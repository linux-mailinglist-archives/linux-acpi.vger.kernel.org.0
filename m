Return-Path: <linux-acpi+bounces-9113-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A349B6232
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 12:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABEB283452
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB0E1E571F;
	Wed, 30 Oct 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ULjmv6uR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7F1DC759;
	Wed, 30 Oct 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288868; cv=none; b=uqiAE8HYLAnyEWyt6VzLsHVl2Bic2vIXKy97OSFgIGZ64+FHYUKEXN5koAZsI4e4AXv5L7oKQdTg7BvEGcVHNmcIte9Y/1yz6VKsrbkmNCcTKJd07Ik4Geie7i3Ae2BGs6o+UFVLPzybnQEe4VOaBE09/UmumzYAWvNjEom5c6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288868; c=relaxed/simple;
	bh=m566/Aw7BokwNE95AHhDC+A322x2cffvVlTff/86lYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOLUDEokSdjU3JBgL3l5HPbN9r0DaM6o1dgXjDphlgbDqhOvaWUelVVd2cPfuz3K7JZNS0vwWV1zTvkcQr1YRKcAGRJ0TTyn7sghOovGg5nauj0AHeynudDLHUIi1ExyoaG/4nvMRuTMnOrsEdn6rWLQt+iidaNmvZNwgYQXaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ULjmv6uR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3561040E0219;
	Wed, 30 Oct 2024 11:47:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id S9VEuAuA33Y3; Wed, 30 Oct 2024 11:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730288860; bh=600G8edgGU8M7BuLs4swFcgrBvQ+28NzvVnBeZLi5DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULjmv6uRCnWbaMzdOD0q270221nwyjYiK+v3hPxMLHNF7J9ulZnnnWQJ8I0/2SydL
	 K7obiq5YWgKYTrg89dbJJxJjDKBnPHyXncCqi3zGyZaCzbSaevTqsCS3squcY/fVVd
	 RN69gP4fXiLYIFm0B2l2Lv08lYNHWw8fDNca9pRHF9hHDGpHFe6gmul8tJg8UFiKPl
	 dc8Hjs8VxUmiE+TrUgX/QFE+wwj6uSG4/CSZLbEV2QbvmR5yaNuKfK5A4j6n3DsgBp
	 Hwbw/8R9t6UakaAxcUYCIEe7Zf0eREaEpEstObDxPkFcnmWQuIWB3av+s6orMLzy8C
	 /WKHE0xubYBkoBTkgq9mlJsXkFfl13XjaQ3oO9DtnFK2JbOk21sZ1/m2VnlshnrLly
	 tg0Z+JubTgdvzFfUGA1znzk1PQGtFOS++spRIXRdMUdeZj4ka2XuGM+mBehzbGI5JY
	 VlmuvbUxtLAoVSStgB3W32O2gOxXbaxCcAjILALFD45R/E27Xdg382mSnyydww0t1f
	 sV3w2c8FMam4RT/VeasYrTrjNIYEfkef3XJLt5It1d2EpoTlw39ZKsu/23dt5Vqofo
	 LGBSBgQ9XhhDSbSrU1yH6XQXRG0xGH+X1fzDrPELjIneSfcDorJZDBFoC4t3aLW80p
	 7nDhrD8zflS3Dghyn9r4/zw8=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD75940E0191;
	Wed, 30 Oct 2024 11:47:21 +0000 (UTC)
Date: Wed, 30 Oct 2024 12:47:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Baoquan He <bhe@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv4, REBASED 1/4] x86/mm/ident_map: Fix virtual address
 wrap to zero
Message-ID: <20241030114712.GCZyIcwF9MyQacmRf1@fat_crate.local>
References: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>
 <20241016111458.846228-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016111458.846228-2-kirill.shutemov@linux.intel.com>

On Wed, Oct 16, 2024 at 02:14:55PM +0300, Kirill A. Shutemov wrote:
> Calculation of 'next' virtual address doesn't protect against wrapping
> to zero. It can result in page table corruption and hang. The
> problematic case is possible if user sets high x86_mapping_info::offset.
> 
> The wrapping to zero only occurs if the top PGD entry is accessed.
> There are no such users in the upstream. Only hibernate_64.c uses
> x86_mapping_info::offset, and it operates on the direct mapping range,
> which is not the top PGD entry.
> 
> Replace manual 'next' calculation with p?d_addr_end() which handles
> wrapping correctly.

So this is a fix for a theoretical issue as it cannot happen currently?

Can we call that out in the commit message so that the stable AI doesn't pick
it up?

And which commit is it fixing?

aece27851d44 ("x86, 64bit, mm: Add generic kernel/ident mapping helper")
perhaps?

Always add Fixes: tags when a patch is fixing something - you know that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

