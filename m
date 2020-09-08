Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40C7261AD4
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Sep 2020 20:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbgIHSkz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Sep 2020 14:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbgIHSkq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2020 14:40:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEC1C061573;
        Tue,  8 Sep 2020 11:40:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j34so170803pgi.7;
        Tue, 08 Sep 2020 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncubfhN3Rgh8bRdqASDrtWtN1Ij2GRQGx0YQSulIwdg=;
        b=u6QZQvi0lnx12bnpjbpbuCLvlmoAabUDpBpjlFY8mgWEy/EtCrDG52lGX5V+CGcoWq
         wP5kZaMcdxLmTuL3hyxKhgRP/QH2i8ozfRJHD27QUCIfOEGF9/Y0XG/7uVfXzna8q96C
         dv+Vd7GzgKpyCtJlkp0/qAV9XzgAbtaySfHpdsWdD0mMPvlbY6Dgx/m/I9ZNEn40yRe8
         n4bHkeWIHH3J+hrHct3ddar7m7Q+xOfrF5eTqkUEK/zqFLbmDaFlUQf8lzcopSWZTtxn
         O1MYQHDVjO/1Ey+p7dhRBFH3tQrtLj+9/+O0evhvP/D1FkT35wtY2MNi4oSj2Q+0//x7
         ZyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncubfhN3Rgh8bRdqASDrtWtN1Ij2GRQGx0YQSulIwdg=;
        b=pD8HL5R75NEJien2m3n2eUECMEgaSsgb7VokM7UO8nCEjftnZGJEJxm/hCS+dNrh74
         cYSsvCju5DNsEZUjPOhb+KuMgJ57UUPwHwvbR9Se1IVefqtCekR8SK3Ij2wfd+2k+T0N
         iZVgkqrnNXH/siaGm0RRN3cBMmKeNmyb13Q+7Syukctr/0vD06DIoO0kYROAgONDwE98
         Qda4yQxy+bU5hYmLJIghTX1i7od9J9Fj9JT7dIYkLB4t6KTTbSUZOEa/93SR0WwwEIgO
         E2igjHpBnPPikETRSsfH3O7p55+SY8eUg/drU1jNqmoVQnD/1yj7NAct8CI12UmDFIU9
         P/KQ==
X-Gm-Message-State: AOAM530Fdnfnj+3PI0VdIOq4OfmNoc7gFiEwa8FuIuyoRxoMr/8C+JR8
        tEVSduF90uH5RxgSa633f5HWyBKC47H6a7n5MRo=
X-Google-Smtp-Source: ABdhPJzY65qjbadQFRobtds2jaaACl/9kmkC9wPQqUtQ2kQgshvPRbqr6vV6keiz30dJy2nV9wgnZOMWApPPJtXzMEA=
X-Received: by 2002:a05:6a00:22c5:: with SMTP id f5mr83596pfj.163.1599590445545;
 Tue, 08 Sep 2020 11:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200908171934.1661509-1-luzmaximilian@gmail.com>
In-Reply-To: <20200908171934.1661509-1-luzmaximilian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Sep 2020 21:40:28 +0300
Message-ID: <CAHp75VevrwKaba_FsZj-nPqJGR9fkmFPzvdCew0wCqF_L6QLbA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Add Driver to set up lid GPEs on MS Surface device
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 8, 2020 at 8:20 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> Conventionally, wake-up events for a specific device, in our case the
> lid device, are managed via the ACPI _PRW field. While this does not
> seem strictly necessary based on ACPI spec, the kernel disables GPE
> wakeups to avoid non-wakeup interrupts preventing suspend by default and
> only enables GPEs associated via the _PRW field with a wake-up capable
> device. This behavior has been introduced in commit f941d3e41da7 ("ACPI:
> EC / PM: Disable non-wakeup GPEs for suspend-to-idle") and is described
> in more detail in its commit message.
>
> Unfortunately, on MS Surface devices, there is no _PRW field present on
> the lid device, thus no GPE is associated with it, and therefore the GPE
> responsible for sending the status-change notification to the lid gets
> disabled during suspend, making it impossible to wake the device via the
> lid.
>
> This patch introduces a pseudo-device and respective driver which, based
> on some DMI matching, marks the corresponding GPE of the lid device for
> wake and enables it during suspend. The behavior of this driver models
> the behavior of the ACPI/PM core for normal wakeup GPEs, properly
> declared via the _PRW field.

...

> +#include <linux/platform_device.h>
> +
> +

One blank line is enough.

...

> +       .gpe_number = 0x17,
> +       .gpe_number = 0x4D,
> +       .gpe_number = 0x4F,
> +       .gpe_number = 0x57,

From where these numbers come from? Can we get them from firmware (ACPI)?

...

> +       { }
> +};
> +
> +

One is enough. Same for other places.

...

> +static int surface_gpe_suspend(struct device *dev)
> +{
> +       const struct surface_lid_device *lid;
> +
> +       lid = dev_get_platdata(dev);

There is enough room to put this assignment directly into definition.

> +       return surface_lid_enable_wakeup(dev, lid, true);
> +}
> +
> +static int surface_gpe_resume(struct device *dev)
> +{
> +       const struct surface_lid_device *lid;
> +
> +       lid = dev_get_platdata(dev);

Ditto.

> +       return surface_lid_enable_wakeup(dev, lid, false);
> +}

...

> +static int surface_gpe_probe(struct platform_device *pdev)
> +{
> +       const struct surface_lid_device *lid;
> +       int status;
> +

> +       lid = dev_get_platdata(&pdev->dev);
> +       if (!lid)
> +               return -ENODEV;

Can we use software nodes?

> +       status = acpi_mark_gpe_for_wake(NULL, lid->gpe_number);
> +       if (status) {
> +               dev_err(&pdev->dev, "failed to mark GPE for wake: %d\n", status);
> +               return -EINVAL;
> +       }
> +

> +       status = acpi_enable_gpe(NULL, lid->gpe_number);

Did I miss anything or all calls of enable / disable GPE are using
NULL as a first parameter? What the point in such case?

> +       if (status) {
> +               dev_err(&pdev->dev, "failed to enable GPE: %d\n", status);
> +               return -EINVAL;
> +       }
> +
> +       status = surface_lid_enable_wakeup(&pdev->dev, lid, false);
> +       if (status) {
> +               acpi_disable_gpe(NULL, lid->gpe_number);
> +               return status;
> +       }
> +
> +       return 0;
> +}

...

> +static void __exit surface_gpe_exit(void)
> +{

> +       if (!surface_gpe_device)
> +               return;

This is redundant check.

> +       platform_device_unregister(surface_gpe_device);
> +       platform_driver_unregister(&surface_gpe_driver);
> +}
> +

> +module_init(surface_gpe_init);
> +module_exit(surface_gpe_exit);

Attach each to the corresponding method w/o blank line in between.

...

> +MODULE_ALIAS("dmi:*:svnMicrosoftCorporation:pnSurfacePro:*");
> +MODULE_ALIAS("dmi:*:svnMicrosoftCorporation:pnSurfacePro4:*");

Can simply

MODULE_ALIAS("dmi:*:svnMicrosoftCorporation:pnSurface*:*");

work?

-- 
With Best Regards,
Andy Shevchenko
