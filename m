Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E12C729D
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Nov 2020 23:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389930AbgK1VuM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Nov 2020 16:50:12 -0500
Received: from mail-41103.protonmail.ch ([185.70.41.103]:58289 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgK1SGN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Nov 2020 13:06:13 -0500
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 9165B20000A1
        for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2020 15:37:56 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="V4O4unyV"
Date:   Sat, 28 Nov 2020 15:37:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1606577873;
        bh=B+V4mS7J4ue7BMs1VbspTddvELqxycTImgNdKUYU1zg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=V4O4unyV6CK4jnkLr2SQOPI3RQnWZHMbEIihmflTV7D8g67R9wSlBUClMMOOu2g0l
         oVEWGJipvK8GdfiCREjUY8UHd/Nywl9Tg+3ZbibLEXJmy6JiBVz1NZSvQiSK+6TzLJ
         ZldUjeM2brLFlTDFpm//QqMlaIXtNYrUfMtfOr+g=
To:     Hans de Goede <hdegoede@redhat.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "mario.limnociello@dell.com" <mario.limnociello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v4 2/3] ACPI: platform-profile: Add platform profile support
Message-ID: <tvhsHrDOOP32PZfdoiajK4HUiE7pV3yfxAjHkied_GvQd3tPUQXxfPAI0P84ovCJjmNYib68twP2_ESRc-fyoUzUAJkTvWsobXdWfJGW74s=@protonmail.com>
In-Reply-To: <faa32924-f53f-b3fd-3f24-3848f45b67e1@redhat.com>
References: <markpearson@lenovo.com> <20201126165143.32776-1-markpearson@lenovo.com> <20201126165143.32776-2-markpearson@lenovo.com> <faa32924-f53f-b3fd-3f24-3848f45b67e1@redhat.com>
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


2020. november 28., szombat 15:08 keltez=C3=A9ssel, Hans de Goede =C3=ADrta=
:

> [...]
> > +static_assert(ARRAY_SIZE(profile_names) =3D=3D platform_profile_perfor=
m+1);
>
> It would be better to add an extra member/entry at the end of the enum
> named platform_profile_no_profiles; and then use that instead of
> platform_profile_perform+1. Also see below where I use this too.
>

I'm not sure if it's just me, but when I read "no_profiles", then "number o=
f probiles"
is not the first thing that comes to mind, maybe _end, _last, _max, etc.
would be harder to mistake for something else? What do you think?


> > +
> > +static ssize_t platform_profile_choices_show(struct device *dev,
> > +=09=09=09=09=09struct device_attribute *attr,
> > +=09=09=09=09=09char *buf)
> > +{
> > +=09int len =3D 0;
> > +=09int err, i;
> > +
> > +=09err =3D mutex_lock_interruptible(&profile_lock);
> > +=09if (err)
> > +=09=09return err;
> > +
> > +=09if (!cur_profile) {
> > +=09=09mutex_unlock(&profile_lock);
> > +=09=09return -ENODEV;
> > +=09}
> > +
> > +=09if (!cur_profile->choices) {
> > +=09=09mutex_unlock(&profile_lock);
> > +=09=09return sysfs_emit(buf, "\n");
> > +=09}
>
> If choices is empty, the for below will never print anything and
> the end result is still just emitting "\n", so this whole if
> block is unnecessary and can be removed.
>
> > +
> > +=09for (i =3D 0; i < ARRAY_SIZE(profile_names); i++) {
> > +=09=09if (cur_profile->choices & BIT(i)) {
>
> Please change the type of choices to an unsigned long array, like this:
>
> =09unsigned long choices[BITS_TO_LONGS(platform_profile_no_profiles)];
>

Sorry for the ignorant question, but does this play well with initializatio=
n?
Can something like this be done easily?
```
struct platform_profile_handler pph =3D {
  .choices =3D BIT(...) | BIT(...) | etc.
};
```
Or do you need to use something like `__set_bit()` in a function?


> [...]
> > +int platform_profile_register(const struct platform_profile_handler *p=
prof)
> > +{
> > +=09int err;
>
> Maybe sanity check the platform_profile_handler a bit here,
> I think it would be ok to check that choices, profile_set and profile_get
> are all not 0 / NULL here and otherwise just return -EINVAL; Doing so
> allows making the code above a bit simpler, also removing some exit
> paths which require an unlock before exiting.
>
> > +
> > +=09err =3D mutex_lock_interruptible(&profile_lock);
> > +=09if (err)
> > +=09=09return err;
>
> Please use a regular mutex_lock here, this is called during
> driver probing, so no need to handle Ctrl+C and other signals.
> [...]

I believe insmod/modprobe can be interrupted,
but I agree that's not really of any concern here.



Regards,
Barnab=C3=A1s P=C5=91cze
