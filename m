Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6285F2AE464
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 00:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbgKJXtB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 18:49:01 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:59742 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKJXtB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 18:49:01 -0500
Date:   Tue, 10 Nov 2020 23:48:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605052137;
        bh=QCQEYvzS954DA1XtnRB6bcr/J8KYUGWKdH/2S6xgIus=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=wG38k1ef0WfvbQFc5EvZn0IHciJJcF0BKD6GUAjYVy9mX/uA/xZwFS55phVo2YHp4
         SebKqUtOX18cLo34PDUcWr7Ctt+gOtupqnVXTvZ4aZGI1PEq9vG5HJPGVjKw7k/5UJ
         QHctJLjjuBY0b2Idm1ZZnSpiNWzUUpwrAGSO6a7U=
To:     Mark Pearson <markpearson@lenovo.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [External] Re: [PATCH 2/3] ACPI: platform-profile: Add platform profile support
Message-ID: <uaE8WMqn_yPjB2GzTz-7JGy2CdMlfz9r2Hy_oQ_cg_fvvNw1mkTQERLWS9Q3m9LI-ohJyOCC4wHDmm5X_qtWwUVW7XKlU--gVN3GWHms2zE=@protonmail.com>
In-Reply-To: <72b0fb0a-8007-d795-8b1a-68fa58231c23@lenovo.com>
References: <markpearson@lenovo.com> <20201110033124.3211-1-markpearson@lenovo.com> <20201110033124.3211-3-markpearson@lenovo.com> <2gY5rkKaKLKayk0DYW0lvZ_aIAs8vSf9FOy2obdGvph_7XcpyHlkafBTpW8RHKC5nEcEz_eY-s4pJtuR2ebltW2Fu10GRssTmMxKMuS4PU8=@protonmail.com> <72b0fb0a-8007-d795-8b1a-68fa58231c23@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi


> [...]
> >> +static char *profile_str[] =3D {
> >
> > Why is it not `const`?
> My mistake. I will fix
> >
> >
> >> +=09"Low-power",
> >> +=09"Cool",
> >> +=09"Quiet",
> >> +=09"Balance",
> >> +=09"Performance",
> >> +=09"Unknown"
> >
> > "unknown" is not documented, yet it may be returned to userspace.
> Ack - I'll look into if it's really needed, but it seemed sensible to
> have it whilst doing the implementation.

I don't advocate for its removal, just that it be documented if it may be
returned to userspace.


> >
> >
> >> +};
> [...]
> >> +#ifndef _PLATFORM_PROFILE_H_
> >> +#define _PLATFORM_PROFILE_H_
> >> +
> >> +/*
> >> + * If more options are added please update profile_str
> >> + * array in platform-profile.c
> >> + */
> >> +
> >> +enum profile_option {
> >> +=09profile_low,
> >> +=09profile_cool,
> >> +=09profile_quiet,
> >> +=09profile_balance,
> >> +=09profile_perform,
> >> +=09profile_unknown /* Must always be last */
> >> +};
> >
> > Shouldn't these be prefixed by `platform_`? And I think it'd be better =
to have
> > `profile_unknown` as the first value in the enumeration.
> I can add 'platform_'
> I liked having profile_unknown as the last value as it makes scanning
> from 'low' to 'unknown' more future proof if other profiles get added
> (e.g in platform_profile_choices_show).
> Is this something you feel strongly about?

I don't feel strongly about it, just that right now, for all practical purp=
oses
`profile_unknown` feels like a first-class profile option in the current fo=
rm of
the patch, and it didn't seem right that it can just change. I'd do somethi=
ng like
```
enum performance_profile_option {
  performance_profile_unknown,
  performance_profile_low,
  ...
  performance_profile_max, /* must be last */
};
```

But I don't have a strong preference for either one of them. Maybe someone
could chime in and tell us which one is more prevalent/preferred.

And as a side note, I think you could put something like
`static_assert(ARRAY_SIZE(profile_str) =3D=3D performance_profile_max);`
in the code somewhere to make sure there are as many strings in the array a=
s
profile options.

You might actually do the following as well:
```
static const char *profile_str[] =3D {
  [performance_profile_unknown] =3D "unknown",
  [performance_profile_low]     =3D "low",
  ...
};
```

I realize I might be a bit too paranoid here. :-) But if you do these three=
 things,
or something similar, then the chances of the enum and the array being out =
of
sync (by accident) will be very slim.


> [...]

Regards,
Barnab=C3=A1s P=C5=91cze
