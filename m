Return-Path: <linux-acpi+bounces-10331-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946B29FE667
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 14:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06BF3A1FAF
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0B1A8415;
	Mon, 30 Dec 2024 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WxgTREaD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19D1A8404;
	Mon, 30 Dec 2024 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565071; cv=none; b=T2dk6gvAK0JFsENOpAHCpg5S3yeyOUjM5ZkFCvqVzXzKgqE2r36RBvgFL5t9Ny+R/o9FNrIoMke7t+ykTUfPRzH7/Z1JMIffVs1B2TOO0USjhSDRD5lvFyIYa6LudTPtI7M5/XoLsqz4ymAIwNPEaSWD3asl+0gbuFMe+QBtvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565071; c=relaxed/simple;
	bh=9ahG7e1FYqkBz2SjErVQ+4j19w0CJzUUtRy1fXEd/Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akPoWTkk+8FmqGgnR70cSnfMTvJVfkcH7BFJmkIZ7t8x2BFqamefDhtX6hPcQaVE5KGuPPDrOVmD2Qsym4/hkBWbju4XhA17Mp8Ics78luHAT6JCQcK5lF3NK50uUL+q94KSMaN+7NrO3kHz+kN9zA1L16RkvIN5xaK+XdPcTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WxgTREaD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 21C3C40E0266;
	Mon, 30 Dec 2024 13:24:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LfG160ZLHRsX; Mon, 30 Dec 2024 13:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735565061; bh=hSUsdBWO8UrOM7Dcvr+xVCV2dlJ+YXUz7ivWsAsvmac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxgTREaDFLl5Mny++ZkvLjYiDReGpm5Z4khxH/mgH6kBdVSMUFCRj7FWgqOO79/Fg
	 b4nuwx7dpr8R0qg3QQ5zjdxalPTKYmy9YNsXwkeAwftvUsseVx27W7EhNDkh6Gzcac
	 m3h+Pz7K9QDCNu4iX93Oyn5FWq17+0+I3BEykbnWyiHmXYKi7nMQeoip+u7fBcVRGP
	 b7mNEmgwMAFe6GrbmTzHWRdvhsVimPrW0dEdNCcQFf6RsUTfBbY1xMxVPO18xf1Pa6
	 AXpq3zTN2df6hOTvFrbDu0XS9zML32uYUZLj4uPFPoB5qLp99WXPIvZ7pnt1lYOXRy
	 ZB2ON5h4MygM6g5d0Z4dBd2j7AjgjzLOt5sBgzTdt8TnhR/0fmFWRO6X3+7Xqzw6LT
	 rgsIduhL54AcaW7PTYEJhWC1RJHdpol+XEUt9HSwcJcTJzNf6m2OAPT3mrkOIC3goW
	 tAZBwXdRzbNw+wLN12NFEc6TnGgsOTFZvD+cy/kEQ63bOW3oGgx1feZW6QUaFBV0Hf
	 6G0jEX6yjrHLap64vaTg9UolM6WP97J7CKI6iMfYQY5hvQnq4yAIYhkiGlEayVfHjX
	 tVZHgB8/T2hZLt5CGEKfjIIYz7VplsgVtrJcFUpb2Dkdd3Bcih2TUeDFYzlGx1Dg8H
	 Vd1OUan/Y2wtyUZKOwKF+CYw=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70E2340E02C4;
	Mon, 30 Dec 2024 13:24:09 +0000 (UTC)
Date: Mon, 30 Dec 2024 14:24:03 +0100
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
Message-ID: <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
References: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
 <1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
 <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
 <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
 <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
 <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>

On Mon, Dec 30, 2024 at 09:04:11PM +0800, Feng Tang wrote:
> As per kernel config, most ARCH has 'panic_timeout' as 0 by default, so
> need to set the kcmdline. For the case in my commit log, where user had
> clear requirement for not-reboot and wait, the manually set 'panic=0'
> should take priority here?

I think so.

I'm not convinced that lets-log-the-hw-error-faster should override the panic
timeout setting but I'm open to real-life example scenarios...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

