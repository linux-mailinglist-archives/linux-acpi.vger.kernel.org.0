Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65A13C8AA2
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 20:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhGNSUe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 14:20:34 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38413 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhGNSUe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2021 14:20:34 -0400
Received: by mail-ot1-f49.google.com with SMTP id 42-20020a9d012d0000b02904b98d90c82cso3451140otu.5;
        Wed, 14 Jul 2021 11:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NtKqh/hhXyEdtvjJOvCHjkNgClG5kHRWw+SH0tD8do=;
        b=bQ0ynAeWR3KMhFQBKSBzJGpB8JzZXX+zVTPAO0msz9XcXfEDUp4AX7prlB1nUz7Ydt
         RrGdEyXwizVg4hvVuxdK5xk0d3CNiLZRY5vmqp8FkFNTqgGOzALqfgxM7b2tcyHJ+r2G
         qVxtBpywgLj4CWsRqM8w8CHxe7q6h1htYRMysErQj09wLUen4zMYyL6D15LNIkkZ4PA4
         2Gb9ty9iztOLo9UD2cjDlFmgb5ovLE70uwZPryL1f4YEItFnh42jujoRWumu+Wvom08M
         ONIA3F29D69+OIG3DWFoWCTu2uegUhhQK0cxeyeF7DBfESm37qLZ6O+zzNqcGW4TkGOU
         NWXQ==
X-Gm-Message-State: AOAM5301mFAfwqCVhvq2faQAKfhggH/VmRoXz6hhV92/+Ihzz09raw5v
        9fUWtUrsCTIc1L31FNgBfWbYSxaVUmjRmSW92RA=
X-Google-Smtp-Source: ABdhPJwqSGLdbvDOnyhxufSLXfr0OqA2WwkMn6qYj3wJJCkj8VVcnwuSy6B/oTZlRErz8BiBRyroH9X6GXd2WgbvRHY=
X-Received: by 2002:a9d:5f19:: with SMTP id f25mr9693465oti.206.1626286661751;
 Wed, 14 Jul 2021 11:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <2780027.e9J7NaK4W3@kreacher> <YOyMdICr/30LhTao@smile.fi.intel.com>
In-Reply-To: <YOyMdICr/30LhTao@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jul 2021 20:17:30 +0200
Message-ID: <CAJZ5v0jhUjo-Gs=bWeNFaUY=nz3T-LAmVYbK_mDGM-LzEGbyCw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] ACPI: glue / driver core: Eliminate
 acpi_platform_notify() and split device_platform_notify()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 8:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 12, 2021 at 07:19:57PM +0200, Rafael J. Wysocki wrote:
> > Hi Greg et al,
> >
> > This series doesn't change functionality (at least not intentionally), but
> > it get rids of a few unneeded checks, parameter passing etc.
> >
> > Patches [1-2/6] simplify the ACPI "glue" code.
> >
> > Patch [3/6] renames a couple of ACPI functions to avoid name collisions going
> > forward.
> >
> > Patch [4/6] gets rid of acpi_platform_notify().
> >
> > Patch [5/6] rearranges the software nodes code along the lines of what happens
> > to the ACPI "glue" code in patch [4/6].
> >
> > Patch [6/6] deals with device_platform_notify().
> >
> > Please review and let me know if there are any concerns regarding this.
>
> The result looks good to me, but perhaps the ordering can be changed to
> minimize addition of the lines that are going to be removed inside the same
> series.
>
> In either case, feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!
