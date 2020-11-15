Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA882B37C4
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Nov 2020 19:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgKOS1G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Nov 2020 13:27:06 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:37238 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgKOS1G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2020 13:27:06 -0500
Date:   Sun, 15 Nov 2020 18:26:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605464819;
        bh=zTVFa8v4NVQO+UjzcNs56FKzJPGM0BeJ3NOCd1qiduA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=llna6zh3J5HK5eF3M6Ud7ZP21JDS99AlH7GX2RVPX2GQIxDhatUccmWbBHwlNZxy9
         D3ePW1mnzc1jxtVbXqIx5MbOvTEfiA4kzetwJleKe0+vKqe2D49b8W6xdXts2+EaDb
         d5tWTaT7QSFnQ99LQc9msGG8X1SV0hGwUh7Ph3SM=
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
Subject: Re: [PATCH v3] ACPI: platform-profile: Add platform profile support
Message-ID: <qpTm5tmuwsXyXCvmpN4vhQoKis0E5jCcILd49n6_9cqzEuN_Pd9iwMEXAFRQQmGf-rCyHe-LfhjTa15-DTTu9sFQCSQaca1KVfqYggmSGts=@protonmail.com>
In-Reply-To: <20201115004402.342838-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com> <20201115004402.342838-1-markpearson@lenovo.com>
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

I believe it would have been easier for the maintainers
if you had resent the whole series.

Another thing is that `mutex_lock_interruptible()` seems to be preferred
instead of `mutex_lock()` [1].


2020. november 15., vas=C3=A1rnap 1:44 keltez=C3=A9ssel, Mark Pearson =
=C3=ADrta:

> [...]
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index edf1558c1105..73a99af5ec2c 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -326,6 +326,20 @@ config ACPI_THERMAL
>  =09  To compile this driver as a module, choose M here:
>  =09  the module will be called thermal.
>
> +config ACPI_PLATFORM_PROFILE
> +=09tristate "ACPI Platform Profile Driver"
> +=09default y
> +=09help
> +=09  This driver adds support for platform-profiles on platforms that
> +=09  support it.
> +=09  Platform-profiles can be used to control the platform behaviour. Fo=
r
> +=09  example whether to operate in a lower power mode, in a higher
> +=09  power performance mode or between the two.
> +=09  This driver provides the sysfs interface and is used as the registr=
ation
> +=09  point for platform specific drivers.
> +=09  Which profiles are supported is determined on a per-platform basis =
and
> +=09  should be obtained from the platform specific driver.
> +
> [...]
> +config ACPI_PLATFORM_PROFILE
> +=09tristate "ACPI Platform Profile Driver"
> +=09default y
> +=09help
> +=09  This driver adds support for platform-profiles on platforms that
> +=09  support it.
> +
> +=09  Platform-profiles can be used to control the platform behaviour. Fo=
r
> +=09  example whether to operate in a lower power mode, in a higher
> +=09  power performance mode or between the two.
> +
> +=09  This driver provides the sysfs interface and is used as the registr=
ation
> +=09  point for platform specific drivers.
> +
> +=09  Which profiles are supported is determined on a per-platform basis =
and
> +=09  should be obtained from the platform specific driver.
> +
> +

Am I missing something or is the ACPI_PLATFORM_PROFILE option in the Kconfi=
g file
twice?


> [...]
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/* Platform profile sysfs interface */
> +
> +#include <linux/acpi.h>

linux/bits.h is missing, I believe the rule of thumb is that if you use
`X` and `X` is defined in `A.h`, then you should include `A.h` directly,
and not rely on the fact that another header file you use includes `A.h`.
An exception is ACPICA related things, I believe linux/acpi.h should be
preferred there.


> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_profile.h>
> +#include <linux/printk.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>

I believe there are some unnecessary header files.
(maybe fs.h, kobject.h, ...)

> +
> +static struct platform_profile_handler *cur_profile;

I think this could be `const` as well.
(along with the argument of `platform_profile_register()`)


> +static DEFINE_MUTEX(profile_lock);
> +
> +/* Ensure the first char of each profile is unique */

I think this comment is not needed anymore, no?


