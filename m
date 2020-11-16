Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6C2B410C
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 11:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgKPKYo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 05:24:44 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:49272 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgKPKYn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2020 05:24:43 -0500
Date:   Mon, 16 Nov 2020 10:24:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605522280;
        bh=/ijmMjbqpNTq4mLlFzz0UsizVrlSjKLUAToZdD0LG5s=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=xLb3dHueurnCsf1I2/W39whiaGvBRe03zwil3TY7cLICLq8RvlKSzCLw1U12WGqIK
         ok9qoKTAhc9KgoVMMBJAH53oks3Xtgv/v7HI5ALvfCYOLHi2yilGhGjtK9zzgmbqTR
         gMH58owv80FqGMOfXCWanEFVAovfKbjD4cP68Gew=
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
Subject: Re: [External] Re: [PATCH v3] ACPI: platform-profile: Add platform profile support
Message-ID: <V-4DMCmZGmDmzaFHHwDhxqTzfNm25SyViOwvoJKvAUytgpL2XlM5u9GZy5AOfxN0r0QjSoCBFt5PQvUtbVRUQQE8oiRzB2j_HGM7U_4s304=@protonmail.com>
In-Reply-To: <3bdd8da6-a47a-fbc6-de0e-858f493a226e@lenovo.com>
References: <markpearson@lenovo.com> <20201115004402.342838-1-markpearson@lenovo.com> <qpTm5tmuwsXyXCvmpN4vhQoKis0E5jCcILd49n6_9cqzEuN_Pd9iwMEXAFRQQmGf-rCyHe-LfhjTa15-DTTu9sFQCSQaca1KVfqYggmSGts=@protonmail.com> <3bdd8da6-a47a-fbc6-de0e-858f493a226e@lenovo.com>
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


2020. november 16., h=C3=A9tf=C5=91 0:04 keltez=C3=A9ssel, Mark Pearson =
=C3=ADrta:

> [...]
> >> +static ssize_t platform_profile_store(struct device *dev,
> >> +=09=09=09    struct device_attribute *attr,
> >> +=09=09=09    const char *buf, size_t count)
> >> +{
> >> +=09int err, i;
> >> +
> >> +=09mutex_lock(&profile_lock);
> >> +=09if (!cur_profile) {
> >> +=09=09mutex_unlock(&profile_lock);
> >> +=09=09return -EOPNOTSUPP;
> >
> > I'm not sure why you modified the errno. ENODEV seemed to me like a per=
fectly
> > fine error to return if `cur_profile` is not set. `platform_profile_cho=
ices_show()`
> > returns ENODEV, so there is a bit of inconsistency.
> > (same applies to `platform_profile_show()`)
> My thinking was it seemed a better message. I can't really see any
> conditions when you'd get here (a driver would have registered a driver
> and then not provided a profile?) but it seemed that if that was
> possible it was more because changing the settings wasn't supported.
>
> I managed to convince myself it made more sense - but have no issue with
> changing it back.
> >
> >
> >> +=09}
> >> +
> >> +=09/* Scan for a matching profile */
> >> +=09i =3D sysfs_match_string(profile_names, buf);
> >> +=09if (i < 0) {
> >> +=09=09mutex_unlock(&profile_lock);
> >> +=09=09return -EINVAL;
> >> +=09}
> >> +
> >> +=09if (!cur_profile->profile_set) {
> >> +=09=09mutex_unlock(&profile_lock);
> >> +=09=09return -EOPNOTSUPP;
> >> +=09}
> >> +

One thing I have just noticed is that I believe the selected profile should=
 be
checked against `cur_profile->choices`, don't you think? I have assumed for
some reason that this check is done, and `profile_set` is only called with =
values
that the handler supports (they are in `choices`) up until now, but I see
that that's not what's happening.


> >> +=09err =3D cur_profile->profile_set(i);
> >> +=09mutex_unlock(&profile_lock);
> >> +=09if (err)
> >> +=09=09return err;
> >> +
> >> +=09return count;
> >> +}
> [...]
> >> diff --git a/include/linux/platform_profile.h b/include/linux/platform=
_profile.h
> >> new file mode 100644
> >> index 000000000000..f6592434c8ce
> >> --- /dev/null
> >> +++ b/include/linux/platform_profile.h
> >> @@ -0,0 +1,36 @@
> [...]
> >
> > By the way, I still feel like the enum values are "too vague" and shoul=
d be
> > prefixed with `platform_`. If you're not opposed to that change.
> Sure - I can change that. For me it made the names long but I don't mind
> changing them.

Short and succinct names a good, but I hope you can see why I'm saying what=
 I'm
saying. I believe these names should be "properly namespaced" since they ar=
e in
a "kernel-global" header file.


> >
> >
> >> +};
> >> +
> >> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
