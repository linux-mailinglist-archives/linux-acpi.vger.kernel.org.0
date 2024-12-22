Return-Path: <linux-acpi+bounces-10265-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F869FA4B4
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 09:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C011888A84
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF8216BE3A;
	Sun, 22 Dec 2024 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g6dh5Olt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21B290F;
	Sun, 22 Dec 2024 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734856185; cv=none; b=qh1s//QqPn4gqEyKARF6d1U85le3ee0sKEGKHdorALxbKImuoPFF3bvKBuaQXfjXDEowGJ7MmSVf9it3k5E/IR1vrkuo9g1F8hMd8uheC5Zsjud4VzeK7b1Lw33ITWLV+DQqvm95P0oSmw73X3YHDhw9Q/sToAJ6K+d9wCh5VsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734856185; c=relaxed/simple;
	bh=luXDESfUxvdZqW674alBjK2xfCAcwVWZR+VR5in2Rno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U4GFWjTMCC2XxqV5P2DaWORzNBPLb9J50l8AJ4mnYRW54Zqk60BS1hxhhXbEEhAehtcfvxxYDEId7WKiCLnicq3K88CP9RQ3RoP6xCOz0GQ3ml5Z4hGbLu1/Iect6zr1DdBE5Hp5IZEMyVNt5IzKrajEys9QfdKdQosknFmsoq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g6dh5Olt; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734856173; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=QHFYpz+OzLsCaVCAYPPWt+cWFpBmzJ/IKFichnBF9as=;
	b=g6dh5Olt6vbWLqNM3FjLucTp8pRx+qj8XCanqtiC7zIrLXDJcgeBhUw0+FxxnIQ1GsI/jZk8uWi90i36P+eYbp9frnS0f2WKyjBIRWqOvJGhI6ZEtdo7vMJhqBwznSWwbU2s1r/KVoEeI/haiykZrWkNTGyEquNFK3wKlPh3TDg=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WLyNENU_1734856170 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 22 Dec 2024 16:29:31 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Gregory Price <gourry@gourry.net>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,  hyeonggon.yoo@sk.com,
  kernel_team@skhynix.com,  "rafael@kernel.org" <rafael@kernel.org>,
  "lenb@kernel.org" <lenb@kernel.org>,  "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  =?utf-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKQ==?=
 System SW
 <honggyu.kim@sk.com>,  =?utf-8?B?6rmA65296riwKEtJTSBSQUtJRSk=?= System SW
 <rakie.kim@sk.com>,
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
In-Reply-To: <Z2bXgMw5WPCqwGSk@gourry-fedora-PF4VCD3F> (Gregory Price's
	message of "Sat, 21 Dec 2024 09:58:08 -0500")
References: <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>
	<20241213195754.2676135-1-joshua.hahnjy@gmail.com>
	<87jzbtr315.fsf@DESKTOP-5N7EMDA>
	<Z2bXgMw5WPCqwGSk@gourry-fedora-PF4VCD3F>
Date: Sun, 22 Dec 2024 16:29:30 +0800
Message-ID: <87ldw8i0id.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Sat, Dec 21, 2024 at 01:57:58PM +0800, Huang, Ying wrote:
>> Hi, Joshua,
>> 
>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>> 
>> > On Fri, 13 Dec 2024 15:19:20 +0900 Hyeonggon Yoo <hyeonggon.yoo@sk.com> wrote:
>> >
>> >> On 2024-12-11 06:54 AM, Joshua Hahn wrote:
>>

[snip]

>
>> >
>> > Regardless of what implementation makes sense, I can re-write the
>> > description so that there is no ambiguity when it comes to the
>> > expected behavior of the code. Thank you for pointing this out!
>> 
>> I don't think that it's a good idea to override the user supplied
>> configuration values.  User configurations always have higher priority
>> than system default configurations.  IIUC, this is the general rule of
>> Linux kernel user space interface.
>> 
>
> We discussed this and decided it was confusing no matter what we did.
>
> If new data comes in (CDAT data from a hotplug event), then the weights
> are now wrong for the new global state - regardless of whether the user
> set a weight manually or not.  This also allowed us to simplify the
> implementation a bit.
>
> But if generally we need to preserve user settings, then I think the
> best we can do to provide a sane system is ignore the user setting when
> re-weighting on a hotplug event.
>
> e.g. user has not set a value
>
> default_values [5,2,-] <- 1 node not set, expected to be hotplugged
> user_values    [-,-,-] <- user has not set values
> effective      [5,2,-]
>
> hotplug event
> default_values [2,1,1] - reweight has occurred
> user_values    [-,-,-]
> effective      [2,1,1]
>
> e.g. user has set a value
>
> default_values [5,2,-] <- 1 node not set, expected to be hotplugged
> user_values    [4,-,-] <- user has only set one value
> effective      [4,2,-]
>
> hotplug event
> default_values [2,1,1] - reweight has occurred
> user_values    [4,-,-]
> effective      [4,1,1]

Another choice is that if the user set a value, he/she set all values
effectively.  Even if he/she doesn't set the other values, he/she thinks
that the other values are good, and more importantly, the ratio is good.
If so,

default_values [5,2,-] <- 1 node not set, expected to be hotplugged
user_values    [4,2,0] <- user has only set one value, not populated nodes have value 0
effective      [4,2,0]

hotplug event
default_values [2,1,1] - reweight has occurred
user_values    [4,2,0]
effective      [4,2,0]

In this way, 0 becomes a valid value too.

What do you think about this?

> So default values get updated, but user values get left alone.
>
> If that's sane we'll fix it up.

---
Best Regards,
Huang, Ying

