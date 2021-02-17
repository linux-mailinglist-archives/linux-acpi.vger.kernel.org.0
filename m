Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A4431D729
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Feb 2021 10:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhBQJzX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Feb 2021 04:55:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2578 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhBQJzW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2021 04:55:22 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DgY4R2f30z67qBC;
        Wed, 17 Feb 2021 17:50:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Feb 2021 10:54:38 +0100
Received: from localhost (10.47.29.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Wed, 17 Feb
 2021 09:54:37 +0000
Date:   Wed, 17 Feb 2021 09:53:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Vishal L Verma" <vishal.l.verma@intel.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target
Message-ID: <20210217095331.000047e3@Huawei.com>
In-Reply-To: <CAPcyv4j962+sS1ovhTiat0SyjqjDOZyQ83k=t7f_XTAW_87PTg@mail.gmail.com>
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
        <20210210112330.00003e74@Huawei.com>
        <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
        <20210211094222.000048ae@Huawei.com>
        <CAPcyv4j0Wce-76OfgqTSkveukgDXB_p2VZZpgM8XjDFd+Q-0Ww@mail.gmail.com>
        <20210212122438.00003621@Huawei.com>
        <CAPcyv4j1axBsy4GdRxj4JhxRXtrK-U+ikxQ3xYKCa-z-a84XPQ@mail.gmail.com>
        <20210216110643.000071f0@Huawei.com>
        <CAPcyv4iv9kFLU7U9=VpYJZOiahUWJAZ_J_ZWCrGy1Lgqq+07kg@mail.gmail.com>
        <20210216180634.00007178@Huawei.com>
        <CAPcyv4h=e_a-YD2pAzY5k8Qc-+EMeBNyfzLfpuC01Jey6_sQ5g@mail.gmail.com>
        <20210216185837.000030c7@Huawei.com>
        <CAPcyv4j962+sS1ovhTiat0SyjqjDOZyQ83k=t7f_XTAW_87PTg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.29.73]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 16 Feb 2021 11:41:40 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Feb 16, 2021 at 11:00 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> [..]
> > > For
> > > example, the persistent memory enabling assigns the closest online
> > > memory node for the pmem device. That achieves the traditional
> > > behavior of the device-driver allocating from "local" memory by
> > > default. However the HMAT-sysfs representation indicates the numa node
> > > that pmem represents itself were it to be online. So the question is
> > > why does GI need more than that? To me a GI is "offline" in terms
> > > Linux node representations because numactl can't target it,  
> >
> > That's fair. It does exist in an intermediate world. Whether the
> > internal representation of online vs offline should have anything much
> > to do with numactl rather than whether than numactl being based on
> > whether a node has online memory or CPUs isn't clear to me.
> > It already has to distinguish whether a node has CPUs and / or memory
> > so this isn't a huge conceptual extension.
> >  
> > > "closest
> > > online" is good enough for a GI device driver,  
> >
> > So that's the point. Is it 'good enough'?  Maybe - in some cases.
> >  
> > > but if userspace needs
> > > the next level of detail of the performance properties that's what
> > > HMEM sysfs is providing.  
> >
> > sysfs is fine if you are doing userspace allocations or placement
> > decisions. For GIs it can be relevant if you are using userspace drivers
> > (or partially userspace drivers).  
> 
> That's unfortunate, please tell me there's another use for this
> infrastructure than userspace drivers? The kernel should not be
> carrying core-mm debt purely on behalf of userspace drivers.

Sorry I wasn't clear - that's the exact opposite of what I was trying to say
and perhaps I'd managed to confuse the HMAT sysfs interface with HMEM
(though google suggests they are different names for the same thing).

Firstly I'll note that the inclusion of GIs in that sysfs representation
was a compromise in the first place (I didn't initially do so, because of
the lack of proven use cases for this information in usespace
- we compromised on the access0 vs access1 distinction.)

The HMAT presentation via sysfs interface, for GIs, is useful
for userspace drivers. It can also be used for steering stuff in kernel
drivers where there are sufficiently rich interfaces (some networking
stuff + GPU drivers as I understand it). In those cases, userspace
can directly influence kernel driver placement decisions.
Userspace applications may also be able to place themselves locally to
devices they know they make heavy use of, but I'm not yet aware of any
application actually doing so using information from this interface
(as opposed to hand tuned setups).

Of course in kernel use cases exist for HMAT, but those are not
AFAIK common yet - at least partly because few existing
systems ship with HMAT.  It will be a while yet before we can rely on HMAT
being present in enough systems.

The core GI stuff - i.e. zone lists etc is useful for kernel drivers today
and is only tangentially connected to HMAT in that it is a new
form of initiator node alongside CPUs.

I would argue we did not add any core-mm debt to enable GI nodes as we
did. It uses support that is already there for memoryless nodes.  If you look
back at the patch adding GI there aren't any core-mm changes at all.
There is one extra registration pass needed on x86 because it has different
ordering of node onlining to arm64 (which didn't need any arch changes at all).

Sure, we can argue we are possibly complicating some potential changes in
core-mm sometime in the future, though the most I can think of is we would
need to 'not enable' something CPU specific for memoryless and CPU less
nodes.

> 
> > In the GI case, from my point of view the sysfs stuff was a nice addition
> > but not actually that useful.  The info in HMAT is useful, but too little
> > of it was exposed.  What I don't yet have (due to lack of time), is a good
> > set of examples that show more info is needed.  Maybe I'll get to that
> > one day!  
> 
> See the "migration in lieu of discard" [1] series as an attempt to
> make HMAT-like info more useful. The node-demotion infrastructure puts
> HMAT data to more use in the sense that the next phase of memory
> tiering enabling is to have the kernel automatically manage it rather
> than have a few enlightened apps consume the HMEM sysfs directly.
> 
> [1]: http://lore.kernel.org/r/20210126003411.2AC51464@viggo.jf.intel.com

We've been following that series (and related ones) with a great deal
of interest.  As I understand it that code still uses SLIT rather than
HMAT data - I guess that's why you said HMAT-like ;)

Absolutely agree though that using this stuff in kernel is going
to get us a lot more wins than exposing it to userspace is likely
to provide.

Jonathan



