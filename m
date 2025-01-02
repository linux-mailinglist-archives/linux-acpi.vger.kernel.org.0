Return-Path: <linux-acpi+bounces-10342-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0B39FF6F1
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2025 09:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4A818823FD
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2025 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778319340B;
	Thu,  2 Jan 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f7u5vhmV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E55F192B63;
	Thu,  2 Jan 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735806939; cv=none; b=NfPfzklITQiuuZbLKq2ZHlhRVxLXuTZFKjm/d1a/kqeklCWmZcCYpo5+AzhNjDIeaZKSH8Q3HhqZsqgvOmZKPh4+SSV1A42cFE7s8W+EzpM7CWcvwk5aIhmcXxtTbmH3ZFhRI93k+uV9epgH6HqQJCs0KMNeFNG9t2hGr7AO/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735806939; c=relaxed/simple;
	bh=rx3F3PvlPiaZKUkc6jJOObgP39KtT4PnzEIx3mGbHBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM0SNPxDUDxkTK2NipLYRXwLK9gt8CcCsTOybR8N7bxcpiEhCKFFNnIUZBpU2oSmaA1/VKoj3UeWNAxtxRfH8iJ/yq1iHRVlpKo83XLhdedv5zL55KZjDbixA9n2PPtoFuqAxjP4bo+MmUOpsoYmxW3MFo6siJpi8r8G+7FshAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f7u5vhmV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 22A8F40E0163;
	Thu,  2 Jan 2025 08:35:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Gh10C3xCg_gb; Thu,  2 Jan 2025 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735806929; bh=RZhHDSIlxFgmmGIBeksIVB2aQh1n3XIe70lH7iCsD48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7u5vhmVveeETgXNtuNcVsh3xH5WF0NThfwidsPQw2QQKo5+5F2BOp4rtnaOF03AS
	 B764jFItDmIWfdgY3RNMcWbEnaefQI0gdWEr1PLa7SbjLtJk4V7YdoPOaLJIDPd+Af
	 TGDLko6y82aY+nYzFik7eYar4D0pPmG7/lPeEuJSMrjGrrXII4M9RwyyTmtyHqY00h
	 bLGosgeei8Xm/yQyeMlcxk5Ks/G+T+U2LR1Iy1cSQQz2rLp/LEvz9BB8Z/a51zFAwJ
	 IR/BKuLwmS1+oVZSyvUs3vIAdXMPKdr4HLXfMRUlfpK2K+X+8u4KRnAflcSihaNFR5
	 InbU2Fcc3VOVfSZo6dPer+KDe6HAULW0a0Ipf3HGhLLNpfCzMT7wOR/Gin7E+SvJg8
	 3cZvaqdhbMu7Xuaem0x7MjKI9b6oS0SNhNDgzvTyneLErfgZOSIA/jrgpgBB7Fky1j
	 EsGj9aL3MGpy+xZObLiinDcC7wGvFfhTBn8GCBBbhOlHPUxjB86krDQOhqVt1FxVaM
	 ABpIaDC5eV/1oPkoHRz4dXLBuoO88mlJ923c32ILL/6sXt9uFyWcCJfTgNfJWKQpYq
	 SzqZ7Wy+c30q0F82KzgrLY/EsSHsqHPae58a/mS4AMpy5/33JsevQjoaMLIHLRVh7l
	 gDRiNmy1MxY7tf9SpnVRs3YM=
Received: from zn.tnic (p200300EA971f93DE329c23FFFea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93de:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A31D540E028B;
	Thu,  2 Jan 2025 08:35:17 +0000 (UTC)
Date: Thu, 2 Jan 2025 09:35:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, rafael@kernel.org,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] acpi/ghes: Make ghes_panic_timeout adjustable as a
 parameter
Message-ID: <20250102083509.GAZ3ZPvcUhl9v6Kbp_@fat_crate.local>
References: <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
 <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
 <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
 <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
 <Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local>
 <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>
 <87ikqydja9.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikqydja9.fsf@DESKTOP-5N7EMDA>

On Thu, Jan 02, 2025 at 10:46:54AM +0800, Huang, Ying wrote:
> IIUC, the hardware error will be written out on non-volatile storage at
> the same time with or without ghes_panic_timeout overriding.  The
> difference is that after rebooting, the error information in
> non-volatile storage can be extracted and reported via UI, SNMP, or
> MCTP earlier.

... which basically makes this forceful rebooting even worse. The user can
reboot whenever she sees fit - not when by some questionable decision done by
kernel devs.

One more reason to whack this thing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

