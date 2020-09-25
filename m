Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787C3278B4A
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 16:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgIYOx3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgIYOx3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 10:53:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AACC0613CE;
        Fri, 25 Sep 2020 07:53:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z19so3418367pfn.8;
        Fri, 25 Sep 2020 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFwDxojg/pSUZmy/jgMQ1wV+tRHc4oxueQ4CcPNn7Ts=;
        b=ZB/C+nlid9Nz8DsPMXDb19d+bNnVxGXq0Tu5Qjzd85rWSXbavrWVS7xTLlwXo4CBbb
         ryJwD78H62q2xycvAWQqvxCDhJwvyLMm3ibjV/gUUazdvYedD564AFxf47AQYe51Xjyo
         Bv+14t6CZrny/vP/DgZE+iiiaoWdzfhPRVRYQYqpXY1bHscPHar7j1VHz0XsqFPr+saQ
         NK1UyizuMtzDVqqEdcKdZGblboUF0Ms5qc0SldLfbEQp67lUIq4dmyHZbtuNkmH6mRXW
         YN8z4RJp8C7ofMu15teFqSpLpJL9w/N3s8Hqh3U8p0jXM3wkeGRbhQg+ABTFNeP2wy4C
         uCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFwDxojg/pSUZmy/jgMQ1wV+tRHc4oxueQ4CcPNn7Ts=;
        b=GjWND2cvOV73qF3BAjDdcKr0o+/L7bIEsBrrXEKTaQDv1F+9TJGqP3fGjLnmKlfi1/
         403MOghyogk0PSEZXCXdcIgk1yLrsg/DEMhTV2rsUsasQNHZPWno4FYEShYwZjQjhdH+
         8/Oua1muWUi6eo1nf6YY9uZeCj+llGtSecWqbJS/h1DzPYmVxaeSaDa6AjCj2OIoJ49Q
         cVrZbdSN+kQVPm4Oi/jGc8zDc25nI7XtYuoUqa2zFahfv1PC5f+SmuTufwW3GvLFGf69
         U6pjfDE+owTkQjp69ugT2VEFzmoDeFTZcMQbxMOjXVachGMuceCk7b++TLsusPrn1w+q
         FAnA==
X-Gm-Message-State: AOAM53272iTy6Pg8wNF73HEwF3awP8sz324T5ZNzXuLhsbHWtVIsxFty
        g0vRG5ZDthH56s1dbchnDZE5jYu7le2vnkGJ878=
X-Google-Smtp-Source: ABdhPJxP0fn266K0iBSoUgJkOacTuXN6kSZsM/RGexNUsaWG0MfEIFeN5mpq9A7BVeMDLXnj96RU2rkHvwYOfw2WQI4=
X-Received: by 2002:a63:4b14:: with SMTP id y20mr357764pga.203.1601045608211;
 Fri, 25 Sep 2020 07:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
 <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com> <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
 <c4c1d999-9ab7-8988-906a-3cb6a70bc93d@gmail.com> <CAK8P3a2XegsP71yvd8Ku08_k6ecQfkU+V+t+QnjQBrJKF2MwCg@mail.gmail.com>
 <d07adfb3-9f79-c00a-cb70-e044aa0b19f8@gmail.com> <CAK8P3a23V8vug2U-9tXUOdO3DvQvEc5+GhZuQh7_HKtTavCqVQ@mail.gmail.com>
In-Reply-To: <CAK8P3a23V8vug2U-9tXUOdO3DvQvEc5+GhZuQh7_HKtTavCqVQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 25 Sep 2020 17:53:10 +0300
Message-ID: <CAHp75VdGjQwzG_hESp8sQzfWjP6ccE5rMXjig94FKWmzhWOHSg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 24, 2020 at 10:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 24, 2020 at 8:59 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> > On 9/24/20 10:26 AM, Arnd Bergmann wrote:
> > > On Thu, Sep 24, 2020 at 1:28 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> > > Note that drivers that connect to the bus typically don't live in the
> > > same subdirectory as the driver that operates the bus. E.g. the
> > > battery driver would go into drivers/power/supply and the input
> > > would go into drivers/input/ or drivers/hid.
> >
> > Right. I wonder if this also holds for devices that are directly
> > dependent on a special platform though? It could make sense to have them
> > under plaform/surface rather than in the individual subsystems as they
> > are only ever going to be used on this platform. On the other hand, one
> > could argue that having them in the subsystem directories is better for
> > maintainability.
>
> Yes, absolutely. The subsystem maintainers are the ones that are
> most qualified of reviewing code that uses their subsystem, regardless
> of which bus is used underneath the device, and having all drivers
> for a subsystem in one place makes it much easier to refactor them
> all at once in case the internal interfaces are changed or common bugs
> are found in multiple drivers.

The problem is that some of the drivers are mostly reincarnation of
board files due to the platform being Windows-oriented with badly
written ACPI tables / firmware as a whole (which means a lot of quirks
are required).

-- 
With Best Regards,
Andy Shevchenko
