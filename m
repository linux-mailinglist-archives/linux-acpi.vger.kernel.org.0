Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BBE1E0AC7
	for <lists+linux-acpi@lfdr.de>; Mon, 25 May 2020 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbgEYJip (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 May 2020 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389365AbgEYJip (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 May 2020 05:38:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE6C061A0E
        for <linux-acpi@vger.kernel.org>; Mon, 25 May 2020 02:38:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q8so504131qkm.12
        for <linux-acpi@vger.kernel.org>; Mon, 25 May 2020 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oKEdAjoI1we/VuEVbQqJGLPGdBpdxDDUB9LRBQgTDcY=;
        b=sO8JZxoK7V43BN2lPuEiy7UhgFl1rprudV7tKJG8/z85WHm5ErxHCz/mSMc30l92gz
         5nlHft+u8JDLYmgRbs6YD2Suxu0A7BUFRxUo+riBM6KN8bJqfBAPjKQ7ZFOceqApIYc0
         ySuo6QV2cpLmoF+kZrIoU5syKlVSEsSp7FDptjp0hqAIwWZFd8mmi3oF4hPltpDpCpNT
         qZFk7Vqk5vfO+jsSA6V64FcVfYwjkvNAioXy/qGVxX72W7G///YUP6jLmXStzjSltj0L
         oMp5cP4qHXnjqtNAbzf6pVjsJJ7FgjOt+INAVWu5oz5lTCxIm/nEcLM+ph+Lp6buubtQ
         MeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oKEdAjoI1we/VuEVbQqJGLPGdBpdxDDUB9LRBQgTDcY=;
        b=ECj2JQ2AfzK4a+mSv5hdrRZBGFNFYKhgE5QFmOzAhsN9VgNCHLb+F/kPRdVMqd5K01
         u1Wg1HJ25NZ8+n01FyZKREAptN/r6i/ZrA0AQcWAP/rHwo+mQMYOTTEOxdk27LNKJnjl
         LaJM2hwd89epz8g17q+wQw4Qg1z92bxOPOAC5CJ8WKZgKq1vrzPPsTnN1EDrhA7vmAIk
         cfzudMBML1OBMK9dCPGS4A1t3/k3t0FhUpEsWynPgZCXU5fodRmfkvhAcyV3le4stGP2
         pZGUTrMuAzBkFP0C+q+IwP8X8YaL2jIDWzGkbXXRxvKOJES6E7OLf3Kv9Pl29+5QFsTx
         50dA==
X-Gm-Message-State: AOAM532PybqjLEYnAw0RZbFui4NExAqgEKg4yJaE4VCjEB1ei47o98ZM
        JIsJCABdHkV0e25opl6C+TnDlyTkBCSWE42BhkAe7joB
X-Google-Smtp-Source: ABdhPJzNqAuz0PkeILrWKangnXOi8X46nVY1gGt6dHL2XUIhcfw2taM7EFISMxEWPxj/NsHYkkgpSiaqyLPzKOnwXaA=
X-Received: by 2002:a37:5b47:: with SMTP id p68mr26424708qkb.120.1590399523280;
 Mon, 25 May 2020 02:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com> <20200520211916.25727-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200520211916.25727-4-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 25 May 2020 11:38:32 +0200
Message-ID: <CAMpxmJVEav8tOBoMWoekfQUaLOfCNOdj6N8fYx5UQ5e_VtHs5w@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] gpio: pca935x: Allow IRQ support for driver built
 as a module
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

=C5=9Br., 20 maj 2020 o 23:19 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> Perhaps by some historical reasons the IRQ support has been allowed
> only for built-in driver. However, there is nothing prevents us
> to build it as module an use as IRQ chip.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This may have been a stand-alone patch as well, so I went ahead and
applied it for next.

Bart
