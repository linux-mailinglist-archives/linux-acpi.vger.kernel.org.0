Return-Path: <linux-acpi+bounces-10240-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA689F9E8A
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 06:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22327A2C50
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 05:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF6E1DA0EB;
	Sat, 21 Dec 2024 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g8LzAB0T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11375370;
	Sat, 21 Dec 2024 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734760693; cv=none; b=RE/Ie81lRYWz2xPc/6A+nXycV3bSapPwHR3IsjCOcoJ43J2ebYFBCHdBYJVxCIH83tylT/bz7tUkw36bZhfm+pAF/DMTsOOKD6D0A2YLKN2xln2pUlaVyBjFm9PrXGugWiC3fz6TW1vrqg4qnKOYlTYQJKQFzbuMk6EpG9jXhMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734760693; c=relaxed/simple;
	bh=JCcX79HP3FFv3A7xXMouqEaWOf9v2xAknUXLpGPOQK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R3v9z3DtxsSJX7eTwSHZezRzzpsckQUpHEdNobcg8y7UEqeowzBxmVquAwsSk/mED9XGVJ1TtuRRaBTIfEZdiupZhhkGv+K1iSRHAbw2H2jNGsaM2iZrRHWthNvAkhTrnaaT3GwAsdGX+cA8UVgcwzBmzFDJi/tVFzAsxF5EOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g8LzAB0T; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734760682; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=6BmLQ7unvu8bhKnAukymqDC+DI3RHZRZDRA4zf6Bd9s=;
	b=g8LzAB0TmwshF5HkyJX28rjBdg+2impixAc5f89BF8hFXXQg0yVw9d3YBaLQvliOGP84t+ODaG4A2xkhOMRm/i75/k+f2p0BeK56suF2+fcUV/LU0YgtEluvRlL+Z0YblBZR1xzy74fRM45hpYYHBvdlVN9P2BNOHjBAtmdJGX4=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WLvcNRy_1734760678 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Dec 2024 13:58:00 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hyeonggon.yoo@sk.com,  "gourry@gourry.net" <gourry@gourry.net>,
  kernel_team@skhynix.com,  "rafael@kernel.org" <rafael@kernel.org>,
  "lenb@kernel.org" <lenb@kernel.org>,  "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  =?utf-8?Q?=EA=B9=80=ED=99=8D=EA=B7=9C=28KIM?=
 =?utf-8?Q?_HONGGYU=29_System_SW?=
 <honggyu.kim@sk.com>,  =?utf-8?Q?=EA=B9=80=EB=9D=BD=EA=B8=B0=28KIM_RAKIE?=
 =?utf-8?Q?=29_System_SW?= <rakie.kim@sk.com>,
  "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
  "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
  "dave.jiang@intel.com" <dave.jiang@intel.com>,  "horen.chuang@linux.dev"
 <horen.chuang@linux.dev>,  "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,  "kernel-team@meta.com"
 <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave
 auto-tuning
In-Reply-To: <20241213195754.2676135-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Fri, 13 Dec 2024 11:57:31 -0800")
References: <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>
	<20241213195754.2676135-1-joshua.hahnjy@gmail.com>
Date: Sat, 21 Dec 2024 13:57:58 +0800
Message-ID: <87jzbtr315.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Joshua,

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Fri, 13 Dec 2024 15:19:20 +0900 Hyeonggon Yoo <hyeonggon.yoo@sk.com> wrote:
>
>> On 2024-12-11 06:54 AM, Joshua Hahn wrote:

[snip]

>
> [-----8<-----]
>
>> > +What:		/sys/kernel/mm/mempolicy/weighted_interleave/max_node_weight

I don't think that we need a new knob for this.  Just use a reasonable
default value, for example, 32 or 16.  If it turns out that a knob will
be really helpful, we can add it at that time.  For now, I don't think
the requirements are clear.  And, this is a new ABI and we need to
maintain it almost for ever.  We must be careful about new knob.

>> > +Date:		December 2024
>> > +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>> > +Description:	Weight limiting / scaling interface
>> > +
>> > +		The maximum interleave weight for a memory node. When it is
>> > +		updated, any previous changes to interleave weights (i.e. via
>> > +		the nodeN sysfs interfaces) are ignored, and new weights are
>> > +		calculated using ACPI-reported bandwidths and scaled.
>> > +
>> 
>> At first this paragraph sounded like "previously stored weights are 
>> discarded after setting max_node_weight", but I think you mean
>> "User can override the default values, but defaults values are 
>> calculated regardless of the values set by the user". Right?
>
> In the implementation, the first way you interpreted is the correct
> description. That is, if a user manually changes a ndoe weight,
> then updates the max_node_weight, the previous manual change will
> be overwritten by the newly scaled values.
>
> Does this behavior make sense? Perhaps it makes sense to ignore
> user-changed values when doing the re-scaling if a user decides to
> change the max_node_weight value themselves. 
>
> Regardless of what implementation makes sense, I can re-write the
> description so that there is no ambiguity when it comes to the
> expected behavior of the code. Thank you for pointing this out!

I don't think that it's a good idea to override the user supplied
configuration values.  User configurations always have higher priority
than system default configurations.  IIUC, this is the general rule of
Linux kernel user space interface.

---
Best Regards,
Huang, Ying

