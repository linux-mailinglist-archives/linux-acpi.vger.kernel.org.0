Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3297C4829EB
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 07:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiABGD3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 01:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiABGD2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 01:03:28 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5065AC061401
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 22:03:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u13so68360296lff.12
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 22:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOSEt2UYspkO7KlpH0taqWCjFFVAh5LxlRawNiLoSCA=;
        b=tGCb3hDZ09NPFPr6FT12MbJtVURDBtkxRXV2FAUpIK+IdsXRbxxLlxD5RF8xeHOlEc
         rdmSfOvohYAfAqnQntjwxXcMrg8fpekXTKeiEFtU+MjoWUpWzrz6GxsLS2PcAK2OmQEy
         YumzH+DZG7mHqw7l6y3F2G18Ru+zT6NqLuwsAIkADGyZ4dRhzF7YoWyMV5/9RlP8Nu+b
         z51JezLya73SyPTWGXQTVea/ARxo88mAjh5xPmHLM3Y+UnVUeA3Ir/OY3xosGv89OQP1
         vyZohRjymVa7nmmoZKQUluLyyA9P0Wnp6d0ZturGsebk89CRpkHYtSDzYi333r+AjIv+
         uUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOSEt2UYspkO7KlpH0taqWCjFFVAh5LxlRawNiLoSCA=;
        b=pL6oBhxV4ocAvkAAGxL+/OzMocm4HPAIw7WXzrJ/TApL8773kf7UsO59l7uks7cHmX
         PUq0BR3+QVnKDdvut0vYVsAaBEOb5NlioU76GF3pcwIpMlIW8tEIIiChuGb69EAJ6lqa
         E5l7SYEoSTF4oQ3AtgGYURa3F2onZGUvJzSbfaQ8T09wLBORSdLh0L13mL+qKff3uxG6
         giqP9j6ucPEVC2IKYOEKJL2ggzGxBw43Hw6SJLVuWyt6f13iLoVZZmEhMJHXeqR3fp9N
         +Icg1wdZNISUe9Zr//gbDWFaUs6PGY4JXn2DR9NTu+KVtj+puoCQ0aIlyLLZDI/r7Knv
         HTjA==
X-Gm-Message-State: AOAM5300dBnfklx5tgvnjxEETWyEnL14zgXHRkBtqsJZT3wDQ1b2LlwU
        1j2V7kfU5i26WAMl6pO8R7sJk2JrrKUbWsTlq3kKDQ==
X-Google-Smtp-Source: ABdhPJyUsJK/0aqdGyEKpwuU7vg2NlhR00lEWpxX20MF2aZZkZEtuybziC46nnAcrr7lYQhYJfFsFAUfCpx4oTaGd/A=
X-Received: by 2002:a05:6512:2303:: with SMTP id o3mr36790809lfu.362.1641103406623;
 Sat, 01 Jan 2022 22:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-22-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-22-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:03:14 +0100
Message-ID: <CACRpkdaPwG7gQd6Zk81NH_u2ZzPA8=33kCThm+SPn_fywBm6AQ@mail.gmail.com>
Subject: Re: [PATCH 21/34] brcmfmac: chip: Only disable D11 cores; handle an
 arbitrary number
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

> At least on BCM4387, the D11 cores are held in reset on cold startup and
> firmware expects to release reset itself. Just assert reset here and let
> firmware deassert it. Premature deassertion results in the firmware
> failing to initialize properly some of the time, with strange AXI bus
> errors.
>
> Also, BCM4387 has 3 cores, up from 2. The logic for handling that is in
> brcmf_chip_ai_resetcore(), but since we aren't using that any more, just
> handle it here.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
