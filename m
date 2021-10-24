Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31993438936
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Oct 2021 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJXNnA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 24 Oct 2021 09:43:00 -0400
Received: from mail-4316.protonmail.ch ([185.70.43.16]:30783 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhJXNnA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Oct 2021 09:43:00 -0400
Date:   Sun, 24 Oct 2021 13:40:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1635082838;
        bh=qU5MGAqRjLFdZ0m8iDiY8gSYAzvuW9aHRuHMQqBZbGU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=rh+iIuZ4kVpFeKPFr6zV4cTizoSX+Nmj0n2gmYT+zXSTlpNsX5mVHiZo2r0B1DH83
         BNCYV7m6eWueMaaX+nDMVhI/M9RuTLTCZQhH+XPpuboKi0T90x0eCWdpxB081iXDtd
         lTzednSQ4+lBJbop4frlXYo7uaxFRI7Bhf4ucABs=
To:     Mario Limonciello <mario.limonciello@amd.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, markpearson@lenovo.com
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] ACPI: platform_profile: Add support for notification chains
Message-ID: <wH_kPWXl4frtlsEIPSKi7RJwuVoW30nN7WOJhjdV2J91_My1No4OFsCQvoyoJ9hz95IhQ4g7hsTWVL-nn4lNA81ccb8WTqn-2BPPjiEvHzU=@protonmail.com>
In-Reply-To: <20211022181608.3121-1-mario.limonciello@amd.com>
References: <20211022181608.3121-1-mario.limonciello@amd.com>
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


Am I right in thinking that this adds functionality that has no users in th=
e
kernel at the moment?


2021. okt=C3=B3ber 22., p=C3=A9ntek 20:16 keltez=C3=A9ssel, Mario Limonciel=
lo =C3=ADrta:

> Allow other drivers to react to determine current active profile
> and react to platform profile changes.
>
> Drivers wishing to utilize this should register for notification
> at module load and unregister when unloading.
>
> Notifications will come in the form of a notifier call.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c  | 44 +++++++++++++++++++++++++++-----
>  include/linux/platform_profile.h | 11 ++++++++
>  2 files changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index dd2fbf38e414..964e0c9bf70d 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -21,6 +21,25 @@ static const char * const profile_names[] =3D {
>  =09[PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
>  };
>  static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
> +static BLOCKING_NOTIFIER_HEAD(platform_profile_chain_head);
> +
> +int platform_profile_register_notifier(struct notifier_block *nb)
> +{
> +=09return blocking_notifier_chain_register(&platform_profile_chain_head,=
 nb);
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_register_notifier);
> +
> +int platform_profile_unregister_notifier(struct notifier_block *nb)
> +{
> +=09return blocking_notifier_chain_unregister(&platform_profile_chain_hea=
d, nb);
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_unregister_notifier);
> +
> +void platform_profile_call_notifier(unsigned long action, void *data)
> +{
> +=09blocking_notifier_call_chain(&platform_profile_chain_head, action, da=
ta);
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_call_notifier);

What is the reason for exporting this function?


>
>  static ssize_t platform_profile_choices_show(struct device *dev,
>  =09=09=09=09=09struct device_attribute *attr,
> @@ -49,11 +68,8 @@ static ssize_t platform_profile_choices_show(struct de=
vice *dev,
>  =09return len;
>  }
>
> -static ssize_t platform_profile_show(struct device *dev,
> -=09=09=09=09=09struct device_attribute *attr,
> -=09=09=09=09=09char *buf)
> +int platform_profile_get(enum platform_profile_option *profile)
>  {
> -=09enum platform_profile_option profile =3D PLATFORM_PROFILE_BALANCED;
>  =09int err;
>
>  =09err =3D mutex_lock_interruptible(&profile_lock);
> @@ -65,15 +81,28 @@ static ssize_t platform_profile_show(struct device *d=
ev,
>  =09=09return -ENODEV;
>  =09}
>
> -=09err =3D cur_profile->profile_get(cur_profile, &profile);
> +=09err =3D cur_profile->profile_get(cur_profile, profile);
>  =09mutex_unlock(&profile_lock);
>  =09if (err)
>  =09=09return err;
>
>  =09/* Check that profile is valid index */
> -=09if (WARN_ON((profile < 0) || (profile >=3D ARRAY_SIZE(profile_names))=
))
> +=09if (WARN_ON((*profile < 0) || (*profile >=3D ARRAY_SIZE(profile_names=
))))
>  =09=09return -EIO;
>
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_get);
> +
> +static ssize_t platform_profile_show(struct device *dev,
> +=09=09=09=09=09struct device_attribute *attr,
> +=09=09=09=09=09char *buf)
> +{
> +=09enum platform_profile_option profile =3D PLATFORM_PROFILE_BALANCED;
> +=09int ret =3D platform_profile_get(&profile);
> +
> +=09if (ret)
> +=09=09return ret;
>  =09return sysfs_emit(buf, "%s\n", profile_names[profile]);
>  }
>
> @@ -130,9 +159,12 @@ void platform_profile_notify(void)
>  =09if (!cur_profile)
>  =09=09return;
>  =09sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +=09platform_profile_call_notifier(PLATFORM_PROFILE_CHANGED, NULL);
> +
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_notify);
>
> +
>  int platform_profile_register(struct platform_profile_handler *pprof)
>  {
>  =09int err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_pr=
ofile.h
> index e5cbb6841f3a..390d95d47e07 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -11,6 +11,8 @@
>
>  #include <linux/bitops.h>
>
> +struct notifier_block;
> +
>  /*
>   * If more options are added please update profile_names array in
>   * platform_profile.c and sysfs-platform_profile documentation.
> @@ -37,5 +39,14 @@ struct platform_profile_handler {
>  int platform_profile_register(struct platform_profile_handler *pprof);
>  int platform_profile_remove(void);
>  void platform_profile_notify(void);
> +int platform_profile_get(enum platform_profile_option *profile);
> +
> +int platform_profile_register_notifier(struct notifier_block *nb);
> +int platform_profile_unregister_notifier(struct notifier_block *nb);
> +void platform_profile_call_notifier(unsigned long action, void *data);
> +
> +enum platform_profile_notifier_actions {
> +=09PLATFORM_PROFILE_CHANGED,
> +};
>
>  #endif  /*_PLATFORM_PROFILE_H_*/
> --
> 2.25.1


Regards,
Barnab=C3=A1s P=C5=91cze
