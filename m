Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4883251ED
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 16:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhBYPCu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 10:02:50 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:42316 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBYPCT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2021 10:02:19 -0500
Received: by mail-ot1-f49.google.com with SMTP id e45so5897743ote.9;
        Thu, 25 Feb 2021 07:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e502o7CCWlPNbJmZY9s9X5FHWXBm35Nmhk7yitJzO4E=;
        b=fYMF1GDDA53c2wyBizyBXO3hDH8uZfQoPhiCszU43IKQS/l0TFN5PY37sNFqpY41Gr
         fA2odc0l+hcu0PKmxAxFfwZL+3M0PwXJGx6dCIUsdJn+iag6JPVW4ulXWSLWcEeM0qXs
         M53LoaUnHSyiCgefKy6tVkfbjudDZ3nBclLkebtAvdtPQyxvNn4y1Cs3/NEg+iSHBYBS
         vFWBiOgQIvuX/NpafMAuzs8sm9+bEG+vPnOczcRcICaI49vbCLS9fr5ZsHH8PSZ/vO+f
         8ezGGrnyG8PsfG9OYGpfu9PBb3po/IdhIu4XzfGHjIoNOP7dmK49I68ngQUAfp1DC9fi
         OTWQ==
X-Gm-Message-State: AOAM530qoVs7xJoxeQYW2GNzq9GdNpy2P1dR5RSCFz99ihLh3R+rgkTX
        5hgonhiMbeZifl0BAk9YDVPAbug1AsO8J3u2CsbaMH42
X-Google-Smtp-Source: ABdhPJzQCX/66Mb0QI7j7N3f/dOotLPO7MAOeXnFoJvadqv5IziVI0uMkZkjS139qJQxhIsF9W2QpuK0fme2LSEv2OU=
X-Received: by 2002:a05:6830:2466:: with SMTP id x38mr2735214otr.206.1614265295839;
 Thu, 25 Feb 2021 07:01:35 -0800 (PST)
MIME-Version: 1.0
References: <2074665.VPHYfYaQb6@kreacher> <46166c43-ee54-4a6b-5e48-36ff8e08cba6@redhat.com>
In-Reply-To: <46166c43-ee54-4a6b-5e48-36ff8e08cba6@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Feb 2021 16:01:25 +0100
Message-ID: <CAJZ5v0iwOiZg1--J-NTzV-1GBFCJytmKW2bDx+x_pPNX61DV0w@mail.gmail.com>
Subject: Re: [PATCH v1] platform: x86: ACPI: Get rid of ACPICA message printing
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 24, 2021 at 8:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> On 2/24/21 7:41 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > A few x86 platform drivers use ACPI_DEBUG_PRINT() or ACPI_EXCEPTION()
> > for printing messages, but that is questionable, because those macros
> > belong to ACPICA and they should not be used elsewhere.  In addition,
> > ACPI_DEBUG_PRINT() requires special enabling to allow it to actually
> > print the message, which is a nuisance, and the _COMPONENT symbol
> > generally needed for that is not defined in any of the files in
> > question.
> >
> > For this reason, replace the ACPI_DEBUG_PRINT() in lg-laptop.c with
> > pr_debug() and the one in xo15-ebook.c with acpi_handle_debug()
> > (with the additional benefit that the source object can be identified
> > more easily after this change), and replace the ACPI_EXCEPTION() in
> > acer-wmi.c with pr_warn().
> >
> > Also drop the ACPI_MODULE_NAME() definitions that are only used by
> > the ACPICA message printing macros from those files and from wmi.c
> > and surfacepro3_button.c (while at it).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thank you for your patch for this.
>
> This looks good to me, except that I already fixed the acer-wmi.c case
> a couple of weeks ago, and that fiox was merged into Linus' tree already:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef14f0e82c9b225ae19476fa5bed89d55b2a96d5
>
> I can drop the acer-wmi.c chunks when I merge this, so there is no
> need to send out a new version.

OK, thanks!

