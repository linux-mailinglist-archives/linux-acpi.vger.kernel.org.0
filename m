Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF611DE4B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 07:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfLMGrP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 01:47:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56052 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMGrP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 01:47:15 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191213064714euoutp0220187a7c4cb24d356ed28133d0441774~f22f3NzYW2466624666euoutp02n
        for <linux-acpi@vger.kernel.org>; Fri, 13 Dec 2019 06:47:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191213064714euoutp0220187a7c4cb24d356ed28133d0441774~f22f3NzYW2466624666euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576219634;
        bh=t1I5hcEKwuXV2m0d6yumfwLKzTFjTTmDrgwb3WQm/xU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PnmqBC6uIL2aUaMtaRakD8l1Dvw0AEddm89VzezJFvtFN3hYgcnIYVCQZGxxzOAx1
         ZiN3tHKZjUeLXXdOX2lWKpfLNwNervgw7/g9G+SeSgXVJWiRmtb5gR6/wfrHoGAkEM
         DUOXs7PxMyhFxwXIRUnBcbnhg5tR/lRCKHJ8wNG8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191213064713eucas1p1e98ee455ccdf6de51019716d4e5439a4~f22fo-CLQ2911829118eucas1p1z;
        Fri, 13 Dec 2019 06:47:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F4.31.60679.1F333FD5; Fri, 13
        Dec 2019 06:47:13 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191213064713eucas1p1508810401752280046aadd43d3058e8c~f22fFQ2A03242832428eucas1p1r;
        Fri, 13 Dec 2019 06:47:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191213064713eusmtrp2154ee5a2edf9cc3dda1c6be8b0c0cc60~f22fEiHaK1280712807eusmtrp2y;
        Fri, 13 Dec 2019 06:47:13 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-e9-5df333f18d7c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 97.B1.08375.1F333FD5; Fri, 13
        Dec 2019 06:47:13 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213064712eusmtip2b7988ba4e33fa3f182d4683597bd8648~f22efyDfz2818728187eusmtip2A;
        Fri, 13 Dec 2019 06:47:12 +0000 (GMT)
Subject: Re: [PATCH v8 1/6] software node: rename is_array to is_inline
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ef1eb8d9-92f3-a4e4-f8d2-a2e247737c97@samsung.com>
Date:   Fri, 13 Dec 2019 07:47:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i3dSOSa37yWLM+zDVnMKVTkOxbyKD4vo0KVwj_uFB26Q@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRz3u+e5u6ebaz9X9JWKXWPyUsLm8bLGFm6Y1cYfXo6e9Liiu+yu
        ImaS9eLStCS5yUvhWrfCzS5XDb3otCiJpryFQ6VD3clMSk9P0X+fz+f7+ez7/WxfipA1Cr2p
        GE08q9UwsXKRhLTU/2pa2LfEqVxU1hlMZ6WcE9DD3ysRXZ9mF9O1hV2I1pusJN3cfFNM5w4a
        BbTx7mlEt1ZcENH5zXcFdOH1VILOLa8T06aqLoIucJ0lVrsrrIbXYoW55KRI8aqtSqS42BCu
        cJr9woTbJaui2NiYRFYbFBIhic60fhMeuI8PZVrck1GlVI/cKMBLoS47V6hHEkqGixHYH/YK
        eOJC0FCaNUacCCr/mITjkZwvZ0h+YERwpfY8wRMHguOFbxHn8sDrweT6MJKgKE8cCT1GLech
        cBsJ1vefxJxHhINB79CLOCzFIfC2oJbgMIlng2nwOeKyU7ESMozRvGUKNJy3k5zshsOhb2g5
        JxN4JpQ7LhA89oIO+6XRowF3i6Hdlk/yR4eC2dkr4rEH9Nhui3nsA8PW8cAJBO+aSsU8OYWg
        NSUf8a6VUGtrGS1D4AC4URHEy2ugPPUxwcmA3eGFYwp/hDvkWM6NyVLISJPx7jlgsJX9W1v9
        5CmRjeSGCc0ME+oYJtQx/N97GZElyItN0KlVrG6xhj0YqGPUugSNKnBPnNqMRl6sccjmuoMq
        BiNrEKaQfLJ0UlS/UiZkEnVJ6hoEFCH3lLLznUqZNIpJOsxq43ZrE2JZXQ2aQZFyL+mSwm6l
        DKuYeHY/yx5gteNTAeXmnYwkz/p3LMvc1RruP41ed5Rl01VbEmmLh+VWq2OFpq3MQ7BWWtSR
        HZqZHRL6+XdYZIVvYnuA54av11rypuuVIQ7/gSIy1292/9Z56dS+n9ePvGHezNq8ce8mVeRV
        85XBBVC9s+DYwAP7I4XvXJL52HS/SB2+rTPLp/ie66V914+IvFQ5qYtmgucRWh3zF7eoMDBe
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7ofjT/HGrzdJ2TR2zSdyeL/h92M
        FsfanrBbHF70gtGia/VOFovz5zewW0z5s5zJYvm+fkaLy7vmsFnMOL+PyWLRslZmiynbj7Bb
        rN7zgtli7pepzA58Hjtn3WX32LSqk83jzrU9bB7zTgZ6fN4kF8AapWdTlF9akqqQkV9cYqsU
        bWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfRvfM9a8EBgYrubXwNjLt5uxg5
        OSQETCQmvZ7M0sXIxSEksJRRYt/yJ8wQCRmJk9MaWCFsYYk/17rYIIpeM0q031zEBJIQFnCX
        WP3lMViRiECSxLpF68GKmAVusEhMunkYrEhI4COTxJ0zYSA2m4ChRNdbkEmcHLwCdhL35x4G
        28YioCqx+s9VRhBbVCBW4vvKT4wQNYISJ2c+ATqPg4NTIFDi4z9LkDCzgJnEvM0PmSFseYnt
        b+dA2eISt57MZ5rAKDQLSfcsJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4m
        RmDcbjv2c/MOxksbgw8xCnAwKvHwMqR8ihViTSwrrsw9xCjBwawkwpuq/TlWiDclsbIqtSg/
        vqg0J7X4EKMp0G8TmaVEk/OBKSWvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFq
        EUwfEwenVAOj3czuCyveSu8wlO23S/k3b4orf4LO2wdZziVr7dpWNXVkpEzappqxo9bZUufb
        wgMbfy6f+DD1QK9o5+cJatNE30vzfdzj+8xnbY+ovs7yXpH8WypPC0O9cpa71hXIsBqEOKRt
        c6pt2uiUK2ppweXeYHX8hd5HrnU15vYzLf9XpmbZ1PgsslZiKc5INNRiLipOBAAKvGg28QIA
        AA==
