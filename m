Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2B2AD382
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 11:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKJKUH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 05:20:07 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:41982 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJKUH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 05:20:07 -0500
Date:   Tue, 10 Nov 2020 10:15:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605003600;
        bh=hQly7mdUFe6QKrsqMJ4ERsdQsbqOi8MW5KLKpd3SIKM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=X0e007OBTYu+h56EICJbXKnCNcNRx7JeXvx5wbeSbMVd9vCHFOcpHwGnFiuHJQrEs
         z112Ms4gBOWENKGgpWVmyjFKRwFpV+Rwp/TbqjMffIiXtCkGegzXVWQF7Kjoe9Xw9c
         k5SprPw6WlP5cpBhtl4Y1WeJk6JeJiQO1+zzwSJU=
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
Subject: Re: [PATCH 2/3] ACPI: platform-profile: Add platform profile support
Message-ID: <2gY5rkKaKLKayk0DYW0lvZ_aIAs8vSf9FOy2obdGvph_7XcpyHlkafBTpW8RHKC5nEcEz_eY-s4pJtuR2ebltW2Fu10GRssTmMxKMuS4PU8=@protonmail.com>
In-Reply-To: <20201110033124.3211-3-markpearson@lenovo.com>
References: <markpearson@lenovo.com> <20201110033124.3211-1-markpearson@lenovo.com> <20201110033124.3211-3-markpearson@lenovo.com>
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

I've added some questions and comments inline.



2020. november 10., kedd 4:31 keltez=C3=A9ssel, Mark Pearson =C3=ADrta:

> [...]
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> new file mode 100644
> index 000000000000..3c460c0a3857
> --- /dev/null
> +++ b/drivers/acpi/platform_profile.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + *  platform_profile.c - Platform profile sysfs interface
> + */
> +
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/string.h>
> +#include <linux/device.h>
> +#include <linux/acpi.h>
> +#include <linux/mutex.h>
> +#include <acpi/acpi_bus.h>
> +#include <linux/platform_profile.h>

This should preferably be alphabetically sorted.


> +
> +struct platform_profile *cur_profile;

This should be `static`.


> +DEFINE_MUTEX(profile_lock);
> +
> +/* Ensure the first char of each profile is unique */

I wholeheartedly disagree that only the first character should be considere=
d.
It is not future-proof, potentially subverts user expectation, and even wor=
se,
someone could rely on this (undocumented) behaviour.


> +static char *profile_str[] =3D {

Why is it not `const`?


> +=09"Low-power",
> +=09"Cool",
> +=09"Quiet",
> +=09"Balance",
> +=09"Performance",
> +=09"Unknown"

"unknown" is not documented, yet it may be returned to userspace.


> +};

The documentation has the names in all-lowercase, and in my opinion it'd be
better to use lowercase names here as well.


> +
> +static ssize_t platform_profile_choices_show(struct device *dev,
> +=09=09=09=09=09struct device_attribute *attr,
> +=09=09=09=09=09char *buf)
> +{
> +=09int i;
> +=09int ret, count =3D 0;
> +
> +=09mutex_lock(&profile_lock);
> +=09if (!cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -ENODEV;
> +=09}
> +
> +=09if (!cur_profile->choices) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return snprintf(buf, PAGE_SIZE, "None");

"None" is not documented anywhere as far as I can see, maybe an empty line
would be better in this case?


> +=09}
> +
> +=09for (i =3D profile_low; i < profile_unknown; i++) {
> +=09=09if (cur_profile->choices & (1 << i)) {

`BIT(i)`?


> +=09=09=09ret =3D snprintf(buf+count, PAGE_SIZE, "%s ", profile_str[i]);

You could use `sysfs_emit_at()`. `ret` is only used in this block, so it co=
uld be
defined here.


> +=09=09=09if (ret < 0)
> +=09=09=09=09break;

However unlikely this case is, I'm not sure if providing partial values is
better than not providing any data at all.


> +=09=09=09count +=3D ret;
> +=09=09}
> +=09}
> +=09mutex_unlock(&profile_lock);

I think a newline character should be written at the end (possibly overwrit=
ing
the last space).


