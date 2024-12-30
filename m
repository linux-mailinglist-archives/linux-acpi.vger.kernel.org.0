Return-Path: <linux-acpi+bounces-10330-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B549FE624
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 14:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CFA67A118A
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40E11EA6F;
	Mon, 30 Dec 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I9XAx7aY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10541370;
	Mon, 30 Dec 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735563858; cv=none; b=r0deuBb9WalS/UFE/VsfiQHSF0kRpM8mh32wRGen9MeSfuQFW6DszRsKgiyM4PNG1Xk2/a1q6yIRcjxKLQMtP3PlOZ2ylyybjRT7w/+CrhxGDxITtbfIONwA2bWWWCBEFtryc/zFYuwKbgHhJ7Ztw94Ok9dp6KvMNNaAGvxPRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735563858; c=relaxed/simple;
	bh=gGI7GK6FK59YdnveTIQXWsea2//BhfsHbymjnvJNEfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHaCnpL2Q50BU2xYiltkLS4IHc4LgyffNINgDmzsq5kTIIIuqFlN+XEDZyb3mTvYs8jlfeKReDRDgEwx7nO8i2n1zhXagoX20WYOaXPXd+Zfs24CwOlIOsXjpLjRCzvtb+NJjTKm/PcGQMng5wQeGN5Di6/lAOkR5dAekjIOyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I9XAx7aY; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735563853; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Ez1VdcEKu+AOlow2xHxzJoOEFZHoSPKWW1tKYYJZGts=;
	b=I9XAx7aYEknUJy99ilXhx3Iraf/aCIEOeAlp8hVu9KHSM6LOKN5pDGI28m9Ee101QiFK5l+rUTctjjUZUn1JOuZhTIl2Mkqo84Rtx+j1TWnd59I7LhxTysdgzBM6xtBL8zktYHBzAoeyXF0zDuAl6NomTT1TDR+4Hu+0V+ZBJ7U=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WMY387b_1735563852 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Dec 2024 21:04:12 +0800
Date: Mon, 30 Dec 2024 21:04:11 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>, rafael@kernel.org,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] acpi/ghes: Make ghes_panic_timeout adjustable as a
 parameter
Message-ID: <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
References: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
 <1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
 <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
 <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
 <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
 <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>

On Mon, Dec 30, 2024 at 01:10:09PM +0100, Borislav Petkov wrote:
> On Mon, Dec 30, 2024 at 07:40:18PM +0800, Feng Tang wrote:
> > Still we may need to honor the user setting, say if user specifically set
> > "panic=XXX" in the cmdline, we should detect that case and skip overwritting
> > the panic_timeout? 
> 
> So the user has set panic timeout to something, machine encounters a hw error
> which you want to log/report earlier but user's panic setting prevents you
> from doing that.
> 
> So what do you do?
> 
> What has higher prio?
> 
> I guess we're something like this:
> 
> https://youtu.be/gLFQystE8vU?t=71

Hah!

As per kernel config, most ARCH has 'panic_timeout' as 0 by default, so
need to set the kcmdline. For the case in my commit log, where user had
clear requirement for not-reboot and wait, the manually set 'panic=0'
should take priority here?  

Thanks,
Feng

> 
> :-P
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

