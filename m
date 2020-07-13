Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B19218B84
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jul 2020 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbgGHPkf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 8 Jul 2020 11:40:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2445 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729858AbgGHPke (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Jul 2020 11:40:34 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 5913D71F1BE5E45C19F5;
        Wed,  8 Jul 2020 16:40:31 +0100 (IST)
Received: from localhost (10.52.126.65) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 8 Jul 2020
 16:40:30 +0100
Date:   Wed, 8 Jul 2020 16:39:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2] PCI/AER: Add support for reset of RCiEPs for
 APEI/Firmware first reporting only
Message-ID: <20200708163924.00007006@Huawei.com>
In-Reply-To: <431b4d136e5e2ba158640c0ef6eb7dc09351a992.camel@linux.intel.com>
References: <20200622114402.892798-1-Jonathan.Cameron@huawei.com>
        <02999929-39F5-4A11-AACA-84490F12E12B@linux.intel.com>
        <20200626194126.00007190@Huawei.com>
        <6CAFE871-36CC-44DD-B4E0-D0BB5ABF3947@linux.intel.com>
        <20200703092351.00004981@Huawei.com>
        <431b4d136e5e2ba158640c0ef6eb7dc09351a992.camel@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.126.65]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 7 Jul 2020 09:56:26 -0700
Sean V Kelley <sean.v.kelley@linux.intel.com> wrote:

