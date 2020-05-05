Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D51C5975
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgEEO1w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 May 2020 10:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729346AbgEEO1t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2020 10:27:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F61C061A0F;
        Tue,  5 May 2020 07:27:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t9so1215266pjw.0;
        Tue, 05 May 2020 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0d2zCfXjqEkoPjXPCO2eW50jfsT6IHtXFCM1nqKnraI=;
        b=FMGNXT2fKKRoI0Pby3QgAP4Puaf5obX+oQRGw4q02LmDjkOt+RB6cbjPh0JwHzPXfm
         AHgHRP5heysnfoNbOXjMjPwe8r8YvUqZYGmP0RO83fTG6L+69/EfRbWXibcjJEy4klyV
         ZkVXEgz1N+v2K2Upz/9ML8/Ba9tJGB9+/XJ9/7DVg8asisv+bu2bxXRwNeUmRu4GS+rQ
         rnmONhdRXEj+ZJuD0x7PLI2XHbxKq8lKli1c1n4pX2VMrBHmcR28oHgqtcjOLi7KktiM
         b8StMxT9POylTHoanWOo3dIONP33MQIuul6kPigKUGMMWQ3HZmwaUKYbJBSJB+xZNnaH
         zY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0d2zCfXjqEkoPjXPCO2eW50jfsT6IHtXFCM1nqKnraI=;
        b=icpyOGM7V3Lj9PJQO6gvlswQnj7J4IHV0uB5If0bkIbI1vroxNNT5d99CedpzeCkbb
         xXWtQsCfuN6zgdUL6a1yuiFhZb5gLw1hlspxqn4ElJYmgrT1cFPScKrkRSIxZCOrHz3L
         aePNq+eoo/UmqwK9Spm0pCQh0XmzXhEI90mlxM3O1dlt5HItVqftUWzlIOihZw0C2eVe
         BUpBlPI2/vr7iof0Fueo+Kc1x/HOOew0hrEHbtyoy2S/3B1UXJ12OzghauTFpuo96iEO
         7O/HVkzDj/AbdhQt90pJNYpnlTI3Pl9WjIkqCBa9qzkwrJ6gOUSJ5uT4HRfoLBbz4gvQ
         JCzA==
X-Gm-Message-State: AGi0PuYTCai6Cv7s/X3Oj7Hh9T3qme0msReFwrkwSHl2/zur5q6T+Nmb
        rsDqlbekm0iI2mD56ic+J3pJBM8AqYxoKD96cDs=
X-Google-Smtp-Source: APiQypI3q+uz07fz96ONWB3ggyRrtBojxXIGIS+eu+fruU+zGJ0LKKFfiU+ajF4EFSxYHvXi9wX/IzALXoeJqGzIQko=
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr3442100pjb.25.1588688867728;
 Tue, 05 May 2020 07:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200502182951.114231-1-hdegoede@redhat.com> <20200502182951.114231-5-hdegoede@redhat.com>
 <7c3e5f844a224ff780cd8e3b3f5f7641@AUSX13MPC101.AMER.DELL.COM>
 <13a8ec94-1eae-4d95-7238-85c612ebc896@redhat.com> <afe7c366c97f4ab18d5a98a9695ceff6@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <afe7c366c97f4ab18d5a98a9695ceff6@AUSX13MPC101.AMER.DELL.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 17:27:41 +0300
