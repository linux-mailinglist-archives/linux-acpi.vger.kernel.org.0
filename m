Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C9F11CBF1
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 12:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfLLLMl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 06:12:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59746 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfLLLMl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Dec 2019 06:12:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191212111238euoutp0143bca0cd3a38c67bbeae1c50b8fe622b~fm08QcHC60034900349euoutp01x
        for <linux-acpi@vger.kernel.org>; Thu, 12 Dec 2019 11:12:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191212111238euoutp0143bca0cd3a38c67bbeae1c50b8fe622b~fm08QcHC60034900349euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576149158;
        bh=X8xeah+SEi0BE3xB3y6s2JeD+upB+iZ9N+PdKwMpYXk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qsc/TL51k9Si6wZJasPgGaRBFIQZ6B+wbC+TU5nPChWyq5/+W2F+LhMg9Tyt5xceJ
         oPsvoXS0+w2GcKa3ytsQlUkpKZ2tCPsukfMIKjsWrMNnW7qvqh5fryN+wGRSUarbPC
         v5H9i3qmuRjh29bmbA5QvEtuBdNC1p4vQa4Y0im8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191212111238eucas1p11121c594ba5f43566e04734f9dca5354~fm08BDaEb0814108141eucas1p17;
        Thu, 12 Dec 2019 11:12:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9F.96.61286.6A022FD5; Thu, 12
        Dec 2019 11:12:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc~fm07rxSx60126101261eucas1p1v;
        Thu, 12 Dec 2019 11:12:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191212111237eusmtrp2789d75c86a6071bdc0769a735476ec52~fm07q5Tjo2339223392eusmtrp2W;
        Thu, 12 Dec 2019 11:12:37 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-26-5df220a6ab06
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.E9.08375.5A022FD5; Thu, 12
        Dec 2019 11:12:37 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191212111237eusmtip2fffaf62829b080dfaee995250f0d4be8~fm07GD8l00043200432eusmtip2O;
        Thu, 12 Dec 2019 11:12:37 +0000 (GMT)
