Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536B039F9D7
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 17:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhFHPFI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 11:05:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:27817 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233740AbhFHPFI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 11:05:08 -0400
IronPort-SDR: gAWadqoGplPjs30rHZfjDz/Ko2kYOCn+KqrI5CD/0JtckIkNq1dTHZd6Jnt7T1nWE8dyGZXVgp
 0vyeQZrMl6NQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="268715549"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="268715549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:03:12 -0700
IronPort-SDR: y3fZ0dhtLYOOoYHwE2fTRtBYcPsDryJ10MroHcpiuGKZ7YNdq/fHYoj2itTRLY67StzWNIvDXz
 YuvcU0qbXQTQ==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="552305629"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:03:08 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Jun 2021 18:03:06 +0300
Date:   Tue, 8 Jun 2021 18:03:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mario Limonciello <mario.limonciello@outlook.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
Message-ID: <YL+Gqh9dT06SBLCx@lahna.fi.intel.com>
References: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
 <93d783c4-4468-023b-193e-3fc6eca35445@redhat.com>
 <a3c05e2f-af1c-ef19-4c9a-6b5b82d2da6d@redhat.com>
 <CAJZ5v0hYnEes7SDqwSqTGKQf4Qebr=gmj_qSQOPWKQzPdpAwrw@mail.gmail.com>
 <FR1PR80MB5051E91269FD36681BB357A7E1389@FR1PR80MB5051.lamprd80.prod.outlook.com>
 <YL5EjVDYLPhRKMIA@lahna.fi.intel.com>
 <209a230c-a7a6-7a8e-0515-97fb534d7401@redhat.com>
 <0f733402-ae3b-b4e7-13c4-e6161f9c7e81@redhat.com>
 <YL9YOlLosVeYfuuu@lahna.fi.intel.com>
 <edeba86c-1db7-e547-09a0-27da405155b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edeba86c-1db7-e547-09a0-27da405155b3@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On Tue, Jun 08, 2021 at 03:24:28PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/8/21 1:44 PM, Mika Westerberg wrote:
> > Hi,
> > 
> > On Tue, Jun 08, 2021 at 11:50:15AM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 6/7/21 9:18 PM, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 6/7/21 6:08 PM, Mika Westerberg wrote:
> >>>> Hi,
> >>>>
> >>>> Tried now on ADL-P and TGL systems and the _OSC still works properly.
> >>>>
> >>>> Thanks Hans for fixing!
> >>>>
> >>>> Feel free to add my Tested-by.
> >>>
> >>> Thank you for testing, unfortunately so far from the comments here:
> >>>
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=213023
> >>>
> >>> it seems that my patch does not help resolve the issues caused
> >>> by commit 719e1f561afb ("ACPI: Execute platform _OSC also with query
> >>> bit clear"), where as reverting that commit does resolve them :|
> >>>
> >>> Does anyone have any other ideas how to fix this ?
> >>
> >> The reporter who has done the bisect has commented out the new/second
> >> _OSC call and that fixes things for them. So I've written a new fix
> >> (attached), note just as before this is untested ATM.
> >>
> >> Mika, if you can test this one (it replaces the previous one)
> >> on machines with native USB4 support to check those don't regress then
> >> that would be great.
> > 
> > I can test it sure, but first let's try to understand what the problem is :)
> > 
> >> I've asked the various reporters from the 2 bugzilla's for this to also
> >> test this new patch. I'll let you know how that goes.
> > 
> > The _OSC on at least one of the affected platforms look like this:
> > 
> >     If ((Arg0 == ToUUID ("0811b06e-4a27-44f9-8d60-3cbbc22e7b48") /* Platform-wide Capabilities */))
> >     {
> > 	If ((Arg1 == One))
> > 	{
> > 	    OSCP = CAP0 /* \_SB_._OSC.CAP0 */
> > 	    If ((CAP0 & 0x04))
> > 	    {
> > 		OSCO = 0x04
> > 		If (((SGMD & 0x0F) != 0x02))
> > 		{
> > 		    If ((RTD3 == Zero))
> > 		    {
> > 			CAP0 &= 0x3B
> > 			STS0 |= 0x10
> > 		    }
> > 		}
> > 	    }
> > 	}
> > 	Else
> > 	{
> > 	    STS0 &= 0xFFFFFF00
> > 	    STS0 |= 0x0A
> > 	}
> >     }
> >     Else
> >     {
> > 	STS0 &= 0xFFFFFF00
> > 	STS0 |= 0x06
> >     }
> > 
> > Probably it is fine to call it several times but the issue is with the mask
> > that it does:
> > 
> >     CAP0 &= 0x3B
> > 
> > This clears out the upper bits. I think this is actually a BIOS bug as it ends
> > up clearing OSC_SB_PCLPI_SUPPORT which is probably not intented, and that seems
> > to cause skipping of the LPI tables or something like that.
> > 
> > The alternative is to pass the original caps to the second _OSC call. I think
> > this is safe too. While looking at the code, I found a couple of other issues
> > that should be fixed with the below hack patch.
> > 
> > What do you think about this approach?
> 
> I think you might be on to something, quoting from the spec:
> 
> """
> 6.2.11.1.3 Sequence of _OSC calls
> The following rules govern sequences of calls to _OSC that are issued to the same host bridge and
> occur within the same boot.
> • The OS is permitted to evaluate _OSC an arbitrary number of times.
> • If the OS declares support of a feature in the Status Field in one call to _OSC, then it must
> preserve the set state of that bit (declaring support for that feature) in all subsequent calls.
> • If the OS is granted control of a feature in the Control Field in one call to _OSC, then it must
> preserve the set state of that bit (requesting that feature) in all subsequent calls.
> """
> 
> So the spec is saying that we should indeed keep all the flags which set during
> the first call also set during subsequent calls.
> 
> If you can turn this into a proper patch then I can ask the reporters of
> the 2 bugs to test that patch.

Sure I will. First I think I figured why this happens. The BIOS loads the HWP
tables dynamically (in ssdt9.dsl) like this:

\_PR.PRxx.GCAP():

            If ((OSYS >= 0x07DF))
            {   
                If (((CFGD & 0x00400000) && !(SDTL & 0x40)))
                {   
                    If ((\_SB.OSCP & 0x40))
                    {   
                        SDTL |= 0x40
                        OperationRegion (HWP0, SystemMemory, DerefOf (SSDT [0x0D]), DerefOf (SSDT [0x0E]))
                        Load (HWP0, HW0) /* \_PR_.PR00.HW0_ */
                        If ((CFGD & 0x00800000))
                        {   
                            OperationRegion (HWPL, SystemMemory, DerefOf (SSDT [0x13]), DerefOf (SSDT [0x14]))
                            Load (HWPL, HW2) /* \_PR_.PR00.HW2_ */
                        }
                    }


Note it checks the \_SB.OSCP which is set in _OSC to the value of the "support"
buffer that Linux populates. However, in _OSC it also clears that particular
bit (when RTD3 is set to 0):

	CAP0 &= 0x3B
	STS0 |= 0x10

Since Linux calls the _OSC again with the cleared bit the \_SB.OSCP also does
not have that bit set anymore and that makes GCAP() to skip the Load()
operation resulting the errors users have reported.

This looks like that the BIOS expects the same set of "support" bits to be set
on each call, or alternatively it only expects the _OSC to be run once.

In any case, I will make a proper patch soon with the above added to the commit log too.
