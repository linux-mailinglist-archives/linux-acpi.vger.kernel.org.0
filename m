Return-Path: <linux-acpi+bounces-5295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1F8AE352
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Apr 2024 13:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0641F220B4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Apr 2024 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5562757EE;
	Tue, 23 Apr 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WxBmPlUb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B376056
	for <linux-acpi@vger.kernel.org>; Tue, 23 Apr 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870234; cv=none; b=A14G1lc7d6KW/5zqV/3+ee2vPREqfai++/FuMwG08Sz2JhZzbPovXXwfcWGxCrd6RgMVIngs2lhC9O0PeqhQ1YoJUFXI2BtkW1ta8a8LDK3aGruRiKOevrGZItzIg9pgs5r4W3y6mr+qwv6Jw89s9G+v8gWW7mTVxv+k7Ocb9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870234; c=relaxed/simple;
	bh=VWztZ/fe4ofdzcdbmJNDnCpV52mg/oLbJuCfL9gqkkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uujIBSWYa1Y+5LhJa2FMbMfDQrJCUrF11Ei3VTNHmrNZrfSwdPkJ1L680EXkUvjXiZrpD0HpnIF0krwJz4o1Hhl0WOsciGjRN1xVJW2Egw96sOnsY/UVUEBAL5cgNHjLlfOGIuY8uleKq2oP/219c/Z5PyjpV3ZaYn1L9bCLQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WxBmPlUb; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ea0db2727bso2963334a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Apr 2024 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713870231; x=1714475031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcipzruX2A9Yhl78blb5w8gS3iCFD8VtiVRtnpWsvs4=;
        b=WxBmPlUbd23ljUFN/MNBxoXQDqTaM7c8N+NOmaYTneLHGxdpXVSEh1th3iEW7ey/Ah
         VZShX24+GOAU+q18hMmss9uCMD4lgAv2yVlshJWFgZP+86HuG9n9KGLBEaUAZ8kCud/D
         jRToRku32+FCHVk7xN/M4r7Ub0gfSvRRNGcszGYcbeupaE1LzYoZ98znxfG19eovkInP
         Ji6idO7PYimWcMvADFt2JQbx6qzLfYk3c/x0UkVo48ldgq/B04e/Mnow1T9gr2FAKVNK
         Ko3FWzSJeeVVv0+619PmYwFEnjrhAd5LiEgomvgpGba7BGi2b+10hjSEaS1ahqGpWHpJ
         Omqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870231; x=1714475031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcipzruX2A9Yhl78blb5w8gS3iCFD8VtiVRtnpWsvs4=;
        b=I+eAOWzuF5iy5ETJ2j5Le4WfA9RBfaFhAeRdhtj+lzqAwQCKM/sqi92dZ1X/stssiM
         tm+eIBI++ZCIhLeA+9ZV+AOcbqZPVjUWzoSzU37gfYX4EabWl38fLOhxvhkkYO3B8UD9
         F6J73Tyto+rxIAcmYMQQ5/La3+VyTSIw4oVqGs+hnsGmHZRNinhsBQBzT4NfNoeNkqOG
         rw5x5sc+AJYf7qL8sR31o4Xxa6idEYxeVenjxsabUwqDYDpjZ9oBEJEcapIu6Mn5lFaW
         kirmhImyafg7H/4sV1Uxlr7gEH5SoOjZEX/e0cmevfrNZEqcfwBVz1yOj9Ea10Bkzy1u
         mAAw==
X-Forwarded-Encrypted: i=1; AJvYcCWpv1W2XZ4ShLRf1uSElKH0tkbViJh3EXsH5N2amgtADWDnXgxEjqUUOrbFocVyYVGplbFRLIb10KlWgIjp4Ju3ZqqLdNA9zlddCw==
X-Gm-Message-State: AOJu0YxF0N8Zh8obqSld4wFTvB+VboudFavvPcoxwSlcIQPukc5qKs3C
	DqCVza0sIGyPyFGrsPHkIp/PvSAmLZ6HJtvl8LBvIyVuQ++tQwiN3fMul9T9XtrazSOc5t5xNJN
	sSqltCtvHJIy4Vf6/ftTlwjzdl5AdsBM8NyDeoA==
X-Google-Smtp-Source: AGHT+IFhGsfWfuGFv/LZLhvGKnt4RFHXPxHS5wX4JPzKOB99V9981I2BjbU0RZ8Sg5EH28NR6FPScsajfozyvhNOLIs=
X-Received: by 2002:a05:6870:55d2:b0:21e:a839:d807 with SMTP id
 qk18-20020a05687055d200b0021ea839d807mr16500749oac.54.1713870231186; Tue, 23
 Apr 2024 04:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com> <d143cd11-26ea-42e3-8f32-700a34b3705e@arm.com>
In-Reply-To: <d143cd11-26ea-42e3-8f32-700a34b3705e@arm.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 23 Apr 2024 19:03:40 +0800
Message-ID: <CAEEQ3wkDMuu+jh56YB3G0vY_ENdUjDL6byMsJXd0C9aQu1FZKw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, john.garry@huawei.com, 
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, sudeep.holla@arm.com, 
	tiantao6@huawei.com, Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

On Fri, Apr 19, 2024 at 11:29=E2=80=AFPM Jeremy Linton <jeremy.linton@arm.c=
om> wrote:
>
> Hi,
>
> On 4/17/24 22:43, Yunhui Cui wrote:
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
> >   arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinf=
o.c
> > index 30a6878287ad..e47a1e6bd3fe 100644
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
> >       if (of_property_read_bool(np, "cache-size"))
> >               ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> >       if (of_property_read_bool(np, "i-cache-size"))
>
> Yes, looks good.
>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
>
>
>
> Thanks,

Could you help review this patchset? Thanks.

Thanks,
Yunhui