> On 3 Jul 2020, at 1:23, Jonathan Cameron wrote:
> 
> > On Thu, 2 Jul 2020 11:06:26 -0700
> > Sean V Kelley <sean.v.kelley@linux.intel.com> wrote:
> >   
> > > On 26 Jun 2020, at 11:41, Jonathan Cameron wrote:
> > >   
> > > > On Fri, 26 Jun 2020 09:29:34 -0700
> > > > Sean V Kelley <sean.v.kelley@linux.intel.com> wrote:
> > > >   
> > > > > Hi,  
> > > > Hi,
> > > > 
> > > > Thanks for taking a look.
> > > >   
> > > > > 
> > > > > On 22 Jun 2020, at 4:44, Jonathan Cameron wrote:
> > > > >   
> > > > > > Was previously: PCI/AER: Add partial initial supprot for
> > > > > > RCiEPs
> > > > > > using
> > > > > > RCEC or
> > > > > > firmware first.
> > > > > > 
> > > > > > Currently the kernel does not handle AER errors for Root
> > > > > > Complex
> > > > > > integrated
> > > > > > End Points (RCiEPs)[0].  These devices sit on a root bus
> > > > > > within 
> > > > > > the
> > > > > > Root Complex
> > > > > > (RC).  AER handling is performed by a Root Complex Event
> > > > > > Collector
> > > > > > (RCEC) [1]
> > > > > > which is a effectively a type of RCiEP on the same root bus.
> > > > > > 
> > > > > > This code will only perform the correct reset flow for the
> > > > > > case
> > > > > > where
> > > > > > there
> > > > > > is no need to take any actions on the RCEC because the
> > > > > > firmware is
> > > > > > responsible for them.   This is true where APEI [2] is used
> > > > > > to
> > > > > > report
> > > > > > the AER
> > > > > > errors via a GHES[v2] HEST entry [3] and relevant AER CPER
> > > > > > record
> > > > > > [4]
> > > > > > and Firmware
> > > > > > First handling is in use.  
> > > > > 
> > > > > Right, in the case of the RCEC one identifies the RCiEPs by
> > > > > the 
> > > > > RCiEP
> > > > > bitmap as a part of the RCEC Associated Endpoint Extended
> > > > > Capabilities.
> > > > > This ‘search’ so to speak would make use also of the RCEC
> > > > > Associated
> > > > > Bus Numbers Register to associate the devices with an RCEC when
> > > > > not
> > > > > on
> > > > > the same bus.  
> > > > 
> > > > Ah. I'm afraid my access to recent specs is a bit limited at the
> > > > moment.
> > > > I do have a draft 5.0 spec which has that in though so I now see 
> > > > what
> > > > you mean.
> > > > 
> > > > Was introduced in Root Complex Event Collector Endpoint
> > > > Association
> > > > Extended
> > > > Capability version 2 in PCIe 5.0 I think.
> > > >   
> > > 
> > > Correct.
> > >   
> > > > > > As there is no current RCEC driver support, it should not be
> > > > > > possible
> > > > > > to get
> > > > > > to this code via any routes other than the one above. Hence
> > > > > > appropriate RCEC
> > > > > > handling can be added when the RCEC driver support is ready.
> > > > > > The error handling is different from a normal PCIe End Point
> > > > > > because:
> > > > > > 
> > > > > > 1) There is no downstream port above an RCiEP as these
> > > > > > devices sit
> > > > > > on
> > > > > > a root
> > > > > >    bus.
> > > > > > 
> > > > > > 2) In general, it makes little sense to reset other devices
> > > > > > on on
> > > > > > the
> > > > > > same
> > > > > >    root bus.  For error handling outside the of the root
> > > > > > complex
> > > > > > (RC)
> > > > > > an AER
> > > > > >    error will indicate that all the topology below the
> > > > > > physical
> > > > > > link,
> > > > > > which
> > > > > >    the error is related to, will need to be reset as they
> > > > > > share a
> > > > > > common
> > > > > >    path to the host.  For an RCiEP there is no such defined
> > > > > > shared
> > > > > > path
> > > > > >    relationship with other elements on the root bus.
> > > > > > 
> > > > > > A new walk function, similar to pci_bus_walk is provided
> > > > > > that 
> > > > > > takes
> > > > > > a
> > > > > > pci_dev
> > > > > > instead of a bus.  If that dev corresponds to a downstream
> > > > > > port it
> > > > > > will walk
> > > > > > the subordinate bus of that downstream port.  If the dev does
> > > > > > not
> > > > > > then
> > > > > > it
> > > > > > will call the function on that device alone.   This function 
> > > > > > allows
> > > > > > us
> > > > > > to
> > > > > > avoid adding special cases to the majority of the error
> > > > > > handling.  
> > > > > 
> > > > > Then in that case the callback could add the additional checks
> > > > > specific
> > > > > to identifying the associated RCiEPs.  
> > > > 
> > > > I am afraid I don't follow what you mean here.  Could you give
> > > > more
> > > > info?  
> > > 
> > > Sure, a given RCEC can be associated with multiple RCiEPs.  As a
> > > part 
> > > of
> > > the Extended Association Cap it is possible to obtain a bitmap of
> > > the
> > > RCiEP device ids on the same bus number as the RCEC device itself.
> > > (5.0-1.0 sec 7.9.10.2).  With a Cap version of 2h or higher, it is 
> > > also
> > > possible to get an additional range of bus numbers containing
> > > RCiEPs
> > > also associated with this RCEC.
> > > 
> > > So I’m wondering if this function could be used in which passing a
> > > dev, in this case the RCEC, triggers the call back which makes use
> > > of
> > > the RCiEP bitmap and associated bus ranges to return all identified
> > > devices in use cases such as in AER for finding sources, etc.  
> > 
> > Ah understood.
> > 
> > If we do this we effectively end up with 3 different types of walk
> > and
> > the meaning of the walk function gets more complex again.
> > 
> > 1) Normal bus walk - we pass the downstream port above a bus to which
> > the device is attached and it walks everthing below that point.
> > 
> > 2) Case I care about RCiEP with no visible association with an RCEC
> > as
> > I don't need to walk devices.  In that case just calls the callbacks 
> > for
> > the actual device.
> > 
> > 3) Pass in RCiEP with RCEC asociated with it (or do a dance at the 
> > caller
> > to pass in the RCEC itself). Need to walk the devices that the RCEC
> > is
> > handling errors for.  For handling, I'm not all the calls will be 
> > generally
> > applicable to other devices associated with the RCEC as some only
> > make
> > sense if there is an actual PCIe bus involved and hence we need to 
> > reset
> > other devices on that bus.  For RCEC I don't think there is an 
> > particular
> > reason to assume an AER error reported at one RCiEP will have any 
> > impact
> > on other devices associated with the particular RCEC.
> > I've not found anything in the spec addressing this question but 
> > perhaps
> > I've missed something?  
> 
> Correct.  There should be no impact to the RCEC or its associated
> RCiEPs which may not happen to reside on the same bus as the collector at all.
> 
> > However, if the RCEC doesn't support multiple error records, you may 
> > need
> > to walk the bus to identify multiple simultaneous issues, very 
> > carefully
> > avoiding (or least minimizing) race conditions.
> >   
> > > The alternative is to have a separate walk for RCECs that loops 
> > > through
> > > the bitmap / ranges (if supported) triggering the callback for each
> > > device found.  
> 
> I’ve been testing the Associated Endpoint Bitmap and Bus Range 
> handling and using my pciutils patches to help to confirm some of the 
> association. This overlaps with my CXL work and CXL 1.1 based RCiEPs
> are good test cards:
> 
> (Decode via:  
> https://lore.kernel.org/linux-pci/20200624223940.240463-1-sean.v.kelley@linux.intel.com/
>  )
> 
> Test card at 6b:00.0
> 
> Capabilities: [e00 v1] Designated Vendor-Specific: Vendor=1e98 ID=0000
> Rev=0 Len=56: CXL
> CXLCap: Cache- IO+ Mem+ Mem HW Init+ HDMCount 1 Viral-
> CXLCtl: Cache- IO+ Mem- Cache SF Cov 0 Cache SF Gran 0 Cache Clean-
> Viral-
> CXLSta: Viral-
> Capabilities: [e38 v1] Device Serial Number 30-91-11-78-10-00-00-00
> 
> RCEC assocated to RCiEP at 6b while residing at 6a:
> 
> Capabilities: [160 v2] Root Complex Event Collector Endpoint
> Association
> RCiEPBitmap: 00000000 [none]
> AssociatedBusNumbers: 6b-6b
> Kernel driver in use: pcieport
> 
> with dmesg:
> 
> [ 10.502543] pcieport 0000:6a:00.4: AER: enabled with IRQ 34
> 
> The trick is the walk, which is not compact.  Currently working on
> error injection to test:
> 
> void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *,
> void *),
> +                   void *userdata)
> +{
> +       u32 pos, bitmap, hdr, busn;
> +       u8 ver, nextbusn, lastbusn;
> +       unsigned int dev, fn, bnr;
> +       struct pci_bus *pbus=NULL;
> +       struct pci_dev *pdev;
> +       int retval;
> +
> +       pos = pci_find_ext_capability(rcec, PCI_EXT_CAP_ID_RCEC);
> +       if (!pos)
> +               return;
> +
> +       pci_read_config_dword(rcec, pos + PCI_RCEC_RCIEP_BITMAP,
> &bitmap);
> +
> +       for (dev = 0; dev < 32; dev++) {

for_each_bit_set perhaps?

> +               if (!(bitmap & (1 << dev)))
> +                       continue;
> +
> +               for (fn = 0; fn < 8; fn++) {
> +                       pdev =
> pci_get_domain_bus_and_slot(pci_domain_nr(rcec->bus),
> +                                                          rcec->bus-
> >number,  
> +                                                          PCI_DEVFN(de
> v, fn));
> +                       if (!pdev)
> +                               continue;
> +
> +                       retval = cb(pdev, userdata);
> +                       if (retval)
> +                               return;
> +               }
> +       }
> 
> Then continuing in the same function above, I need to also consider the
> case for the Bus ranges (still wip, not tested):
> 
> +       pci_read_config_dword(rcec, pos, &hdr);
> +       ver = PCI_RCEC_EP_CAP_VER(hdr);
> +       if (ver < PCI_RCEC_BUSN_REG_VER)
> +               return;
> +
> +       pci_read_config_dword(rcec, pos + PCI_RCEC_BUSN, &busn);
> +       nextbusn = PCI_RCEC_BUSN_NEXT(busn);
> +       lastbusn = PCI_RCEC_BUSN_LAST(busn);
> +
> +       if ((nextbusn == 0xff) && (lastbusn == 0x00))
> +               return;
> +
> +       for (bnr = nextbusn; bnr < (lastbusn + 1); bnr++) {
> +               pbus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
> +               if (pbus) {
> +                       /* find RCiEP devices on the given bus */
> +                       for (dev = 0; dev < 32; dev++) {
> + etc...
> +                       }
> +               }
> +       }
> +}

