Return-Path: <linux-acpi+bounces-5176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB78AA86B
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Apr 2024 08:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1001F21FD4
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Apr 2024 06:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2A42206C;
	Fri, 19 Apr 2024 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M/tcyPTn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF446883D
	for <linux-acpi@vger.kernel.org>; Fri, 19 Apr 2024 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508074; cv=none; b=kHoFG6paE+VgYIj7s65sRKnQHaFepsqwaHkLdNgrQYDhOJKnvZ/QSae5c4pTMPDZ+6zSlaxUoEsCT8BiUyF6lpPEEZWCqdrUO9qZp4obeDMwRqggqx77UDmtOl2mu65lEkqraXyLaaawuLCIcYLhlE6zLTDy2mmcoW4RAm9fJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508074; c=relaxed/simple;
	bh=PMENbycWR80LGlHz52du/Cq3m/a213RCoUDFiAYhtY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRyLrP++sE1hmzFm+vS23jdy8Vjz3UXHdKBiFXJmZPOzf4F0PR4yCEF96VFSENAfzD1/97xg1OVjDt/h9lj2AuSIK82B/LeJlGe7cZjuN7E2tBA9nEsJwkAMc4EZ2zAKMTpaG9BcgwNpJnU8j1K/29TK1LOWyTbnlaqYvO999Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M/tcyPTn; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6eb7500abe3so1209262a34.2
        for <linux-acpi@vger.kernel.org>; Thu, 18 Apr 2024 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713508071; x=1714112871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6YFkKyn5/BuCOc0JMepcoAMu+9H+aV4NIJoWyR8Zmo=;
        b=M/tcyPTnE5ZD/PbrQ+fOniKs7YhuPzwDTJTfLseLzb94xmgWvJVRORDzf4rpbqdGq/
         /GrcmqlgRnRKQ6eHKzM4LDZbMTQov/Gi1EwEpigFnCarVoAmzfvtSccx97rhb6M6vPCj
         1fb0VTpTfV05UEdOiyiovSskdopJ18PYX/4ubrauC6uTZau4LVMq/KQV0B+NSBvDkwP4
         /TH2IlYYskJBBe4mjtM+qJEXXhL0PTtjnzPhTjljnqWufeb4AC5n9EkBI1jHQIslSENV
         5/NUm3mXI5d3O4/lJN1SF4VljL+mjMJ8rS746MynWLdiKyNEZGm2SsO58ad5/AgbFmEn
         UbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713508071; x=1714112871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6YFkKyn5/BuCOc0JMepcoAMu+9H+aV4NIJoWyR8Zmo=;
        b=sr1OhsbFUiOYLfoc1CSHrcAWeBsGzMeQYwHaAgzmMdGQ/QoDZUHfIKuHtodNMhS+1l
         w5NhcqnScRrRazIiIj4rG4rrL4c27M+96nSv/lZ5G6GKq2iQfmMehPDW0jZyhreacEGm
         QpGLqvkYzGQjjh+H2w8ZzVYgrgEefzM5FuygnXddthP8ZYKWx9/PjKFW4XaUvSQgyngc
         E46dAJji9c/v0q63UZbweFHY06TbP1sXpZO1lEs+j9vq7IhvIiN2ATiaFee/BnEmEIFC
         53/uutUSug19qT67ozjceDeTdgDIodHT17AJXk5fNShrrSqSYSZQitxQhGgt609M85he
         FuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3+5x02ZoXA2e9wvZVMQBeWUc2mTpWyGMiGFHc5PQ9jYflciyeLgquN/IeiLsv6curLIBT035TxfB5PPJhHLPRaJgMoOZ9WX3FPA==
X-Gm-Message-State: AOJu0YxJrqOHvr4hURk6itHMrLuyYvV8CakzC7E8557exiK2zxXmS47F
	dpfW/6OMwOFah+AKUUEdp6nT3BCdnWBVlxJOnCLtWxaaAxEM3qrapL3V4yDF571eqzKsLNgsHjx
	s4++MEInnFQzuD4it6TObRUNuOpQP2y/ynBQshA==
X-Google-Smtp-Source: AGHT+IGf8SONi2t4Gq3O9Mc0MZ15L3EcbK72rX/+CNgR7DC3KTPhm36jDoIozEgIKj5ptE6BCWlUi4kFxG6WxMLgMps=
X-Received: by 2002:a05:6870:b14c:b0:22e:a7a1:6e56 with SMTP id
 a12-20020a056870b14c00b0022ea7a16e56mr1339830oal.29.1713508071026; Thu, 18
 Apr 2024 23:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com> <20240418084144.go3zk5yycsg6e2k2@bogus>
In-Reply-To: <20240418084144.go3zk5yycsg6e2k2@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 19 Apr 2024 14:27:39 +0800
Message-ID: <CAEEQ3wm-t1DM+5d4ugr+dM+g4oBLwpOtLM=C2f=NAfOF_u0bUw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com, 
	john.garry@huawei.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi palmer,

On Thu, Apr 18, 2024 at 4:42=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Thu, Apr 18, 2024 at 11:43:29AM +0800, Yunhui Cui wrote:
> > Before cacheinfo can be built correctly, we need to initialize level
> > and type. Since RSIC-V currently does not have a register group that
> > describes cache-related attributes like ARM64, we cannot obtain them
> > directly, so now we obtain cache leaves from the ACPI PPTT table
> > (acpi_get_cache_info()) and set the cache type through split_levels.
> >
> > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinf=
o.c
> > index 30a6878287ad..e47a1e6bd3fe 100644
> > --- a/arch/riscv/kernel/cacheinfo.c
> > +++ b/arch/riscv/kernel/cacheinfo.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/cpu.h>
> >  #include <linux/of.h>
> >  #include <asm/cacheinfo.h>
> > +#include <linux/acpi.h>
> >
> >  static struct riscv_cacheinfo_ops *rv_cache_ops;
> >
> > @@ -78,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
> >       struct device_node *prev =3D NULL;
> >       int levels =3D 1, level =3D 1;
> >
> > +     if (!acpi_disabled) {
> > +             int ret, fw_levels, split_levels;
> > +
> > +             ret =3D acpi_get_cache_info(cpu, &fw_levels, &split_level=
s);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             BUG_ON((split_levels > fw_levels) ||
> > +                    (split_levels + fw_levels > this_cpu_ci->num_leave=
s));
> > +
> > +             for (; level <=3D this_cpu_ci->num_levels; level++) {
> > +                     if (level <=3D split_levels) {
> > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_DATA=
, level);
> > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_INST=
, level);
> > +                     } else {
> > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_UNIF=
IED, level);
> > +                     }
> > +             }
> > +             return 0;
> > +     }
> > +
>
> Much better, so my review still stands =F0=9F=98=84
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> >       if (of_property_read_bool(np, "cache-size"))
> >               ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> >       if (of_property_read_bool(np, "i-cache-size"))
> > --
> > 2.20.1
> >
>
> --
> Regards,
> Sudeep

Do you have any comments about this patch series?

Thanks,
Yunhui

