Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E7482A30
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 07:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiABGWr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 01:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiABGWq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 01:22:46 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2373C061401
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 22:22:45 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id by39so51118057ljb.2
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 22:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/Ej1kwtDnac4AtSox85/cR64vAMuYuA5l43/y2cDy0=;
        b=Zxci2cDHlxnWheWrT+BJuyAv+jSNKqi6Dd8NPCwhAgzylesFm6o8xd9kPsGAhpSn4/
         MBPsho2DdOEOIs1p9+Z0P8POKXyV/5gihu7hHpmgCaQ2uFFX9CG4FjQkTJ7oJCFFXRdI
         3gDrphEIKxyCEOXj2Fwp2lB+jCRvCaWw+9VuIUf0i3gfXNvTv35acAtXAhL6QdiXol3x
         vHZ+cj1VbJVxP8idZ3wumEzCWNe9TeR5mF4B4JIlahwaTLFPDpBCCeqSGyTktewkl5PY
         km5nzk/LIQdU6WwP15B8H2WpMWhMoaQSuarcCV/4cds49XnE06lZ2weH7tKc7Il1KRHC
         SS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/Ej1kwtDnac4AtSox85/cR64vAMuYuA5l43/y2cDy0=;
        b=L4q96tXflfkxeOE3+nOafhChxvU65Dinjg316pQ9DnsGk/+MiLBwBuRUc8HpAo1PXH
         g3861BONuDqXiSRM1/zEZNmPY2Snpf08NmtR6YSiBldqtad7YjnWwmajTtSlZ4M70IU8
         Q5SoaFoQsODYMp0KTlRN5S1Vmg2Sr3PTC4lMHPwGkxA09Pv9Rxs3dmhU5Q4HFB8/1kAP
         vE35bdc/cmK+bE5hwE0Ry38DrROOutKnH+5zLdX4iVEiOBV1Qw4tUsP84EMLdqbXu9Qx
         5nBRaZ0bPs1H35qiDYvR6ss93hKxK9ldidAnXP9Wxs6g6g8M+SBlRKuXxgo+H4SK+sz7
         t+Zw==
X-Gm-Message-State: AOAM532xSWz5pboB7WUaym0hF8qxsR/cd5f8b37qpBf5GunlBEfmbLS5
        m6k9zjtlDeHtsbNkw8QAJImq3wL7e7iFFFKQ7I3hEA==
X-Google-Smtp-Source: ABdhPJyBjvtM4M8NZdWc/8jY3X5hM4iv5Y0dwjXg1krJCGqwzGNt0K3l6G3z7WqmWJx1vlngWbf8PaXNd7uuZMGsb0c=
X-Received: by 2002:a05:651c:1a1f:: with SMTP id by31mr26154294ljb.266.1641104563931;
 Sat, 01 Jan 2022 22:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-6-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-6-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:22:30 +0100
Message-ID: <CACRpkdYWui=V6fyOs7NTrYvUywWtBc-2bHOJmS67HS6HAo3bug@mail.gmail.com>
Subject: Re: [PATCH 05/34] brcmfmac: pcie/sdio/usb: Get CLM blob via standard
 firmware mechanism
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

On Sun, Dec 26, 2021 at 4:37 PM Hector Martin <marcan@marcan.st> wrote:

> Now that the firmware fetcher can handle per-board CLM files, load the
> CLM blob alongside the other firmware files and change the bus API to
> just return the existing blob, instead of fetching the filename.
>
> This enables per-board CLM blobs, which are required on Apple platforms.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