Subject: Re: [PATCH v8 1/6] software node: rename is_array to is_inline
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <b3f6ca8b-dbdf-0cec-aa8f-47ffcc5c5307@samsung.com>
Date:   Thu, 12 Dec 2019 12:12:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191108042225.45391-2-dmitry.torokhov@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjlt3vvdl1Nft4lfmX0WCRWpolRl7KsiFr4h0UPejBq1UWtOW23
        VVaQPTQ3il7G5jCtVU5aao3RWqmllsMiLcWwh6HlHy5Q5qOXSdb1Zvnf+c45H+d88NEE00BN
        olP1+zmDXqtTSeXkvbofjXOLp/Vp5v2wjGPPnrBI2OHAQ8TW5XTK2Fp7F2LNTi/JNjbekbF5
        Qw4J66g6h9jmBwVS1tpYJWHtxdkEm+d5ImOdFV0Ee2XgMrEsWO21tcnUrlsmqfr96wqpurB+
        nbrfNWUttVUev5vTpR7gDDFLd8hT7OebiQxn5CGP+x3KQhenmlEQDXg+VA8FSDOS0wwuQdDa
        YyIFgcEDCAY820ShH8Fgbic5uvH5u4kQBQeC3ttvkDh0I3A9cssElxKvBufAJ0oQJuCzCJ66
        ro2EELidgDpTlURwSXEsmLvNUgEr8FLoPBUY4Uk8E244C//wNB2KNZDrSBEtIVCfL9YIwglw
        svTSCCbwVPB0FxAiDoO3nUUSIQuwXwZ3vrVQYu+V0PPhmVTESvjsE5sCngzD3tGFkwg6Gkpl
        4nAGQfMJKxJdi6HW94oSGhF4FpQ/iBHp5eDJfkEINOBgaO0OEUsEw8V7lr+0AnJzGNEdATZf
        2b/Y6pdNxHmkso05zTbmHNuYc2z/c68i8hYK44x8WjLHx+q5g9G8No036pOjd6WnudCfL3v+
        y9d3H31p2lmDMI1U4xXt4b0ahtIe4DPTahDQhGqCwpfTo2EUu7WZhzlD+naDUcfxNSicJlVh
        iji7X8PgZO1+bi/HZXCGUVVCB03KQp5HUQEi0SWfTuXv2GKKX250STfFOOZImO1ffdaNP5eU
        tN1dZb75cE+cO+L6osdbhtgZOuX0wUsl0RRzHG9OzCk+pqpO6Br0RmWG8iuOTK7UR83J39eu
        rD9tTY3cEHJ0gQV9zEha86IyqbSck3uL3GUdFxZaVk58xq5v8TcnDPtVJJ+ijZ1NGHjtb+S8
        1alhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xe7pLFT7FGiw/bmDR2zSdyeL/h92M
        FsfanrBbHF70gtGia/VOFovz5zewW0z5s5zJYvm+fkaLy7vmsFnMOL+PyWLRslZmiynbj7Bb
        rN7zgtli7pepzA58Hjtn3WX32LSqk83jzrU9bB7zTgZ6fN4kF8AapWdTlF9akqqQkV9cYqsU
        bWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexaMJl5oLVGhXbt9xmbGCcJN/F
        yMkhIWAi8epHJ3MXIxeHkMBSRonvjxexQCRkJE5Oa2CFsIUl/lzrYoMoes0ocWl/PztIQljA
        XWL1l8esIAkRgX5GiZPts5hAHGaBR8wSyxefABslJFAscezgVbBRbAKGEl1vQUZxcvAK2Ek8
        afnABGKzCKhKLFk9DywuKhAr8X3lJ0aIGkGJkzOfgM3hFLCXaF47GcxmFjCTmLf5ITOELS+x
        /e0cKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/d
        xAiM3m3Hfm7ewXhpY/AhRgEORiUe3g7Jj7FCrIllxZW5hxglOJiVRHiPt72LFeJNSaysSi3K
        jy8qzUktPsRoCvTcRGYp0eR8YGLJK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQ
        WgTTx8TBKdXA2OwQ9o034Ysrr5t0ac6eK2GKbjstGO/4X9ui/fTK/XAF1/UijhZRdiUZhzll
        pA11+59rbp+sXrqfzabU80u32PINj7rjYoSnclz9GOzcGfp4h2W1iezXo8FCh7ku7t/0epoB
        u2upRVfYghdLzf0LCnsC/xRyzDG5+PVp9MsvViFGjxZN3RGgxFKckWioxVxUnAgAcbXCTfQC
        AAA=
X-CMS-MailID: 20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
        <20191108042225.45391-2-dmitry.torokhov@gmail.com>
        <CGME20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc@eucas1p1.samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear All,

On 08.11.2019 05:22, Dmitry Torokhov wrote:
> We do not need a special flag to know if we are dealing with an array,
> as we can get that data from ratio between element length and the data
> size, however we do need a flag to know whether the data is stored
> directly inside property_entry or separately.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Today I've noticed that this patch got merged to linux-next as commit 
e6bff4665c595b5a4aff173848851ed49ac3bfad. Sadly it breaks DWC3/xHCI 
driver operation on Samsung Exynos5 SoCs (and probably on other SoCs 
which use DWC3 in host mode too). I get the following errors during boot:

dwc3 12000000.dwc3: failed to add properties to xHCI
dwc3 12000000.dwc3: failed to initialize host
dwc3: probe of 12000000.dwc3 failed with error -61

Here is a full kernel log from Exynos5250-based Snow Chromebook on KernelCI:

https://storage.kernelci.org/next/master/next-20191212/arm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5250-snow.txt

(lack of 'ref' clk is not related nor fatal to the driver operation).

