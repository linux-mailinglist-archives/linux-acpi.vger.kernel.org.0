Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3D14829DA
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 07:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiABGBi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 01:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiABGBi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 01:01:38 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972D3C06173E
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 22:01:37 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g11so68589617lfu.2
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 22:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++X+4IgLBv/570wWkxuv+d3gXkmfZziDfkCYW9h+SJs=;
        b=knBJo7GhK2Jk/F9CsVp2X6EbhmF36fhL3Ch9zTgeJWn1Qy/LzVwy4JJyXgWT2b6f34
         fbGzR2BPAh+MgNvWWWX/Iok78ZD1LQDE5V4M+uK/OuehMIb8hKWXE74T8o9RAmoScAi0
         tou+kA0D69AKOyV8UPnna68NTE0to+xqItixTEtGW7vCsAulOkEoFC2XjvAKWGOY5dU4
         1XLUs5ggyFU6Ub6rRRE1vTl4x9svgt0V0u1386If311tYtRluUwEqvR8sPVBKFPESCjn
         fDvVaZZSqTcFA/Kf4a48EkM0VAms2sPyAh6oKCr+Mt9TORj1pdOrbuY5anyr9dKgV42L
         WQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++X+4IgLBv/570wWkxuv+d3gXkmfZziDfkCYW9h+SJs=;
        b=WXQlVJKwsR3RExtlTURWPl4hOJMnXBYl1OKnP4JbnFYMVnS4yppMXL3heZWRyEI0qR
         BVoLRW2UYagFqBV93JrAtHRRth7HSfCvbgkYygIMVYZCd/1f7RWUO+qVFh5Yd8WAz4Ww
         P7+1F+MMKmUQnyCe7RwsrPpyrLDGkjTbCTdeKyKdKYEF/z2gOVhipicrRsrPj+kiwWrT
         eQozLxhcw/csiXh6Q2HBHbIaQv8PjYB/MR3LkxL1CFh/czOxom0TxivczCAUXQnKtrym
         9uYkCU31OF8ejHcGhDBs217+CqH1YSsrvACcHA9CXmkUxJ8yef2eMD3vHiqzGY1v9rBf
         8CKA==
X-Gm-Message-State: AOAM531aZxpPpODyteu2pKSRimff5QEhnfrupUJ9Fw/tDZcTEq5Syvq5
        Gxz6Z4x86jv7s79xM8nuNNI8XJ7IgxgOJSBWON37Fw==
X-Google-Smtp-Source: ABdhPJwo+jQV37pSOSt4QRaSzrw1bPUZLyT95BP9G5ewHKlFXkn162F6G0jabBIo80rL7nWLCT5J51HbvqCKRuYML6E=
X-Received: by 2002:a05:6512:261f:: with SMTP id bt31mr20429087lfb.400.1641103295931;
 Sat, 01 Jan 2022 22:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-20-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-20-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:01:23 +0100
Message-ID: <CACRpkdYhs9_+5iwpB7nJT6xXJ0NBtjDd97_DAxvsMXXV_jg9cA@mail.gmail.com>
Subject: Re: [PATCH 19/34] brcmfmac: pcie: Add IDs/properties for BCM4377
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

On Sun, Dec 26, 2021 at 4:39 PM Hector Martin <marcan@marcan.st> wrote:

> This chip is present on at least these Apple T2 Macs:
>
> * tahiti:  MacBook Pro 13" (2020, 2 TB3)
> * formosa: MacBook Pro 13" (Touch/2019)
> * fiji:    MacBook Air 13" (Scissor, 2020)
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
