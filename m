Return-Path: <linux-acpi+bounces-9195-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA97C9B7C42
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7DF280E20
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6322F19F406;
	Thu, 31 Oct 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MO6FtS8I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926D19F121;
	Thu, 31 Oct 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383192; cv=none; b=rV9LNvjmNN4U0beO8ruXjHGKQ895S1ogZ5wCk6V6THdsyPmJDAb6mLId7aZrJsATO/kF7cwevBkNXEkhq8S1f0OsM55+iG6GDXPJqT9tcvVLk/gZs4N/FdcQiL0MVZ1GurpbQnwsCpr4UXBcMYQ8IDxPAMD1O5cn/SE7poNNLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383192; c=relaxed/simple;
	bh=YUnvh8XF+mERUGDnm5G9QT/jKJiunfYK7/Oby1r+6x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dv12oZv+UIc/VgBw4YXQiaNN1mv1/2DaSzPPup4cdAO6Bo8GZu7U5FaUfc4hJ6I5CvG4QresPjFdtfkHM0qL18TeNeBFEH6+cptzo1HHqmlIJJ70IEv+gS001cqdFY2p7NxlrpqvPKMuA9cJG1V7P2BArWMPC9xovi1nDaTT1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MO6FtS8I; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2FE7C40E0219;
	Thu, 31 Oct 2024 13:59:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id j-JhUJ7QuuxX; Thu, 31 Oct 2024 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730383182; bh=qjpAzN9T7MYnXqarN64Vq83eSL0IXuYgi5LpW86thBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MO6FtS8IBNmCcNevgYmmHgQHvmWrb04DfBAVzajW5kF5U4DjzCWLd1F0rfUQaSQhk
	 z4Znl4RW/Yhdzo6Vzgx/EysxKBF9lrKvbPI3lN4GIAIyoGekmRX7mPv44tGx6aBRUY
	 XDOR0g6Tf4QTnEN7hwizSwhF51bMAGIC9UylRFa2Oj/znhCpdzKXLfwA3wXxWKzl3L
	 q25F/W7y5Ky4ecOUoxRRlLUF5OX8MXWBAvw5xgtEDmJ9E3TIzl1Rf34qKqcUctBt/z
	 5y7T1dE7/fVyy04j80afsVK14fRMMJrBp9zOkW/lvfEUzI+ojqiy+yO+W6vfmAcyyu
	 qzY+V37WmEJS1/G106pwvOyDEKY9I7JrH8dAp4kUHbCR05h/BO6uS0odh2XJux4JUd
	 ACV9JEF9F6HIWg0LPN+WY3WIzvRzJoSSD0c0sBnZpbchk/BN4WsFJxfx9wqaTKTt4m
	 amS1sqOoyoiNCiIfzS1fwCe3L7at13+543E4f9sJYE40kD5vbFEEOGNDBf7vwXgkHa
	 Cx3DtdQSnb+7YBWpkc5WA9prVB2vGTTbWGv5KsYrauDfCyinlefE+mzCcYNub2sEoJ
	 5yh6wqJzG+BTF28u+WPBqHv1Qae+5110IbE8E4lwyUACMg+AWRZDtK5bkNOr8T7u2Q
	 wmZuyQpt9ONZ5uc0JTL1TDQQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE3CA40E0028;
	Thu, 31 Oct 2024 13:59:23 +0000 (UTC)
Date: Thu, 31 Oct 2024 14:59:16 +0100
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
Message-ID: <20241031135916.GDZyONNENEDAViMSOZ@fat_crate.local>
References: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>
 <20241016111458.846228-2-kirill.shutemov@linux.intel.com>
 <20241030114712.GCZyIcwF9MyQacmRf1@fat_crate.local>
 <3rmdms6czfsa4hwfx5egcf5rheojpwhdhwq2gxkn2ffvvymfir@dv7x4cmby6sz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3rmdms6czfsa4hwfx5egcf5rheojpwhdhwq2gxkn2ffvvymfir@dv7x4cmby6sz>

On Thu, Oct 31, 2024 at 12:11:52PM +0200, Kirill A. Shutemov wrote:
> Do we have magic words for that?

No clue.

> I tried to express that in the second paragraph: "no such users in the
> upstream".

Right, so perhaps better to spell it out explicitly:

"Backporter's note:

This fixes a theoretical issue only and there's no need to backport it to
stable."

at the end of the commit message.

> > And which commit is it fixing?
> > 
> > aece27851d44 ("x86, 64bit, mm: Add generic kernel/ident mapping helper")
> > perhaps?
> 
> This one is closer:
> 
> e4630fdd4763 ("x86/power/64: Always create temporary identity mapping correctly")
> 
> It adds x86_mapping_info::offset.

But aece27851d44 has the faulty check...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

