Return-Path: <linux-acpi+bounces-4358-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E187F0FD
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Mar 2024 21:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862101F23FEB
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Mar 2024 20:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4643857870;
	Mon, 18 Mar 2024 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eAWsAA/U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938456B6E
	for <linux-acpi@vger.kernel.org>; Mon, 18 Mar 2024 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792793; cv=none; b=L5X323QxNkr5NPb0rVxHxB/tGoAJezj4AL5A/Lig4fvdKPiJBhv3s72yGBlXpgDJcq5fV3xH4Mz9eszUKAkjMrcTi9MmJBc9zYdBmpxDphqZGAe5/OGkx6HDQT/3aMNf6FjUJSMGwFTFJ/+y+wMAjGUSOlpdVL9VEmJIoglsezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792793; c=relaxed/simple;
	bh=ufvZzDemArw/XUVPS+u3xEmL3PjgXjFHfxClTIsS/jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HumntntLNFebwosoYk+aQvWAUIVedVhtoSYDYjB3TO/ekMUnHb1g3xaGNg4KsCm38k6BRnsIBazwHgUtQUDU7THZtZ4NQhh3snS8Az8NDNRRwk8mlnq4KGfC/yqjlGqX8sqzIUkcVsbV6GYL8/crD1zmu4gPKypI9I9VMoLeP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eAWsAA/U; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso3931572276.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Mar 2024 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710792789; x=1711397589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GmiV5M2hXSbQEKR31mdypKhoX7dIAGE7+RzEV5WkEY=;
        b=eAWsAA/UIIllUecMgCnhzrdWw6zZmL++Um6fWuyMR9qGueD/zq7y2kurzV7VRttX0r
         fAc0Ro4zxULYetwktSlWiIclZEhpF+19UUXjP4Dhv6FxFxx3YXtQZQ+mNQfE0jfULdg8
         ObMbrwB95tYc87IEYW42X5c3GayFDUCSMXtUoq/eMLPmD5uAL0q1ddzZJPBy2k/sO/f/
         S237WZCoLfMO5FPxGUZORe3tgO9hVHayXBdX3NMDyRAeWM6kd8LLfzCOREP5TQe2kz2Q
         5AebgZhAKIQM8GKdC001OXMXJ/svfWARBDcdWW5ufGJsuoMuk4gb3wfdUOJ3MnES/O36
         lZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792789; x=1711397589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GmiV5M2hXSbQEKR31mdypKhoX7dIAGE7+RzEV5WkEY=;
        b=XDR6JXJ8bbXzQAvnk1934WFnovBhslgy9AU7JMnVnBj48VJ2aHuRhbJlouR9hPmnBa
         nw6pQvdcZ2tWdqYOMiYEav6eJhTe01Omf8/dqDq0+B8oF38HSBXePYLo3TPjnk0RMTtO
         YYEwCrNsucZRkYFuudFMBFuiJ7MaZXJ8XsdXzE0ZkEgFvF3GeAZMhFVgl8telXCIlY+e
         Grhu8X+WMO1PKL8vUlotrfmSExHZDstT5f8aiLGcyRJGULbHhynjJRvoNt617fJgpV/t
         GDEYLAedry259YQBSmWFmNnPfjRTEeSGs5bmHFZlgUfsR+r3230WkIZYbhwnAHkh3bgv
         fa2w==
X-Forwarded-Encrypted: i=1; AJvYcCUsgowijYmY0jh5C6a1w08D5jQOaE/dQfLHeJ0xxJEXVI5ny5htk+0MJ1yJ4jhTGxzrY6UnNbirXbhiIvl/TQVnFdIBGz8+roeFtg==
X-Gm-Message-State: AOJu0Yyn4Ewo/DuieChj+LrrwGJiGXBOs2zLYrgyom6GpyAuJ7j23Jgo
	mn/KilJWKDPJ97j+Rp8zityucqxg0L2ZEnYeNJ+xcNxGds9cEjxV6AAtUrvOz/HWm5n/SnNqHmD
	W/nNRn4PqxogD5u+pPWn6WLYuphN2MU/8v+mWBZsUJocRrvplkWI=
