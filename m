Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AB72DD3CE
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgLQPKU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 17 Dec 2020 10:10:20 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:36150 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgLQPKU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 10:10:20 -0500
Received: by mail-ot1-f48.google.com with SMTP id d20so9607021otl.3;
        Thu, 17 Dec 2020 07:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tEN1qjjJDhKWq8GWfh+LqPeIlI4fd4/+X95HKDScqc8=;
        b=Wj8/folkdqtiaBSo67Wp+Okj/GM1zVOOMWk9P2tV4D21rMhDEDklHVROmFxFbhBJZF
         oP+rAPwm6whMhcu63MA3LINR35Z6G7wYFXgHUhK+f84CPpQudu573qmHpAor1tobSC3g
         c3gV+oA9UmJKROLDHh+zd7KFPoudOmXf8JxLpLWkAw+eyY9oN2Tt3CEszwn0rTSlIZcu
         FFyeoY+Vs/6AyrspHzMF+NdCVmA3RLjjlOfEIjKFgdjYV621734b7/TePmNtKeOdtGWb
         0lif4Rb81F/8UjdoeJr3J6WpQ/fZZtVPtMKaAH0Av2L0KX4gDIJz2B8+9PEBPTmG6H0x
         oGog==
X-Gm-Message-State: AOAM533NySaieaIrisJrIeyujrhzc1rnm8ewaWoRkc8cgQdPr5MIq7NN
        R6qX5n2lKhL69JiNaW88PcXbpxJFIktNbj3Au4s=
X-Google-Smtp-Source: ABdhPJzG/PtAkrfCilJzmiK5TO7QOvjLw0f00Fz4G4GZYwxUtlrM0gGmdVzv0yA6w8CrtuniqG//nMQppLNqPIk3S9Q=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr30218818otn.321.1608217779204;
 Thu, 17 Dec 2020 07:09:39 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201211020630.305905-1-markpearson@lenovo.com>
 <20201211020630.305905-2-markpearson@lenovo.com> <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com>
 <l-Nzteqdz9SbINiwW0w4kFnKwknGoh5DH7VXqvkb23SZPwhvNyna0FRV9z2IZ18T0S9-a4n3LGBR1pMZYKX4FcxNTOma7vIuya66CY_Mkpc=@protonmail.com>
 <CAJZ5v0hHoScy18FE_Aj+zoWpr-vUhGq-vO+8AjO7RxmOvZBYMA@mail.gmail.com>
 <00993237-eb24-6038-3a85-bb76f96f679d@lenovo.com> <CAJZ5v0ji_+BbCrJo=3TB1Cytb8eV-tGE_m6R35UYfwmpUs6MAg@mail.gmail.com>
 <e682cdbd-41fe-065e-5912-d0fb94879dc9@lenovo.com> <CAJZ5v0gMo_22OJvjrufJy6uQsMjh+AT_mYQyFD-LpNzAwhkimA@mail.gmail.com>
 <lz2i0N6rCGcqra4IF0bl9Q0ke6btCg4-uW4fwI4PCnjsfLvhF2hm3SgqjCtUBybLzZTKDMmleu123UylZDfAjZ_jsayppN-X0PnSaaNwK6c=@protonmail.com>
In-Reply-To: <lz2i0N6rCGcqra4IF0bl9Q0ke6btCg4-uW4fwI4PCnjsfLvhF2hm3SgqjCtUBybLzZTKDMmleu123UylZDfAjZ_jsayppN-X0PnSaaNwK6c=@protonmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Dec 2020 16:09:27 +0100
Message-ID: <CAJZ5v0gzXrft6x03tEtpn492StzSH=8jJbOmS6ncpVRRvscNKg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 2/3] ACPI: platform-profile: Add
 platform profile support
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

On Thu, Dec 17, 2020 at 4:02 PM Barnabás Pőcze <pobrn@protonmail.com> wrote:
>
> 2020. december 17., csütörtök 14:36 keltezéssel, Rafael J. Wysocki <rafael@kernel.org> írta:
>
> > [...]
> > > >> My thinking here that I shouldn't make assumptions for future platform
> > > >> implementations - there may be valid cases in the future where being
> > > >> able to return an error condition if there was an error would be useful.
> > > >>
> > > >> Just trying to keep this somewhat future proof. Returning an error
> > > >> condition seemed a useful thing to have available.
> > > >
> > > > You can still return an error while returning a platform_profile_option value.
> > > >
> > > > Just add a special value representing an error to that set.
> > > >
> > > I'd like to understand what is better about that approach than having an
> > > error and a returnable parameter?
> > >
> > > I'm probably missing something obvious but if I add an extra
> > > platform_profile option (e.g PLATFORM_PROFILE_ERROR) to be used in an
> > > error case (and return just an enum platform_profile_option) it seems I
> > > lose the granularity of being able to return a specific error condition.
> > > It doesn't feel like an improvement.
> >
> > And what's the user expected to do about the different error codes
> > that can be returned?
>
> Even assuming the users of the API cannot or will not handle different errors
> differently, who would benefit from getting rid of this information which may be
> an aid in debugging for those who know what they're looking at?
>
> And if a new enum value is introduced to signal an error condition, how is that
> going to be communicated to the users? A magic string like "error" or "-1"?
> Or under a single errno like -EIO?

Yes.

> Personally, I believe neither of these two
> solutions are better than returning the actual errno which is deemed most
> appropriate by the platform profile handler. Or am I missing a third way?

Can we please defer this until we actually have a driver needing to
return different error values from ->get_profile() (and I find it hard
to believe that there will be any drivers like that)?

Let's do the simpler thing until we have a real need to do the more
complicated one.

Otherwise we're preparing for things that may never happen.
