Return-Path: <linux-acpi+bounces-20275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA668D1CEFE
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 08:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 406B930146E8
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AE337BE60;
	Wed, 14 Jan 2026 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yhz9eVpp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3835E523;
	Wed, 14 Jan 2026 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376892; cv=none; b=drakMLvy972U3Hwg4negtXpHr21GE+N0xLdgthdEV1KypHSEm+76rx5Q1J0L2xptvfRWwOeqXC/lN1vnsBsyKDTnQdkvbEZ+k1QbGxSqP3/Pdzhte044zKM6iNxw0HLYFfCluawA8ufhc4Dn3JbS/6mzltEEnxMVljTLqx30G3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376892; c=relaxed/simple;
	bh=TJ+rJsaKH3QQ3WAfFW5kYZZTnhZ6gxrYY+bsG9t3vqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amwsDPW4ONcf0HAO410sIbJ+JyZyrveuEN1pZHQhhq5jGJ2THdIUfJIofwCtX7DUmI8uPRCfLMKLpzfFL8hYN2NGeJ3JVAhfVTcm0kG3OwQn6t6qVT4XXvrt0BHqh7OPfcIHfIkbAcfGJeapl9a9bHk411JIrPQ+KyadZBKAmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yhz9eVpp; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768376877; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=por3oCbMyad7aQvcq37Xw75Anh9VtEyaGJfm1peZ4LA=;
	b=Yhz9eVppcN2uMpGxJhkCTKcNk8R7g8wIKnsPLF165PWuExBSsawIc08aGuvLBRLL8k9xDA29MWVR7M3tgTjkLMnUekl76pn4amIZdsSRUinOPLWLcI/6x4qOvAzBaqqJctee6obyT+d3xYyi/wn/d07al6S6Osc+WkhKAsOUeAY=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wx1ZMe2_1768376876 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 15:47:57 +0800
Date: Wed, 14 Jan 2026 15:47:56 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWdKLClEHQ1cg34-@U-2FWC9VHC-2323.local>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus>
 <CAJZ5v0gXMAFRCH8sn7OSb8Dc8XCf0wgi-CGre8i76KXAZ8tc-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gXMAFRCH8sn7OSb8Dc8XCf0wgi-CGre8i76KXAZ8tc-Q@mail.gmail.com>

Hi Rafael,

Thanks for the review!

On Tue, Jan 13, 2026 at 05:21:07PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 12, 2026 at 6:03 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 06:49:09PM +0800, Feng Tang wrote:
> > > There was warning message about PPTT table:
> > >
> > >       "ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> > >
> > > and it in turn caused scheduler warnings when building up the system.
> > > It took a while to root cause the problem be related a broken PPTT
> > > table which has wrong cache information.
> > >
> > > To speedup debugging similar issues, dump the PPTT table, which makes
> > > the warning more noticeable and helps bug hunting.
> > >
> > > The dumped info format on a ARM server is like:
> > >
> > >     ACPI PPTT: Processors:
> > >     P[  0][0x0024]: parent=0x0000 acpi_proc_id=  0 num_res=1 flags=0x11(package)
> > >     P[  1][0x005a]: parent=0x0024 acpi_proc_id=  0 num_res=1 flags=0x12()
> > >     P[  2][0x008a]: parent=0x005a acpi_proc_id=  0 num_res=3 flags=0x1a(leaf)
> > >     P[  3][0x00f2]: parent=0x005a acpi_proc_id=  1 num_res=3 flags=0x1a(leaf)
> > >     P[  4][0x015a]: parent=0x005a acpi_proc_id=  2 num_res=3 flags=0x1a(leaf)
> > >     ...
> > >     ACPI PPTT: Caches:
> > >     C[   0][0x0072]: flags=0x7f next_level=0x0000 size=0x4000000  sets=65536  way=16 attribute=0xa  line_size=64
> > >     C[   1][0x00aa]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x4  line_size=64
> > >     C[   2][0x00c2]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x2  line_size=64
> > >     C[   3][0x00da]: flags=0x7f next_level=0x0000 size=0x100000   sets=2048   way=8  attribute=0xa  line_size=64
> > >     ...
> > >
> > > It provides a global and straightforward view of the hierarchy of the
> > > processor and caches info of the platform, and from the offset info
> > > (the 3rd column), the child-parent relation could be checked.
> > >
> > > With this, the root cause of the original issue was pretty obvious,
> > > that there were some caches items missing which caused the issue when
> > > building up scheduler domain.
> > >
> >
> > While this may sound like a good idea, it deviates from how errors in other
> > table-parsing code are handled. Instead of dumping the entire table, it would
> > be preferable to report the specific issue encountered during parsing.
> >
> > I do not have a strong objection if Rafael is comfortable with this approach;
> 
> I'm not a big fan of it TBH.
> 
> > however, it does differ from the established pattern used by similar code.
> > Dumping the entire table in a custom manner is not the standard way of
> > handling parsing errors. Just my opinion.
> 
> I agree.

I understand the concern of this could be kind of special, Hanjun and Sudeep
have the same feeling.

The reason for the patch is:
* The apcidump tool follow the standard general format to dump each item,
  without grouping them according to type, the number of lines of acpidump
  is about 20X more than this, making it harder to parse
* In rare cases like for silicon enabling, sometimes the kernel can fail
  early where the user space checking is not available. If HW debugger is
  not available either, the kernel dumping is the only way to debug.

Does the proposal of putting it under a kernel config look doable to you?
If not, I will keeep the code local for now.

Thanks,
Feng



