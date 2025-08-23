Return-Path: <linux-acpi+bounces-15989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123ACB32ACC
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A113B3AE0DD
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E12EA170;
	Sat, 23 Aug 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwOT3Eah"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80392E92A0;
	Sat, 23 Aug 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965638; cv=none; b=qdvNF8ZFGKjnX0udMuBwvQmsP1oFIZaz+WNf0+7zaX12nNEdEDuNUMWNQbMaJejbI5Dwi9GpCtekp30g9C9q4de3n7oLVDDZpohzqP68GrzGzyDJ6rLMmjHgfFQTY4xjeOAYLbeZ23A+iUDxP7Vuklko1b8v1ELA1NA+Q4ia+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965638; c=relaxed/simple;
	bh=XaPvEnRFO7P4KvitECQfWezTdZsWUoJ2K1hXS1ViaaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ajsv4sSZ2sbDdnBc9lKwW/SAjIoIx9yljqraVGEAakvYQkeLVnxp0QKq0h4nElEKmXCnRThnWqQ3VFzzcvTY4AA5OMumpRaDDPTWE3MWXy+pF+1PbVSIFKgdCSm3pNk7nkgMJlgitDw9m+I2FJryFaROL3HoWdVLhgN6sYODvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwOT3Eah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A3CC4CEE7;
	Sat, 23 Aug 2025 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755965637;
	bh=XaPvEnRFO7P4KvitECQfWezTdZsWUoJ2K1hXS1ViaaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mwOT3EahRhLnSDnBsMWD8EGciO+59kw6Z3vnNjDr3+IIUSCK15El8g7D9hs3utaA9
	 BjWYog1TETd4M9qD/rxV7BmE29+QjuU5maMNZ5o2mHUxTO0ikFlurKseDdN7OOcxWf
	 jO8vEoU3Tp9x0p0Fk8mVnSFKqom4IOaXGm0ZY/uZwXatlccylisBaxdmf6zirrKb96
	 umBwHhk+uHlhWc51D/vihVb5l/OQ6qmAwH0tU51fsOoa/AHR7kQ8EI5sapf2A0aAOr
	 pu4wgWutV6l5UTx2e8kvGf0SypMMhaWc002l71cJhQmWcXnfKtk92P/McZkqH+PQ0+
	 HizWK4HyDyEEQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3111c59720dso1527092fac.1;
        Sat, 23 Aug 2025 09:13:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0Jq1PiotXiA0CdR7YNJ8qpy8PEF1SDZhbIEqLsjpfNI9OnrYAspthArmVWBQ7CDu3m1EEGdFA8Rm3gddR@vger.kernel.org, AJvYcCWrZmVWKZ7IHEXylGfSF71iVdnWK2cn0vojbU+Efsvrv3AmxY4adQUSGy8DvAqvZ0/Jzm/Esa+P7Y57@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbZmxXvdhGLqJbUZokuMBGXavdlX+/XlV8myped2CjQ5+C5mo
	kdo+uGIkbNM+5DSMxI4scc9xEkQZ/cOsD2iah+KTRQf8lgdFzf8q6C2ubmFOwt3TcB3jjzWgcia
	Ktgh+wFQFjbsl30qunVX7t8hCn7RihOA=
X-Google-Smtp-Source: AGHT+IHQEQMNRFxeAFDw7ZZNHI4KcgNqKGMxdGr0V6CWZ143cN26OeQMrUwAFF3q9rtDoJ5ONnscfNKcf0YyvCNPGr4=
X-Received: by 2002:a05:6808:1925:b0:40b:999f:b2f0 with SMTP id
 5614622812f47-4378513f9bdmr2855384b6e.0.1755965636515; Sat, 23 Aug 2025
 09:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728070612.1260859-1-lihuisong@huawei.com> <20250728070612.1260859-3-lihuisong@huawei.com>
