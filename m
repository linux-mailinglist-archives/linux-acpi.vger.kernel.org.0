Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5A836F49C
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Apr 2021 05:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhD3Dq6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 29 Apr 2021 23:46:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3411 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhD3Dq4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Apr 2021 23:46:56 -0400
Received: from dggeml752-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FWdVm1yc9z5vZy;
        Fri, 30 Apr 2021 11:42:56 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (7.185.36.106) by
 dggeml752-chm.china.huawei.com (10.1.199.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Apr 2021 11:46:05 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 30 Apr 2021 11:46:05 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 30 Apr 2021 11:46:04 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Andrew Jones <drjones@redhat.com>
CC:     "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [RFC PATCH v6 1/4] topology: Represent clusters of CPUs within a
 die
Thread-Topic: [RFC PATCH v6 1/4] topology: Represent clusters of CPUs within a
 die
Thread-Index: AQHXNXvAeoar4cxa7ESjcQhDUM7ABqrJNh+AgANDDqA=
Date:   Fri, 30 Apr 2021 03:46:04 +0000
Message-ID: <2fcccd7430f945e9badf693627298fdd@hisilicon.com>
References: <20210420001844.9116-2-song.bao.hua@hisilicon.com>
 <20210428094811.159245-1-drjones@redhat.com>
In-Reply-To: <20210428094811.159245-1-drjones@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.93]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Wednesday, April 28, 2021 9:48 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: aubrey.li@linux.intel.com; bp@alien8.de; bsegall@google.com;
> catalin.marinas@arm.com; dietmar.eggemann@arm.com;
> gregkh@linuxfoundation.org; guodong.xu@linaro.org; hpa@zytor.com; Jonathan
> Cameron <jonathan.cameron@huawei.com>; juri.lelli@redhat.com;
> lenb@kernel.org; Liguozhu (Kenneth) <liguozhu@hisilicon.com>;
> linux-acpi@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linuxarm@openeuler.org; mark.rutland@arm.com;
> mgorman@suse.de; mingo@redhat.com; msys.mizuma@gmail.com;
> peterz@infradead.org; Zengtao (B) <prime.zeng@hisilicon.com>;
> rjw@rjwysocki.net; rostedt@goodmis.org; sudeep.holla@arm.com;
> tglx@linutronix.de; tim.c.chen@linux.intel.com; valentin.schneider@arm.com;
> vincent.guittot@linaro.org; will@kernel.org; x86@kernel.org; xuwei (O)
> <xuwei5@huawei.com>; yangyicong <yangyicong@huawei.com>
> Subject: Re: [RFC PATCH v6 1/4] topology: Represent clusters of CPUs within
> a die
> 
> On 20/04/2021 12:18, Barry Song wrote:
> ...
> > Currently the ID provided is the offset of the Processor
> > Hierarchy Nodes Structure within PPTT.  Whilst this is unique
> > it is not terribly elegant so alternative suggestions welcome.
> >
> 
> The ACPI table offsets are consistent with how other topology IDs are
> generated. I once tried to make them a little more human friendly with
> [1], but it was nacked.
> 
> [1] https://lore.kernel.org/lkml/20180629132934.GA16282@e107155-lin/t/
> 

Ideally, we are going to check if cluster node has a valid UID,
if yes, read this ID; otherwise, fall back to use offset.

Will move to that way in next version.

> Thanks,
> drew

Thanks
Barry
