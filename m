Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDCA4829D3
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 07:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiABGAy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 01:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiABGAw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 01:00:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51619C06173E
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 22:00:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x6so15657332lfa.5
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 22:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTLmkAGe0nMUNWPjMKpLbDUGkN7ojNy65opvZtoCGow=;
        b=ngXXgI5MFCua4XE6UIuvOL3zYQCZkNeU6n0Khg3UpYyr3l07WCX0OrVf4nSBfQeEbq
         alRr1JnZ3PvXvKSeNKXQboDjsFpBF8CGwnT0a2KA1dWftbkA9oU/CB2gJIdOV2xbuqz5
         Zfj/reC5Hu+RzVnaphUVbKDvy9Bk9J8R0DTJZPuEYB/7fNiZmCyOJwHIHmulsQnGt47j
         qoGpu4AeEmvW/zi77f+SQnYyOjkH/NnFGRmtH9LTYCIOtDGvoU/Lei32PPFZvC7iteGl
         k7/2fp4iU7etc8itLW19f/8h/5/9OvOupfCfEhDTnUI+zu9WUF/LKZlsTck5AWcbhWe5
         h5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTLmkAGe0nMUNWPjMKpLbDUGkN7ojNy65opvZtoCGow=;
        b=Nstdb/tZg7s06aY3s4JwhuMe5L9WUQ/BOgJqBxGfBIKMvMHCIpUsPO0yGZCYgU68Ia
         iiR/dEkJpglVbaWL3aY0Br5kkaGIBuEd5s2NGNpH8EKdHmDSzylhDAgkbkQ1V8zgZycz
         Q8tkiji8t8LTIRXG6a5tQxxf/HtDDZXTO+iIJiD0OlrezSOwoqu2H/NDzcoUdT6QoV9t
         t66JZid4Ohty6Tz0Bqc9eteLSEeFbBZzC6O9w/fIZn6ngmdGkDLnldyanSFpTsIjlKuL
         eblGMPyYiSWF18laDQ9uzTf4WhSoHTPQRLRS3xZWAFde5Y1cW5u2Mc/l9rucFr3cNTEw
         cdUg==
X-Gm-Message-State: AOAM533L0hgFa33rgttlhunYDVGbkgDZt81RDj0OYq7enmtUWbaEtdiw
        TJB1iobrIC3mikZscJadf0BfXQICx/78V/SAhGxRHQ==
X-Google-Smtp-Source: ABdhPJycF0PZrYIBhbNaYzZXJsO4SuCYCZ+KgaA+cK/5b51H/hols6a1ZdcsP/UHLOD7kBzjTTaIwnvv1hnAoxJDvUM=
X-Received: by 2002:a05:6512:39ce:: with SMTP id k14mr19035581lfu.508.1641103250662;
 Sat, 01 Jan 2022 22:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-19-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-19-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:00:38 +0100
Message-ID: <CACRpkdZ1gRO+qyEPmKMVdMcLuOdekEMye5_4gLQCdFDF8f=r0g@mail.gmail.com>
Subject: Re: [PATCH 18/34] brcmfmac: pcie: Add IDs/properties for BCM4355
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
> * hawaii: MacBook Air 13" (Late 2018)
> * hawaii: MacBook Air 13" (True Tone, 2019)
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
