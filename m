Return-Path: <linux-acpi+bounces-10336-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D15C9FEEB4
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 11:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A09E1882577
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 10:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0C18C910;
	Tue, 31 Dec 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B45dqc3k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36A7BAEC;
	Tue, 31 Dec 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735640172; cv=none; b=U6tqqmuISwjO5rSR50eDQLbT9BUrxyAUAy/iOz9xs3V6fWk5A0wgLzkZmLFy03sCb1sHsizYo7a5eThtUeTTKlpQZhNZvZgkuo1qrE0/PddzxmMomhu3ziN4y7KlT/kSdspOJlsOQM2CzA+IPdK7b9V4hb5fbz+AUKlZd2UOOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735640172; c=relaxed/simple;
	bh=bkYQeouCbVu0Q6Ig7unIl5HylC2UO8LX1IokAVP0g5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn9kfHyCRKUwsMKY1/SU2TUnj+bU4CdgEfTMsmhz2acm9lLfZVikirW/k5iW3sBV+MTxsNSLElDgLTzE1+ciWMvIXd+l6UYdVz7uiT69KPQWKgf2d0DBmjhvZRIelm6snCL6E5tP9jmYVlIpmngxF/tcVNFJlUVWL6dmPfnBnBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B45dqc3k; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735640161; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Dj8KIyX31h9fY0JSmXUoiFOaJ8quVrl8Y/8pQ/3sZbs=;
	b=B45dqc3k9y9/FeDesmO/NATxpJ1AZ48G/OSKRzLzNSu/C6BSKBeFA2MxckeFWC/mj3z1nN/1uFamvuJT/wHPXC2sVT3YqDZ45xALQ7LAdS7Ms30Qh6YD/1o2fxZHlWaS/lWLQP2z21dATuthfMatbp8dVJAJOyOX+c5tb+WKH0E=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WMdmjAk_1735640159 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Dec 2024 18:16:00 +0800
Date: Tue, 31 Dec 2024 18:15:59 +0800
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
Message-ID: <Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local>
References: <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
 <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
 <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
 <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
 <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
 <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
 <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>

On Tue, Dec 31, 2024 at 10:23:58AM +0100, Borislav Petkov wrote:
> On Tue, Dec 31, 2024 at 02:44:48PM +0800, Feng Tang wrote:
> > +	/* If user hasn't specifically set panic timeout, reboot to log the error! */
> > +	if (!panic_timeout && !strstr(saved_command_line, "panic="))
> 
> And you want to scan saved_command_line because?
> 
> Hint: look at how other code checks panic_timeout.
 
Thanks for the hint! IIUC, you are mentioning the set_arch_panic_timeout().
One thing is, most ARCHs' default timeout is 0, while in our case, the user
will also set 'panic=0' :), so we can't easily detect if the 0 is the user-set
value or the OS default one. Originally I even thought about adding a flag
of 'timeout_user_changed'.  Any suggestion?

> > Or we want to stick the orignal patch, which doesn't change the
> > original flow?
> 
> And pile more broken stuff ontop?

OK, will skip this.

Thanks,
Feng

