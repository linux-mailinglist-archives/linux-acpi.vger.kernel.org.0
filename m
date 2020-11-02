Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8332A3251
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 18:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgKBRxs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 12:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbgKBRxr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2020 12:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604339625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jbDjjKhbn/CeKz9vwEfJGyUWdP2/xRCz/gMfQtrHdY0=;
        b=J23hERzY/1eF5i1VodmRPH8rczSqp9wV0vpdPg/xRCidb9IA52q0cseG5A23XtcTNJ79yL
        PTADCP9lgaDnm2IYpjd+IRRoB/AQAIKX8MfUpiUfXu1uyIVLsnT0fbizfVurG6smD+sabz
        B1cw+Z644lTzn1uY7Gy+NKof/1GNy+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-QZZMNBYBOrKVXiq4zv3hPw-1; Mon, 02 Nov 2020 12:53:40 -0500
X-MC-Unique: QZZMNBYBOrKVXiq4zv3hPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9088100CD1F;
        Mon,  2 Nov 2020 17:53:38 +0000 (UTC)
Received: from [10.36.113.163] (ovpn-113-163.ams2.redhat.com [10.36.113.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 062E31002393;
        Mon,  2 Nov 2020 17:53:32 +0000 (UTC)
Subject: Re: Onlining CXL Type2 device coherent memory
To:     Vikram Sethi <vsethi@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
 <451b2571-c3e8-97d8-bfd0-f8054a1b75c5@redhat.com>
 <CAPcyv4jX1tedjuU-vCSKgvhQeNFukyq9d0ddmsk7jAjWMX+iBQ@mail.gmail.com>
 <958912b2-1436-378f-43d7-cbc5c8955ffd@redhat.com>
 <BL0PR12MB2532D78BF9E62E141AED5EADBD100@BL0PR12MB2532.namprd12.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2f9fa312-e080-d995-eb82-1ac9e6128a33@redhat.com>
Date:   Mon, 2 Nov 2020 18:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BL0PR12MB2532D78BF9E62E141AED5EADBD100@BL0PR12MB2532.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 02.11.20 17:17, Vikram Sethi wrote:
> Hi David,
>> From: David Hildenbrand <david@redhat.com>
>> On 31.10.20 17:51, Dan Williams wrote:
>>> On Sat, Oct 31, 2020 at 3:21 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 30.10.20 21:37, Dan Williams wrote:
>>>>> On Wed, Oct 28, 2020 at 4:06 PM Vikram Sethi <vsethi@nvidia.com> wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> I wanted to kick off a discussion on how Linux onlining of CXL [1] type 2
>> device
>>>>>> Coherent memory aka Host managed device memory (HDM) will work for
>> type 2 CXL
>>>>>> devices which are available/plugged in at boot. A type 2 CXL device can be
>> simply
>>>>>> thought of as an accelerator with coherent device memory, that also has a
>>>>>> CXL.cache to cache system memory.
>>>>>>
>>>>>> One could envision that BIOS/UEFI could expose the HDM in EFI memory map
>>>>>> as conventional memory as well as in ACPI SRAT/SLIT/HMAT. However, at
>> least
>>>>>> on some architectures (arm64) EFI conventional memory available at kernel
>> boot
>>>>>> memory cannot be offlined, so this may not be suitable on all architectures.
>>>>>
>>>>> That seems an odd restriction. Add David, linux-mm, and linux-acpi as
>>>>> they might be interested / have comments on this restriction as well.
>>>>>
>>>>
>>>> I am missing some important details.
>>>>
>>>> a) What happens after offlining? Will the memory be remove_memory()'ed?
>>>> Will the device get physically unplugged?
>>>>
> Not always IMO. If the device was getting reset, the HDM memory is going to be
> unavailable while device is reset. Offlining the memory around the reset would

Ouch, that speaks IMHO completely against exposing it as System RAM as 
default.

> be sufficient, but depending if driver had done the add_memory in probe,
> it perhaps would be onerous to have to remove_memory as well before reset,
> and then add it back after reset. I realize you’re saying such a procedure
> would be abusing hotplug framework, and we could perhaps require that memory
> be removed prior to reset, but not clear to me that it *must* be removed for
> correctness.
> 
> Another usecase of offlining without removing HDM could be around
> Virtualization/passing entire device with its memory to a VM. If device was
> being used in the host kernel, and is then unbound, and bound to vfio-pci
> (vfio-cxl?), would we expect vfio-pci to add_memory_driver_managed?

At least for passing through memory to VMs (via KVM), you don't actually 
need struct pages / memory exposed to the buddy via 
add_memory_driver_managed(). Actually, doing that sounds like the wrong 
approach.

E.g., you would "allocate" the memory via devdax/dax_hmat and directly 
map the resulting device into guest address space. At least that's what 
some people are doing with

-- 
Thanks,

David / dhildenb

