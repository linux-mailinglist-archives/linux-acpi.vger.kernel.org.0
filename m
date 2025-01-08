Return-Path: <linux-acpi+bounces-10426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F385A04EC4
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2025 02:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFCB1888093
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2025 01:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B503BBF0;
	Wed,  8 Jan 2025 01:19:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail3.skhynix.com (exvmail3.hynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55478F34;
	Wed,  8 Jan 2025 01:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299176; cv=none; b=FFTX2SkKlwDjkIumGB1ZFG7vNFA388YJ61bvPXrGH7MHuMuqfHncH6wfbzXyeTOR4yBmw1ucYJCSGCllS2s+An0AhsgPMLX1STmpwBmpe86LvPycsWqPXvuadn2XO+nzPfBmjvjvYsIln0lOx6rp0Eo1Z6dHgqMI1LekBYY3KJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299176; c=relaxed/simple;
	bh=dvrqP5BQ+dV+xcXVe2bnqQg2JUt0uaKvmhW72G/gHAE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZpiQmh0g8985rsXBu35+CYn/A+Vj4YiUEpSmZMCpVA9gSWJJox1m323RVQtX+dUnM+5v2ajp3QJirAjd5ByU8VtdBHHHMDmdiMIb3P6LXDPaJwQ/+Y5iwwC6kCG69mF0FwXBJSj+06s817RuZlXSEiPhuuTQ54NPeFSzz9v9m/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-7a9ff700000194b3-30-677dd2985662
Message-ID: <769f98b3-f5e5-448c-966e-4dd5468e5041@sk.com>
Date: Wed, 8 Jan 2025 10:19:19 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, 42.hyeyoo@gmail.com,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 =?UTF-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKSBTeXN0ZW0gU1c=?=
 <honggyu.kim@sk.com>, =?UTF-8?B?6rmA65296riwKEtJTSBSQUtJRSkgU3lzdGVtIFNX?=
 <rakie.kim@sk.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "horen.chuang@linux.dev" <horen.chuang@linux.dev>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] Re: [External Mail] [RFC PATCH] mm/mempolicy:
 Weighted interleave auto-tuning
To: "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20241225093042.7710-1-joshua.hahnjy@gmail.com>
 <874j2rp6or.fsf@DESKTOP-5N7EMDA> <Z22cwZycFV47wOfX@gourry-fedora-PF4VCD3F>
 <87cyhdhon1.fsf@DESKTOP-5N7EMDA> <Z27JXDwEmplZCDEX@gourry-fedora-PF4VCD3F>
 <874j2lll91.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
From: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
In-Reply-To: <874j2lll91.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsXC9ZZnoe6MS7XpBoe+8VhM7DGwmLN+DZvF
	9KkXGC1O3Gxks/h59zi7RfPi9WwWqzf5WtzuP8dqsWrhNTaL41vnsVvsuwhUu/PhWzaL5fv6
	GS0u75rDZnFvzX9Wi7lfpjJbrF6T4SDocfjNe2aPnbPusnt0t11m92g58pbVY/Gel0wem1Z1
	snls+jSJ3ePEjN8sHjsfWnosbJjK7LF/7hp2j3MXKzw+b5IL4I3isklJzcksSy3St0vgyjjY
	0MZYsEyp4vKBH2wNjLckuxg5OSQETCTWn/7LCmPvvn0ZzOYVsJRY/auXDcRmEVCRWLftAgtE
	XFDi5MwnYLaogLzE/Vsz2LsYuTiYBf6ySfQdOAvWLCyQI9F+/B5YkYhAjcTqxQtZQIqEBH4w
	SjQs6QYrYhYQl7j1ZD5TFyMHB5uAlsSOzlSQMKeArsT7z1cYIUrMJLq2dkHZ8hLb385hBpkj
	IXCOXeLBwzksEFdLShxccYNlAqPgLCQHzkKyYhaSWbOQzFrAyLKKUSQzryw3MTPHWK84O6My
	L7NCLzk/dxMjMH6X1f6J3MH47ULwIUYBDkYlHl4Pudp0IdbEsuLK3EOMEhzMSiK8lrJAId6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYzVtnYqd7Z3lqW/
	T61Y/MP0HHtf0cEGjo0mr9nTZqkeai7SLj/33a1m8U4Ty3/2oRGP2jdyfsravMdRNje7ZL3d
	Bwl2pW/C2ULbn1e2iU4z4lS2kOd09Bf0+3Gg8FfYyQerFWdamU1Rj9JwmJHH8le2/ZZcUeSx
	ngMPnp17XiG+SuxJvzjXQyWW4oxEQy3mouJEAHIZBd3bAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsXCNUOnRHf6pdp0gydvrCwm9hhYzFm/hs1i
	+tQLjBYnbjayWfy8e5zdonnxejaL1Zt8LT4/e81scbv/HKvFqoXX2CyOb53HbrHvIlDD4bkn
	WS12PnzLZrF8Xz+jxeVdc9gs7q35z2ox98tUZotD156zWqxek+Eg4nH4zXtmj52z7rJ7dLdd
	ZvdoOfKW1WPxnpdMHptWdbJ5bPo0id3jxIzfLB47H1p6LGyYyuyxf+4ado9zFys8vt328Fj8
	4gOTx+dNcgH8UVw2Kak5mWWpRfp2CVwZBxvaGAuWKVVcPvCDrYHxlmQXIyeHhICJxO7bl1lB
	bF4BS4nVv3rZQGwWARWJddsusEDEBSVOznwCZosKyEvcvzWDvYuRi4NZ4C+bRN+Bs2DNwgI5
	Eu3H74EViQjUSKxevJAFpEhI4AejRMOSbrAiZgFxiVtP5jN1MXJwsAloSezoTAUJcwroSrz/
	fIURosRMomtrF5QtL7H97RzmCYx8s5DcMQvJpFlIWmYhaVnAyLKKUSQzryw3MTPHTK84O6My
	L7NCLzk/dxMjMEqX1f6ZtIPx22X3Q4wCHIxKPLwecrXpQqyJZcWVuYcYJTiYlUR4LWWBQrwp
	iZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYzJHx4eFAjYrXkw
	Je3Fit1/NW+wblK+eGb9IwXvcOvq/80HF8/zvlaz6W6gTbtVSc3frZvW++3tt3MQX/dNbbu/
	5kYLC+NMHQbvtj1JpnVyNpwx5j3G0r2vcvicZm8zF6k9detQZOudvVr5m9UUljXt21a2IcNY
	d/lUuRCbo7+W7SvL1nq1dLsSS3FGoqEWc1FxIgCUdkf1zgIAAA==
