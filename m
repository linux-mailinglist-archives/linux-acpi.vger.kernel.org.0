Return-Path: <linux-acpi+bounces-15293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E88B0F42A
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jul 2025 15:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B255667F1
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jul 2025 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB672E9ED5;
	Wed, 23 Jul 2025 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw3xeDyN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ECE2E9EA6;
	Wed, 23 Jul 2025 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277736; cv=none; b=AnaJ4uAl9V+RU1Yl837z5eG+JVRBHCoNXHdHI9lsUAhfhD2dnp7/OROwYYeifY8rAdK1b0FCKv/dVDOKu6TitSVfWn0D8ouYl8Dz8Jgyc3zhR7omYHWbzOlX6/jz2M91B5065gDr3OPQM72NN+20aK8b2r9LWNfVVbczGc2ZVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277736; c=relaxed/simple;
	bh=L2qZUOAPfjSFhZesNu8X11Qw8IVdgImrR2at+uKnWDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aqygs3eAJ59cfW6DTirw4QzWs1dhapNXr843ZZf0KPQtnn5Bgu/HYHJRcHkiGE7nxQ9GMLU1m7GroIoVLJGwzWCo3ppKYwsxo8kOQ2c3VMs6zafUCpssCpxAcBgngvUj20FaJnO/krCWO4yLbpxvO5vCxKLuaMVWUL/5Ey8f4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw3xeDyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E40C4CEF7;
	Wed, 23 Jul 2025 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753277736;
	bh=L2qZUOAPfjSFhZesNu8X11Qw8IVdgImrR2at+uKnWDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xw3xeDyNX0IQqb0DxOQMq2tgdzwUJv9T+vQLIpNxokYVDfA6N8g6A+KgkOPqxv/j9
	 yX9GiZzhPFR8/ennif6u0eFtYdbQ4VZElFmvnrF6ge1petYcxgEl9aj96oyyd9CdMc
	 pLIL3mAWj20+kByQZhyiX8UKoGEcfoSAL4P20VH3MZ2NNSz6Xog/W5nknIeTwqcxd6
	 O4MxCvD4Z6RWgvqIvCAFQBx97+MTrJASF/17pbN5lZke13j4sd86WmSMFM04KOyxWK
	 1E/EiGKSqMIowTX43m3f42zG2pNJAgWG77UXNjOmN4t3Dcc9ICGRjdje9IQKUWezOR
	 S9yLk2Z5rfArA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-615950642d9so3756018eaf.1;
        Wed, 23 Jul 2025 06:35:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU17ZrRuv6d19v0ocS2ddy9H+vFrDKgIZl8p3z3DOElS3yOHFQHtJROGeBB/pwzECSZQ5YVLqOC76am@vger.kernel.org, AJvYcCUuuIwXKA0vCzfs4D90lLzXhwLSYuXBtb6fTUU8i3SsaUL0dut+lUY5NLcMarMTQrN3vzi+xRO2Hhc6n5dd@vger.kernel.org
X-Gm-Message-State: AOJu0YyhbZiuFLxKv6wi3ighrcH4pXmTIzgiShEZ1xuJMH/LvDW9xhhB
	Qyq72bADnFj0x6t0BpdRPi3d0mqVDRipRJjCQhl6fV4ScEC4+FwxA88kMP1qvY/HoqTqmHXBPqC
	9CXWYH3umaeCcpmi3qAWRMSaUaHqRGEk=
X-Google-Smtp-Source: AGHT+IEAliIFzrWVAoD/qEpT2o5T1SOc2xRGy+1bTmSt/v5TXoC/zofdPln4FPx0AocBcJsMtWm9I9xSvlzxenEfQZk=
X-Received: by 2002:a05:6820:a03:b0:615:9673:ab6c with SMTP id
 006d021491bc7-6186e7b4703mr1997335eaf.1.1753277735141; Wed, 23 Jul 2025
 06:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723121034.3685996-1-lihuisong@huawei.com>
