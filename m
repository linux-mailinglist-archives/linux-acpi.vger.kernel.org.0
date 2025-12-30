Return-Path: <linux-acpi+bounces-19913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250DCEA9A5
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 21:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43D23014BF1
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 20:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211992E0418;
	Tue, 30 Dec 2025 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CZftLkiS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFB2773DE;
	Tue, 30 Dec 2025 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126167; cv=none; b=IcnSsR5hI6zZH8u9L7U504y/piWLMj/RWLeBSPHIjTozfcwOG/oCi1+4LSf6l4ymNcG+/Tvuu+0xVKG1mWO25dX/Nxj1wO8wnB0jDmAuwEHiD7BbLKso6Tz7CGhj0TzoHcmqqPK5MvmWRwW/401c6kiwyh6YtfsmUdCzUwikFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126167; c=relaxed/simple;
	bh=wOawhRMy6PqBJKMCTblvUizuauY9tZtanHyV3crtbYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FR5MVvIDUeLYPiFhTRxq7JEhojwRYBQkyF5SmtrX7DDt7jpSwBsvenhhgRwS68Ulcy7xH0eIT+znVqCoAU0mOMUW7K5QxcHVBaqRZxf6igRKe93jsij8hUZ52Q9nAdITtwU+PzTBffB5Czr+1f2xhcMqG47XVmSNbEdR7ig8X7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CZftLkiS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8D7D140E0200;
	Tue, 30 Dec 2025 20:22:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6019D1TzHUu6; Tue, 30 Dec 2025 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1767126154; bh=7VSjZH9YRcwoArFWQ3nrQhzF6SeGlXpAy9wzH4sePkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZftLkiSaYSuny9JPh+I4cMr86G5HGZynbGE4hsn0NvabteM/KIFQEcmu/mgFfNAF
	 W0fPnfjlWbMn40x8ByvMddii07FftBkdzlm043PDJfB5gn8g09h5uE/8BW3uwqbQxk
	 V7KSZzQbmQJSpLdtime8xn+e2LkbvVseaDdaDWbwcuq/y6Ky9KHLn6OQ1vzYxNfJgv
	 vpIhzEVPQhjyBn5Qw18DpFm9sJl8mtntp6p8LFFhjU4hpDzod7pNu1diLwQYIIKwUD
	 /mz/U/lh1yIepLjd/ROiwCXP5xOKWOWSpDXi9q5zhKkRYceNx6VTT3JyCD8M9eJkt7
	 4lxfun7vIHgZRNA60bbHYm54gA8TfkB8WLR2vQ4PlvhYO2JJnc0GsVST/XTCnQ14WP
	 Ac10ffwKginHPD1X3jCm5nnuXEs+qK4HQSlGFIgfVjaEeJYUSMAZ58UXxZMqzatTKq
	 3ejWocyb2In7vzdfgOCro3hfc6zCOLQ8k8ik2rY6pRPuqQG/QRA9smEFMoTYBar3Ss
	 A7ftcSCNrU34hZkNhbeafgpanayQ25kZ5u9wKlTWigAWfsFJPFsjmngoCmaOl4Kgwr
	 9N5am9o9/se1jMAv0vtCq2k7exXFume5D168LibYKvOYkytYe8J01SSrNKmeV1fRRK
	 c7VbaMk9SRHs/d1fF1EDJ0hg=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9F49D40E01A9;
	Tue, 30 Dec 2025 20:22:18 +0000 (UTC)
Date: Tue, 30 Dec 2025 21:22:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: catalin.marinas@arm.com, will@kernel.org, lpieralisi@kernel.org,
	guohanjun@huawei.com, sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org, lenb@kernel.org, tony.luck@intel.com,
	yazen.ghannam@amd.com, misono.tomohiro@fujitsu.com,
	fengwei_yin@linux.alibaba.com
Subject: Re: [PATCH v5 00/17] ARM Error Source Table V2 Support
Message-ID: <20251230202211.GAaVQ0cx8o-CqzGU2O@fat_crate.local>
References: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230090945.43969-1-tianruidong@linux.alibaba.com>

Some high-level notes first:

On Tue, Dec 30, 2025 at 05:09:28PM +0800, Ruidong Tian wrote:
> This series introduces support for the ARM Error Source Table (AEST), aligning
> with version 2.0 of ACPI for Armv8 RAS Extensions [0].

I'd like to hear from ARM folks what the strategy for this thing is...

> AEST provides a critical mechanism for hardware to directly notify the
> operating system kernel about RAS errors via interrupts, a concept known as
> Kernel-first error handling. Compared to firmware-first error handling
> (e.g., GHES), AEST offers a more lightweight approach. This efficiency allows
> the OS to potentially report every Corrected Error (CE), enabling upper-layer
> applications to leverage CE information for error prediction[1][2].
> 
> This series is based on Tyler Baicar's preliminary patches [3], which have not
> yet been sent to the mailing list as v2.

I guess I'll wait for those first.

> AEST Driver Architecture
> ========================
> 
> The AEST driver is structured into three primary components:
>   - AEST device: Responsible for handling interrupts, managing the lifecycle
>                  of AEST nodes, and processing error records.
>   - AEST node: Corresponds directly to a RAS node in the hardware

What is a "RAS node"?

>   - AEST record: Represents a set of RAS registers associated with a specific
>                  error source.

...

> Address Translation
> ===================
> 
> As described in section 2.2 [0], error addresses reported by AEST records
> may be "node-specific Logical Addresses" rather than the "System Physical
> Addresses" (SPA) used by the kernel. Therefore, the driver needs to translate
> these Logical Addresses (LA) to SPA. This translation mechanism is conceptually
> similar to AMD's Address Translation Logic (ATL) [4], leading patch 0014 to
> introduce a common translation function for both AMD and ARM architectures.

Say what now? 

The ATL is very AMD-specific. What does "conceptually similar" mean exactly?
What happens if we have to change the ATL and break your use case in the
process?

What exact functionality from the ATL do you really need here?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

