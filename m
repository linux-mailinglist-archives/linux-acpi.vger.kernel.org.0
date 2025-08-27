Return-Path: <linux-acpi+bounces-16114-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34711B38763
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE71C1B2730B
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692F34573A;
	Wed, 27 Aug 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMC4TSSS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757E34572A;
	Wed, 27 Aug 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310905; cv=none; b=fB1oc98HL51wqGefYjJQg3mQLu9E5rfMfZy2oAHSwoLDMhhGHuzPAO5+HD52aj4hKwNAx18KZvn0ub1vwdK5nCm+4M+UFcQXBCmMlgYuRTgl+OvObrv6mLDusi7/x7oBKxPFZZZc0iNTbiFRyMNRjrIrGRho/XXTVDul1tuMXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310905; c=relaxed/simple;
	bh=sByO5WXVMLJSSxDN3MeLMu9UcOAS25+M3YCbGrOAQ5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I68V4IjogclBJLQQn6wV7AR477BLhJdd/P4M2K+M0XYRiczylj3kftbsJ5/Oxp+YHab3cuEnhdXc+o0rRF6ZRMibIVomBROtyKkSZYRJPc9ART1rJraxsC4uKgDKshdC6k6o00F2oDpKd7ZUtPugfi7FVjFslkUl34YfCnKQsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMC4TSSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1D1C4CEF7;
	Wed, 27 Aug 2025 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310905;
	bh=sByO5WXVMLJSSxDN3MeLMu9UcOAS25+M3YCbGrOAQ5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MMC4TSSSu0gXxL4Xcm7X3P68mdlGtOVNaOUXqEkqauTCJaC69a+L0bQxVQbRgtXGq
	 SkT3Gv2cksFGq/iw94AvcaWLpUkzhvcRSO98cLdogA9MEk9XrrrxUAu6EvNUWbM1H8
	 O2VsF5b44CPXlCRl+ByGwtG74gLqzixxneUbLtsiUlzsE6vLd3T2touX3/CnRUuzfw
	 hIsqZB4PBosbJ2oU9rQr1s6rJrJBpSRO5crWqj6pSKiCh2C3FXMCrSMnm0odlb9hDF
	 RsvTboBtoaKObT9D3An99UG9ksxMKJX+z5swvRAFAwYI/unEmKwDJK9tN+ega/V47n
	 zwMnGXkDh6scw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cb9e039d9so1475993a12.1;
        Wed, 27 Aug 2025 09:08:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWXN8OglpcI3mhroJN2H6qprKD0dQhUAYDkwZFvLPlskyInGISXsAUCrqt/H9u/rtM8HTZEM0Otpj7CA==@vger.kernel.org, AJvYcCWYDFwitoRObOxg3zYTfE70xuoVEMTpoB438MuotkY95J61Gebj0BAzHXD0vYrsPCgeP4Lkhpy3eVKD@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxSTfKblUbEbwTc5EIXcv93OUH6IcyzBaJwqVvADG7YPZy1/+
	daGmL7Dc05MvLuwb5tbzgLPVvY55xl2/RX8ojYmpQcOnC21xkxLSIwHB8uHVEFpHm7dzcO+3PpI
	3ry9gqfSHKhsTHuuq5oiEebo11KR6ow==
X-Google-Smtp-Source: AGHT+IFqv6Ng7UWtLQz1bQpYXPMLfkZ5AljMlpdSdbuChrj1GMfasDer/vKIdWdJCxDi5ORdTh7uVMDCQ1ElScMXa1s=
X-Received: by 2002:a05:6402:27cc:b0:61c:91c1:37e2 with SMTP id
 4fb4d7f45d1cf-61c91c13befmr5963193a12.16.1756310903622; Wed, 27 Aug 2025
 09:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822153048.2287-1-james.morse@arm.com> <20250822153048.2287-15-james.morse@arm.com>
In-Reply-To: <20250822153048.2287-15-james.morse@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 27 Aug 2025 11:08:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK5HZdyq_6rQibtmDE_H=gy+3aeCSCioA5MHR5+Gh_drQ@mail.gmail.com>
X-Gm-Features: Ac12FXwmDxRL-eFGpQpbfwfUyBdCUvSfzx1ak3V0nyRWrqa9LPLYA6NMV2maEUo
Message-ID: <CAL_JsqK5HZdyq_6rQibtmDE_H=gy+3aeCSCioA5MHR5+Gh_drQ@mail.gmail.com>
Subject: Re: [PATCH 14/33] arm_mpam: Add cpuhp callbacks to probe MSC hardware
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	shameerali.kolothum.thodi@huawei.com, 
	D Scott Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com, 
	lcherian@marvell.com, bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com, 
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, 
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com, dfustini@baylibre.com, 
	amitsinght@marvell.com, David Hildenbrand <david@redhat.com>, 
	Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, 
	Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com, 
	baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lecopzer Chen <lecopzerc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:32=E2=80=AFAM James Morse <james.morse@arm.com> =
