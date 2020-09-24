Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14466277982
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 21:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIXTin (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 15:38:43 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgIXTin (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 15:38:43 -0400
X-Greylist: delayed 40034 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 15:38:42 EDT
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MxVbb-1kfODR2rKz-00xvac; Thu, 24 Sep 2020 21:38:40 +0200
Received: by mail-qv1-f47.google.com with SMTP id ef16so122056qvb.8;
        Thu, 24 Sep 2020 12:38:40 -0700 (PDT)
X-Gm-Message-State: AOAM531kDPXkhiZYw7gvR8oXc2heYsLvEpV9mIKBjCPto49n89+ceUsI
        l8ZvAVFamL2KGyu/TPyXdkbklxkhLbil8skWJ34=
X-Google-Smtp-Source: ABdhPJwb2a07lzpQCrzg3jtFtJXS1gTYpcGBk/RGooNlixhivRVF08OHCGO55og0kHNqshgFEi2ogMfqzGxcRooZPQk=
X-Received: by 2002:a05:6214:1873:: with SMTP id eh19mr870293qvb.16.1600976319259;
 Thu, 24 Sep 2020 12:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
 <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com> <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
 <c4c1d999-9ab7-8988-906a-3cb6a70bc93d@gmail.com> <CAK8P3a2XegsP71yvd8Ku08_k6ecQfkU+V+t+QnjQBrJKF2MwCg@mail.gmail.com>
 <d07adfb3-9f79-c00a-cb70-e044aa0b19f8@gmail.com>
In-Reply-To: <d07adfb3-9f79-c00a-cb70-e044aa0b19f8@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 24 Sep 2020 21:38:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a23V8vug2U-9tXUOdO3DvQvEc5+GhZuQh7_HKtTavCqVQ@mail.gmail.com>
Message-ID: <CAK8P3a23V8vug2U-9tXUOdO3DvQvEc5+GhZuQh7_HKtTavCqVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
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
X-Provags-ID: V03:K1:3BIMiRbgQycvNucXKzcS5vkFqPEIq3DE+mg6SzlMWwm40f+ulB+
 Nrj3ZhQEPewWAlItOhTfoo6fJX2dZNuRXreOKr256QJ+TZXb8DXiUB3zyEzbCQcjrG8bpA5
 BpR0XJhxNl3gNe2MHCJV8KFKSNqujJy/XM7wNUmXctOkn0E/zBMS9jIblaXJuyM3qKWq51V
 Os3pkhdAqZXrcikTGLZ8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OLGtHSwCH/k=:V51WjINOskBmYYiF4aUWtl
 0nkM1XPgkorf7lcmMX+SQrvSi2HzsJXLxHs2Ebs5iiuGtV0fbXtWaNhBlvUvoMAjctODVDf7T
 UJHRxgf80Gk+q8EssMsT5OgX7VxP6/1EApjda+uTC5i35PA9gOPEaU6A2/+bII4K5P77apX6i
 OiTUxcJ4Du3CXJrZceOnE5+GgZS50B7RdTAQjd2Tohi9le8kcjdQcXqLMGwdN2fw/ULJmYPB1
 X6L5wucGA5RukUe7V/sOSJbXcPWdKW+rVi0FVDvHbkuBLtnyceKKyBF9/ZoIx/qn2h/6ygHMm
 fCjlXh7lgKZEB5OyXooEsHMjgDivugwdKORiSwQ1oArJhmCKbq1qT5CZK53qYSfBsQguPSaBI
 Z7dlDwDYYjP8+g1/vtT/t8bY1u2pKIUyeaG1jXYC89gfRc/ou8mbZYGQpZMd5yZuPes3KY2Bw
 JJfK0T2KSXC1SEVzILjwgyeOuhljg0VjXYFgWSgmmEJDrvcKTadd8XcwpOcvQKNQKT7WTBTr3
 FPuD1MxZnmBTZwpA2QilhTwJcZFAmbuRxFeFI4+5atuc5Ra5qB1OXzVcSyo0b1UfneAHrqBI5
 yXrmAYMSVtVTyzjnt4wrVhYu3Tj6Sj10XttrXK8Ml9nY4x9Ev/LyD15TX3nO7tfsPElmYUTph
 YDj5vKdnoYeDmqpy3Ddbv16sjDn6443xXq9mkWjd/AX4V2mm6CF4H6Qx0YvVbATbTrSSCXe6R
 rhJV0uTzjmSpPKFR+AhOA+QyDjoE5TzsTei2hV+FUFtQEw1xu932/E2/O0MZuvRWkUVsivVhK
 WNQ9ls/8lQwFPvuJPu76XNw0cDCCgFb4B2M6EHeZ4IaN6tjEVtOSN5dC3ou432nfaYOqx21
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 24, 2020 at 8:59 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> On 9/24/20 10:26 AM, Arnd Bergmann wrote:
> > On Thu, Sep 24, 2020 at 1:28 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:

> > Note that drivers that connect to the bus typically don't live in the
> > same subdirectory as the driver that operates the bus. E.g. the
> > battery driver would go into drivers/power/supply and the input
> > would go into drivers/input/ or drivers/hid.
>
> Right. I wonder if this also holds for devices that are directly
> dependent on a special platform though? It could make sense to have them
> under plaform/surface rather than in the individual subsystems as they
> are only ever going to be used on this platform. On the other hand, one
> could argue that having them in the subsystem directories is better for
> maintainability.

Yes, absolutely. The subsystem maintainers are the ones that are
most qualified of reviewing code that uses their subsystem, regardless
of which bus is used underneath the device, and having all drivers
for a subsystem in one place makes it much easier to refactor them
all at once in case the internal interfaces are changed or common bugs
are found in multiple drivers.

       Arnd