Makes sense.

> 
> Currently this lives in aer.c and it's large enough that I wonder if
> due to the specifity of the assoicated spec requirments if that should
> be fine?

Seems fine to me.

> 
> > Agreed. We would end up with the same splitting of handling paths
> > that
> > wasn't liked in my v1 patch.   Perhaps we need  single 
> > pci_walk_aer_affected
> > function with a pile of documentation for what it is actually doing?  
> 
> Perhaps this would be a good start?  I tend to agree.  I can also
> submit more of the patches as RFC for further comment.

When you are ready that would be great.

> 
> > 
> > Even then we may need to have a parameter to indicate a particular 
> > callback
> > should be restricted to devices that share a 'real bus' or not.  
> 
> In my case 'walk' through the spec options of either just bitmap or if
> of sufficient version (2h), I walk through the bus ranges, calling the
> callback at each encounter.

That wasn't what I meant.  When doing some of the actual handling once
we have a walk function it will get a bit fiddly.
I 'think' we need to first identify which devices associated with the RCEC
have reported an AER error and then we need to only call the callback for
those.

In a case with a real bus and EP, the assumption is that the whole bus
is going down so you have to issue it to everyone.

> 
> > 
> > I guess the proof will as ever be in what the code looks like.  
> 
> Agreed.
> 
> > 
> > Hmm. It increasingly feels like we may need to have a go at drawing 
> > together
> > some coherent documentation for the different ways of handling
> > AER errors and specifications / assumptions for each.  Would be 
> > 'interesting'
> > to do given I'm fairly sure very few people actually understands all 
> > the options and
> > nasty corner cases!
> > 
> > +CC Lorenzo and James who may also be interested in this topic in 
> > general.  
> 
> Let's do.

