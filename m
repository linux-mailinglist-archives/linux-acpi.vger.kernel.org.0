Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59A311D278
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 17:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfLLQlf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 11:41:35 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36300 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbfLLQlf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Dec 2019 11:41:35 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so911263oic.3;
        Thu, 12 Dec 2019 08:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAhkMJgoZo1BWz+qs5Xno3OsSKZ86r1MkClH94NFChM=;
        b=ZGBqSKgXkEU8zPLpGwOZI18a87nXD3r2fvq+D0pW0f6ala7KTcbSKdwgARMwzpLDo4
         /sq6isXWuLTvxs9DS/Od/BRQV71ITatVSEE8jrjkTiQI/F+F6bAy/8MAtD/lKC7CTOvu
         8yt+sbayYou0QAebyUFWnsK3+qC4E6/QN1h0DJLlpfocwiR+l7Vnz51BvA4nMGtaADPP
         dJGrGuvRiL2ONf0lcuvqYuw2Zwj9camNbSiRGy8mXJKS4lj2SLgJPOOYxROStCWYZzq5
         1zhmyYzlD73Fz09SK7yo71qm4vVCFOCALtGbpUxvPPlVEAbVv0fDDm0sLv5YVamB1UD2
         44zg==
X-Gm-Message-State: APjAAAXV64tNbqEUDxHk2raeRvNW+E07L16mGZy1zciz+572uUlwJFdh
        JLHMnQaOXQdnvrepsOLi/1WCPIFCn9o+xe1++jk=
X-Google-Smtp-Source: APXvYqz/HR4b555gMUmBfIr+En2JhqxAwZmSDSEDPYWP867i+78mHmWSktUG5yszyRCA4BCxfwarPEWTLzzeFMNk+PY=
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr5694666oij.110.1576168894436;
 Thu, 12 Dec 2019 08:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
 <20191108042225.45391-2-dmitry.torokhov@gmail.com> <CGME20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc@eucas1p1.samsung.com>
 <b3f6ca8b-dbdf-0cec-aa8f-47ffcc5c5307@samsung.com> <20191212112825.GK32742@smile.fi.intel.com>
In-Reply-To: <20191212112825.GK32742@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Dec 2019 17:41:21 +0100
Message-ID: <CAJZ5v0i3dSOSa37yWLM+zDVnMKVTkOxbyKD4vo0KVwj_uFB26Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] software node: rename is_array to is_inline
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Dec 12, 2019 at 12:28 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 12, 2019 at 12:12:36PM +0100, Marek Szyprowski wrote:
> > Dear All,
> >
> > On 08.11.2019 05:22, Dmitry Torokhov wrote:
> > > We do not need a special flag to know if we are dealing with an array,
> > > as we can get that data from ratio between element length and the data
> > > size, however we do need a flag to know whether the data is stored
> > > directly inside property_entry or separately.
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > Today I've noticed that this patch got merged to linux-next as commit
> > e6bff4665c595b5a4aff173848851ed49ac3bfad. Sadly it breaks DWC3/xHCI
> > driver operation on Samsung Exynos5 SoCs (and probably on other SoCs
> > which use DWC3 in host mode too). I get the following errors during boot:
> >
> > dwc3 12000000.dwc3: failed to add properties to xHCI
> > dwc3 12000000.dwc3: failed to initialize host
> > dwc3: probe of 12000000.dwc3 failed with error -61
> >
> > Here is a full kernel log from Exynos5250-based Snow Chromebook on KernelCI:
> >
> > https://storage.kernelci.org/next/master/next-20191212/arm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5250-snow.txt
> >
> > (lack of 'ref' clk is not related nor fatal to the driver operation).
> >
> > The code which fails after this patch is located in
> > drivers/usb/dwc3/host.c. Let me know if I can help more in locating the bug.
>
> Thank you for report.
>
> I think we should not have that patch in the fist place... I used to have
> a bad feeling about it and then forgot about it existence.

Well, I think you mean the [2/6].

The $subject one really shouldn't change functionality, we must have
missed something here.

Anyway, I'll drop this branch from the linux-next one for now.
