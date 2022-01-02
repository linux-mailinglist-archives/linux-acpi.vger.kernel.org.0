Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E346A4829ED
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 07:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiABGKK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 01:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiABGKJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 01:10:09 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591E3C06173F
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 22:10:09 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t14so22631861ljh.8
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 22:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfx54z3g7sfFs7JsVZzrDRW1hVLAL2mHFjv2JYjNFmE=;
        b=MO5AUuIABvQLLi+tkM6OuNl1SFRhfjnfNdZf/WF35ksOELjU+aknIlVmUV02Ge74mb
         N3E4241Z0dw7sXALiXjlHzNENbvq6pG+ee/D2LydEggYwYAa8czMTDe3mHtrOQ8e2PQm
         2xmYzsBAGAKlurQRe+J9yA0c71rgTnhonBW3Fh2rb/pu4cVvamPrnhv1qBbKx+YXBSs9
         DY8RNrjy2JeWUCKgV9ulHQY/8KTYAbQyvG1+2LvdSLzm+azP8+d1m3g8gcUuUqsjX6Kh
         9X9+2vFCALVdFZDfDXttI1v4K3ewSf+XMGm7SSRKcf55LRGb+ZYsJhypGmvUSvUqKQF0
         Cvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfx54z3g7sfFs7JsVZzrDRW1hVLAL2mHFjv2JYjNFmE=;
        b=hHRgUmW62yJrxQuIdxfPg+K23VKffilekuIDhWdCJ9apzybaEjtKvstjrTnYaB5w4V
         2FLUAIozokmPdY1DJuoYyeVtXiPERxl1RVa3yJtyXJMaRXvzh5jpUa3cLebvkDBcsIB0
         iGvGuN+eZwYK5gGlTG4oqzqaIIHpkez4xUurLAqM/zqfoBmVkBpmLhXHJdaVkUMVgsqm
         /yYXclsK2bJ+EFo9xpX6yT+E2cEEAwOMb/i0ut4ga9kta5vqZkKtizIlhdksoyBRVpGp
         JSdK9ePV3RcY3LGap9F7ey5RwuGhS8Ulpg3idQEh6Hb8pxh/rX80CjZaoWvYdzGCZL2B
         IFDg==
X-Gm-Message-State: AOAM530zWr5WTsYRvYqQhjdbnv2M9mK+Xz/U+T/GIhDvHSPSslJYMVWT
        oIedNTAcRru0doWLBpkqggBeqYliZDH/lKpv5m/juQ==
X-Google-Smtp-Source: ABdhPJxWp3CGlZRZaaUTWpT7/gu8dnteeqOe+rMzZGWFHzCxm8tDGyYTI5LyPDXA6ulkKiQb/xXECrpR2ZqPp9nlH6I=
X-Received: by 2002:a2e:8810:: with SMTP id x16mr31131176ljh.78.1641103807519;
 Sat, 01 Jan 2022 22:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-23-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-23-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:09:55 +0100
Message-ID: <CACRpkdYkMMJnL9yyXJfhTc8Rn57ChB2bZWsKs=uJNKKea2DvXg@mail.gmail.com>
Subject: Re: [PATCH 22/34] brcmfmac: chip: Handle 1024-unit sizes for TCM blocks
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

> BCM4387 has trailing odd-sized blocks as part of TCM which have
> their size described as a multiple of 1024 instead of 8192. Handle this
> so we can compute the TCM size properly.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
