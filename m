Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0AA28D117
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Oct 2020 17:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389233AbgJMPSM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Oct 2020 11:18:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:17834 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389037AbgJMPSL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Oct 2020 11:18:11 -0400
IronPort-SDR: j4tCWTFkZFIJdONyoSK3Tl0h4V3nqtMt/voAor1OpHD4WOU/0j92Xbm+c9Pomj9Dz6GDjvJ3Tq
 rPXRbrTRiHmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="183410001"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="183410001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 08:17:54 -0700
IronPort-SDR: 536CS6GdxDtd9/xQPjkz6Ts0KhJ596SAsKwVEUc5cSdeKRlVHcgzIZDNG2N8zDOYh2NvdFwDF4
 YXQmh3M+gkfA==
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="463523063"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.131.190]) ([10.249.131.190])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 08:17:52 -0700
Subject: Re: i8042_init: PS/2 mouse not detected with ACPIPnP/PnPBIOS
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <1a69c5bc-ccc4-68db-7871-af05a70052c9@molgen.mpg.de>
 <20201007221628.GW1009802@dtor-ws>
 <bbb70981-1242-0aea-01c9-f9507f8eae3b@molgen.mpg.de>
 <CAJZ5v0hKmESo0-kfN1+vK7to05GpVV3d7ZnO3XEsQ2jKKhvkJQ@mail.gmail.com>
 <7921b792-c99a-659c-730f-ecb25cb7f04b@molgen.mpg.de>
 <CAJZ5v0iim_XvBcjSZevEmbQb6F8bCb2jP14Ptnqd_7qfuuUHpw@mail.gmail.com>
 <082dfba3-6187-7081-6a8c-8c38a3a95b19@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <48973620-21a8-7fef-8c99-e59c38941145@intel.com>
Date:   Tue, 13 Oct 2020 17:17:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <082dfba3-6187-7081-6a8c-8c38a3a95b19@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/13/2020 5:00 PM, Paul Menzel wrote:
> Dear Rafael, dear Dmitry,
>
>
> Am 12.10.20 um 13:00 schrieb Rafael J. Wysocki:
>> On Mon, Oct 12, 2020 at 12:50 PM Paul Menzel wrote:
>
>>> Am 12.10.20 um 12:39 schrieb Rafael J. Wysocki:
>>>> On Sun, Oct 11, 2020 at 1:08 AM Paul Menzel wrote:
>
>>>>> Am 08.10.20 um 00:16 schrieb Dmitry Torokhov:
>>>>>
>>>>>> On Wed, Oct 07, 2020 at 11:18:41PM +0200, Paul Menzel wrote:
>>>>>
>>>>>>> On the Asus F2A85-M PRO Linux 5.9-rc8 (and previous versions) 
>>>>>>> does not
>>>>>>> recognize a plugged in PS/2 mouse using the Plug & Play method. 
>>>>>>> The PS/2
>>>>>>> keyboard is detected fine, and using `i8042.nopnp`, the PS/2 
>>>>>>> mouse also
>>>>>>> works.
>>>>>>>
>>>>>>>> [    1.035915] calling i8042_init+0x0/0x42d @ 1
>>>>>>>> [    1.035947] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 
>>>>>>>> 0x60,0x64 irq 1
>>>>>>>> [    1.035948] i8042: PNP: PS/2 appears to have AUX port 
>>>>>>>> disabled, if this is incorrect please boot with i8042.nopnp
>>>>>>>> [    1.036589] serio: i8042 KBD port at 0x60,0x64 irq 1
>>>>>>>> [    1.036621] initcall i8042_init+0x0/0x42d returned 0 after 
>>>>>>>> 687 usecs
>>>>>>>
>>>>>>> But, the DSDT includes the “mouse device”. From
>>>>>>>
>>>>>>>        acpidump > dump.bin; acpixtract dump.bin; iasl -d *dat; 
>>>>>>> more dsdt.dsl
>>>>>>>
>>>>>>> we get
>>>>>>>
>>>>>>>                    Device (PS2M)
>>>>>>>                    {
>>>>>>>                        Name (_HID, EisaId ("PNP0F03") /* 
>>>>>>> Microsoft PS/2-style Mouse */)  // _HID: Hardware ID
>>>>>>>                        Name (_CID, EisaId ("PNP0F13") /* PS/2 
>>>>>>> Mouse */) // _CID: Compatible ID
>>>>>>>                        Method (_STA, 0, NotSerialized)  // _STA: 
>>>>>>> Status
>>>>>>>                        {
>>>>>>>                            If ((IOST & 0x4000))
>>>>>>>                            {
>>>>>>>                                Return (0x0F)
>>>>>>>                            }
>>>>>>>                            Else
>>>>>>>                            {
>>>>>>>                                Return (Zero)
>>>>>>>                            }
>>>>>>>                        }
>>>>>>>
>>>>>>> and the identifiers PNP0F03 and PNP0F13 are both listed in the 
>>>>>>> array
>>>>>>> `pnp_aux_devids[]`. But adding print statements to 
>>>>>>> `i8042_pnp_aux_probe()`,
>>>>>>> I do not see them, so the function does not seem to be called.
>>>>>>
>>>>>> My guess is that _STA returns 0 indicating that the device is not
>>>>>> present. I would try tracking where IOST is being set and 
>>>>>> figuring out
>>>>>> why it does not have mouse bit enabled.
>>>>>
>>>>> Does the ACPI subsystem allow to track, how ACPI variables(?) like 
>>>>> IOST
>>>>> are read and set?
>>>>
>>>> My guess would be that IOST is a field in an operation region which
>>>> would indicate that it is initialized by the bootstrap part of the
>>>> BIOS.
>>>
>>> Thank you for your answer. But how can I verify that?
>>
>> Inspecting the ACPI tables from the system in question could help you
>> to find out whether or not IOST really is a field in an operation
>> region, but its initial value may not be possible to determine this
>> way.
>>
>>> Is there a Linux kernel parameter, that would print it?
>>
>> Not that I know of.
>
> I created an issue in the Linux kernel bugtracker [1] and attached the 
> output of `acpidump` there.
>
> Could
>
>     If ((IOST & 0x4000))
>
> versus
>
>     If ((IOST & 0x0400))
>
> be a typo?
>
Yes, it could.


