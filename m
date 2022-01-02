Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58A1482A02
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 07:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiABGOA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 01:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiABGOA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 01:14:00 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6F8C061746
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 22:13:59 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g11so68632874lfu.2
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 22:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sMkTbPGbS0cdXIJfh5+hY6EL0S/5OB7ShD5HL8BaBM=;
        b=rmQuPjCG2uqpfl7GAsWopsTum5R+urfC4iVA+Jw2YDMc4nMNlQVXZ98SoTT19ykAyM
         bENJgReEL1K3Q1ZQthPkm0blthX4P2W394ZPBBSpZRyaQ0WCnmdIpXcLd5qbWrupAzK1
         IRTY3defpG+7cQ4fyHKq0MS3fx7QrQxlk+wI7qq9MYAdR2KRMnGpzcQrs6Yqs5QViaUM
         HTsGMetzCPWjjVpkJxhChVR2gbSwuh8HzDZdxeTHBgJwGdxPmWPf+AQxRYcyW+9yAMJ1
         xjOrEVGTY4uvbPyeoqUqrwW4KEWYRxk60EmoBcNZcvXlWJ7rAd7UXDb4y3frdrpemIhR
         Sqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sMkTbPGbS0cdXIJfh5+hY6EL0S/5OB7ShD5HL8BaBM=;
        b=URiRpc7eQ69CxqFQpgQUGy5BKfe8fx+Bzetn7MOYeAVJTF5DV/CjZZMKv7O64ehMp/
         uo4Se8d+Rn4cP0m4UtIC5i+qrYcS4wIN9hsM/k7VR1osB0z/PwBNQ7V386JoeJrmR+AT
         jwXdm+qjP/QSLqaGUNJ5P7x8NhoPf/5Dj+IRhaZeg2WLKqCNeWxxMD9qZjR+p+eZ9B6L
         8TwSWTuGvFRKYHMq+f/QhGO4tiIYjg1+8IB9rPuaAJT3xV5oGkTzAl04jlOEDEaqq4yj
         liKVavDx8LNdXnbYNepN1GJwg9WmreVanCsTaJpyy1yxnkixLKZDKTiWUEkVlL/yumdn
         rMew==
X-Gm-Message-State: AOAM533foOlHfKS+EJJTujglE9w/FwFRozEMuKPDWFOsj/D5X8IqNR/d
        Ed+XjDIyYy0nDySfFQ/bRzBqDjvTzCCDm42PL0Cwpw==
X-Google-Smtp-Source: ABdhPJyCazaSB74rZNFvZ78lLcqbHNTpihP04lLu4fdMubHBanaKA0y68FD4EU6Z5Gy/QZM4n49VaW3rXzl4eiRD8EE=
X-Received: by 2002:a05:6512:118d:: with SMTP id g13mr36266419lfr.591.1641104037812;
 Sat, 01 Jan 2022 22:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-28-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-28-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:13:45 +0100
Message-ID: <CACRpkdarpOowF79TjcT_Wh5uiOzTTAL_-mxZ+tPvY0DhShAAHw@mail.gmail.com>
Subject: Re: [PATCH 27/34] brcmfmac: pcie: Add IDs/properties for BCM4387
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

> This chip is present on Apple M1 Pro/Max (t600x) platforms:
>
> * maldives   (apple,j314s): MacBook Pro (14-inch, M1 Pro, 2021)
> * maldives   (apple,j314c): MacBook Pro (14-inch, M1 Max, 2021)
> * madagascar (apple,j316s): MacBook Pro (16-inch, M1 Pro, 2021)
> * madagascar (apple,j316c): MacBook Pro (16-inch, M1 Max, 2021)
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