Great.  Whilst we only care about this particular corner for now it may
be worth working out some more comprehensive docs covering standard topology
as well. CXL may bring its own additions, but I'm not sure we actually
have a clear description of what 'should' happen on normal PCIe.

Jonathan

> 
> Best regards,
> 
> Sean
> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> > > Thanks,
> > > 
> > > Sean
> > >   
> > > > > > Open questions:
> > > > > > 
> > > > > > 1. Are we better protecting against link reset for an RCiEP
> > > > > > in 
> > > > > > here
> > > > > > or
> > > > > >    should we put the check in the link reset functions?
> > > > > > 
> > > > > > 2. If we were to get a stupid firmware record with the
> > > > > > relevant
> > > > > > reset
> > > > > > flag
> > > > > >    set to trigger a link reset, what is the correct
> > > > > > response?  For
> > > > > > now
> > > > > > I
> > > > > >    try to report that we haven't done anything and print a 
> > > > > > warning.
> > > > > > 
> > > > > > 3. Naming of pci_walk_below_dev is rather unsatisfying. Any
> > > > > > better
> > > > > > ideas?
> > > > > > 
> > > > > > 4. pci_walk_below_dev is perhaps not of general utility.
> > > > > > Shall I
> > > > > > make
> > > > > > it local
> > > > > >    in err.c?  If not would a precursor patch for that be
> > > > > > preferred?’  
> > > > > 
> > > > > It depends.  Is it intended as a drop in replacement where
> > > > > needed 
> > > > > for
> > > > > pci_walk_bus()? So in that case you are now passing the dev 
> > > > > structure
> > > > > and do the check for subordinate or is it intended as being 
> > > > > specific
> > > > > to
> > > > > say RCEC? With AER, one could either first check for RC_EC type
> > > > > before
> > > > > using this one.  Or one could just drop in replace (passing the
> > > > > dev
> > > > > structure instead) and the call back performs the RCEC specific
> > > > > checks
> > > > > when a device is encountered.  
> > > > 
> > > > If it is useful in aer.c that's great.   Just seemed such a weird
> > > > beast
> > > > I wasn't sure it would be of use anywhere else.
> > > >   
> > > > > > Testing has been performed via error injection on a QEMU
> > > > > > platform 
> > > > > > as
> > > > > > that lets
> > > > > > me create a wide range of topologies and report errors at
> > > > > > any 
> > > > > > chosen
> > > > > > location.
> > > > > > Currently I have no plans to upstream this injection support,
> > > > > > but 
> > > > > > am
> > > > > > happy to
> > > > > > share if useful to others.  
> > > > > 
> > > > > I’m experimenting with it in my RCEC code in AER and will give 
> > > > > you
> > > > > additional feedback.  
> > > > 
> > > > Great, thanks
> > > > 
> > > > Jonathan
> > > >   
> > > > > Thanks,
> > > > > 
> > > > > Sean
> > > > > 
> > > > >   
> > > > > > [0] ACPI PCI Express Base Specification 4.0 1.3.2.3 Root
> > > > > > Complex
> > > > > > Integrated
> > > > > >     Endpoint Rules.
> > > > > > [1] ACPI PCI Express Base Specification 4.0 6.2 Error
> > > > > > Signalling 
> > > > > > and
> > > > > > Logging
> > > > > > [2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error 
> > > > > > Interface
> > > > > > (APEI)
> > > > > > [3] ACPI Sepcification 6.3 18.2.3.7 Generic Hardware Error
> > > > > > Source
> > > > > > [4] UEFI Specification 2.8, N.2.7 PCI Express Error Section
> > > > > > 
> > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > ---
> > > > > > Changes since v1:
> > > > > > * Separated from the largely unrelated fix so the two can
> > > > > > move
> > > > > > forwards separately.
> > > > > > * Instead of separate path for RCiEP handling use the method
> > > > > > suggested
> > > > > > by Bjorn
> > > > > >   and Sathyanarayanan with an adjusted pci_bus_walk.
> > > > > > 
> > > > > > Thanks all for reviews of V1.
> > > > > > 
> > > > > >  drivers/pci/bus.c      | 28 ++++++++++++++++++++++++++++
> > > > > >  drivers/pci/pcie/err.c | 29 +++++++++++++++++++----------
> > > > > >  include/linux/pci.h    |  2 ++
> > > > > >  3 files changed, 49 insertions(+), 10 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > > > > index 8e40b3e6da77..7cbe1ed2db3d 100644
> > > > > > --- a/drivers/pci/bus.c
> > > > > > +++ b/drivers/pci/bus.c
> > > > > > @@ -411,6 +411,34 @@ void pci_walk_bus(struct pci_bus *top,
> > > > > > int
> > > > > > (*cb)(struct pci_dev *, void *),
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(pci_walk_bus);
> > > > > > 
> > > > > > +/** pci_walk_below_dev - walk devices below (or on) another 
> > > > > > device
> > > > > > + *  @dev      device for which we should walk below,
> > > > > > include 
> > > > > > device
> > > > > > when not a port.
> > > > > > + *  @cb       callback to be called for each device found
> > > > > > + *  @userdata arbitrary pointer to be passed to callback.
> > > > > > + *
> > > > > > + *  If the device provided is a port,
> > > > > > + *  walk the subordinate bus, including any bridged devices
> > > > > > + *  on buses under this bus.  Call the provided callback
> > > > > > + *  on each device found.
> > > > > > + *
> > > > > > + *  If the device provided hs no subordinate bus, call the 
> > > > > > provided
> > > > > > + *  callback on the device itself.
> > > > > > + *
> > > > > > + */
> > > > > > +void pci_walk_below_dev(struct pci_dev *dev, int
> > > > > > (*cb)(struct
> > > > > > pci_dev
> > > > > > *, void *),
> > > > > > +			void *userdata)
> > > > > > +{
> > > > > > +	struct pci_bus *bus;
> > > > > > +
> > > > > > +	if (dev->subordinate) {
> > > > > > +		bus = dev->subordinate;
> > > > > > +		pci_walk_bus(bus, cb, userdata);
> > > > > > +	} else {
> > > > > > +		cb(dev, userdata);
> > > > > > +	}
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(pci_walk_below_dev);
> > > > > > +
> > > > > >  struct pci_bus *pci_bus_get(struct pci_bus *bus)
> > > > > >  {
> > > > > >  	if (bus)
> > > > > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > > > > index 14bb8f54723e..fa08b1cc3d96 100644
> > > > > > --- a/drivers/pci/pcie/err.c
> > > > > > +++ b/drivers/pci/pcie/err.c
> > > > > > @@ -151,33 +151,39 @@ pci_ers_result_t
> > > > > > pcie_do_recovery(struct
> > > > > > pci_dev
> > > > > > *dev,
> > > > > >  			pci_ers_result_t (*reset_link)(struct
> > > > > > pci_dev *pdev))
> > > > > >  {
> > > > > >  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> > > > > > -	struct pci_bus *bus;
> > > > > > 
> > > > > >  	/*
> > > > > >  	 * Error recovery runs on all subordinates of the
> > > > > > first 
> > > > > > downstream
> > > > > > port.
> > > > > >  	 * If the downstream port detected the error, it is
> > > > > > cleared at 
> > > > > > the
> > > > > > end.
> > > > > > +	 * For RCiEPs we should reset just the RCiEP itself.
> > > > > >  	 */
> > > > > >  	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > > > > > -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> > > > > > +	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> > > > > > +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END))
> > > > > >  		dev = dev->bus->self;
> > > > > > -	bus = dev->subordinate;
> > > > > > 
> > > > > >  	pci_dbg(dev, "broadcast error_detected message\n");
> > > > > >  	if (state == pci_channel_io_frozen) {
> > > > > > -		pci_walk_bus(bus, report_frozen_detected,
> > > > > > &status);
> > > > > > +		pci_walk_below_dev(dev, report_frozen_detected,
> > > > > > &status);
> > > > > > +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)
> > > > > > {
> > > > > > +			pci_warn(dev, "link reset not possible
> > > > > > for RCiEP\n");
> > > > > > +			status = PCI_ERS_RESULT_NONE;
> > > > > > +			goto failed;
> > > > > > +		}
> > > > > > +
> > > > > >  		status = reset_link(dev);
> > > > > >  		if (status != PCI_ERS_RESULT_RECOVERED) {
> > > > > >  			pci_warn(dev, "link reset failed\n");
> > > > > >  			goto failed;
> > > > > >  		}
> > > > > >  	} else {
> > > > > > -		pci_walk_bus(bus, report_normal_detected,
> > > > > > &status);
> > > > > > +		pci_walk_below_dev(dev, report_normal_detected,
> > > > > > &status);
> > > > > >  	}
> > > > > > 
> > > > > >  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> > > > > >  		status = PCI_ERS_RESULT_RECOVERED;
> > > > > >  		pci_dbg(dev, "broadcast mmio_enabled
> > > > > > message\n");
> > > > > > -		pci_walk_bus(bus, report_mmio_enabled,
> > > > > > &status);
> > > > > > +		pci_walk_below_dev(dev, report_mmio_enabled,
> > > > > > &status);
> > > > > >  	}
> > > > > > 
> > > > > >  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> > > > > > @@ -188,17 +194,20 @@ pci_ers_result_t
> > > > > > pcie_do_recovery(struct
> > > > > > pci_dev
> > > > > > *dev,
> > > > > >  		 */
> > > > > >  		status = PCI_ERS_RESULT_RECOVERED;
> > > > > >  		pci_dbg(dev, "broadcast slot_reset message\n");
> > > > > > -		pci_walk_bus(bus, report_slot_reset, &status);
> > > > > > +		pci_walk_below_dev(dev, report_slot_reset,
> > > > > > &status);
> > > > > >  	}
> > > > > > 
> > > > > >  	if (status != PCI_ERS_RESULT_RECOVERED)
> > > > > >  		goto failed;
> > > > > > 
> > > > > >  	pci_dbg(dev, "broadcast resume message\n");
> > > > > > -	pci_walk_bus(bus, report_resume, &status);
> > > > > > +	pci_walk_below_dev(dev, report_resume, &status);
> > > > > > 
> > > > > > -	pci_aer_clear_device_status(dev);
> > > > > > -	pci_aer_clear_nonfatal_status(dev);
> > > > > > +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > > > > > +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> > > > > > +		pci_aer_clear_device_status(dev);
> > > > > > +		pci_aer_clear_nonfatal_status(dev);
> > > > > > +	}
> > > > > >  	pci_info(dev, "device recovery successful\n");
> > > > > >  	return status;
> > > > > > 
> > > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > > index c79d83304e52..538bf0a76d33 100644
> > > > > > --- a/include/linux/pci.h
> > > > > > +++ b/include/linux/pci.h
> > > > > > @@ -1411,6 +1411,8 @@ int pci_scan_bridge(struct pci_bus
> > > > > > *bus,
> > > > > > struct
> > > > > > pci_dev *dev, int max,
> > > > > > 
> > > > > >  void pci_walk_bus(struct pci_bus *top, int (*cb)(struct
> > > > > > pci_dev 
> > > > > > *,
> > > > > > void *),
> > > > > >  		  void *userdata);
> > > > > > +void pci_walk_below_dev(struct pci_dev *dev, int
> > > > > > (*cb)(struct
> > > > > > pci_dev
> > > > > > *, void *),
> > > > > > +			void *userdata);
> > > > > >  int pci_cfg_space_size(struct pci_dev *dev);
> > > > > >  unsigned char pci_bus_max_busnr(struct pci_bus *bus);
> > > > > >  void pci_setup_bridge(struct pci_bus *bus);
> > > > > > -- 
> > > > > > 2.19.1  
> 