Message-ID: <CAHp75VcNJFfgshhL_pYsHodF1pMNySw08Z_4jr-vVkE-Xpj_ng@mail.gmail.com>
Subject: Re: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode
 switch on "Detachable" and "Portable" chassis-types
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 5, 2020 at 5:22 PM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> > owner@vger.kernel.org> On Behalf Of Hans de Goede
> > Sent: Tuesday, May 5, 2020 4:06 AM
> > To: Limonciello, Mario; dvhart@infradead.org; andy@infradead.org
> > Cc: linux-acpi@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode
> > switch on "Detachable" and "Portable" chassis-types
> >
> >
> > [EXTERNAL EMAIL]
> >
> > Hi,
> >
> > On 5/4/20 5:37 PM, Mario.Limonciello@dell.com wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Hans de Goede <hdegoede@redhat.com>
> > >> Sent: Saturday, May 2, 2020 1:30 PM
> > >> To: Darren Hart; Andy Shevchenko; Limonciello, Mario
> > >> Cc: Hans de Goede; linux-acpi@vger.kernel.org; platform-driver-
> > >> x86@vger.kernel.org; linux-kernel@vger.kernel.org
> > >> Subject: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode
> > switch
> > >> on "Detachable" and "Portable" chassis-types
> > >>
> > >>
> > >> [EXTERNAL EMAIL]
> > >>
> > >> Commit de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
> > >> switch on 2-in-1's") added a DMI chassis-type check to avoid accidentally
> > >> reporting SW_TABLET_MODE = 1 to userspace on laptops.
> > >>
> > >> Some devices with a detachable keyboard and using the intel-vbnt (INT33D6)
> > >> interface to report if they are in tablet mode (keyboard detached) or not,
> > >> report 32 / "Detachable" as chassis-type, e.g. the HP Pavilion X2 series.
> > >>
> > >> Other devices with a detachable keyboard and using the intel-vbnt (INT33D6)
> > >> interface to report SW_TABLET_MODE, report 8 / "Portable" as chassis-type.
> > >> The Dell Venue 11 Pro 7130 is an example of this.
> > >>
> > >> Extend the DMI chassis-type check to also accept Portables and Detachables
> > >> so that the intel-vbtn driver will report SW_TABLET_MODE on these devices.
> > >>
> > >> Note the chassis-type check was originally added to avoid a false-positive
> > >> tablet-mode report on the Dell XPS 9360 laptop. To the best of my knowledge
> > >> that laptop is using a chassis-type of 9 / "Laptop", so after this commit
> > >> we still ignore the tablet-switch for that chassis-type.
> > >
> > > Yes that's correct.
> > >
> > >>
> > >> Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
> > >> switch on 2-in-1's")
> > >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > >> ---
> > >> Looking at the Microsoft Windows documentation for tablet-mode reporting:
> > >> https://docs.microsoft.com/en-us/windows-hardware/drivers/gpiobtn/button-
> > >> implementation
> > >>
> > >> Then the presence of a tablet-mode switch is indicated by the presence
> > >> of a PNP0C60 compatible ACPI devices. There are 2 ways in which this device
> > >> can report the tablet-mode. 1. Directly providing a GpioInt resource inside
> > >> the PNP0C60 device, 2. Through injecting events from a Windows driver.
> > >>
> > >> It seems that the intel-vbtn / the INT33D6 ACPI device is the ACPI side
> > >> of Intel's generic solution for the case where the tablet-mode comes from
> > >> the embedded-controller and needs to be "injected".
> > >>
> > >> This all suggests that it might be better to replace the chassis-type
> > >> check with a acpi_dev_present("PNP0C60", NULL, -1) check.
> > >>
> > >> Mario, can you provide an acpidump and alsa-info.sh output for the
> > >> Dell XPS 9360, so that I can check if that might help with the issue
> > >> there, and thus is a potential candidate to replace the chassis-type
> > >> check?
> > >
> > > Unfortunately with WFH right now, I don't have access to a XPS 9630 to
> > > double check the patch series.
> > >
> > > However I do agree this should be a good approach.
> >
> > Ok, so lets stick with the chassis-type check (as amended by this patch)
> > for now then. Then once you are able to go to your office again, we
> > can examine the acpi_dev_present("PNP0C60", NULL, -1) alternative.
>
> I know XPS 13's are pretty popular, perhaps someone on the mailing list who has
> one can share ACPI dump in the interim.

https://github.com/intel/dptfxtract/issues/13
?

-- 
With Best Regards,
Andy Shevchenko
