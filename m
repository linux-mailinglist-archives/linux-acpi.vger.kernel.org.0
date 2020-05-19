Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9F71D9461
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 12:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgESKcf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 06:32:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34646 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgESKce (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2020 06:32:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200519103232euoutp029dd51ea6a914faaa5081a36582d838d8~QZ2UffFNN0529005290euoutp02u
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2020 10:32:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200519103232euoutp029dd51ea6a914faaa5081a36582d838d8~QZ2UffFNN0529005290euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589884352;
        bh=8aqTPyb+75966luDR2CZdhE8lWVOMDbEHkMTToW0Gdw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UVRs57AznvQOXUgb5s5z3+UVfOW1EGUps9dAtKqHklAIhRbvcXm1nnwBYuzjJxOSP
         qyJQ3uFLEJdjHLrurTC+epApaWtG+fLxQYXNsks3f3/2DVNZVak+B/ZZu+Ac9ghSk0
         hLvuvaXwtP+RXnc/gT4WhD3iZlZ6AoEdv3oRTKbI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200519103232eucas1p194e62333f8c5f252d962d95915630bcb~QZ2UKu4ga1478214782eucas1p1m;
        Tue, 19 May 2020 10:32:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9E.10.60679.0C5B3CE5; Tue, 19
        May 2020 11:32:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200519103231eucas1p105f6b8b68a285536795e726a4e98bee9~QZ2TxWUkR1516315163eucas1p1p;
        Tue, 19 May 2020 10:32:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200519103231eusmtrp1db3cd1b337f0a47dd218d8a5924c6d3a~QZ2Twp9Dt0843608436eusmtrp16;
        Tue, 19 May 2020 10:32:31 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-3f-5ec3b5c03e45
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.4D.07950.FB5B3CE5; Tue, 19
        May 2020 11:32:31 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200519103231eusmtip25924103fd58f2427f9171da4f4a01fbd~QZ2TLBGAi0462804628eusmtip2k;
        Tue, 19 May 2020 10:32:31 +0000 (GMT)
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding
 all top level devices
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ji Luo <ji.luo@nxp.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Message-ID: <8dd9ecc2-0c61-49b7-d485-b169eb721712@samsung.com>
Date:   Tue, 19 May 2020 12:32:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <18332705-dd61-9a0e-d931-ae610c8fb600@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtt3t37505+bksv7QXi8qkLK3oRmFZCiNUhP4TNK95UdE52d3s
        QYVmZQ1JyZY6NSWh0qzhNJ2GpisUGflI6KWJmrCK1ggNU7JyXi3/O98553sc+BhCYZf6MakZ
        Ol6bwaUrKQ+yqWumb2fHk+fxu/PMUrbyRa+ULf36h2Jzq80UWzL8gmatzT5sy5iTYu+3FyB2
        sLV8nu9rl7AVU0aCvdI27zDY5qgjnqqmp01SVYvpA62qsuhVltrrlOpZRR2tqv9mlagmLRti
        6FiPQ0l8emoWr90VmuCRkl3jIjO/+Jwxu4x0NnJgA5IxgPeCo/G7xIA8GAV+gGBmLp8WiykE
        n3/MEmIxicBRbyOWWoYKRhZd9xG4vhVSbkGBXQja6nYYEMOswokwfcvLTVM4GAxOw4LFBweC
        5fVH0t1L4MskDJXeWRDkOBQqi9yCjCHxFnhg70JuvBrHgb26AYkeb+gpnVjwyPBhGCibot2Y
        wBuh2VlOiNgX3k9ULuQBPE6D42Wf1H0Q4HCoGFCIAVbBl+5GWsTrwF6UT4r+XARjvY9oschH
        MHipBImugzDcO0u5BxF4O5hbd4l0GDTkFJHifC946/QWb/CCm03FhEjL4drVxbVbwdT9+N/a
        zv5XRCFSmpYlMy1LY1qWxvR/bxUia5EvrxfUybwQksGfDhI4taDPSA46pVFb0PyL2X93T1lR
        669EG8IMUnrKEzS2eIWUyxLOqm0IGELpIy/8NE/Jk7iz53it5qRWn84LNuTPkEpf+Z67n+MU
        OJnT8Wk8n8lrl1QJI/PLRoXJP/1vCCsnj24TnpjD5HlKijOE90QZnQ8ZMvbC6LG8yPdZz+tP
        rKiaHo8eDx+I2LwpKqCdOp8Qva8M9Q+YWhreBB0/GTJaYyFG7lVNrinWlSUJaRp8um9oLuVA
        lzmnM+y2itPNFKRbDfq9kWvfGY2SAMf2hhj5/oiOi0PW9UpSSOGCAwmtwP0FXJ+ck14DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xe7r7tx6OM1jWo2kx/8g5VouZb/6z
        WTQvXs9mMePOEXaLHdtFLHY+fMtmsXxfP6PF5V1zgOLn9zFZzP0yldmidS9QRdehv2wOPB7b
        dm9j9dg56y67x4JNpR6bVnWyeeyfu4bdY+O7HUwenzfJBbBH6dkU5ZeWpCpk5BeX2CpFG1oY
        6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU0rHzPUvBKpGL9+6nsDYzPBboYOTkk
        BEwkbvffY+9i5OIQEljKKPHo+XIWiISMxMlpDawQtrDEn2tdbBBFbxklfs85xdTFyMEhLJAk
        8WCeJUgNm4ChRNdbkBpODhEBLYlN1x6zgNQzC7SxSByafxyq+QOTxOzNJ5hAqngF7CTmT34M
        to1FQFVixeljjCC2qECsxOprrYwQNYISJ2c+AavhFLCXuDj7CzuIzSxgJjFv80NmCFteYvvb
        OVC2uMStJ/OZJjAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kR
        GLnbjv3csoOx613wIUYBDkYlHt6E/ENxQqyJZcWVuYcYJTiYlUR4J7wACvGmJFZWpRblxxeV
        5qQWH2I0BXpuIrOUaHI+MKnklcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLp
        Y+LglGpg9LFxi3+awPd1gaBy+4RvLxrMTlR6f/ryhtnd8KhedOSjDxzhUQyFD0R+vrmUtC7/
        VBXv5+qXi/Na93wtqrn5bZslk+KHX5bSQqyt0y4tdcyYef6Q3ZVnws+fbDPb0GBW9l/09rGq
        xYckRXzl/TlOXvvWPTPo1xqmCZcvJkaJTYqtt58tPlfhrRJLcUaioRZzUXEiAGA0T7HyAgAA
X-CMS-MailID: 20200519103231eucas1p105f6b8b68a285536795e726a4e98bee9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200519062510eucas1p27bc59da66e1b77534855103a27f87452
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200519062510eucas1p27bc59da66e1b77534855103a27f87452
References: <20200515053500.215929-1-saravanak@google.com>
        <CGME20200519062510eucas1p27bc59da66e1b77534855103a27f87452@eucas1p2.samsung.com>
        <20200515053500.215929-5-saravanak@google.com>
        <e0f9211d-9cf6-a12d-eb63-df06910920ed@samsung.com>
        <CAGETcx_FOGgHdaNY8Dd-4rgT28U7_OHYeLsazbUE-1hyuatRSg@mail.gmail.com>
        <18332705-dd61-9a0e-d931-ae610c8fb600@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi

On 19.05.2020 09:11, Marek Szyprowski wrote:
> On 19.05.2020 08:48, Saravana Kannan wrote:
>> On Mon, May 18, 2020 at 11:25 PM Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> On 15.05.2020 07:35, Saravana Kannan wrote:
>>>> The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
>>>> parsing of the device tree nodes when a lot of devices are added. This
>>>> will significantly cut down parsing time (as much a 1 second on some
>>>> systems). So, use them when adding devices for all the top level 
>>>> device
>>>> tree nodes in a system.
>>>>
>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>> This patch recently landed in linux-next 20200518. Sadly, it causes
>>> regression on Samsung Exynos5433-based TM2e board:
>>>
>>> ...
>>>
>>> Both issues, the lack of DMA for SPI device and Synchronous abort in 
>>> I2S
>>> probe are new after applying this patch. I'm trying to investigate 
>>> which
>>> resources are missing and why. The latter issue means typically that 
>>> the
>>> registers for the given device has been accessed without enabling the
>>> needed clocks or power domains.
>> Did you try this copy-pasta fix that I sent later?
>> https://lore.kernel.org/lkml/20200517173453.157703-1-saravanak@google.com/ 
>>
>>
>> Not every system would need it (my test setup didn't), but it helps 
>> some cases.
>>
>> If that fix doesn't help, then some tips for debugging the failing 
>> drivers.
>> What this pause/resume patch effectively (not explicitly) does is:
>> 1. Doesn't immediately probe the devices as they are added in
>> of_platform_default_populate_init()
>> 2. Adds them in order to the deferred probe list.
>> 3. Then kicks off deferred probe on them in the order they were added.
>>
>> These drivers are just not handling -EPROBE_DEFER correctly or
>> assuming probe order and that's causing these issues.
>>
>> So, we can either fix that or you can try adding some code to flush
>> the deferred probe workqueue at the end of fw_devlink_resume().
>>
>> Let me know how it goes.
>
> So far it looks that your patch revealed a hidden issue in exynos5433 
> clocks configuration, because adding clk_ignore_unused parameter to 
> kernel command line fixes the boot. I'm still investigating it, so 
> probable you can ignore my regression report. I will let you know asap 
> I finish checking it.
>
Okay, I confirm that the issue is in the Exynos I2S driver and 
Exynos5433 clock provider. I've posted a quick workaround. I'm sorry for 
the noise, your patch is fine.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

