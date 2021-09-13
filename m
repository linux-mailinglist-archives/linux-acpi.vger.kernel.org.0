Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191E6408C35
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Sep 2021 15:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhIMNPp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Sep 2021 09:15:45 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:54440
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240039AbhIMNPj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Sep 2021 09:15:39 -0400
Received: from [192.168.1.5] (unknown [124.160.154.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9C1C23F234;
        Mon, 13 Sep 2021 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631538862;
        bh=TFpJA/aRGIr5ydn0/yNoDEYIt+7WwAOZovltnH+tPQ0=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=WOmBdzKTzm4WEly456oo40b2JZM80wH2oJXNe9MUSzzN6zv0zpKnAg2LbdCaeVLOe
         e3N4NFr+ghqUP601biERIL54ebo1FOR5ZjSO7BQ7mFonUfvo66J7AdB/oG35uJ1UZx
         gyhFapRKrXYDDxq7NSYpl4FS1Q2sGpcEWfLkrxq4sdmP6AEITV/Ft2VWrpUluaTFWC
         0fKmW1PyW45V3L0t0c1sbzkNoDBim0kYWmZRAix5qr8ZrU9G/xzs28+748w1Qbcd9M
         GHQqFiG6J0M4JOQjGWO61VfXwca8CZSJwnQl4pBvfn8uE6Gps3lMmy44QnOOXz91xQ
         PJjxlVPk4AlTQ==
Subject: Re: [PATCH] ACPI: resources: add legacy irq override exception by DMI
 info
To:     Manuel Krause <manuelkrause@netscape.net>,
        linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
References: <20210904014340.17536-1-hui.wang@canonical.com>
 <d34e6ab0-c8c2-6721-af41-09f04b6030f6@netscape.net>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <1a5d713e-84f7-4d5f-aa84-b87e50ec9056@canonical.com>
Date:   Mon, 13 Sep 2021 21:14:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d34e6ab0-c8c2-6721-af41-09f04b6030f6@netscape.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Could you please take a look at this patch and give some comment when 
you have time, the patch will not introduce the regression like the 
previous one.

Hi Manuel,

Thanks for your comment. Let's work together to make the keyboard work 
under Linux kernel.

Regards,

Hui.

On 9/5/21 12:04 AM, Manuel Krause wrote:
> Hi Hui Wang and all others,
>
> thank you for notifying me and for giving it a new run for the kernel! 
> ;-)
>
> On 04/09/2021 03:43, Hui Wang wrote:
>> After the commit 0ec4e55e9f57 ("ACPI: resources: Add checks for ACPI
>> IRQ override") is reverted, the keyboard of those Medion laptops can't
>> work again.
>>
>> To fix the keyboard issue, here adding an override check by DMI info,
>> this will not affect other machines and this design refers to
>> the prt_quirks[] in the drivers/acpi/pci_irq.c.
>>
>> If we meet similar issues on other platforms, we could expand the
>> table of skip_override_table[] or medion_laptop[].
>
> ^
> | IMO this is the major positive aspect of this patch, that it enables 
> additions, allowing the kernel to work-around other buggy BIOSs / 
> hardware properly in future.
>
> Maybe https://bugzilla.kernel.org/show_bug.cgi?id=213353 "IRQs for 
> onboard UARTs are not level-triggered with IRQNoFlags even if the 
> parent section has the defaults in PRS" is another candidate to add to 
> the table (but I haven't digged deeply enough into it to be sure).
>
> Many thanks to all helpful people involved,
> best regards,
>
> Manuel
>
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
>> BugLink: http://bugs.launchpad.net/bugs/1909814
>> Reported-by: Manuel Krause <manuelkrause@netscape.net>
>> Tested-by: Manuel Krause <manuelkrause@netscape.net>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   drivers/acpi/resource.c | 52 ++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index ee78a210c606..434c8964f182 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
> [...]