In-Reply-To: <20250723121034.3685996-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Jul 2025 15:35:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOi5kUKVWSwaPW=4Kmjkj1kj=nzaZ0jTa8fAAy32ZytA@mail.gmail.com>
X-Gm-Features: Ac12FXxOjiaUjEzPLgb4u84iD2PrGnGDKHPxD-8tosnQSTKy8kagenOxi10Qzsc
Message-ID: <CAJZ5v0gOi5kUKVWSwaPW=4Kmjkj1kj=nzaZ0jTa8fAAy32ZytA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor: idle: Fix resource leak and potential
 concurrent in acpi_processor_power_init()
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, liuyonglong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 2:10=E2=80=AFPM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> There are three kind of issues:
> 1> There are two resource leak issues in acpi_processor_power_init:
>    a> Don't unregister acpi_idle_driver when do kzalloc failed.

This is not a resource leak.  As I said before, the driver need not be
unregistered on a memory allocation failure.

>    b> Don't free cpuidle device memory when register cpuidle device faile=
d.

This is a separate minor issue that needs to be addressed by a separate pat=
ch.

> 2> There isn't lock to prevent the global acpi_processor_registered, whic=
h
>    may lead to concurrent register cpuidle driver.

That's not obvious because in principle the code in question is only
run during initialization which is serialized.

In theory, it could run in parallel CPU online, but that at least is
not default behavior AFAICS.

In any case, if you claim something like this, it is advisable to
mention a specific scenario in which the race in question can happen.

> 3> The cpuidle driver should be registered in advance when all of the CPU=
s
>    have been brought up instead of being in a CPU hotplug callback.

The "in advance" piece above is rather confusing and it can be dropped
without changing the meaning of the rest of the sentence.

> To solve these issues, so add a new function to initialize acpi_idle_driv=
er
> based on the power management information of an available CPU and registe=
r
> cpuidle driver in acpi_processor_driver_init().

I think that the main problem here is that the cpuidle driver is
registered from within a CPU hotplug callback, which is questionable
and confusing.  Usually, however, this doesn't lead to any functional
issues AFAICS.

> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  v2: register cpuidle driver in advance when all of the CPUs have been
>      brought up.
>      v1 link: https://patchwork.kernel.org/project/linux-acpi/patch/20250=
619061327.1674384-1-lihuisong@huawei.com/
> ---
>  drivers/acpi/processor_driver.c |  5 +++
>  drivers/acpi/processor_idle.c   | 71 ++++++++++++++++++++++-----------
>  include/acpi/processor.h        |  9 +++++
>  3 files changed, 62 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index 65e779be64ff..ff944c93b6ff 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -263,6 +263,10 @@ static int __init acpi_processor_driver_init(void)
>         if (result < 0)
>                 return result;
>
> +       result =3D acpi_processor_register_idle_driver();
> +       if (result)
> +               pr_info("register idle driver failed, ret =3D %d.\n", res=
ult);

This registers the cpuidle driver before registering cpuidle devices
for all CPUs.

It would be better to make acpi_processor_register_idle_driver() print
the diagnostic message on failures and then it won't need to return a
value.

Note that it may fail if intel_idle is already registered, for
example, so the message should rather be a debug-level one.

