Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC091D90B7
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 09:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgESHLr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 03:11:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41253 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESHLp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2020 03:11:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200519071144euoutp02b819308d90aca65075835fdbb240bc45~QXHAAo6xQ0048500485euoutp02Q
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2020 07:11:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200519071144euoutp02b819308d90aca65075835fdbb240bc45~QXHAAo6xQ0048500485euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589872304;
        bh=wUifd9mNGCqS+cJ3EIdbirIVh2WMlKdLwIt+fOi2nlc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=N5Wq74V9nPLHA5l+LpuuvFip8RsoVVfPwIVH0YclG1DrG55S9RefjBD6PNpLQpPpI
         zNNimhISU3qbMf5Z6lMabK8ArxZq7G0/PCi+jDVnoTsJHkOSIwfhZFspWWnAd7g1oS
         d96uHyNV03NYm+2hkX2pKqgxMReINB6AQm5W3Wis=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200519071144eucas1p247d683cf2d7f582b9d4cd3fedc77df6e~QXG-ul06t0169201692eucas1p2N;
        Tue, 19 May 2020 07:11:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D4.CD.60679.0B683CE5; Tue, 19
        May 2020 08:11:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200519071143eucas1p11ddbfc41e96d1a3a7bdf37995515e940~QXG-doInZ0145301453eucas1p1y;
        Tue, 19 May 2020 07:11:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200519071143eusmtrp2ee03f555c8a52fb4d89ed6205a32a6b2~QXG-c5yf52589025890eusmtrp2L;
        Tue, 19 May 2020 07:11:43 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-a4-5ec386b0a98f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F8.9F.08375.FA683CE5; Tue, 19
        May 2020 08:11:43 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200519071143eusmtip25d3d33dc8bbf98ff2aef0e100387a4d7~QXG_yiWyI1140611406eusmtip2V;
        Tue, 19 May 2020 07:11:43 +0000 (GMT)
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding
 all top level devices
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
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <18332705-dd61-9a0e-d931-ae610c8fb600@samsung.com>
Date:   Tue, 19 May 2020 09:11:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx_FOGgHdaNY8Dd-4rgT28U7_OHYeLsazbUE-1hyuatRSg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUYRTl25mdGc2VcVX2YmWxUKDgs5LBaqkIml+R0gMMzVUHFdcHOz6y
        onwluolZZuniq4w0s7Q11LU025V8xZppGmWRZqCm9lB7iGa7Tpb/zjn3nO/eAx+FSZ+JnajI
        mHhOHaNUyQlrvOHpr163ukxjkOdQti1T1m4SM0VTywSTXlFLMIXD7STT1OjA6EemCaay9SJi
        +puLzXpvq4gpmSvAmPMtZofGsETssWEbHjaIWb32LcmW6xJYXXU2wT4uqSHZ+zNNInZW53yI
        DLDeFcapIhM5tYci2DpivmZ33HXnk2X5o2QKGgUNsqKA3g767ipSg6wpKV2FIDcnCxfIHIJH
        g7lIILMIJppTsdVIVsawWBhUImj7+V0kkM8IlrpumSMUZU+HwI8rtpaAA+0KusEPK89idAYO
        b4pKCcuAoL1AM61ZwRJaAcVTOciCcXoLVA0ZRBbsSAdCT0U9Ejx20FU0hluwFe0H34yfVi7C
        6E3QOF38F8vg9VjZykFAvyNhsvwCLpy9H1K+DogFbA+THQ9IAW+AZf1qIB3BiOkuKZAcBP1p
        hUhw7YRh0wJhqYbRLlDb7CHIe6E+NR+3yEDbwqtpO+EIW7jccA0TZAlkZUoF91bQdtz7t/bJ
        8xdYHpJr11TTrqmjXVNH+39vOcKrkYxL4KPDOd47hkty55XRfEJMuHtobLQOmf9Yz++OuSbU
        vBhiQDSF5DaS4FhDkFSsTOSTow0IKEzuIMkbN0uSMGXyKU4de0KdoOJ4A1pP4XKZZNuNiUAp
        Ha6M56I4Lo5Tr05FlJVTClrn7a87rSdDk7qOv3Q3Dki4jeE2E0c1UYWN/pK53i+Lrlm+vA87
        GmDwmWmbf3/Yxeaj1UL90OY7l1i/I05M5zHfxCm3+OzAptI0ZePZ3gCPsX0FfTsUrV43+2QH
        bpuyvc/Jna8Oq1JlTuMHO+sdx0pEQ2cqC4zdLQr3ziKDwrNOjvMRSi9XTM0r/wCXShu5XwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xe7rr2w7HGVzcYm4x/8g5VouZb/6z
        WTQvXs9mMePOEXaLHdtFLHY+fMtmsXxfP6PF5V1zgOLn9zFZzP0yldmidS9QRdehv2wOPB7b
        dm9j9dg56y67x4JNpR6bVnWyeeyfu4bdY+O7HUwenzfJBbBH6dkU5ZeWpCpk5BeX2CpFG1oY
        6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GV8XWNbsFCuYv7kR+wNjI8kuhg5OSQE
        TCQ6Wu6wdjFycQgJLGWUmLFyNxtEQkbi5LQGVghbWOLPtS6wuJDAW0aJn3Mkuxg5OIQFkiQe
        zLMECYsIaElsuvaYBWQOs0Abi8Sh+ceh6nczSby+zA5iswkYSnS9hZjDK2AnMedNDyOIzSKg
        KrHi+iEmEFtUIFZi9bVWRogaQYmTM5+wgNicAoESnw6/ZgaxmQXMJOZtfghly0tsfzsHyhaX
        uPVkPtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJjdtux
        n5t3MF7aGHyIUYCDUYmHNyH/UJwQa2JZcWXuIUYJDmYlEd4JL4BCvCmJlVWpRfnxRaU5qcWH
        GE2BnpvILCWanA9MJ3kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODil
        GhjdymIteY4U/JH9ccGrZerqYoObuxczpG8IOnT96y9Pw8adPk9Ur9/tk4076cT2aNNdvhOt
        ntunNFTEnnC32NM0STstSLvDTmZBktd0wYOmhmbrT187MbuE7eF25X5RBf6WtSGPmzVlrXkW
        lVT/m6n6qzigVMlIy5RLlW0n3/terulHJz6+u0uJpTgj0VCLuag4EQC7zRpB7wIAAA==
