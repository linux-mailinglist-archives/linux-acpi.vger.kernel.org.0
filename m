Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F1938B7AC
	for <lists+linux-acpi@lfdr.de>; Thu, 20 May 2021 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhETTmY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 May 2021 15:42:24 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46002 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhETTmY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2021 15:42:24 -0400
Received: by mail-oi1-f170.google.com with SMTP id w127so13653384oig.12;
        Thu, 20 May 2021 12:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1iin/fsWDM3w5QyDMVs0rUZIL7VQZLTGcYt+0lEbCQ=;
        b=EEk4riasDquK6JGMs0d9+/LhG8hgfs3pNF++ijDNiIWI48jWXFM5wIsWlRCrB/6P3W
         6JIoHYfoPSOre9dCce/anfyahEM/G9GK+JeM+pIm/9jA5wXF2Y/xIIgKhnzzEVPoPhmr
         2Hjw125qoA6+bwhrdo1p25VwYSUvc5kLdJy4ruoZg0LzQT5m/LhXyUtREwp8Qjz6ltn1
         IwJxf5t8scJGdrgWZzrY97Di2LP58pgF42YR9/op8n6pwwGvrC2qYb+0ssTVbL2GEFuk
         HW4ulv/hzgfrvcrnTy4gjrmRtO6B9jgYOCM3Y2UrtcE8C0z9UOuzIjcNxCzInFQyudAG
         kRvA==
X-Gm-Message-State: AOAM530XUUSfwwB+BdMJxzxdJ6/I+/Ycnie8MUbG/nTdmUjMxr1nHX3z
        WwXFf/r71oELY6pbuRr35fyAlFql4u34lDvs6QQ=
X-Google-Smtp-Source: ABdhPJwlLcanJ8ZpS/SGjqVaANYZucjsh3Cy2+yy0vt8wVmKq3yOMqnXSOAC2qLMGX83z3ynXSbHNO1JHSA7oR8D/po=
X-Received: by 2002:aca:380a:: with SMTP id f10mr4623632oia.157.1621539661194;
 Thu, 20 May 2021 12:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210519210253.3578025-1-andy.shevchenko@gmail.com> <CAJZ5v0in=qEtVULLF=RwBTiFqiRK-DyPfD4F6uUAqeUfPFB8QQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0in=qEtVULLF=RwBTiFqiRK-DyPfD4F6uUAqeUfPFB8QQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 May 2021 21:40:50 +0200
Message-ID: <CAJZ5v0hsDpGtLHPQvcnof3c1LBnhoZSwWyHJdj1mOov9gV_W8A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 20, 2021 at 9:13 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 19, 2021 at 11:19 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > Currently it's possible to iterate over the dangling pointer in case the device
> > suddenly disappears. This may happen becase callers put it at the end of a loop.
> >
> > Instead, let's move that call inside acpi_dev_get_next_match_dev().
>
> Not really.

OK, I see what you want to achieve and the macro is actually buggy,
because it leaves unbalanced references behind.

> > Fixes: 803abec64ef9 ("media: ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver")
> > Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro")
> > Cc: Daniel Scally <djrscally@gmail.com>
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  drivers/acpi/utils.c                       | 5 +----
> >  drivers/media/pci/intel/ipu3/cio2-bridge.c | 8 +++-----
> >  include/acpi/acpi_bus.h                    | 5 -----
> >  3 files changed, 4 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index 3b54b8fd7396..ccfc484dbffd 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -846,10 +846,6 @@ EXPORT_SYMBOL(acpi_dev_present);
> >   * Return the next match of ACPI device if another matching device was present
> >   * at the moment of invocation, or NULL otherwise.
> >   *
> > - * FIXME: The function does not tolerate the sudden disappearance of @adev, e.g.
> > - * in the case of a hotplug event. That said, the caller should ensure that
> > - * this will never happen.
> > - *
> >   * The caller is responsible for invoking acpi_dev_put() on the returned device.
> >   *
> >   * See additional information in acpi_dev_present() as well.

But the kerneldoc really needs to say that the caller is required to
obtain a reference on adev before passing it here, because that
reference will be dropped and the object pointed to by adev may not be
present any more after this returns.

> > @@ -866,6 +862,7 @@ acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const cha
> >         match.hrv = hrv;
> >
> >         dev = bus_find_device(&acpi_bus_type, start, &match, acpi_dev_match_cb);
> > +       acpi_dev_put(adev);
