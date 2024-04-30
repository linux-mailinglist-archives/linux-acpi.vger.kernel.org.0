Return-Path: <linux-acpi+bounces-5472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC3A8B683B
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 05:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147D4B218AD
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 03:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D51FC01;
	Tue, 30 Apr 2024 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dZcj1YtF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0901DDDA
	for <linux-acpi@vger.kernel.org>; Tue, 30 Apr 2024 03:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446990; cv=none; b=WwOUhRcQvpaxqS8/H7PChSJPi4IM8KWsB3knsBXIHhNkTULAQw7Lp+TlS15sRVOiCaCGhDuCJ3bQ1LfplZpAx2734G9PYZYGWtyRW/rltYLDw7ItTsZcGJ6lOyC9xWXVAOhJZ3jXlgLVBN0H1+201kvsZcHF22y1x4W+CdV4VWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446990; c=relaxed/simple;
	bh=J9Uks/wSVBDMZDqvqL821ZvLl/AHfaZ2zTTwqy+dauc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0KmXABzssZXuLDFOL9AY0gthbsdX1RSOuKFJQrAFAV7FqlMa2YiWyjreeS8t+DWo0cUerBe97Pee+u8GmVAofdsToTN6xdz36LftFfQBqm8xI+YGBI64erhgUyiA7ygsqICwzI6ZQLOwd5cXXZ+Wi8yQwmoE4+nUGGd5/VzZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dZcj1YtF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23333dddd8aso2436734fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2024 20:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714446987; x=1715051787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewLuAUPPP39X0HCkRHtN2NHvevZusHejI+aydV0tNX4=;
        b=dZcj1YtFnMMluykz4azkZGm9/O7ZO7Q5DPepNAohogxeowhN4VBCqIe+qz789KDMU9
         +ry426yB4YDDXoOlqvjbCkmiK/n5ODyq7nhWkxrSKvwilm/FTIL4kmkGt2NFEaWlKk9J
         R9wJkjNwADkJQPNb/5SeC1Gqv+tTS9FVRHFxh/ryki7uuW3N1++2+MtO8x+kvuRXwxvK
         05ZWMl/yy9NOIIgGKliQIuxIwBpyQvNBY23zxS5B8YDqqof/WkFvt6FohflLkeJ/hVPy
         7ReQ1vpO3c/bci5tQpDAOA+bNgJZQS7pEQg0tmumsq8oZlMvoi3x+x7/xMKeNASZ8SKG
         OOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714446987; x=1715051787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewLuAUPPP39X0HCkRHtN2NHvevZusHejI+aydV0tNX4=;
        b=wxJF/6MLEt/FAKHojPQOFd4tV8cZ43/n48x61WxqnCYUFUbarIMjSD8VwmrfPMwCnp
         4ttjcbY7N4rvF+sdHifE9cnpj6xr/0WqO8aekCK9t1AIcjJUU7BTzuMyapBPJGJhuZ4w
         84hJ4cyaUUc+DzKp/qNmNXncyeeVcjaerCeQkGeFGmKnmMsIR7X4GPXgBmlWMrBnZbpV
         9lOpJEp/LEZfxQQXwoHjWB5TxkDauhq0u8FfeGpFdN0hVu+FkcAKFqdxmjtKOCiViS85
         /cF7PBy9uVPTxxVx/vHLtgYKdPub7dSSopedYf904tUCi+I6Q+NuciTA+vz+jk8lUD3d
         kDfA==
X-Forwarded-Encrypted: i=1; AJvYcCVXH2vUhplNoMAH46uZKYjC34ybAJXoTufv6oASdqV6ZhahvMeeHPcWpLVjAFwB4C5J8g/Un4EBrFrKVZ7ArLhsN4147RVWhZOSrQ==
X-Gm-Message-State: AOJu0YxvD8bcHe9KvlhATIqmGzpyApk7Lnzdhg5Tkuew3TiLiMP0bt+z
	u2ctrh2iq2C9sT4Ly0FEyyecuytoHvAlEjwIIEe5LD07Lm2zEDT7r2xWBUquptOaMQ4YFflFq/b
	SX1r9SFlACmnexMeyFWW6u3Gb3twpf57FLoNMTg==
