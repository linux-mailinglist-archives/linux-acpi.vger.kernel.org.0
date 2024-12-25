Return-Path: <linux-acpi+bounces-10302-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FCC9FC2F0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2024 01:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEEE1883139
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2024 00:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21578825;
	Wed, 25 Dec 2024 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oDqhjOuT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3004A35;
	Wed, 25 Dec 2024 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735086326; cv=none; b=AB9uIH0XpgXDefFUd8+vIKK6t56STO61ytpcj3tJ65Bstl7rEfQoSM5fyTw/AeWdfb4Gq8/DcJ4tyz+Z8pFGVAZSaJL88u4a/tUtbJWMFSkFM4DYYmIzPnGQsGhMblw/vxloX/vG7bq7QFHl+f0mL6l16C+nLHjMFexVbKrPFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735086326; c=relaxed/simple;
	bh=g+yOP68g3HRmvcC1IvoLWu8GIL56Rq2QMid60cwJ6Q0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IE5v5pzL2iwtqXJSGp+7MYxQtMTFpCIRJgcGdJ0Q56CC5Og3SEIOZ0nx9abkm5oLvLPbl6lgLTaeli5sd7Bq3/KMCFYukhFpPyKJiF+FRF4CQHye5AGQ4YCXiMUJx2R+FHPovsWh2+kA7bGIShBPdgdwZMMETQWOWtm2ReuXxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oDqhjOuT; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735086316; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=CPspHS8rV5GvkrVEm82MMZPR989gHfj32X9+atYu838=;
	b=oDqhjOuTatyEZobV5yk3YKZNrq7GRUKhL4lnC0VBoltUqNx1MI+gle3pS8+SUXDXVk7H/iHIILl12d4v9587cjYrbMT1iiEVHhUi/3+a/8fCdqw6oEAtkT7Fx4wigLVaFwGHD6h3doqrcJp7qeNeni6Iu4NOFURT+AUopp3Aiwc=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WMDCBXo_1735086313 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Dec 2024 08:25:15 +0800
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
In-Reply-To: <Z2hEXttgNMjAo8-q@gourry-fedora-PF4VCD3F> (Gregory Price's
	message of "Sun, 22 Dec 2024 11:54:54 -0500")
References: <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>
	<20241213195754.2676135-1-joshua.hahnjy@gmail.com>
	<87jzbtr315.fsf@DESKTOP-5N7EMDA>
	<Z2bXgMw5WPCqwGSk@gourry-fedora-PF4VCD3F>
	<87ldw8i0id.fsf@DESKTOP-5N7EMDA>
	<Z2hEXttgNMjAo8-q@gourry-fedora-PF4VCD3F>
Date: Wed, 25 Dec 2024 08:25:13 +0800
Message-ID: <87ed1wa9sm.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Sun, Dec 22, 2024 at 04:29:30PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry@gourry.net> writes:
>> 
>> > On Sat, Dec 21, 2024 at 01:57:58PM +0800, Huang, Ying wrote:
>> 
>> Another choice is that if the user set a value, he/she set all values
>> effectively.  Even if he/she doesn't set the other values, he/she thinks
>> that the other values are good, and more importantly, the ratio is good.
>
> This is probably the actual way to go.  
>
>> If so,
>> 
>> default_values [5,2,-] <- 1 node not set, expected to be hotplugged
>> user_values    [4,2,0] <- user has only set one value, not populated nodes have value 0
>> effective      [4,2,0]
>>
>> hotplug event
>> default_values [2,1,1] - reweight has occurred
>> user_values    [4,2,0]
>> effective      [4,2,0]
>> 
>> In this way, 0 becomes a valid value too.
>> 
>> What do you think about this?
>> 
>
> We decided when implementing weights that 0 was a special value that
> reverts to the system default:
>
>   Writing an empty string or `0` will reset the weight to the
>   system default. The system default may be set by the kernel
>   or drivers at boot or during hotplug events.
>
> I'm ok pulling the default weights in collectively once the first one is
> written, but 0 is an invalid value which causes issues.
>
> We went through that when we initially implemented the feature w/ task-local
> weights and why the help function overrides it to 1 if it's ever seen.
>
> We'll revert back to our initial implementation w/ default_iw_table and
> iw_table - where iw_table contains user-defined weights.  Writing a 0 to
> iw_table[N] will allow get_il_weight() to retrieve default_iw_table[N]
> as the docs imply it should.

So, the suggested behavior becomes the following?

default_values [5,2,-] <- 1 node not set, expected to be hotplugged
user_values    [4,2,1] <- user has only set one value, not populated nodes have value 1
effective      [4,2,1]

hotplug event
default_values [2,1,1] - reweight has occurred
user_values    [4,2,1]
effective      [4,2,1]

Even if so, we still have another issue.  The effective values may be a
combination of default_values and user_values and it's hard for users to
identify which one is from default_values and subject to change.  For
example,

user reset weight of node 0 to default: echo 0 > node0
default_values [2,1,1]
user_values    [0,2,1]
effective      [2,2,1]

change the default again
default_values [3,1,1] - reweight again
user_values    [0,2,1]
effective      [3,2,1]

This is still quite confusing.  Another possible solution is to copy the
default value instead,

user reset weight of node 0 to default: echo 0 > node0
default_values [2,1,1]
user_values    [2,2,1] - copy default value when echo 0
effective      [2,2,1]

change the default again
default_values [3,1,1] - reweight again
user_values    [2,2,1]
effective      [2,2,1]

The remaining issue is that we cannot revert to default atomically.
That is, user_values may becomea  combination of old and new
default_values if users echo 0 to each node one by one when kernel is
changing default_values.  To resolve this, we may add another interface
to do that, for example, "use_default".

echo 1 > use_default

will use default_values for all nodes.  We can check whether we are
using default via

cat use_default

Anyway, I think that we need a thorough thought about the user space
interface.  And add good document, at least in change log.  It's really
hard to make user space interface right.

I'm open to better user space interface design.

---
Best Regards,
Huang, Ying

