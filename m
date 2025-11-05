Return-Path: <linux-acpi+bounces-18554-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A05C36B00
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 17:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A510A681DAF
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55203358B3;
	Wed,  5 Nov 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABBMehgU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8498330313
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359400; cv=none; b=P390qOrxN+16Z2XHHjGxhtiqIwjvEDO2T+Y1BLN0o1QMD8TE8S5nvNG/RiyJRxPEfZuJPJNbsOv9kFFjq5DkFsT3CBNL2CWrFXwthonIKX0XDLQcBJlzmU08Cjz9URZ/jm09e/WNRqFeHebu4oh4S+jEew7E+NebDBJm9DZdUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359400; c=relaxed/simple;
	bh=0mW1b+073J2WkpEQgSQKQ1fM7vUG/qFsJY90DxjuK3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUiaML3/8ChPDeNDLquSHt5f7SutYpP9Ndbc6Vdv9O6okoC6POqhF3CjwUXZ7B5bFA3Rxp6k5ROb8ZmB2ixzqJUPQEoW4TOFUgYoKUuv/N5snMnxib4b5XIXQEBj7Sn1mnFxM0gBSBIy4FKqm97OwSCsI+OsbB3AIYT9eZPchH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABBMehgU; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so293849139f.2
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762359398; x=1762964198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACs9ehJB3oUkzpqGylHL7GURPnmGaEVz6xiN6ORjiWI=;
        b=ABBMehgUwkZhVIo1+hLrwrvLisbWg0FCHrESyyNmmQCC8N2yXkdsC8GSGGE84D6wDm
         w3jM9d7Vq1duUa8kv6wORSI4JvOCCkBMGHA0loPbg+GwdyE9xX4zepkitVOK9sNfa2mY
         65QMKy/9bQi0PB+rH9WdQJlf8P39ESyPR73P92/W6vKvY6mquaWnZ3AcJz2D1T8MGK9i
         ObdLgbka2bMwAU+OmCzEXUmEUDCD1kXOUm4MvWXFpmYi4ChDugPbFJq5GEVCShTsyCs4
         t2kOlI2Ifphf0CX7UG9l0KTp9yb8/VaXtPocaU1qVoyHLR5NA8eT83RvT29dXpGpPp0e
         oAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359398; x=1762964198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACs9ehJB3oUkzpqGylHL7GURPnmGaEVz6xiN6ORjiWI=;
        b=BEuRmuhP1fELDzc/aAMJ/KEVCoPNjNZhz0RppKeU7Q/wNdmgX0ppGEbdKrtIKMMQRJ
         qXCRES3LvAp5XZpKZl8/iAj5xiZMGh8rNmeC9HBgyBh3NRStzA5v2jX+pm344Y8PcNmj
         SWzjpTgm9OSgXiBZSfkb7i61g9LJOxouUMfrwFhBN8lm4Sr0xZ0wNWBgzoTSZTTqFOJh
         p/IHZTbR9Uy4oPyWpmK8MbtGxQY4/fE9F6UkgX0dN9oNenBRzoKBpfIKoZmdCHgMLb+y
         C9jRiJL580dlsHcFC9Q0rQbDVfe9iTnIrqdzcc+W0qfG0YPVbr5sERh5OKfFr0ALL8rN
         4BUg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4mLXZjhP8vyEr8E5bsv3w6iadPmue7yIgv9BlR45c9h9s8MrZcux+sNv2B2zSlUnfWYbeWO7hdaE@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTGETStL8R79ue7pEe3iOH1gspcszSVA0nlIzpKGn/KwX//Jj
	AK8m6nCeOlSCWzn12xatuAS7I2ODCBy85DygG5u5/61M+ttsO9rfdrdiioJWjOLWKsku7Im+OgH
	1peFAvryqCJ62ClvFhEoHHPUaNl8rywxQHk8KAiHi
X-Gm-Gg: ASbGncve5Mt0n6ESUHQpoHW1j44mTrApEpgOCsZaz69ZuuLY/U05pQVnVcCLn9eU1cm
	TSyMBu6BqHQdTdfbwzu2oI/wQEX0idJ/gKbRoftA+Q3lK6qzpLGM/6fpgV7xno5Muhaxy/IJk9i
	bZK4dloZTBdrzN5kreardlBvS9xPo6OTZ+vE3HfNyvAV/O/AvX6RukySJ0XbwMBVPb/MR7jKKy9
	UFd7ZwqPl4mKt2QboRKBoM98LzqLuO0psVDHgjPkhDgna2kyKfiBI0H1B+iKRcWAxy31zveQ02J
	r4YYisWULS65bpYgDzc6R5qPAQ==
