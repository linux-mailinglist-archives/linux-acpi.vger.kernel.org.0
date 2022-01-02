Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957DD4829FC
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 07:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiABGN3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 01:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiABGN2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 01:13:28 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3419AC061401
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 22:13:28 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u22so51017986lju.7
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 22:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQZLwT+w1+Y2g2ul+2mg6iUoYfiNjzZt86lCdfnWPtA=;
        b=AW/ZNbPSLW468zW/twl9o/cgXt0oE2gt8F4kyzPQGwiulKCrpOaWwAM0cyUJ1FPKJk
         A6QNbIDZTy9H6jycg5ZpeCoAvVEmfyIIjdo3JyNI2Bhc+9jijMoFpYbDWad9ao1nxGzv
         l2D6ltASDWxaZJpXCGXEYIRszLKvpLrBVLODpBTSIWex436szk5LoV/gKPejKrDnng1z
         4BI5m2do8sdvrhOCT7NxgfYh1xc9b0e0LKCI6S7MtVpl6KHt977Da09LB2yfTeDOrSL6
         UEMNeDcgaXkmkUG3wWnTXp3OHn23qojCG9T0srXLdJc4wmrqdKZafnFL67r2CQFmmMiN
         BtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQZLwT+w1+Y2g2ul+2mg6iUoYfiNjzZt86lCdfnWPtA=;
        b=b+a++UCmTId6waXo+mYZaUN79EFC5hoBuh3I5IPzvcbOTxmA9zgjeCkJnhe/Fxym0n
         iEfKa+JUFnSHkZIoCx0P7c7ewEcdxtwXkFe6y0LBuMM0P51ZHfFafRUhVUxbM+Mu1Yvb
         6VN5HFyLsFBr7fXCU3DM/wBG0KyTetqZSGH7nSXTZdntVa1ss7qaP1D8aKvR/6eHamaA
         48SagQrUdYhYsTrQfWTTwEojluzg0x4aPxxswq5K7ub/43m/x9kvqr0VDoBPczMPnMMB
         TFDRybbHaIMMoWNSiIi3uCeb9TVy9M7nTHu2J234Gy2bUEiZ0y4FhlXly+KfQHBe1pH3
         +rHw==
X-Gm-Message-State: AOAM530q4Mb/jQo+0Pou6rL7x7XRzN3bjEi368anw5FqJagfaaZtH8Pj
        ZVgOYtBuW9cVTfPAJ4UAuJ2U88l2W6VrqOeD2UJkJQ==
X-Google-Smtp-Source: ABdhPJxM2f7u0RlwdZkYufWQhioNOnTnjJqHgjzjatwX6cpu+GxEYVnS/6kGtZs3QlqQ09MrlhCLnoOvUxy7A8YmozA=
X-Received: by 2002:a05:651c:623:: with SMTP id k35mr35568925lje.133.1641104006495;
 Sat, 01 Jan 2022 22:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-27-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-27-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:13:13 +0100
Message-ID: <CACRpkdZ4w1Ftq+UcpmYVzcESG-2tJTkUs8RViqRPv9EKmL4NLg@mail.gmail.com>
Subject: Re: [PATCH 26/34] brcmfmac: cfg80211: Pass the PMK in binary instead
 of hex
To:     Hector Martin <marcan@marcan.st>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "Daniel (Deognyoun) Kim" <dekim@broadcom.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Dec 26, 2021 at 4:40 PM Hector Martin <marcan@marcan.st> wrote:

> Apparently the hex passphrase mechanism does not work on newer
> chips/firmware (e.g. BCM4387). It seems there was a simple way of
> passing it in binary all along, so use that and avoid the hexification.
>
> OpenBSD has been doing it like this from the beginning, so this should
> work on all chips.
>
> Also clear the structure before setting the PMK. This was leaking
> uninitialized stack contents to the device.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
