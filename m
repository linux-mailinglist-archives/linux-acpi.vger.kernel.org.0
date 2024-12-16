Return-Path: <linux-acpi+bounces-10141-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11799F2B31
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 08:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A701886066
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EF41FF60C;
	Mon, 16 Dec 2024 07:54:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail3.skhynix.com (exvmail3.hynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B2B433C8;
	Mon, 16 Dec 2024 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335643; cv=none; b=D1IFvT5+VZrzWvUHCPXjK9mzbxFJgk4o40ywrCmk/yo3q7b+Xr3DrPkYEHblVfCMUTYJo1BBPU/RIyy7jeBt8sPMA5furdyWhbrwKNO9TqU75XChg3EkGns0nOtD/K0dIWTSYDp7wu47LKXoc7CWiqJDCO2sDJj204ZHz02Clxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335643; c=relaxed/simple;
	bh=4YUi9IIN+FDfpxF4emlc22UqQohODEXavHnNVnPLZE8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XsEI2D/qelcIV6RQIGCEF/SsG2+0dAXEBOYCXHzp2mUYCe1uf+StLETdgRccncRtV+QvU0qOA5+hqxMrysATXfOouJ+1bB1eNLoZai1z/IzIfccYdyg0pYZO0m16ADaiKrm+UVk+82qD6GP5TLoY3RlaI2W+AnmbvB7Sxd08Wj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-7a9ff700000194b3-e2-675fdc8c7271
Message-ID: <7ed89f33-6ba0-44c7-b4ea-0c72029fa33b@sk.com>
Date: Mon, 16 Dec 2024 16:53:47 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, 42.hyeyoo@gmail.com,
 "gourry@gourry.net" <gourry@gourry.net>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 =?UTF-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKSBTeXN0ZW0gU1c=?=
 <honggyu.kim@sk.com>,
 "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
 =?UTF-8?B?6rmA65296riwKEtJTSBSQUtJRSkgU3lzdGVtIFNX?= <rakie.kim@sk.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "horen.chuang@linux.dev" <horen.chuang@linux.dev>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave
 auto-tuning
To: Joshua Hahn <joshua.hahnjy@gmail.com>
References: <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>
 <20241213195754.2676135-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
From: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
In-Reply-To: <20241213195754.2676135-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsXC9ZZnkW7Pnfh0gw8LVCwm9hhYzFm/hs1i
	+tQLjBYnbjayWfy8e5zdonnxejaL1Zt8LW73n2O1WLXwGpvF8a3z2C32XQSq3fnwLZvF8n39
	jBaXd81hs7i35j+rxdwvU5ktVq/JcBD0OPzmPbPHzll32T262y6ze7QcecvqsXjPSyaPTas6
	2Tw2fZrE7nFixm8Wj50PLT0WNkxl9tg/dw27x7mLFR6fN8kF8EZx2aSk5mSWpRbp2yVwZczq
	7mIpeCle0fh8BmsD41ThLkZODgkBE4mV+6ayw9gzn21mBrF5BSwlPq36wgRiswioSkzsu8cK
	EReUODnzCQuILSogL3H/1gywXmaB1+wS3R+dQWxhgRiJ7XeWM4LYIgKaEidaJ4HNFBLIkzi2
	djkzRL24xK0n84Hmc3CwCWhJ7OhMBQlzCthLfL92nhWixEyia2sXI4QtL7H97RygVi6gM0+x
	SyzoP8wCcbOkxMEVN1gmMArOQnLeLCQrZiGZNQvJrAWMLKsYRTLzynITM3OM9YqzMyrzMiv0
	kvNzNzECY3dZ7Z/IHYzfLgQfYhTgYFTi4b1wKS5diDWxrLgy9xCjBAezkghvjUlsuhBvSmJl
	VWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbGOjXrw2uX3MqV5WP+
	nsYa07ieeePlBc+9vKquRU1O7Snem7qIOUSg99BZNrl8ljnf5WqcE596f41PUZUwvvVf1+5h
	uCf36Yprc8P3BwXua3XL1GL8ed6zu8LXZ6HF7d+Bcy4/mTRHZfGUzI8Cr5mOXHQ0eHYpwOE9
	k7Sx6Qv9ssSLwTxr2w8osRRnJBpqMRcVJwIAlZmsEdkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsXCNUOnRLfnTny6wfwlrBYTewws5qxfw2Yx
	feoFRosTNxvZLH7ePc5u0bx4PZvF6k2+Fp+fvWa2uN1/jtVi1cJrbBbHt85jt9h3Eajh8NyT
	rBY7H75ls1i+r5/R4vKuOWwW99b8Z7WY+2Uqs8Wha89ZLVavyXAQ8Tj85j2zx85Zd9k9utsu
	s3u0HHnL6rF4z0smj02rOtk8Nn2axO5xYsZvFo+dDy09FjZMZfbYP3cNu8e5ixUe3257eCx+
	8YHJ4/MmuQD+KC6blNSczLLUIn27BK6MWd1dLAUvxSsan89gbWCcKtzFyMkhIWAiMfPZZmYQ
	m1fAUuLTqi9MIDaLgKrExL57rBBxQYmTM5+wgNiiAvIS92/NYAexmQVes0t0f3QGsYUFYiS2
	31nOCGKLCGhKnGidBDZTSCBP4tja5cwQ9eISt57MB5rPwcEmoCWxozMVJMwpYC/x/dp5VogS
	M4murV2MELa8xPa3c5gnMPLNQnLFLCSTZiFpmYWkZQEjyypGkcy8stzEzBwzveLsjMq8zAq9
	5PzcTYzACF1W+2fSDsZvl90PMQpwMCrx8F64FJcuxJpYVlyZe4hRgoNZSYS3xiQ2XYg3JbGy
	KrUoP76oNCe1+BCjNAeLkjivV3hqgpBAemJJanZqakFqEUyWiYNTqoHR8P3iud1rdubmmW1I
	XWe7JJ6tmvVhTuzWH4eOTN6UNf+3pn3y6wgv9QVcdqbTjC+xrGK4eXax90f2G4asXtza2fsY
	p0kY/zE/Vr5ht/eOB5lOOjxviidfLt8+LWv3g8bL2980VC1fKpKyP8MhVu9Aw/ZDCy+n3Pfl
	UdjVFie1puX37kf/mNM7lViKMxINtZiLihMBvS4OA8wCAAA=
X-CFilter-Loop: Reflected



On 2024-12-14 4:57 AM, Joshua Hahn wrote:
> On Fri, 13 Dec 2024 15:19:20 +0900 Hyeonggon Yoo <hyeonggon.yoo@sk.com> wrote:
> 
>> On 2024-12-11 06:54 AM, Joshua Hahn wrote:
>>> This patch introduces an auto-configuration for the interleave weights
>>> that aims to balance the two goals of setting node weights to be
>>> proportional to their bandwidths and keeping the weight values low.
>>> This balance is controlled by a value max_node_weight, which defines the
>>> maximum weight a single node can take.
>>
>> Hi Joshua,
>>
>> I am wondering how this is going to work for host memory + CXL memory
>> interleaving. I guess by "the ACPI table" you mean the ACPI HMAT or CXL
>> CDAT, both of which does not provide the bandwidth of host memory.
>> If this feature does not consider the bandwidth of host memory, manual
>> configuration will be inevitable anyway.
> 
> Hi Hyeonggon,
> 
> Thank you for reviewing my patch!

No problem :)

> As Gregory showed in his reply, I think it would be possible to get host bandwidth information
> using the ACPI HMAT.

You're right. I was wrong. I checked on our server, and its bandwidth 
information was valid for both local memory and CXL memory. Sorry for
the noise.

> [-----8<-----]
> 
>>> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/max_node_weight
>>> +Date:		December 2024
>>> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>>> +Description:	Weight limiting / scaling interface
>>> +
>>> +		The maximum interleave weight for a memory node. When it is
>>> +		updated, any previous changes to interleave weights (i.e. via
>>> +		the nodeN sysfs interfaces) are ignored, and new weights are
>>> +		calculated using ACPI-reported bandwidths and scaled.
>>> +
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
> Does this behavior make sense?

Ok. then current implementation overwrites the node weights
previously set by the user.

I think it makes sense to re-scale all nodes and overwrite manually set 
node weights, because it's what the knob is meant to do, and the user 
still can override the weight by setting node weight after updating
max_node_weight.

By the way, could you please explain which part of this patch implements
this rule? IIUC it does not invalidate iw_table after updating these
default values, which makes get_il_weight() to use manully set node 
weights even after updating max_node_weight. (Or probably I just
misunderstood the code?)

> Have a great day!

Have a great day too :)

--
Hyeonggon