X-CMS-MailID: 20191213064713eucas1p1508810401752280046aadd43d3058e8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
        <20191108042225.45391-2-dmitry.torokhov@gmail.com>
        <CGME20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc@eucas1p1.samsung.com>
        <b3f6ca8b-dbdf-0cec-aa8f-47ffcc5c5307@samsung.com>
        <20191212112825.GK32742@smile.fi.intel.com>
        <CAJZ5v0i3dSOSa37yWLM+zDVnMKVTkOxbyKD4vo0KVwj_uFB26Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 12.12.2019 17:41, Rafael J. Wysocki wrote:
> On Thu, Dec 12, 2019 at 12:28 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Thu, Dec 12, 2019 at 12:12:36PM +0100, Marek Szyprowski wrote:
>>> On 08.11.2019 05:22, Dmitry Torokhov wrote:
>>>> We do not need a special flag to know if we are dealing with an array,
>>>> as we can get that data from ratio between element length and the data
>>>> size, however we do need a flag to know whether the data is stored
>>>> directly inside property_entry or separately.
>>>>
>>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Today I've noticed that this patch got merged to linux-next as commit
>>> e6bff4665c595b5a4aff173848851ed49ac3bfad. Sadly it breaks DWC3/xHCI
>>> driver operation on Samsung Exynos5 SoCs (and probably on other SoCs
>>> which use DWC3 in host mode too). I get the following errors during boot:
>>>
>>> dwc3 12000000.dwc3: failed to add properties to xHCI
>>> dwc3 12000000.dwc3: failed to initialize host
>>> dwc3: probe of 12000000.dwc3 failed with error -61
>>>
>>> Here is a full kernel log from Exynos5250-based Snow Chromebook on KernelCI:
>>>
>>> https://storage.kernelci.org/next/master/next-20191212/arm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5250-snow.txt
>>>
>>> (lack of 'ref' clk is not related nor fatal to the driver operation).
>>>
>>> The code which fails after this patch is located in
>>> drivers/usb/dwc3/host.c. Let me know if I can help more in locating the bug.
>> Thank you for report.
>>
>> I think we should not have that patch in the fist place... I used to have
>> a bad feeling about it and then forgot about it existence.
> Well, I think you mean the [2/6].
>
> The $subject one really shouldn't change functionality, we must have
> missed something here.

Nope, I was really talking about [1/6]. It looks that it revealed an 
issue in the DWC3 driver pointed by Dmitry.

> Anyway, I'll drop this branch from the linux-next one for now.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

