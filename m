Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE4389FB9
	for <lists+linux-acpi@lfdr.de>; Thu, 20 May 2021 10:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhETIZS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 May 2021 04:25:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4696 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETIZR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2021 04:25:17 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fm2kW6mLpz16QST;
        Thu, 20 May 2021 16:21:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 16:23:54 +0800
Received: from localhost (10.52.127.139) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 20 May
 2021 09:23:51 +0100
Date:   Thu, 20 May 2021 09:22:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <20210520092205.000044ee@Huawei.com>
In-Reply-To: <CAPcyv4hCCqEPzGKh4hyjHEBE3jDn9iTA_WUOZMFptHKrX-2J_A@mail.gmail.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
        <20210511175006.00007861@Huawei.com>
        <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
        <20210514094755.00002081@Huawei.com>
        <CAPcyv4h_qSZq+sTAOTKDNsO3xPmq=65j8oO1iw0WdVFj8+XrOA@mail.gmail.com>
        <20210517094045.00004d58@Huawei.com>
        <CAPcyv4iQcV_U1qmQhXKM0RG9v-sAEPwtTxnv=P86yJrCH25k+w@mail.gmail.com>
        <20210518110403.000013e6@Huawei.com>
        <CAPcyv4g3JPtAHzemKdQiM44ZkZ_0u+U-UJ5mfeU3fKzRWuaDyQ@mail.gmail.com>
        <20210519161156.00003bf9@Huawei.com>
        <CAPcyv4j_oEWG1NG1wYryVt3-Gx8q2WwzP7_xhchsDARDR0zBEA@mail.gmail.com>
        <20210519172052.00002124@Huawei.com>
        <20210519173352.000026fe@Huawei.com>
        <CAPcyv4gUy0nNh-3y2wWVwM4AtO4F8OOJCtWz_ZH7Eu0H=oymuw@mail.gmail.com>
        <20210519180057.00002ac3@Huawei.com>
        <CAPcyv4ii3KC6MBBxJrnCUCm_JGS7ugL+JTFUu9QTBnPUhQFtfQ@mail.gmail.com>
        <20210519211818.00002acf@Huawei.com>
        <CAPcyv4hCCqEPzGKh4hyjHEBE3jDn9iTA_WUOZMFptHKrX-2J_A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.139]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 19 May 2021 16:51:36 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, May 19, 2021 at 1:20 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 19 May 2021 12:20:17 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > On Wed, May 19, 2021 at 10:03 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:
> > > [..]  
> > > > > > "The DOE Busy bit can be used to indicate that the DOE responder is
> > > > > >  temporarily unable to accept a data object. It is necessary for a
> > > > > >  DOE requester to ensure that individual data object transfers are
> > > > > >  completed, and that a request/response contract is completed, for
> > > > > >  example using a mutex mechanism to block other conflicting traffic
> > > > > >  for cases where such conflicts are possible."  
> > > > >
> > > > > I read that as the specification mandating my proposal to disallow
> > > > > multi-initiator access. My only mistake was making the exclusion apply
> > > > > to reads and not limiting it to the minimum of config write exclusion.  
> > > >
> > > > Key thing is even that isn't enough.   The mutex isn't about stopping
> > > > temporary access, it's about ensuring "request/response contract is completed".
> > > > So you would need userspace to be able to take a lock to stop the kernel
> > > > from using the DOE whilst it completes it's request/response pair and
> > > > userspace to guarantee it doesn't do anything stupid.  
> > >
> > > A userspace lockout of the kernel is not needed if userspace is
> > > outright forbidden from corrupting the kernel's state machine. I.e.
> > > kernel enforced full disable of user initiated config-write to DOE
> > > registers, not the ephemeral pci_cfg_access_lock() proposal.  
> >
> > That would work but I thought was ruled out as an approach.
> > @Bjorn would this be acceptable?
> >  
> 
> It sounded like Bjorn needed more convincing:
> 
>     "I don't know how hard we should work to protect against that."
> 
> ...and I'm advocating that yes, DOE config-writes are in a different
> class than other critical register writes, and that class is analogous
> to what Linux does for driver managed MMIO exclusion.

I'm not convinced they are special, though I can see an argument for write
protecting a bunch of registers in config space, including them, with
some form of disable for those debug type cases that Bjorn referred to.

> 
> > >  
> > > > Easiest way to do that is provide proper interfaces that allows the
> > > > kernel to fully mediate the access + don't support direct userspace access
> > > > for normal operation. (treat it the same as an other config space write)  
> > >
> > > Again, it's the parenthetical at issue. I struggle to see this as just
> > > another errant / unwanted config-write when there is legitimate reason
> > > for userspace to expect that touching the DOE is not destructive to
> > > device operation as opposed to writes to other critical registers.  
> >
> > True for specific protocols (CDAT). I'm fairly sure, with IDE you can take down
> > the link encryption to the device, potentially (worst case?) resulting a memory
> > access failure and a machine reboot or corruption of persistent memory.  
> 
> No, that does not sound right. My reading of the PCI IDE spec
> highlights a few exclusions that apply here:
> 
> 1/ A DOE instance that implements the CMA/SPDM protocol will support
> "no other data object protocol(s)".
> 
> 2/ An SPDM session once established arranges for "requests that are
> received through a different secure [SPDM] session must be discarded
> by the Responder, and must not result in a response"

Fair enough.  I've not looked at that one in a while and clearly
need to give it another read.
CXL compliance though can definitely cause things to be exciting
for the host.

> 
> >  
> > > Where the kernel's legitimate-access and userspace's legitimate-access
> > > to a resource collide, the kernel provides a mediation interface that
> > > precludes conflicts. Otherwise, I don't understand why the kernel is
> > > going through the trouble of /dev/mem and pci-mmap restrictions if it
> > > is not supposed to be concerned about userspace corrupting driver
> > > state.  
> >
> > The short answer is that lock requirement, in the above note, rules
> > out safe direct userspace use of the DOE (unless we can tell the kernel
> > is not going to ever use it).  
> 
> Linux has the mitigation for that situation defined already. It's the
> mechanism for /dev/mem and pci-mmap exclusion: disable the driver to
> enable unfettered userspace access (modulo kernel-lockdown is
> disabled).
> 
> > Mediation must be done. Even if we safely
> > protect the kernel side via aborts, userspace transactions can be
> > interrupted in a fashion that is invisible to userspace (beyond maybe
> > a timeout if the userspace code is hardened against this).  
> 
> Right, ephemeral per-transaction lockout is more complicated to handle
> than coarse lockout bounded to driver attach lifetime.
> 
> > So there is no
> > legitimate use that is not fully mediated by the kernel. So ioctl
> > or defined per protocol interfaces are the way forwards.  
> 
> Agree, and Linux has historically tried to wrap specific protocols
> around capabilities like this rather than defining raw passthroughs.
> I.e. I'm equating DOE enabling policy to ACPI DSM enabling policy. So
> per-protocol enabling is my expectation regardless of sysfs or ioctl.
> In fact. for SPDM and IDE key establishment that is probably neither
> ioctl nor sysfs, but instead a cooperation with the Linux keys api.

Agreed.  On that basis I'll do a very limited polish of the generic
ioctl approach simply as an enabling tool and put some warnings
on the patch that we don't currently intend it to be merged etc.

Great - that lets be me lazy with testing lifetime management which
is always irritating to do ;)

> 
> > Perhaps that's putting it rather strongly :)  
> 
> No major disagreement on the big picture... just quibbling with
> details at this point.

