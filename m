Return-Path: <linux-acpi+bounces-15151-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F08B04699
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 19:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CC61A62415
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8954F265CDF;
	Mon, 14 Jul 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Re4a3htN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111726529E;
	Mon, 14 Jul 2025 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514574; cv=none; b=BullrHufiDO2gZr8ZK1x9SHBiGkXso5xHAbB+YfD37DaeLOREgm/vtkO4GhVLsvPzqxjHHHWPXR3Vp/bKRm4We1EoejTVI8JhJ7ASXby7lSQs1gNPtOcejcAHqTy48UjKaFjprxq3D4jri8PSbSAdz+gKkbf90a3SylYUQQ/daQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514574; c=relaxed/simple;
	bh=8IU5WKPXqylOyQLEbZfhqTgJkFBOD7Uvwv/JnKqP4cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIRkCv6XCMDEjhaGTgqQ1hlGxM+yVMMPV8p0Lnf8r8LuFt5ZeC4LxIpwrPCoO3X/7fTwYk8aKdPBLKk6WRdyL4LTfLi3OYP51pRzMcdal6EWBtWqWkDe+Lt9tC7eds+6ACpPIClrLgJ04FnsyEB9gX719CpM1HqoXeYeBrtmcVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Re4a3htN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5395040E0213;
	Mon, 14 Jul 2025 17:36:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3udpkK78Ryqj; Mon, 14 Jul 2025 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752514567; bh=s+72wSplaPZbA1EC+HBfXzH538BlwXjxnGTIl4hRRbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Re4a3htNorDgunbABNMiYVRqfeal96HQl3+sYxq2m6Y80UaeJrYFCoBpT7iqEVCAU
	 zgyasTmIjG6VuUYUU+n++RqZInVK+Sdmvu65bmAgEs0Ks6PYgdOUAz8yTS7qfEl8sD
	 D60hO+3oJyRynJa9T8Nv/ufcLYMZeY/of7BSIGvo92ZGZHN52LN09Upd9Q0/p48sbZ
	 KicnO0VlqyI6+83U46+bqyTrYtW7viRSnapMB5i2ar00bnY/lfLZMtXnqQS+A5sNUg
	 2qTeEc3hjATQbXy/b/PuucvIz6c8PoNO3S7LvdPeUtSoJbMHZksCNHe+ldyTl1QdFB
	 rCbZcMKkGfmdZN06zyCVZRHVxiR27rT1u6/ibVfN54sx8qCZB1+W68TRzYMid0ps+p
	 s4T5MTCJQ3a4nhe/tXv8uxrCRmsRuhcX8LDi7ce5/VWP+anbozv4qZeMsyujoqiG8u
	 /b5FbXWW9U1624v0qeSyOQV1oA11vu7IKIdJPuCeFTCgi6nirovkciGhrtug/FH8xM
	 63y4vZQA7Z/kDvma7Z/PA2/ukhGnbo5OQd1DmgW8sCyyENE6b78RjZlJkIUuEX/bcl
	 eHZY2Omq6N0xEgyUUBnqSY999tCxD6QMPJf09VTc/sPJ+1rpPwts+dvVkKPD/qrt5N
	 pDmHWGifhHZ24M4VPVs6ppf4=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0147F40E00DA;
	Mon, 14 Jul 2025 17:35:56 +0000 (UTC)
Date: Mon, 14 Jul 2025 19:35:56 +0200
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
Message-ID: <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Mon, Jul 14, 2025 at 05:33:45PM +0000, Luck, Tony wrote:
> > If you're going to do this, then you can perhaps make this variable always
> > present so that you don't need an export and call it "hardware_errors_count"
> > or so and all machinery which deals with RAS - GHES, MCE, AER, bla, can
> > increment it...
> 
> Not sure I'd want to see all the different classes of errors bundled together
> in a single count.  I think MCE recovery is quite robust and rarely leads to
> subsequent kernel problems.

That's what I said. And a RAS tool can give that info already.

But for some reason Breno still wants that info somewhere else.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