wrote:
>
> Because an MSC can only by accessed from the CPUs in its cpu-affinity
> set we need to be running on one of those CPUs to probe the MSC
> hardware.
>
> Do this work in the cpuhp callback. Probing the hardware will only
> happen before MPAM is enabled, walk all the MSCs and probe those we can
> reach that haven't already been probed.
>
> Later once MPAM is enabled, this cpuhp callback will be replaced by
> one that avoids the global list.
>
> Enabling a static key will also take the cpuhp lock, so can't be done
> from the cpuhp callback. Whenever a new MSC has been probed schedule
> work to test if all the MSCs have now been probed.
>
> CC: Lecopzer Chen <lecopzerc@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c  | 144 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |   8 +-
>  2 files changed, 147 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> index 5baf2a8786fb..9d6516f98acf 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -4,6 +4,7 @@
>  #define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
>
>  #include <linux/acpi.h>
> +#include <linux/atomic.h>
>  #include <linux/arm_mpam.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpu.h>
> @@ -21,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> +#include <linux/workqueue.h>
>
>  #include <acpi/pcc.h>
>
> @@ -39,6 +41,16 @@ struct srcu_struct mpam_srcu;
>  /* MPAM isn't available until all the MSC have been probed. */
>  static u32 mpam_num_msc;
>
> +static int mpam_cpuhp_state;
> +static DEFINE_MUTEX(mpam_cpuhp_state_lock);
> +
> +/*
> + * mpam is enabled once all devices have been probed from CPU online cal=
lbacks,
> + * scheduled via this work_struct. If access to an MSC depends on a CPU =
that
> + * was not brought online at boot, this can happen surprisingly late.
> + */
> +static DECLARE_WORK(mpam_enable_work, &mpam_enable);
> +
>  /*
>   * An MSC is a physical container for controls and monitors, each identi=
fied by
>   * their RIS index. These share a base-address, interrupts and some MMIO
> @@ -78,6 +90,22 @@ LIST_HEAD(mpam_classes);
>  /* List of all objects that can be free()d after synchronise_srcu() */
>  static LLIST_HEAD(mpam_garbage);
>
> +static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
> +{
> +       WARN_ON_ONCE(reg > msc->mapped_hwpage_sz);
> +       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessib=
ility));

These either make __mpam_read_reg uninlined or add 2 checks to every
register read. Neither seems very good.

> +
> +       return readl_relaxed(msc->mapped_hwpage + reg);
> +}
> +
> +static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
> +{
> +       lockdep_assert_held_once(&msc->part_sel_lock);

Similar thing here.

> +       return __mpam_read_reg(msc, reg);
> +}
> +
> +#define mpam_read_partsel_reg(msc, reg)        _mpam_read_partsel_reg(ms=
c, MPAMF_##reg)
> +
>  #define init_garbage(x)        init_llist_node(&(x)->garbage.llist)
>
>  static struct mpam_vmsc *
> @@ -511,9 +539,84 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx=
,
>         return err;
>  }
>
> -static void mpam_discovery_complete(void)

It is annoying to review things which disappear in later patches...


