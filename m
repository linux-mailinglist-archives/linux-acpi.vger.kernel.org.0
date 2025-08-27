Return-Path: <linux-acpi+bounces-16112-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAE8B386D3
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874FA1C20E4A
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636612D24AB;
	Wed, 27 Aug 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOITCRqL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364331EDA1B;
	Wed, 27 Aug 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309195; cv=none; b=hXsK7F4UPVMhR8+lAzY2FmyM+6uL0I6Y3ejUMYzNgumuD/UYGO6JyA+r/COdtKwurPC8reeS+6x6bUaPDbY5q033+FZtI4EuxdwwxsBPCcbN2lPupDNa8zLlnM7QmlqLwfHaK3clv7WZOiLpG4PWOR36P53DOwZBEjEJxmsKo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309195; c=relaxed/simple;
	bh=XpL0NHYCXXMqbU685shGrpWLMglmT8uVKmdX9FpfqjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRk9QfG62BniuSA/7rLNKwXG3WnqRcUZCAF3HvRrWPY89z0pXE8ObfV5AR7/RRXGVzlHFJ0D96B21FQy275FHz+PEJkc+Bha+2JqXzGZ69ht9vaETIF/euyCLT4CzTyIJLL/A1Dc0TxpB6sfwhUnlwkUAJGbsvetsBPckG97Xnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOITCRqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB91C4CEF6;
	Wed, 27 Aug 2025 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756309195;
	bh=XpL0NHYCXXMqbU685shGrpWLMglmT8uVKmdX9FpfqjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uOITCRqLqB0xaKTbE1JSqmQw5+ZlQzWGk7FD1F9un8Wg+vtoxkSmXuzXZFo1enQwc
	 HI46wlHMzAbfo9rpFiZWrDBGpiOzrBGcO1eB5PgHqlhYwoPHV9ryQTugOKjFx2SlZ4
	 LdwEDSqNXkI0nu0yJj551EWT0iuha/wEjylxA2WWjJmwWuEUJW3UbzLS21NVNjTwUC
	 uGenVjvrvGMeJBdo8NLaHXog4Q/j5Y7tzhnu6daEXh6qfoDUmGDgm47iCryzE4Ucu1
	 +3toFxA3WEv8AZUy5jlKhBkBhXAuC9SvrJ1+n0dWoiKv6Weg4DLXBBLHXjHQ/R0UEB
	 BJG9LRlsPbvPQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61cb9f6dbe7so1319660a12.0;
        Wed, 27 Aug 2025 08:39:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxZEjMhlAupszxV5Gj63noSI51kk0H25/nFl+rpOLdzE88HpjmIe5rDSdiQNaQI3s9jFit3/s1Lhdr@vger.kernel.org, AJvYcCXqdndApDz0cmdMhTj1oygiSxEeOgKkxu5hk6Ne4f9T1W1s2nTgFo363fvzMKaPvcS/KqLsoQgi+hPEag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkQrA/xdGR7foFCaXB8Hvi9/ud4/Jlexp2jPku5t95WNRIKte
	49nQ83ir76SYiKKcVgQVFbx+38Lpx1oWR9Yw62sp6iwg9So5VMDpqMypkozeJibG8YTgyha5/Ia
	Psiv50AF53tH329dvoac45RBK0bTV6A==
X-Google-Smtp-Source: AGHT+IFmMejBfGffCeQyJtL633VAw2U+X/fFZ3ZA1T2t+CqcOQ6ngJXA0F/eCzdgXeoBI4G9bK/wW8snQe+DU0rUXPE=
X-Received: by 2002:a17:906:c155:b0:afe:be21:88d3 with SMTP id
 a640c23a62f3a-afebe21a37emr366786966b.12.1756309193292; Wed, 27 Aug 2025
 08:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822153048.2287-1-james.morse@arm.com> <20250822153048.2287-11-james.morse@arm.com>
In-Reply-To: <20250822153048.2287-11-james.morse@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 27 Aug 2025 10:39:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKUSJjmyj-E6eduZt3S=x6v7VUR5JEJV_Ow6O-O49TgEg@mail.gmail.com>
X-Gm-Features: Ac12FXyLEh6605SOQV9C3YKKBYl_B1S8918xCYKCcYduQZx7scA-BJFYxOidWQY
Message-ID: <CAL_JsqKUSJjmyj-E6eduZt3S=x6v7VUR5JEJV_Ow6O-O49TgEg@mail.gmail.com>
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
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
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:32=E2=80=AFAM James Morse <james.morse@arm.com> =
wrote:
>
> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
> only be accessible from those CPUs, and they may not be online.
> Touching the hardware early is pointless as MPAM can't be used until
> the system-wide common values for num_partid and num_pmg have been
> discovered.
>
> Start with driver probe/remove and mapping the MSC.
>
> CC: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * Check for status=3Dbroken DT devices.

