Return-Path: <linux-acpi+bounces-10784-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19C5A18979
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 02:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B3D7A2C12
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 01:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4942F53368;
	Wed, 22 Jan 2025 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mi/hGQjT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB31E517;
	Wed, 22 Jan 2025 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737509075; cv=none; b=sllc2QAAYq49bUwUVgUc2lbc8TfWaro8oVbfAs1op1mckB2an0FBGU3zvx7UlzbGkCt3eomthQIepVmdDrE1m18fsjQsMw/TwmpZ0vpTZxIKOmgty0wvIkUbDQVHaDC3WHS2Y6TWEjm/z7yplTzYfDEUzCLZ4GMEaXVGTUwpskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737509075; c=relaxed/simple;
	bh=eaM1BH87XHSl3sAorXK4SPJuCWzuubx3MCt5x5w7HLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VenYbmZwiVhngwQPc2p33sd2Ga7/nx8hzXmxlvMafS37MfIQk7qLx1+w6lQ4xbC5HKd8dr5srBflyttOmlDj3SApGB4JXoYckk/4l2A9tqQDjUafXaa3qYxZ6Y8sdjNz+/uqyF26BMJ/okbKB8kgT3VtHzmj24rsV+fyB3r0p4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mi/hGQjT; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737509063; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ZPhJcHXO+4qxb/S/ng3urgM4sHYsTOg2Vg9r4Wof2z0=;
	b=mi/hGQjTRZRiyCUn5kU654bCxlUYSR9egZKQA/SnGiCkF9eEXpheCLBUwQIgsm5PEEENzZTXbr89Vf2a/QaYf3ieZU04XOLGOXUW8wVgdHBthdGURwnt5mVwhR+EEjER25iZAa8idKBL+6M8itEXocgZdUhiZdAnm0j1GLlzYjI=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WO6fYz._1737509047 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 09:24:22 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,  kernel_team@skhynix.com,
  gourry@gourry.net,  hyeonggon.yoo@sk.com,  rafael@kernel.org,
  lenb@kernel.org,  gregkh@linuxfoundation.org,  akpm@linux-foundation.org,
  rakie.kim@sk.com,  dan.j.williams@intel.com,
  Jonathan.Cameron@huawei.com,  dave.jiang@intel.com,
  horen.chuang@linux.dev,  hannes@cmpxchg.org,
  linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
In-Reply-To: <147aba6e-7e23-4ad1-9bd2-1ceac0f3d55b@sk.com> (Honggyu Kim's
	message of "Tue, 21 Jan 2025 20:27:17 +0900")
References: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
	<87ikq8h0w4.fsf@DESKTOP-5N7EMDA>
	<147aba6e-7e23-4ad1-9bd2-1ceac0f3d55b@sk.com>
Date: Wed, 22 Jan 2025 09:24:07 +0800
Message-ID: <87a5bjiqtk.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Honggyu,

Honggyu Kim <honggyu.kim@sk.com> writes:

> Hi Ying and Joshua,
>
> On 1/21/2025 8:17 PM, Huang, Ying wrote:
>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>> 

[snip]

>>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>>> index 0b7972de04e9..d30dc29c53ff 100644
>>> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>>> @@ -20,6 +20,30 @@ Description:	Weight configuration interface for nodeN
>>>   		Minimum weight: 1
>>>   		Maximum weight: 255
>>>   -		Writing an empty string or `0` will reset the weight
>>> to the
>>> -		system default. The system default may be set by the kernel
>>> -		or drivers at boot or during hotplug events.
>>> +		Writing invalid values (i.e. any values not in [1,255],
>>> +		empty string, ...) will return -EINVAL.
>>> +
>>> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/mode
>>> +Date:		January 2025
>>> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>>> +Description:	Auto-weighting configuration interface
>>> +
>>> +		Configuration modes for weighted interleave. Can take one of
>>> +		two options: "manual" and "auto". Default is "auto".
>>> +
>>> +		In auto mode, all node weights are re-calculated and overwritten
>>> +		(visible via the nodeN interfaces) whenever new bandwidth data
>>> +		is made available either during boot or hotplug events.
>>> +
>>> +		In manual mode, node weights can only be updated by the user.
>>> +		If a node is hotplugged while the user is in manual mode,
>>> +		the node will have a default weight of 1.
>>> +
>>> +		Modes can be changed by writing either "auto" or "manual" to the
>>> +		interface. All other strings will be ignored, and -EINVAL will
>>> +		be returned. If "auto" is written to the interface but the
>>> +		recalculation / updates fail at any point (-ENOMEM or -ENODEV)
>>> +		then the mode will remain in manual mode.
>>> +
>>> +		Writing a new weight to a node directly via the nodeN interface
>>> +		will also automatically update the system to manual mode.
>> IMHO, this interface is somewhat hard to be used.  Users need to
>> know
>> which value is legal.  So, this will become something like,
>> $ cat mode
>> auto [manual]
>> $ echo auto > mode
>> $ cat mode
>> [auto] manual
>
> This is exactly I internally proposed to Hyeonggon, but couldn't share
> the idea directly here.
>
>> Unless it's possible we will add more modes in the future, this is
>> kind
>> of overkill for me.  How about something simpler as below?
>> $ cat auto
>> true
>> $ echo 0 > auto
>> $ cat auto
>> false
>
> That also makes sense, but I feel like somewhat vague what "auto" false
> means. The "auto" might be better to be "use_hmat" instead and this
> makes "use_hmat" false more meaningful. "use_hmat_weight" or
> "use_hmat_info" might be another candidates.

As Gregory pointed out in another email.  hmat isn't good because it's
platform dependent.  We may use something else to get default weights on
another platform.

I'm open to other platform independent naming.  For example, use_default.

[snip]

---
Best Regards,
Huang, Ying

