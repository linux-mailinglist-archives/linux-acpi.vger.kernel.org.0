Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1372DC769
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Dec 2020 20:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgLPTvl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 16 Dec 2020 14:51:41 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43715 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgLPTvk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2020 14:51:40 -0500
Received: by mail-oi1-f174.google.com with SMTP id q25so28996919oij.10;
        Wed, 16 Dec 2020 11:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VG2a+aUeuUJoDGJ2T+H988ucb0Jvb5rhppA8FZY5au8=;
        b=c5MYILstHNkf58dsygRVqtdoAVVopDu9OmuCrAP7nhEG9HlEMOyNq7oK1jT+7UHDWG
         9cty2wLBHMfJpVdDjVS4twsRJLb/v87hnl3Sp26bg2eAAJL3kGQL5ZMEZRgD8XQlIndc
         k6pori8lxhU0yhoidlx9yd4MC195zAcbeuOiDU9t0iWJOtzgvV/eo9TnxDf8FhSQBsV1
         59hvrllgkWWgzYjDDWgCOxihOWXJoDnKTUwmQuKpwFK86dzsiGatdptuo+xWuh8L5HIM
         sB3qm5NWUg7OtvQcybyomGYNeMTA/h6oXrLP++1AZrOCWrwOGvxA3i8faNTvl8qouhIY
         f/mQ==
X-Gm-Message-State: AOAM533kvTiQSML4NLpwjvqF8+RWNvwBG9AHYpe8hW8x6nfxds2qYihC
        G+RTqh3wI/VpJccdX/FsRtsJxwzmj53qxcP54Jk=
X-Google-Smtp-Source: ABdhPJykO92G9OqKIjRxc7/savxQfRiE8NKCX9VAmO3ifEvDSzdzM9pXqfWVKQ1pO2kqwMy6CkAZLgAqLXo6hMTBBTM=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr2739376oib.69.1608148259920;
 Wed, 16 Dec 2020 11:50:59 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201211020630.305905-1-markpearson@lenovo.com>
 <20201211020630.305905-2-markpearson@lenovo.com> <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com>
 <l-Nzteqdz9SbINiwW0w4kFnKwknGoh5DH7VXqvkb23SZPwhvNyna0FRV9z2IZ18T0S9-a4n3LGBR1pMZYKX4FcxNTOma7vIuya66CY_Mkpc=@protonmail.com>
 <CAJZ5v0hHoScy18FE_Aj+zoWpr-vUhGq-vO+8AjO7RxmOvZBYMA@mail.gmail.com> <00993237-eb24-6038-3a85-bb76f96f679d@lenovo.com>
In-Reply-To: <00993237-eb24-6038-3a85-bb76f96f679d@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Dec 2020 20:50:45 +0100
Message-ID: <CAJZ5v0ji_+BbCrJo=3TB1Cytb8eV-tGE_m6R35UYfwmpUs6MAg@mail.gmail.com>
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

On Wed, Dec 16, 2020 at 8:19 PM Mark Pearson <markpearson@lenovo.com> wrote:
>
> Hi Rafael,
>
> On 16/12/2020 13:47, Rafael J. Wysocki wrote:
> > On Wed, Dec 16, 2020 at 7:42 PM Barnabás Pőcze <pobrn@protonmail.com> wrote:
> >>
> >> 2020. december 16., szerda 19:13 keltezéssel, Rafael J. Wysocki írta:
> >>
> >>> On Fri, Dec 11, 2020 at 3:15 AM Mark Pearson <markpearson@lenovo.com> wrote:
> >>>>
> >>>> This is the initial implementation of the platform-profile feature.
> >>>> It provides the details discussed and outlined in the
> >>>> sysfs-platform_profile document.
> >>>>
> >>>> Many modern systems have the ability to modify the operating profile to
> >>>> control aspects like fan speed, temperature and power levels. This
> >>>> module provides a common sysfs interface that platform modules can register
> >>>> against to control their individual profile options.
> >>>>
> >>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> >>> [...]
> >>>> +enum platform_profile_option {
> >>>> +       PLATFORM_PROFILE_LOW,
> >>>> +       PLATFORM_PROFILE_COOL,
> >>>> +       PLATFORM_PROFILE_QUIET,
> >>>> +       PLATFORM_PROFILE_BALANCED,
> >>>> +       PLATFORM_PROFILE_PERFORM,
> >>>> +       PLATFORM_PROFILE_LAST, /*must always be last */
> >>>> +};
> >>>> +
> >>>> +struct platform_profile_handler {
> >>>> +       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >>>> +       int (*profile_get)(enum platform_profile_option *profile);
> >>>
> >>> I'm not sure why this callback is necessary and, provided that there
> >>> is a good enough reason, why it cannot return an enum
> >>> platform_profile_option value.
> >>>
> >>> In principle, if ->profile_set() returns 0, the requested profile can
> >>> be saved in a static var and then returned by subsequent "read"
> >>> operations.
> >>>
> >>
> >> It is possible that the platform profile can be changed with (e.g.) a dedicated
> >> button (commonly found on laptops), in which case there needs to be a mechanism
> >> to retrieve the new profile, which would not be possible without introducing
> >> something else in place of that getter - unless I'm missing something obvious.
> >
> > Fair enough.
> >
> > The other question remains, then.
> >
> My thinking here that I shouldn't make assumptions for future platform
> implementations - there may be valid cases in the future where being
> able to return an error condition if there was an error would be useful.
>
> Just trying to keep this somewhat future proof. Returning an error
> condition seemed a useful thing to have available.

You can still return an error while returning a platform_profile_option value.

Just add a special value representing an error to that set.
