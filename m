Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34DA511DE47
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 07:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLMGoq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 01:44:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33107 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLMGop (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 01:44:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191213064443euoutp01ea8d5651fcb975ef2b1dc1ee45ac06de~f20T8d3A72943229432euoutp011
        for <linux-acpi@vger.kernel.org>; Fri, 13 Dec 2019 06:44:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191213064443euoutp01ea8d5651fcb975ef2b1dc1ee45ac06de~f20T8d3A72943229432euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576219483;
        bh=k25aPoT/OyS2r8tJ1yujHHIj/GSRAZSZZq6vu4ljcak=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iXcVxJ3pSipkLlfgeYhbSyCXru3ydHyiXhOLO3fguHLxVxHA+dK+nO3vvQQZ6Pn0p
         kqCiUrqyGWSylZlqOLxQeiksxwIjQ04BzPFnERai2KbZS0ePMVDRKtNef2v3flEssb
         SXCD5Lg4dGpNHIiSt/TFA+lz2aMl8HBDjuKpR89E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191213064443eucas1p1315089e83e86b52f5b51c831dfc72880~f20TdKSsi2828228282eucas1p1I;
        Fri, 13 Dec 2019 06:44:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 83.A3.60698.B5333FD5; Fri, 13
        Dec 2019 06:44:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191213064443eucas1p1a4fb4d43f1e151299aaa22818115ba6d~f20TKGMXI1098410984eucas1p1Z;
        Fri, 13 Dec 2019 06:44:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213064443eusmtrp1596cf1f357dcb69c6a4ffbb0dd3556c1~f20TJUG9N2569625696eusmtrp1E;
        Fri, 13 Dec 2019 06:44:43 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-de-5df3335b0ed9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 88.83.07950.B5333FD5; Fri, 13
        Dec 2019 06:44:43 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213064442eusmtip24a45183f0eee40e4606e3a048f6aee4e~f20SkmUQk2296622966eusmtip2d;
        Fri, 13 Dec 2019 06:44:42 +0000 (GMT)
Subject: Re: [PATCH v8 1/6] software node: rename is_array to is_inline
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <b8dca439-ffa3-f562-e319-3413986caaaa@samsung.com>
Date:   Fri, 13 Dec 2019 07:44:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191213012408.GH101194@dtor-ws>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3bv7q7D6XUqO5olDAxK0sSEm4kkSS6s6OVLWCOX3lR0c2xq
        miRmzXQY9mKpSytGTtE0k3L5gpmvqSxTK1TyQ2o0rZm0RflC5bxafvv9z/mf55w/PCQmNHE9
        yQRFCqNSyJLEBB9v7FkY3Hkq0CrdNW92p6/lFHPoP/MtiO7JnebRnXozorU1TTg9OFjPo4uW
        Kzl0ZVshokeaywi6ZLCNQ+sNGowuMnbx6JpWM0aX225j+5wkTboJnqShOp+QfHjfSkju9R2T
        WBu2HuVG8UNimaSENEblHxrNj5+qK+Qoa0XpHbYeIhvpXbXIgQRqNzSOthNaxCeFVBWCyYdF
        HFbYEDyZN+CssCKoLqrirY+Mdd/A2EYlgoridi4rLAiWSg2rLlcqAmpsU1w7u1H+YLy7iOyM
        Ue04vDKK7ExQAaC1aAk7C6hQMF59tzqLUz7wucC8spok3Skp5FXGsxYX6Cudxu3sQPlB95dL
        PPZJbzBayjCWRTA+fX81AlCTPDDW9ePs1eHwqz0XY9kVZnufrqXxgoFbBTg7cBnBx9e1PFYU
        IBjJKUGsay909g5x7Rdh1HZ43OzPlsPAqDFh9jJQTjBqcWGPcIKbjcVrZQHk5QpZ9zbQ9db9
        W/vyzTB2HYl1G6LpNsTRbYij+7/3AcKrkYhJVcvjGHWggjnvp5bJ1amKOL+YZHkDWvlkA797
        fzxHbctnOxBFIrGjYFPsd6mQK0tTZ8g7EJCY2E3A+FqlQkGsLOMCo0o+o0pNYtQdaDOJi0WC
        QP2MVEjFyVKYRIZRMqr1Lod08MxGJzTNmkPOFafHEo2zvseVYTX7Dz/aEkhpPMaV4d5XWjJR
        fUxnpnN/17lggTmq5KtX0NuLjkdMWRHN6aF936KDhmbvzAUTyuEFw0+PsgN+lvxnL3wsuX2R
        aUETssh0U5Z+us7keLDAu9OwOLC0x4kOmSmfn6s6aWuYU04uJn8iAsS4Ol4WsANTqWV/AcQf
        5pxgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xe7rRxp9jDSb+ZbbobZrOZPH/w25G
        i2NtT9gtDi96wWjRtXoni8X58xvYLab8Wc5ksXxfP6PF5V1z2CxmnN/HZLFoWSuzxZTtR9gt
        Vu95wWwx98tUZgc+j52z7rJ7bFrVyeZx59oeNo95JwM9Pm+SC2CN0rMpyi8tSVXIyC8usVWK
        NrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4vK6fqWCteMWhL8fYGhgXCXcx
        cnJICJhI3Dw6kbmLkYtDSGApo8SK3iuMEAkZiZPTGlghbGGJP9e62CCKXjNKLHj3BSwhLOAu
        sfrLYzBbREBfYvvsX4wgRcwCh1gkOpbuZYXoWMAksfPgRnaQKjYBQ4mutyCjODl4Bewktrdf
        BYuzCKhKPO95wQJiiwrESnxf+YkRokZQ4uTMJ2BxTgE9iaOvG8HqmQXMJOZtfsgMYctLbH87
        B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC
        o3fbsZ9bdjB2vQs+xCjAwajEw7si8VOsEGtiWXFl7iFGCQ5mJRHeVO3PsUK8KYmVValF+fFF
        pTmpxYcYTYGem8gsJZqcD0wseSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg
        +pg4OKUaGB2ZmaJFbpzP/trn1ZqvE7H0UBr7rrSKXw9/hKnM8hE/6Mlx9U7KhOesvwR26dd+
        63m05IOsq7u5iV3dkvcPL9mseC7sKRxwK5fF6cn50CWOFZ5q1g4Xd5qyB9oH/ucUWZD4+ESf
        qKrQuoRFnHcqKyzyreeKz2W2uzevW3FzYo0ai/ptV96pSizFGYmGWsxFxYkA8LD7OPQCAAA=
X-CMS-MailID: 20191213064443eucas1p1a4fb4d43f1e151299aaa22818115ba6d
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
        <20191213012408.GH101194@dtor-ws>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dmitry,

On 13.12.2019 02:24, Dmitry Torokhov wrote:
> On Thu, Dec 12, 2019 at 12:12:36PM +0100, Marek Szyprowski wrote:
>> On 08.11.2019 05:22, Dmitry Torokhov wrote:
>>> We do not need a special flag to know if we are dealing with an array,
>>> as we can get that data from ratio between element length and the data
>>> size, however we do need a flag to know whether the data is stored
>>> directly inside property_entry or separately.
>>>
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Today I've noticed that this patch got merged to linux-next as commit
>> e6bff4665c595b5a4aff173848851ed49ac3bfad. Sadly it breaks DWC3/xHCI
>> driver operation on Samsung Exynos5 SoCs (and probably on other SoCs
>> which use DWC3 in host mode too). I get the following errors during boot:
>>
>> dwc3 12000000.dwc3: failed to add properties to xHCI
>> dwc3 12000000.dwc3: failed to initialize host
>> dwc3: probe of 12000000.dwc3 failed with error -61
>>
>> Here is a full kernel log from Exynos5250-based Snow Chromebook on KernelCI:
>>
>> https://protect2.fireeye.com/url?k=df93ba76-820d14ec-df923139-0cc47a336fae-f751d8b108bc5bdf&u=https://storage.kernelci.org/next/master/next-20191212/arm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5250-snow.txt
>>
>> (lack of 'ref' clk is not related nor fatal to the driver operation).
>>
>> The code which fails after this patch is located in
>> drivers/usb/dwc3/host.c. Let me know if I can help more in locating the bug.
> Does the following help? If, as I expect, it does, I'll submit it
> formally.

Yes, it fixes the issue. If possible, please add the following tags:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

to the final patch.

> ---
>
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 5567ed2cddbec..fa252870c926f 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -88,10 +88,10 @@ int dwc3_host_init(struct dwc3 *dwc)
>   	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
>   
>   	if (dwc->usb3_lpm_capable)
> -		props[prop_idx++].name = "usb3-lpm-capable";
> +		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
>   
>   	if (dwc->usb2_lpm_disable)
> -		props[prop_idx++].name = "usb2-lpm-disable";
> +		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb2-lpm-disable");
>   
>   	/**
>   	 * WORKAROUND: dwc3 revisions <=3.00a have a limitation
> @@ -103,7 +103,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>   	 * This following flag tells XHCI to do just that.
>   	 */
>   	if (dwc->revision <= DWC3_REVISION_300A)
> -		props[prop_idx++].name = "quirk-broken-port-ped";
> +		props[prop_idx++] = PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
>   
>   	if (prop_idx) {
>   		ret = platform_device_add_properties(xhci, props);
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

