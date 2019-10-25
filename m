Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC85E4581
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 10:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408227AbfJYIWz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 04:22:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40506 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405453AbfJYIWy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2019 04:22:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id d8so1430043otc.7
        for <linux-acpi@vger.kernel.org>; Fri, 25 Oct 2019 01:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXemS+ZKx1wgWi9JebLe7mTMBKEzcNLvOBl4mimHIL4=;
        b=Qpm0gNdiTANyGIt/T3HUVgA+dGtsGNT2hUT8HmKIvd0OXlD1y9ETJsbeyOVUZIKBlv
         wjiPzcqvf88a6ke2Tswz6ADrgb/53JjjBMmFIh2KYHmKvtn4aqDE0ngyEGR/3DNbsRnj
         bM6NfMB7RqImQV1ur5vJotsH05f9a08PlaD377AB08mOQ2CIyEqc0ToH0A4d/+l+mgtP
         gSP+viacMb9hxO8DkIWHQRkecUiAG/+8kRLm2foONiWRyX1SeJgX6OjiGucnKTrYwwyY
         gWeUkIvXsMezDeyQtE2mEmKwYGPgOArLHduxEQZCpRi5ZH5J4OjSeg419Ikl7d1nsK2C
         Baww==
X-Gm-Message-State: APjAAAUf2mTiYoD6OIeFxUaiioSw+gJM5cZ0eYqJpJsBuaQUppHUB3Ql
        lc/ZNYi9E+U5EdHVt5Sqd26qoPA/VS2BJwUQyTs=
X-Google-Smtp-Source: APXvYqzLZvd0Fe8d7VtHw4w8E3s5dzX0fTSBWrlDJys/1LLFO+seiF3L7RqxazjUNBJuzy87tfptqVJLxeEo0g3Gpxg=
X-Received: by 2002:a9d:5907:: with SMTP id t7mr1652360oth.118.1571991772360;
 Fri, 25 Oct 2019 01:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191024185556.4606-1-erik.schmauss@intel.com>
 <20191024185556.4606-6-erik.schmauss@intel.com> <20191025081950.GI32742@smile.fi.intel.com>
In-Reply-To: <20191025081950.GI32742@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Oct 2019 10:22:41 +0200
Message-ID: <CAJZ5v0ijO-KZhWBQ46mxSTcu3+P13c5shQ-0OZvKJtrCUWR5QQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] ACPICA: make acpi_load_table() return table index
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 25, 2019 at 10:19 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 24, 2019 at 11:55:49AM -0700, Erik Schmauss wrote:
> > From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> >
> > ACPICA commit d1716a829d19be23277d9157c575a03b9abb7457
> >
> > For unloading an ACPI table, it is necessary to provide the index of
> > the table. The method intended for dynamically loading or hotplug
> > addition of tables, acpi_load_table(), should provide this information
> > via an optional pointer to the loaded table index.
> >
> > This patch fixes the table unload function of acpi_configfs.
> >
>
> Thank you!
>
> My comments below.
>
> First of all, can I be Cc'ed to all series to be able to test?
>
> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> > Fixes: d06c47e3dd07f ("ACPI: configfs: Resolve objects on host-directed
> > table loads")
>
> I believe this has to be one line.

Yes, it does, but I fix up such things, so no worries.

> > --- a/drivers/acpi/acpi_configfs.c
> > +++ b/drivers/acpi/acpi_configfs.c
> > @@ -53,7 +53,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
> >       if (!table->header)
> >               return -ENOMEM;
> >
> > -     ret = acpi_load_table(table->header);
> > +     ret = acpi_load_table(table->header, &table->index);
> >       if (ret) {
> >               kfree(table->header);
> >               table->header = NULL;
>
> As far as I understood the release notes of latest ACPICA there is also a
> counterpart function being provided. That said, we need to modify ConfigFS
> removing path to use the new API.
>
> Am I correct?

Yes, you are.  These are just ACPICA changes and we still need to
update the configfs I/F on top of them.

Cheers!
