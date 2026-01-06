Return-Path: <linux-acpi+bounces-19976-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8FCF8942
	for <lists+linux-acpi@lfdr.de>; Tue, 06 Jan 2026 14:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 869EE30084EC
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jan 2026 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E1331A4A;
	Tue,  6 Jan 2026 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oayL/TUM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5753314D7;
	Tue,  6 Jan 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706750; cv=none; b=AwZUfwb+sM8oGzqQK8uhpuEqi+AK+u82EGlgWEB9ko0w/dMDYiGyjqWYyE7a64v7NpEeTIvRewGUteThb/DLpj5Fx1UH305ieCyePwxc0VGqyC85fqjn/WqzT4cQ2S57cDRj9+Fc1RPkwuxd2TMlr86lc9dYNlaccSImHCBFul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706750; c=relaxed/simple;
	bh=vzhZy47WO9h/hidipeIZvSD1hWbqbVl3/wPi0/CNmjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQdIqehG5zMOBRY3Kiofq9sBc3eUZ6p0o5rX3yT+QY7UBU8phRueDqZhkVBhmN36QJyA6Wh9zVEysvM319vPlGFS9C2dl5ykkmHpvx4dARua8w1q9+VZYbc/qxkHqJdEVnelZf16QapaegwajZwO25/067ZqgJoEVym5NTf2Jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oayL/TUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA68C116C6;
	Tue,  6 Jan 2026 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767706749;
	bh=vzhZy47WO9h/hidipeIZvSD1hWbqbVl3/wPi0/CNmjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oayL/TUMAzhEKXOUJ/hfA814KsaGfFTjsyIvPeuCq93vKHvPfd75A4vB+EL1zZrZq
	 2aRLgSyubyz1GIU1wNbcolrtcftrLXdOQ8NB7i2ObGKJpkw3TUOhwhTmkO5pxgbWez
	 GnNQWd2bekBpdQe8DHW1yP33HxRYV3TO45JNKgBxWBa8Oy7IqA9Is946LgC+v+dL60
	 6VlMFBVUmDkdIGwEWq/5kqup9Hfgz2R0KF7NBZkL6meXvvEmC88JTW23Y8Cl0xlFyy
	 iAWVFw1YGwJ3KJXumXemjZmA5ZldxjNd9tGeZscPjgDg/DMDrCZKK71lh4mQgsf2ZV
	 Zr/aGCopMDRsQ==
Date: Tue, 6 Jan 2026 13:39:03 +0000
From: Will Deacon <will@kernel.org>
To: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>,
	"kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH v5] ACPI: AGDI: Add interrupt signaling mode support
Message-ID: <aV0Qd3k-MXVJXlP5@willie-the-truck>
References: <20251222065359.27330-1-fj1078ii@aa.jp.fujitsu.com>
 <176764598538.1443384.12447831892240359560.b4-ty@kernel.org>
 <OSCPR01MB16310961C8744194C94C51CAED587A@OSCPR01MB16310.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSCPR01MB16310961C8744194C94C51CAED587A@OSCPR01MB16310.jpnprd01.prod.outlook.com>

On Tue, Jan 06, 2026 at 07:29:58AM +0000, Kazuhiro Abe (Fujitsu) wrote:
> > > AGDI has two types of signaling modes: SDEI and interrupt.
> > > Currently, the AGDI driver only supports SDEI.
> > > Therefore, add support for interrupt signaling mode.
> > > The interrupt vector is retrieved from the AGDI table, and call panic
> > > function when an interrupt occurs.
> > >
> > >
> > > [...]
> > 
> > Applied to arm64 (for-next/acpi), thanks!
> > 
> > [1/1] ACPI: AGDI: Add interrupt signaling mode support
> >       https://git.kernel.org/arm64/c/9296d4fd190f
> 
> Thank you for applying the patch.
> 
> I apologize, but there was a mistake in the v5 patch I submitted.
> I mistakenly sent an older version (v1) instead of the intended v4.
> 
> Could you please revert commit "9296d4fd190f in for-next/acpi" ?
> I will properly prepare and resubmit the correct v6 patch, which contains
> the intended changes from v4, as soon as possible.
> 
> Thank you for your understanding and cooperation.

Not at all, thanks for letting me know. I can just rewind HEAD on
for-next/acpi. I look forward to v6!

Will

