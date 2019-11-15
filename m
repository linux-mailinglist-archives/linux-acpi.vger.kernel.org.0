Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80535FE1C2
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2019 16:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKOPsL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Nov 2019 10:48:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39489 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfKOPsK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Nov 2019 10:48:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so8369805lfk.6
        for <linux-acpi@vger.kernel.org>; Fri, 15 Nov 2019 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKS6rtCZj8IaErcUrjRP92Wgp74E5JlJ2MHPseDiEWo=;
        b=Pic7rPYcvUsXNNtxBunu7WIK/Gtn4aqprOS1rk1gJIxywYezckGtII0nqrTVIGPXBu
         7MsWQumzkSuy4YEAkpMGQAplLbZ60ovggZ1uzw1W5aSK5lHxgNC2Wgh4POqh0FUZjHyN
         3tLPOHQNm0o9KZCS/W8rM7+FhMHSaLHt0pi2HExHuH450Gp4nOnsgb9ldXtZktmZXuHr
         hXfZXQlO6pzFI32s5eowebPHMceoXvtHTNZ5+x6iFaDAL1kwPjpoiesNixWvmRnUnpyQ
         06YbbNurlYG5puRjR/FlE7wEHtrep1feCMKcoSmeBgzheWPwwYyiZqcFqusneo1YmGJB
         3RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKS6rtCZj8IaErcUrjRP92Wgp74E5JlJ2MHPseDiEWo=;
        b=dPG8b5f/W3e6MEOfuu8GWrwVskCZoqsF0+py9BoPESHfgkRrQgx27uq25uQADg2mP3
         ycmCCForW/AQ4ydDg3PbL2jy5tSvhnvz9IwNJaaJJhtpMB1zlaemsbXgjtVK6WzNzbcT
         kLHu4wzWtkJ5iY2q4nGr8QYDG5gR7WIJq9zf4zxlABUgpnQn+WwSFLA/Rj3BRq5QcVrQ
         gsVWVLz/NGhmAhwiN8C8hUVhfE3nPr1gPM9hZBjruKw7irIm21tA8J0iBkIA7mbhDpxF
         TAFitTZoRzTrxae2BTs6CznJHyQG92QNQ1+pGUAB/fLFVo187FPl27x9yRcKnJAsyIWT
         8OJA==
X-Gm-Message-State: APjAAAXDNkPd20TVXYt/1EfKiFBSGxb3Q7tdlBs9fkQ/H/SF1Nf4cL4C
        xcLrFPuGyVPza8cbvOAVgacQAnAczaP/J61wQeeK+w==
X-Google-Smtp-Source: APXvYqyZoqBIeRRXE6Tp+xEkPnpvBKDFdlWGPub1qxgpSvfSx0sWfBaGbFbMN2YsYEXanF1TNEKAivdJG/k7sxcjKQk=
X-Received: by 2002:a19:651b:: with SMTP id z27mr11532990lfb.117.1573832888693;
 Fri, 15 Nov 2019 07:48:08 -0800 (PST)
MIME-Version: 1.0
References: <20191114102600.34558-1-hdegoede@redhat.com>
In-Reply-To: <20191114102600.34558-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Nov 2019 16:47:57 +0100
Message-ID: <CACRpkdZ6otZOsN++qTm1ZBPxSmd=T5NcyZKYfWDScuB1YrHiFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: acpi: Print pin number on
 acpi_gpiochip_alloc_event errors
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 11:26 AM Hans de Goede <hdegoede@redhat.com> wrote:

> Print pin number and error-code on acpi_gpiochip_alloc_event errors,
> to help debugging these.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Take into account that pin-number may be 16 bits
> -Also log the error-code

Patch applied.

Yours,
Linus Walleij
