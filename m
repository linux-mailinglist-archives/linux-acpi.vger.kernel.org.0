Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 802B26E7F7
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jul 2019 17:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfGSP3k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Jul 2019 11:29:40 -0400
Received: from foss.arm.com ([217.140.110.172]:44496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfGSP3k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Jul 2019 11:29:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F840344;
        Fri, 19 Jul 2019 08:29:39 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 718AD3F59C;
        Fri, 19 Jul 2019 08:29:37 -0700 (PDT)
Subject: Re: MPAM branch verification (was RE: [RFC PATCH 2/2] ACPI / PPTT:
 cacheinfo: Label caches based on fw_token)
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Vijaya Kumar K <vkilari@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tomasz Nowicki <Tomasz.Nowicki@cavium.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
        Richard Ruigrok <rruigrok@qti.qualcomm.com>
References: <5FC3163CFD30C246ABAA99954A238FA83F2B38FD@lhreml524-mbs.china.huawei.com>
 <d3341796-d7ce-8b1b-3575-333eda7e6d07@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83F2DBB39@lhreml524-mbs.china.huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <6b863739-fc6d-424c-6b70-21e2e3775b78@arm.com>
Date:   Fri, 19 Jul 2019 16:29:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F2DBB39@lhreml524-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

On 03/07/2019 13:27, Shameerali Kolothum Thodi wrote:
>> -----Original Message-----
>> On 21/06/2019 16:57, Shameerali Kolothum Thodi wrote:
>>>> -----Original Message-----
>>>> From: James Morse [mailto:james.morse@arm.com]

>> The domid bitfield not being big enough for the width of the cacheinfo id field
>> looks like
>> a bug in the existing resctrl code. Could you spin that as a patch against
>> mainline?
> 
> Yes it could be a bug. But I am not sure about the assumption on x86 platforms with
> respect to cache id width. Also any need to consider 32 bit systems at all or not.
> 
>> It won't affect any x86 system, but I don't want to 'fix' anything as part of the
>> mpam
>> support.
> 
> Does that mean the cache id width on x86 will never be >14 bits?

I have no idea. Today they're 0,1,2, so its unlikely?, but Documentation/x86/resctrl.rst's
"Cache IDs" section says "it isn't guaranteed to be a contiguous sequence", so maybe?

The problem is 'struct cacheinfo's id field is an int, its exposed via sysfs as an int,
but resctrl packs it into a smaller size. That's going to bite one day, it would be good
to fix it now we know its a problem.


>> We almost certainly need to compress the cache-id numbers down to {0,1,2} if
>> only so we
>> haven't filled all the exposed bits on day-1. (so it might not matter for arm64
>> either...)
> 
> That will be nice if we can compress it like that> I think we can leave the fix for now
> and come up with a solution when things gets really going.
> 
> Mean time I am trying to probe memory controller as well on our system and it looks
> like there are still issues.

Typo in the MBA picking code? Should be:
| if (!mpam_has_feature(mpam_feat_mbw_part, class->features) &&
|     !mpam_has_feature(mpam_feat_mbw_max, class->features)) {

It can do something useful with either of those features, but the (!part || !max)
previously forced it to have both.

(This still doesn't work on the model as its describing a 0-bit bitmap MBW_PART)


> I will debug and update if it really is a problem. Please
> let me know if you have any plans to update the branch so that I can try the latest.

I hope to push a new version by the end of June. (whoosh! There goes June).
http://www.linux-arm.org/git?p=linux-jm.git;a=shortlog;h=refs/heads/mpam/snapshot/jun

The changes in there are to avoid the known-issues when the same 'thing' is picked as both
L3 resource and the MBA resource.

I think the risk of sleeping-while-atomic if not all mpam:devices are accessible from all
CPUs in the resctrl:domain is my next highest priority issue...


Thanks,

James