X-Google-Smtp-Source: AGHT+IFETTrBJ77lnga2XTx8H37L+r3SUM9K/oqa4D1IjsNxvnj1s00F9NGDxpflePP6ZXGG+xUJkzolNGOfV0V/g0A=
X-Received: by 2002:a05:6902:2191:b0:dcf:2697:5ca3 with SMTP id
 dl17-20020a056902219100b00dcf26975ca3mr607819ybb.5.1710792789278; Mon, 18 Mar
 2024 13:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312061729.1997111-1-horenchuang@bytedance.com>
 <20240312061729.1997111-2-horenchuang@bytedance.com> <874jdb4xk8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAKPbEqpTNN5GKKCXmyTv0szpL-N1pdKFZYPHCJjyhgpKZGMiWw@mail.gmail.com> <8734st2qu0.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734st2qu0.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 18 Mar 2024 13:12:58 -0700
Message-ID: <CAKPbEqophdVjDfzLOCSbKYKOLsvPr1Eyiy6U9XuTZwxjoEUTTw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/1] memory tier: acpi/hmat: create
 CPUless memory tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com, 
	tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
	Hao Xiang <hao.xiang@bytedance.com>, sthanneeru@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm working on V3. Thanks for Ying's feedback.

cc: sthanneeru@micron.com


On Thu, Mar 14, 2024 at 12:54=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > On Tue, Mar 12, 2024 at 2:21=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
> >>
> >> > The current implementation treats emulated memory devices, such as
> >> > CXL1.1 type3 memory, as normal DRAM when they are emulated as normal=
 memory
> >> > (E820_TYPE_RAM). However, these emulated devices have different
> >> > characteristics than traditional DRAM, making it important to
> >> > distinguish them. Thus, we modify the tiered memory initialization p=
rocess
> >> > to introduce a delay specifically for CPUless NUMA nodes. This delay
> >> > ensures that the memory tier initialization for these nodes is defer=
red
> >> > until HMAT information is obtained during the boot process. Finally,
> >> > demotion tables are recalculated at the end.
> >> >
> >> > * Abstract common functions into `find_alloc_memory_type()`
> >>
> >> We should move kmem_put_memory_types() (renamed to
> >> mt_put_memory_types()?) too.  This can be put in a separate patch.
> >>
> >
> > Will do! Thanks,
> >
> >
> >>
> >> > Since different memory devices require finding or allocating a memor=
y type,
> >> > these common steps are abstracted into a single function,
> >> > `find_alloc_memory_type()`, enhancing code scalability and concisene=
ss.
> >> >
> >> > * Handle cases where there is no HMAT when creating memory tiers
> >> > There is a scenario where a CPUless node does not provide HMAT infor=
mation.
> >> > If no HMAT is specified, it falls back to using the default DRAM tie=
r.
> >> >
> >> > * Change adist calculation code to use another new lock, mt_perf_loc=
k.
> >> > In the current implementation, iterating through CPUlist nodes requi=
res
> >> > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will =
end up
> >> > trying to acquire the same lock, leading to a potential deadlock.
> >> > Therefore, we propose introducing a standalone `mt_perf_lock` to pro=
tect
> >> > `default_dram_perf`. This approach not only avoids deadlock but also
> >> > prevents holding a large lock simultaneously.
> >> >
> >> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> >> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >> > ---
> >> >  drivers/acpi/numa/hmat.c     | 11 ++++++
> >> >  drivers/dax/kmem.c           | 13 +------
> >> >  include/linux/acpi.h         |  6 ++++
> >> >  include/linux/memory-tiers.h |  8 +++++
> >> >  mm/memory-tiers.c            | 70 +++++++++++++++++++++++++++++++++=
---
> >> >  5 files changed, 92 insertions(+), 16 deletions(-)
> >> >
> >> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> >> > index d6b85f0f6082..28812ec2c793 100644
> >> > --- a/drivers/acpi/numa/hmat.c
> >> > +++ b/drivers/acpi/numa/hmat.c
> >> > @@ -38,6 +38,8 @@ static LIST_HEAD(targets);
> >> >  static LIST_HEAD(initiators);
> >> >  static LIST_HEAD(localities);
> >> >
> >> > +static LIST_HEAD(hmat_memory_types);
> >> > +
> >>
> >> HMAT isn't a device driver for some memory devices.  So I don't think =
we
> >> should manage memory types in HMAT.
> >
> > I can put it back in memory-tier.c. How about the list? Do we still
> > need to keep a separate list for storing late_inited memory nodes?
> > And how about the list name if we need to remove the prefix "hmat_"?
>
> I don't think we need a separate list for memory-less nodes.  Just
> iterate all memory-less nodes.
>

