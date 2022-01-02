Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B892E4829C0
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 06:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiABFyH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 00:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiABFyG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 00:54:06 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74360C061401
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 21:54:06 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q8so35289738ljp.9
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 21:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EyGPGRrzaSpBH7dUGkqyF9/f5p7cVq7+HA/jLDDM8I=;
        b=NNatE1smYg3/3sUUusjNfeQrxJfMermAT4Cr+qcdJB9VfFeSiT/RctY7FeEvuuY2QL
         WtBAheXYk3l0zQstb37L7uXeyWycmJTXV1jEQeCypgyZkMS5atDR0NDpXspOV7Uyhbbz
         hYIStWWr2kDbCZwX/MjNlKyb2jZNO5bCVahExgzESzpX7wOFam61Uk1+JOfIm5OcjPvk
         mc5Kt6iRCEp67/Zo3UqYyUoNe/N+DpLXZSnDc3Zdf9oH2S50L8r28a0ycsEqszI9Sge1
         swbTxRYIRa6ddQtuRe9q0ODrEIrSYqZ1vovoNnhRWvvnhSzp0bEaou45lJ4JBozMPnhF
         fBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EyGPGRrzaSpBH7dUGkqyF9/f5p7cVq7+HA/jLDDM8I=;
        b=Tc3dhhj5/2s/ne3HkOLc8KtORx8fZg78PneptC4vlXpRxGHeEoVF6v34D36Zexxb2L
         WUluZZgCmghRZ0dbWayLB9zgT4eqZilzOQ4NaX3vcQjm9osv0wCWNV9u3a5hhwhUIOFZ
         bM5SMua0EfagExFyqweNBJ6Zp30YPr1XeAIn756XMa7Khwe8k+8eozZPnKbPyzRdP1P1
         9rZfCMUeFl1RPt9YjbIaFzQB/I1r2JH9n2lGb+x/Nyzlom90+9/WEj+tTT9pG8osT0ae
         HU1wVdiDi0lXqof+F/vHsxnVKLKlD2YRrGAFY9WgUyZS268ZulmDKPPQ8q2ovTl1AE9r
         /lTQ==
X-Gm-Message-State: AOAM530F+Jgt4SA+eTLjJhX5IHvMPSb7n63+khhiXq3JsFMKAe8kH7F9
        bz4zdq403kTACIx6AwgKmqd0BVUV/5ss1CApzVMJfw==
X-Google-Smtp-Source: ABdhPJzHrjb1kHLwofScAQ778QMmEbV+rQRrvFiwAD7abFYA7z7oKl1vryfquMnaBTp/+07y5iST4GnsAT4OT1vodL4=
X-Received: by 2002:a05:651c:1a1f:: with SMTP id by31mr26113708ljb.266.1641102844760;
 Sat, 01 Jan 2022 21:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-15-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-15-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 06:53:52 +0100
Message-ID: <CACRpkdZxKXMz9+PgsZCi4HEJMoM9XH1kYzGJZMrC4B_kK3zghw@mail.gmail.com>
Subject: Re: [PATCH 14/34] brcmfmac: pcie: Add IDs/properties for BCM4378
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

On Sun, Dec 26, 2021 at 4:38 PM Hector Martin <marcan@marcan.st> wrote:

> This chip is present on Apple M1 (t8103) platforms:
>
> * atlantisb (apple,j274): Mac mini (M1, 2020)
> * honshu    (apple,j293): MacBook Pro (13-inch, M1, 2020)
> * shikoku   (apple,j313): MacBook Air (M1, 2020)
> * capri     (apple,j456): iMac (24-inch, 4x USB-C, M1, 2020)
> * santorini (apple,j457): iMac (24-inch, 2x USB-C, M1, 2020)
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
