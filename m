Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600E9482953
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 06:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiABFcZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 00:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiABFcZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 00:32:25 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03044C061574
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 21:32:25 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h21so39044860ljh.3
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 21:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoiQ1KQCJ264ktaBoIMzabH4DC3BnHoyNUOH7R2xfGE=;
        b=yYBSC5lysVvJJvnfgAikjlfcPvXtpBeSHCMXW02NeblK+R7M2cdUuXlPIQsC8hgj6S
         m9MClDBjLME/csDB9yr+lu2tJAczUjiZQugxQKJKJ/Y85c0/CIZyIoPEUl5o83nLjsQd
         yFYszFo2r81u/y51uN6O+HurpwmOo9M8TkZ4VgMSukjVAFnYKhDuS3QHNRSQ6xsYhBuU
         X2cMVp6CObIuuli55848qIysWAP/7IrvkE4fhng5L0fYkpzLBfjbObzyYm21uv35RX2N
         lmBWtfArOezp5xg7xGM6xXq9gv7w/3zSNrW+TqVYg/upO7oPZtc1kWklBnnTV0A7NqS3
         h1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoiQ1KQCJ264ktaBoIMzabH4DC3BnHoyNUOH7R2xfGE=;
        b=Fc9wVhRf8QEZot1TOmdo8U0T9aSgfDbJcbCv4PxU4lHLlC72MA4LI2Dw4WelEorCft
         +QQKM3RNhpXYkuUOkh5rHlw/6EH8RnaFUC5bfh68ps99PgPn2B8jyHYqDj3DebbQUxyN
         fygsMUJRmPD9V1JzpWXYBsL/j+j7AmSSk78EKBBuitQEyuPpQ0/7E9ucnKyceSwHFh/m
         xDXOaiN6lKWX+AX7nzbHSOoQXFfoVTX5QsuJQzbaljtS1kft8aMY2fP8/qrRmITg+1Tp
         EMj60ij2NmfEIKdPK9qIKmvBKKjpHl4g2+ZWIDsNczlpAxRIdAeqcLllHih5C+xBYuAZ
         x6QQ==
X-Gm-Message-State: AOAM531kj1cQI9GIIqk4FtEEAIXgvMTnKW5+JAj1RiucnYeIHjaYgIuB
        P4f63KsarsTbMMkLxGPZWHfTYO+77Lj4dmeRksW5Iw==
X-Google-Smtp-Source: ABdhPJw4xEaszeQin5r2Odu1gmvGU60LgLA3geDvlmTokl3LciZbSNZGYLPNPKmSyqjJHa3BrTln8FjKn/xFLZmC/AY=
X-Received: by 2002:a2e:7c01:: with SMTP id x1mr33669767ljc.145.1641101543185;
 Sat, 01 Jan 2022 21:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-4-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-4-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 06:31:26 +0100
Message-ID: <CACRpkdZc75XUJh7afPhcBNaVE63Ovby2HVBe+HObvURN8i84KQ@mail.gmail.com>
Subject: Re: [PATCH 03/34] brcmfmac: firmware: Support having multiple alt paths
To:     Hector Martin <marcan@marcan.st>,
        Dmitry Osipenko <digetx@gmail.com>
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

On Sun, Dec 26, 2021 at 4:37 PM Hector Martin <marcan@marcan.st> wrote:

> Apple platforms have firmware and config files identified with multiple
> dimensions. We want to be able to find the most specific firmware
> available for any given platform, progressively trying more general
> firmwares.
>
> First, add support for having multiple alternate firmware paths.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

This looks OK to me so FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Make sure Dmitry Osipenko gets to review this though, he has many
valuable insights about how the FW is loaded and helped me out a
lot when I patched this.

Yours,
Linus Walleij
