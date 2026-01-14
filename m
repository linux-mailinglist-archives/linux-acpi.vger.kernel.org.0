Return-Path: <linux-acpi+bounces-20274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39664D1CC3D
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 08:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAD143004B92
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 07:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCCE376BFF;
	Wed, 14 Jan 2026 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hEpn6Hwu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7F374189;
	Wed, 14 Jan 2026 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768374423; cv=none; b=iKk+vTHNMabPhBUoOKw6tXemJbtsOFUP354VCekp9HEDnWz+WxtKf2wLNZkEt4SR0R0aew25ZnvZZ5N4XmL6TkeNyjYo0N32R65BRqMK2TQ5H/0u8cpHXaM3t/anucoFbyA6Wm6n0SPQ0d0r0ywoNmVfefxsv/N61RPEnzECyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768374423; c=relaxed/simple;
	bh=rAy+B8mHZVC9TX9kxOdPVxN8IPJuBi5/ncZ+VRyU08c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS84R3mK8jm+XytMc1K7v/qXWEWfY2lte4mBvaNfoWl076yrPOoTiVLmIOdNOszlTwzLeMvl3I4B67ixVru6WlahAhLKIb3PotLOmFkDTMHmuoXeT/LfewK15fGPHrDE3tfl+EF0kVIu/UtBPNLounwJTE+2KHyeK3iQijMyXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hEpn6Hwu; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768374411; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=X1q3AxCeZWc3sXJ+2Tx6Hc/gUb+8CIWKomGxwbllRAw=;
	b=hEpn6Hwu6RuVOVzMPp8dBS4F6W41l/MYoldDt5nq8Bugx0lXANKe5k17lmZIJDiAWt6qIlmilK0W7lVlgFNvbKJuBModCdpiBCavdCLwVvUXHID++x1IpOksc0eLy0rz3Lt6qZbdJpZjCptCJ89Y6K8UGYkTaasKW25spQAwnHU=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wx1MuLo_1768374409 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 15:06:50 +0800
Date: Wed, 14 Jan 2026 15:06:49 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWdAiaC10ear9ajR@U-2FWC9VHC-2323.local>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus>
 <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
 <aWZZeD496CPi20Gc@bogus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWZZeD496CPi20Gc@bogus>

Hi Sudeep,

On Tue, Jan 13, 2026 at 02:40:56PM +0000, Sudeep Holla wrote:
[...]
> > > > 
> > > > With this, the root cause of the original issue was pretty obvious,
> > > > that there were some caches items missing which caused the issue when
> > > > building up scheduler domain.
> > > > 
> > > 
> > > While this may sound like a good idea, it deviates from how errors in other
> > > table-parsing code are handled. Instead of dumping the entire table, it would
> > > be preferable to report the specific issue encountered during parsing.
> > > 
> > > I do not have a strong objection if Rafael is comfortable with this approach;
> > > however, it does differ from the established pattern used by similar code.
> > > Dumping the entire table in a custom manner is not the standard way of
> > > handling parsing errors. Just my opinion.
> > 
> > Yes, it's a fair point about the error handling. Actually for the issue
> > we met, the PPTT table complies with ACPI spec and PPTT table spec nicely,
> > that it has no checksum or format issue, the only problem is some items
> > are missing. 
> > 
> 
> Agreed, but how is this any different from other tables that contain optional
> entries the ASL compiler cannot detect?
> 
> > So I would say the dump itself doesn't break any existing ACPI table error
> > handling, or change anything. As Hanjun suggested, it could be put under a
> > CONFIG_ACPI_PPTT_ERR_DUMP option as a PPTT specific debug method, and not
> > related to general ACPI table error handling.
> > 
> 
> Sure, that could be an option as long as CONFIG_ACPI_PPTT_ERR_DUMP is default
> off and are enabled only when debugging and not always like in distro images.
> Does that work for you ?

Yes. It sounds great to me.

> > We have had this in our tree for a while, and the good part is it gives a
> > direct overview of all the processors and caches in system, you get to
> > know the rough number of them from the index, and items are listed side
> > by side so that some minor error could be very obvious in this comparing
> > mode.
> > 
> 
> Agreed, but all this info are available to userspace in some form already.
> What does this dump give other than debugging a broken PPTT ?

It is mainly for debugging issues. Though we locally has option to dump it
on boot unconditionally to help kernel/BIOS devleoper to have a quick
overview of the PPTT table, as the table gets updated from time to time,
or sometime the kernel could fail before booting to user space.

Thanks,
Feng

> -- 
> Regards,
> Sudeep

