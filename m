Return-Path: <linux-acpi+bounces-10308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E229FC774
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Dec 2024 02:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B5B7A12C3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Dec 2024 01:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71842AA5;
	Thu, 26 Dec 2024 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="axF/D7rx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD62B9CD;
	Thu, 26 Dec 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176956; cv=none; b=GcBXGUUyp8Z1Te7t/Neujmna00SJjnBO25EbblG85jqPyITTeQB2F/5V8jrXSYqskMvyxkpHAycNs1DNRCsKSPMU3SAOSU2jrrHL42Loya4yYzZif87lrkWn4wZIYqwYRIprX+4v+fEkE/Corhzt/CJ7oMfV6rzDPl+r5p+VlMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176956; c=relaxed/simple;
	bh=cxN1/UykUiErM6n9pqaTT43SgrrU0uzHv3x3MhrjuOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1PYpWqCNOPe4bbIWo9FUwOekRqhaps5UkQa5IGuXDg6E0so6cOVwVx+yOxh+SMNUvBm3Tz/qs8r0BpjVFrxEK5o/liJiG2jKJOsS9Bl5LpCwCplgVP6xWhn1+QB9TeWz4l88X0RHjJELxHnsx3zh4hBkiVEQtbAgEAvfVbxcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=axF/D7rx; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735176945; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=LgMyQTcokgOo73uKJV1KP+xRroEyuPt5ZYl/VKgG9TA=;
	b=axF/D7rxGHcavi9GyHiGlssRXTIcK4d9pj1KqaOpg/bJkcpMw1qwdFjVCwrPW7LF9CVcmOMrJ2T0q/L8FIC521thRkHBC8z9LUNkawfMMUQ1kkgu19ERXO71GI8M2+RG5tYeIsuljsL1RJei5RMmddOcZsFxDqKjHqqG/0r5H+g=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WMGJQaw_1735176936 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 09:35:44 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Gregory Price <gourry@gourry.net>,  hyeonggon.yoo@sk.com,
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
In-Reply-To: <20241225093042.7710-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Wed, 25 Dec 2024 18:30:42 +0900")
References: <20241225093042.7710-1-joshua.hahnjy@gmail.com>
Date: Thu, 26 Dec 2024 09:35:32 +0800
Message-ID: <874j2rp6or.fsf@DESKTOP-5N7EMDA>
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

