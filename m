Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B4536D2E
	for <lists+linux-acpi@lfdr.de>; Sat, 28 May 2022 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiE1N4f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 May 2022 09:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiE1N4b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 May 2022 09:56:31 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306E62187
        for <linux-acpi@vger.kernel.org>; Sat, 28 May 2022 06:56:29 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id z186so7951368ybz.3
        for <linux-acpi@vger.kernel.org>; Sat, 28 May 2022 06:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8D3dq9fjKiHJEpNi9lD/Pi+3kzdxm1zCcx42uFEdrI=;
        b=kI+vT7GVGTgHRnqgEQW0svSCRG+FjgtqBqJfbmw0Nj37YxUNXNxjk2kFoFSpfZut0X
         EMaZoqdro/orN8JU6Lkb4uj3bZd2Boyr4njL5YgwXApko3zzyDtiI+FMowa19zMJCOHN
         at6vf5L/UC5U3XhXRALUfV2+2hGYrLbbfvkaL8lMzeHzY4X7c+RtednIIpA1C/kWcAEn
         8dJhM0tJX0sa6PZsFwAm7p1wGR53my4dNR0K2teYWLEHdkTAQi8Mom5XGbidLeGG8u1n
         424YjaXCBVbGJlhN6VQhECaWVoxd1jvRScjDXhps8wk97HF8zTi40R6D0oGfDen6U+SH
         y17w==
X-Gm-Message-State: AOAM530z4JEZ293kwHHuiaakeYQY2nJsHBjjTjnkaCB1gCAOqB8XNf+V
        wwoU/6zy/kNLdB2UjvrQEONONTF0nwuFDv6tVFU=
X-Google-Smtp-Source: ABdhPJyj+dkLDvUQfH6uz7UJ1ri7nZuWQpletKCOOFDknySi4oHXfzvFnkC5QjMY05a1dVJQgQ4AcNAHplQuf6m3QfE=
X-Received: by 2002:a25:2004:0:b0:650:740:f31d with SMTP id
 g4-20020a252004000000b006500740f31dmr24722611ybg.81.1653746188366; Sat, 28
 May 2022 06:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-3-sakari.ailus@linux.intel.com> <CAJZ5v0jrFQk2aH78Fg=W+6KAzhony3yZ+NjYy8ki5atKoaPwLw@mail.gmail.com>
 <YpCTjhncY4fhDjMq@paasikivi.fi.intel.com> <CAJZ5v0jM3rayEkAT21aReau+n-mZsNzVeQjH0wS5c1F+s5OgsQ@mail.gmail.com>
 <YpE7oTE5iy97jbjZ@paasikivi.fi.intel.com>
In-Reply-To: <YpE7oTE5iy97jbjZ@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 28 May 2022 15:56:17 +0200
Message-ID: <CAJZ5v0hW=kiwNqyjR6_+nQ3uvxBK2DVimo573jgkHMXf1B3oVQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] ACPI: property: Tie data nodes to acpi handles
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 27, 2022 at 10:59 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Fri, May 27, 2022 at 07:04:39PM +0200, Rafael J. Wysocki wrote:
> > On Fri, May 27, 2022 at 11:02 AM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Thu, May 26, 2022 at 09:19:17PM +0200, Rafael J. Wysocki wrote:
> > > > > +static int acpi_tie_nondev_subnodes(struct acpi_device_data *data)
> > > > > +{
> > > > > +       struct acpi_data_node *dn;
> > > > > +
> > > > > +       list_for_each_entry(dn, &data->subnodes, sibling) {
> > > > > +               acpi_status status;
> > > > > +               int ret;
> > > > > +
> > > > > +               status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
> > > > > +               if (ACPI_FAILURE(status)) {
> > > > > +                       acpi_handle_err(dn->handle, "Can't tag data node\n");
> > > > > +                       return 0;
> > > > > +               }
> > > > > +
> > > > > +               ret = acpi_tie_nondev_subnodes(&dn->data);
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > >
> > > > Is it actually possible that this returns anything different from 0?
> > >
> > > acpi_attach_data() involves allocating memory and resolving a reference.
> > > Both can fail.
> >
> > Yes, they can, but the value returned by acpi_attach_data() is
> > effectively ignored above (except for printing the error message,
> > which BTW could be "info" and provide more information).
>
> Oops. Good point.
>
> I intended this to return an error here. I don't have strong opinion on
> which way to go though. How about changing that to -ENOMEM?

It might as well return bool and let the caller worry about the error handling.

> I think this is basically a decision on whether any subnodes could be
> referenced if ore or more of them could not. I don't expect this to happen
> in practice.

So is having a partial description of something useful?  I guess it
may or may not be, depending on the use case.

If there's any use case in which it may be useful, I would ignore the
attach errors and address missing stuff elsewhere.
