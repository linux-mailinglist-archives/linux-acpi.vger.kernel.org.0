Return-Path: <linux-acpi+bounces-10327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A982B9FE59E
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 12:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF3E1882C26
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF74195980;
	Mon, 30 Dec 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ity2MT2Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EF2594BB;
	Mon, 30 Dec 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735557994; cv=none; b=rtBiXevxgViD7WMq6xFaFjwVm8gpKmjaXufIxqPQvknLoUG/OXJTVATKXC8PGqzho8UUnu9Tzg31vUD1kHszh3QIvt8GwjXn9EaZdHln6wSFyZKIsdxKamZ9N3PfLf4jIEhBzpwMoVx9ty7bVD1GRxOQYB0XXlmyFiDfCDNkpqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735557994; c=relaxed/simple;
	bh=UA2u2lCeULDxYv5cAZMRgWC5Is8zlhaT1j3iHbIyzwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOTtp/3w7oASimCTrrXTt43k51ZPjo2Mt9PsJ1kqydG7dJeW13pJ9Q28HSbeRuELJYLHe7a4BPkViSltqu2q+AuXjqiO7/NsF5wrc+pTjMyuLV+Il9kCG/pdgmNKQ7W945N5L9Pzp/b2t4lPWiDfEl4m3Ksr7K3thqmnr1qhZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ity2MT2Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4FABE40E02D6;
	Mon, 30 Dec 2024 11:26:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nDzYHlRWOVlT; Mon, 30 Dec 2024 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735557987; bh=DzbqjJWbNtF4VttW2GP08qg2xt9RLAKzP7vp4D/+vqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ity2MT2ZZfmxTu1nZ05RYLKWsTZD9Nglrto/LiaRbjpjh4vPHVop4bgWMpW2/vf6X
	 VBLNIHodAF5bRhqQAe0MwxifI5HF6cuD7btBREseFuCyJECKQdlm2NE71h7ZvsqjPW
	 iLVrjxaibrZyj6CDw8sERDphOUJAanoq5eOPLXFJpEgOGdAiEBwTRBgnFKO4vrC1px
	 ta2xT8G0DNDkmUPvtFzHdgyqPAl7oEEZyyr1wIVI3ugknib3JwkG0qNSoDAkgycx/a
	 LfdNvFzkQy908NS3LIyisYaBKEZ7+C35vSBG5egAbBa2WrlCwXOWJ1SSU612zocviB
	 IZlJ5kpWHdh6R0+qbYVPKBKIDy3QlGBwRcO0XCBbdoKtBxkrrrQL5SHppW4KzwdA/g
	 RipaZB3yYj75Eie66MRTWJiQmPetJWy24/3KRVZQV9bCQqcjAK6VuJuQakfRIf+naX
	 SChWsQPrL7EZwBseZCwAQn+bdpQcK5FZ2hdhVAq4llcI6ZsYkvzLmWhwMk/J4pECYn
	 TTX5Z2xYc2oqTZD0bfBUjv5caHaZ7Rzmmpc/aB3aXc5hDhb9+EzH0v6sEh+FfTgkyw
	 j6/I09A6yLBeCySOFs3CfBaZ7hdizgHFKG7oIte1H2Ox8tvW1lFY49rfcbJQlrqInR
	 CK8A4CErcvS4tvq4OWQFlUFM=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF6FE40E02C4;
	Mon, 30 Dec 2024 11:26:14 +0000 (UTC)
Date: Mon, 30 Dec 2024 12:26:08 +0100
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
Message-ID: <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
References: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
 <1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
 <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
 <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
 <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmfhjusk.fsf@DESKTOP-5N7EMDA>

On Mon, Dec 30, 2024 at 07:04:59PM +0800, Huang, Ying wrote:
> Another possible benefit of ghes_panic_timeout is,
> 
> rebooting instead of waiting forever can help us to log/report the
> hardware errors earlier.

So you rip out ghes_panic_timeout and set the panic_timeout in the ghes code,
when you get a hw error which requires reboot.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

