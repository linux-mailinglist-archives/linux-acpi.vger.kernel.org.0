Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A1729A7A3
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 10:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442759AbgJ0JTU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 05:19:20 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36849 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387859AbgJ0JTT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 05:19:19 -0400
Received: by mail-wr1-f44.google.com with SMTP id x7so1029134wrl.3;
        Tue, 27 Oct 2020 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OOfjhuhTD9zQyQKa367WJYfNXLO5sju7NGsP+LncHg=;
        b=EfibJUiWTOmw1OAgBReOF9qT+M2VDkU6Smvd2+iVxdSy8OqnMwJOpi4J107Dex99oB
         NX2UvZ3g5Xi0/X2lDsPc6wQ1pKzR3ayklDOAebOb2Rr+v0XZR2jYXQ7Lj3pqATLIBPz+
         +PsLmjLmuUmttB3vSWSnPpS7P9ZqNJEeww7k1LgTIFebFEEd2INV5i7BQwZNfmo5ZS+6
         VZnsW8802co1MNN9M9da9w31SZL2bbNifHmw+3c3B47Qvd1T6zXHTe6H4ovRxygNjS2E
         oKORkS2dRnJfhu6sG4FuGYOLym6BoQnrdzmWDuu42DCfG7q2h1PxZoz2pFm63+PhMpgQ
         zRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OOfjhuhTD9zQyQKa367WJYfNXLO5sju7NGsP+LncHg=;
        b=AY+bh08/HZeNVM9AZnXA2EUtSHn4kbZtEgoCXntERf+DKD9DzAbrcDjaK6Xd5D6cVt
         0+xMUwko3+bpi0hCmFo3ECqHAyiQeqxa8BORWgYR2Itmw5W0Kw3rGtg10v7ecHmXlw/9
         iygXUDSKZbr5rmBdG1YvmJjuZZ3SCPzx5KXGELL02gxAk+bsSoYmMt0L5qbXGFUzSBkd
         Cj7CxL5kwU9pOCLTN8OCgJ6sWQoz3WxgmMO0B0HR0z9MpaP8qVZDfFH/ZEm4QN9a5dbT
         D313XbtnfETyHXJIY31oD4TkcEiRicvcAzQ+pm8pWYAEa+4Nk7KOOnBDd8GHj5ER87wp
         2apQ==
X-Gm-Message-State: AOAM5333t4gFsC02AE7ZrVxCnhjFeyj5uuqowqrarYeOjnOB9iu6K/8o
        ESKMdebICysuE9S2MVOHocw=
X-Google-Smtp-Source: ABdhPJzelJGygDhpfTD4K7Y5hLTcBYoUOdTRtidWUuS8SAfNUXBwHVLsL+KZ9XT82ccJOtlkNRfYjg==
X-Received: by 2002:adf:d84e:: with SMTP id k14mr1745123wrl.251.1603790355966;
        Tue, 27 Oct 2020 02:19:15 -0700 (PDT)
Received: from pce.localnet (host-80-117-125-178.pool80117.interbusiness.it. [80.117.125.178])
        by smtp.gmail.com with ESMTPSA id x10sm1160524wrp.62.2020.10.27.02.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:19:15 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
To:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, hadess@hadess.net, bberg@redhat.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] [RFC] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Tue, 27 Oct 2020 10:19:12 +0100
Message-ID: <12633630.uLZWGnKmhe@pce>
In-Reply-To: <1fbaf1fa-47c6-afe7-ca9e-41b3ad6a4556@redhat.com>
References: <markpearson@lenovo.com> <ef9b93a0-636f-9b96-9d5b-fee1e5738af7@lenovo.com> <1fbaf1fa-47c6-afe7-ca9e-41b3ad6a4556@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi to all,

