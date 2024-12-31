Return-Path: <linux-acpi+bounces-10335-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17DD9FEE52
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 10:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68DD3A279E
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A896318DF7C;
	Tue, 31 Dec 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dYRmLHoC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A11189915;
	Tue, 31 Dec 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735637067; cv=none; b=qMKCz2tmRPqJPToVHv8ihiPRvp7hCmZVEIfXz67LSg+yOptcldDzQzmH0k67z7UwuUE04C4TO0t5WMJspIkJmnID5hhRdOUul12uxQHP1SSeML23XGZ8Z+PynU1cbDWMtTHEDLlIMoHAT94xs37d3OvD326yECUY976UjJs6WPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735637067; c=relaxed/simple;
	bh=uYTg+TjcebhGiEXFQepim2pTyjAHhOYaXwPyyeRBtyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaCdUzqgZiCsixaxMdQE+pK9YktTZPerXjijjM3bLdGdnL8pcbFPcG/Pf4RwnfOxm6k20hgs7u/B0GfdIqM2PHnUUEV8tOOvFFh/Tny+7RROt137jn5BfCINk4gZcMM1vAKAr/gtlpct8DmwHNZ5jj7OE5mL5VkrOgruajblsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dYRmLHoC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4277040E02D6;
	Tue, 31 Dec 2024 09:24:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9dApH0SaVcxc; Tue, 31 Dec 2024 09:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735637058; bh=ERacIDYl5vtlbroSEkZG7Pm4i/nXuVYVA6Xa7epl7oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYRmLHoCtZ/xe+j0AZzPIxlAt/PQM2MWHs7TVETBHWZ1F8k953fmR9mziKRPH6D4/
	 rgKUKqfx6QXISJQQV7hp5BfAOMb/4JVm24RE4tILlCbDm2WH8JRP2xaOIWt+jbsZNl
	 8GVQe6q3+WMyefAjKdFwhy2TlOGbkdD2tDKre+TlK5x7NSdXO5Cd5JNCvbH68JlXZZ
	 eLoRjCurDETWMhjVuRCetcrUsm7ihmypyddDRzL7DbeE7jkRqwVgT+yUg/tZRrq7o7
	 kqcA2FfMAsslAQ+NYYSjhkwFTRmgWG5QW5wi7a74/KW8TFyVE1RyZj5QqadwBENFWb
	 0+EmCUsIpu3/WTzWouwYBwgJ0DZk+cbP3JX2XBo2bfRj3+5Lv0Ksp0N2wI+RHiz9hh
	 9gxCI1cY8e1w6s9IGFGhtZAzLbo8nnQjed9eYKOSBFuv5Hj/Flgxeo4cwFsM087HEf
	 n8yRuExrtzxOtTijBMvntho6G5aOy0k2w+3dnU1a9gKN91ChLraHXXwifyenCxd//4
	 EZMwv30HxpM2aR5t0pDPvvm1MovwmVyqG6pwI4ISPmTPkYHzmriL+HRuzWUNCIyA/x
	 s5kbulR1x0dLoGvlGsVRgCINJZMz3HDfjdE8CWAVqEWdz6jVuRApkunLF0fCsIzbTk
	 lvCBweX1DqSuHUhFO27lkKIQ=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1BA640E0269;
	Tue, 31 Dec 2024 09:24:05 +0000 (UTC)
Date: Tue, 31 Dec 2024 10:23:58 +0100
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
Message-ID: <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
References: <1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
 <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
 <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
 <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
 <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
 <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
 <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>

On Tue, Dec 31, 2024 at 02:44:48PM +0800, Feng Tang wrote:
> +	/* If user hasn't specifically set panic timeout, reboot to log the error! */
> +	if (!panic_timeout && !strstr(saved_command_line, "panic="))

And you want to scan saved_command_line because?

Hint: look at how other code checks panic_timeout.

> Or we want to stick the orignal patch, which doesn't change the
> original flow?

And pile more broken stuff ontop?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

