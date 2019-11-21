Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD14105CD6
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 23:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfKUWtr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 17:49:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43442 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKUWtq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 17:49:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id p14so4613166qkm.10
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2019 14:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hA7ZeCaJ44IhniM9MrgBuv3D6rgyGtv4i7x/i/LEXnc=;
        b=VPOwDJ7M8glx/FuSXYsbzC8HGbZRK0z630Dk2T6qzrBTG9L9rBc5dGhwzzsmHCsKwi
         pitfVVmwmLyA1B6PpK4/Ox5jzFB7k/RzHWf4yHunb2h7qDRNYKlpUXuh3+d4Q+MVgTuf
         FCBLtrmoRt0JR/z8J27iALIiDQVVWCLs2TU8fFY8XCRtIstrAReDJeugpICIgPjb9h2G
         hk+57TGsyURujX3RVW72Te3grY1O9M0tQ/ETnZcTaes0JtJlev/b9fqpnnNZ0vwy6pv/
         m3CfjGet2lchinpd8y5k98ouOOgKVDIUW7QWQrpskxK1N++8IwwrRy7vpVrE6oVuk0uZ
         TDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hA7ZeCaJ44IhniM9MrgBuv3D6rgyGtv4i7x/i/LEXnc=;
        b=Kq7S0VIy5RHLq/xWD1HgrFn/AnxpVsX73y3/Noy6Mv5ZPrhjsSIpACvD6yeKk4vgGh
         nPQbgWQ4n8OqHINtwu0DewrLuW/NGr1pkyDEtlDNbF3yUBVS9PeS+Ue6SXDnoUrQI/SS
         8xvg/deFFkOk3M5m6Ps2h24oXN8n9teC1jA2ATsdClN+hTlz+uu/wj9davxXfzpvhi58
         joNFDLSuBmuFrjN1XeolYxUuhVRgszYQahRF82JvL8kZawTxBaP7S20Tg9NKziktC5mI
         GhnsH/AInoiINxOwh5zJJMuf66JXjeMsX/hUMiaWa6hhyfiRKeggzJjDl2RMExGaKqt5
         X6HQ==
X-Gm-Message-State: APjAAAX8R2lOPHk05Gc2oRD+2YtJLuLmMtn6Wu8recByMFR4KYhN5oLC
        R/hIPyeiPHVWw4u/6b1Uhioz6cSMY3F6o7txTcdV871k
X-Google-Smtp-Source: APXvYqzoRC+/nFW26wmO1E4ZIlgmdO94w5XkeLkpOc3CtCYsAfp+XDLZ0GC8tvawYaTzgkZxHLp1GILN+xZnMA3gLEQ=
X-Received: by 2002:a37:4bc2:: with SMTP id y185mr780220qka.10.1574376585876;
 Thu, 21 Nov 2019 14:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com> <CAJwJo6ZTSw93zKdN3i-YqVtEEwh4qWc22Hk-emHvJth+HsaQbQ@mail.gmail.com>
In-Reply-To: <CAJwJo6ZTSw93zKdN3i-YqVtEEwh4qWc22Hk-emHvJth+HsaQbQ@mail.gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Thu, 21 Nov 2019 14:49:34 -0800
Message-ID: <CA+HUmGh+tEnP7n+_FcJuwZOF4HBgfatLwUa8a=K_BdqnKETNCw@mail.gmail.com>
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

On Thu, Nov 21, 2019 at 1:19 PM Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> Hi Francesco,
>
> I believe, there's still an issue with your patch.
>
> On Wed, 20 Nov 2019 at 05:50, Francesco Ruggeri <fruggeri@arista.com> wrote:
> > @@ -472,10 +477,11 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
> >                 mutex_unlock(&acpi_ioremap_lock);
> >                 return;
> >         }
> > -       acpi_os_drop_map_ref(map);
> > +       refcount = acpi_os_drop_map_ref(map);
> >         mutex_unlock(&acpi_ioremap_lock);
>
> Here comes acpi_os_get_iomem() increasing the refcount again.

Thanks Dmitry.
I think that any code that increments the refcount does so after
looking for map in acpi_ioremap under acpi_ioremap_lock,
and the process that drops the last reference removes map
from the list, also under acpi_ioremap_lock, so I am not sure
this could happen.
The synchronize_rcu_expedited in acpi_os_map_cleanup should
then take care of any other references to map (which it is my
understanding require acpi_ioremap_lock or rcu read lock).

Thanks,
Francesco
