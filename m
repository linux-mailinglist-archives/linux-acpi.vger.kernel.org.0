Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 557D4AE841
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2019 12:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389308AbfIJKfk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Sep 2019 06:35:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45597 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388481AbfIJKfk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Sep 2019 06:35:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so5335254ljb.12
        for <linux-acpi@vger.kernel.org>; Tue, 10 Sep 2019 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E17t9nsKObBUkkD0LBm1VvJsFUJUtomTh2F3C0pWBBg=;
        b=PxhAh1UA8/oxprqJ7vDTf4uNmw227REjjRYuMyrolLKKSoSEgnh4cKGRvvpCuVjjZb
         nTf7VTzl9FGS0WkPSHPqToRkOt3u2EibIaVFUW8xSBHs1O7BFylaxXmkkalSa4Dcv3kv
         GeRRA1HkVQnhC57raCgO4fm2Q0GBaeVgUUDJN6J4gkSDMaK8RRJOGehAOe2aP/7eT+CY
         yIh+DdshLaahOo1WDyvWvwyUT/vIZ4HZKeqFUhnDxTUBD7VRITghxXud1IRCNRvZTWwk
         fAzO9tOPqPBORXMLoL5lreJqxy3KytBYbFw+u4cND0CPJF1jE9kZyw01WLVi/pq0YY7G
         e8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E17t9nsKObBUkkD0LBm1VvJsFUJUtomTh2F3C0pWBBg=;
        b=KA5vIK87WcX5qz2HUJOlI+ZRrn71LGh8M70D7WmdpGj0885mgCXNXGY3ktXnT9pRdP
         JlQki1TnzRs12LfylgQH7N5J5ffY9VBoHWkPzHh5cGGRtnSFgD0OE6F5vmYnp/i+1wC2
         r6NiR43sTdgAngQzZUDXe1jdBjnnAOGa+XzXpZ3kWtPHhS91A1MMHe3OORk86O6PRTsQ
         wSmiPx1003zZeET3Jg4OJIoboEYGLgVK6Uu7qhb/bBaRaQpewBrG0r4M+/jl7zl/cdIw
         feA1uxeloWHJbyX8N8zp6t/CPKy9ual0g+0b7s32rapCpbRmViL375iFnJn4/M3tv5jG
         KKGg==
X-Gm-Message-State: APjAAAWG9/dWIOhrJHJg7nzbUYaKV4x2+CJIX61Wo+YsEetXIptOsS13
        YJ0/yoXAdItYhez7l9rEIGOTd4dvhGhMwl11+gwR8Q==
X-Google-Smtp-Source: APXvYqwqbMlISNGBlmWQOwOUdX589aFpzFerGxuMZYnIj10DzE+NZDz4XIlI/VUYIt+UMAnE5LjH+X7ugc3++ZUFV/o=
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr11399051ljo.180.1568111737980;
 Tue, 10 Sep 2019 03:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190904172624.GA76617@dtor-ws>
In-Reply-To: <20190904172624.GA76617@dtor-ws>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Sep 2019 11:35:26 +0100
Message-ID: <CACRpkdbc70pp=SwvxGTDq=-K3ofinQJuVVymFf8ere3_f_+qqA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: make acpi_can_fallback_to_crs() static
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 4, 2019 at 6:26 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> It is not used outside gpiolib-acpi.c module, so there is no need to
> export it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