X-CFilter-Loop: Reflected



On 2024-12-30 3:48 AM, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
>> On Fri, Dec 27, 2024 at 09:59:30AM +0800, Huang, Ying wrote:
>>> Gregory Price <gourry@gourry.net> writes:
>>>> This still allows 0 to be a manual "reset specific node to default"
>>>> mechanism for a specific node, and gives us a clean override.
>>>
>>> The difficulty is that users don't know the default value when they
>>> reset a node's weight.  We don't have an interface to show them.  So, I
>>> suggest to disable the functionality: "reset specific node to default".
>>> They can still use "echo 1 > use_defaults" to reset all nodes to
>>> default.
>>>
>>
>> Good point, and agree.  So lets just ditch 0.  Since that "feature"
>> wasn't even functional in the current code (it just reset it to 1 at
>> this point), it's probably safe to just ditch it.  Worst case scenario
>> if someone takes issues, we can just have it revert the weight to 1.
> 
> Before implementing the new version, it's better to summarize the user
> space interface design first.  So, we can check whether we have some
> flaws.

Hi, hope you all had a nice year-end holiday :)

Let me summarize the points we've discussed:

- A new knob 'weightiness' is unnecessary until it's proven useful.
   Just using an internal default weightiness value will be enough.

- It will be counter-intuitive to update the value previously set by
   user, even if the value will no longer be valid (e.g. due to CXL
   memory hot-plug). User should update the weights accordingly in that
   case, instead of the kernel updating automatically overwriting them.

- Ditch the way of using 0 as 'system default' value because the user
   won't know what will be the default when setting it anyway. 0 value
   now means the kernel won't weight-interleave the node.

- Setting a node weight to default value (e.g. via the previous
   semantic of '0') could be problematic because it's not atomic -
   the system may be updating default values while the user's
   trying to set a node weight to default value.

   To deal with that, Huang suggested 'use_defaults' to atomically update
   all the weights to system default.

Please let me know if there's any point we discussed that I am missing.

Additionally I would like to mention that within an internal discussion
my colleague Honggyu suggested introducing 'mode' parameter which can be
either 'manual' or 'auto' instead of 'use_defaults' to be provide more
intuitive interface.

With Honggyu's suggestion and the points we've discussed,
I think the interface could be:

# At booting, the mode is 'auto' where the kernel can automatically
# update any weights.

mode             auto         # User hasn't specified any weight yet.
effective        [2, 1, -, -] # Using system defaults for node 0-1,
                               # and node 2-3 not populated yet.

# When a new NUMA node is added (e.g. via hotplug) in the 'auto' mode,
# all weights are re-calculated based on ACPI HMAT table, including the
# weight of the new node.

mode             auto         # User hasn't specified weights yet.
effective        [2, 1, 1, -] # Using system defaults for node 0-2,
                               # and node 3 not populated yet.

# When user set at least one weight value, change the mode to 'manual'
# where the kernel does not update any weights automatically without
# user's consent.

mode             manual       # User changed the weight of node 0 to 4,
                               # changing the mode to manual config mode.
effective        [4, 1, 1, -]


# When a new NUMA node is added (e.g. via hotplug) in the manual mode,
# the new node's weight is zero because it's in manual mode and user
# did not specify the weight for the new node yet.

mode             manual
effective        [4, 1, 1, 0]

# When user changes the mode to 'auto', all weights are changed to
# system defaults based on the ACPI HMAT table.

mode             auto
effective        [2, 1, 1, 1]  # system defaults

In the example I did not distinguish 'default weights' and 'user
weights' because it's not important where the weight values came from --
but it's important to know 1) what's the effective weights now and 2) if
the kernel can update them.

Any thoughts?

---
Best,
Hyeonggon

