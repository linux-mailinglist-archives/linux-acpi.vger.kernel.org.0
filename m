Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B830A34162A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 07:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhCSG5b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 19 Mar 2021 02:57:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2714 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhCSG5R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 02:57:17 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F1vg545PMz680hd;
        Fri, 19 Mar 2021 14:50:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 07:57:12 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 06:57:11 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Fri, 19 Mar 2021 14:57:09 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [RFC PATCH v5 1/4] topology: Represent clusters of CPUs within a
 die
Thread-Topic: [RFC PATCH v5 1/4] topology: Represent clusters of CPUs within a
 die
Thread-Index: AQHXHHeQcl1lHq1u7kWPO6cWrdJxq6qKVPyAgACJR5A=
Date:   Fri, 19 Mar 2021 06:57:08 +0000
Message-ID: <eb48302277f3436eb9899032e6b0bf1c@hisilicon.com>
References: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
 <20210319041618.14316-2-song.bao.hua@hisilicon.com>
 <YFRGIedW1fUlnmi+@kroah.com>
In-Reply-To: <YFRGIedW1fUlnmi+@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.211]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Friday, March 19, 2021 7:35 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: tim.c.chen@linux.intel.com; catalin.marinas@arm.com; will@kernel.org;
> rjw@rjwysocki.net; vincent.guittot@linaro.org; bp@alien8.de;
> tglx@linutronix.de; mingo@redhat.com; lenb@kernel.org; peterz@infradead.org;
> dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
> mgorman@suse.de; msys.mizuma@gmail.com; valentin.schneider@arm.com; Jonathan
> Cameron <jonathan.cameron@huawei.com>; juri.lelli@redhat.com;
> mark.rutland@arm.com; sudeep.holla@arm.com; aubrey.li@linux.intel.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-acpi@vger.kernel.org; x86@kernel.org; xuwei (O) <xuwei5@huawei.com>;
> Zengtao (B) <prime.zeng@hisilicon.com>; guodong.xu@linaro.org; yangyicong
> <yangyicong@huawei.com>; Liguozhu (Kenneth) <liguozhu@hisilicon.com>;
> linuxarm@openeuler.org; hpa@zytor.com
> Subject: Re: [RFC PATCH v5 1/4] topology: Represent clusters of CPUs within
> a die
> 
> On Fri, Mar 19, 2021 at 05:16:15PM +1300, Barry Song wrote:
> > diff --git a/Documentation/admin-guide/cputopology.rst
> b/Documentation/admin-guide/cputopology.rst
> > index b90dafc..f9d3745 100644
> > --- a/Documentation/admin-guide/cputopology.rst
> > +++ b/Documentation/admin-guide/cputopology.rst
> > @@ -24,6 +24,12 @@ core_id:
> >  	identifier (rather than the kernel's).  The actual value is
> >  	architecture and platform dependent.
> >
> > +cluster_id:
> > +
> > +	the Cluster ID of cpuX.  Typically it is the hardware platform's
> > +	identifier (rather than the kernel's).  The actual value is
> > +	architecture and platform dependent.
> > +
> >  book_id:
> >
> >  	the book ID of cpuX. Typically it is the hardware platform's
> > @@ -56,6 +62,14 @@ package_cpus_list:
> >  	human-readable list of CPUs sharing the same physical_package_id.
> >  	(deprecated name: "core_siblings_list")
> >
> > +cluster_cpus:
> > +
> > +	internal kernel map of CPUs within the same cluster.
> > +
> > +cluster_cpus_list:
> > +
> > +	human-readable list of CPUs within the same cluster.
> > +
> >  die_cpus:
> >
> >  	internal kernel map of CPUs within the same die.
> 
> Why are these sysfs files in this file, and not in a Documentation/ABI/
> file which can be correctly parsed and shown to userspace?

Well. Those ABIs have been there for much a long time. It is like:

[root@ceph1 topology]# ls
core_id  core_siblings  core_siblings_list  physical_package_id thread_siblings  thread_siblings_list
[root@ceph1 topology]# pwd
/sys/devices/system/cpu/cpu100/topology
[root@ceph1 topology]# cat core_siblings_list
64-127
[root@ceph1 topology]#

> 
> Any chance you can fix that up here as well?

Yes. we will send a separate patch to address this, which won't
be in this patchset. This patchset will base on that one.

> 
> Also note that "list" is not something that goes in sysfs, sysfs is "one
> value per file", and a list is not "one value".  How do you prevent
> overflowing the buffer of the sysfs file if you have a "list"?
> 

At a glance, the list is using "-" rather than a real list
[root@ceph1 topology]# cat core_siblings_list
64-127

Anyway, I will take a look if it has any chance to overflow.

> thanks,
> 
> greg k-h

Thanks
Barry