X-Google-Smtp-Source: AGHT+IHQZKM1ZIvOzc0BTAWTiBchrFVz/jaxMvcm4J0YS/D7nzOQrjehDvNXZEDRtLipEVRhqNLnJGXaHB+hLjHZ7EU=
X-Received: by 2002:a05:6871:8912:b0:23c:2554:d8b7 with SMTP id
 ti18-20020a056871891200b0023c2554d8b7mr8543686oab.20.1714446986897; Mon, 29
 Apr 2024 20:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com> <d143cd11-26ea-42e3-8f32-700a34b3705e@arm.com>
 <CAEEQ3wkDMuu+jh56YB3G0vY_ENdUjDL6byMsJXd0C9aQu1FZKw@mail.gmail.com>
In-Reply-To: <CAEEQ3wkDMuu+jh56YB3G0vY_ENdUjDL6byMsJXd0C9aQu1FZKw@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 30 Apr 2024 11:16:15 +0800
Message-ID: <CAEEQ3w=FJMzkL3_if1rQcHCUu0C9PVJzL3D3yytNLr-y3YS5nw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Jeremy Linton <jeremy.linton@arm.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com, 
	john.garry@huawei.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Gentle ping...

On Tue, Apr 23, 2024 at 7:03=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Palmer,
>
> On Fri, Apr 19, 2024 at 11:29=E2=80=AFPM Jeremy Linton <jeremy.linton@arm=
.com> wrote:
> >
> > Hi,
> >
> > On 4/17/24 22:43, Yunhui Cui wrote:
> > > Before cacheinfo can be built correctly, we need to initialize level
> > > and type. Since RSIC-V currently does not have a register group that
> > > describes cache-related attributes like ARM64, we cannot obtain them
> > > directly, so now we obtain cache leaves from the ACPI PPTT table
> > > (acpi_get_cache_info()) and set the cache type through split_levels.
> > >
> > > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >   arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
> > >   1 file changed, 22 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cachei=
nfo.c
> > > index 30a6878287ad..e47a1e6bd3fe 100644
> > > --- a/arch/riscv/kernel/cacheinfo.c
> > > +++ b/arch/riscv/kernel/cacheinfo.c
> > > @@ -6,6 +6,7 @@
> > >   #include <linux/cpu.h>
> > >   #include <linux/of.h>
> > >   #include <asm/cacheinfo.h>
> > > +#include <linux/acpi.h>
> > >
> > >   static struct riscv_cacheinfo_ops *rv_cache_ops;
> > >
> > > @@ -78,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
> > >       struct device_node *prev =3D NULL;
> > >       int levels =3D 1, level =3D 1;
> > >
> > > +     if (!acpi_disabled) {
> > > +             int ret, fw_levels, split_levels;
> > > +
> > > +             ret =3D acpi_get_cache_info(cpu, &fw_levels, &split_lev=
els);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             BUG_ON((split_levels > fw_levels) ||
> > > +                    (split_levels + fw_levels > this_cpu_ci->num_lea=
ves));
> > > +
> > > +             for (; level <=3D this_cpu_ci->num_levels; level++) {
> > > +                     if (level <=3D split_levels) {
> > > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_DA=
TA, level);
> > > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_IN=
ST, level);
> > > +                     } else {
> > > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_UN=
IFIED, level);
> > > +                     }
> > > +             }
> > > +             return 0;
> > > +     }
> > > +
> > >       if (of_property_read_bool(np, "cache-size"))
> > >               ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> > >       if (of_property_read_bool(np, "i-cache-size"))
> >
> > Yes, looks good.
> >
> > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> >
> >
> >
> > Thanks,
>
> Could you help review this patchset? Thanks.
>
> Thanks,
> Yunhui

Thanks,
Yunhui

