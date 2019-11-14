Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA2FCE65
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 19:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKNS66 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 13:58:58 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41602 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfKNS65 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 13:58:57 -0500
Received: by mail-oi1-f171.google.com with SMTP id e9so6265295oif.8
        for <linux-acpi@vger.kernel.org>; Thu, 14 Nov 2019 10:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ms0EdeIMZHsQm/7BwxtccI6+60ouq2rKWZ3CyIyncWQ=;
        b=c3E4Ycr0+nh8nBVkmfgN4+SP2seQ2b+lwDp7nb7H00LLeX/ia0M385bxaH7fhk/wCM
         srGfEZBkiqnYtNbt+pFm26KMAshtMkUVxsR7VSIWL2yrZeigejAY/AquNSRvgnbecczA
         hWLFQmhqtVtzoZT232EJZMibM8sxWUhL611P9seSFFB8jN51ZyIqp0E+AGGdnI4V40WB
         m/EJN3h/ea98Z+Uo7a7qtAntIvljNJ9ptm4NKQWhVIzxidBzIebrurry5Y1Q2POvdT2/
         88nLzqIE330VjXAg5YT1rTDePglHH2eBxPEI839/B9HHB4C/u9FQ4nm/dc+sJ3O/k3Dm
         5glQ==
X-Gm-Message-State: APjAAAVbdPJ77xu3duHTVJ5RKfZBu1pzYOXvlmMfgLFrwAu+Wi6zLYn7
        Xai0Zer5W9hET5y599dv08isoSI6lhLz+a9iK/U=
X-Google-Smtp-Source: APXvYqwcnFCAr4ipng+s2X0sUSAKmejtb2jJo2voxaM/ix74IQ8Y6oJ0FGwAfsU2/eTGtVuBONnuh+ghotCDPWEcjq0=
X-Received: by 2002:aca:c753:: with SMTP id x80mr4516037oif.115.1573757936812;
 Thu, 14 Nov 2019 10:58:56 -0800 (PST)
MIME-Version: 1.0
References: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
 <CAJZ5v0iZ9pR8ou95q2kQnawWWmuOqpnEivRVx4H12sa4FGveSg@mail.gmail.com>
 <cd3bd414-50c8-4751-8370-6a17b3b338f6@www.fastmail.com> <CAJZ5v0hN2PrFUQkWtTB2DfDVtyGubS+iPRU7WA1wM--1R+N7kQ@mail.gmail.com>
 <2a86e8b1-c631-4705-885e-779997589751@www.fastmail.com> <CAJZ5v0hzwsuxZUKc-QdxwOnJ6xmVHBccg2ubaOYUmhnPMQKEAQ@mail.gmail.com>
 <b450cff7-f3ef-4523-b86b-d0fd0ea4923e@www.fastmail.com>
In-Reply-To: <b450cff7-f3ef-4523-b86b-d0fd0ea4923e@www.fastmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 19:58:45 +0100
Message-ID: <CAJZ5v0hCrNoEA=TKVbsG0TPLLKT1br6N7O+sSm=KDA+QwX6fOg@mail.gmail.com>
Subject: Re: how to disable the "button" kernel module?
To:     Bruno Dantas <kernel@dantas.airpost.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 7:46 PM Bruno Dantas <kernel@dantas.airpost.net> wrote:
>
> > You can try to unbind all devices handled by the button driver and see
> > if that makes any difference.  That would be as good as unloading it.
> >
> Good idea, Rafael. I gave it a try:
>
> bruno@box:~$ ls /sys/bus/acpi/drivers/button
> LNXPWRBN:00  PNP0C0D:00   PNP0C0E:00   bind         uevent       unbind
> bruno@box:~$ echo "PNP0C0D:00" | sudo tee /sys/bus/acpi/drivers/button/unbind
> PNP0C0D:00
> bruno@box:~$ echo "PNP0C0E:00" | sudo tee /sys/bus/acpi/drivers/button/unbind
> PNP0C0E:00
> bruno@box:~$ echo "LNXPWRBN:00" | sudo tee /sys/bus/acpi/drivers/button/unbind
> LNXPWRBN:00
> bruno@box:~$ ls /sys/bus/acpi/drivers/button
> bind    uevent  unbind
>
> Still, xscreensaver animations refuse to kick in while laptop lid is closed. Very mysterious, indeed...
>
> Would it be correct to say that I've excluded the button driver's devices as "culprits" in telling xscreensaver about my lid state?

Yes, it would.

> Even though this issue is somewhat trivial, I feel compelled to keep digging because of how mysterious it is to me.
> *Something* is obviously aware of the lid switch. Maybe it's my video module (i915)? Maybe it's X? Would either of
> these be able to assess the lid switch's status if all the button driver's devices are all unbound?

As I said, that may be the panel state rather than the lid switch status.

> Thanks a lot for your help!

YW
