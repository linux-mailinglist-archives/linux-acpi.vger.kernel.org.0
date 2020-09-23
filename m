Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2227615D
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Sep 2020 21:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWTsf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 15:48:35 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53751 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIWTse (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Sep 2020 15:48:34 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 15:48:34 EDT
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MPK73-1k6gbE2KXV-00PZmn; Wed, 23 Sep 2020 21:43:29 +0200
Received: by mail-qk1-f172.google.com with SMTP id 16so950714qkf.4;
        Wed, 23 Sep 2020 12:43:29 -0700 (PDT)
X-Gm-Message-State: AOAM531k+6cFCGvKlq9ZOn/bJk0PW5wC1hdxDa2ZeBc6uZC1UfC14jVB
        Sl488IehFXiaXiq5kGymroovDMzjMhrSk5O4dOY=
X-Google-Smtp-Source: ABdhPJyn6PBTLIZkNftTyKRiHCSe0jnGHmRoh0ig+i/aHp9NtN97mSHMr09kiJcYqk0qSH8c8idO3VOG5Tt00K+/tlE=
X-Received: by 2002:a05:620a:15a7:: with SMTP id f7mr1426063qkk.3.1600890208253;
 Wed, 23 Sep 2020 12:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com> <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com>
In-Reply-To: <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Sep 2020 21:43:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
Message-ID: <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:W2KZH/f7lez05WWj13E5feQrfDbh6fkDJF0vlt8lZht4NgLOyA0
 Z3jZXxBurib5D93Qv2fogLSqyYlEAOfU5wwbWcms4STgpwIPxwCd701gQ6Xld1Z6zTI0nVK
 3Rui5mraoL4pUNa192amiED+z7nrtv5E5m5s+82Ljui3AmsV9jZq/rX7JdE5NB/SdWCDLta
 SbXfNb0coQ1FOfPs+xZ2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sLsSeXvckVs=:EsiTAwKr3Sfttf0XpxaUW8
 ApnkyAsScsHVin/McCNWTOVwZJUf3GzhpzoPMATXjqB0w3ikVKlYaKeGiVP4rhLdUgZy+m8Lg
 CbSTUXcNZ5S6zA41mZe1WhSB/hk0FGv2lmLccYnjVsSQXBlWImRWi7LzzF4gq52FUK3s0aeuz
 50c+WlfzWL8tY7Qm+Kw21otQ2F+xEZtC+VQkSBWWiV2M3Nm+HDklKuDms0KF3Y+yd/goXWEn6
 o9NPZpviBG/F4niZXDtsvu6BSQZh4huq46xXQEfUvvkMBYxx0mNOPyjFsPTGLeeQ54B9z1lbF
 bhz16gdOm90HLnI37L8HTLeg3Km5+pj17+s9IUWvxK6tVJmZt6MNMzxNGSTmIBugtt8LUfft5
 jFJEAH7LKVrnNmlowzsdwgaKc3zmSic4hg2TkvNnhdwguotLgjp3OfpHOYLOC/LVTQWrgBMmo
 pRhV/hp59JEGQM4F9lB+c7DyICbEjMnCxYnQ4Ez8DbO4u5TRc1LFQpvbtsQLbgQFQ+DiBk66A
 FyQnGV6eGIMiS2Zq60EZ9i8tIIvtqxKa6jcQY9uq/tlhAeq5tWu1D2wXx6Hs3+m63umV6V/M4
 tsJrdjX+69N5gI1gIUIUZAk+kkw/1UUmiJLh+RfhPQ+vkJ7B5BHEuCxgANW9K0QLmDeZisCtQ
 pS2jnDFBECgz2Bnaxjv8HQac8sYrhDGwgYs8n2mRsU+ATkgieAHrbivzDdKqV2XLntza9hqse
 fqzYOA+sQFAcY2yyCxoPJ3mqzScUa+DO2aYzFKwtyBV623SqRQ2TH37vFfbZVRcRwq1kFXuun
 vDFjUKWOEiLOy685vAuthBFnZjtT/tSSZtdDQD4i8xkNXayRV0dSC6/fyUL7MeiYkcI5zQ/Mw
 wjEsGzoJJH03rFj3jFgRAje5LLYmOb3DvGF/TqibWicrb+o32S1lY711mHj5243CxEoy3VbJU
 MrX3iWIbG6sWSx8weWQTxqzggkQk2fyMJm3147yX8F4Ipq8yaGRoJ
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 23, 2020 at 5:43 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 9/23/20 5:30 PM, Arnd Bergmann wrote:
> > On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> >>
> >> Hello,
> >>
> >> The Surface System Aggregator Module (we'll refer to it as Surface
> >> Aggregator or SAM below) is an embedded controller (EC) found on various
> >> Microsoft Surface devices. Specifically, all 4th and later generation
> >> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
> >> exception of the Surface Go series and the Surface Duo. Notably, it
> >> seems like this EC can also be found on the ARM-based Surface Pro X [1].
> >
> > I think this should go to drivers/platform/x86 or drivers/platform/surface/
> > along with other laptop vendor specific code rather than drivers/misc/.
>
> I initially had this under drivers/platform/x86. There are two main
> reasons I changed that: First, I think it's a bit too big for
> platform/x86 given that it basically introduces a new subsystem. At this
> point it's really less of "a couple of odd devices here and there" and
> more of a bus-type thing. Second, with the possibility of future support
> for ARM devices (Pro X, Pro X 2 which is rumored to come out soon), I
> thought that platform/x86 would not be a good fit.

I don't see that as a strong reason against it. As you write yourself, the
driver won't work on the arm machines without major changes anyway,
and even if it does, it fits much better with the rest of it.

If you are worried about the size of the directory,
drivers/platform/x86/surface/
would also work.

> I'd be happy to move this to platform/surface though, if that's
> considered a better fit and you're okay with me adding that. Would make
> sense given that there's already a platform/chrome, which, as far as I
> can tell, also seems to be mainly focused on EC support.

Yes, I think the main question is how much overlap you see functionally
between this driver and the others in drivers/platform/x86.

      Arnd
