Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8242E1CBB99
	for <lists+linux-acpi@lfdr.de>; Sat,  9 May 2020 02:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEIALe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 May 2020 20:11:34 -0400
Received: from foss.arm.com ([217.140.110.172]:54032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgEIALe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 May 2020 20:11:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCB73D6E;
        Fri,  8 May 2020 17:11:33 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3D893F68F;
        Fri,  8 May 2020 17:11:32 -0700 (PDT)
Subject: Re: [net-next PATCH v3 4/5] net: phy: Introduce fwnode_get_phy_id()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux.cj@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Florin Laurentiu Chiculita <florinlaurentiu.chiculita@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        "Rajesh V . Bikkina" <rajesh.bikkina@nxp.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        netdev <netdev@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20200505132905.10276-1-calvin.johnson@oss.nxp.com>
 <20200505132905.10276-5-calvin.johnson@oss.nxp.com>
 <67e263cf-5cd7-98d1-56ff-ebd9ac2265b6@arm.com>
 <CAHp75Vew8Fh6HEoOACk+J9KCpw+AE2t2+oFnXteK1eShopfYAA@mail.gmail.com>
 <83ab4ca4-9c34-4cdd-4413-3b4cdf96727d@arm.com>
 <20200508160755.GB10296@lsv03152.swis.in-blr01.nxp.com>
 <20200508181301.GF298574@lunn.ch>
 <1e33605e-42fd-baf8-7584-e8fcd5ca6fd3@arm.com>
 <20200508202722.GI298574@lunn.ch>
 <97a9e145-bbaa-efb8-6215-dc3109ee7290@arm.com>
 <20200508234257.GA338317@lunn.ch>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <8e67dd6c-e83d-d366-9799-940708e6ae3d@arm.com>
Date:   Fri, 8 May 2020 19:11:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508234257.GA338317@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/8/20 6:42 PM, Andrew Lunn wrote:
> On Fri, May 08, 2020 at 05:48:33PM -0500, Jeremy Linton wrote:
>> Hi,
>>
>> On 5/8/20 3:27 PM, Andrew Lunn wrote:
>>>>> There is a very small number of devices where the vendor messed up,
>>>>> and did not put valid contents in the ID registers. In such cases, we
>>>>> can read the IDs from device tree. These are then used in exactly the
>>>>> same way as if they were read from the device.
>>>>>
>>>>
>>>> Is that the case here?
>>>
>>> Sorry, I don't understand the question?
>>
>> I was asking in general, does this machine report the ID's correctly.
> 
> Very likely, it does.
> 
>> The embedded single mac:mdio per nic case seems like the normal case, and
>> most of the existing ACPI described devices are setup that way.
> 
> Somebody in this thread pointed to ACPI patches for the
> MACCHIATOBin. If i remember the hardware correctly, it has 4 Ethernet
> interfaces, and two MDIO bus masters. One of the bus masters can only
> do C22 and the other can only do C45. It is expected that the busses
> are shared, not a nice one to one mapping.

Thats whats going on with the NXP too AFAIK. But the mcbin is one of the 
ones with the "compatible" embedded in the DSD properties.. AKA, they 
buried the entire DT node there.

> 
>> But at the same time, that shifts the c22/45 question to the nic
>> driver, where use of a DSD property before instantiating/probing
>> MDIO isn't really a problem if needed.
> 
> This in fact does not help you. The MAC driver has no idea what PHY is
> connected to it. The MAC does not know if it is C22 or C45. It uses
Thats all I was trying to say (the mac side capability is implied by the 
HID/CID that instantiates it).

> the phylib abstraction which hides all this. Even if you assume 1:1,
> use phy_find_first(), it will not find a C45 PHY because without
> knowing there is a C45 PHY, we don't scan for it. And we should expect
> C45 PHYs to become more popular in the next few years.
> 
>> In fact this embedded nic/mac/mdio/phy 1:1:1 case, is likely a requirement
>> for passthrough into a generic VM, otherwise someone has to create a virtual
>> mdio, and pass the phy in for the nic/mac.
>>
>> AFAIK, NXP's part avoids this despite having a shared MDIO, because the phy
>> state never leaves the mgmt side of the picture. It monitors the state and
>> then feeds that back into their nic mgmt complex rather than using it
>> directly.
> 
> That is the other model. Don't use Linux to drive the PHY, use
> firmware in the MAC. A number of MACs do that, but it has the usual
> problems of firmware. It limits you on your choice of PHYs, bugs in
> the firmware cannot be fixed by the community, no sharing of drivers
> because firmware is generally proprietary, no 'for free features'
> because somebody else added features to the linux PHY driver etc.  But
> it will make ACPI support simple, this whole discussion goes away, no
> ACPI needed at all.

Open source firmware! :)