> +=09return count;
> +}
> +
> +static ssize_t platform_profile_show(struct device *dev,
> +=09=09=09=09=09struct device_attribute *attr,
> +=09=09=09=09=09char *buf)
> +{
> +=09enum profile_option profile =3D profile_unknown;
> +
> +=09mutex_lock(&profile_lock);
> +=09if (!cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -ENODEV;
> +=09}
> +=09if (cur_profile->profile_get)
> +=09=09profile =3D cur_profile->profile_get();

I'd assume that `profile_get()` can return any arbitrary errno, which is th=
en
propagated to the "reader", but it seems that's not the case?
I think returning `-EOPNOTSUPP` would be better if `profile_get` is NULL.


> +=09mutex_unlock(&profile_lock);
> +
> +=09return snprintf(buf, PAGE_SIZE, "%s", profile_str[profile]);

There is `sysfs_emit()`, as far as I know it is supposed to replace this ex=
act
snprintf(...) idiom. Directly indexing the `profile_str` with an unchecked
value here is rather unsafe in my opinion.


> +}
> +
> +static ssize_t platform_profile_store(struct device *dev,
> +=09=09=09    struct device_attribute *attr,
> +=09=09=09    const char *buf, size_t count)
> +{
> +=09enum profile_option profile;
> +
> +=09mutex_lock(&profile_lock);
> +=09if (!cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -ENODEV;
> +=09}
> +
> +=09/* Scan for a matching profile */
> +=09for (profile =3D profile_low; profile < profile_unknown; profile++) {
> +=09=09if (toupper(buf[0]) =3D=3D profile_str[profile][0])
> +=09=09=09break;
> +=09}
> +=09if (profile =3D=3D profile_unknown) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09if (cur_profile->profile_set)
> +=09=09cur_profile->profile_set(profile);

The return value is entirely discarded? I'd assume it's returned to the "wr=
iter".
I'm also not sure if ignoring if `profile_set` is NULL is the best course o=
f
action. Maybe returning `-EOPNOTSUPP` would be better?


> +
> +=09mutex_unlock(&profile_lock);
> +=09return count;
> +}
> +
> +static DEVICE_ATTR_RO(platform_profile_choices);
> +static DEVICE_ATTR_RW(platform_profile);
> +
> +static struct attribute *platform_profile_attributes[] =3D {
> +=09&dev_attr_platform_profile_choices.attr,
> +=09&dev_attr_platform_profile.attr,
> +=09NULL,
> +};
> +
> +static const struct attribute_group platform_profile_attr_group =3D {
> +=09.attrs =3D platform_profile_attributes,
> +};

It's a minor thing, but there is an `ATTRIBUTE_GROUPS()` macro which could =
possibly
simplify the above part.


> +
> +int platform_profile_notify(void)
> +{
> +=09if (!cur_profile)
> +=09=09return -ENODEV;
> +=09sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_notify);
> +
> +int platform_profile_register(struct platform_profile *pprof)
> +{
> +=09mutex_lock(&profile_lock);
> +=09/* We can only have one active profile */
> +=09if (cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -EEXIST;
> +=09}
> +=09cur_profile =3D pprof;
> +=09mutex_unlock(&profile_lock);
> +=09return sysfs_create_group(acpi_kobj, &platform_profile_attr_group);
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_register);
> +
> +int platform_profile_unregister(void)
> +{
> +=09mutex_lock(&profile_lock);
> +=09sysfs_remove_group(acpi_kobj, &platform_profile_attr_group);
> +=09cur_profile =3D NULL;
> +=09mutex_unlock(&profile_lock);
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_unregister);
> +
> +static int __init platform_profile_init(void)
> +{
> +=09cur_profile =3D NULL;

If I'm not missing anything, `cur_profile` will be initialized to NULL, thu=
s
this is not needed.


> +=09return 0;
> +}
> +
> +static void platform_profile_exit(void)

This should be marked `__exit`.


> +{
> +=09sysfs_remove_group(acpi_kobj, &platform_profile_attr_group);
> +=09cur_profile =3D NULL;
> +}
> +
> +MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
> +MODULE_LICENSE("GPL");
> +
> +module_init(platform_profile_init);
> +module_exit(platform_profile_exit);
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_pr=
ofile.h
> new file mode 100644
> index 000000000000..347a12172c09
> --- /dev/null
> +++ b/include/linux/platform_profile.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * platform_profile.h - platform profile sysfs interface
> + *
> + * See Documentation/ABI/testing/sysfs-platform_profile for more informa=
tion.
> + */
> +
> +#ifndef _PLATFORM_PROFILE_H_
> +#define _PLATFORM_PROFILE_H_
> +
> +/*
> + * If more options are added please update profile_str
> + * array in platform-profile.c
> + */
> +
> +enum profile_option {
> +=09profile_low,
> +=09profile_cool,
> +=09profile_quiet,
> +=09profile_balance,
> +=09profile_perform,
> +=09profile_unknown /* Must always be last */
> +};

Shouldn't these be prefixed by `platform_`? And I think it'd be better to h=
ave
`profile_unknown` as the first value in the enumeration.


> +
> +struct platform_profile {

Personally, I think a name like platform_profile_(handler|provider)
would be a better fit.


> +=09unsigned int choices; /* bitmap of available choices */

Most comments are capitalized.


> +=09int cur_profile;      /* Current active profile */

`cur_profile` field doesn't seem to be used here. I see that it's utilized =
in the
thinkpad_acpi driver, but I feel like this does not "belong" here.


> +=09int (*profile_get)(void);
> +=09int (*profile_set)(int profile);

Why does it take an `int` instead of `enum profile_option`?


> +};
> +
> +extern int platform_profile_register(struct platform_profile *pprof);
> +extern int platform_profile_unregister(void);
> +extern int platform_profile_notify(void);
> +

`extern` could be omitted from here. Although it seems rather "unregulated"
whether `extern` is to be present in header files or not.


> +#endif  /*_PLATFORM_PROFILE_H_*/
> --
> 2.28.0


Regards,
Barnab=C3=A1s P=C5=91cze

