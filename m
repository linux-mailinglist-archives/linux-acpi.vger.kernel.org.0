Return-Path: <linux-acpi+bounces-5077-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD878A7AF0
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Apr 2024 05:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128FC2846DC
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Apr 2024 03:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E6F79C2;
	Wed, 17 Apr 2024 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bpLLkZr3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F692748F
	for <linux-acpi@vger.kernel.org>; Wed, 17 Apr 2024 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323751; cv=none; b=JZjn4ihCpEKE89/T1nWjKxy0imj4ARQTi9gJebYGpFVti2dN8VZJGSp2Cqds8ZzKLLrDiHlWPtSijPuxxHl3cai1oRZSzgilc6cVHI8jU/umj7rbIY4L2nUZPfbYFBbfedxU1RUSVcYSVN5XVv7OltiykKaVtMyhpFsYZzq/i8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323751; c=relaxed/simple;
	bh=+YZX28rHLDWuM2x05KKJCYzQLjdwZ0E/VxcDLzfvnyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdkPrMPhmkkiNP3sTX45BQoYhRiJAk5NphKvTP7Tl5W6t++aKsdhiVXK4ZbqNMx5iW+S/NkLfZxdwRvkNDFmgH/svSqWu4XTqtWP8SLXTTJjPyI/6m8U2G2holOAN8KTUo6kuD3Iy4BNWvxIOoYvR6fO2A5vz2satQPlM6qFk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bpLLkZr3; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2220a389390so175451fac.0
        for <linux-acpi@vger.kernel.org>; Tue, 16 Apr 2024 20:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713323749; x=1713928549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9Z++jv9thhXwuK9ebCXoyfu1FayJyWXQhF4Y4dqH70=;
        b=bpLLkZr3p2CYlMtw9dAVizHtdbctiM+c8x3jiv7A8gq2dgXQLHfvRXDk1MCB8ymUuI
         iG2cHLMcvU18D3adhEbSb69p9CHuotWuKdKo+jPe+v3nt9gddXwzDztS33rXs5HCETk2
         C7bzPYO2s7sVoFOuzaGHuZ9m6IoFwS1DLvRmnR8nnlQNxXslTMdToxFdLDitz5zQqfoH
         O9h+zE+OaTPTRxgsrnEaqGTYa7GUZWsn1UTKVrnYz4mFMDSr8R4LRBAUu+QgU+jn8FLe
         8+Th330Ijjumleviq4xN35USCIO2AFb5l09/PSkADYm0vh6L1RXE8M/tBuLb3Mzmme2V
         QcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713323749; x=1713928549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9Z++jv9thhXwuK9ebCXoyfu1FayJyWXQhF4Y4dqH70=;
        b=ZHqDnIGWtSwANrQb0821/GALqvGNKxlK/A5tEpeq/TmafENttTCSqjmW9bbv4LOYd0
         8wKF3g4Jn9ljt2D73hYrPa/6yTXSyAADGxaVjvmcuuhHE0T6tYtttZ7S0eIi0lD1kSx9
         uNwfza3wLuhABhuhwnaXz7MyqO1EcZPLgH+GkDbzgSGNv/DvfP9HsN+lHSMmfqk+MziH
         74c1zTk/MLIzFqkdGkkC2WXhncwP0weqpq5G5CDp/jXxxZpHFqXD+B+ytyDh0brDkV3Z
         exjoO1KQhzOffbkD3csT6ExQbU8TOcRkN+kGvO4U1gw8b6gex/sV3h4nM4xcdIZy0WUx
         Cn/w==
X-Forwarded-Encrypted: i=1; AJvYcCVbIwaFF2nP8+/1nCIMfgE3B65EJw++QOx2eZPINwgt4qNEwqvKLDD5At4VlI7OhncG8X/+sRIptDoUxoXNJd8hhU8gjIzgI7rJ1Q==
X-Gm-Message-State: AOJu0YwveAgqDry7cogJNqzfwfZRxyWUqJ3RC03pR65IN7zSrbRNw/Bm
	TN67c+yfC3KYdcH1Tn9J1+p3theehVS6h4AQoS7LmXXXt3qMu7hq3oBVpQPNyF4Mw7TWplVgjmI
	4Lnyyip7v47D7QwwSj6b/vCFvsAyNvhza/6xiWA==
X-Google-Smtp-Source: AGHT+IG7+SlzZiYgUQUE9mnnio01KvFFZXX0TXlXW4MiCLJOo1mTdXknFxGrqYT18e/8jaVZSK+07OkTH2bc9Zfj+IE=
X-Received: by 2002:a05:6870:51b:b0:22a:a34a:c995 with SMTP id
 j27-20020a056870051b00b0022aa34ac995mr1355278oao.17.1713323749172; Tue, 16
 Apr 2024 20:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416031438.7637-1-cuiyunhui@bytedance.com>
 <20240416031438.7637-2-cuiyunhui@bytedance.com> <9f36bedd-1a68-43a9-826d-ce56caf01c52@arm.com>
In-Reply-To: <9f36bedd-1a68-43a9-826d-ce56caf01c52@arm.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 17 Apr 2024 11:15:38 +0800
Message-ID: <CAEEQ3w=W+xLGP3WsyAQmRNaHm1xVRtqcGJ+t0TnZvJdCTR4v6w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, john.garry@huawei.com, 
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, sudeep.holla@arm.com, 
	tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

On Wed, Apr 17, 2024 at 4:04=E2=80=AFAM Jeremy Linton <jeremy.linton@arm.co=
m> wrote:
>
> Hi,
>
>
> On 4/15/24 22:14, Yunhui Cui wrote:
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
> >   arch/riscv/kernel/cacheinfo.c | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinf=
o.c
> > index 30a6878287ad..dc5fb70362f1 100644
> > --- a/arch/riscv/kernel/cacheinfo.c
> > +++ b/arch/riscv/kernel/cacheinfo.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/cpu.h>
> >   #include <linux/of.h>
> >   #include <asm/cacheinfo.h>
> > +#include <linux/acpi.h>
> >
> >   static struct riscv_cacheinfo_ops *rv_cache_ops;
> >
> > @@ -78,6 +79,25 @@ int populate_cache_leaves(unsigned int cpu)
> >       struct device_node *prev =3D NULL;
> >       int levels =3D 1, level =3D 1;
> >
> > +     if (!acpi_disabled) {
> > +             int ret, idx, fw_levels, split_levels;
> > +
> > +             ret =3D acpi_get_cache_info(cpu, &fw_levels, &split_level=
s);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             for (idx =3D 0; level <=3D this_cpu_ci->num_levels &&
> > +                  idx < this_cpu_ci->num_leaves; idx++, level++) {
>
> AFAIK the purpose of idx here it to assure that the number of cache
> leaves is not overflowing. But right below we are utilizing two of them
> at once, so this check isn't correct. OTOH, since its allocated as
> levels + split_levels I don't think its actually possible for this to
> cause a problem. Might be worthwhile to just hoist it before the loop
> and revalidate the total leaves about to be utilized.
>

Do you mean to modify the logic as follows to make it more complete?
for (idx =3D 0; level <=3D this_cpu_ci->num_levels &&
      idx < this_cpu_ci->num_leaves; level++) {
        if (level <=3D split_levels) {
               ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
               idx++;
               ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
               idx++;
       } else {
               ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
               idx++;
      }
}


Thanks,
Yunhui