I will be assuming that you will pick up this patch and adjust it as needed.

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
>
>
> > ---
> >  drivers/platform/surface/surfacepro3_button.c |    2 --
> >  drivers/platform/x86/acer-wmi.c               |    4 ++--
> >  drivers/platform/x86/lg-laptop.c              |    2 +-
> >  drivers/platform/x86/wmi.c                    |    1 -
> >  drivers/platform/x86/xo15-ebook.c             |    6 ++----
> >  5 files changed, 5 insertions(+), 10 deletions(-)
> >
> > Index: linux-pm/drivers/platform/x86/lg-laptop.c
> > ===================================================================
> > --- linux-pm.orig/drivers/platform/x86/lg-laptop.c
> > +++ linux-pm/drivers/platform/x86/lg-laptop.c
> > @@ -678,7 +678,7 @@ static int __init acpi_init(void)
> >
> >       result = acpi_bus_register_driver(&acpi_driver);
> >       if (result < 0) {
> > -             ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
> > +             pr_debug("Error registering driver\n");
> >               return -ENODEV;
> >       }
> >
> > Index: linux-pm/drivers/platform/x86/xo15-ebook.c
> > ===================================================================
> > --- linux-pm.orig/drivers/platform/x86/xo15-ebook.c
> > +++ linux-pm/drivers/platform/x86/xo15-ebook.c
> > @@ -26,8 +26,6 @@
> >  #define XO15_EBOOK_HID                       "XO15EBK"
> >  #define XO15_EBOOK_DEVICE_NAME               "EBook Switch"
> >
> > -ACPI_MODULE_NAME(MODULE_NAME);
> > -
> >  MODULE_DESCRIPTION("OLPC XO-1.5 ebook switch driver");
> >  MODULE_LICENSE("GPL");
> >
> > @@ -66,8 +64,8 @@ static void ebook_switch_notify(struct a
> >               ebook_send_state(device);
> >               break;
> >       default:
> > -             ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > -                               "Unsupported event [0x%x]\n", event));
> > +             acpi_handle_debug(device->handle,
> > +                               "Unsupported event [0x%x]\n", event);
> >               break;
> >       }
> >  }
> > Index: linux-pm/drivers/platform/x86/acer-wmi.c
> > ===================================================================
> > --- linux-pm.orig/drivers/platform/x86/acer-wmi.c
> > +++ linux-pm/drivers/platform/x86/acer-wmi.c
> > @@ -30,7 +30,6 @@
> >  #include <linux/input/sparse-keymap.h>
> >  #include <acpi/video.h>
> >
> > -ACPI_MODULE_NAME(KBUILD_MODNAME);
> >  MODULE_AUTHOR("Carlos Corbacho");
> >  MODULE_DESCRIPTION("Acer Laptop WMI Extras Driver");
> >  MODULE_LICENSE("GPL");
> > @@ -1605,7 +1604,8 @@ static void acer_kbd_dock_get_initial_st
> >
> >       status = wmi_evaluate_method(WMID_GUID3, 0, 0x2, &input_buf, &output_buf);
> >       if (ACPI_FAILURE(status)) {
> > -             ACPI_EXCEPTION((AE_INFO, status, "Error getting keyboard-dock initial status"));
> > +             pr_warn("Error getting keyboard-dock initial status: %s\n",
> > +                     acpi_format_exception(status));
> >               return;
> >       }
> >
> > Index: linux-pm/drivers/platform/surface/surfacepro3_button.c
> > ===================================================================
> > --- linux-pm.orig/drivers/platform/surface/surfacepro3_button.c
> > +++ linux-pm/drivers/platform/surface/surfacepro3_button.c
> > @@ -40,8 +40,6 @@ static const guid_t MSHW0040_DSM_UUID =
> >  #define SURFACE_BUTTON_NOTIFY_PRESS_VOLUME_DOWN              0xc2
> >  #define SURFACE_BUTTON_NOTIFY_RELEASE_VOLUME_DOWN    0xc3
> >
> > -ACPI_MODULE_NAME("surface pro 3 button");
> > -
> >  MODULE_AUTHOR("Chen Yu");
> >  MODULE_DESCRIPTION("Surface Pro3 Button Driver");
> >  MODULE_LICENSE("GPL v2");
> > Index: linux-pm/drivers/platform/x86/wmi.c
> > ===================================================================
> > --- linux-pm.orig/drivers/platform/x86/wmi.c
> > +++ linux-pm/drivers/platform/x86/wmi.c
> > @@ -32,7 +32,6 @@
> >  #include <linux/fs.h>
> >  #include <uapi/linux/wmi.h>
> >
> > -ACPI_MODULE_NAME("wmi");
> >  MODULE_AUTHOR("Carlos Corbacho");
> >  MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
> >  MODULE_LICENSE("GPL");
> >
> >
> >
>
