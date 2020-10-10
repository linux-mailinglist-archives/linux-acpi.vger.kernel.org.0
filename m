Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80B428A371
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Oct 2020 01:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390356AbgJJW5F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Oct 2020 18:57:05 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:36489 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387905AbgJJUm0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Oct 2020 16:42:26 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Oct 2020 16:42:25 EDT
Received: from [192.168.1.11] (dynamic-089-014-081-185.89.14.pool.telefonica.de [89.14.81.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 079D720645E93;
        Sat, 10 Oct 2020 22:32:11 +0200 (CEST)
Subject: Re: i8042_init: PS/2 mouse not detected with ACPIPnP/PnPBIOS
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
References: <1a69c5bc-ccc4-68db-7871-af05a70052c9@molgen.mpg.de>
 <20201007221628.GW1009802@dtor-ws>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <bbb70981-1242-0aea-01c9-f9507f8eae3b@molgen.mpg.de>
Date:   Sat, 10 Oct 2020 22:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007221628.GW1009802@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Dmitry, dear Rafael, dear Len,


Am 08.10.20 um 00:16 schrieb Dmitry Torokhov:

> On Wed, Oct 07, 2020 at 11:18:41PM +0200, Paul Menzel wrote:

>> On the Asus F2A85-M PRO Linux 5.9-rc8 (and previous versions) does not
>> recognize a plugged in PS/2 mouse using the Plug & Play method. The PS/2
>> keyboard is detected fine, and using `i8042.nopnp`, the PS/2 mouse also
>> works.
>>
>>> [    1.035915] calling  i8042_init+0x0/0x42d @ 1
>>> [    1.035947] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
>>> [    1.035948] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
>>> [    1.036589] serio: i8042 KBD port at 0x60,0x64 irq 1
>>> [    1.036621] initcall i8042_init+0x0/0x42d returned 0 after 687 usecs
>>
>> But, the DSDT includes the “mouse device”. From
>>
>>      acpidump > dump.bin; acpixtract dump.bin; iasl -d *dat; more dsdt.dsl
>>
>> we get
>>
>>                  Device (PS2M)
>>                  {
>>                      Name (_HID, EisaId ("PNP0F03") /* Microsoft PS/2-style Mouse */)  // _HID: Hardware ID
>>                      Name (_CID, EisaId ("PNP0F13") /* PS/2 Mouse */) // _CID: Compatible ID
>>                      Method (_STA, 0, NotSerialized)  // _STA: Status
>>                      {
>>                          If ((IOST & 0x4000))
>>                          {
>>                              Return (0x0F)
>>                          }
>>                          Else
>>                          {
>>                              Return (Zero)
>>                          }
>>                      }
>>
>> and the identifiers PNP0F03 and PNP0F13 are both listed in the array
>> `pnp_aux_devids[]`. But adding print statements to `i8042_pnp_aux_probe()`,
>> I do not see them, so the function does not seem to be called.
> 
> My guess is that _STA returns 0 indicating that the device is not
> present. I would try tracking where IOST is being set and figuring out
> why it does not have mouse bit enabled.

Does the ACPI subsystem allow to track, how ACPI variables(?) like IOST 
are read and set?


Kind regards,

Paul
