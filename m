Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DB240CFCE
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 01:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhIOXG0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 19:06:26 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:50130
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231579AbhIOXG0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Sep 2021 19:06:26 -0400
Received: from [192.168.1.5] (unknown [124.160.154.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 432413F357;
        Wed, 15 Sep 2021 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631747105;
        bh=cMO5C/wmhXIE4vb1cRZKUS7NnOfuHvlU6SEUlhrFypI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=KsiRT4mP6GZllyM4NqmxiRU8GwJCk6ck6wDbG+udfB7tZT5DVzAseJ+9NvyNcHU6i
         ZUn2hepC94o5Hdqwh3PnE1Hq24Xr9nq44J9YdClxTHaopnasZWbZWKd1JRNbpIBZ6V
         hGSxY3+oW4JOYJhuZCOXnY5MwT7YiarEW0y2jsfIQlo7CVYJzg7blrIHOVqDufUOmn
         8R8MwJLVZngpNcbDZnkZxbBwS1YA77hO7o1oivMxClRSdEpA2RIUAPIcwPzkmVDayX
         i6LA9wLlw+FUJP4rUQpiJOgHBQJ2EEPwDWmGq6Drmg+IbU9CjPgAKDtHWSxENfuk1j
         oSTC+lQ09yjyg==
Subject: Re: [PATCH v3] ACPI: resources: add legacy irq override exception by
 DMI info
To:     Manuel Krause <manuelkrause@netscape.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>
References: <20210915130905.11196-1-hui.wang@canonical.com>
 <CAJZ5v0g1_zMKX9WeSDF5SXib1EFTke3wMHqtJm-+YtQzSyM6dQ@mail.gmail.com>
 <8e93e2ee-b403-c938-d730-7deacbfd759e@netscape.net>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <6609e8a2-1f05-3c0b-8067-8ada8f5742a7@canonical.com>
Date:   Thu, 16 Sep 2021 07:04:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8e93e2ee-b403-c938-d730-7deacbfd759e@netscape.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 9/16/21 3:05 AM, Manuel Krause wrote:
> On 15/09/2021 20:13, Rafael J. Wysocki wrote:
>>
[...]
>>> +       if (check_override &&
>>> +           acpi_dev_irq_override(gsi, triggering, polarity, 
>>> shareable) &&
>>> +           !acpi_get_override_irq(gsi, &t, &p)) {
>>>                  u8 trig = t ? ACPI_LEVEL_SENSITIVE : 
>>> ACPI_EDGE_SENSITIVE;
>>>                  u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>>>
>>> -- 
>>
>> Applied as 5.16 material under the subject "ACPI: resources: Add
>> DMI-based legacy IRQ override quirk" with some changelog edits.
>>
>> Thanks!
>>
>
Thanks Rafael.
> We have to thank you, Rafael, for investing your time and covering 
> this issue + fix again!
>
> I just want to add now, that also PATCH v3 works fine on here (with 
> kernel v5.14.4 now).
>
> I'm still not familiar with the kernel patch queueing mechanisms, so 
> forgive my possibly bothering question:
> Would it be possible (e.g. for you) to get that fix into earlier 
> kernel versions? Simple reason to ask for it: Some people thinking 
> over to return their newly bought machine of this type without proper 
> out-of-the-box Linux support.
> It shouldn't be my business, but I understand those folks' concerns.
>
>
Hi Manuel,

After the patch is in the linux-next, at least I will backport the patch 
to ubuntu 20.04, 20.10 and 21.04 kernels.

Regards,

Hui.

> TIA and best regards,
>
> Manuel
