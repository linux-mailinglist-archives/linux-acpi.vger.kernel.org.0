Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC428365EA6
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhDTRcs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 20 Apr 2021 13:32:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2892 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhDTRcr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2021 13:32:47 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FPrG006Sfz6wjTm;
        Wed, 21 Apr 2021 01:26:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Apr 2021 19:32:14 +0200
Received: from localhost (10.52.127.46) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 20 Apr
 2021 18:32:13 +0100
Date:   Tue, 20 Apr 2021 18:30:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vikram Sethi <vsethi@nvidia.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Douglas, Chet R" <chet.r.douglas@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Samer El-Haj-Mahmoud" <Samer.El-Haj-Mahmoud@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [ACPI Code First ECN v2]: Generic Port, performace data for
 hotplug memory
Message-ID: <20210420183044.0000172d@Huawei.com>
In-Reply-To: <BL0PR12MB25323D058297AD200277FBCFBD489@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com>
        <BL0PR12MB25321D18363AD50ACC7A2643BD499@BL0PR12MB2532.namprd12.prod.outlook.com>
        <CAPcyv4jztOGShTF+pVSMAtGeK4giHvC3mGNa5bC0pXz=2ZcrJw@mail.gmail.com>
        <BL0PR12MB2532D6AD41E6CF4F3252EE59BD489@BL0PR12MB2532.namprd12.prod.outlook.com>
        <CAPcyv4jMQbHYQssaDDDQFEbOR1v14VUnejcSwOP9VGUnZSsCKw@mail.gmail.com>
        <20210420100342.00000253@Huawei.com>
        <BL0PR12MB25323D058297AD200277FBCFBD489@BL0PR12MB2532.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.127.46]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 20 Apr 2021 16:53:36 +0000
