Return-Path: <linux-acpi+bounces-16429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5EB462F2
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 20:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197DFBA1F15
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B429C325;
	Fri,  5 Sep 2025 18:52:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C2629B20A;
	Fri,  5 Sep 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098366; cv=none; b=DbCZrU5QjzZ9B4UogkxIqcO+mk+vgOMVt0amqwJLUWD9DRIHn3waeSpRQ2qIFRlWG7PzyexnzegPbHC+G1XxDYCHTX0tZaTuOn7aR6j0CYFKOYHDBo0wzyfX1jqqgxKZPdlklcZ4w8c0Kvqeg8LYhL2+9C4p4E/OWKfeXFYeOz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098366; c=relaxed/simple;
	bh=6D2aVBqqBKV07BwAyUrhJdhm3+fz0a7BNgGgi1w1Y8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/0vYEq4kSsNQrpGVpy3a8UGtoJB4WleiSuLr7EmaKV/rsUjXnvONsKEP+ZT9H2tgrcsp0bu2mUtzyqYLCy27GLQbmftHswxFMSUG7XBRQIVeuzv0GOQidhu7QtIKtJgBP8SzJ6T72jtdF5MjQYoOqZ7pCrweotkP3Cottynn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E1241BC0;
	Fri,  5 Sep 2025 11:52:35 -0700 (PDT)
Received: from [10.1.197.69] (unknown [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28DB93F6A8;
	Fri,  5 Sep 2025 11:52:38 -0700 (PDT)
Message-ID: <d4aa5d0d-da66-4350-a9e1-ce7fb39f2961@arm.com>
Date: Fri, 5 Sep 2025 19:52:36 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-11-james.morse@arm.com>
 <CAL_JsqKUSJjmyj-E6eduZt3S=x6v7VUR5JEJV_Ow6O-O49TgEg@mail.gmail.com>
 <CAL_JsqJDpEHBcWeCqxSiUjpyBs0gEJKVyyR70xJO56x-pYQHMw@mail.gmail.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <CAL_JsqJDpEHBcWeCqxSiUjpyBs0gEJKVyyR70xJO56x-pYQHMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rob,

On 27/08/2025 17:16, Rob Herring wrote:
> On Wed, Aug 27, 2025 at 10:39 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Fri, Aug 22, 2025 at 10:32 AM James Morse <james.morse@arm.com> wrote:
>>>
>>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>>> only be accessible from those CPUs, and they may not be online.
>>> Touching the hardware early is pointless as MPAM can't be used until
>>> the system-wide common values for num_partid and num_pmg have been
>>> discovered.
>
> [...]
>
>>> +static int mpam_dt_parse_resources(struct mpam_msc *msc, void *ignored)
>>> +{
>>> +       int err, num_ris = 0;
>>> +       const u32 *ris_idx_p;
>>> +       struct device_node *iter, *np;
>>> +
>>> +       np = msc->pdev->dev.of_node;
>>> +       for_each_child_of_node(np, iter) {
>>
>> Use for_each_available_child_of_node_scoped()
>>
>>> +               ris_idx_p = of_get_property(iter, "reg", NULL);
>>
>> This is broken on big endian and new users of of_get_property() are
>> discouraged. Use of_property_read_reg().
>
> Err, this is broken on little endian as the DT is big endian.
>
> So this was obviously not tested as I'm confident you didn't test on BE.

'not tested' is shades of grey. I fed the FVP ~6 different DTB files to hit the different
paths through the driver. The FVP only has controls under RIS-0, so all of those only
defined RIS-0, and unsurprisingly didn't notice the helper isn't endian safe.


Thanks,

James

