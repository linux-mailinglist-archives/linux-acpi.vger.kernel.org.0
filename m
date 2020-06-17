Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B751FD68A
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jun 2020 22:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgFQU5J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Jun 2020 16:57:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:21681 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgFQU5J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Jun 2020 16:57:09 -0400
IronPort-SDR: kIIpwWMx0wSOJBiajSHkOUU3DuqSBPJVo9HzVRNfvu5guIrKXALonUX+7NzhDucAG/bVlxj5N4
 7M0TbS0mBhjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 13:57:08 -0700
IronPort-SDR: 3LdJdG29Xe/CBVUDrzZ8Nj90xmYIraC750Xiz9tIQx+WyBEymLYnP+PbkGo/g6/nnvFpRjbnL+
 HPkV2auF8oPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="421269938"
Received: from dbalber-mobl.amr.corp.intel.com (HELO [10.254.72.151]) ([10.254.72.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Jun 2020 13:57:08 -0700
Subject: Re: [PATCH 1/2] PCI/AER: Do not reset the device status if doing
 firmware first handling.
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20200616174731.GA1969609@bjorn-Precision-5520>
 <110fa7a9-1147-b755-2958-6f40c5d666a2@linux.intel.com>
 <20200617103120.00006dcd@Huawei.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <56b9434a-2586-2321-49cb-9d205218fbe8@linux.intel.com>
Date:   Wed, 17 Jun 2020 13:57:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617103120.00006dcd@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/17/20 2:31 AM, Jonathan Cameron wrote:
> On Tue, 16 Jun 2020 11:00:32 -0700
> "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 6/16/20 10:47 AM, Bjorn Helgaas wrote:
>>> [+cc Sathy]
>>>
>>> On Fri, May 22, 2020 at 01:31:33AM +0800, Jonathan Cameron wrote:
>>>> pci_aer_clear_device_status() currently resets the device status even when
>>>> firmware first handling is going on.  In particular it resets it on the
>>>> root port.
>>>>
>>>> This has been discussed previously
>>>> https://lore.kernel.org/patchwork/patch/427375/.
>> pci_aer_clear_device_status() is only used by handle_error_source(). And
>> I don't think handle_error_source() is called in FF mode. Can you
>> give more details on this issue ?
> 
> It's called in pcie_do_recovery
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/pci/pcie/err.c#L200
> 
> Which is called from both handle_error_source and aer_recover_work_func.
> 
> indirectly called from ghes_handle_aer / ghes_do_proc
> 
> This particular flow will only happen (I think) on hardware reduced ACPI systems.
Ok. Makes sense.
> 
> Jonathan
> 
>>>
>>> I don't think this reference is really pertinent, is it?  That patch
>>> to b2c8881da764 changes pci_cleanup_aer_uncorrect_error_status() so it
>>> doesn't clear PCI_ERR_UNCOR_STATUS in "firmware-first" mode.
>>>
>>> But your patch only affects PCI_EXP_DEVSTA, not PCI_ERR_UNCOR_STATUS.
>>>    
>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>    drivers/pci/pcie/aer.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index f4274d301235..43e78b97ace6 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -373,6 +373,9 @@ void pci_aer_clear_device_status(struct pci_dev *dev)
>>>>    {
>>>>    	u16 sta;
>>>>    
>>>> +	if (pcie_aer_get_firmware_first(dev))
use if (!pcie_aer_is_native(dev))
>>>> +		return;
>>>
>>> This needs to be adjusted because pcie_aer_get_firmware_first() no
>>> longer exists after 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
>>> parsing for AER ownership").
>>>
>>> This will use the _OSC AER ownership bit to gate clearing of the
>>> status bits in the PCIe capability (not the AER capability).
>>>
>>> I think that's the right thing to do, but it's certainly not obvious
>>> from the _OSC description in the PCI Firmware Spec r3.2.  I think we
>>> need a pointer to the ECN that clarifies this, i.e., sec 4.5.1 of:
>>>
>>>     System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
>>>     2020, affecting PCI Firmware Specification, Rev. 3.2
>>>     https://members.pcisig.com/wg/PCI-SIG/document/14076
>>>    
>>>>    	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>>>>    	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>>>>    }
>>>> -- 
>>>> 2.19.1
>>>>   
>>
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