No such status... 'disabled' can be for a variety of reasons.

>  * Moved all the files around.
>  * Made Kconfig symbols depend on EXPERT
> ---
>  arch/arm64/Kconfig              |   1 +
>  drivers/Kconfig                 |   2 +
>  drivers/Makefile                |   1 +
>  drivers/resctrl/Kconfig         |  11 ++
>  drivers/resctrl/Makefile        |   4 +
>  drivers/resctrl/mpam_devices.c  | 336 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h |  62 ++++++
>  7 files changed, 417 insertions(+)
>  create mode 100644 drivers/resctrl/Kconfig
>  create mode 100644 drivers/resctrl/Makefile
>  create mode 100644 drivers/resctrl/mpam_devices.c
>  create mode 100644 drivers/resctrl/mpam_internal.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e51ccf1da102..ea3c54e04275 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
>
>  config ARM64_MPAM
>         bool "Enable support for MPAM"
> +       select ARM64_MPAM_DRIVER
>         select ACPI_MPAM if ACPI
>         help
>           Memory Partitioning and Monitoring is an optional extension
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 4915a63866b0..3054b50a2f4c 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -251,4 +251,6 @@ source "drivers/hte/Kconfig"
>
>  source "drivers/cdx/Kconfig"
>
> +source "drivers/resctrl/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index b5749cf67044..f41cf4eddeba 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -194,5 +194,6 @@ obj-$(CONFIG_HTE)           +=3D hte/
>  obj-$(CONFIG_DRM_ACCEL)                +=3D accel/
>  obj-$(CONFIG_CDX_BUS)          +=3D cdx/
>  obj-$(CONFIG_DPLL)             +=3D dpll/
> +obj-y                          +=3D resctrl/
>
>  obj-$(CONFIG_S390)             +=3D s390/
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> new file mode 100644
> index 000000000000..dff7b87280ab
> --- /dev/null
> +++ b/drivers/resctrl/Kconfig
> @@ -0,0 +1,11 @@
> +# Confusingly, this is everything but the CPU bits of MPAM. CPU here mea=
ns
> +# CPU resources, not containers or cgroups etc.
> +config ARM64_MPAM_DRIVER
> +       bool "MPAM driver for System IP, e,g. caches and memory controlle=
rs"
> +       depends on ARM64_MPAM && EXPERT
> +
> +config ARM64_MPAM_DRIVER_DEBUG
> +       bool "Enable debug messages from the MPAM driver."
> +       depends on ARM64_MPAM_DRIVER
> +       help
> +         Say yes here to enable debug messages from the MPAM driver.
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> new file mode 100644
> index 000000000000..92b48fa20108
> --- /dev/null
> +++ b/drivers/resctrl/Makefile
> @@ -0,0 +1,4 @@
> +obj-$(CONFIG_ARM64_MPAM_DRIVER)                        +=3D mpam.o
> +mpam-y                                         +=3D mpam_devices.o
> +
> +cflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)       +=3D -DDEBUG
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> new file mode 100644
> index 000000000000..a0d9a699a6e7
> --- /dev/null
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.

Given the 2024 below, should this be 2024-2025?

> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/list.h>
> +#include <linux/lockdep.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/srcu.h>
> +#include <linux/types.h>
> +
> +#include <acpi/pcc.h>
> +
> +#include "mpam_internal.h"
> +
> +/*
> + * mpam_list_lock protects the SRCU lists when writing. Once the
> + * mpam_enabled key is enabled these lists are read-only,
> + * unless the error interrupt disables the driver.
> + */
> +static DEFINE_MUTEX(mpam_list_lock);
> +static LIST_HEAD(mpam_all_msc);
> +
> +static struct srcu_struct mpam_srcu;
> +
> +/* MPAM isn't available until all the MSC have been probed. */
> +static u32 mpam_num_msc;
> +
> +static void mpam_discovery_complete(void)
> +{
> +       pr_err("Discovered all MSC\n");

Perhaps print out how many MSCs.

> +}
> +
> +static int mpam_dt_count_msc(void)
> +{
> +       int count =3D 0;
> +       struct device_node *np;
> +
> +       for_each_compatible_node(np, NULL, "arm,mpam-msc") {
> +               if (of_device_is_available(np))
> +                       count++;
> +       }
> +
> +       return count;
> +}
> +
> +static int mpam_dt_parse_resource(struct mpam_msc *msc, struct device_no=
de *np,
> +                                 u32 ris_idx)
> +{
> +       int err =3D 0;
> +       u32 level =3D 0;
> +       unsigned long cache_id;
> +       struct device_node *cache;
> +
> +       do {
> +               if (of_device_is_compatible(np, "arm,mpam-cache")) {
> +                       cache =3D of_parse_phandle(np, "arm,mpam-device",=
 0);
> +                       if (!cache) {
> +                               pr_err("Failed to read phandle\n");
> +                               break;
> +                       }
> +               } else if (of_device_is_compatible(np->parent, "cache")) =
{

Don't access device_node members. I'm trying to make it opaque. And
technically it can be racy to access parent ptr when/if nodes are
dynamic. I think this should suffice:

else {
  cache =3D of_get_parent(np);
  if (!of_device_is_compatible(cache, "cache")) {
    cache =3D NULL;
    break;
  }
}

> +                       cache =3D of_node_get(np->parent);
> +               } else {
> +                       /* For now, only caches are supported */
> +                       cache =3D NULL;
> +                       break;
> +               }
> +
> +               err =3D of_property_read_u32(cache, "cache-level", &level=
);
> +               if (err) {
> +                       pr_err("Failed to read cache-level\n");
> +                       break;
> +               }
> +
> +               cache_id =3D cache_of_calculate_id(cache);
> +               if (cache_id =3D=3D ~0UL) {
> +                       err =3D -ENOENT;
> +                       break;
> +               }
> +
> +               err =3D mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE, l=
evel,
> +                                     cache_id);
> +       } while (0);
> +       of_node_put(cache);
> +
> +       return err;
> +}
> +
> +static int mpam_dt_parse_resources(struct mpam_msc *msc, void *ignored)
> +{
> +       int err, num_ris =3D 0;
> +       const u32 *ris_idx_p;
> +       struct device_node *iter, *np;
> +
> +       np =3D msc->pdev->dev.of_node;
> +       for_each_child_of_node(np, iter) {

Use for_each_available_child_of_node_scoped()

> +               ris_idx_p =3D of_get_property(iter, "reg", NULL);

This is broken on big endian and new users of of_get_property() are
discouraged. Use of_property_read_reg().

> +               if (ris_idx_p) {
> +                       num_ris++;
> +                       err =3D mpam_dt_parse_resource(msc, iter, *ris_id=
x_p);
> +                       if (err) {
> +                               of_node_put(iter);

And then drop the put.

> +                               return err;
> +                       }
> +               }
> +       }
> +
> +       if (!num_ris)
> +               mpam_dt_parse_resource(msc, np, 0);
> +
> +       return err;
> +}
> +
> +/*
> + * An MSC can control traffic from a set of CPUs, but may only be access=
ible
> + * from a (hopefully wider) set of CPUs. The common reason for this is p=
ower
> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
> + * the corresponding cache may also be powered off. By making accesses f=
rom
> + * one of those CPUs, we ensure this isn't the case.
> + */
> +static int update_msc_accessibility(struct mpam_msc *msc)
> +{
> +       struct device_node *parent;
> +       u32 affinity_id;
> +       int err;
> +
> +       if (!acpi_disabled) {
> +               err =3D device_property_read_u32(&msc->pdev->dev, "cpu_af=
finity",
> +                                              &affinity_id);
> +               if (err)
> +                       cpumask_copy(&msc->accessibility, cpu_possible_ma=
sk);
> +               else
> +                       acpi_pptt_get_cpus_from_container(affinity_id,
> +                                                         &msc->accessibi=
lity);
> +
> +               return 0;
> +       }
> +
> +       /* This depends on the path to of_node */

I'm failing to understand what has to be at the root node?

> +       parent =3D of_get_parent(msc->pdev->dev.of_node);
> +       if (parent =3D=3D of_root) {
> +               cpumask_copy(&msc->accessibility, cpu_possible_mask);
> +               err =3D 0;
> +       } else {
> +               err =3D -EINVAL;
> +               pr_err("Cannot determine accessibility of MSC: %s\n",
> +                      dev_name(&msc->pdev->dev));
> +       }
> +       of_node_put(parent);
> +
> +       return err;
> +}
> +
> +static int fw_num_msc;
> +
> +static void mpam_pcc_rx_callback(struct mbox_client *cl, void *msg)
> +{
> +       /* TODO: wake up tasks blocked on this MSC's PCC channel */
> +}
> +
> +static void mpam_msc_drv_remove(struct platform_device *pdev)
> +{
> +       struct mpam_msc *msc =3D platform_get_drvdata(pdev);
> +
> +       if (!msc)
> +               return;
> +
> +       mutex_lock(&mpam_list_lock);
> +       mpam_num_msc--;
> +       platform_set_drvdata(pdev, NULL);
> +       list_del_rcu(&msc->glbl_list);
> +       synchronize_srcu(&mpam_srcu);
> +       devm_kfree(&pdev->dev, msc);

This should happen automagically.

> +       mutex_unlock(&mpam_list_lock);
> +}
> +
> +static int mpam_msc_drv_probe(struct platform_device *pdev)
> +{
> +       int err;
> +       struct mpam_msc *msc;
> +       struct resource *msc_res;
> +       void *plat_data =3D pdev->dev.platform_data;
> +
> +       mutex_lock(&mpam_list_lock);
> +       do {
> +               msc =3D devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL=
);
> +               if (!msc) {
> +                       err =3D -ENOMEM;
> +                       break;
> +               }
> +
> +               mutex_init(&msc->probe_lock);
> +               mutex_init(&msc->part_sel_lock);
> +               mutex_init(&msc->outer_mon_sel_lock);
> +               raw_spin_lock_init(&msc->inner_mon_sel_lock);
> +               msc->id =3D mpam_num_msc++;

Multiple probe functions can run in parallel, so this needs to be
atomic. Maybe it is with mpam_list_lock, but then the name of the
mutex is misleading given this is not the list. It's not really clear
to me what all needs the mutex here. Certainly a lot of it doesn't.
Like everything else above here except the increment.

> +               msc->pdev =3D pdev;
> +               INIT_LIST_HEAD_RCU(&msc->glbl_list);
> +               INIT_LIST_HEAD_RCU(&msc->ris);
> +
> +               err =3D update_msc_accessibility(msc);
> +               if (err)
> +                       break;
> +               if (cpumask_empty(&msc->accessibility)) {
> +                       pr_err_once("msc:%u is not accessible from any CP=
U!",
> +                                   msc->id);
> +                       err =3D -EINVAL;
> +                       break;
> +               }
> +
> +               if (device_property_read_u32(&pdev->dev, "pcc-channel",

Does this property apply to DT? It would as the code is written. It is
not documented though.

> +                                            &msc->pcc_subspace_id))
> +                       msc->iface =3D MPAM_IFACE_MMIO;
> +               else
> +                       msc->iface =3D MPAM_IFACE_PCC;
> +
> +               if (msc->iface =3D=3D MPAM_IFACE_MMIO) {
> +                       void __iomem *io;
> +
> +                       io =3D devm_platform_get_and_ioremap_resource(pde=
v, 0,
> +                                                                   &msc_=
res);
> +                       if (IS_ERR(io)) {
> +                               pr_err("Failed to map MSC base address\n"=
);
> +                               err =3D PTR_ERR(io);
> +                               break;
> +                       }
> +                       msc->mapped_hwpage_sz =3D msc_res->end - msc_res-=
>start;
> +                       msc->mapped_hwpage =3D io;
> +               } else if (msc->iface =3D=3D MPAM_IFACE_PCC) {
> +                       msc->pcc_cl.dev =3D &pdev->dev;
> +                       msc->pcc_cl.rx_callback =3D mpam_pcc_rx_callback;
> +                       msc->pcc_cl.tx_block =3D false;
> +                       msc->pcc_cl.tx_tout =3D 1000; /* 1s */
> +                       msc->pcc_cl.knows_txdone =3D false;
> +
> +                       msc->pcc_chan =3D pcc_mbox_request_channel(&msc->=
pcc_cl,
> +                                                                msc->pcc=
_subspace_id);
> +                       if (IS_ERR(msc->pcc_chan)) {
> +                               pr_err("Failed to request MSC PCC channel=
\n");
> +                               err =3D PTR_ERR(msc->pcc_chan);
> +                               break;
> +                       }
> +               }
> +
> +               list_add_rcu(&msc->glbl_list, &mpam_all_msc);
> +               platform_set_drvdata(pdev, msc);
> +       } while (0);
> +       mutex_unlock(&mpam_list_lock);
> +
> +       if (!err) {
> +               /* Create RIS entries described by firmware */
> +               if (!acpi_disabled)
> +                       err =3D acpi_mpam_parse_resources(msc, plat_data)=
;
> +               else
> +                       err =3D mpam_dt_parse_resources(msc, plat_data);

Isn't there a race here if an error occurs since you already added the
MSC to the list? Something like this sequence with 2 MSCs:

device 1 probe
device 1 added
    device 2 probe
    device 2 added
device 1 calls mpam_discovery_complete()
    device 2 error on parse_resources
    device 2 removed

> +       }
> +
> +       if (!err && fw_num_msc =3D=3D mpam_num_msc)
> +               mpam_discovery_complete();
> +
> +       if (err && msc)
> +               mpam_msc_drv_remove(pdev);
> +
> +       return err;
> +}
> +
> +static const struct of_device_id mpam_of_match[] =3D {
> +       { .compatible =3D "arm,mpam-msc", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mpam_of_match);
> +
> +static struct platform_driver mpam_msc_driver =3D {
> +       .driver =3D {
> +               .name =3D "mpam_msc",
> +               .of_match_table =3D of_match_ptr(mpam_of_match),
> +       },
> +       .probe =3D mpam_msc_drv_probe,
> +       .remove =3D mpam_msc_drv_remove,
> +};
> +
> +/*
> + * MSC that are hidden under caches are not created as platform devices
> + * as there is no cache driver. Caches are also special-cased in
> + * update_msc_accessibility().
> + */
> +static void mpam_dt_create_foundling_msc(void)
> +{
> +       int err;
> +       struct device_node *cache;
> +
> +       for_each_compatible_node(cache, NULL, "cache") {
> +               err =3D of_platform_populate(cache, mpam_of_match, NULL, =
NULL);

This is going to create platform devices for all caches (except L1)
regardless of whether they support MPAM or not. Isn't it likely or
possible that only L3 or SLC caches support MPAM?

> +               if (err)
> +                       pr_err("Failed to create MSC devices under caches=
\n");
> +       }
> +}
> +
> +static int __init mpam_msc_driver_init(void)
> +{
> +       if (!system_supports_mpam())
> +               return -EOPNOTSUPP;
> +
> +       init_srcu_struct(&mpam_srcu);
> +
> +       if (!acpi_disabled)
> +               fw_num_msc =3D acpi_mpam_count_msc();
> +       else
> +               fw_num_msc =3D mpam_dt_count_msc();
> +
> +       if (fw_num_msc <=3D 0) {
> +               pr_err("No MSC devices found in firmware\n");
> +               return -EINVAL;
> +       }
> +
> +       if (acpi_disabled)
> +               mpam_dt_create_foundling_msc();
> +
> +       return platform_driver_register(&mpam_msc_driver);
> +}
> +subsys_initcall(mpam_msc_driver_init);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_inter=
nal.h
> new file mode 100644
> index 000000000000..07e0f240eaca
> --- /dev/null
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2024 Arm Ltd.

It's 2025.

> +
> +#ifndef MPAM_INTERNAL_H
> +#define MPAM_INTERNAL_H
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cpumask.h>
> +#include <linux/io.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/resctrl.h>
> +#include <linux/sizes.h>
> +
> +struct mpam_msc {
> +       /* member of mpam_all_msc */
> +       struct list_head        glbl_list;
> +
> +       int                     id;
> +       struct platform_device *pdev;
> +
> +       /* Not modified after mpam_is_enabled() becomes true */
> +       enum mpam_msc_iface     iface;
> +       u32                     pcc_subspace_id;
> +       struct mbox_client      pcc_cl;
> +       struct pcc_mbox_chan    *pcc_chan;
> +       u32                     nrdy_usec;
> +       cpumask_t               accessibility;
> +
> +       /*
> +        * probe_lock is only take during discovery. After discovery thes=
e

s/take/taken/

> +        * properties become read-only and the lists are protected by SRC=
U.
> +        */
> +       struct mutex            probe_lock;
> +       unsigned long           ris_idxs[128 / BITS_PER_LONG];
> +       u32                     ris_max;
> +
> +       /* mpam_msc_ris of this component */
> +       struct list_head        ris;
> +
> +       /*
> +        * part_sel_lock protects access to the MSC hardware registers th=
at are
> +        * affected by MPAMCFG_PART_SEL. (including the ID registers that=
 vary
> +        * by RIS).
> +        * If needed, take msc->lock first.

Stale comment? I don't see any 'lock' member.

> +        */
> +       struct mutex            part_sel_lock;
> +
> +       /*
> +        * mon_sel_lock protects access to the MSC hardware registers tha=
t are
> +        * affeted by MPAMCFG_MON_SEL.
> +        * If needed, take msc->lock first.
> +        */
> +       struct mutex            outer_mon_sel_lock;
> +       raw_spinlock_t          inner_mon_sel_lock;
> +       unsigned long           inner_mon_sel_flags;
> +
> +       void __iomem            *mapped_hwpage;
> +       size_t                  mapped_hwpage_sz;
> +};
> +
> +#endif /* MPAM_INTERNAL_H */
> --
> 2.20.1
>