The code which fails after this patch is located in 
drivers/usb/dwc3/host.c. Let me know if I can help more in locating the bug.

> ---
>   drivers/base/swnode.c    | 12 +++++-------
>   include/linux/property.h | 13 ++++++++-----
>   2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index d8d0dc0ca5acf..18a30fb3cc588 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -108,10 +108,7 @@ static const void *property_get_pointer(const struct property_entry *prop)
>   	if (!prop->length)
>   		return NULL;
>   
> -	if (prop->is_array)
> -		return prop->pointer;
> -
> -	return &prop->value;
> +	return prop->is_inline ? &prop->value : prop->pointer;
>   }
>   
>   static const void *property_entry_find(const struct property_entry *props,
> @@ -205,7 +202,7 @@ static void property_entry_free_data(const struct property_entry *p)
>   	const char * const *src_str;
>   	size_t i, nval;
>   
> -	if (p->is_array) {
> +	if (!p->is_inline) {
>   		if (p->type == DEV_PROP_STRING && p->pointer) {
>   			src_str = p->pointer;
>   			nval = p->length / sizeof(const char *);
> @@ -250,7 +247,7 @@ static int property_entry_copy_data(struct property_entry *dst,
>   	const void *pointer = property_get_pointer(src);
>   	const void *new;
>   
> -	if (src->is_array) {
> +	if (!src->is_inline) {
>   		if (!src->length)
>   			return -ENODATA;
>   
> @@ -264,15 +261,16 @@ static int property_entry_copy_data(struct property_entry *dst,
>   				return -ENOMEM;
>   		}
>   
> -		dst->is_array = true;
>   		dst->pointer = new;
>   	} else if (src->type == DEV_PROP_STRING) {
>   		new = kstrdup(src->value.str, GFP_KERNEL);
>   		if (!new && src->value.str)
>   			return -ENOMEM;
>   
> +		dst->is_inline = true;
>   		dst->value.str = new;
>   	} else {
> +		dst->is_inline = true;
>   		dst->value = src->value;
>   	}
>   
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 48335288c2a96..dad0ad11b55e2 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -227,15 +227,17 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
>    * struct property_entry - "Built-in" device property representation.
>    * @name: Name of the property.
>    * @length: Length of data making up the value.
> - * @is_array: True when the property is an array.
> + * @is_inline: True when the property value is embedded in
> + *	&struct property_entry instance.
>    * @type: Type of the data in unions.
> - * @pointer: Pointer to the property (an array of items of the given type).
> - * @value: Value of the property (when it is a single item of the given type).
> + * @pointer: Pointer to the property when it is stored separately from
> + *	the &struct property_entry instance.
> + * @value: Value of the property when it is stored inline.
>    */
>   struct property_entry {
>   	const char *name;
>   	size_t length;
> -	bool is_array;
> +	bool is_inline;
>   	enum dev_prop_type type;
>   	union {
>   		const void *pointer;
> @@ -262,7 +264,6 @@ struct property_entry {
>   (struct property_entry) {						\
>   	.name = _name_,							\
>   	.length = (_len_) * __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
> -	.is_array = true,						\
>   	.type = DEV_PROP_##_Type_,					\
>   	{ .pointer = _val_ },						\
>   }
> @@ -293,6 +294,7 @@ struct property_entry {
>   (struct property_entry) {						\
>   	.name = _name_,							\
>   	.length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),		\
> +	.is_inline = true,						\
>   	.type = DEV_PROP_##_Type_,					\
>   	{ .value = { ._elem_ = _val_ } },				\
>   }
> @@ -311,6 +313,7 @@ struct property_entry {
>   #define PROPERTY_ENTRY_BOOL(_name_)		\
>   (struct property_entry) {			\
>   	.name = _name_,				\
> +	.is_inline = true,			\
>   }
>   
>   struct property_entry *

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

