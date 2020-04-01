Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF13419A873
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Apr 2020 11:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbgDAJR5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Apr 2020 05:17:57 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39749 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgDAJR5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2020 05:17:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id x11so25216909otp.6;
        Wed, 01 Apr 2020 02:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvEBEkwz9Sq6aAttX3Rnj82JX5NkQ0CAunYUtFI0KDM=;
        b=H/ieCdAhv4hrNNIEhvtS4+1k8PawKy65U0Cbk+Hm5RzxFGf610ILMgOZukq/R5PeLZ
         lUVMqKJvWmp0/5qKwE0yAyovHKPHHv3C2JVrADyUISp2IkzRmYprBDMzPxJPedV+dmyQ
         h5vMJcOhBxUHZuNKizVKGqu+AbkNZIIt1U90sdfEFdO9vy1aDKf549pkhNsI7BHJ1GdL
         RvFIi78VewdwiOsgyPnt6sy1Ia4MzrTo3dpgowpXezfuPwUmZqt3WAmNH0EO5zl0ncTO
         +wPNsKhe3vggpE+erX9uDryOrUkAfQxiSsCRmGHlXHr7IgDebUFlkspLLkFmL2fWQyXv
         h15w==
X-Gm-Message-State: ANhLgQ0mXTaiy2u19eJKB+a5xuoZNjocLpOaH2eRDYR/huANcc82FdEZ
        6tfRijE01eCvvyGFXwTW09UbZ1D9p790/LTYfN2BKw==
X-Google-Smtp-Source: ADFU+vs3g5x5BswUgDpQqQ/W2DS6rIW6SxR67+ucWdEeArPwNiHvJgBL2Crzi0FMj7cQPLRGHMi8rxw9qnJPJ0sfRm8=
X-Received: by 2002:a9d:7402:: with SMTP id n2mr16596009otk.262.1585732676649;
 Wed, 01 Apr 2020 02:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <19409af2-f38a-6760-c7b3-aa5794a94df0@infradead.org> <c292826f-0a41-910d-1973-e6b613fbce7e@redhat.com>
In-Reply-To: <c292826f-0a41-910d-1973-e6b613fbce7e@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Apr 2020 11:17:44 +0200
Message-ID: <CAJZ5v0iKvivmqmWqgoDM9W35SfMotacP7xP+er+ow7C7=SVkzA@mail.gmail.com>
Subject: Re: [PATCH] ACPI; update docs for "acpi_backlight" kernel parameter options
To:     Hans de Goede <hdegoede@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 31, 2020 at 10:16 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/31/20 2:17 AM, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > Update the Documentation for "acpi_backlight" by adding
> > 2 new options (native and none).
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: linux-acpi@vger.kernel.org
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
>
> Thanks!
>
> Patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
>
>
>
> > ---
> >   Documentation/admin-guide/kernel-parameters.txt |    8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > --- linux-next-20200330.orig/Documentation/admin-guide/kernel-parameters.txt
> > +++ linux-next-20200330/Documentation/admin-guide/kernel-parameters.txt
> > @@ -22,11 +22,13 @@
> >                       default: 0
> >
> >       acpi_backlight= [HW,ACPI]
> > -                     acpi_backlight=vendor
> > -                     acpi_backlight=video
> > -                     If set to vendor, prefer vendor specific driver
> > +                     { vendor | video | native | none }
> > +                     If set to vendor, prefer vendor-specific driver
> >                       (e.g. thinkpad_acpi, sony_acpi, etc.) instead
> >                       of the ACPI video.ko driver.
> > +                     If set to video, use the ACPI video.ko driver.
> > +                     If set to native, use the device's native backlight mode.
> > +                     If set to none, disable the ACPI backlight interface.
> >
> >       acpi_force_32bit_fadt_addr
> >                       force FADT to use 32 bit addresses rather than the
> >

Applied as 5.7-rc material with a slightly modified subject, thanks!
