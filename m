Return-Path: <linux-acpi+bounces-10325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 626DC9FE539
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 11:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA9A18820B6
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD801A2C0B;
	Mon, 30 Dec 2024 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CwhVO0K6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534F2B9B9;
	Mon, 30 Dec 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735553853; cv=none; b=GyOt5sJE1Eb1j4iu0tCZnIGova6NTaqp/W9VX6ujwVa1GG/EooyUgG6rwAPhDHTBb2paQYrl3d6JN8va/y+iyhYWUJe7Il3WWv+dTcip3cFQemYw0gTUbbUbY8NF/5LtiGU83Ne2rGP0RSI5R8Wqi4yPIbWEnPNQp0RgS3oZjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735553853; c=relaxed/simple;
	bh=06//Qd+ut3MkptCZFfz+ZX6JR+8OfaJP9HldgGP0Clg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIhcTEYeO8vqm/KTjrd4ZzxUUTwn3KLDQw1p4ke3NInR1eQWk+hLDh70zxPlRYkUfRK6BDdwjK7GE0xdkB0VeizgGUmlNNospG++AWuLKAtdiL/PvlHZ0409kMVdtsJGItdNVIz50/6f44BndL3Lc5l7KoVDxCl2v5JL8ZqO+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CwhVO0K6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1041540E0266;
	Mon, 30 Dec 2024 10:17:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WOC1cSsXxH6I; Mon, 30 Dec 2024 10:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735553837; bh=CVWFJg6qc/aldOPgTqHR6mawBkIbe4pkUHHlC9KBTAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwhVO0K6TP7aJWJvuYhMKQLj9DWWE0pyD1D/Dv4uyluGh80ZhnCI5my409f1oXG3a
	 hSSj1K+ewBa5RBK0Dkk2uec2vIobI1+5Dciv/Z048dOgVOlaseKPcKrMlv9u07lt1M
	 XG+YIFpBtGJy1z+OikYwEptw8OxfpTChmvAAhIdrq4iumn3rngBrA1Hn6ygfGpz107
	 DFLnnPxcia9/yh+XI1MyBppBj+NdMkWn/wc+QVbRsHfgYK/fRVW2/Q0hq9064RFkQ1
	 bt3C9lxJ2rmJQ6QeaLdd3/YsFqk1UVtRNW4ma93xIorfb4lRYBxn13ggt0ryZtQBsj
	 BF0DZJk5vn8FxUCogUZIT7RiRaFZ68s/XA5a5AxqmLTc4UbA69kPdVBBjbUv28QhCI
	 2QX3J+wKHeqSxzaXeD85qgJ6jFSBdEzUyV+2WeZotToP98afR5BV2UOUfR3WWTRb6D
	 8ghu3J0DXM1Hl7ZRYIYuqf5NqOSEAXy7Jz8fjCWbGOv2g92O2hA/MYrav06XO2k/Qs
	 lw9hmVylnKPfV9c3bYnlLhtrIkq78fzFa/Viz7HwPRr+sNDqduHYFqnOvILOms2mEx
	 eyGn67GnW03CoWvpk9/uVf5IEKllzd3Zi4RJSJBqC4HWYoO3K5qRxz8EvIwUW1EXQ4
	 Kj+7mU2tn2G2PmHPadyvzVss=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9858D40E02C0;
	Mon, 30 Dec 2024 10:17:05 +0000 (UTC)
Date: Mon, 30 Dec 2024 11:16:58 +0100
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
Message-ID: <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
References: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
 <1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
 <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>

On Mon, Dec 30, 2024 at 01:54:36PM +0800, Huang, Ying wrote:
> For example, it may be OK to wait forever for a software error, but it may
> be better to reboot the system to contain the influence of the hardware
> error for some hardware errors.

A default panic timeout of 30 seconds for hw errors?! You do realize that 30
seconds for a machine is an eternity and by that time your hardware error has
long propagated and corrupted results, right?

So your timeout is not even trying to do what you want.

So unless I'm missing something, this ghes timeout needs to go - if you want
to "contain the influence" you need to panic *immediately*! And not even that
would help in some cases - hw has its own protections there so the OS
panicking is meh. At least on x86, that is.

> So, we introduced another knob for that.

No, that another knob is piling more of the silly ontop.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

