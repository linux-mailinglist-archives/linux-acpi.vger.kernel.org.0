Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7002CD30E
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 10:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgLCJ5z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 3 Dec 2020 04:57:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2198 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbgLCJ5z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 04:57:55 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cmrmg6RY4z67Hq5;
        Thu,  3 Dec 2020 17:55:15 +0800 (CST)
Received: from lhreml714-chm.china.huawei.com (10.201.108.65) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 3 Dec 2020 10:57:12 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml714-chm.china.huawei.com (10.201.108.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 3 Dec 2020 09:57:11 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 3 Dec 2020 17:57:09 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
Thread-Topic: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
Thread-Index: AQHWx46tyJL5OgLpakCat9sEfhhBKKnh4fQAgAK2JoCAAItncA==
Date:   Thu, 3 Dec 2020 09:57:09 +0000
Message-ID: <ebc9da1f1fdf45479651906edbfc55a6@hisilicon.com>
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com>
 <jhj1rg9v7gr.mognet@arm.com>
 <20201203092831.GH2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201203092831.GH2414@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Thursday, December 3, 2020 10:29 PM
> To: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> catalin.marinas@arm.com; will@kernel.org; rjw@rjwysocki.net; lenb@kernel.org;
> gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> mingo@redhat.com; juri.lelli@redhat.com; vincent.guittot@linaro.org;
> dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
> mgorman@suse.de; mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Zengtao (B)
> <prime.zeng@hisilicon.com>
> Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
> 
> On Tue, Dec 01, 2020 at 04:04:04PM +0000, Valentin Schneider wrote:
> >
> > Gating this behind this new config only leveraged by arm64 doesn't make it
> > very generic. Note that powerpc also has this newish "CACHE" level which
> > seems to overlap in function with your "CLUSTER" one (both are arch
> > specific, though).
> >
> > I think what you are after here is an SD_SHARE_PKG_RESOURCES domain walk,
> > i.e. scan CPUs by increasing cache "distance". We already have it in some
> > form, as we scan SMT & LLC domains; AFAICT LLC always maps to MC, except
> > for said powerpc's CACHE thingie.
> 
> There's some intel chips with a smaller L2, but I don't think we ever
> bothered.
> 
> There's also the extended topology stuff from Intel: SMT, Core, Module,
> Tile, Die, of which we've only partially used Die I think.
> 
> Whatever we do, it might make sense to not all use different names.

Yep. Valentin was actually recommending the same SD_SHARE_PKG_RESOURCES sd flags
by ignoring the actual names of the hardware.
But the question is where we should start, in case we have 3 domains under llc,
maybe it is not good to scan from the first level domain as it is gathering
too much.

> 
> Also, I think Mel said he was cooking something for
> select_idle_balance().
> 
> Also, I've previously posted patches that fold all the iterations into
> one, so it might make sense to revisit some of that if Mel also already
> didn.t

Would you point out the link of your previous patches?

Thanks
Barry