Vikram Sethi <vsethi@nvidia.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Tuesday, April 20, 2021 4:04 AM
> > To: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vikram Sethi <vsethi@nvidia.com>; linux-cxl@vger.kernel.org; linux-
> > acpi@vger.kernel.org; Natu, Mahesh <mahesh.natu@intel.com>; Douglas, Chet R
> > <chet.r.douglas@intel.com>; Verma, Vishal L <vishal.l.verma@intel.com>;
> > Widawsky, Ben <ben.widawsky@intel.com>; Samer El-Haj-Mahmoud <Samer.El-
> > Haj-Mahmoud@arm.com>; Thanu Rangarajan <Thanu.Rangarajan@arm.com>
> > Subject: Re: [ACPI Code First ECN v2]: Generic Port, performace data for hotplug
> > memory
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, 19 Apr 2021 22:08:39 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > On Mon, Apr 19, 2021 at 9:22 PM Vikram Sethi <vsethi@nvidia.com> wrote:  
> > > >  
> > > > > From: Dan Williams <dan.j.williams@intel.com>
> > > > > On Mon, Apr 19, 2021 at 3:56 PM Vikram Sethi <vsethi@nvidia.com> wrote:
> > > > > [..]  
> > > > > > > * Replace all instances of "Initiator" with "Initiator / Port" in "Table
> > > > > > >   5.59 Flags - Generic Initiator Affinity Structure", including the
> > > > > > >   table name.  
> > > > > >
> > > > > > I wanted to discuss the implications of a CXL host bridge implementation  
> > that  
> > > > > > does not set the "Architectural Transactions" bit/flag in the aforementioned
> > > > > > Flags in Table 5.59.
> > > > > >
> > > > > > Since the kernel would be expecting all "System RAM" to have equivalent
> > > > > > Functional properties, if HDM cannot have all the same functionality, then  
> > in  
> > > > > > the absence of ISA specific ACPI tables clarifying what architectural feature  
> > isn't  
> > > > > > supported, the kernel may be forced to not online the HDM memory as  
> > system  
> > > > > > RAM. If there is more granular expression of what features are lacking in a  
> > ISA  
> > > > > > Specific table (eg Memory Tagging/Memory Protection keys not  
> > supported),  
> > > > > > the kernel could choose to not enable that feature in all of system RAM (if
> > > > > > discrepancy discovered at boot), but still online the HDM as System RAM.
> > > > > >
> > > > > > To that end, it may be useful to clarify this to host vendors by way of an
> > > > > > Implementation note (ideally in the CXL specification). Something like:
> > > > > > "CXL hosts are encouraged to support all architectural features in HDM
> > > > > > as they do in CPU attached memory to avoid either the memory from
> > > > > > being onlined as System RAM, or the architectural feature being disabled.
> > > > > > Hosts must indicate architectural parity for HDM in ACPI SRAT
> > > > > > “Generic Port” flags “Architectural transactions” bit by setting it to 1.
> > > > > > A port that sets this bit to 0 will need ISA specific ways/ACPI tables to
> > > > > > describe which specific ISA features would not work in HDM, so an OS
> > > > > > could disable that memory or that feature."
> > > > > >
> > > > > > Thoughts?  
> > > > >
> > > > > The problem, as you know, is that those features are already defined
> > > > > without those "ISA specific ways / ACPI tables". I think it simply
> > > > > must be the case that the only agent in the system that is aware of
> > > > > the intersection of capabilities between ISA and CXL (platform
> > > > > firmware) must mitigate the conflict. I.e. so that the CXL
> > > > > infrastructure need not worry about ISA feature capability and vice
> > > > > versa. To me, this looks like a platform firmware pre-boot
> > > > > configuration menu / switch that turns off CXL (declines to publish
> > > > > ACPI0016 devices) if incompatible ISA feature "X" is enabled, or the
> > > > > reverse turns off ISA feature "X" if CXL is enabled. In other words,
> > > > > the conflict needs to be resolved before the OS boots, setting this
> > > > > bit to 0 is not a viable option for mitigating the conflict because
> > > > > there is no requirement for the OS to even look at this flag.  
> > > >
> > > > Leaving it to Firmware is easier for the OS, but could be a couple
> > > > of issues with that:
> > > > Platform firmware may not have a way of disabling ISA feature
> > > > if it is directly visible to the OS via CPU ID registers, and the
> > > > registers can't be trapped to some FW and values adjusted
> > > > on access
> > > > Platform Firmware may not know if the OS supports a specific
> > > > Feature (code may not exist or not default option etc) so it
> > > > may be premature/suboptimal to disable CXL hostbridge
> > > > altogether. Although I suppose a UEFI variable type knob
> > > > could be adjusted in this case and take effect on reboot.
> > > >
> > > > Also, for some *future* ISA features where it may be possible and
> > > > practical to define ISA feature support discovery per NUMA
> > > > node/address range w/ ACPI (prior to userspace ABI being set),
> > > > the platform would want to enable the CXL host bridge and leave
> > > > selective enablement of the feature to the OS. Yes, this is messy
> > > > and best avoided, but it may make sense depending on ISA
> > > > feature and how messy it makes user space. I'm personally
> > > > not in favor of this latter option, but I'm told this was discussed
> > > > in other Coherent interconnect forums and chosen as a path
> > > > forward.  
> > >
> > > I think it's reasonable for new stuff to define _OSC or other opt-in
> > > requirements to allow the OS to manage ISA vs CXL conflict policy. For
> > > existing conflicts the only reliable mechanism is decline to publish
> > > ACPI0016 if platform firmware can enumerate an ISA feature that it is
> > > not supported on CXL. So I think the proposal here is a recommendation
> > > for platform firmware implementations that they are responsible for
> > > this conflict resolution unless / until other mechanisms arrive.  
> > 
> > Agreed with one addition.  It should be possible to retrofit negotiation
> > for existing features as well. Default policy should be that it's firmware's
> > problem but if the OS uses _OSC to negotiate something else then it may
> > be possible to be more flexible. As long as the default is safe, relaxing
> > that can happen once mechanisms are defined.  The actual decision on
> > whether to enable ACPI0016 can for example be pushed into AML code.
> >   
> 
> Relaxations could happen only when ABI to userspace isn't already set
> and in use though, no?

Indeed, though here we are talking about relaxing from:
- Firmware prevents the enabling of a feature (ISA feature or CXL) to...
- OS negotiates with the firmware to say it knows more (via some new method)
  and hence does want the feature enabled.

So userspace ABI doesn't change, things simply become available that were
previously not on this particular system (because firmware had to hide them)

> 
> What about Coherent device memory in type 2 devices? That is not EFI
> conventional memory but once some part has been onlined by a driver by
> calling something like add_memory_driver_managed, that part should 
> have all the properties of System RAM as well. Not clear that Platform
> firmware would know if a driver intents to online some or all of that
> memory. 

Type 2 devices are a pain to talk about in any remotely general fashion,
but it's certainly possible that their drivers might do something
different after negotiating with the firmware for permission to do so.
As you say though, firmware can't know if a driver intends to online that
memory, so as the potential is there, the safe option is not expose that
device at all (I think we'll fairly quickly develop a way to make this work
given alternative is turn lots of things off :)

My guess is it would be system wide.  So taking example of Memory tagging:
If the platform doesn't support that feature for all CXL attached memory
found (or potentially hotplugged), today it has to turn it off, or
refuse to expose connected CXL devices (it sets ACPI0016 _STA to say it's
not there or something like that).

If later, we get some new mechanism that allows the OS to handle this
mismatch, it can use _OSC or similar to tell the firmware it can handle
this case.  The firmware can then report the ACPI0016 as present.

The AML stuff is similar to the _OSC related _PXM manipulation that let
us safely introduce Generic Initiators - there we rely on the _OSC being
called before and _PXM calls are made and have the _PXM results change
dependent on result of that _OSC negotiation of capabilities.

Jonathan