> +
>         result =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>                                    "acpi/cpu-drv:online",
>                                    acpi_soft_cpu_online, NULL);
> @@ -301,6 +305,7 @@ static void __exit acpi_processor_driver_exit(void)
>
>         cpuhp_remove_state_nocalls(hp_online);
>         cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
> +       acpi_processor_unregister_idle_driver();
>         driver_unregister(&acpi_processor_driver);
>  }
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 2c2dc559e0f8..2408f1076631 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1360,7 +1360,52 @@ int acpi_processor_power_state_has_changed(struct =
acpi_processor *pr)
>         return 0;
>  }
>
> -static int acpi_processor_registered;
> +int acpi_processor_register_idle_driver(void)
> +{
> +       struct acpi_processor *pr;
> +       int cpu;
> +       int ret;

The ret variable needs to be initialized here or tools will complain,
and so it may be initialized to -ENODEV:

int ret =3D -ENODEV;

> +
> +       /*
> +        * Acpi idle driver is used by all possible CPUs.
> +        * Install the idle handler by the processor power info of one in=
 them.
> +        * Note that we use previously set idle handler will be used on
> +        * platforms that only support C1.
> +        */
> +       for_each_cpu(cpu, (struct cpumask *)cpu_possible_mask) {
> +               pr =3D per_cpu(processors, cpu);
> +               if (pr =3D=3D NULL)

"if (!pr)" please.

> +                       continue;
> +
> +               ret =3D acpi_processor_get_power_info(pr);

if (ret)
        continue;

> +               if (!ret) {
> +                       pr->flags.power_setup_done =3D 1;

I think this is set here to prevent the subsequent
acpi_processor_setup_cpuidle_states() call from bailing out, but is
this not too early to set it?

> +                       break;
> +               }
> +       }
> +
> +       if (unlikely(!pr))
> +               return -ENODEV;

This is unnecessary if ret is initialized to -ENODEV;

> +
> +       if (ret) {
> +               pr_err("%s get power information failed.\n",
> +                      acpi_idle_driver.name);

This message is confusing at best.  It should be something like "No
ACPI power information for any CPUs" and the driver name in it has no
purpose.

> +               return ret;
> +       }
> +
> +       acpi_processor_setup_cpuidle_states(pr);

I'd call this in the loop right before breaking out of it, so the
scope of pr is clear.

> +       ret =3D cpuidle_register_driver(&acpi_idle_driver);
> +       if (ret)

Print a diagnostic message here and do not return a value (ie. make
the function void).

> +               return ret;
> +
> +       pr_debug("%s registered with cpuidle\n", acpi_idle_driver.name);
> +       return 0;
> +}
> +
> +void acpi_processor_unregister_idle_driver(void)
> +{
> +       cpuidle_unregister_driver(&acpi_idle_driver);
> +}
>
>  int acpi_processor_power_init(struct acpi_processor *pr)
>  {
> @@ -1375,22 +1420,7 @@ int acpi_processor_power_init(struct acpi_processo=
r *pr)
>         if (!acpi_processor_get_power_info(pr))
>                 pr->flags.power_setup_done =3D 1;
>
> -       /*
> -        * Install the idle handler if processor power management is supp=
orted.
> -        * Note that we use previously set idle handler will be used on
> -        * platforms that only support C1.
> -        */
>         if (pr->flags.power) {
> -               /* Register acpi_idle_driver if not already registered */
> -               if (!acpi_processor_registered) {
> -                       acpi_processor_setup_cpuidle_states(pr);
> -                       retval =3D cpuidle_register_driver(&acpi_idle_dri=
ver);
> -                       if (retval)
> -                               return retval;
> -                       pr_debug("%s registered with cpuidle\n",
> -                                acpi_idle_driver.name);
> -               }
> -
>                 dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>                 if (!dev)
>                         return -ENOMEM;
> @@ -1403,11 +1433,10 @@ int acpi_processor_power_init(struct acpi_process=
or *pr)
>                  */
>                 retval =3D cpuidle_register_device(dev);
>                 if (retval) {
> -                       if (acpi_processor_registered =3D=3D 0)
> -                               cpuidle_unregister_driver(&acpi_idle_driv=
er);
> +                       per_cpu(acpi_cpuidle_device, pr->id) =3D NULL;
> +                       kfree(dev);

These two lines should be added in a separate patch.


>                         return retval;
>                 }
> -               acpi_processor_registered++;
>         }
>         return 0;
>  }
> @@ -1421,10 +1450,6 @@ int acpi_processor_power_exit(struct acpi_processo=
r *pr)
>
>         if (pr->flags.power) {
>                 cpuidle_unregister_device(dev);
> -               acpi_processor_registered--;
> -               if (acpi_processor_registered =3D=3D 0)
> -                       cpuidle_unregister_driver(&acpi_idle_driver);
> -
>                 kfree(dev);
>         }
>
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index d0eccbd920e5..3cb41a3f2d9a 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -423,6 +423,8 @@ int acpi_processor_power_init(struct acpi_processor *=
pr);
>  int acpi_processor_power_exit(struct acpi_processor *pr);
>  int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
>  int acpi_processor_hotplug(struct acpi_processor *pr);
> +int acpi_processor_register_idle_driver(void);
> +void acpi_processor_unregister_idle_driver(void);
>  #else
>  static inline int acpi_processor_power_init(struct acpi_processor *pr)
>  {
> @@ -443,6 +445,13 @@ static inline int acpi_processor_hotplug(struct acpi=
_processor *pr)
>  {
>         return -ENODEV;
>  }
> +static int acpi_processor_register_idle_driver(void)
> +{
> +       return -ENODEV;
> +}
> +static void acpi_processor_unregister_idle_driver(void)
> +{
> +}
>  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>
>  /* in processor_thermal.c */
> --
> 2.33.0
>