X-CMS-MailID: 20200519071143eucas1p11ddbfc41e96d1a3a7bdf37995515e940
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
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

On 19.05.2020 08:48, Saravana Kannan wrote:
> On Mon, May 18, 2020 at 11:25 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 15.05.2020 07:35, Saravana Kannan wrote:
>>> The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
>>> parsing of the device tree nodes when a lot of devices are added. This
>>> will significantly cut down parsing time (as much a 1 second on some
>>> systems). So, use them when adding devices for all the top level device
>>> tree nodes in a system.
>>>
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>> This patch recently landed in linux-next 20200518. Sadly, it causes
>> regression on Samsung Exynos5433-based TM2e board:
>>
>> s3c64xx-spi 14d30000.spi: Failed to get RX DMA channel
>> s3c64xx-spi 14d50000.spi: Failed to get RX DMA channel
>> s3c64xx-spi 14d30000.spi: Failed to get RX DMA channel
>> s3c64xx-spi 14d50000.spi: Failed to get RX DMA channel
>> s3c64xx-spi 14d30000.spi: Failed to get RX DMA channel
>>
>> Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 0 PID: 50 Comm: kworker/0:1 Not tainted 5.7.0-rc5+ #701
>> Hardware name: Samsung TM2E board (DT)
>> Workqueue: events deferred_probe_work_func
>> pstate: 60000005 (nZCv daif -PAN -UAO)
>> pc : samsung_i2s_probe+0x768/0x8f0
>> lr : samsung_i2s_probe+0x688/0x8f0
>> ...
>> Call trace:
>>    samsung_i2s_probe+0x768/0x8f0
>>    platform_drv_probe+0x50/0xa8
>>    really_probe+0x108/0x370
>>    driver_probe_device+0x54/0xb8
>>    __device_attach_driver+0x90/0xc0
>>    bus_for_each_drv+0x70/0xc8
>>    __device_attach+0xdc/0x140
>>    device_initial_probe+0x10/0x18
>>    bus_probe_device+0x94/0xa0
>>    deferred_probe_work_func+0x70/0xa8
>>    process_one_work+0x2a8/0x718
>>    worker_thread+0x48/0x470
>>    kthread+0x134/0x160
>>    ret_from_fork+0x10/0x1c
>> Code: 17ffffaf d503201f f94086c0 91003000 (88dffc00)
>> ---[ end trace ccf721c9400ddbd6 ]---
>> Kernel panic - not syncing: Fatal exception
>> SMP: stopping secondary CPUs
>> Kernel Offset: disabled
>> CPU features: 0x090002,24006087
>> Memory Limit: none
>>
>> ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> Both issues, the lack of DMA for SPI device and Synchronous abort in I2S
>> probe are new after applying this patch. I'm trying to investigate which
>> resources are missing and why. The latter issue means typically that the
>> registers for the given device has been accessed without enabling the
>> needed clocks or power domains.
> Did you try this copy-pasta fix that I sent later?
> https://lore.kernel.org/lkml/20200517173453.157703-1-saravanak@google.com/
>
> Not every system would need it (my test setup didn't), but it helps some cases.
>
> If that fix doesn't help, then some tips for debugging the failing drivers.
> What this pause/resume patch effectively (not explicitly) does is:
> 1. Doesn't immediately probe the devices as they are added in
> of_platform_default_populate_init()
> 2. Adds them in order to the deferred probe list.
> 3. Then kicks off deferred probe on them in the order they were added.
>
> These drivers are just not handling -EPROBE_DEFER correctly or
> assuming probe order and that's causing these issues.
>
> So, we can either fix that or you can try adding some code to flush
> the deferred probe workqueue at the end of fw_devlink_resume().
>
> Let me know how it goes.

So far it looks that your patch revealed a hidden issue in exynos5433 
clocks configuration, because adding clk_ignore_unused parameter to 
kernel command line fixes the boot. I'm still investigating it, so 
probable you can ignore my regression report. I will let you know asap I 
finish checking it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

