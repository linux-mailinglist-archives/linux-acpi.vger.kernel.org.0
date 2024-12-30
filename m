Return-Path: <linux-acpi+bounces-10329-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023CA9FE5C4
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 13:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0AE3A1E0E
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019FD1A3AB8;
	Mon, 30 Dec 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Evptad4g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8D126C18;
	Mon, 30 Dec 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735560634; cv=none; b=Shle2PfC83GnTnVShdHEFd+VKbiFFTTeYj3NURI1wEYTXoR/izKjijH11Vq67NJk90l3ot7MRfzqCH7n1ZIkFQm+l8RMidRan19fkhAJ6vxK3ieOKiEKNdm6X916iVzKEDiyN0VPaKe8Bufua86Dd0wo5uncoK1sEUjgTEUIdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735560634; c=relaxed/simple;
	bh=y4vUF40SNU3r6lJHVy9PB5HpVHUlZEYQJQ5z8y1ZVzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbOj0bo3ZRQnt/kONI1QZkg+kqMYXg4OP3fbU7neHys3mvllo+T6Jn2SHN6vLBVf3Mv1X36ZqGgkOVwSEVIQ4nUPVDZidk2gsZ9oVsIAVYb6MM2EjRBwU99LmFMonxPl+nqPQcKKVsGiNzu3Uo4vRMzxmzz4yLJqGkiM8vQBLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Evptad4g; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ECD5440E02C4;
	Mon, 30 Dec 2024 12:10:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ls06U09l14tV; Mon, 30 Dec 2024 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735560627; bh=KHSl7cwnALoJClsV/rXpUKHhFeegpXDKxNHK01L8fwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Evptad4g0blKOMlDTtrni/NjDC0jmoD7l2E0tZ0w7eL6/aZMJEoCdD6SmbWodbv8F
	 5/WBXxG2GPkuyRZHNyFK79j/woncVyOTZpRzqfIh7O90UXqEZXr1wvcOwLr3mTtK1J
	 ZANk4/EnjfCtonxSgUmfux1lgzMgfarGHULnES4HTvyYMX0qJAMxjnf/ALE8sxjCic
	 LSIQbS5Ss7ANCsDGxoxfgf5zJp0VcuwRNLWyR9eCt6c1NBBzECfKqGjEhXpswg/jxn
	 kPHeTkV3my2aIOTQ5bynuuuDJC2MbW4sInzhjgZojg7Ka8s1CDFKOIhH8a19Z/i9D/
	 BRioSYLzmIaBsYfx332aKHkgW9bto8npzt4f/dlz93+3OkNkDIpt+W5nkvPQZtg5mN
	 KH4JWacVFwS1pI1WXUFcCesosd8KqZb6SWUYwzon/W4kSTb/QSUH7lz1hJ3+wvV8Jz
	 b8cr3V/HYnJChor975VOa6rsAPNG9bzUL3YEVdXEJQNjD8HjA1+Zv9nhlEGAVRSIcb
	 IU0TdTJauX5oEWYHPdszPdBtVheko6FJ52irJUVpFRenwvjQEp3v8zNKDZk1O/JzWt
	 UVoTmA1Yl77t9RLzW3lDv3pJEYZStsAP+0aJLey36UPeqmfR8brHYcIoXY/sM5uDFM
	 UdnBhGYulg2mPF4y2xkRGPLs=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC8F940E021D;
	Mon, 30 Dec 2024 12:10:14 +0000 (UTC)
Date: Mon, 30 Dec 2024 13:10:09 +0100
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
Message-ID: <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
References: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
 <1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
 <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
 <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
 <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
 <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>

On Mon, Dec 30, 2024 at 07:40:18PM +0800, Feng Tang wrote:
> Still we may need to honor the user setting, say if user specifically set
> "panic=XXX" in the cmdline, we should detect that case and skip overwritting
> the panic_timeout? 

So the user has set panic timeout to something, machine encounters a hw error
which you want to log/report earlier but user's panic setting prevents you
from doing that.

So what do you do?

What has higher prio?

I guess we're something like this:

https://youtu.be/gLFQystE8vU?t=71

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

