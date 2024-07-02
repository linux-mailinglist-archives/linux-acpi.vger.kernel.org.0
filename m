Return-Path: <linux-acpi+bounces-6736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F04923E1A
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8A71C219C1
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658FD1509BC;
	Tue,  2 Jul 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ik3s/CRH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF59470;
	Tue,  2 Jul 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924350; cv=none; b=C2U1z4Ae9+uVSR6/5LCYlbYdmq/NOFbmgvhoEl6hZ38JbpJ9U50JFF7R2Q5SpA3NBzDY5LeZk+NSSLwFjViNOerlD7nlOHPmTKiHYU/8Qnn4dmslqCaid49pM2M6o1HsN+5GLy7TwGZbxc1xbbCPvXXKyQo5j/+5j1V5wig2PQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924350; c=relaxed/simple;
	bh=6MxOCjaZBfyhMv8du5omxW8oPy/q2TFH9X6JuMNqPjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TS/r6J98nauKIOVcCuH/Sd5YaCstUOFpzTIKzSP8+dEcD7Tv+veUnpmEvTjqZmXLUq116i7ac5FyJ+FknqaXR25aSBbGC6Pe2ia2JxGrNclBFYvozB8q21nTzXV6rDDdfwbY7GpQOFuMrCg/iVrI4HA27TfKPd6iwgipaF2CSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ik3s/CRH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 37F8B40E0185;
	Tue,  2 Jul 2024 12:45:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yDrurNuZkDgg; Tue,  2 Jul 2024 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719924341; bh=ijZkZE9XznnApp6up4UcjQQ75hPC45pe2q9sFxxaCZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik3s/CRHtyfWtp3Gj8m+o/DrBiNBlAESRzya4ZShBaVclzri05XQoLmxeLeV+xd2H
	 KbVGekNohy70doRGqxfRx06Uvndh7piOLm4rd2u5Tyg4bvBdHk2gH9ejSPiv4dz1AC
	 AAsoW3y37gIS88FsmVh5lHfemsHjDqlZAtKZw7ZiStA3hV78K2Ridxw3q/Di174CE+
	 oqeDypiECwEoEaRzryxlQG4QLgpRQePAY4gitDPGZKHyiIvxp24AYJ79ItWWDx/uGn
	 jfcLtKOdsPaOxnkRTlTMH30jb/FRKn10cfEVLBRVolvX1z5b+gS54Itif8exwPbZnh
	 D91EXhkaG2vcPdarTxyixGj4OGRmPIHNHfo93HlhTg34ZF10dhOqgQ1/5eqWkbNnUN
	 MCBzocbo1oFQKZgGbt1P/Y0/6+QPTDjDET1ILGrVaVx3zs4r8bpvbT3GV9I0UwL35x
	 sl7W91zcf1RuOQejgvpH30h2d/4yiACK9pJBNYId46JfumGpp2TODpla8pHzr8psMf
	 KJ7ENF/ee/M9ZhIo5gm1anStDpYuufLgcS5fENsFYt9hXXn4LJa8hR4rJlqcWkeUBo
	 X7+Kv8L3flPO/KB+39aZXRv31xm9xz+WoG5ushF10ZEAbs5WoIno1AzwJwlG4zqcim
	 f3IOlQSMLifHy5+q/Di9iHK4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD80B40E0192;
	Tue,  2 Jul 2024 12:45:29 +0000 (UTC)
Date: Tue, 2 Jul 2024 14:45:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3] x86/acpi: fix panic while AP online later with kernel
 parameter maxcpus=1
Message-ID: <20240702124524.GEZoP2ZKcTcKl1ca1R@fat_crate.local>
References: <20240702005800.622910-1-zhiquan1.li@intel.com>
 <41ee5438e8059c299f5722e386cdc1457ddc16eb.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41ee5438e8059c299f5722e386cdc1457ddc16eb.camel@intel.com>

On Tue, Jul 02, 2024 at 12:05:38PM +0000, Huang, Kai wrote:
> On Tue, 2024-07-02 at 08:58 +0800, Zhiquan Li wrote:
> > The issue was found on the platform that using "Multiprocessor Wakeup
> > Structure"[1] to startup secondary CPU, which is usually used by
> > encrypted guest.  When restrict boot time CPU to 1 with the kernel
> > parameter "maxcpus=1" and bring other CPUs online later, there will be
> > a kernel panic.
> > 
> > The variable acpi_mp_wake_mailbox, which holds the virtual address of
> > the MP Wakeup Structure mailbox, will be set as read-only after init.
> > If the first AP gets online later, after init, the attempt to update
> > the variable results in panic.
> > 
> > The memremap() call that initializes the variable cannot be moved into
> > acpi_parse_mp_wake() because memremap() is not functional at that point
> > in the boot process.
> > 
> > [1] Details about the MP Wakeup structure can be found in ACPI v6.4, in
> >     the "Multiprocessor Wakeup Structure" section.
> > 
> > Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Seems this changelog only mentions the problem, but doesn't say how to fix:
> 
>   Remove the __ro_after_init annotation of acpi_mp_wake_mailbox to fix.

Do not talk about *what* the patch is doing in the commit message - that
should be obvious from the diff itself. Rather, concentrate on the *why*
it needs to be done.

Imagine one fine day you're doing git archeology, you find the place in
the code about which you want to find out why it was changed the way it 
is now.

You do git annotate <filename> ... find the line, see the commit id and
you do:

git show <commit id>

You read the commit message and there's just gibberish and nothing's
explaining *why* that change was done. And you start scratching your
head, trying to figure out why. Because the damn commit message is worth
sh*t.

This happens to us maintainers at least once a week. Well, I don't want
that to happen in my tree anymore.

So none of this text above still doesn't explain to me *why* this is
happening.

Why do APs need to update acpi_mp_wake_mailbox?

Which patch is this fixing?

See Documentation/process/submitting-patches.rst

Questions over questions...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

