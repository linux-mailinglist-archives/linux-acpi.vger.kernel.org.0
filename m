Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2B16F051
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 21:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgBYUm1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 15:42:27 -0500
Received: from foss.arm.com ([217.140.110.172]:55530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbgBYUm1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Feb 2020 15:42:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12FB31B;
        Tue, 25 Feb 2020 12:42:26 -0800 (PST)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C0783F534;
        Tue, 25 Feb 2020 12:42:26 -0800 (PST)
Subject: Re: [EXT] Re: [PATCH v1 1/7] mdio_bus: Introduce fwnode MDIO helpers
To:     Calvin Johnson <calvin.johnson@oss.nxp.com>,
        "linux.cj@gmail.com" <linux.cj@gmail.com>,
        Jon Nettleton <jon@solid-run.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "Rajesh V. Bikkina" <rajesh.bikkina@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Cc:     linux-acpi@vger.kernel.org, Al Stone <ahs3@redhat.com>
References: <20200131153440.20870-1-calvin.johnson@nxp.com>
 <20200131153440.20870-2-calvin.johnson@nxp.com>
 <371ff9b4-4de6-7a03-90f8-a1eae4d5402d@arm.com>
 <AM0PR04MB56366808BA5C841E4E7BC86E931C0@AM0PR04MB5636.eurprd04.prod.outlook.com>
 <20200225101240.GA8966@lsv03152.swis.in-blr01.nxp.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <1e97119b-1073-33cc-2d53-622b7c17070a@arm.com>
Date:   Tue, 25 Feb 2020 14:42:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225101240.GA8966@lsv03152.swis.in-blr01.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,


On 2/25/20 4:12 AM, Calvin Johnson wrote:
> On Fri, Feb 07, 2020 at 09:42:56AM +0000, Calvin Johnson (OSS) wrote:
> Hi Jeremy,
> 
>   
>>> -----Original Message-----
>>> From: Jeremy Linton <jeremy.linton@arm.com>
>>> Sent: Wednesday, February 5, 2020 7:48 PM
>>
>> <snip>
>>
>>>> +static int fwnode_mdio_parse_addr(struct device *dev,
>>>> +                               const struct fwnode_handle *fwnode) {
>>>> +     u32 addr;
>>>> +     int ret;
>>>> +
>>>> +     ret = fwnode_property_read_u32(fwnode, "reg", &addr);
>>>> +     if (ret < 0) {
>>>> +             dev_err(dev, "PHY node has no 'reg' property\n");
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     /* A PHY must have a reg property in the range [0-31] */
>>>> +     if (addr < 0 || addr >= PHY_MAX_ADDR) {
>>>> +             dev_err(dev, "PHY address %i is invalid\n", addr);
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>>> +     return addr;
>>>> +}
>>>
>>> Almost assuredly this is wrong, the _ADR method exists to identify a device
>>> on its parent bus. The DT reg property shouldn't be used like this in an ACPI
>>> environment.
> 
> In the ACPI environment, can we use _ADR to get the PHY device address
> from the DSDT? Is there any function to get this value?

It appears most of the callers are using acpi_evaluate_integer().

> acpi_ut_evaluate_numeric_object is called from inside drivers/acpi/acpica.
> However, I don't see any other driver outside drivers/acpi using _ADR to get
> the address.

Its really only useful for "buses with standard enumeration functions", 
so you wouldn't see it being used in device drivers, only bus drivers. 
As such, mfd_acpi_add_device() is an example that lives outside the 
drivers/acpi directory although I think the pci bits in the drivers/acpi 
might be a better example.

> 
>>>
>>> Further, there are a number of other dt bindings in this set that seem
>>> inappropriate in common/shared ACPI code paths. That is because AFAIK the
>>> _DSD methods are there to provide device implementation specific
>>> behaviors, not as standardized methods for a generic classes of devices.
>>> Its vaguely the equivalent of the "vendor,xxxx" properties in DT.
>>>
>>> This has been a discussion point on/off for a while with any attempt to
>>> publicly specify/standardize for all OS vendors what they might find encoded
>>> in a DSD property. The few year old "WORK_IN_PROGRESS" link on the uefi
>>> page has a few suggested ones
>>>
>>> https://uefi.org/sites/default/files/resources/nic-request-v2.pdf
> 
> Having this as part of spec would be helpful.
> Do you know who can help get this nic-request integrated into spec?

+Al Stone, who looked at this a while back, may be able to shed more 
light. But again, standardization of Device Specific Data (DSD) 
properties is a bit odd.

> 
>>>
>>> Anyway, the use of phy-handle with a reference to the phy device on a
>>> shared MDIO is a technically workable solution to the problem brought up in
>>> the RPI/ACPI thread as well. OTOH, it suffers from the use of DSD and at a
>>> minimum should probably be added to the document linked above if its
>>> found to be the best way to handle this. Although, in the common case of a
>>> mdio bus, matching acpi described devices with their discovered
>>> counterparts (note the device() definition in the spec
>>> 19.6.30) only to define DSD references is a bit overkill.
>>>
>>> Put another way, while seemingly not necessary if a bus can be probed, a
>>> nic/device->mdio->phy can be described in the normal ACPI hierarchy with
>>> only appropriately nested CRS and ADR resources. Its the shared nature of the
>>> MDIO bus that causes problems.
> 
> Were you able to take a look at the shared DSDT tables? Is this the ACPI hierarchy
> with nested CRS and ADR resources which you mentioned above?

>> https://source.codeaurora.org/external/qoriq/qoriq-components/edk2-platforms/tree/Platform/NXP/LX2160aRdbPkg/AcpiTables/Dsdt/Mdio.asl?h=LX2160_UEFI_ACPI_EAR1
>> https://source.codeaurora.org/external/qoriq/qoriq-components/edk2-platforms/tree/Platform/NXP/LX2160aRdbPkg/AcpiTables/Dsdt/Mc.asl?h=LX2160_UEFI_ACPI_EAR1
> 
> Thanks
> Calvin
> 

