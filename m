Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2B659B1D
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Dec 2022 18:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiL3Rx7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Dec 2022 12:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiL3Rx6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Dec 2022 12:53:58 -0500
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022C7F1C
        for <linux-acpi@vger.kernel.org>; Fri, 30 Dec 2022 09:53:57 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id y2so11656973ily.5
        for <linux-acpi@vger.kernel.org>; Fri, 30 Dec 2022 09:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/htuYpDlIdbEfr+H5sciFdu9hrh7E6EVU2TL6P4Qahg=;
        b=12RDyKxQtPoF8C5Texz+nrE53QIrjzObFp2XBAEQkjshiqCQyW8pcD0J30ciASokXH
         8IheKKP2szh/zjXDO4vgSbLIGEXuMdwpx4b/RM6mZHWQ7OkhaKt+7pZrYRJQRKVV5X9p
         M2O6itfQQ/BrqIAF7rYL5y6X2y9YwZ7OjFpwXW8gLelJEvGOsutWbYCldN8INJJvtGg1
         ZqEum+ELQe4g4Mz/E4qr6sCMDk8FQS9RwnUEWe2Yj/N0TEbMUSuml683WIjjeWcT8pYd
         b2bg5nQdFf6SlNX4vyw3cVo9Wj5oKp+7j1w/6Y+0LBepmIj7CCrXC9RxMN/8pQBAs/TL
         t8oA==
X-Gm-Message-State: AFqh2kobtCccz7YJGEDtY1NVJmka2KmSyhAiLujZ0jiBgcHL9J4MjeP7
        a3bNO4OpKF+PxaggSNVlDz2AfuUFaZG7C7U/7vc=
X-Google-Smtp-Source: AMrXdXsSflhNGhkHp46W7uVNQ3skSmqPebwSs7e2k1mimUjcyoslpW1rsHmSN5vUoua7SKKFJ57tlMZhSy00wJhj+sM=
X-Received: by 2002:a92:ab05:0:b0:30b:b015:376c with SMTP id
 v5-20020a92ab05000000b0030bb015376cmr2695175ilh.201.1672422836293; Fri, 30
 Dec 2022 09:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20221220150126.1624988-1-sakari.ailus@linux.intel.com> <CAJZ5v0gdFdPjAc-aLZBDJAkZ1jjGdigBjX9RzWwTdokH_sCwhw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gdFdPjAc-aLZBDJAkZ1jjGdigBjX9RzWwTdokH_sCwhw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 18:53:44 +0100
Message-ID: <CAJZ5v0guBgiRn2E_MG+uNqVVmgd0iHPHHwUPK1b1jBG3xz3PHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: acpica: Constify pathname argument for acpi_get_handle()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 21, 2022 at 2:43 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 20, 2022 at 4:01 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > acpi_get_handle() uses the pathname argument to find a handle related to
> > that pathname but it does not need to modify it. Make it const, in order
> > to be able to pass const pathname to it.
> >
> > Cc: "Moore, Robert" <robert.moore@intel.com>
> > Link: https://github.com/acpica/acpica/pull/773
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/acpica/nsxfname.c | 2 +-
> >  include/acpi/acpixf.h          | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
> > index b2cfdfef31947..a0592d15dd37c 100644
> > --- a/drivers/acpi/acpica/nsxfname.c
> > +++ b/drivers/acpi/acpica/nsxfname.c
> > @@ -44,7 +44,7 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
> >
> >  acpi_status
> >  acpi_get_handle(acpi_handle parent,
> > -               acpi_string pathname, acpi_handle *ret_handle)
> > +               const char *pathname, acpi_handle *ret_handle)
> >  {
> >         acpi_status status;
> >         struct acpi_namespace_node *node = NULL;
> > diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> > index 67c0b9e734b64..085f23d833349 100644
> > --- a/include/acpi/acpixf.h
> > +++ b/include/acpi/acpixf.h
> > @@ -526,7 +526,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> >                                            struct acpi_buffer *ret_path_ptr))
> >  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> >                              acpi_get_handle(acpi_handle parent,
> > -                                            acpi_string pathname,
> > +                                            const char *pathname,
> >                                              acpi_handle *ret_handle))
> >  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> >                              acpi_attach_data(acpi_handle object,
> > --
>
> I'll queue up this one for 6.3 early next week, thanks!

Applied now, thanks!
