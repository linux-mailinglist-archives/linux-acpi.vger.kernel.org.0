Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B540E1AE52B
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Apr 2020 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgDQSwX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 17 Apr 2020 14:52:23 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:35629 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgDQSwX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Apr 2020 14:52:23 -0400
Received: by mail-oo1-f65.google.com with SMTP id t12so303841oot.2;
        Fri, 17 Apr 2020 11:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o6U3HjuhtRd7DK0wpGc2QDT8+5TzaGews9QgS65m3X4=;
        b=ZYC+uBEAqRChfL2gEWc68a2voIC5Kp6t6JqWi6PR0tWHNq0PedF6Dqg63uEaBdCsOi
         DDtxsGtQpfedvIbFLdIR2VX46i8ryzr2ebaGaSWNVfLUACSO/Dg0EKZTj2OpuEa8m78m
         dOV/jseIMmpP9fclckrnHFTnYvxw0xDnevwtwj46d/dhdIjS6PN6L1fnVR+/TUZp9CsP
         1Uxbr/9NtA6NPm26UZnmHRRk9kyMxTQVBbJAIncNxdan381ysEt5XwBRPfdB6JCDPUlB
         ukcm4p0xt2PvkUBHRnFAG+hPxNnTvOHXVU7qMhUTcfzYC06z8cK6CgYV8bodddFUh1bO
         z6QA==
X-Gm-Message-State: AGi0PuaHPlo2nXF5oXSxZfYXq3y/BY8Oc8dDomwjGGyu/jxEmOsZ9StO
        8bcvOSaAPRHa89d53gyfRj5BypQ+u7l5APEgjIzH+dbZ
X-Google-Smtp-Source: APiQypKwGTWKkrgL7fiIOfQwUTLkd3ebOQLG/34cya2vn8IYluDQdV7RXPY2YfriKovTokL32G0AwnXZVOWyTCb0Bnw=
X-Received: by 2002:a05:6820:348:: with SMTP id m8mr3733858ooe.38.1587149541912;
 Fri, 17 Apr 2020 11:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <fdd9ce1d-146a-5fbf-75c5-3a9384603312@gmx.de> <5478a950-4355-8084-ea7d-fe8b270bf2e3@infradead.org>
 <5392275.BHAU0OPJTB@kreacher> <4b21c095-fbe5-1138-b977-a505baa41a2b@gmx.de>
In-Reply-To: <4b21c095-fbe5-1138-b977-a505baa41a2b@gmx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Apr 2020 20:52:10 +0200
Message-ID: <CAJZ5v0icdVL6_yGpfsorqszdi9GcLxzYdvDqTJyG4ENzkOG2pQ@mail.gmail.com>
Subject: Re: regression 5.6.4->5.6.5 at drivers/acpi/ec.c
To:     =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 17, 2020 at 6:36 PM Toralf Förster <toralf.foerster@gmx.de> wrote:
>
> On 4/17/20 5:53 PM, Rafael J. Wysocki wrote:
> > Does the patch below (untested) make any difference?
> >
> > ---
> >  drivers/acpi/ec.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/acpi/ec.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/ec.c
> > +++ linux-pm/drivers/acpi/ec.c
> > @@ -2067,7 +2067,10 @@ static struct acpi_driver acpi_ec_driver
> >               .add = acpi_ec_add,
> >               .remove = acpi_ec_remove,
> >               },
> > -     .drv.pm = &acpi_ec_pm,
> > +     .drv = {
> > +             .probe_type = PROBE_FORCE_SYNCHRONOUS,
> > +             .pm = &acpi_ec_pm,
> > +     },
> >  };
> >
> >  static void acpi_ec_destroy_workqueues(void)
> I'd say no, but for completeness:

OK, it looks like mainline commit

65a691f5f8f0 ("ACPI: EC: Do not clear boot_ec_is_ecdt in acpi_ec_add()")

was backported into 5.6.5 by mistake.

Can you please revert that patch and retest?
