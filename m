Return-Path: <linux-acpi+bounces-15170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D624B06289
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 17:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63AD166518
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E9D204598;
	Tue, 15 Jul 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PXc33a/Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48B1FE474;
	Tue, 15 Jul 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592217; cv=none; b=MH0aPU+GYY/w+mFhz09K8zDxqF0EJKH0kBOmDnKfN6+b4CxdHPKqCSoyK9FSlrgNmw/kPdpPxKKgE3HdLKM8Sw/asZs7yNFlAcVGS3UBz5Hrpu9bNOxr0A3QDTtjiV2e1GpDz+gSV2DwYY6DV/T6hKVxCdWJpbxf9442ueeWBrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592217; c=relaxed/simple;
	bh=HmoZ4lN3wvwAzl5tWZFRqjK3/FTT5rlib3oST7BeXog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqCIGwsSikQczSXD18vWmd28+W9f9NdU9G4rPgv5Qz6K1TEkhO9xQcvI+5FAsnGF+ti839TrBXsDqRvpGLq3oIaHLnJYTVWhf+g2IojOFoskiysnXgHe9zWfHjdHB3rrULYJCWpnHDTyPxjklaC6ph6oJIaNndfR2wfKRC2O5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PXc33a/Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5A68940E0213;
	Tue, 15 Jul 2025 15:10:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zNuZLnjRNb5u; Tue, 15 Jul 2025 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752592208; bh=XNB3FVi86rDQ41zikMknzeSTzlfLx8JzZduWBcGkNJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXc33a/ZNuN0cee7L5ZMqLapPXrOzkljN5rzIYMxoPjjD7ABUPnUV+rmjXdbjoV9u
	 DUEWkFCt3nasNTvibw1vnSHbW1klANe45HBj0qmqrQroBw/c/zaOdN/0np1A1u+XoI
	 mMDoNClJfxe75m+hnUh5oBpMmMYUCs10JI3T5Bp4Q+Ty+uWtsVm252laBccNvEISoq
	 TN2tbA/JLMi3G6X2g4gpmsUkEh8hci5Sfes91CjrTmgZNEi0yJgK4yx6ESeBiPb+Su
	 1FApx5FFhNsi+eb4HyIMZbCCGmtHeC8vzZ41VswdVDeK/h/rAIotC7W0yKVA5XEz/T
	 HZLVU5DNWeuTKX7b4eBqWNNGNfiMce4z5t1qiyUPHKXNhI6/7lv2b2Rr0Ff6gUqOa4
	 ZzMOdrD0nO2kN49MMdfgUTZagQn8IC2uay+Ye2G9YWLC+EM/Z7cXqZsL9gK4S9Yygz
	 y9t4Cpl1ecC7TZGyoaWQBQIsGNA8K5fj6ikil0yHIoRAVwWg2r179lfId0M5B9pYcP
	 kBc9hF0z34amzU0mKp8rW6qU+TrxPzqXcRT3wZAE2tmtqsD4KSF7HdCP+/Zg/mMqBj
	 D3jMh6hNLCHCJd0UBsHaH8wS6xdKBX+sp67EfBor9B5bDIfQrZ1vUij1K8eWEe9kqf
	 8V5BufIjpV52p23RvadHL41g=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E34BD40E0208;
	Tue, 15 Jul 2025 15:09:53 +0000 (UTC)
Date: Tue, 15 Jul 2025 17:09:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Breno Leitao <leitao@debian.org>, Alexander Graf <graf@amazon.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Gonda <pgonda@google.com>, "Luck, Tony" <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	"Moore, Robert" <robert.moore@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <20250715150947.GAaHZvOxsvEvALZNDd@fat_crate.local>
References: <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>

On Tue, Jul 15, 2025 at 09:46:03PM +0800, Shuai Xue wrote:
> For the purpose of counting, how about using the cmdline of rasdaemon?

That would mean you have to run rasdaemon on those machines before they
explode and then carve out the rasdaemon db from the coredump (this is
post-mortem analysis).

I would love for rasdaemon to log over the network and then other tools can
query those centralized logs but that has its own challenges...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

