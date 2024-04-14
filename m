Return-Path: <linux-acpi+bounces-4990-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D680D8A3FF3
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Apr 2024 04:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA6E1F222B8
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Apr 2024 02:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0742F168B7;
	Sun, 14 Apr 2024 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LJcNZyEl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4912E75
	for <linux-acpi@vger.kernel.org>; Sun, 14 Apr 2024 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713062448; cv=none; b=NR0/k1E1a9Eno/PekOPfEQ3wh9c0hae313QrK9HvJ7Vc8JWeNl4qcglxAjchjKWTeTD7jOKfJ+VUIFwx8zqKLO1iU7LyCkUHuYzMtkMVLMQsqhLYU2iI2W40b6syQTWRp5yo7RzueYI6JNaQqFlOrzYvRUz0tDv5lcVBm/L38us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713062448; c=relaxed/simple;
	bh=0Ra2rBygaHTvfTYkSYizmWffraI2B7qG+UW9u4YkyTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmB/Vi8T3O3wVE4c2LmoG0ztrgRJ8+M2qY6pKersMbv3uJwUpeKyqkmnVdtZM5IU7ldrulHygLmhjVOKVa3p1G8rmfnDGUgAbZtS3xoxjJfa8KkGHo1iYVZCoEBYeV678klfD8kCyDM4HsyUOqG/AxY394L7S3NaAqbOGH/y0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LJcNZyEl; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23408962585so762821fac.2
        for <linux-acpi@vger.kernel.org>; Sat, 13 Apr 2024 19:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713062445; x=1713667245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg5h8uRNuNN02FjEj+e/nOQiSG+uVSKaRhJ+VyPOQkA=;
        b=LJcNZyElY+lxZOUa6/2/PqerXM1BPLTDrSEGTV4620D4ndO+e24/m8Cw2eVNtmHQKt
         BEoy3dDOUa+9m1uODs6cjGLzv5IeA48roPQtoXQnLK+Jm/xYmlXjwDV38b4gz0J01Eye
         hDvsdMGZqzt7LgsjqAs1ECLowI7JjXAcrHmUsMItdN45yDpdsub1nmaXdPi5rT7rShE7
         nyaYcB/Nj8bfKOn+N6cxifnanRhFuglh/aqfXyjjZC3RjN6mcA3XD53lrdboTNfzCEys
         B7Ytx0MUtui72BLQAu+ZBaLLotTbjIdAy6RoBjz3ryqYfYOUmhMQSz4bSaNYIdpYfM4h
         mcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713062445; x=1713667245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg5h8uRNuNN02FjEj+e/nOQiSG+uVSKaRhJ+VyPOQkA=;
        b=LNdbZBuKQDMuYA0oNFz7CYNtqPbNIayu0ySrq2Eu1VJhO9QYvpSwXzUNqevitapQqz
         xGrFBOZItJnncv3D/P88Nh9g8CNTEWBeLYXL4JayVvbVqU9WuaWUPcR9ZVOWC5Xl7UVw
         MymGofRzIk08yX40s5QXi0+lQj/5fmGbWyyGcG+DLQt+O8NUY7N5J04W83j5CYBiALWm
         sH6WUxoBFKNNZrQDt2bfSovz8Gv2KPSnXpzSNzBhj6U2mY3mg3vl0cdMZBDFK5gidKzJ
         5Kc7ScR/lq91UVXg5V/63ZznXiiViA9BchXT7qDUqoS4I0vkLlSsBlNtEcYswjQHU61D
         LT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgUl1BV63Wjv8R2jGO2xasLPQ3t4zULXH28GiTCBUzKF3b4ZQhoJqA5JInlpKJbT7vKAXYdB8GXfkU5TR+aW+H5zAGEvdVCzwtFg==
X-Gm-Message-State: AOJu0YxGFQYP2iZdFfJ9EK8a6+i7S59aTlFxSVnjGm8rQYq3XZX6zguu
	fKhGr79qJMQ0kO3WOvU0pRhlET219f4Yuv0DTt7Yq0K0bZ4w6iszw5oTLCqIdgzFKxYr6aIGSXH
	rSMi4KOi0kN/aQKL8HjB4cpJ5L9vqImDfvMmVcQ==
X-Google-Smtp-Source: AGHT+IGG1vbolPF8XedWyN268VhRLxaCyGKWzCADzcv/mukMs/gFqjPg6R/T4v4fW1herfdfnjmDrf4faIvQBZtWKe8=
X-Received: by 2002:a05:6871:322f:b0:21e:9aa5:f3f7 with SMTP id
 mo47-20020a056871322f00b0021e9aa5f3f7mr5658929oac.58.1713062445707; Sat, 13
 Apr 2024 19:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
 <abd135fa-c432-4e37-9792-07a0e17e93d5@arm.com> <CAEEQ3w=+C2J0ZS227-1P-B+pe_NRp_3i4c4CxGssiKqbpXx_qw@mail.gmail.com>
 <2cde00c8-7878-45c0-8621-fca4e70c75e7@arm.com> <ZhlcYRolZwm7UwJu@bogus> <Zhlg67dbl_S1GD0u@bogus>
In-Reply-To: <Zhlg67dbl_S1GD0u@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sun, 14 Apr 2024 10:40:34 +0800
Message-ID: <CAEEQ3w=VrQRammHcKBhT=YGPTZ=ktK9PDhLCBM9ODpYMJw_=-Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep=EF=BC=8CJeremy=EF=BC=8C

On Sat, Apr 13, 2024 at 12:27=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com=
> wrote:
>
> On Fri, Apr 12, 2024 at 05:08:01PM +0100, Sudeep Holla wrote:
> > diff --git i/arch/riscv/kernel/cacheinfo.c w/arch/riscv/kernel/cacheinf=
o.c
> > index 09e9b88110d1..92ab73ed5234 100644
> > --- i/arch/riscv/kernel/cacheinfo.c
> > +++ w/arch/riscv/kernel/cacheinfo.c
> > @@ -79,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
> >         struct device_node *prev =3D NULL;
> >         int levels =3D 1, level =3D 1;
> >
> > +       if (!acpi_disabled) {
> > +               int ret, fw_levels, split_levels;
> > +
> > +               ret =3D acpi_get_cache_info(cpu, &fw_levels, &split_lev=
els);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               /* must be set, so we can drop num_leaves assignment be=
low */
> > +               this_cpu_ci->num_leaves =3D fw_levels + split_levels;
> > +
> > +               for (idx =3D 0; level <=3D this_cpu_ci->num_levels &&
> > +                    idx < this_cpu_ci->num_leaves; idx++, level++) {
> > +                       if (level <=3D split_levels) {
> > +                               ci_leaf_init(this_leaf++, CACHE_TYPE_DA=
TA, level);
> > +                               ci_leaf_init(this_leaf++, CACHE_TYPE_IN=
ST, level);
> > +                       } else {
> > +                               ci_leaf_init(this_leaf++, CACHE_TYPE_UN=
IFIED, level);
> > +                       }
> > +               }
>
> Ofcourse we need to add here,
>                 return 0;
>
> > +       }
> > +
> >         if (of_property_read_bool(np, "cache-size"))
> >                 ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level=
);
> >         if (of_property_read_bool(np, "i-cache-size"))
> >
>
> --
> Regards,
> Sudeep

With this modification, I tested that I can obtain cacheinfo
correctly. If RISC-V later adds a new register describing the cache,
then we can continue to improve it in populate_cache_leaves().
Thank you for your comments and I will add you as Suggested-by in v2.

Thanks,
Yunhui

