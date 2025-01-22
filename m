Return-Path: <linux-acpi+bounces-10785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B4DA18999
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 02:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2876A3A9284
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 01:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13288433C8;
	Wed, 22 Jan 2025 01:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FYIZw9jD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D94C9F;
	Wed, 22 Jan 2025 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737509853; cv=none; b=AGXJm9E0l0iXujM4RNWelBsabXQiznrpvwo/0BJDL5goCzoZ3h81QIVOkXRE0ZtSGRM3bQA0I7Bk0+bDUcpp69bkT8kQWPxeJrL4/bJEMCGuOrBAXMudyWfC0g6+bC18wpYFJEvGgLi0FwzfkTjUo4HZCf1BsO5gf+cG4Jz7+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737509853; c=relaxed/simple;
	bh=OjbnLw86DqVsnxIi2wL042GVGNbn2+f7Z/GWLS0OpdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYzhaq65VeipKEq9ljoomNAxJFMaUs7wg01Kn0K3qwCXz9vXFs3KwevTy7Kd3Iw7IzJJJPiBlkW0xI00JKcLyv7GpefXKugX9NkWwUlf/lyDpBClS8qdWIS3uHdNh21gStqmfWhqZ0LMwQoDjokV3Y4ezHCNpS8CqvRoW6fR9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FYIZw9jD; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737509842; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=rT1fOpwUiVwPsQgO7JwgisGYgbIhkRsKCAiqVZXk6/o=;
	b=FYIZw9jDWJ8jjr5dS61xnCunpghnogYhLcDlL3rxb3YBp2d+A8FKzOul37R3cyJJTTqn4yiJHEaJeQjLe+6vDjYekQoDmuMHT5GbHhoFeHvwS9JlPs4ZDniC0crSLlHDMgGk1ksOWvcF4YRKJc+fZo68Qb6BpjADlJOHLBF3x5w=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WO6fJNc_1737509840 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 09:37:21 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Gregory Price <gourry@gourry.net>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,  hyeonggon.yoo@sk.com,
  rafael@kernel.org,  lenb@kernel.org,  gregkh@linuxfoundation.org,
  akpm@linux-foundation.org,  honggyu.kim@sk.com,  rakie.kim@sk.com,
  dan.j.williams@intel.com,  Jonathan.Cameron@huawei.com,
  dave.jiang@intel.com,  horen.chuang@linux.dev,  hannes@cmpxchg.org,
  linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
In-Reply-To: <Z4_782yoMKqIOfW5@gourry-fedora-PF4VCD3F> (Gregory Price's
	message of "Tue, 21 Jan 2025 14:56:35 -0500")
References: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
	<87ikq8h0w4.fsf@DESKTOP-5N7EMDA>
	<Z4_782yoMKqIOfW5@gourry-fedora-PF4VCD3F>
Date: Wed, 22 Jan 2025 09:37:20 +0800
Message-ID: <8734hbiq7j.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Tue, Jan 21, 2025 at 07:17:15PM +0800, Huang, Ying wrote:
> ... snip ...
>> 
>> Unless it's possible we will add more modes in the future, this is kind
>> of overkill for me.  How about something simpler as below?
>> 
>> $ cat auto
>> true
>> $ echo 0 > auto
>> $ cat auto
>> false
>
> We have discussed having a dynamic-mode where the weights might adjust
> on the fly based on system-state, but i think this ends up being
> controlled under mempolicy/dynamic_interleave or something.
>
> So this seems reasonable.
>
>> >  static u8 __rcu *iw_table;
>> >  static DEFINE_MUTEX(iw_table_lock);
>> > +static const int weightiness = 32;
>> > +static bool weighted_interleave_auto = true;
>> 
>> I still prefer to use 2 iw_table, one is for default, the other is for
>> manual.  The default one will be used if the manual one is NULL.  Both
>> are protected by RCU.  The default one can be updated upon hotplug
>> blindly.  This makes the whole model easier to be understood IMHO.
>> 
>> What do you think about that.
>> 
>
> only question is, lets say you have
>
> `cat auto node0 node1` -> `true 5 1`
> and you do
> echo 0 > auto
>
> what should a subsequent `cat auto node0 node1` output?
>
> `false 5 1`
> or
> `false 1 1`

IMO, it should be

`false 5 1`

That is, we copy auto-generated weights to manual weights atomically and
use it.

> Then lets say we do
> echo 7 > node0

Now, `cat auto node0 node1` outputs,

`false 7 1`

That is, we delete manual weights and use the auto-generated ones.

> what should
> echo true > auto
> result in?
>
> `true 5 1`
> or
> `true 7 1`

It should be

`true 5 1`

> The current code makes sure that when you switch modes from auto
> to manual, it inherits the current state - instead of there being
> some hidden state that suddenly takes precedence.

I think that we can do that with two weight arrays.

> So I prefer to just have one IW array and no hidden state.

Then, when we switch from manual to auto mode, where to find
auto-generated weights?  Re-calculate them?

---
Best Regards,
Huang, Ying

