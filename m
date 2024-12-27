Return-Path: <linux-acpi+bounces-10311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6372B9FCF89
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Dec 2024 02:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6E91883692
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Dec 2024 01:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56211C6A3;
	Fri, 27 Dec 2024 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lWnXLV3I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4A19A;
	Fri, 27 Dec 2024 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735264790; cv=none; b=PfLVfV0fx++3VUXfb+odQ+3xMHVBcT8KQkUlJG1jf2kF00x0eeBiBqgJ9qJhLiPddjRuB6SatDmF6ejvLCn7LCDaIJJifEEer3nNM+RVlDzC3NXIZaSJXcB0ikc18fferTCG5Bpl9GcgwjR16FJaJUApwIjwsd0K7z1uUSvPyEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735264790; c=relaxed/simple;
	bh=I1bjv/0RBQVqsXPywcPZLVPyKj/mD0eLmgcVxy69MYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rl2b2CnKFsrNXg4IeGzIGiUfpg9aG7jjc8zRIw9Mn6h90zrZvsQAjHWBZVkXbUskQfr+UPD0TFFAKwlP9S8PaLG395mijrrjleykwtrOYoE3kahvPsf2HXj0JI/PthqJTapopKHSgwoFguHDJKoA5L9GbTBB9lIrOts1sUIQKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lWnXLV3I; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735264779; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=yg/jG1rpsLEYnYPzqiuf4YxmQ5oFpoPbwk3hphHZGDI=;
	b=lWnXLV3I4wDvFPdLzou2VDAHHTofpZTFSQOoEu1qGwdevMc9TVWkDU5Sc03BdjQKBG5tenfx2ziOZfSChBJJke2kwwli/qtVDEGH31wNStbOg9wrJ3eehj98rMpaUTwSjqxS9ALXscwuNQlBmNBqP/DyGmr0P+hcwMjWTR6gl14=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WMJYFwA_1735264770 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Dec 2024 09:59:37 +0800
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
In-Reply-To: <Z22cwZycFV47wOfX@gourry-fedora-PF4VCD3F> (Gregory Price's
	message of "Thu, 26 Dec 2024 11:13:21 -0700")
References: <20241225093042.7710-1-joshua.hahnjy@gmail.com>
	<874j2rp6or.fsf@DESKTOP-5N7EMDA>
	<Z22cwZycFV47wOfX@gourry-fedora-PF4VCD3F>
Date: Fri, 27 Dec 2024 09:59:30 +0800
Message-ID: <87cyhdhon1.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Thu, Dec 26, 2024 at 09:35:32AM +0800, Huang, Ying wrote:
>> > Having two files for each node (nodeN, defaultN) seems a bit too
>> > cluttered for the user perspective. Making the nodeN interfaces serve
>> > multiple purposes (i.e. echo -1 into the nodes will output the default
>> > value for that node) also seems a bit too complicated as well, in my
>> > opinion. Maybe having a file 'weight_tables' that contains a table of
>> > default/user/effective weights (as have been used in these conversations)
>> > might be useful for the user? (Or maybe just the defaults)
>> >
>> > Then a workflow for the user may be as such:
>> >
>> > $ cat /sys/kernel/mm/mempolicy/weighted_interleave/weight_tables
>> > default vales: [4,7,2]
>> >   user values: [-,-,-]
>> >     effective: [4,7,2]
>> 
>> AFAIK, this breaks the sysfs attribute format rule as follows.
>> 
>> https://docs.kernel.org/filesystems/sysfs.html#attributes
>> 
>> It's hard to use array sysfs attribute here too.  Because the node ID
>> may be non-consecutive.  This makes it hard to read.
>>
>
> Would generally agree. I think essentially a
>    use_defaults => (0 | 1)
> interface is probably the best we can do.
>
> Setting any node changes use_defaults from 1 => 0
> echoing 1 into use_default clears user_values
>
> This still allows 0 to be a manual "reset specific node to default"
> mechanism for a specific node, and gives us a clean override.

The difficulty is that users don't know the default value when they
reset a node's weight.  We don't have an interface to show them.  So, I
suggest to disable the functionality: "reset specific node to default".
They can still use "echo 1 > use_defaults" to reset all nodes to
default.

> The only question is a matter of hotplug behavior
>
> nodes_online: 0,1
>   default_values: [5,3]
>   user_values   : [-,-]
>
> event: node1 is taken offline
>   default_values: [5,3] <-- nothing happens
>
> event: node1 comes back online with different bandwidth attribute
>   default_values: [6,5] <-- reweight as occured silently
>
> event: user sets a custom value (node1 <= 2)
>   default_values: [6,5]
>   user_values:    [6,2] <= note, *no reduction*
>
> event: node1 is taken offline
>   default_values: [6,5]
>   user_values:    [6,2] <= value still present but not used
>
> event: node1 comes back online with different bandwidth attribute
>   default_values: [5,3] <-- default reweight has occurred silently
>   user_values   : [6,2] <-- user responsible for triggering re-weight
>
> The user has the option of
>
> echo 1 > /sys/.../weghted_interleave/user_defaults
> result
> 	default_values: [5,3]
> 	user_values   : [-,-]
> or
> echo 0 > /sys/.../weighted_interleave/node1
> result
> 	default_values: [5,3]
> 	user_values   : [6,3] <= only node1 is updated, no re-weight
>
> Basically, if the user ever sets any value, we never automatically pull
> new values in, and the admin is responsible for triggering a re-weight
> (use_default) or manually reweighting *all* nodes - because changing
> values implies a change in the bandwidth distribution anyway.
>
> I think this makes the most sense.

---
Best Regards,
Huang, Ying

