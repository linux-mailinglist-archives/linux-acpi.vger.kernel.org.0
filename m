Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2EB40BC67
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 01:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbhINX6r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Sep 2021 19:58:47 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43576
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233774AbhINX6q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Sep 2021 19:58:46 -0400
Received: from [192.168.1.5] (unknown [124.160.154.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1D3B73F0FD;
        Tue, 14 Sep 2021 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631663848;
        bh=mOiH41oAzOZu9YXySmnJ7oMJF9C+YR8FocPnvZlIHwM=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=SS47mpxq6vjthB/wQzJL3m2+MEf5aEY1V8xxL2f/bH10DeaVLTSkxCUCcMeZTkkgK
         j6PHrLJUKuJJ68MC9h4UMMz0zLSAXsp1fSU9bxBreQBElq27dlTcQqo1yB43CbAJHK
         DyLhndEidDg11eEgF5F2fGBwpVJjXwk+8WZtWS9oSgm0x/p5zSTO5P8XFnTCBP3Gbj
         u8piDLOR+0txq3zdbx2cigfEgPXHX7GN2Sx1zwoID+5ZXJmlgDAF0JgB8q2L85Hw66
         jlaX+6nCRzvTqAMReDLu5BJjvUI87jhQn9acLLslQQYsE7X6+8P4Ygl4ncedZTyFAP
         415GfR4ZQ3p1g==
Subject: Re: [PATCH v2] ACPI: resources: add legacy irq override exception by
 DMI info
To:     Manuel Krause <manuelkrause@netscape.net>,
        linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
References: <20210914133410.88366-1-hui.wang@canonical.com>
 <dffc0f3c-19e9-5b24-e33d-588e73ca130b@netscape.net>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <ba2bcbda-387a-05f3-8c55-d9b3f7ad3572@canonical.com>
Date:   Wed, 15 Sep 2021 07:57:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dffc0f3c-19e9-5b24-e33d-588e73ca130b@netscape.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 9/15/21 12:01 AM, Manuel Krause wrote:
> Hi Rafael, Hui and all others,
>
> thank you very much for your time, thoughts and work, again!
>
> The new [PATCH v2] works as well on here as the previous one. Keep my 
> "Tested-by" attribute.
>
> @Rafael: Do you see risks with this patch or the need for further 
> improvements? If not, can you, please, push this patch towards kernel 
> inclusion?
>
> @Hui: Are you going to publish the updated patch on bugzilla or should 
> I upload it? -- Many thanks for your recent quick actions!

OK, will do it.

Thanks,

Hui.

>
> Best regards,
>
> Manuel
>
>
> On 14/09/2021 15:34, Hui Wang wrote:
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
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
>> BugLink: http://bugs.launchpad.net/bugs/1909814
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reported-by: Manuel Krause <manuelkrause@netscape.net>
>> Tested-by: Manuel Krause <manuelkrause@netscape.net>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   drivers/acpi/resource.c | 51 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 49 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index ee78a210c606..676254ccac4d 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
> [...]
