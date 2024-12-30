Return-Path: <linux-acpi+bounces-10328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E97DE9FE5B3
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 12:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA55818819D7
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 11:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E01A76BB;
	Mon, 30 Dec 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CuvAHFRT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AC1A725C;
	Mon, 30 Dec 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735558833; cv=none; b=DzgbkFtmz9pTL+BRm/j7Xgxxg0KrHCsOH7JmL8otViGFIgDKTjFOQDRLwrOJh4P8FPVY2wWOmr6I3zJ8gFl8G4vG75LwPugBoc9fuW76X/yeA5hbP9vzd3vBO8nI+hoLmDN9X3+AqJoo6dluf9EJHL/tb7wzFcHcsk42wib8sV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735558833; c=relaxed/simple;
	bh=h+/LOAm6VMeMxlR3FuEXrulxipp5Rn9CqdDYD75zys0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRQ7QEbb9w+cH/a/q3TrIwgiYwtxXyBzcpPVXRedhScPsrX7S3VZJvYfyAvQfM1H6bOrrcQpRw0AOIjbgXMbt4+R7Zey8W6z9wRmsKL13QDHZi22kNe7/8Hx9m4SBusQY12kFR/2LgoI4Wd1L16HnNQ8cioSBunPgdboZgAA1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CuvAHFRT; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735558820; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=9Ly4J5WnR4cmToOR82IuFV0ajsX1MTvf2XAoP2T/K0Q=;
	b=CuvAHFRTEAolZ3/z0+8/MjC/K13JRx0Y7WsRGJUxCydeFXAvcRBAxFfVDOMoAnMPOlUUEn8zgLV4ZdwT6piWQC5vxxwGnVApCai5VjDb9joI1R1dBREUR71THBgZowUw+vDMTBWPXnZPYJu66FEH5AdXfRA1CdGh3bBgivP4y+Y=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WMX9utZ_1735558819 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Dec 2024 19:40:20 +0800
Date: Mon, 30 Dec 2024 19:40:18 +0800
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
Message-ID: <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
References: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
 <1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
 <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
 <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
 <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
 <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>

On Mon, Dec 30, 2024 at 12:26:08PM +0100, Borislav Petkov wrote:
> On Mon, Dec 30, 2024 at 07:04:59PM +0800, Huang, Ying wrote:
> > Another possible benefit of ghes_panic_timeout is,
> > 
> > rebooting instead of waiting forever can help us to log/report the
> > hardware errors earlier.
> 
> So you rip out ghes_panic_timeout and set the panic_timeout in the ghes code,
> when you get a hw error which requires reboot.

Still we may need to honor the user setting, say if user specifically set
"panic=XXX" in the cmdline, we should detect that case and skip overwritting
the panic_timeout? 

Thanks,
Feng

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

