Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0DF1DA90A
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 06:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgETEV2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 00:21:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39364 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgETEV1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2020 00:21:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200520042125euoutp018c276f6dadbabdf8989b7e9e3987dbd8~QoblQPlCZ1895318953euoutp01h
        for <linux-acpi@vger.kernel.org>; Wed, 20 May 2020 04:21:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200520042125euoutp018c276f6dadbabdf8989b7e9e3987dbd8~QoblQPlCZ1895318953euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589948485;
        bh=xiWXMWfNTMDhpyYN6ynqaEoNJ+Fc3bIMAx5GVLMVvWo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bxVvSUqCDndl8Du69qqiRAAfgUbulItHjsf613JVgWJGI/P1MxvZLTlIisZd63tV0
         HBpni8DG4f61uPBNqNloGRoIWaf1H/CRdyjFeNLMjYA69y+XRXRUr3BPjio1JTQAXi
         AXc2YPY2TFwrJoyacya6G+6CHJPEZcgluPc7vcfI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200520042125eucas1p261681d480f781be6db7485d6b3f328ba~QobktHNkQ2740227402eucas1p2a;
        Wed, 20 May 2020 04:21:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 69.70.60698.540B4CE5; Wed, 20
        May 2020 05:21:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200520042124eucas1p1a848a7353c8cc5183688f9acd189b360~QobkVS_eG2110621106eucas1p1F;
        Wed, 20 May 2020 04:21:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200520042124eusmtrp2cdbe049b0513fdc44ac09ed185f1f0e9~QobkUnVw20913609136eusmtrp2x;
        Wed, 20 May 2020 04:21:24 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-2a-5ec4b0452ffa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.57.07950.440B4CE5; Wed, 20
        May 2020 05:21:24 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200520042124eusmtip1e56f8e692b6a8f3e6890b7fb4fcc62e9~QobjrEmBf2685426854eusmtip10;
        Wed, 20 May 2020 04:21:24 +0000 (GMT)
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
Message-ID: <f53cee8b-c4e9-fc1c-a340-e8cda7b10311@samsung.com>
Date:   Wed, 20 May 2020 06:21:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx_VtJXCqih4ZadZ0dFVJwKOBEQnnrr9JxxmGNh7HX_vNQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7quG47EGUxq47CYf+Qcq8XMN//Z
        LJoXr2ezmHHnCLvFju0iFjsfvmWzWL6vn9Hi8q45QPHz+5gs5n6ZymzRuheoouvQXzYHHo9t
        u7exeuycdZfdY8GmUo9NqzrZPPbPXcPusfHdDiaPz5vkAtijuGxSUnMyy1KL9O0SuDJ2bnrA
        XtAnU9Hf/5mpgbFXvIuRk0NCwERi28V+1i5GLg4hgRWMEpsWz2SDcL4wSvx/3cUCUiUk8JlR
        YtEZN5iOl0dXQ3UsZ5Q4/P4uE4TznlFi6qV1QO0cHMICSRLfp/CBNIgIaElsuvaYBaSGWaCF
        ReL2zHlsIAk2AUOJrrddYDavgJ3EhxXrwLaxCKhK/GraxQ5iiwrESpxevJkRokZQ4uTMJ2A1
        nAKBEmfbTzOD2MwC8hLb386BssUlbj2ZD3aQhMA9domrx2czQpztIjF52z8WCFtY4tXxLewQ
        tozE/50wDc2MEg/PrWWHcHoYJS43zYDqtpa4c+4X2GvMApoS63fpQ4QdJTY3TmYBCUsI8Enc
        eCsIcQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkLw2C8k7s5C8Mwth7wJGllWM
        4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBaez0v+NfdzDu+5N0iFGAg1GJh/fGzsNxQqyJ
        ZcWVuYcYJTiYlUR4J7w4FCfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC
        1CKYLBMHp1QD40Upz19XlIXzlEW5F620Xes6ge+DSVCErXE395wHpuwqR95L2OfF2DreWHT6
        xflig2ar22f+WwoKnvicqbZB4VN46G9J2bfb2hMX6GaxLeNN2Wj0QfrQtJCvH675qItuY3NP
        uKlw3+xXzNubZsdXpqgV3Q825sqf8FpgoUzhy/hDn9d/2ct2V4mlOCPRUIu5qDgRACuhKx9f
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xu7ouG47EGVw/qmMx/8g5VouZb/6z
        WTQvXs9mMePOEXaLHdtFLHY+fMtmsXxfP6PF5V1zgOLn9zFZzP0yldmidS9QRdehv2wOPB7b
        dm9j9dg56y67x4JNpR6bVnWyeeyfu4bdY+O7HUwenzfJBbBH6dkU5ZeWpCpk5BeX2CpFG1oY
        6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXs3PSAvaBPpqK//zNTA2OveBcjJ4eE
        gInEy6OrWbsYuTiEBJYySrzomsMOkZCRODmtgRXCFpb4c62LDaLoLaPElittQAkODmGBJIkH
        8yxBakQEtCQ2XXvMAlLDLNDGInFo/nGohjfMEmu2/AabxCZgKNH1FmQSJwevgJ3EhxXrWEBs
        FgFViV9Nu8A2iwrESqy+1soIUSMocXLmE7AaToFAibPtp5lBbGYBM4l5mx9C2fIS29/OgbLF
        JW49mc80gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAyN12
        7OeWHYxd74IPMQpwMCrx8BrsORwnxJpYVlyZe4hRgoNZSYR3wotDcUK8KYmVValF+fFFpTmp
        xYcYTYGem8gsJZqcD0wqeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4
        OKUaGJOMGUs4p2h02divUvjp6ua6aoPCwo03FGQrRaPmXnX2+d3z9ml0YP5kS4nJievW8wtH
        /EhYVeBtfceOReU7X+17wzlbP6Q+07YX0z3I2XVzw/GWR4sW9IXUeDvLlrM5aDvteJ3dEi/l
        eTXwzUdp4eeXHn87JNJyRlv8eHcQa8f0S0nvanjXKLEUZyQaajEXFScCAIIPUZLyAgAA
