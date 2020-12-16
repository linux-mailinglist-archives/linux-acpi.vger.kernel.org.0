Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB52DC6BC
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Dec 2020 19:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgLPSsq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 16 Dec 2020 13:48:46 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:46681 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgLPSsq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2020 13:48:46 -0500
Received: by mail-ot1-f52.google.com with SMTP id w3so24005412otp.13;
        Wed, 16 Dec 2020 10:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xqmAg/xobK1xHhCO4PR0pvoyshLXTVKo5OcutPAwkao=;
        b=jKuYHI0KQhuDaoPhCZuxuWsVTf6qgTj6RMQuQ8musCBUI1E9VrMdKMvtVnv6/ELJV/
         v4oiaTzewe7EURg4BYvAWOiLdsZN3kWGQj1EGY+5teIfqx+RyeJ+f0WEKCI2pMpCMDkp
         2jJvOKV2WJ8gGIak/+tFlL6FwhyeKD+W0YinSqlcFZ5zXWNQwbMiW1YVmf52Hqebza40
         TITBX7qf6dCtgjCuQEe1s6cASAj6uRhh63X+4Vum8hP/DRrDHrrAD8DElzjRgJq3Ed7f
         J7Ew2YPaLXIsLLp7oeDuFlaTik7VLD71LxGXi/BbD31XXJU1DfFbsefwxWdy3HOTnAqh
         4oTg==
X-Gm-Message-State: AOAM533B0gJdJhlL3MiCJIHGWWP43w3TyoXEKGfli5NFiHKUV2VoZwi1
        /ZDlig8AuTlnCKGnITAqqnatsMFkXlCYdVp/EVs=
X-Google-Smtp-Source: ABdhPJwB896NylpPsVJun7Pnhk/QJUu0JwQAQ58T7ud+SwaWmhxVdLuT7HIjkxtXRhzwZHTSM7WIGgx0K/IEZ21IUNA=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr27428433otn.321.1608144485340;
 Wed, 16 Dec 2020 10:48:05 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201211020630.305905-1-markpearson@lenovo.com>
 <20201211020630.305905-2-markpearson@lenovo.com> <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com>
 <l-Nzteqdz9SbINiwW0w4kFnKwknGoh5DH7VXqvkb23SZPwhvNyna0FRV9z2IZ18T0S9-a4n3LGBR1pMZYKX4FcxNTOma7vIuya66CY_Mkpc=@protonmail.com>
In-Reply-To: <l-Nzteqdz9SbINiwW0w4kFnKwknGoh5DH7VXqvkb23SZPwhvNyna0FRV9z2IZ18T0S9-a4n3LGBR1pMZYKX4FcxNTOma7vIuya66CY_Mkpc=@protonmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Dec 2020 19:47:53 +0100
Message-ID: <CAJZ5v0hHoScy18FE_Aj+zoWpr-vUhGq-vO+8AjO7RxmOvZBYMA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] ACPI: platform-profile: Add platform profile support
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        "njosh1@lenovo.com" <njosh1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 16, 2020 at 7:42 PM Barnabás Pőcze <pobrn@protonmail.com> wrote:
>
> 2020. december 16., szerda 19:13 keltezéssel, Rafael J. Wysocki írta:
>
> > On Fri, Dec 11, 2020 at 3:15 AM Mark Pearson <markpearson@lenovo.com> wrote:
> > >
> > > This is the initial implementation of the platform-profile feature.
> > > It provides the details discussed and outlined in the
> > > sysfs-platform_profile document.
> > >
> > > Many modern systems have the ability to modify the operating profile to
> > > control aspects like fan speed, temperature and power levels. This
> > > module provides a common sysfs interface that platform modules can register
> > > against to control their individual profile options.
> > >
> > > Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> > [...]
> > > +enum platform_profile_option {
> > > +       PLATFORM_PROFILE_LOW,
> > > +       PLATFORM_PROFILE_COOL,
> > > +       PLATFORM_PROFILE_QUIET,
> > > +       PLATFORM_PROFILE_BALANCED,
> > > +       PLATFORM_PROFILE_PERFORM,
> > > +       PLATFORM_PROFILE_LAST, /*must always be last */
> > > +};
> > > +
> > > +struct platform_profile_handler {
> > > +       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> > > +       int (*profile_get)(enum platform_profile_option *profile);
> >
> > I'm not sure why this callback is necessary and, provided that there
> > is a good enough reason, why it cannot return an enum
> > platform_profile_option value.
> >
> > In principle, if ->profile_set() returns 0, the requested profile can
> > be saved in a static var and then returned by subsequent "read"
> > operations.
> >
>
> It is possible that the platform profile can be changed with (e.g.) a dedicated
> button (commonly found on laptops), in which case there needs to be a mechanism
> to retrieve the new profile, which would not be possible without introducing
> something else in place of that getter - unless I'm missing something obvious.

Fair enough.

The other question remains, then.
