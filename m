Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240035E3E0
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 14:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfGCM2I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 3 Jul 2019 08:28:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33045 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfGCM2I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jul 2019 08:28:08 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9AA835D2410C32F149EB;
        Wed,  3 Jul 2019 13:28:06 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.154]) by
 LHREML710-CAH.china.huawei.com ([10.201.108.33]) with mapi id 14.03.0415.000;
 Wed, 3 Jul 2019 13:27:57 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     Vijaya Kumar K <vkilari@codeaurora.org>,
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
Subject: RE: MPAM branch verification (was RE: [RFC PATCH 2/2] ACPI / PPTT:
 cacheinfo: Label caches based on fw_token)
Thread-Topic: MPAM branch verification (was RE: [RFC PATCH 2/2] ACPI / PPTT:
 cacheinfo: Label caches based on fw_token)
Thread-Index: AdUoR6JBXCmGfD+rTvOGseVrKJ7QIACYz8KAAbik43A=
Date:   Wed, 3 Jul 2019 12:27:57 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F2DBB39@lhreml524-mbs.china.huawei.com>
References: <5FC3163CFD30C246ABAA99954A238FA83F2B38FD@lhreml524-mbs.china.huawei.com>
 <d3341796-d7ce-8b1b-3575-333eda7e6d07@arm.com>
In-Reply-To: <d3341796-d7ce-8b1b-3575-333eda7e6d07@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.96.3]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi James,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of James Morse
> Sent: 24 June 2019 18:36
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Vijaya Kumar K <vkilari@codeaurora.org>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Tomasz Nowicki
> <Tomasz.Nowicki@cavium.com>; Jeffrey Hugo <jhugo@codeaurora.org>;
> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Linuxarm
> <linuxarm@huawei.com>; Jeremy Linton <jeremy.linton@arm.com>;
> linux-acpi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Sudeep Holla
> <sudeep.holla@arm.com>; wangxiongfeng (C)
> <wangxiongfeng2@huawei.com>; Richard Ruigrok
> <rruigrok@qti.qualcomm.com>
> Subject: Re: MPAM branch verification (was RE: [RFC PATCH 2/2] ACPI / PPTT:
> cacheinfo: Label caches based on fw_token)
> 
> Hi Shameer,
> 
> On 21/06/2019 16:57, Shameerali Kolothum Thodi wrote:
> >> -----Original Message-----
> >> From: James Morse [mailto:james.morse@arm.com]
> 
> >> Subject: Re: [RFC PATCH 2/2] ACPI / PPTT: cacheinfo: Label caches based on
> >> fw_token
> 
> >>> and noted that
> >>> on our HiSilicon platform all the L3 cache were labeled with the same Id.
> >> Debugging> revealed that the above leaf node check was removed in this
> >> branch[2] which makes
> >>> the min_physid calculation going wrong.
> 
> >>> Just wondering is there any particular reason
> >>> for removing the check or the branch is not carrying the latest patch?
> >>
> >> Nope, that's a bug.
> >>
> >> Jeremy Linton's review feedback[0] was that that PROCESSOR_ID_VALID
> flag
> >> can't be relied
> >> on. It looks like I over-zealously removed the whole if(), and this doesn't
> cause a
> >> problem with my pptt so I didn't notice.
> >>
> >> I've fixed it locally, I've also pushed a fix to those branches, but it will get
> folded
> >> in
> >> next time I push a branch.
> >
> > Thanks for that.
> >
> > Apart from the above, I have come across few other issues as well and had
> some
> > temporary fixes to the branch here[0]. This is encountered while trying to get
> the
> > resctrl fs mounted and attempted a cqm test run using resctrl_tests tool.
> 
> Thanks! I haven't run that on the model yet as I want it to get the monitors
> working first.
> 
> If you are seeing bugs in that monitor code, beware you're the only person to
> ever run it!

Ya..I guessed so :).

> 
> > The fixes may not be proper ones, but I think it will give you an idea. Please
> take a
> > look and let me know your thoughts.
> 
> {,!} exposed_mon_capable, yup that's a typo.

Ok.

> the evt_list being uninitialised is because that code has never run, as noted in
> the
> KNOWN_ISSUES, (The model doesn't expose have any of the mpam counters...)
> 
> Issues around component->resource mapping will disappear as I've re-written
> all that to
> fix issues around picking the same resource twice.

Ok. Good to know that.

> 
> The domid bitfield not being big enough for the width of the cacheinfo id field
> looks like
> a bug in the existing resctrl code. Could you spin that as a patch against
> mainline?

Yes it could be a bug. But I am not sure about the assumption on x86 platforms with
respect to cache id width. Also any need to consider 32 bit systems at all or not.

> It won't affect any x86 system, but I don't want to 'fix' anything as part of the
> mpam
> support.

Does that mean the cache id width on x86 will never be >14 bits?

> We almost certainly need to compress the cache-id numbers down to {0,1,2} if
> only so we
> haven't filled all the exposed bits on day-1. (so it might not matter for arm64
> either...)

That will be nice if we can compress it like that. I think we can leave the fix for now
and come up with a solution when things gets really going.

Mean time I am trying to probe memory controller as well on our system and it looks
like there are still issues. I will debug and update if it really is a problem. Please
let me know if you have any plans to update the branch so that I can try the latest.

Cheers,
Shameer
 
> 
> Thanks,
> 
> James
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
