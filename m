Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E754829F3
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jan 2022 07:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiABGLt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jan 2022 01:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiABGLt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jan 2022 01:11:49 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D8FC06173E
        for <linux-acpi@vger.kernel.org>; Sat,  1 Jan 2022 22:11:48 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id by39so51092868ljb.2
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jan 2022 22:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLYs6RPdlYoNdW+4UL3boVj/wZ9DVO7dQZSS21vPQg8=;
        b=k1AOt9g7ctt0LaNkr2kqTxIjq3+DWOMbt5ZOTBEJA6LntouCvz3cYAhESGIrt+jF0n
         ThCPNtuYU7nqQ93Bv0wFNIvD4gbfeV0LShkAxf5Pr0L5cPrKs2+YInUWDDQu7k7SJ5p6
         dW8xprCt6mIhj1AUY+0jhZHcBb5vkt7Q955Netg7siEtQuDgaeEx8X8gGl62VSvtVW2N
         gBkrprBk9ggy11Y8xjCLCx2NbSC3yW+m+PUtZyybJOs9RAu1Jw0ErbEyapVGNta+aa2K
         zhHVlyN89pAO2JUBqUUrUym51c9J7skKnHoo0d0iNNhQOeAFJzN5W29j3j0hQ7FocYqU
         wI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLYs6RPdlYoNdW+4UL3boVj/wZ9DVO7dQZSS21vPQg8=;
        b=UCe0AW6GrwMZnW6AVGlqjNSBLg2OcGnF0JtZj4Ut0WxKeczYJVc8dLq5oRRqlB/oMv
         +k5Do10is5vuKEQOnivwrvC+yrdH3sFHW8/E+N/gfqbyvWxcFlHINe2VqcPRWmg4YBtZ
         eavcH90gxLS4dTDqJfG6lFEnqn0VLnrJvgYZ73U3aHOdO406pXAZJjiBuKWiMnoHcIH/
         HM7pNxg+Wudud2NtPwRMqe7bpuTm1UiWW0Uc3iqdemWEJgb5bkuZ0PlP7ZA+oj9LEG1P
         CgYfRSy+GIvL7F7BDxag9ZAFRuzUytGTO78hJVjvtVUEQHxPRyiwhtPjXntekKruNgmr
         /Odg==
X-Gm-Message-State: AOAM530taou8GOJkNhe4MaD3Dt2hYVmcJCneAScDv70qnw2+2DNzU/wp
        F0BZ7Wt99xvqynzw9ChDOUNC3Wkh8HHQkd/pBAkArQ==
X-Google-Smtp-Source: ABdhPJwgIObPmwk+diSjYih9QUhroCYQGoR5YghpXUjDlvzhjBXtDoMBCB6FepG9wKcYRFCuczmvG4SeU5CjPd2DRiI=
X-Received: by 2002:a2e:7c01:: with SMTP id x1mr33723616ljc.145.1641103906802;
 Sat, 01 Jan 2022 22:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-25-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-25-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:11:34 +0100
Message-ID: <CACRpkdZJnXhzDRhZt97Svf5pU5T_Xc2mfxFFnibNda7JJ8fiFQ@mail.gmail.com>
Subject: Re: [PATCH 24/34] brcmfmac: feature: Add support for setting feats
 based on WLC version
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

> The "wlc_ver" iovar returns information on the WLC and EPI versions.
> This can be used to determine whether the PMKID_V2 and _V3 features are
> supported.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
