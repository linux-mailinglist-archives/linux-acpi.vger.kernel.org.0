Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712E64222C8
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 11:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhJEJzf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 05:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhJEJzd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 05:55:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72BCC061745;
        Tue,  5 Oct 2021 02:53:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b8so41701209edk.2;
        Tue, 05 Oct 2021 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqBff3Ef3KNLtTXqUihmgQLUfF7J6Ba5JI9GvX/qpqw=;
        b=A3uwVvQgAcTvWB7YXnbKFFRpIKc27mwIRcaIf3CwkHwH+MMtxiOR1q/ZcnL0LqS6/c
         8A0ErbtdihZhd36XSIVe8gEIyPuu03yxn7yxHmvKGL/kP4ypzlXhT0viiJdVR/bxOe9I
         2eniBRKRpwmeRTLalPhCYOUj9w3rzxcSvpgGInpf4B09OiQ714+BvTSHy97AuN0zFBY0
         Qh1yn62gVKElN2k9/a+2ihIfHukQGfdL2ye4kO7hb6zP+QZlSpSyr6/79kElYz7Xj2mR
         JHe8cQWjjwGfl74xHUQWSQvdsUeOE+YRIm8NasfWQZlCUx7ZPglYAt7H/AwKOnFVesnv
         gUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqBff3Ef3KNLtTXqUihmgQLUfF7J6Ba5JI9GvX/qpqw=;
        b=nmSBB+Ye5OA37ucKi2jrznuagrqEZpGnocEWbO19atbUSUeP8QzZkwEtaIld2+BJd+
         i2tc3lvebaMOwJ2E6Hm6icJMKKe4en2Bjcvs82x2ArCCITVXJVZJF8LYiR5xwK8rGO/q
         txLhb+Jr/3d1zDombY0BIwcIhAlQIhN6Z0YZMFyKkmEIAsoKGKwSwFIFQ2u21Ldpuljt
         3MTU1xwD/fOlxViawJ8C9ma/zWZcKAGrsnt2WbBXuhaIz4zpr9yzzFu2II2b4kZN/bN1
         /rzmTBibg7cjt0s2sSwEDZ8j0USs4Pk+abdQFbr9A7otP+z7L5xEMl4xGu29pfD4n3eP
         yJFA==
X-Gm-Message-State: AOAM533sDCz2SbT7mo4aB8IE1XdLEAfP90QE/isp0EGPNmM6O8n2yH57
        Yfi34IMyiH7YVYrHt19LX4qytgElTw2dZbgRfZI=
X-Google-Smtp-Source: ABdhPJz+hqVZWNLge79zzbiDStrJDfBslZ9U/+CorMJUX7k31oAw3jV815Fy+7wdtKn+/QK6TtYq35XnNEsGws3vLok=
X-Received: by 2002:a50:e188:: with SMTP id k8mr25656849edl.119.1633427620774;
 Tue, 05 Oct 2021 02:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <YVrM8VdLKZUt0i8R@kroah.com> <20211004121942.GA3343713@sol>
 <YVrz86m3+7wDSYlh@kuha.fi.intel.com> <20211004124701.GA3418302@sol>
 <YVr/t7AbmP/h08GX@kuha.fi.intel.com> <20211004141754.GA3510607@sol>
 <20211004152844.GA3825382@sol> <CAHp75VeBc3AN+5f680LeK8V6NpiiaPUTgE14FFonUM1W-xrjNA@mail.gmail.com>
 <20211005004035.GA29779@sol> <YVwLIWrqY9TRLjwG@smile.fi.intel.com> <YVwf7uzL1aydysVl@kuha.fi.intel.com>
In-Reply-To: <YVwf7uzL1aydysVl@kuha.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Oct 2021 12:53:04 +0300
Message-ID: <CAHp75VfZPDwwvB1sqobSVmqjSePMBPw1igrYwaTkUkxC84cOqQ@mail.gmail.com>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 5, 2021 at 12:50 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Oct 05, 2021 at 11:21:53AM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 05, 2021 at 08:40:35AM +0800, Kent Gibson wrote:

...

> > I'll see what I can do about.
>
> So, something like this (attached)?

Actually I have sent another solution:
https://lore.kernel.org/linux-gpio/20211005093731.62743-1-andriy.shevchenko@linux.intel.com/T/#u

-- 
With Best Regards,
Andy Shevchenko
