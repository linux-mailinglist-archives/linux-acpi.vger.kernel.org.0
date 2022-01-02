Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6F6482A09
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 07:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiABGPS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 01:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiABGPR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 01:15:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE73C061746
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 22:15:17 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp20so68543276lfb.6
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 22:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWErgVPSbPgPS0cot2KuzsoxPnk5t2poaH8xxZaNOfk=;
        b=yDNjcq4g15xOFHBXQDmYyXN8EZZbyJUjHUrUfjBIRdjYkk4XhGgviRbuxzqnIhrwHI
         IAixxYAZhkVclfTndwOLRDv2dL2UFC3tvno0yBgTm6Ci0hrA+ZdiWNzdktiKBRhGGkYC
         E6EtUZpkyiqGeQxH0sK8EdwBlKyotxF5zzKj8h8sWvUTE2jqW5dOdb/cU1FUbkzE1IdF
         EXtBDALv7qNHkEoUoNMY5LVZr8458hpNNGb+T3fSDdIxhFfzPOsMhhAX1BiB2CWnlNt5
         SFU0ZapAjcGxfx6GhJHXVkO49P2FBilbj561vi4KXabYoyNo8z0uwThYrMZ7KFXNmePB
         ioBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWErgVPSbPgPS0cot2KuzsoxPnk5t2poaH8xxZaNOfk=;
        b=U9uuQxWHsvcJ/rpUaTK4DGNzSX57C7su4D3OiqD+IWmpbbUwqQ+11jrBA4F9y5vY7b
         nZwn8PH9a81395DFVnFGE45B5wYzvzgT2fxZxcAzJuc6e56mPpYjisP6DY2+U/Rk+YQv
         V7fMH/l0kVJ8ANRdNunc2MhjmsdZBoSqw+8+lg3mDJyOz3GFW3Pgk+mERRh0yMwaSJ2U
         +8d6hinA9D6V2bdsW/yFQ83ohUSilBI9weMKQ8suOXWgZGPsZGGXkjq1IcyvhmVeTK+7
         1W8zpBM+wZFN2r6+2hH05DFRetEh5LbCRsGGUx+PWMlSoZSuu8BTmE9N7R9fL9tKuObn
         tLSQ==
X-Gm-Message-State: AOAM530i0UJE28ODKhrf21/lKUZMkOhH/YBnqkHhszbyMO8/7LVEepYe
        uYvwdxMxt32Gb6N4JeZ2mZxC7OmH7i/aWsgjLbzqAA==
X-Google-Smtp-Source: ABdhPJxCopLUWq+4ft+NVnaS82/nys0iopBB2B2ZS6BEHXy52c/7c79JVhvvzJycZWI0WqHdXsCC4MjxOpz9+YpqrZs=
X-Received: by 2002:a05:6512:750:: with SMTP id c16mr37650476lfs.622.1641104115576;
 Sat, 01 Jan 2022 22:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-29-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-29-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:15:03 +0100
Message-ID: <CACRpkdYGQkTEHFNtLB=gMV-jkPWiF8mjUVv_C_rTyd7bxrYcXA@mail.gmail.com>
Subject: Re: [PATCH 28/34] brcmfmac: pcie: Replace brcmf_pcie_copy_mem_todev
 with memcpy_toio
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

> The alignment check was wrong (e.g. & 4 instead of & 3), and the logic
> was also inefficient if the length was not a multiple of 4, since it
> would needlessly fall back to copying the entire buffer bytewise.
>
> We already have a perfectly good memcpy_toio function, so just call that
> instead of rolling our own copy logic here. brcmf_pcie_init_ringbuffers
> was already using it anyway.
>
> Fixes: 9e37f045d5e7 ("brcmfmac: Adding PCIe bus layer support.")
> Signed-off-by: Hector Martin <marcan@marcan.st>

Excellent patch.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