Ok. There is no need to keep a list of memory-less nodes. I will
only keep a memory_type list to manage created memory types.


> >
> >> Instead, if the memory_type of a
> >> node isn't set by the driver, we should manage it in memory-tier.c as
> >> fallback.
> >>
> >
> > Do you mean some device drivers may init memory tiers between
> > memory_tier_init() and late_initcall(memory_tier_late_init);?
> > And this is the reason why you mention to exclude
> > "node_memory_types[nid].memtype !=3D NULL" in memory_tier_late_init().
> > Is my understanding correct?
>
> Yes.
>

Thanks.

> >> >  static DEFINE_MUTEX(target_lock);
> >> >
> >> >  /*
> >> > @@ -149,6 +151,12 @@ int acpi_get_genport_coordinates(u32 uid,
> >> >  }
> >> >  EXPORT_SYMBOL_NS_GPL(acpi_get_genport_coordinates, CXL);
> >> >
> >> > +struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
> >> > +{
> >> > +     return find_alloc_memory_type(adist, &hmat_memory_types);
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(hmat_find_alloc_memory_type);
> >> > +
> >> >  static __init void alloc_memory_initiator(unsigned int cpu_pxm)
> >> >  {
> >> >       struct memory_initiator *initiator;
> >> > @@ -1038,6 +1046,9 @@ static __init int hmat_init(void)
> >> >       if (!hmat_set_default_dram_perf())
> >> >               register_mt_adistance_algorithm(&hmat_adist_nb);
> >> >
> >> > +     /* Post-create CPUless memory tiers after getting HMAT info */
> >> > +     memory_tier_late_init();
> >> > +
> >>
> >> This should be called in memory-tier.c via
> >>
> >> late_initcall(memory_tier_late_init);
> >>
> >> Then, we don't need hmat to call it.
> >>
> >
> > Thanks. Learned!
> >
> >
> >> >       return 0;
> >> >  out_put:
> >> >       hmat_free_structures();
> >> > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> >> > index 42ee360cf4e3..aee17ab59f4f 100644
> >> > --- a/drivers/dax/kmem.c
> >> > +++ b/drivers/dax/kmem.c
> >> > @@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
> >> >
> >> >  static struct memory_dev_type *kmem_find_alloc_memory_type(int adis=
t)
> >> >  {
> >> > -     bool found =3D false;
> >> >       struct memory_dev_type *mtype;
> >> >
> >> >       mutex_lock(&kmem_memory_type_lock);
> >> > -     list_for_each_entry(mtype, &kmem_memory_types, list) {
> >> > -             if (mtype->adistance =3D=3D adist) {
> >> > -                     found =3D true;
> >> > -                     break;
> >> > -             }
> >> > -     }
> >> > -     if (!found) {
> >> > -             mtype =3D alloc_memory_type(adist);
> >> > -             if (!IS_ERR(mtype))
> >> > -                     list_add(&mtype->list, &kmem_memory_types);
> >> > -     }
> >> > +     mtype =3D find_alloc_memory_type(adist, &kmem_memory_types);
> >> >       mutex_unlock(&kmem_memory_type_lock);
> >> >
> >> >       return mtype;
> >> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> >> > index b7165e52b3c6..3f927ff01f02 100644
> >> > --- a/include/linux/acpi.h
> >> > +++ b/include/linux/acpi.h
> >> > @@ -434,12 +434,18 @@ int thermal_acpi_critical_trip_temp(struct acp=
i_device *adev, int *ret_temp);
> >> >
> >> >  #ifdef CONFIG_ACPI_HMAT
> >> >  int acpi_get_genport_coordinates(u32 uid, struct access_coordinate =
*coord);
> >> > +struct memory_dev_type *hmat_find_alloc_memory_type(int adist);
> >> >  #else
> >> >  static inline int acpi_get_genport_coordinates(u32 uid,
> >> >                                              struct access_coordinat=
e *coord)
> >> >  {
> >> >       return -EOPNOTSUPP;
> >> >  }
> >> > +
> >> > +static inline struct memory_dev_type *hmat_find_alloc_memory_type(i=
nt adist)
> >> > +{
> >> > +     return NULL;
> >> > +}
> >> >  #endif
> >> >
> >> >  #ifdef CONFIG_ACPI_NUMA
> >> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tie=
rs.h
> >> > index 69e781900082..4bc2596c5774 100644
> >> > --- a/include/linux/memory-tiers.h
> >> > +++ b/include/linux/memory-tiers.h
> >> > @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
> >> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *per=
f,
> >> >                            const char *source);
> >> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist=
);
> >> > +struct memory_dev_type *find_alloc_memory_type(int adist,
> >> > +                                                     struct list_he=
ad *memory_types);
> >> > +void memory_tier_late_init(void);
> >> >  #ifdef CONFIG_MIGRATION
> >> >  int next_demotion_node(int node);
> >> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets=
);
> >> > @@ -136,5 +139,10 @@ static inline int mt_perf_to_adistance(struct a=
ccess_coordinate *perf, int *adis
> >> >  {
> >> >       return -EIO;
> >> >  }
> >> > +
> >> > +static inline void memory_tier_late_init(void)
> >> > +{
> >> > +
> >> > +}
> >> >  #endif       /* CONFIG_NUMA */
> >> >  #endif  /* _LINUX_MEMORY_TIERS_H */
> >> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> >> > index 0537664620e5..79f748d60e6f 100644
> >> > --- a/mm/memory-tiers.c
> >> > +++ b/mm/memory-tiers.c
> >> > @@ -6,6 +6,7 @@
> >> >  #include <linux/memory.h>
> >> >  #include <linux/memory-tiers.h>
> >> >  #include <linux/notifier.h>
> >> > +#include <linux/acpi.h>
> >> >
> >> >  #include "internal.h"
> >> >
> >> > @@ -35,6 +36,7 @@ struct node_memory_type_map {
> >> >  };
> >> >
> >> >  static DEFINE_MUTEX(memory_tier_lock);
> >> > +static DEFINE_MUTEX(mt_perf_lock);
> >>
> >> Please add comments about what it protects.  And put it near the data
> >> structure it protects.
> >>
> >
> > Where is better for me to add comments for this? Code? Patch descriptio=
n?
> > Will put it closer to the protected data. Thanks.
>
> Just put the comments at the above of the lock in the source code.
>

Got it. Thanks!

>
> >
> >
> >> >  static LIST_HEAD(memory_tiers);
> >> >  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> >> >  struct memory_dev_type *default_dram_type;
> >> > @@ -623,6 +625,58 @@ void clear_node_memory_type(int node, struct me=
mory_dev_type *memtype)
> >> >  }
> >> >  EXPORT_SYMBOL_GPL(clear_node_memory_type);
> >> >
> >> > +struct memory_dev_type *find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
> >> > +{
> >> > +     bool found =3D false;
> >> > +     struct memory_dev_type *mtype;
> >> > +
> >> > +     list_for_each_entry(mtype, memory_types, list) {
> >> > +             if (mtype->adistance =3D=3D adist) {
> >> > +                     found =3D true;
> >> > +                     break;
> >> > +             }
> >> > +     }
> >> > +     if (!found) {
> >> > +             mtype =3D alloc_memory_type(adist);
> >> > +             if (!IS_ERR(mtype))
> >> > +                     list_add(&mtype->list, memory_types);
> >> > +     }
> >> > +
> >> > +     return mtype;
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(find_alloc_memory_type);
> >> > +
> >> > +static void memory_tier_late_create(int node)
> >> > +{
> >> > +     struct memory_dev_type *mtype =3D NULL;
> >> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
> >> > +
> >> > +     mt_calc_adistance(node, &adist);
> >> > +     if (adist !=3D MEMTIER_ADISTANCE_DRAM) {
> >>
> >> We can manage default_dram_type() via find_alloc_memory_type()
> >> too.
> >>
> >> And, if "node_memory_types[node].memtype =3D=3D NULL", we can call
> >> mt_calc_adistance(node, &adist) and find_alloc_memory_type() in
> >> set_node_memory_tier().  Then, we can cover hotpluged memory node too.
> >>
> >> > +             mtype =3D hmat_find_alloc_memory_type(adist);
> >> > +             if (!IS_ERR(mtype))
> >> > +                     __init_node_memory_type(node, mtype);
> >> > +             else
> >> > +                     pr_err("Failed to allocate a memory type at %s=
()\n", __func__);
> >> > +     }
> >> > +
> >> > +     set_node_memory_tier(node);
> >> > +}
> >> > +
> >> > +void memory_tier_late_init(void)
> >> > +{
> >> > +     int nid;
> >> > +
> >> > +     mutex_lock(&memory_tier_lock);
> >> > +     for_each_node_state(nid, N_MEMORY)
> >> > +             if (!node_state(nid, N_CPU))
> >>
> >> We should exclude "node_memory_types[nid].memtype !=3D NULL".  Some me=
mory
> >> nodes may be onlined by some device drivers and setup memory tiers
> >> already.
> >>
> >> > +                     memory_tier_late_create(nid);
> >> > +
> >> > +     establish_demotion_targets();
> >> > +     mutex_unlock(&memory_tier_lock);
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(memory_tier_late_init);
> >> > +
> >> >  static void dump_hmem_attrs(struct access_coordinate *coord, const =
char *prefix)
> >> >  {
> >> >       pr_info(
> >> > @@ -636,7 +690,7 @@ int mt_set_default_dram_perf(int nid, struct acc=
ess_coordinate *perf,
> >> >  {
> >> >       int rc =3D 0;
> >> >
> >> > -     mutex_lock(&memory_tier_lock);
> >> > +     mutex_lock(&mt_perf_lock);
> >> >       if (default_dram_perf_error) {
> >> >               rc =3D -EIO;
> >> >               goto out;
> >> > @@ -684,7 +738,7 @@ int mt_set_default_dram_perf(int nid, struct acc=
ess_coordinate *perf,
> >> >       }
> >> >
> >> >  out:
> >> > -     mutex_unlock(&memory_tier_lock);
> >> > +     mutex_unlock(&mt_perf_lock);
> >> >       return rc;
> >> >  }
> >> >
> >> > @@ -700,7 +754,7 @@ int mt_perf_to_adistance(struct access_coordinat=
e *perf, int *adist)
> >> >           perf->read_bandwidth + perf->write_bandwidth =3D=3D 0)
> >> >               return -EINVAL;
> >> >
> >> > -     mutex_lock(&memory_tier_lock);
> >> > +     mutex_lock(&mt_perf_lock);
> >> >       /*
> >> >        * The abstract distance of a memory node is in direct proport=
ion to
> >> >        * its memory latency (read + write) and inversely proportiona=
l to its
> >> > @@ -713,7 +767,7 @@ int mt_perf_to_adistance(struct access_coordinat=
e *perf, int *adist)
> >> >               (default_dram_perf.read_latency + default_dram_perf.wr=
ite_latency) *
> >> >               (default_dram_perf.read_bandwidth + default_dram_perf.=
write_bandwidth) /
> >> >               (perf->read_bandwidth + perf->write_bandwidth);
> >> > -     mutex_unlock(&memory_tier_lock);
> >> > +     mutex_unlock(&mt_perf_lock);
> >> >
> >> >       return 0;
> >> >  }
> >> > @@ -836,6 +890,14 @@ static int __init memory_tier_init(void)
> >> >        * types assigned.
> >> >        */
> >> >       for_each_node_state(node, N_MEMORY) {
> >> > +             if (!node_state(node, N_CPU))
> >> > +                     /*
> >> > +                      * Defer memory tier initialization on CPUless=
 numa nodes.
> >> > +                      * These will be initialized when HMAT informa=
tion is
> >>
> >> HMAT is platform specific, we should avoid to mention it in general co=
de
> >> if possible.
> >>
> >
> > Will fix! Thanks,
> >
> >
> >> > +                      * available.
> >> > +                      */
> >> > +                     continue;
> >> > +
> >> >               memtier =3D set_node_memory_tier(node);
> >> >               if (IS_ERR(memtier))
> >> >                       /*
> >>
>
> --
> Best Regards,
> Huang, Ying



--
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