X-Google-Smtp-Source: AGHT+IFrsuFMA1TSlPF6UPOqwRKI3S1TVMUqjqGwbsvSlZ623YeZIKO2ZUxGfz3c2g6/ooCxqi5U/+HTdvc4VcOqieE=
X-Received: by 2002:a05:6e02:1805:b0:430:b994:3bd1 with SMTP id
 e9e14a558f8ab-433407698c4mr55204705ab.1.1762359397327; Wed, 05 Nov 2025
 08:16:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017185645.26604-1-james.morse@arm.com> <20251017185645.26604-21-james.morse@arm.com>
 <OSZPR01MB8798162B444DA35707A4E3798BFCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB8798162B444DA35707A4E3798BFCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 5 Nov 2025 17:16:24 +0100
X-Gm-Features: AWmQ_bn_GHMcQLM6dMy9FTsbSXlRMr5a1a_4wB6ts3RgPX1XxSVdyRM8ndMU0uE
Message-ID: <CALPaoChLKRQqjZO+O92WQ=MsWjV+q=hVE8=BXCOdkta6ZEXNMQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/29] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
Cc: James Morse <james.morse@arm.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	D Scott Phillips OS <scott@os.amperecomputing.com>, 
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>, 
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, 
	Xin Hao <xhao@linux.alibaba.com>, "dfustini@baylibre.com" <dfustini@baylibre.com>, 
	"amitsinght@marvell.com" <amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, 
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>, 
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, 
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>, 
	Ben Horgan <ben.horgan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 9:48=E2=80=AFAM Shaopeng Tan (Fujitsu)
<tan.shaopeng@fujitsu.com> wrote:
>
> Hello James,
>
> > When CPUs come online the MSC's original configuration should be restor=
ed.
> >
> > Add struct mpam_config to hold the configuration. This has a bitmap of
> > features that were modified. Once the maximum partid is known, allocate=
 a
> > configuration array for each component, and reprogram each RIS configur=
ation
> > from this.
> >
> > CC: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> > Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> > ---
> > Changes since v2:
> >  * Call mpam_init_reset_cfg() on alloated config as 0 is not longer cor=
rect.
> >  * init_garbage() on each config - the array has to be freed in one go,=
 but
