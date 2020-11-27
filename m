Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A262C6C74
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Nov 2020 21:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgK0UPv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Nov 2020 15:15:51 -0500
Received: from mail-41103.protonmail.ch ([185.70.41.103]:60843 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgK0UPd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2020 15:15:33 -0500
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id B0288200FFC8
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2020 19:16:34 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="REHfzXAP"
Date:   Fri, 27 Nov 2020 19:14:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1606504468;
        bh=OFzHuFWdkGeaAG2R7kvwdvA/h6zW49kBYWeXaLISNXk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=REHfzXAP+nYXT6Bw88H+d97bBnhD98gesdW11OWojcxDCJeAanQWZzbkUFSkWQ21x
         Q845Xwjdv5D+fVDIJunIcCkWoUNC3tHOgwE0E4GzsTcQloCqRJSWcC6WyaI6VHdIg5
         ncX0hSS1UmnHJmty+jpPYZMxNrFhYIvlqhDOrdsU=
To:     Mark Pearson <markpearson@lenovo.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
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
Message-ID: <GojTnStq-_lTx1Zy0JIDn-_9ZHLyyTvtUeg4BwNAS51dogIGCn4Ou8qnRTqkJSjp6pHBv3SeuFthHhL58ID3tJSb7w31Ix-2UxExy-d-tIQ=@protonmail.com>
In-Reply-To: <20201126165143.32776-2-markpearson@lenovo.com>
References: <markpearson@lenovo.com> <20201126165143.32776-1-markpearson@lenovo.com> <20201126165143.32776-2-markpearson@lenovo.com>
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


2020. november 26., cs=C3=BCt=C3=B6rt=C3=B6k 17:51 keltez=C3=A9ssel, Mark P=
earson =C3=ADrta:

> [...]
+static const char * const profile_names[] =3D {
+=09[platform_profile_low] =3D "low-power",
+=09[platform_profile_cool] =3D "cool",
+=09[platform_profile_quiet] =3D "quiet",
+=09[platform_profile_balance] =3D "balance",

Documentation says "balanced".


+=09[platform_profile_perform] =3D "performance",
+};
> [...]
> +static ssize_t platform_profile_show(struct device *dev,
> +=09=09=09=09=09struct device_attribute *attr,
> +=09=09=09=09=09char *buf)
> +{
> +=09enum platform_profile_option profile =3D platform_profile_balance;
> +=09int err;
> +
> +=09err =3D mutex_lock_interruptible(&profile_lock);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (!cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -ENODEV;
> +=09}
> +
> +=09if (!cur_profile->profile_get) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -EOPNOTSUPP;
> +=09}
> +
> +=09err =3D cur_profile->profile_get(&profile);
> +=09mutex_unlock(&profile_lock);
> +=09if (err < 0)
> +=09=09return err;
> +

In `platform_profile_store()`, you do
```
err =3D cur_profile->profile_set(i);
if (err)
  return err;
```
but here you do `if (err < 0)`, why?


> +=09/* Check that profile is valid index */
> +=09if ((profile < 0) || (profile >=3D ARRAY_SIZE(profile_names)))
> +=09=09return sysfs_emit(buf, "\n");
> +

I'd write `if (WARN_ON(profile < 0 ....))` since that is serious error in m=
y
opinion which should be logged. I am also not sure if


> +=09return sysfs_emit(buf, "%s\n", profile_names[profile]);
> +}
> [...]
> +int platform_profile_unregister(void)
> +{
> +=09int err;
> +
> +=09err =3D mutex_lock_interruptible(&profile_lock);
> +=09if (err)
> +=09=09return err;
> +

I know it was me who said to prefer `mutex_lock_interruptible()`, but in th=
is
particular instance I believe `mutex_lock()` would be preferable to avoid t=
he case
where the module unloading is interrupted, and thus the profile handler is =
not
unregistered properly. This could be handled in each module that uses this
interface, however, I believe it'd be better to handle it here.


> +=09if (!cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -ENODEV;
> +=09}
> +
> +=09sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +=09cur_profile =3D NULL;
> +=09mutex_unlock(&profile_lock);
> +=09return 0;
> +}
> [...]


Regards,
Barnab=C3=A1s P=C5=91cze