X-CMS-MailID: 20200520042124eucas1p1a848a7353c8cc5183688f9acd189b360
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
        <8dd9ecc2-0c61-49b7-d485-b169eb721712@samsung.com>
        <CAGETcx_VtJXCqih4ZadZ0dFVJwKOBEQnnrr9JxxmGNh7HX_vNQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

On 19.05.2020 20:02, Saravana Kannan wrote:
> On Tue, May 19, 2020 at 3:32 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 19.05.2020 09:11, Marek Szyprowski wrote:
>>> On 19.05.2020 08:48, Saravana Kannan wrote:
>>>> On Mon, May 18, 2020 at 11:25 PM Marek Szyprowski
>>>> <m.szyprowski@samsung.com> wrote:
>>>>> On 15.05.2020 07:35, Saravana Kannan wrote:
>>>>>> The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
>>>>>> parsing of the device tree nodes when a lot of devices are added. This
>>>>>> will significantly cut down parsing time (as much a 1 second on some
>>>>>> systems). So, use them when adding devices for all the top level
>>>>>> device
>>>>>> tree nodes in a system.
>>>>>>
>>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>> This patch recently landed in linux-next 20200518. Sadly, it causes
>>>>> regression on Samsung Exynos5433-based TM2e board:
>>>>>
>>>>> ...
>>>>>
>>>>> Both issues, the lack of DMA for SPI device and Synchronous abort in
>>>>> I2S
>>>>> probe are new after applying this patch. I'm trying to investigate
>>>>> which
>>>>> resources are missing and why. The latter issue means typically that
>>>>> the
>>>>> registers for the given device has been accessed without enabling the
>>>>> needed clocks or power domains.
>>>> Did you try this copy-pasta fix that I sent later?
>>>> https://lore.kernel.org/lkml/20200517173453.157703-1-saravanak@google.com/
>>>>
>>>>
>>>> Not every system would need it (my test setup didn't), but it helps
>>>> some cases.
>>>>
>>>> If that fix doesn't help, then some tips for debugging the failing
>>>> drivers.
>>>> What this pause/resume patch effectively (not explicitly) does is:
>>>> 1. Doesn't immediately probe the devices as they are added in
>>>> of_platform_default_populate_init()
>>>> 2. Adds them in order to the deferred probe list.
>>>> 3. Then kicks off deferred probe on them in the order they were added.
>>>>
>>>> These drivers are just not handling -EPROBE_DEFER correctly or
>>>> assuming probe order and that's causing these issues.
>>>>
>>>> So, we can either fix that or you can try adding some code to flush
>>>> the deferred probe workqueue at the end of fw_devlink_resume().
>>>>
>>>> Let me know how it goes.
>>> So far it looks that your patch revealed a hidden issue in exynos5433
>>> clocks configuration, because adding clk_ignore_unused parameter to
>>> kernel command line fixes the boot. I'm still investigating it, so
>>> probable you can ignore my regression report. I will let you know asap
>>> I finish checking it.
>>>
>> Okay, I confirm that the issue is in the Exynos I2S driver and
>> Exynos5433 clock provider. I've posted a quick workaround. I'm sorry for
>> the noise, your patch is fine.
> Thanks for debugging and finding the real issue. I tried finding your
> patches, but couldn't. Can you point me to a lore.kernel.org link? I'm
> just curious to see what the issue was.

https://lore.kernel.org/linux-samsung-soc/f67db8c1-453b-4c70-67b9-59762ac34f64@kernel.org/T/#t

It looks that one more clock has to be enabled to properly read init 
configuration. So far it worked, because that device was probed much 
earlier, before the unused clocks are turned off. Your patch changed the 
probe order, so that device is probed later.

> I'm guessing you didn't need to pick up this one?
> https://lore.kernel.org/lkml/20200517173453.157703-1-saravanak@google.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

