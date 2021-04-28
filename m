Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149B336D781
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbhD1Mib (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:38:31 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34705 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbhD1Mib (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 08:38:31 -0400
Received: by mail-oi1-f181.google.com with SMTP id r3so9492719oic.1;
        Wed, 28 Apr 2021 05:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=242UK1h4kw9vO9eTAPxNIGHP5gMqLpb7shCVDX9s6a4=;
        b=OQSb8WEuGdDsPqPqvMu8OSBNLSgcdWxEjB83lyB6N7aQFKyg9/sR4cAwBcoWhWJXfo
         iAhaBx7vmMN/4AkQ+yDlEjlqreA5Iypmccvbv9jN8jNYSfrnvkdZ8YIZzI4N7jo5jfEs
         0N+2jiPY0riqO1y5bj6tCV+ykZ6gkJMyZxg2sAuPUKswcHqhn1/FC4d0KqfTbvEgYM4n
         js3bMUNwW91nvrqwH0LF9cDdgD0/pLqIdkAb9AfUtu87i5xGc6kBIfxsvf2Yh8vHkJwv
         4RvUSh9opaUlBx/UFK5MwxRdcC4qQCWhA2O0ic8tEfGCmd/geVQIL1KA+UfFTUQL8k3n
         G1eQ==
X-Gm-Message-State: AOAM5334Rfr5FZuDBJgj6wa7BbX8z8ygJairup4xGinP/9ujyEtC28c7
        uTJZEU0ekazP5MxEcdI+XDSxpaQ/hMnZkuy1uxojPVRo
X-Google-Smtp-Source: ABdhPJzatlyRpL0+4/W1VHR7JvgooF3FYWdjEs8HbXgX5Bh4yxfx+R/ZUKCKV9MgrzQDdoaCj691mLF0jqlISsHxqUM=
X-Received: by 2002:aca:bc89:: with SMTP id m131mr20241934oif.71.1619613466041;
 Wed, 28 Apr 2021 05:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210428110536.edy74gsobkgtd6al@ubuntu> <YIlCzOl/rkYeOWVW@kroah.com>
 <56ea648f-3742-6dd6-9deb-5f1ba441905f@perex.cz> <YIlT0KKfT6QaE8mz@unreal> <20210428123205.nkxunwubdogjyvmq@burgerking>
In-Reply-To: <20210428123205.nkxunwubdogjyvmq@burgerking>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Apr 2021 14:37:33 +0200
Message-ID: <CAJZ5v0hRBYtAG-_PUDN5WiDYhW0jcGDMMb7frd0G5x0+KwcY8Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 28, 2021 at 2:32 PM B K Karthik <bkkarthik@pesu.pes.edu> wrote:
>
> On 21/04/28 03:23PM, Leon Romanovsky wrote:
> > On Wed, Apr 28, 2021 at 02:17:00PM +0200, Jaroslav Kysela wrote:
> > > Dne 28. 04. 21 v 13:11 Greg KH napsal(a):
> > > > On Wed, Apr 28, 2021 at 04:35:36PM +0530, Anupama K Patil wrote:
> > > >> isapnp code is very old and according to this link
> > > >> https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
> > > >> from Wikipedia, even Windows Vista disabled ISA PnP by default.
> > > >>
> > > >> This change is in follow up to
> > > >> https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
> > > >> and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu/T/#u
> > > >>
> > > >> Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > > >> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> > > >
> > > > Has the maintainer said this is unsupported?
> > >
> > > I've no idea, if there're any users at the time, but there are many drivers
> > > which depend on this code.
> >
> > IMHO, this is exactly "Odd fixes" - code not really dead, but not really
> > alive too.
>
> Okay! Does this have to come around as a v2 with 'Odd Fixes' instead of obsolete?
> Or should that be a separate patch?
>
> Or should we just wait for the maintainer's reply?
> Sorry i'm a little confused.

I don't think that the MAINTAINERS entry needs to be updated.

Technically, this code is maintained, but because the availability of
systems on which to test changes is kind of limited, intrusive
functional changes in it should better be avoided.

Thanks!
