Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC89911DF90
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 09:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLMIho (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 03:37:44 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39206 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLMIhn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 03:37:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so5492241oty.6;
        Fri, 13 Dec 2019 00:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrUtcMROVbSj3bFQMrJtvcxKtecQ0YYWZGQ6UFEvpuE=;
        b=H6lumRRZfMia/fXBlvj0yzat0cyD68UyCiANSvczQJxLyOq6oAfOgLap1jr9Tn2tsn
         7TDLX5aWebiv9J3cfR3UZIOxiwzAEh/eCHW0KflOTdV3kXgIk88ehdvTCDru07C6498n
         3eAPRFv1XtTf8oIU+ohratFwAKEB3L7RVXvUs1AOSGpUwZaWPdpCj6f6DLlqTbfVtah2
         +2tTSGUcnETLd4fwfAgMg1sbheSd0wUpwj0MU9pfUKPtlndiuuHnS5Ko9OwgGBYus0H5
         ryOVoXRAsqf75liyAIK4E8qBsZj9G178YYRl0gEWTKcCR7u7g0TYN9/WlU0jLQx/lCjF
         idxg==
X-Gm-Message-State: APjAAAV6QgQ3Sd8dH+lBVpVOcnplffXI+YMLKgyqvSjNReQSo5EwpYxF
        8RLDFGmIqqpzeFCC4LAG03vr8JTVIHGDe6YsIzM=
X-Google-Smtp-Source: APXvYqzwQuxqpAXr1PaoHa2ITEuOSiCxR6CYI4S0X2/CUhtNPf5jZ7bP1wxtc/TXNOR61beC6esoVnZKEDS8l3BlkTs=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr12830287ote.118.1576226262292;
 Fri, 13 Dec 2019 00:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
 <20191108042225.45391-2-dmitry.torokhov@gmail.com> <CGME20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc@eucas1p1.samsung.com>
 <b3f6ca8b-dbdf-0cec-aa8f-47ffcc5c5307@samsung.com> <20191212112825.GK32742@smile.fi.intel.com>
 <CAJZ5v0i3dSOSa37yWLM+zDVnMKVTkOxbyKD4vo0KVwj_uFB26Q@mail.gmail.com> <ef1eb8d9-92f3-a4e4-f8d2-a2e247737c97@samsung.com>
In-Reply-To: <ef1eb8d9-92f3-a4e4-f8d2-a2e247737c97@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Dec 2019 09:37:31 +0100
Message-ID: <CAJZ5v0ggTeUURcBpdQfKHLCLCrBCVGn_uiBDMhb-GagySNBytQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] software node: rename is_array to is_inline
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 13, 2019 at 7:47 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Rafael,
>
> On 12.12.2019 17:41, Rafael J. Wysocki wrote:
> > On Thu, Dec 12, 2019 at 12:28 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >> On Thu, Dec 12, 2019 at 12:12:36PM +0100, Marek Szyprowski wrote:
> >>> On 08.11.2019 05:22, Dmitry Torokhov wrote:
> >>>> We do not need a special flag to know if we are dealing with an array,
> >>>> as we can get that data from ratio between element length and the data
> >>>> size, however we do need a flag to know whether the data is stored
> >>>> directly inside property_entry or separately.
> >>>>
> >>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>> Today I've noticed that this patch got merged to linux-next as commit
> >>> e6bff4665c595b5a4aff173848851ed49ac3bfad. Sadly it breaks DWC3/xHCI
> >>> driver operation on Samsung Exynos5 SoCs (and probably on other SoCs
> >>> which use DWC3 in host mode too). I get the following errors during boot:
> >>>
> >>> dwc3 12000000.dwc3: failed to add properties to xHCI
> >>> dwc3 12000000.dwc3: failed to initialize host
> >>> dwc3: probe of 12000000.dwc3 failed with error -61
> >>>
> >>> Here is a full kernel log from Exynos5250-based Snow Chromebook on KernelCI:
> >>>
> >>> https://storage.kernelci.org/next/master/next-20191212/arm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5250-snow.txt
> >>>
> >>> (lack of 'ref' clk is not related nor fatal to the driver operation).
> >>>
> >>> The code which fails after this patch is located in
> >>> drivers/usb/dwc3/host.c. Let me know if I can help more in locating the bug.
> >> Thank you for report.
> >>
> >> I think we should not have that patch in the fist place... I used to have
> >> a bad feeling about it and then forgot about it existence.
> > Well, I think you mean the [2/6].
> >
> > The $subject one really shouldn't change functionality, we must have
> > missed something here.
>
> Nope, I was really talking about [1/6]. It looks that it revealed an
> issue in the DWC3 driver pointed by Dmitry.

Right, but I was referring to the Andy's comment.

Cheers!