> +static int mpam_msc_hw_probe(struct mpam_msc *msc)
> +{
> +       u64 idr;
> +       int err;
> +
> +       lockdep_assert_held(&msc->probe_lock);
> +
> +       mutex_lock(&msc->part_sel_lock);
> +       idr =3D mpam_read_partsel_reg(msc, AIDR);

I don't think AIDR access depends on PART_SEL.

> +       if ((idr & MPAMF_AIDR_ARCH_MAJOR_REV) !=3D MPAM_ARCHITECTURE_V1) =
{
> +               pr_err_once("%s does not match MPAM architecture v1.x\n",
> +                           dev_name(&msc->pdev->dev));
> +               err =3D -EIO;
> +       } else {
> +               msc->probed =3D true;
> +               err =3D 0;
> +       }
> +       mutex_unlock(&msc->part_sel_lock);
> +
> +       return err;
> +}
> +
> +static int mpam_cpu_online(unsigned int cpu)
>  {
> -       pr_err("Discovered all MSC\n");
> +       return 0;
> +}
> +
> +/* Before mpam is enabled, try to probe new MSC */
> +static int mpam_discovery_cpu_online(unsigned int cpu)
> +{
> +       int err =3D 0;
> +       struct mpam_msc *msc;
> +       bool new_device_probed =3D false;
> +
> +       mutex_lock(&mpam_list_lock);
> +       list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
> +               if (!cpumask_test_cpu(cpu, &msc->accessibility))
> +                       continue;
> +
> +               mutex_lock(&msc->probe_lock);
> +               if (!msc->probed)
> +                       err =3D mpam_msc_hw_probe(msc);
> +               mutex_unlock(&msc->probe_lock);
> +
> +               if (!err)
> +                       new_device_probed =3D true;
> +               else
> +                       break; // mpam_broken
> +       }
> +       mutex_unlock(&mpam_list_lock);
> +
> +       if (new_device_probed && !err)
> +               schedule_work(&mpam_enable_work);
> +
> +       return err;
> +}
> +
> +static int mpam_cpu_offline(unsigned int cpu)
> +{
> +       return 0;
> +}
> +
> +static void mpam_register_cpuhp_callbacks(int (*online)(unsigned int onl=
ine),
> +                                         int (*offline)(unsigned int off=
line))
> +{
> +       mutex_lock(&mpam_cpuhp_state_lock);
> +       if (mpam_cpuhp_state) {
> +               cpuhp_remove_state(mpam_cpuhp_state);
> +               mpam_cpuhp_state =3D 0;
> +       }
> +
> +       mpam_cpuhp_state =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mpam=
:online",
> +                                            online, offline);
> +       if (mpam_cpuhp_state <=3D 0) {
> +               pr_err("Failed to register cpuhp callbacks");
> +               mpam_cpuhp_state =3D 0;
> +       }
> +       mutex_unlock(&mpam_cpuhp_state_lock);
>  }
>
>  static int mpam_dt_count_msc(void)
> @@ -772,7 +875,7 @@ static int mpam_msc_drv_probe(struct platform_device =
*pdev)
>         }
>
>         if (!err && fw_num_msc =3D=3D mpam_num_msc)
> -               mpam_discovery_complete();
> +               mpam_register_cpuhp_callbacks(&mpam_discovery_cpu_online,=
 NULL);
>
>         if (err && msc)
>                 mpam_msc_drv_remove(pdev);
> @@ -795,6 +898,41 @@ static struct platform_driver mpam_msc_driver =3D {
>         .remove =3D mpam_msc_drv_remove,
>  };
>
> +static void mpam_enable_once(void)
> +{
> +       mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
> +
> +       pr_info("MPAM enabled\n");
> +}
> +
> +/*
> + * Enable mpam once all devices have been probed.
> + * Scheduled by mpam_discovery_cpu_online() once all devices have been c=
reated.
> + * Also scheduled when new devices are probed when new CPUs come online.
> + */
> +void mpam_enable(struct work_struct *work)
> +{
> +       static atomic_t once;
> +       struct mpam_msc *msc;
> +       bool all_devices_probed =3D true;
> +
> +       /* Have we probed all the hw devices? */
> +       mutex_lock(&mpam_list_lock);
> +       list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
> +               mutex_lock(&msc->probe_lock);
> +               if (!msc->probed)
> +                       all_devices_probed =3D false;
> +               mutex_unlock(&msc->probe_lock);
> +
> +               if (!all_devices_probed)
> +                       break;
> +       }
> +       mutex_unlock(&mpam_list_lock);
> +
> +       if (all_devices_probed && !atomic_fetch_inc(&once))
> +               mpam_enable_once();
> +}
> +
>  /*
>   * MSC that are hidden under caches are not created as platform devices
>   * as there is no cache driver. Caches are also special-cased in
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_inter=
nal.h
> index 6e0982a1a9ac..a98cca08a2ef 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -49,6 +49,7 @@ struct mpam_msc {
>          * properties become read-only and the lists are protected by SRC=
U.
>          */
>         struct mutex            probe_lock;
> +       bool                    probed;
>         unsigned long           ris_idxs[128 / BITS_PER_LONG];
>         u32                     ris_max;
>
> @@ -59,14 +60,14 @@ struct mpam_msc {
>          * part_sel_lock protects access to the MSC hardware registers th=
at are
>          * affected by MPAMCFG_PART_SEL. (including the ID registers that=
 vary
>          * by RIS).
> -        * If needed, take msc->lock first.
> +        * If needed, take msc->probe_lock first.

Humm. I think this belongs in patch 10.

>          */
>         struct mutex            part_sel_lock;
>
>         /*
>          * mon_sel_lock protects access to the MSC hardware registers tha=
t are
>          * affeted by MPAMCFG_MON_SEL.
> -        * If needed, take msc->lock first.
> +        * If needed, take msc->probe_lock first.
>          */
>         struct mutex            outer_mon_sel_lock;
>         raw_spinlock_t          inner_mon_sel_lock;
> @@ -147,6 +148,9 @@ struct mpam_msc_ris {
>  extern struct srcu_struct mpam_srcu;
>  extern struct list_head mpam_classes;
>
> +/* Scheduled work callback to enable mpam once all MSC have been probed =
*/
> +void mpam_enable(struct work_struct *work);
> +
>  int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_lev=
el,
>                                    cpumask_t *affinity);
>
> --
> 2.20.1
>