> Hi Gregory and Huang,
>
> Sorry for the silence on my end for the past few days. I decided to take
> some time off of the computer, but I should be more reponsive now!
>
> On Wed, 25 Dec 2024 08:25:13 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>
>> Gregory Price <gourry@gourry.net> writes:
>> 
>> > On Sun, Dec 22, 2024 at 04:29:30PM +0800, Huang, Ying wrote:
>> >> Gregory Price <gourry@gourry.net> writes:
>> >> 
>> >> > On Sat, Dec 21, 2024 at 01:57:58PM +0800, Huang, Ying wrote:
>
> [.....8<.....]
>
>> > We decided when implementing weights that 0 was a special value that
>> > reverts to the system default:
>> >
>> >   Writing an empty string or `0` will reset the weight to the
>> >   system default. The system default may be set by the kernel
>> >   or drivers at boot or during hotplug events.
>> >
>> > I'm ok pulling the default weights in collectively once the first one is
>> > written, but 0 is an invalid value which causes issues.
>> >
>> > We went through that when we initially implemented the feature w/ task-local
>> > weights and why the help function overrides it to 1 if it's ever seen.
>> >
>> > We'll revert back to our initial implementation w/ default_iw_table and
>> > iw_table - where iw_table contains user-defined weights.  Writing a 0 to
>> > iw_table[N] will allow get_il_weight() to retrieve default_iw_table[N]
>> > as the docs imply it should.
>> 
>> So, the suggested behavior becomes the following?
>> 
>> default_values [5,2,-] <- 1 node not set, expected to be hotplugged
>> user_values    [4,2,1] <- user has only set one value, not populated nodes have value 1
>> effective      [4,2,1]
>> 
>> hotplug event
>> default_values [2,1,1] - reweight has occurred
>> user_values    [4,2,1]
>> effective      [4,2,1]
>
> Yes, I think this was the intended effect when we were discussing what
> interface made the most sense.
>
>> Even if so, we still have another issue.  The effective values may be a
>> combination of default_values and user_values and it's hard for users to
>> identify which one is from default_values and subject to change.  For
>> example,
>> 
>> user reset weight of node 0 to default: echo 0 > node0
>> default_values [2,1,1]
>> user_values    [0,2,1]
>> effective      [2,2,1]
>> 
>> change the default again
>> default_values [3,1,1] - reweight again
>> user_values    [0,2,1]
>> effective      [3,2,1]
>
> Agreed. Actually, this confusion was partly what motivated our new
> re-work of the patch in v2, which got rid of the default and user
> layers, and made all internal values transparent to the user as well.
> That way, there would be no confusion as to the true source of the
> value, and the user could be aware that re-weighting would impact
> all values, regardless of whehter they were default values or not.
>
> If we are moving away from allowing users to dynamically change the
> weightiness (max_node_weight) parameter however, then I think that there
> may be more merit to using the two-level default & user values system to
> allow for more flexibility.
>  
>> This is still quite confusing.  Another possible solution is to copy the
>> default value instead,
>> 
>> user reset weight of node 0 to default: echo 0 > node0
>> default_values [2,1,1]
>> user_values    [2,2,1] - copy default value when echo 0
>> effective      [2,2,1]
>> 
>> change the default again
>> default_values [3,1,1] - reweight again
>> user_values    [2,2,1]
>> effective      [2,2,1]
>
> This makes a lot sense to me, I think it lets us keep both the
> transparency of the new one-layered system and all the benefits that
> come with having default values that can adapt to hotplug events. One
> thing we should consider is that the user should probably be able to
> check what the default value is for a given node before deciding to
> copy that value over to the weight table.
>
> Having two files for each node (nodeN, defaultN) seems a bit too
> cluttered for the user perspective. Making the nodeN interfaces serve
> multiple purposes (i.e. echo -1 into the nodes will output the default
> value for that node) also seems a bit too complicated as well, in my
> opinion. Maybe having a file 'weight_tables' that contains a table of
> default/user/effective weights (as have been used in these conversations)
> might be useful for the user? (Or maybe just the defaults)
>
> Then a workflow for the user may be as such:
>
> $ cat /sys/kernel/mm/mempolicy/weighted_interleave/weight_tables
> default vales: [4,7,2]
>   user values: [-,-,-]
>     effective: [4,7,2]

AFAIK, this breaks the sysfs attribute format rule as follows.

https://docs.kernel.org/filesystems/sysfs.html#attributes

It's hard to use array sysfs attribute here too.  Because the node ID
may be non-consecutive.  This makes it hard to read.

> $ echo 4 > /sys/kernel/mm/mempolicy/weighted_interleave/node2
> 4
> ...
>
>> The remaining issue is that we cannot revert to default atomically.
>> That is, user_values may becomea  combination of old and new
>> default_values if users echo 0 to each node one by one when kernel is
>> changing default_values.  To resolve this, we may add another interface
>> to do that, for example, "use_default".
>> 
>> echo 1 > use_default
>> 
>> will use default_values for all nodes.  We can check whether we are
>> using default via
>> 
>> cat use_default
>
> Like mentioned in the previous comments, I think that the "setting one
> value to set all the others" is a good method, especially since the
> more I think about it (in my limited experience), I think there is rarely
> a scenario where a user wants to use a hybrid of manually-set and
> default values and is switching back and forth between default and
> manual values.
>
>> Anyway, I think that we need a thorough thought about the user space
>> interface.  And add good document, at least in change log.  It's really
>> hard to make user space interface right.
>> 
>> I'm open to better user space interface design.
>
> I agree with this, thank you for your feedback. I think there has been
> a lot of great points raised in these conversations, and I will do my
> best to take these comments into consideration when writing better
> documentation. 
>
> Thank you for your input! I hope you have a great day and happy holidays!

Happy holidays!

---
Best Regards,
Huang, Ying

