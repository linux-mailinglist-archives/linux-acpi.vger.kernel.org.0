Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A0D275C3C
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Sep 2020 17:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIWPnQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 11:43:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPnN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Sep 2020 11:43:13 -0400
X-Greylist: delayed 759 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 11:43:11 EDT
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Ma1D8-1k07xz2jWG-00Vviz; Wed, 23 Sep 2020 17:30:31 +0200
Received: by mail-qt1-f179.google.com with SMTP id n10so213106qtv.3;
        Wed, 23 Sep 2020 08:30:31 -0700 (PDT)
X-Gm-Message-State: AOAM5307kOwsmtZfQPw3FcRZVF6R9vw0L9GcCOy6LgUSOHuw5dyGgvU0
        MjRygTZVbVOkdKQKjboSOZ6llH1lEfK+GAYpFRQ=
X-Google-Smtp-Source: ABdhPJyx3khV9ouMU1lDxgVnLoI4g4YiXmj0IB5rW6IHWN5WF61DmY8GCOsbNySmlU3CqZ9ohZGbz8tecEaKsFKwVrg=
X-Received: by 2002:aed:3825:: with SMTP id j34mr581207qte.7.1600875030304;
 Wed, 23 Sep 2020 08:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
In-Reply-To: <20200923151511.3842150-1-luzmaximilian@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Sep 2020 17:30:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
Message-ID: <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
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
        Dorian Stoll <dorian.stoll@tmsp.io>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8N6geTkfnb188B0H6aGTVMbLl+suW/kEDmJPmYACXe0NZkdkx0T
 0Iv2eSBTrpLTjcbWGFtPZHXyFUfmrt8b0CJkQJF2lY/YoKl0dQNRDrdi90q9vhoJ27ekbYP
 hnW2az5XXGHgmYbfrY84iNXFQOJz+JzUT0qfZRzG4VUP3VKySlOg44mLtJUbKQosYp1iOGO
 3TMl/2A6NXe2AN8sMKM5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Phmjv88EpoY=:qh7cV9XqbHbulKPMwD2F5s
 zHsyLfRN3Fh2puLdmoowscMMpUGiOvzzQo8bM2cCn/gBrqV0mjGWRHsHvFBb8VnOW0GigHUZo
 GUFe25jnD7JY6XyTlQKaxEUQzIcQEhqlvS06ClJR09pzNJvw4O0zL2AATkgI1dS5g4im+fwWb
 SWnPYsw7U9jlAUYIl90b3X2CfJzoh5nvy/VBDrvx4uvwoX4a7WAUmg5bYCquM2EFn5QXarVik
 KDq4dzSujWheHxy5zk0B1SueNbykdfSRVLh5DZopAb7qPScalHPnOooxftvoAUcAbDlsUlNu9
 oLq71PInBmAzV/mUrxBkiJ0n3Y/NUKmRXjt2JRzHv+hZLP81VYQDvibtpYWyAUIq1USGyV9Ez
 +RSQ/CZkrEuC5LpI5xnSiJCOmxvZe8WpTA1epGtg4bDl3wclyeMvO92F8mhnWsGBwS8g0J0LY
 k9NmpHaqkjHeCO8oBwOVz5+g15Fld5nADR1fVgka0SIBC5WPzfEWcR24KAiFdMhekUQPNFr56
 JKPRMf87ni+FQO8n3F3Wy9TJzL0NmrgvtVN0kbaLBNuSve86jkyvie8r4qydwLJ1Q+lwddk+Y
 ox24ozYlxLbERWa6didUOq6C9yqGoyVYjcD1A84LztqpymFS7LANPE1buQ7OSYX0vBUzYQ5Dy
 ZmndrBCCgjDhVDthRiMFj1kX9nOL6asV4NUl3PLEqxiY1BpYkLBmQLBDm9rdcETsvrszcW9By
 sGRI6jJHFb5WbWCBO9FPCIp3KS5eMMEJnYwKoHQYiYuWK+kbn8H1d/FH01bSqDj4gePvaL7xy
 1V4ezojlyv8lBa+VGcS5HIOif9YNpaGFhJZ6BjIgJSRa1lWEG/W1s5gQHd/CBQw0p8nXPDg
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> Hello,
>
> The Surface System Aggregator Module (we'll refer to it as Surface
> Aggregator or SAM below) is an embedded controller (EC) found on various
> Microsoft Surface devices. Specifically, all 4th and later generation
> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
> exception of the Surface Go series and the Surface Duo. Notably, it
> seems like this EC can also be found on the ARM-based Surface Pro X [1].

I think this should go to drivers/platform/x86 or drivers/platform/surface/
along with other laptop vendor specific code rather than drivers/misc/.

I'll have a look at the code myself, but I'd prefer to have the maintainers
for the other laptop drivers review this properly.

       Arnd
