Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8368A3A9EF1
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhFPP13 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 11:27:29 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:39755 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhFPP13 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 11:27:29 -0400
Received: by mail-oi1-f169.google.com with SMTP id m137so2918220oig.6;
        Wed, 16 Jun 2021 08:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFf58MJ0hBtlReoLX8yfknJv/OdwkcjxbCN+8el/7bI=;
        b=A6UizmM7z+vAA0j8a1MjLY2/pWzKv7HUAKVceUhFFRU0U+dQ5ao49KtJZeGMRxTHD8
         rUPM1rEFVJiyRNp8LMNC3vuv9tyJJXsitbHz/MbHdroLdkU6+xWFIqvIkVss6ohUqv3m
         YICViQSXF/QsQfZGbzf7gjEgvq3C83Dozn1Qektce0m2R/wgc8+GH/U10a8Uto/REdGB
         vI+8lQtKNLNmcib4V1s8g5ePTIjhuDO96hVO+DjCgAX6Bb7A7DPYYLAUxBlp3IHqkIhJ
         z6HYQUpL1One7MQUmy8iQLGlmlYLgAYuF/Cc7+VoTFLNhVV7xpz6RMTgiS1BSYc7gyik
         Uj/Q==
X-Gm-Message-State: AOAM532kxp/eq1k1fo84TDmZt/VF+0PYz9ZinXczZ1Z3T4OJw8V1UL+c
        e7uKqUATTSTAQFMHOW20s/cGRqe3rfc/LpJ/scEtBiHr
X-Google-Smtp-Source: ABdhPJy0z7vZQi7eBaPEXAXvr8e0LBd9wOl6uHR7+sNwCRWJmdelvHdamM+2ehtisscGT/EWNUrEBWNQnfR9s9artzU=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr7526616oia.157.1623857123194;
 Wed, 16 Jun 2021 08:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <3140195.44csPzL39Z@kreacher> <1881350.PYKUYFuaPT@kreacher>
 <f46533e2-1ebe-0130-9323-b045da6ea62d@redhat.com> <CAJZ5v0gZ2Fbff_g_v8t46-957=U_1nGe22sP9W=Hc-dohG8=Jg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gZ2Fbff_g_v8t46-957=U_1nGe22sP9W=Hc-dohG8=Jg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Jun 2021 17:25:12 +0200
Message-ID: <CAJZ5v0h3Tb-vzQVcr77HbtRbRB6TkB4Nf4Hb6nML2jUQ_ZEGnA@mail.gmail.com>
Subject: Re: [PATCH 2/5] ACPI: scan: Make acpi_walk_dep_device_list()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 5:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jun 16, 2021 at 4:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 6/16/21 4:22 PM, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Because acpi_walk_dep_device_list() is only called by the code in the
> > > file in which it is defined, make it static, drop the export of it
> > > and drop its header from acpi.h.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Actually, acpi_walk_dep_device_list() was split out as a
> > helper function used to implement acpi_dev_clear_dependencies()
> > because it will be used outside of drivers/acpi.
>
> Not exactly.
>
> > Specifically it will be used in the new intel_skl_int3472 driver:
> > https://patchwork.kernel.org/project/platform-driver-x86/patch/20210603224007.120560-6-djrscally@gmail.com/
>
> That driver will use acpi_dev_get_first_consumer_dev() which is based
> on acpi_walk_dep_device_list(), but still defined in
> drivers/acpi/scan.c.
>
> > Which I plan to merge into pdx86/for-next today, I've just merged
> > your linux-pm/acpi-scan PULL-req which exports acpi_walk_dep_device_list()
> > as preparation for this.
>
> No, the acpi_walk_dep_device_list() is a leftover there AFAICS.

I mean the export of it.

> If it needs to be exported in the future, that still can be done.  ATM
> the export isn't necessary.
>
> Thanks!
