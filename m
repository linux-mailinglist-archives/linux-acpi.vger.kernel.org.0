Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4F3B0069
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jun 2021 11:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhFVJik (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Jun 2021 05:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJij (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jun 2021 05:38:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A65CC061574
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jun 2021 02:36:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h16so11753249pjv.2
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jun 2021 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tbh1b3cV5Q3qqNHTOWoiBGQ8jdo8ehqJLGOWO9alnAE=;
        b=VijD66acf2I0khuIlqULqYLwrNkIQLhnS4/WoaNk5nLctnpK6mPZUl38twowGd8UVN
         hKG4K4G4xNDeYylZrULINX6kLkplLdNE2XltTaDI6tV8AOhGM6/itdNa3/mQlDl7Uzy4
         AQS2TvM11G/15vi/qiPPMc84pi0CQmBIR+kD8i4Gh2E5dRG0xaRrovw/nf/qiIQJmA3W
         pFoTy0q5FmE2JWbCw6Rnw0DwlH26qgO7/bcaJeCTuMC4zS6EKKUWnmBX2yD/HXQuIIRV
         ua/kaQo0tx3KxnKJ+PQ2y5fH9cnhnTQVkHmdyucV6MRpXhj+nDUsQNqr1qCPdBE9vYWG
         SAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tbh1b3cV5Q3qqNHTOWoiBGQ8jdo8ehqJLGOWO9alnAE=;
        b=sxuK/ZsVYm6/C11azlhgRf8RN/R/VQHZA6XW2GYMDu6fz+vnB3/YBtBi4NJ1dI9rb2
         4Rw2/ppIbMzrYYt6ncZcNvdz7EigYNU8XrVJ4mTTMm57k9vOBeGv/2uPkE4lpPPyvdOQ
         M7oS7Eb0S3cQB/8R++lVHd9pAzVkYV641rFfSY+1TuIA0lCD9ozKfQcRIaunFclrpaoc
         Bgw+C+vD/lDvBZMQsw7raSsmw7tWjUxeILe8fwj+cXEX//DW3w0AVNiqRPj7H2Jb1NTp
         a98R/fOhO8IuZBjOvomexYkobsmIw4uc8p8uKnfP46HhQracbOOZqAwTvyMcV3p/NFpU
         R+0Q==
X-Gm-Message-State: AOAM531Gd5nanExFfOn5RVEXKOS3m7Baa0zLPZYg9EQi7yHa0Fw2Qt/S
        9H0o2ef+OYxGZFjjZkibHD0MxRJorWhfgz22X/A=
X-Google-Smtp-Source: ABdhPJzmS3/hfzu78tx/Bgg1tHfWvOIk48In+KRycbbfHd4s0985Vnqm9y/FJZY8j6AeyTo9Sg737eOcoYaRsjwmy7s=
X-Received: by 2002:a17:902:fe0a:b029:11d:81c9:3adf with SMTP id
 g10-20020a170902fe0ab029011d81c93adfmr21911807plj.0.1624354583076; Tue, 22
 Jun 2021 02:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
In-Reply-To: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Jun 2021 12:35:46 +0300
Message-ID: <CAHp75Vd1gvsxFZamwp5FJDHVZsvq1S3eMBiJdu+ZD7StDoeGBw@mail.gmail.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

-Lee, Hekki
+Hans de Goede, Rafael, Laurent, Sakari

Below bug report again reminds me about the "interesting" design of
some ACPI tables in the wild. See below for more.

On Sun, Jun 20, 2021 at 11:36 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Over a month ago, Andy Shevchenko reported and fixed a NULL pointer
> dereference issue introduced by commit
>         42e59982917a ("mfd: core: Add support for software nodes")
> in v5.13-rc1:
>         https://lore.kernel.org/lkml/20210510141552.57045-1-andriy.shevch=
enko@linux.intel.com/
>
> A bisect shows that it is indeed commit 42e59982917a which causes boot to
> fail due to a NULL pointer dereference on my work laptop, where "intel-lp=
ss"
> is bound to
>         00:15.0 Signal processing controller: Intel Corporation Sunrise P=
oint-LP Serial IO I2C Controller #0 (rev 21)
> and fails to bind to INT3446:
>
> [    6.048087] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> [    6.050625] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [    6.109112] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> [    6.111348] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [    6.172229] intel-lpss 0000:00:15.2: enabling device (0000 -> 0002)
> [    6.174353] idma64 idma64.2: Found Intel integrated DMA 64-bit
> [    6.231865] intel-lpss 0000:00:15.3: enabling device (0000 -> 0002)
> [    6.233845] idma64 idma64.3: Found Intel integrated DMA 64-bit

> [    6.287492] ACPI Warning: SystemMemory range 0x00000000FE028000-0x0000=
0000FE0281FF conflicts with OpRegion 0x00000000FE028000-0x00000000FE028207 =
(\_SB.PCI0.GEXP.BAR0) (20210331/utaddress-204)
> [    6.287704] ACPI: OSL: Resource conflict; ACPI support missing from dr=
iver?
> [    6.289760] intel-lpss: probe of INT3446:00 failed with error -16

Above lines appear due to the following:
1. In hardware we have an I=C2=B2C bus with GPIO I/O expander (PCA953x
compatible in all cases I saw so far).
2. The ACPI table has a "real" driver for that expander written in ASL (sic=
!).
3. Due to the above we have I=C2=B2C controller resources and that driver
in a conflict, because the driver uses I=C2=B2C controller registers
directly (sic!).

The questions for brainstorming the ideas here are:
1. Is it possible to blacklist the Device Node from being evaluated /
parsed based on the ACPI DSDT path (the "real driver", of course,
doesn't have any other means to be enumerated properly)?
2. Can we create the ACPI driver in the OS which will take the ACPI
path as ID for enumeration / instantiation?
3. Is it possible to hook up on the methods, so we will know what to
do when a certain method is called (like setting pin direction or so)?
4. Does above make any sense or we simply mark that hardware as broken
(i.e. Windoze-only bad desing) and that's it?

> Unfortunately, the patch by Andy Shevchenko (applied on top of Linus' tre=
e)
> does not fix the issue. A complete revert, however, does fix the issue, a=
nd
> allows my laptop to boot again.
>
> In my opinion, it is unfortunate that although it has been known for over=
 a
> month that commit 42e59982917a is broken, the bugfix (though probably not
> far-reaching enough) has not yet progressed upstream.



--=20
With Best Regards,
Andy Shevchenko
