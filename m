Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7757E2B7C10
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Nov 2020 12:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgKRLFp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 18 Nov 2020 06:05:45 -0500
Received: from thoth.sbs.de ([192.35.17.2]:59451 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKRLFo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Nov 2020 06:05:44 -0500
X-Greylist: delayed 3651 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 06:05:43 EST
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 0AIA4Opg011392
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 11:04:24 +0100
Received: from md1za8fc.ad001.siemens.net ([167.87.8.227])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AIA4MAe026664;
        Wed, 18 Nov 2020 11:04:22 +0100
Date:   Wed, 18 Nov 2020 11:04:21 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "johannes-hahn@siemens.com" <johannes-hahn@siemens.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Simon Glass <sjg@chromium.org>,
        Simon Glass <sjg@google.com>,
        "val.krutov@erd.epson.com" <val.krutov@erd.epson.com>,
        Claudius Heine <ch@denx.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "werner.zeh@siemens.com" <werner.zeh@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "martin.mantel@siemens.com" <martin.mantel@siemens.com>
Subject: Re: [PATCH v2 2/3] rtc: rx6110: add ACPI bindings to I2C
Message-ID: <20201118110421.65679ade@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75VfkHgaaFUN9Nw4sVVsLxzky0=-dAgAmmG+EkF8xV7Na5A@mail.gmail.com>
References: <20201112130734.331094-1-ch@denx.de>
        <20201112130734.331094-3-ch@denx.de>
        <20201116144631.GB1689012@smile.fi.intel.com>
        <20201116163024.74c767b6@md1za8fc.ad001.siemens.net>
        <AM0PR10MB3169089EF445E785C363A0B4E7E20@AM0PR10MB3169.EURPRD10.PROD.OUTLOOK.COM>
        <CAHp75Vdxj0tgn6P8Nfi5mMd=e9Q1+hzt4bquzB93zg0vOeMopw@mail.gmail.com>
        <CAHp75VfkHgaaFUN9Nw4sVVsLxzky0=-dAgAmmG+EkF8xV7Na5A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We are trying to reach out to Epson to find valid IDs, but will do that
off-list for now.

In the meantime we will propose just the I2C patches, without ACPI.

We have Werner Zeh here, who pushed the coreboot change. In coreboot
nobody objected, maybe they have not been aware of the processes or it
was missed in their review.

Werner i think the coreboot change should be reverted so it does not
enter a release and will become legacy that needs to be supported. Let
us revisit it once we have the proper IDs. If that fails we have to
look into the other options that Andy proposed. There is no point
having the coreboot support without the Linux-user ... 

regards,
Henning

Am Tue, 17 Nov 2020 13:41:08 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> +Cc: Simon
> 
> Simon, this is an issue with ACPI IDs and I think JFYI would be an
> interesting topic since this may happen in the future in U-Boot or
> other projects. Also, you may know people from coreboot to figure out
> what to do with this case and how to prevent something similar from
> happening in the future.
> 
> On Tue, Nov 17, 2020 at 1:33 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Nov 17, 2020 at 11:51 AM johannes-hahn@siemens.com
> > <johannes-hahn@siemens.com> wrote:  
> > >
> > > Hello Val,
> > >
> > > my name is Johannes Hahn from Siemens AG in Germany.
> > > Our product Open Controller II (OCII)[1] uses the Realtime Clock
> > > RX6110SA from SEIKO EPSON.  
> >
> > Nice to hear from you!
> >  
> > > Currently there is a merge request ongoing for the Linux Kernel
> > > master branch[2] which adds I²C and ACPI support to your original
> > > driver implementation.
> > >
> > > Simultaneously there is an already merged patch-set for
> > > coreboot[3] available creating the ACPI (SSDT) table entries for
> > > the RX6110SA.  
> >
> > Thanks for pointers, I commented there. The ACPI ID change must be
> > reverted! 
> > > The OCII uses coreboot for firmware initialization.
> > >
> > > During the merge request the eligible objection arose that the
> > > ACPI ID used in the Linux driver patch is not conforming the ACPI
> > > Specification. Indeed it does not. But when searching for a
> > > product identifier of RX6110SA I was not able to find a
> > > sufficient one with respect to the ACPI Specification (see [4]
> > > chapter 6.1.5 _HID (Hardware ID),[5]).  
> >
> > Unfortunately many vendors, even being registered in the ACPI/PNP
> > registry, are still neglecting the process.
> >  
> > > According to the fact that there are other Linux RTC drivers on
> > > the Kernel mainline[6] which support ACPI matching that also do
> > > not have ACPI Specification compatible IDs we used that as an
> > > example for our first patch attempt.  
> >
> > I answered this in previous mail.
> >  
> > > A PNP ID for SEIKO EPSON is already registered at UEFI
> > > database[7].
> > >
> > > What I kindly ask your for is an ACPI Specification conforming
> > > Product Identifier for the RX6110SA RTC ? According to [5] this
> > > Product Identifier should be "... always four-character
> > > hexadecimal numbers (0-9 and A-F)".
> > >
> > > In case you do not know it our can not acquire/create one could
> > > you please redirect me to someone from SEIKO EPSON who can help
> > > me with that demand ?  
> >
> > So, to be on the constructive page (I thought initially you are
> > from G company, but anyway) you may do the following:
> >
> > - (for prototyping only) you may use the PRP0001 approach,
> > described in [8]
> > - you may issue an ID under your (Siemens) vendor ID
> > - you may insist G company to issue the ID under their vendor space
> > (thru coreboot)
> > - (the best option) to communicate to Seiko Epson to get official ID
> > from them for this component (and ID mustn't abuse 6.1.5)
> >
> > Unfortunately I have no contacts there, but I think the best effort
> > is to contact their support and at the same time ask ASWG [9] how to
> > proceed. I Cc'ed this to ACPI people in Linux kernel, maybe they can
> > help.
> >
> > Of course you have choice to push bad ID forward and use precedence
> > (like many other companies, even Intel in past, do with firmwares
> > and Linux kernel is full of badly formed IDs), but since the change
> > is not existed in read devices I would really like to see proper
> > process to be followed.
> >
> > In the Linux kernel I'm in principle trying to prevent bad IDs from
> > happening as much as I can.
> >  
> > > [1]:
> > > (https://mall.industry.siemens.com/mall/en/WW/Catalog/Product/6ES7677-2DB42-0GB0)
> > > [2]: https://lkml.org/lkml/2020/11/12/561 [3]:
> > > https://review.coreboot.org/c/coreboot/+/47235 [4]:
> > > https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> > > [5]: https://www.uefi.org/PNP_ACPI_Registry [6]:
> > > https://elixir.bootlin.com/linux/latest/source/drivers/rtc/rtc-ds1307.c#L1142
> > > [7]: https://www.uefi.org/PNP_ID_List?search=SEIKO+EPSON  
> >
> > [8]:
> > https://elixir.bootlin.com/linux/latest/source/Documentation/firmware-guide/acpi/enumeration.rst
> > [9]: https://www.uefi.org/workinggroups 
> > > > Before adding new ACPI ID, can you provide an evidence (either
> > > > from vendor of the component, or a real snapshot of DSDT from
> > > > device on market) that this is real ID?
> > > >
> > > > Before that happens, NAK.
> > > >
> > > > P.S. Seems to me that this is kinda cargo cult patch because
> > > > proposed ID is against ACPI and PNP registry and ACPI
> > > > specification.  
> > >
> > > In fact we pushed it in coreboot and Linux at the same time.
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Freview.coreboot.org%2Fc%2Fcoreboot%2F%2B%2F47235&amp;data=04%7C01%7Cjohannes-hahn%40siemens.com%7C21c9e1fe99274df7951a08d88a448af5%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637411374276831534%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7EVdO%2F77LNyvux0y3m9nEf2HZO%2BDm2WkWMfxzaJUoto%3D&amp;reserved=0
> > >
> > > That is the evidence. But in case this is wrong we can probably
> > > still change coreboot, even though the patches have been merged
> > > there already.
> > >
> > > Maybe you can go into detail where you see the violations and
> > > maybe even suggest fixes that come to mind.  
> >
> > --
> > With Best Regards,
> > Andy Shevchenko  
> 
> 
> 