In-Reply-To: <20250728070612.1260859-3-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 23 Aug 2025 18:13:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jckgZfuh=yAqoftG1Q-1z0ngLXQa4TX-iwuy54UmWMng@mail.gmail.com>
X-Gm-Features: Ac12FXwRVEFVjYqhwBmbr-fMWP6hx7gXW6rHkFyiOf8ARTCUMeoFlL5z7tBeYq0
Message-ID: <CAJZ5v0jckgZfuh=yAqoftG1Q-1z0ngLXQa4TX-iwuy54UmWMng@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ACPI: processor: idle: Optimize acpi idle driver registration
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, liuyonglong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:06=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> Currently, the acpi idle driver is registered from within a CPU
> hotplug callback. Although this didn't cause any functional issues,
> this is questionable and confusing. And it is better to register
> the cpuidle driver when all of the CPUs have been brought up.
>
> So add a new function to initialize acpi_idle_driver based on the
> power management information of an available CPU and register cpuidle
> driver in acpi_processor_driver_init().
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_driver.c |  3 ++
>  drivers/acpi/processor_idle.c   | 65 +++++++++++++++++++++------------
>  include/acpi/processor.h        |  8 ++++
>  3 files changed, 53 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index 65e779be64ff..bc9f58a02c1d 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -263,6 +263,8 @@ static int __init acpi_processor_driver_init(void)
>         if (result < 0)
>                 return result;
>
> +       acpi_processor_register_idle_driver();
> +
>         result =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>                                    "acpi/cpu-drv:online",
>                                    acpi_soft_cpu_online, NULL);
> @@ -301,6 +303,7 @@ static void __exit acpi_processor_driver_exit(void)
>
>         cpuhp_remove_state_nocalls(hp_online);
>         cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
> +       acpi_processor_unregister_idle_driver();
>         driver_unregister(&acpi_processor_driver);
>  }
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 031738390f2d..c71802d42e8a 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1360,7 +1360,48 @@ int acpi_processor_power_state_has_changed(struct =
acpi_processor *pr)
>         return 0;
>  }
>
> -static int acpi_processor_registered;
> +void acpi_processor_register_idle_driver(void)
> +{
> +       struct acpi_processor *pr;
> +       int ret =3D -ENODEV;
> +       int cpu;
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
> +               if (!pr)
> +                       continue;
> +
> +               ret =3D acpi_processor_get_power_info(pr);
> +               if (!ret) {
> +                       pr->flags.power_setup_done =3D 1;
> +                       acpi_processor_setup_cpuidle_states(pr);
> +                       break;
> +               }
> +       }
> +
> +       if (ret) {
> +               pr_debug("No ACPI power information from any CPUs.\n");
> +               return;
> +       }
> +
> +       ret =3D cpuidle_register_driver(&acpi_idle_driver);
> +       if (ret) {
> +               pr_debug("register %s failed.\n", acpi_idle_driver.name);
> +               return;
> +       }
> +       pr_debug("%s registered with cpuidle.\n", acpi_idle_driver.name);
> +}
> +
> +void acpi_processor_unregister_idle_driver(void)
> +{
> +       cpuidle_unregister_driver(&acpi_idle_driver);
> +}
>
>  int acpi_processor_power_init(struct acpi_processor *pr)
>  {
> @@ -1375,22 +1416,7 @@ int acpi_processor_power_init(struct acpi_processo=
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
> @@ -1403,13 +1429,10 @@ int acpi_processor_power_init(struct acpi_process=
or *pr)
>                  */
>                 retval =3D cpuidle_register_device(dev);
>                 if (retval) {
> -                       if (acpi_processor_registered =3D=3D 0)
> -                               cpuidle_unregister_driver(&acpi_idle_driv=
er);
>                         kfree(dev);
>                         per_cpu(acpi_cpuidle_device, pr->id) =3D NULL;
>                         return retval;
>                 }
> -               acpi_processor_registered++;
>         }
>         return 0;
>  }
> @@ -1423,10 +1446,6 @@ int acpi_processor_power_exit(struct acpi_processo=
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
> index d0eccbd920e5..1249f5e81d92 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -423,6 +423,8 @@ int acpi_processor_power_init(struct acpi_processor *=
pr);
>  int acpi_processor_power_exit(struct acpi_processor *pr);
>  int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
>  int acpi_processor_hotplug(struct acpi_processor *pr);
> +void acpi_processor_register_idle_driver(void);
> +void acpi_processor_unregister_idle_driver(void);
>  #else
>  static inline int acpi_processor_power_init(struct acpi_processor *pr)
>  {
> @@ -443,6 +445,12 @@ static inline int acpi_processor_hotplug(struct acpi=
_processor *pr)
>  {
>         return -ENODEV;
>  }
> +static void acpi_processor_register_idle_driver(void)
> +{
> +}
> +static void acpi_processor_unregister_idle_driver(void)
> +{
> +}
>  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>
>  /* in processor_thermal.c */
> --

Applied as 6.18 material, thanks!

While at it, in the future, please always spell ACPI in capitals in
patch subjects, changelogs and code comments.

