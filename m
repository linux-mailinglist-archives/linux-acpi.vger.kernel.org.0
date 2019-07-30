Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7127B5F4
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2019 00:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfG3W6C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jul 2019 18:58:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35654 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbfG3W6C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jul 2019 18:58:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id p197so45917911lfa.2
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jul 2019 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOa/eOdf8nGVianCf7QdDXN00Pv7cigGpgKKYde9+74=;
        b=azFlaHoj2pnGJQTSpeaxBoinHQBeFIZ2FvXvaION9nXWkwMXA2oNzk+eyR97IT18yk
         nyap42nFYXbUMLK20A8LXm+bGk4DZkFd8U5LN1CkSiJxKxvnW9O4Fvw10fA1Y4MG+3tU
         tWC/MstUroCJ83KKchgf1ll4xxr1qF9OOWHfTsSmQPgl9rFm4UsETKzl5bu0hF8zw1OH
         uaS+ryPlQLmL3uq7AQtcDXexLvcehy5XYmOj2xXsX8lk5LgKcF2HO9feIfJbU9dX0hWp
         ksfAGA8DaJI4EbmXtT1ZkUiHkxjQq2iLk1gw/x8SBjb4ObsJEXteWXH9BaDRgCqezihQ
         bc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOa/eOdf8nGVianCf7QdDXN00Pv7cigGpgKKYde9+74=;
        b=O6sa+JSuVmzmMNOXVcFNdT4nbAc5PhIMOPgxXzmE5j7ILpq9oOTrkip0uWJtO1mu3S
         ehVOrr4cBTm38RiZU3AxrXQUquFEKFZh1F3OhjAV6bOezAznILlvMJWk13wM36F8OjzO
         kuyRD5gHfKtv5FKuCABMnMwgnYmuY5JofCyl4oMAJqq1nhaI+Mk/+mcJ71vQJ13KDWSK
         RO8UQIJEu+GUjW+r5uRIPO8pghiOrDLKwWX22Uu7qiKP38e/qdIXcCMB48Guu6U3+nzk
         0NB3vnjhJ0GpUxrJUrcynjLjlqdr1Tg1vYmsEkOcwEah6o3KeRH1oV+ju9v5rGv2zB7R
         QOgA==
X-Gm-Message-State: APjAAAVgheNtnoj/vDlwGC/IaVKkP3QgVIS2f6pzFEiBqxgkGBFn/oIi
        zrFbzHH9oTMbIzf+Hcx6FyzAuZ6D37XJYKpE5609Rw==
X-Google-Smtp-Source: APXvYqyyaioH5ibhGa0A9YuOGsu2iiA9QyUZjoRMMmH+vmXo09C9Rg+meEIGopvuvfiXrdyRL2XRdreSHa+rhC6OW4A=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr45567407lfp.61.1564527480182;
 Tue, 30 Jul 2019 15:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190730104337.21235-1-andriy.shevchenko@linux.intel.com> <20190730104337.21235-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190730104337.21235-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Jul 2019 00:57:48 +0200
Message-ID: <CACRpkdbbxiP_Me8S_9ajEvRQ4OL8vGuT8n2H-Fv=BrEcAV=GGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpiolib: acpi: Split ACPI stuff to gpiolib-acpi.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 30, 2019 at 12:43 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This is a follow up to the commit
>
>   f626d6dfb709 ("gpio: of: Break out OF-only code")
>
> which broke down OF parts of GPIO library. Here we do the similar to ACPI.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: Cc to ACPI people

Patch applied.

Yours,
Linus Walleij
