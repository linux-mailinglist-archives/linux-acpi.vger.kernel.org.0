Return-Path: <linux-acpi+bounces-10797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C74A19D4F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 04:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7081882FE7
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 03:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82F07DA95;
	Thu, 23 Jan 2025 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sxw0siYC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760541F5F6;
	Thu, 23 Jan 2025 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737603197; cv=none; b=Yy/lqoqOFQS7F9FNLxHdoMGVC6XrqUzTZc8DmFN/i+mPXL8rGB+5c4jeRs3XYJmXhMjnHhpWq+Exoo6bFi3jqfFnZHKiLp9sJ0nhIslm4+7hjyoa8/XoGQFme98umoMYsHygTzPu3EABzZQkYrviVzXlMsbiUM+x4YaO9gr4aug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737603197; c=relaxed/simple;
	bh=r6SqBq7kJU7pHPYzzLWvW4EwfzJ/N2WxZvuVMLQWlqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C3oL0s8vAmH4jG8iQH1jyZOwJ9OZM6tjRfCoTQl6WqQ/ahjeXwndy3Q9NqCy2BL2cHcp4rgVQquYCGtdEM0g3fnpyGFFNxP/BPEldmaRPP+x1vvtyhG/c3y6pynw+bOYQJJuw4TK84nWaYO0Nt30sGx+2PVt6CuAfsSccAVpkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sxw0siYC; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737603190; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=2lsDPWvDtMfLfMIV7hWLp0tfTWnTTnVOPgkf/bqRyXk=;
	b=sxw0siYCDy62cS8jCh02Z+8h5FxoplY8Fuk8X5L7ZOTnUpwJVHw9dDQecL0pkP31eWypX4RJQywYqHhdLRxY2TVlsy0LIsIzx9psv9Eggl+FOdT6YdVY9SaUs0uwWv0jzmymgml21GPE64Gh01eJZ4szdjJSFz1tAyfy6XqxwKU=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WOAEWoR_1737603157 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 11:33:08 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Gregory Price <gourry@gourry.net>,  hyeonggon.yoo@sk.com,
  rafael@kernel.org,  lenb@kernel.org,  gregkh@linuxfoundation.org,
  akpm@linux-foundation.org,  honggyu.kim@sk.com,  rakie.kim@sk.com,
  dan.j.williams@intel.com,  Jonathan.Cameron@huawei.com,
  dave.jiang@intel.com,  horen.chuang@linux.dev,  hannes@cmpxchg.org,
  linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
In-Reply-To: <20250122155935.1282897-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Wed, 22 Jan 2025 07:59:34 -0800")
References: <20250122155935.1282897-1-joshua.hahnjy@gmail.com>
Date: Thu, 23 Jan 2025 11:32:37 +0800
Message-ID: <8734hakxwq.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Wed, 22 Jan 2025 09:37:20 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>
> Hi Gregory and Ying, thank you both for your insights!
>
> [...snip...]
>
>> >> I still prefer to use 2 iw_table, one is for default, the other is for
>> >> manual.  The default one will be used if the manual one is NULL.  Both
>> >> are protected by RCU.  The default one can be updated upon hotplug
>> >> blindly.  This makes the whole model easier to be understood IMHO.
>> > `cat auto node0 node1` -> `true 5 1`
>> > and you do
>> > echo 0 > auto
>
> I think that when initially developing this patch, this was the intent
> that I had as well (in the v1 of this RFC patch, there was an iw_table
> and a separate default_iw_table). However, I think that the ideas of
> having a "default" and "manual" table made less sense over time, given
> that they behaved more like a "default" and "visible" table instead.
> That is, the visible layer is directly manipulable by the user, but
> does not necessarily only contain manually-set values; rather, most of
> the time, it probably still has a lot of auto-generated weights.
>
> I think that this analysis runs the risk of being a bit too semantically
> nit-picky, but as I'll explain below, I think both the 1-layer approach
> that I implemented in this RFC and the expected 2-layer behavior that
> you outline below are essentially the same, functionally. In other
> words, I think we agree on what the expected behavior should be : -)
> We just have to agree on what presentation would make the most sense
> for the user.

This sounds good to me.

We still need to finalize the interface, 'mode' or 'auto'.  Personally,
I prefer 'auto', because it's simpler.

>> > what should a subsequent `cat auto node0 node1` output?
>> >
>> > `false 5 1`
>> > or
>> > `false 1 1`
>> 
>> IMO, it should be
>> 
>> `false 5 1`
>> 
>> That is, we copy auto-generated weights to manual weights atomically and
>> use it.
>> 
>> > Then lets say we do
>> > echo 7 > node0
>> 
>> Now, `cat auto node0 node1` outputs,
>> 
>> `false 7 1`
>> 
>> That is, we delete manual weights and use the auto-generated ones.
>> 
>> > what should
>> > echo true > auto
>> > result in?
>> >
>> > `true 5 1`
>> > or
>> > `true 7 1`
>> 
>> It should be
>> 
>> `true 5 1`
>
> I see, so I think we actually agree on what the behavior for this is.
> Then there is no real "hidden state", it's either just using the
> default weights, or turning that off and being able to edit the
> states.
>  
>> > The current code makes sure that when you switch modes from auto
>> > to manual, it inherits the current state - instead of there being
>> > some hidden state that suddenly takes precedence.
>> 
>> I think that we can do that with two weight arrays.
>> 
>> > So I prefer to just have one IW array and no hidden state.
>> 
>> Then, when we switch from manual to auto mode, where to find
>> auto-generated weights?  Re-calculate them?
>
> Even in manual mode, incoming bandwidth data is continuously stored.
> This way, when a user does decide to switch back to auto mode later,
> the system doesn't have to retrieve the bandwidth data all over again.
> As for the auto-generated weights, they are re-calculated based solely
> on the bandwidth data available. (I will note that re-calculating
> the weights are very quick, see reduce_interleave_weights)
>
> Based on your description of the expected behavior, everything you
> listed out is actually what currently happens in the one-layer system.
> Switching from auto --> manual inherits the auto-generated weights, and
> switching from manual --> auto wipes all previous user-stored data.
>
> At this point, I think that I am happy with either option. I wrote and
> re-wrote this a bunch of times, and came to the conclusion that now
> that we agree on the behavior of the interface, I have no strong
> opinion on whether we have a "hidden" default layer or a phantom
> default layer that is just generated every time a user needs it : -)
>
> Please let me know if I missed anything as well! Thank you all for
> your continued feedback and interest! Have a great day,

I see.  You cache the nodes bandwidth instead of default weights.  That
works.  I am fine with either way too.

---
Best Regards,
Huang, Ying