> [...]
> +static ssize_t platform_profile_choices_show(struct device *dev,
> +=09=09=09=09=09struct device_attribute *attr,
> +=09=09=09=09=09char *buf)
> +{
> +=09int len =3D 0;
> +=09int i;
> +
> +=09mutex_lock(&profile_lock);
> +=09if (!cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -ENODEV;
> +=09}
> +
> +=09if (!cur_profile->choices) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return sysfs_emit(buf, "\n");
> +=09}
> +
> +=09for (i =3D profile_low; i <=3D profile_perform; i++) {
> +=09=09if (cur_profile->choices & BIT(i)) {
> +=09=09=09if (len =3D=3D 0)
> +=09=09=09=09len +=3D sysfs_emit_at(buf, len, "%s",  profile_names[i]);
> +=09=09=09else
> +=09=09=09=09len +=3D sysfs_emit_at(buf, len, " %s",  profile_names[i]);
                                                                     ^^
I'm unsure why there are two spaces before `profile_names[i]` in both previ=
ous places.


> +=09=09}
> +=09}
> +=09len +=3D sysfs_emit_at(buf, len, "\n");
> +=09mutex_unlock(&profile_lock);
> +
> +=09return len;
> +}
> +
> +static ssize_t platform_profile_show(struct device *dev,
> +=09=09=09=09=09struct device_attribute *attr,
> +=09=09=09=09=09char *buf)
> +{
> +=09enum platform_profile_option profile;
> +=09int err;
> +
> +=09mutex_lock(&profile_lock);
> +=09if (!cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -EOPNOTSUPP;
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
> +=09return sysfs_emit(buf, "%s\n", profile_names[profile]);

I believe `profile` should be initialized to some value, and the value afte=
r the
call to the handler it should be checked for validity, and maybe an warning=
 should
be emitted if it's out of range - in my opinion.


> +}
> +
> +static ssize_t platform_profile_store(struct device *dev,
> +=09=09=09    struct device_attribute *attr,
> +=09=09=09    const char *buf, size_t count)
> +{
> +=09int err, i;
> +
> +=09mutex_lock(&profile_lock);
> +=09if (!cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -EOPNOTSUPP;

I'm not sure why you modified the errno. ENODEV seemed to me like a perfect=
ly
fine error to return if `cur_profile` is not set. `platform_profile_choices=
_show()`
returns ENODEV, so there is a bit of inconsistency.
(same applies to `platform_profile_show()`)


> +=09}
> +
> +=09/* Scan for a matching profile */
> +=09i =3D sysfs_match_string(profile_names, buf);
> +=09if (i < 0) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09if (!cur_profile->profile_set) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -EOPNOTSUPP;
> +=09}
> +
> +=09err =3D cur_profile->profile_set(i);
> +=09mutex_unlock(&profile_lock);
> +=09if (err)
> +=09=09return err;
> +
> +=09return count;
> +}
> [...]
> +int platform_profile_register(struct platform_profile_handler *pprof)
> +{
> +=09mutex_lock(&profile_lock);
> +=09/* We can only have one active profile */
> +=09if (cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -EEXIST;
> +=09}
> +
> +=09cur_profile =3D pprof;
> +=09mutex_unlock(&profile_lock);
> +=09return sysfs_create_group(acpi_kobj, &platform_profile_group);

I believe the return value of `sysfs_create_group()` should be checked here=
,
and `cur_profile` should only be set if that succeeds.


> +}
> +EXPORT_SYMBOL_GPL(platform_profile_register);
> [...]
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_pr=
ofile.h
> new file mode 100644
> index 000000000000..f6592434c8ce
> --- /dev/null
> +++ b/include/linux/platform_profile.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Platform profile sysfs interface
> + *
> + * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
> + * information.
> + */
> +
> +#ifndef _PLATFORM_PROFILE_H_
> +#define _PLATFORM_PROFILE_H_
> +
> +/*
> + * If more options are added please update profile_names
> + * array in platform-profile.c and sysfs-platform-profile.rst
> + * documentation.
> + */
> +
> +enum platform_profile_option {
> +=09profile_low,
> +=09profile_cool,
> +=09profile_quiet,
> +=09profile_balance,
> +=09profile_perform
                       ^
I believe there's no reason to remove the comma from there, and in fact,
having a comma after the last entry in an array, enum, etc. seems to be
the preferred.

If you don't want to go the `platform_profile_last` route that I suggested =
previously,
then I think a comment should mention that the last profile should be used
in the static_assert() in platform-profile.c.

By the way, I still feel like the enum values are "too vague" and should be
prefixed with `platform_`. If you're not opposed to that change.


> +};
> +
> +struct platform_profile_handler {
> +=09unsigned int choices; /* Bitmap of available choices */
> +=09int (*profile_get)(enum platform_profile_option *profile);
> +=09int (*profile_set)(enum platform_profile_option profile);
> +};
> +
> +int platform_profile_register(struct platform_profile_handler *pprof);
> +int platform_profile_unregister(void);
> +int platform_profile_notify(void);

I don't think it's a big problem, but right now, I personally can't quite s=
ee the
purpose `platform_profile_notify()` and `platform_profile_unregister()`
returning any value.


> +
> +#endif  /*_PLATFORM_PROFILE_H_*/
> --
> 2.25.1


[1]: https://www.kernel.org/doc/html/latest/kernel-hacking/locking.html#loc=
king-only-in-user-context


Regards,
Barnab=C3=A1s P=C5=91cze
