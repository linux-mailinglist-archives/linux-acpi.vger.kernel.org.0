Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7775E2DD244
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 14:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgLQNhr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 17 Dec 2020 08:37:47 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43839 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgLQNhr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 08:37:47 -0500
Received: by mail-ot1-f54.google.com with SMTP id q25so27246125otn.10;
        Thu, 17 Dec 2020 05:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NoeXfB0eJPirdXd7MaQdan24LqFp/TWBS4FGEpeBf/I=;
        b=LP5Sd2WOXfb7VT5Fs3DQW/esD6ZkBxRm5/oZ7ig36cIlrasqQeinWd3vHGyQyiECnY
         nQwtwR663Qa/o0US23rp3sf/NrKPpS5hqyuPPm5i8qIA59P5W05w+yk3GN/tRkYQeYKw
         0SkGnk6wELAObeu2zZewYEa/UiTmJ+NL7LZpvrybDuxh9yjjhkb/rHAemzk8Yj4wTNYY
         R1SO2OaJju4h7I+zs/zdYVlLI2kos5NzFlmLstvI9fptZQX1MOkrBHD1Pr5ZtPIz4MGr
         GyzTvJUyLTDtarojADbPwv+OsOmf0hnh/j5o9/AW12taunou7DqEgew4c2AKsm3CXaGc
         lHmA==
X-Gm-Message-State: AOAM533q8tH6ou2JGQdVDbiGlda7zVrO1b2YVifk2x4JR0YzzwOScG4S
        yjLkXTCgOLml+VQbruoEVK8d0uJ6cXfR/JV6WrE=
X-Google-Smtp-Source: ABdhPJzPyUxK+WTRxxu4WMLdQODS6OnQ49unx0eK5CeBccees2hMYYDJlwxpG2PxyhL8cNWmAUJs1At+u1O1+Aw0UQU=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr27415863ota.260.1608212226334;
 Thu, 17 Dec 2020 05:37:06 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201211020630.305905-1-markpearson@lenovo.com>
 <20201211020630.305905-2-markpearson@lenovo.com> <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com>
 <l-Nzteqdz9SbINiwW0w4kFnKwknGoh5DH7VXqvkb23SZPwhvNyna0FRV9z2IZ18T0S9-a4n3LGBR1pMZYKX4FcxNTOma7vIuya66CY_Mkpc=@protonmail.com>
 <CAJZ5v0hHoScy18FE_Aj+zoWpr-vUhGq-vO+8AjO7RxmOvZBYMA@mail.gmail.com>
 <00993237-eb24-6038-3a85-bb76f96f679d@lenovo.com> <CAJZ5v0ji_+BbCrJo=3TB1Cytb8eV-tGE_m6R35UYfwmpUs6MAg@mail.gmail.com>
 <e682cdbd-41fe-065e-5912-d0fb94879dc9@lenovo.com>
In-Reply-To: <e682cdbd-41fe-065e-5912-d0fb94879dc9@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Dec 2020 14:36:54 +0100
Message-ID: <CAJZ5v0gMo_22OJvjrufJy6uQsMjh+AT_mYQyFD-LpNzAwhkimA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 2/3] ACPI: platform-profile: Add
 platform profile support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
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

On Wed, Dec 16, 2020 at 10:36 PM Mark Pearson <markpearson@lenovo.com> wrote:
>
>
> On 16/12/2020 14:50, Rafael J. Wysocki wrote:
> > On Wed, Dec 16, 2020 at 8:19 PM Mark Pearson <markpearson@lenovo.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 16/12/2020 13:47, Rafael J. Wysocki wrote:
> >>> On Wed, Dec 16, 2020 at 7:42 PM Barnabás Pőcze <pobrn@protonmail.com> wrote:
> >>>>
> >>>> 2020. december 16., szerda 19:13 keltezéssel, Rafael J. Wysocki írta:
> >>>>
> >>>>> On Fri, Dec 11, 2020 at 3:15 AM Mark Pearson <markpearson@lenovo.com> wrote:
> >>>>>>
> >>>>>> This is the initial implementation of the platform-profile feature.
> >>>>>> It provides the details discussed and outlined in the
> >>>>>> sysfs-platform_profile document.
> >>>>>>
> >>>>>> Many modern systems have the ability to modify the operating profile to
> >>>>>> control aspects like fan speed, temperature and power levels. This
> >>>>>> module provides a common sysfs interface that platform modules can register
> >>>>>> against to control their individual profile options.
> >>>>>>
> >>>>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> >>>>> [...]
> >>>>>> +enum platform_profile_option {
> >>>>>> +       PLATFORM_PROFILE_LOW,
> >>>>>> +       PLATFORM_PROFILE_COOL,
> >>>>>> +       PLATFORM_PROFILE_QUIET,
> >>>>>> +       PLATFORM_PROFILE_BALANCED,
> >>>>>> +       PLATFORM_PROFILE_PERFORM,
> >>>>>> +       PLATFORM_PROFILE_LAST, /*must always be last */
> >>>>>> +};
> >>>>>> +
> >>>>>> +struct platform_profile_handler {
> >>>>>> +       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >>>>>> +       int (*profile_get)(enum platform_profile_option *profile);
> >>>>>
> >>>>> I'm not sure why this callback is necessary and, provided that there
> >>>>> is a good enough reason, why it cannot return an enum
> >>>>> platform_profile_option value.
> >>>>>
> >>>>> In principle, if ->profile_set() returns 0, the requested profile can
> >>>>> be saved in a static var and then returned by subsequent "read"
> >>>>> operations.
> >>>>>
> >>>>
> >>>> It is possible that the platform profile can be changed with (e.g.) a dedicated
> >>>> button (commonly found on laptops), in which case there needs to be a mechanism
> >>>> to retrieve the new profile, which would not be possible without introducing
> >>>> something else in place of that getter - unless I'm missing something obvious.
> >>>
> >>> Fair enough.
> >>>
> >>> The other question remains, then.
> >>>
> >> My thinking here that I shouldn't make assumptions for future platform
> >> implementations - there may be valid cases in the future where being
> >> able to return an error condition if there was an error would be useful.
> >>
> >> Just trying to keep this somewhat future proof. Returning an error
> >> condition seemed a useful thing to have available.
> >
> > You can still return an error while returning a platform_profile_option value.
> >
> > Just add a special value representing an error to that set.
> >
> I'd like to understand what is better about that approach than having an
> error and a returnable parameter?
>
> I'm probably missing something obvious but if I add an extra
> platform_profile option (e.g PLATFORM_PROFILE_ERROR) to be used in an
> error case (and return just an enum platform_profile_option) it seems I
> lose the granularity of being able to return a specific error condition.
> It doesn't feel like an improvement.

And what's the user expected to do about the different error codes
that can be returned?
