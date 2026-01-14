Return-Path: <linux-acpi+bounces-20325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B3D1FEA0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 16:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CB5730049FC
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A31639E6FD;
	Wed, 14 Jan 2026 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gDEI+zFP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F523A0B20;
	Wed, 14 Jan 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405645; cv=none; b=X908mYV16jV4zWT3xPQWvdE2NUuV2Jw/9R1hW4ijY4+jgHcDw0ZasC9MdahBZKoX1SR96301VXFG9iw74UtPMT7oM0a5ApGX4HXfpWXQLd4IEBR7ywGFE84XXojjlMyECu8gzXWNSZ1v8FlKLyshkt+Bqx3D5Nr98voYS0SNpOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405645; c=relaxed/simple;
	bh=UPnHOPIjGmubnCAzxv2GweargRz8EcqG9W3rLov+k0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uV1sOqk1ewRcP/k79xXoGltJFdDBwIpnzLRWLNF6vZG8oeWkX4YJ1eV3a3ewaCoEb3ppa6Fpg05+bxLIJKUI+OED2uAVaaSTf7Eq2u0h/UjWR3A8KiAtvLVawPnFEEK28e2+toV9aA+GfnLNYRAuSLTFi7PEF1JFuWPdMYP4rTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gDEI+zFP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5591040E0281;
	Wed, 14 Jan 2026 15:47:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2Abegj8iRGYn; Wed, 14 Jan 2026 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768405635; bh=xSyGH2S7hw1AUiS9jEfdC4Jr8F3HyJxMOuZ6mZOurSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDEI+zFP6Ss3OY2BMcgbNLN6U7b1rIDSoTpKUB2buPrrZIaCri12/AmAYJPCvFLam
	 xVr8dN9vmC39iER+aqrDI6eEPdJs9jDu5SJm2HSujdKeX+WMVtFn7scxIyP391CrrZ
	 uDxlfppV1co4BKRgvTr3mf4urvTob2ZO8gc3iC3oIYaA/Qi09Pnsyi1ohpiQKcdRdX
	 IPStX4Mnb3FyoI8OHQxQ6SI1v1sXu3zihNxvpN2msC1FPV91G9Y7rVhbR9CTYPCwXd
	 l3H2ncP4mMl8x7V57bLLQ+4C3Gy7P8BznsWOg+YaNBbMI1Eek8yCGfdw9PiFixOxeU
	 6fBFy2sbgx8riUtgBto4EnqAu8bybVK/QI37n5OjBb9RKLEl2rcZGJQuO3vkHaNZNe
	 ZxBftFt8d3VDUfd7efGESykH4eyJP0nr2ANXZ/BxfOvGpqwrTKpumDKfmMXTuVwRgV
	 9A92b7etLcXP+ZyK2eFIs6RP5/1AYim6VJt8Ezr4xZgxUDtxW9W9YwEQs/naCDmuXw
	 Jp1B5c5uZ2gkql++3Booc1daFCgLsXonLPu0VWNPJoHq//zGKX69DVD27I1Xv9c/ml
	 dt8B+W4d2egZAZDv1WjRCMNkJqYVfVrMP38EX0VMmHl4mJG6Mn2JkpGXfwWSf6G+aC
	 YxlOwbepQGXZpEMl2IfwwON0=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1DC3E40E0028;
	Wed, 14 Jan 2026 15:47:03 +0000 (UTC)
Date: Wed, 14 Jan 2026 16:46:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/acpi: Add acpi=spcr to use SPCR-provided default
 console
Message-ID: <20260114154656.GDaWe6cFCruAGbJbhe@fat_crate.local>
References: <20251228092222.130954-1-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251228092222.130954-1-me@shenghaoyang.info>

On Sun, Dec 28, 2025 at 05:22:22PM +0800, Shenghao Yang wrote:
> Commit 0231d00082f6 ("ACPI: SPCR: Make SPCR available to x86")
> made SPCR available as an earlycon option on x86 but did not add
> it as a preferred console to avoid breaking existing setups -

No one has noticed AFAICT since 2018 (this commit's date).

Also:

        /* Do not enable ACPI SPCR console by default */
        acpi_parse_spcr(earlycon_acpi_spcr_enable, false);

Looks nicely conservative to me.

> users have to round trip the dumped console options
> ("SPCR: console: uart,io,0x3f8,115200") back via their
> bootloader.

I don't know what that means.

> Let users opt in so serial console configuration can be made
> automatic.

Why?

Text says:

	[X86] When used with no options the early console is
	determined by the ACPI SPCR table.

But the code doesn't enable the SPCR console by default.

I have no clue what this patch is trying to do.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