In data marted=EC 27 ottobre 2020 08:54:44 CET, Hans de Goede ha scritto:
> Hi,
>=20
> On 10/26/20 8:55 PM, Mark Pearson wrote:
> > Thanks Hans
> >=20
> > On 26/10/2020 14:33, Hans de Goede wrote:
> >> Hi Mark,
> >>=20
> >> Thank you for this new version.
> >>=20
> >> On 10/26/20 6:44 PM, Mark Pearson wrote:
> >>> From: Hans de Goede <hdegoede@redhat.com>
> >=20
> > <snip>
> >=20
> >>> +
> >>> +If for some reason there is no good match when mapping then a new
> >>> profile-name +may be added. Drivers which wish to introduce new
> >>> profile-names must: +1. Have very good reasons to do so.
> >>> +2. Add the new profile-name to this document, so that future drivers
> >>> which also +   have a similar problem can use the same new.
> >>=20
> >> s/same new/same name/
> >=20
> > I've read this document so many times...I'm not sure how I missed that
> > one. Thanks.>=20
> >>> + Usually new profile-names will
> >>> +   be added to the "extra profile-names" section of this document. B=
ut
> >>> in some +   cases the set of standard profile-names may be extended.
> >>=20
> >> With the change from a more generic API to this new one more targeted
> >> towards DPTF I would drop this part.
> >=20
> > OK - I have some questions then related to this change, below
> >=20
> >>> +
> >>> +What:        /sys/firmware/acpi/platform_profile_choices
> >>> +Date:        October 2020
> >>> +Contact:    Hans de Goede <hdegoede@redhat.com>
> >>> +Description:
> >>> +        Reading this file gives a space separated list of profiles
> >>> +        supported for this device.
> >>> +
> >>> +        Drivers must use the following standard profile-names whenev=
er
> >>> +        possible:
> >>> +
> >>> +        low-power:        Emphasises low power consumption
> >>> +        quiet:            Offers quieter operation (lower fan
> >>> +                    speed but with higher performance and
> >>> +                    temperatures then seen in low-power
> >>=20
> >> I think the description here is a bit too specific, this may cause
> >> userspace to have expectations which are not necessary true. I would
> >> describe this as just:
> >>=20
> >>         quiet:            Emphasises quieter operation
> >=20
> > Agreed. I'll update
> >=20
> >>> +        balanced:        Balance between low power consumption
> >>> +                    and performance
> >>> +        performance:        Emphasises performance (and may lead to
> >>> +                    higher temperatures and fan speeds)
> >>> +
> >>> +        Userspace may expect drivers to offer at least several of th=
ese
> >>> +        standard profile-names! If none of the above are a good match
> >>> +        for some of the drivers profiles, then drivers may use one of
> >>> +        these extra profile-names:
> >>> +        <reserved for future use>
> >>> +
> >=20
> > If we remove the extra profile-names section above then I think it shou=
ld
> > be removed here too. If someone wants to add a new 'mode' then it would
> > be added to the list of 'standard names', and becomes a new option.
> > Wanted to check I'm not missing something important.
> You are completely right, any references to an extra profile-names section
> should be removed here too. I did intend to add that it should be removed
> here too, but I forgot.
>=20
> >>> +What:        /sys/firmware/acpi/platform_profile
> >>> +Date:        October 2020
> >>> +Contact:    Hans de Goede <hdegoede@redhat.com>
> >>> +Description:
> >>> +        Reading this file gives the current selected profile for this
> >>> +        device. Writing this file with one of the strings from
> >>> +        available_profiles changes the profile to the new value.
> >>=20
> >> The part about custom profiles below may be dropped. That was intended
> >> for use with e.g. GPUs but since this now strictly is a system-level
> >> profile API, the part below can be dropped now.
> >=20
> > Agreed
> >=20
> >>> +
> >>> +        Reading this file may also return "custom". This is intended
> >>> for
> >>> +        drivers which have and export multiple knobs. Such drivers m=
ay
> >>> +        very well still want to offer a set of profiles for easy of =
use
> >>> +        and to be able to offer a consistent standard API (this API)=
 to
> >>> +        userspace for configuring their performance. The "custom" va=
lue
> >>> +        is intended for when ai user has directly configured the kno=
bs
> >>> +        (through e.g. some advanced control-panel for a GPU) and the
> >>> +        knob values do not match any of the presets represented by t=
he
> >>> +        platform-profiles. In this case writing this file will
> >>> +        override the modifications and restore the selected presets.
> >>> +
> >>=20
> >> Regards,
> >>=20
> >> Hans
> >=20
> > Thanks!
> > mark
>=20
> Regards,
>=20
> Hans

This look good,
only thing is that hp-wmi driver need a cool profile (Emphasises the comput=
er=20
cool to touch), if you can add it would be perfect.

Regards
Elia