> >    otherwise this looks weird.
> >  * Use struct initialiser in mpam_init_reset_cfg(),
> >  * Moved int err definition.
> >  * Removed srcu lock taking based on squinting at the only caller.
> >  * Moved config reset to mpam_reset_component_cfg() for re-use in
> >    mpam_reset_component_locked(), previous memset() was not enough
> > since zero
> >    no longer means reset.
> >
> > Changes since v1:
> >  * Switched entry_rcu to srcu versions.
> >
> > Changes since RFC:
> >  * Added a comment about the ordering around max_partid.
> >  * Allocate configurations after interrupts are registered to reduce ch=
urn.
> >  * Added mpam_assert_partid_sizes_fixed();
> >  * Make reset use an all-ones instead of zero config.
> > ---
> >  drivers/resctrl/mpam_devices.c  | 284
> > +++++++++++++++++++++++++++++---
> > drivers/resctrl/mpam_internal.h |  23 +++
> >  2 files changed, 287 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devi=
ces.c
> > index ab37ed1fb5de..e990ef67df5b 100644
> > --- a/drivers/resctrl/mpam_devices.c
> > +++ b/drivers/resctrl/mpam_devices.c
> > @@ -118,6 +118,17 @@ static inline void init_garbage(struct mpam_garbag=
e
> > *garbage)  {
> >       init_llist_node(&garbage->llist);
> >  }
> > +
> > +/*
> > + * Once mpam is enabled, new requestors cannot further reduce the
> > +available
> > + * partid. Assert that the size is fixed, and new requestors will be
> > +turned
> > + * away.
> > + */
> > +static void mpam_assert_partid_sizes_fixed(void)
> > +{
> > +     WARN_ON_ONCE(!partid_max_published);
> > +}
> > +
> >  static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)  {
> >       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> > &msc->accessibility)); @@ -366,12 +377,16 @@ static void
> > mpam_class_destroy(struct mpam_class *class)
> >       add_to_garbage(class);
> >  }
> >
> > +static void __destroy_component_cfg(struct mpam_component *comp);
> > +
> >  static void mpam_comp_destroy(struct mpam_component *comp)  {
> >       struct mpam_class *class =3D comp->class;
> >
> >       lockdep_assert_held(&mpam_list_lock);
> >
> > +     __destroy_component_cfg(comp);
> > +
> >       list_del_rcu(&comp->class_list);
> >       add_to_garbage(comp);
> >
> > @@ -812,48 +827,102 @@ static void mpam_reset_msc_bitmap(struct
> > mpam_msc *msc, u16 reg, u16 wd)
> >       __mpam_write_reg(msc, reg, bm);
> >  }
> >
> > -static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid=
)
> > +/* Called via IPI. Call while holding an SRCU reference */ static void
> > +mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
> > +                                   struct mpam_config *cfg)
> >  {
> >       struct mpam_msc *msc =3D ris->vmsc->msc;
> >       struct mpam_props *rprops =3D &ris->props;
> >
> > -     WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
> > -
> >       mutex_lock(&msc->part_sel_lock);
> >       __mpam_part_sel(ris->ris_idx, partid, msc);
> >
> > -     if (mpam_has_feature(mpam_feat_cpor_part, rprops))
> > -             mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
> > rprops->cpbm_wd);
> > +     if (mpam_has_feature(mpam_feat_cpor_part, rprops) &&
> > +         mpam_has_feature(mpam_feat_cpor_part, cfg)) {
> > +             if (cfg->reset_cpbm)
> > +                     mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
> > +                                           rprops->cpbm_wd);
> > +             else
> > +                     mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
> > +     }
> >
> > -     if (mpam_has_feature(mpam_feat_mbw_part, rprops))
> > -             mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
> > rprops->mbw_pbm_bits);
> > +     if (mpam_has_feature(mpam_feat_mbw_part, rprops) &&
> > +         mpam_has_feature(mpam_feat_mbw_part, cfg)) {
> > +             if (cfg->reset_mbw_pbm)
> > +                     mpam_reset_msc_bitmap(msc,
> > MPAMCFG_MBW_PBM,
> > +                                           rprops->mbw_pbm_bits);
> > +             else
> > +                     mpam_write_partsel_reg(msc, MBW_PBM,
> > cfg->mbw_pbm);
> > +     }
> >
> > -     if (mpam_has_feature(mpam_feat_mbw_min, rprops))
> > +     if (mpam_has_feature(mpam_feat_mbw_min, rprops) &&
> > +         mpam_has_feature(mpam_feat_mbw_min, cfg))
> >               mpam_write_partsel_reg(msc, MBW_MIN, 0);
> >
> > -     if (mpam_has_feature(mpam_feat_mbw_max, rprops))
> > -             mpam_write_partsel_reg(msc, MBW_MAX,
> > MPAMCFG_MBW_MAX_MAX);
> > +     if (mpam_has_feature(mpam_feat_mbw_max, rprops) &&
> > +         mpam_has_feature(mpam_feat_mbw_max, cfg))
> > +             mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
> >
> >       mutex_unlock(&msc->part_sel_lock);
> >  }
> >
> > +struct reprogram_ris {
> > +     struct mpam_msc_ris *ris;
> > +     struct mpam_config *cfg;
> > +};
> > +
> > +/* Call with MSC lock held */
> > +static int mpam_reprogram_ris(void *_arg) {
> > +     u16 partid, partid_max;
> > +     struct reprogram_ris *arg =3D _arg;
> > +     struct mpam_msc_ris *ris =3D arg->ris;
> > +     struct mpam_config *cfg =3D arg->cfg;
> > +
> > +     if (ris->in_reset_state)
> > +             return 0;
> > +
> > +     spin_lock(&partid_max_lock);
> > +     partid_max =3D mpam_partid_max;
> > +     spin_unlock(&partid_max_lock);
> > +     for (partid =3D 0; partid <=3D partid_max + 1; partid++)
> > +             mpam_reprogram_ris_partid(ris, partid, cfg);
> > +
> > +     return 0;
> > +}
> > +
> > +static void mpam_init_reset_cfg(struct mpam_config *reset_cfg) {
> > +     *reset_cfg =3D (struct mpam_config) {
> > +             .cpbm =3D ~0,
> > +             .mbw_pbm =3D ~0,
> > +             .mbw_max =3D MPAMCFG_MBW_MAX_MAX,
>
> When rdtgroup_schemata_show() is called, the "cpbm" value is output to th=
e schema file.
> Since bitmap lengths are chip-dependent, I think we just need to reset th=
e bitmap length portion.
> Otherwise, 0xffffffff(u32) will be output from the schemata file.

When I apply additional patches to add the mpam_resctrl.c stuff I
notice this too:

# grep L3 schemata
L3:1=3Dffffffff
# cat info/L3/shareable_bits
ffff

I noticed that new groups also get a too-long cbm as long as any other
groups have a too-long cbm. Maybe this out-of-range value is bleeding
into new groups in __init_one_rdt_domain() when it calls
resctrl_arch_get_config() on all other groups.

-Peter

