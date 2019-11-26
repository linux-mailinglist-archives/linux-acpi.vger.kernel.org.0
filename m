Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB510A6B5
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Nov 2019 23:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfKZWmM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Nov 2019 17:42:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38168 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKZWmM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Nov 2019 17:42:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id b8so2789657qkk.5
        for <linux-acpi@vger.kernel.org>; Tue, 26 Nov 2019 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3HO6SXo/+LFIGX6UpuuHJPqUR81U5M7JzQUmD7d8F4=;
        b=JNVoCwtUcDqcAeJqQG0H4ONEwOBEfkGfYitKpXdn/mUnfBBRk379qcJGQc3WqoMCid
         mm3lwV8Kv0LCsvmwBNl06bXrsZkWMJlTQyV3eYJiPGGvu+f4yb0q1MjsqX4Llxq/xI85
         0Z+imuBHfhFL0ScLxaor4erbJbIQHO0Vr7QGHO2dYpvDQqGTjJWsN7EVBBJTby42RpXj
         WIt3gRzAJ3B8smrw4M4krpFXD3ARC3mk6ODvCBeCGT1yukOSTC3COI58rAnu0SXVCeIY
         6vokY7ppCr4xCWnnMStvZAkAIzsWg3CIce80LROaaScdLzJTS4ouWO+asL3habZg813m
         w/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3HO6SXo/+LFIGX6UpuuHJPqUR81U5M7JzQUmD7d8F4=;
        b=ViNZeETyx0RJ+Bi7Cxf9dyYd5xewpQshdh0d9yYwI8mh+cxegdvolkwfwWg9Ct0wXp
         tlIYM1F4lCSGCZCbwYX2FXm2K+V1RndTdL1IyuDGH90IBavZke0Uaj17K17+tZi+UggH
         PmQHnS4nNUzlupxH9f8YakiDRNGmdEuaXqQEPhGsR/jTXB+udOt8LWgQFNmc65k4DM7W
         N/gPmixe+WV182NlCjAtWgy9EdFZvozVGlheWu92Q+fAF6V+3p+sT3DG4+6IW2AC/Wiq
         /LPOFGcEfBwL/+1x3RKpgOS3WTPW6Rxplbi9wWWig7kVnKTn3E5nX0UTE7RtvVgGx3Bm
         Ji7w==
X-Gm-Message-State: APjAAAWFnP36xvjh0PmQ01egUralW6lB+LY9OJs8QijBOg2Besy0adnM
        1gXrKj39WO45PENbsoZzOsABbXM3YoHwqbbrImGsuA==
X-Google-Smtp-Source: APXvYqwmsBlCX7bYkD89da0RhDH7R/RYRo4OjW7ZOSqhB36GDbrQNMb4zazoXQo0f63bed/21NgM/RdqARvl2K3fxJ8=
X-Received: by 2002:ae9:e201:: with SMTP id c1mr954023qkc.416.1574808131615;
 Tue, 26 Nov 2019 14:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com> <CAJwJo6bu0Hkmneg=DuwN=v_G4pkm1JQnUWKEVcudJD5L0pjLiw@mail.gmail.com>
In-Reply-To: <CAJwJo6bu0Hkmneg=DuwN=v_G4pkm1JQnUWKEVcudJD5L0pjLiw@mail.gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Tue, 26 Nov 2019 14:42:00 -0800
Message-ID: <CA+HUmGhOEPNcUGn1-yc6Zo41wYSCO+Ch4qh6N2TDbFEfRmNvEQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: only free map once in osl.c
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 21, 2019 at 2:58 PM Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> On Wed, 20 Nov 2019 at 05:50, Francesco Ruggeri <fruggeri@arista.com> wrote:
> >
> > acpi_os_map_cleanup checks map->refcount outside of acpi_ioremap_lock
> > before freeing the map. This creates a race condition the can result
> > in the map being freed more than once.
> > A panic can be caused by running
> >
> > for ((i=0; i<10; i++))
> > do
> >         for ((j=0; j<100000; j++))
> >         do
> >                 cat /sys/firmware/acpi/tables/data/BERT >/dev/null
> >         done &
> > done
> >
> > This patch makes sure that only the process that drops the reference
> > to 0 does the freeing.
> >
> > Fixes: b7c1fadd6c2e ("ACPI: Do not use krefs under a mutex in osl.c")
> > Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
>
> Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Thanks,
>              Dmitry

Any more comments on this?
Can this be applied or is more work needed?

Thanks,
Francesco Ruggeri
