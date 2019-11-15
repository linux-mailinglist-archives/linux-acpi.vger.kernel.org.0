Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479F7FD882
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2019 10:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKOJLk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Nov 2019 04:11:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42924 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKOJLk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Nov 2019 04:11:40 -0500
Received: by mail-oi1-f196.google.com with SMTP id x4so67104oie.9;
        Fri, 15 Nov 2019 01:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhSO1gIvMBthCcIYFaVagEQHsOd7UGLs1OedipoLMqc=;
        b=lovYERWYyIDeDPf1W/cd2PDl/FK8oMk2Y6HdjVz8fgnehi7vmAgYoMt34tLBHdbwWu
         Z8eJ/etk2gKpdTPekc8eJ4MQzMndzCSfrjV+nqEe4DkzPsSqop97p+UY5dqMy2BLPptN
         UrwehvsuEU0mLjdJ90VL4HSBMOM3LHii3VisEhI5cPSDDDEMQBh1yVKigcGLgxZ8W7Us
         aYF46VQUplDU5vnONA6gq0nLYG+Di8ot4S1YRwIezP8ZKJq5KlhHD/Tab5XGDJ65hmCX
         frn6zyvkmA+2T4LD04xnU/J5oPcxzMxEO8QX500jMM0P3rmezjUHhSyhOy3SlI48HwvD
         xz4g==
X-Gm-Message-State: APjAAAVCnEKdgDxabph32vVKhB6/O7DW8bSP/W+7vY58Ne4B9WkBBr4E
        mz+G4JpmHvk8T4ZUfhSnYYvaqjVpDl9AoCKCQMsjPMAY
X-Google-Smtp-Source: APXvYqyWoRPYNz/S8J6cX2/Gzn9hhzRueSIqtaxfybY/4WNLjj/JZ/o5l9hXir/UzAHxM1LOv2DmGlOl8ff62y4W3Zw=
X-Received: by 2002:aca:1101:: with SMTP id 1mr7335246oir.103.1573809099105;
 Fri, 15 Nov 2019 01:11:39 -0800 (PST)
MIME-Version: 1.0
References: <1573732820166-0.post@n7.nabble.com> <0780918b-184e-55a6-a439-06403d3777ff@infradead.org>
In-Reply-To: <0780918b-184e-55a6-a439-06403d3777ff@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Nov 2019 10:11:28 +0100
Message-ID: <CAJZ5v0g4iqh22GwTKu51eXiqz-V9aiUwPi-_yyJykR+x0=9V5A@mail.gmail.com>
Subject: Re: how to disable the button kernel module?
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bruno GNUser <kernel@dantas.airpost.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 15, 2019 at 6:33 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/14/19 4:00 AM, Bruno GNUser wrote:
> > I realize that /button/ is a kernel built-in and therefore cannot be disabled
> > via the /blacklist=<module_name>/ boot parameter. So I thought I'd try
> > /initcall_blacklist=<function>/ but I cannot find an obvious module
> > initialization function in button.c
>
> In what kernel version if the button driver built-in?
> It currently can be built as a loadable module.
>
> The lines
> module_driver(acpi_button_driver, acpi_button_register_driver,
>                acpi_button_unregister_driver);
> at the end of the source file create an init function named
> acpi_button_driver_init.  You could try:
>   initcall_blacklist=acpi_button_driver_init
>
>
> > Please, how would one disable the /button/ module? Either using the
> > /initcall_blacklist=foo/ or some other method is fine, as long as it does
> > not involve recompiling the kernel.
>
> Any help from ACPI people?

https://lore.kernel.org/linux-acpi/CAJZ5v0hy2QpJtnGVvOOggOzTDifD1HYosN9vf0y_=15b+M8v0Q@mail.gmail.com/T/#t

Thanks!
