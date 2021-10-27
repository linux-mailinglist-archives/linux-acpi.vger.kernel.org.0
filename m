Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33AD43CF9D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbhJ0R0V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 13:26:21 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42848 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhJ0R0U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 13:26:20 -0400
Received: by mail-oi1-f181.google.com with SMTP id g125so4387932oif.9;
        Wed, 27 Oct 2021 10:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7zZvIfv3CsZqjoYb0Mz7kBVQSW9A8D+jJ6CWe5XNmw=;
        b=gCIb0wzJEjJbmsTA7REnV9WkTLiJKH2+ZjnBm7a9xDsLMq1W5L3vm/RTyPPhwagw4A
         MIAGUA0x4QjAarANUPdNb3bt9yHEjP7YCa6wJe6cyqrOl+iaYu259K/Vd/xQebq1b45j
         ShL07OeuWeMmBjW82cipbMY9VCHQla41xs+MwWBFllFRMuerQ1hiH3Ju8sctBk9echeT
         /C+seOCcH5CqJIz6H9z3mJWkl0lgXwUJJofBYp4oe9MnfAyRM65rFY7uzm8toRrlX1jb
         F2ViANVJg1APszFZ51XgIKBJgtwkbqsfubKlNf+kzFWal8VQrmtD4tBgR1jHxbc8GXHz
         mTZw==
X-Gm-Message-State: AOAM533O3xCs/1F2dnBHSEAniFnOlKwt23K1AGiEg3xEVFq3sBQfSSQo
        mBeNeDTdI8NkWQSNbE8Ms/D9VawLh1v7p+lHzDg=
X-Google-Smtp-Source: ABdhPJwl3VTKKaHQuRP6YmgcNDXqY80yOXmuV1vmIvrsN/TKCh2UxwnTeKCGtFD3C0G6Zdja/n6Fl1aW9umeaEMotl8=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr4567170oil.166.1635355434782;
 Wed, 27 Oct 2021 10:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <11862679.O9o76ZdvQC@kreacher> <YXmJjlY6+oFy4siX@smile.fi.intel.com>
In-Reply-To: <YXmJjlY6+oFy4siX@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Oct 2021 19:23:43 +0200
Message-ID: <CAJZ5v0j43dhVcbsKyJ8BZjeBbXHNFG-Vtv-UtsJwFBYP4usNFQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: glue: Use acpi_device_adr() in acpi_find_child_device()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 7:17 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 27, 2021 at 06:59:06PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of evaluating _ADR in acpi_find_child_device(), use the
> > observation that it has already been evaluated and the value returned
> > by it has been stored in the pnp.type.bus_address field of the ACPI
> > device object at hand.
>
> ...
>
> > +             acpi_bus_address addr = acpi_device_adr(adev);
> >               int score;
> >
> > -             status = acpi_evaluate_integer(adev->handle, METHOD_NAME__ADR,
> > -                                            NULL, &addr);
> > -             if (ACPI_FAILURE(status) || addr != address)
> > +             if (!adev->pnp.type.bus_address || addr != address)
> >                       continue;
>
> I'm not sure I understand the new check, i.e. !adev->pnp.type.bus_address.

See acpi_set_pnp_ids().

adev->pnp.bus_addres is the address value and
adev->pnp.type.bus_address is a flag that is set to 1 when _ADR is
valid.

> IIUC _ADR == 0 is a valid value and children may have it like this.

That's true.

> I believe this change will break the working things (first comes to my mind
> is drivers/mfd/intel_quark_i2c_gpio.c).

I don't think so.
