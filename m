Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14EF0519A6
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfFXRfx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 13:35:53 -0400
Received: from foss.arm.com ([217.140.110.172]:55626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731032AbfFXRfw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jun 2019 13:35:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07DC0C0A;
        Mon, 24 Jun 2019 10:35:52 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E0AA3F718;
        Mon, 24 Jun 2019 10:35:50 -0700 (PDT)
Subject: Re: MPAM branch verification (was RE: [RFC PATCH 2/2] ACPI / PPTT:
 cacheinfo: Label caches based on fw_token)
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Vijaya Kumar K <vkilari@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Tomasz Nowicki <Tomasz.Nowicki@cavium.com>,
        Richard Ruigrok <rruigrok@qti.qualcomm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
References: <5FC3163CFD30C246ABAA99954A238FA83F2B38FD@lhreml524-mbs.china.huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d3341796-d7ce-8b1b-3575-333eda7e6d07@arm.com>
Date:   Mon, 24 Jun 2019 18:35:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F2B38FD@lhreml524-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

On 21/06/2019 16:57, Shameerali Kolothum Thodi wrote:
>> -----Original Message-----
>> From: James Morse [mailto:james.morse@arm.com]

>> Subject: Re: [RFC PATCH 2/2] ACPI / PPTT: cacheinfo: Label caches based on
>> fw_token

>>> and noted that
>>> on our HiSilicon platform all the L3 cache were labeled with the same Id.
>> Debugging> revealed that the above leaf node check was removed in this
>> branch[2] which makes
>>> the min_physid calculation going wrong.

>>> Just wondering is there any particular reason
>>> for removing the check or the branch is not carrying the latest patch?
>>
>> Nope, that's a bug.
>>
>> Jeremy Linton's review feedback[0] was that that PROCESSOR_ID_VALID flag
>> can't be relied
>> on. It looks like I over-zealously removed the whole if(), and this doesn't cause a
>> problem with my pptt so I didn't notice.
>>
>> I've fixed it locally, I've also pushed a fix to those branches, but it will get folded
>> in
>> next time I push a branch.
> 
> Thanks for that.
> 
> Apart from the above, I have come across few other issues as well and had some
> temporary fixes to the branch here[0]. This is encountered while trying to get the
> resctrl fs mounted and attempted a cqm test run using resctrl_tests tool. 

Thanks! I haven't run that on the model yet as I want it to get the monitors working first.

If you are seeing bugs in that monitor code, beware you're the only person to ever run it!


> The fixes may not be proper ones, but I think it will give you an idea. Please take a
> look and let me know your thoughts.

{,!} exposed_mon_capable, yup that's a typo.

the evt_list being uninitialised is because that code has never run, as noted in the
KNOWN_ISSUES, (The model doesn't expose have any of the mpam counters...)

Issues around component->resource mapping will disappear as I've re-written all that to
fix issues around picking the same resource twice.


The domid bitfield not being big enough for the width of the cacheinfo id field looks like
a bug in the existing resctrl code. Could you spin that as a patch against mainline?

It won't affect any x86 system, but I don't want to 'fix' anything as part of the mpam
support.

We almost certainly need to compress the cache-id numbers down to {0,1,2} if only so we
haven't filled all the exposed bits on day-1. (so it might not matter for arm64 either...)


Thanks,

James
