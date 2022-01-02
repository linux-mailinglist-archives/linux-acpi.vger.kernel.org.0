Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD24A482959
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 06:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiABFeU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 00:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiABFeT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 00:34:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479BBC061746
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 21:34:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x7so68423620lfu.8
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 21:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=92ZAzCrCPw0W1NFt/Y4QYxWJV7lis48854pVbK+SYG4=;
        b=qCQ7fuFvoP38NvSywvxG3zAhp9FxZ5InVyVfNdATCe0bCC9nRt2cRf2T8FZOqinAaV
         Cr9Nj3fjMNfFV8YlWFxpG/pcb6RiVKSWXCUAnLhFA/1FFmlSmLF4zb+HOgEHYg1b16sC
         KL/JJoC1mr8tNru2Oa4Jq6Sj5TNuxGaUn3SMIKIk9McaZ5Cz4iaSOvGQiIojw6cjIIyA
         X3R0ilGtEPNt9mAhqX/SMyQm2UXUC4fbpgNOZPYrJG9dglIRrW5vakche/gqdc4oCMwY
         7Jbyn5fJLTpTZJ05rpARLwPKi7amKxRgS8jrfD646IunH9Oo2hI59T1vqLTgqh3jw6kC
         BPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92ZAzCrCPw0W1NFt/Y4QYxWJV7lis48854pVbK+SYG4=;
        b=l9LoCzy7g9JXwTpJUm+UBfYQdf11XkAbuaxRuFMuQ1389XpXJ3n2xX2w14cDH8B5OF
         uOxI0rcChi8NoOCEHGd4JPdk2xYJzZBNDy6PEg8cYntXw+SKrF4lmiXLAeZqIrMIBC51
         4TnCwFJ8eJrYCtLpnzCzaXhDcQfjBgetV0J4Vod3o8yomP9XERVHcEGms2puJb0mO5sG
         +8jOQ3rkMP5vZ1vZG9rw1bfnS3Qgp+RlGQfg1mqZF1GNh3Xi/s5CJuGdq3DTzvmnCh8f
         sMp+CadqoNELfk04k/8jyOWRop11TNu/Ssif+Zek4QAk+xvfLpKog4ZwRsQhq8jJVpti
         W2UA==
X-Gm-Message-State: AOAM532KhGfIaPEXmZS5C6OJf0z9Jjrvn1bIheMs1hNjOZ5fo0rOxKSV
        LjXfZ2ZNrnV4a96ynAJtjSMU5BnzJfoa9ac7wfayzA==
X-Google-Smtp-Source: ABdhPJybDhokn+xOVsFdW+LfgnJof+m7g7TYaEEWVbC+XMFpx5jKW+mJxZ0kkJrYuc2RLM2CC8d/xzZp3Ew/OWgI5oQ=
X-Received: by 2002:a05:6512:39ce:: with SMTP id k14mr18986263lfu.508.1641101657431;
 Sat, 01 Jan 2022 21:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-7-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-7-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 06:34:05 +0100
Message-ID: <CACRpkdZaPKApKLS8jRjtg2dXvz0e_XmEVzndNQbZ34hMUaZwcA@mail.gmail.com>
Subject: Re: [PATCH 06/34] brcmfmac: firmware: Support passing in multiple board_types
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

> In order to make use of the multiple alt_path functionality, change
> board_type to an array. Bus drivers can pass in a NULL-terminated list
> of board type strings to try for the firmware fetch.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
