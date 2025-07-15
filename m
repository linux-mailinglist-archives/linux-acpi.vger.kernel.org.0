Return-Path: <linux-acpi+bounces-15157-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9AB054E2
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B84D3A57F2
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C21275AE9;
	Tue, 15 Jul 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CWjLfTg/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5C275104;
	Tue, 15 Jul 2025 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568206; cv=none; b=H4vSFPhbFTkk9XjJ3uSDx1GLq1QHw4D221fVhktNED8I+el2R1dYlYdArHtLX8shMMMyhveKQg9UeYq9kAtLvJOktaVyHUHaaP6J04OHyRNKSXOV0cQWKttcHqX0GnJOMAz5hrj8NMq1yRzgUmOuFpgpewqvY4X1ro8t/o5Iid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568206; c=relaxed/simple;
	bh=h/pfCpDMjWTqe/dvmJVF9X9JwfQYz7GSXTRkMsmHkQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbzvk0mmM96VH9ymkISmdjMFyce5a7ysfN5ZDMH5S8LNUZu/HaZzYt3Xi9ZXcHrD546+CzDS3ehccn4M67n9fHYyvopKM/cbbCilSXN/IjmJmWRRc5HhSJYVgaa8eaDSro+TR9dZtJktbNUTc93gK+7RuNNONTnqQeABFe97yv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CWjLfTg/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 91CE040E0208;
	Tue, 15 Jul 2025 08:30:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9KM_z8NCoKpf; Tue, 15 Jul 2025 08:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752568196; bh=RTx8e2p8V1LQHIFJgxMIie0+itdjsVlC/C6D4mzUHZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWjLfTg/z0jSfaWaLKexB4AeRjsH9M0DkBpfgVTzbDN8ZdVe1wb3i4omUZlQWZXeA
	 j5a+Ru73tJHyzPk78qWbJN9GEcF2nIHl+c2iELMRoOssCOHYPMpc2aw4bN4wplMOXu
	 a1oZlgXMFLgTSKOqbggHunXbBWStb3LIsc/lQEcx3kI5/hIeseaQGPs3FZ5kyGEWww
	 +XLUsDguDBvodirwBGcZyDD9bNo+7tUUyRQByLBh0hL+E9E0dUssEaai/Q6TbVmxay
	 tuBPddRcB5PSxDFuyqXXYn5t0QgRZP5PTLbSQuxrLlST/LRzUOpXPQ86a5ae9/zG2b
	 9z5QUBOfIjMZHAwtXWX0Ft2G+bMr+zXOY8+LJrtRS/k/sKANLJvdAiCfst9IKnbnLR
	 IQOINkpLLepwndtCxAybewCSNozqqIVscBmCDzRdxtwwx/F5qr3cLXz2EtwW8pMvjx
	 g5oNNenhmRkf5oLyV6OIRXN95nPPSU4wBKn+K6QP+viGrLu9XMXAFSX64NjOU/kw2J
	 fGhd2kZJ1dhXG5Cb8eyVJvcPszndztQajPfqUjxJXkq/ahW9MtJkeMaAuBx89fs5Yj
	 ExsrQAFSN1z39zIWwLZp+FQ1at0mp2cLtthgUGl2hOgoENMuhgu/8AhShnwMMVsuxV
	 mJBqynnabt41Wh9X40fHbwwM=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1769B40E0213;
	Tue, 15 Jul 2025 08:29:46 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:29:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	"Moore, Robert" <robert.moore@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHWC-J851eaHa_Au@agluck-desk3>

On Mon, Jul 14, 2025 at 03:21:44PM -0700, Luck, Tony wrote:
> So what about something like:
> 
> enum recovered_error_sources {
> 	ERR_GHES,
> 	ERR_MCE,
> 	ERR_AER,
> 	...
> 	ERR_NUM_SOURCES
> };
> 
> static struct recovered_error_info {
> 	int	num_recovered_errors;
> 	time64_t	last_recovered_error_timestamp;
> } recovered_error_info[ERR_NUM_SOURCES];

Too many "recovered" :-)

> A count is just a hint. A count with a timestamp that is shortly
> before a crash is a smoking gun.

All good thoughts... from where I'm standing right now, though, it looks to me
like we're wagging the dog: inventing issues and thinking of which solution
would fit them best. :-)

We have all of that info in rasdaemon. If the machine explodes, one can simply
read out its database from the core file. 

And if you don't run rasdaemon, you can read out dmesg from the vmcore where
the errors should have been dumped anyway.

So there's no need to add anything new to the kernel.

IMNSVHO.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

