Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7BE5E8ED2
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Sep 2022 19:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiIXRQD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Sep 2022 13:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIXRQC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Sep 2022 13:16:02 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10383AE54;
        Sat, 24 Sep 2022 10:16:01 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id u28so1915328qku.2;
        Sat, 24 Sep 2022 10:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LOKoEroXBklDUC/nOoRK6LpTu77sehbETLRxe7PMdyU=;
        b=OcZBGcDTk1Lr7EnqVFQuRcsxNMRl+/WWhid/NTzEc6eK72NNrkupuuV3XyndiZP7uF
         p22o+YzfEUCpP++e1lzh2g6nDVJI+0evrgPZesBB/DFdwy3zl4UzB6d+ehYEQVJkoHqG
         nQtg3wpf3Chbouua4+tuvZHpzR4bspjmgC30Fkfk3srVCSN6riCiLQODugBu0A5fk230
         OYR76tk2qtkTmYUfJIjvuVTT/dLlZV4Rum7MMn2SljXh+EL6DLykE3vwe7T8jKM940e4
         WINr3Qr659HPxyH/P0RP4XM/XT/SN96y0uLBOrEryVZupyahZrLOAiFgcY917eQRDOEg
         bZKA==
X-Gm-Message-State: ACrzQf2PENK551zisTtlKPyc/jq2cgfbjaU2YJEMEe9v1muk8WMEAL1i
        u213nm+AJfL4iuhQAqMVEYsgJ4/KCG5bxj0Bz0s=
X-Google-Smtp-Source: AMsMyM4Dojtc+cy+QHDOB+k3YM2olfuIdpg/XIF0cetw71mCZ458M5cva4XdVH3mlb8l861IWagzdsttSg1YED6+/H4=
X-Received: by 2002:a05:620a:4008:b0:6ce:8725:cb7 with SMTP id
 h8-20020a05620a400800b006ce87250cb7mr9704726qko.480.1664039760942; Sat, 24
 Sep 2022 10:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220921230439.768185-1-djrscally@gmail.com> <b3855fe0-4b85-a442-1835-3e62456b3206@redhat.com>
In-Reply-To: <b3855fe0-4b85-a442-1835-3e62456b3206@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 19:15:49 +0200
Message-ID: <CAJZ5v0gB=jztBtmcfmuXNiNd2s+ftQRF1fqYHQApFsX_yEvkMQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add multiple-consumer support to int3472-tps68470 driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 22, 2022 at 10:55 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> On 9/22/22 01:04, Daniel Scally wrote:
> > Hello all
> >
> > At the moment there are a few places in the int3472-tps68470 driver that are
> > limited to just working with a single consuming device dependent on the PMIC.
> > There are systems where multiple camera sensors share a single TPS68470, so
> > we need to extend the driver to support them. This requires a couple of tweaks
> > to the ACPI functions to fetch dependent devices, which also assumes that only
> > a single dependent will be found.
> >
> > The v2 for this series was some time ago...it's kept falling to the back of my
> > to-do list so I've only just gotten round to it; sorry about that. v2 here:
> >
> > https://lore.kernel.org/linux-acpi/20220327161344.50477-1-djrscally@gmail.com/
>
> Rafael, I would like to merge this through the pdx86 tree may I have your
> ack for patches 1 + 2 for this. As a reminder (since it has been a while)
> here are your review remarks to v2 of patch 1:
>
> https://lore.kernel.org/platform-driver-x86/CAJZ5v0i2ciLHP-=8eQcZc0v0xCzhKHKpxLC=Kgv6W5E_5=HQJA@mail.gmail.com/
>
> (which both seem to have been addressed)
>
> AFAICT you did not have any remarks for v2 of patch 2.

No, I didn't.

However, because acpi_bus_get_acpi_device() becomes
acpi_get_acpi_dev() in my tree, I think it's better to route this
material through it, if that's not a problem.

I've tentatively queued it up for 6.1.

Thanks!

> p.s.
>
> Dan, if I want to give the IR cam a test run on my own Surface Go (version 1)
> I guess I may need a sensor driver? Where can I find that sensor driver and
> what do I need in userspace to test this ?
>
>
>
> > Daniel Scally (5):
> >   ACPI: scan: Add acpi_dev_get_next_consumer_dev()
> >   ACPI: bus: Add iterator for dependent devices
> >   platform/x86: int3472: Support multiple clock consumers
> >   platform/x86: int3472: Support multiple gpio lookups in board data
> >   platform/x86: int3472: Add board data for Surface Go2 IR camera
> >
> >  drivers/acpi/scan.c                           | 40 +++++++---
> >  drivers/clk/clk-tps68470.c                    | 13 +++-
> >  drivers/platform/x86/intel/int3472/common.c   |  2 +-
> >  drivers/platform/x86/intel/int3472/tps68470.c | 76 ++++++++++++++++---
> >  drivers/platform/x86/intel/int3472/tps68470.h |  3 +-
> >  .../x86/intel/int3472/tps68470_board_data.c   | 54 ++++++++++++-
> >  include/acpi/acpi_bus.h                       | 15 +++-
> >  include/linux/platform_data/tps68470.h        |  7 +-
> >  8 files changed, 177 insertions(+), 33 deletions(-)
> >
>
