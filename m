Return-Path: <linux-acpi+bounces-5010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6F8A4E6B
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 14:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE949280F1B
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A294467A1A;
	Mon, 15 Apr 2024 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ereQHwXE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF966B5E
	for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182634; cv=none; b=QgQamE+KqI+YQpXb0qhlqTyxvq9AsRKKcG15EWkLCrOZXhKPtT2c+wuvKDaaK/5l9MQqKB0oQSgPkUoacwXXAzK6mEAkuBv3Jc28nzNoU7nu6qpdykTHW0lyAhTSLyZ1ky3cZMXlFofQJDh49eYZSDM70KzXkF8BbPEO6/rXPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182634; c=relaxed/simple;
	bh=XUdYqSmwVovBEI2SpQ5+Es9BsdYiZplIxqYD7Dd9rUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OH6bzndXzO2x6BWlXj8YPG/k1qeATSQw5BA/nyJ0+BI3K/+JwmAnChsjXvncmUGp7DRiAoAaUIjiYtaQ+Dpg6sZyysvudy24ijTuQ0gxzuIS/rxwkFYpPheIT1uQxy6FddezTsiiEsUfxqFLB2Tj5ybWUaSg24CP/fMiHIsZ2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ereQHwXE; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23335730db1so1902347fac.2
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 05:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713182630; x=1713787430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUM9SS9JNPHB2GD0yvR5K/5tFBuL0BhdH0M+pWpbQJA=;
        b=ereQHwXEWrlqFaVW5w9wnlvTObVZGGEY4MEJIa0J9co40F022QSKULc5iNhC+GDEzy
         KMUgMTSTdPI6gNpsaOwb/siNe1/NXhdDmuyzmU1V98y6D04rtgxQNFnbxQzYn8Y01Sm0
         srpCZWI2rSZNWDAveRsWQH5jMNDZcYw2uSvHcRvxpwYsDw2GrQtsEFcVSyDLqj4UIQX2
         /Z/DbBwa9mkRpTabX+WdPfXmKn/IqjcHa94wwsn5jv3Iex/ZM/y/Nbl7vwcA+T9j2WcH
         89TDkSF9HO8I3Aj9/5fjIRgJ0/u6J36bvE0ATdtuZqEX8SE3P7RT94ZGIu5Qrdud/Koi
         HAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713182630; x=1713787430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUM9SS9JNPHB2GD0yvR5K/5tFBuL0BhdH0M+pWpbQJA=;
        b=EUByQsI0dhQq1XRXB5XhHi0nTPf3HfdJwUsJLN2slToGustqu5Q/w0kq4vD5HNj9xY
         7WDYoMQL2ug0PkS7k6EbuA5Kdao0f2L4hWreKFeyptmJ+V6b/cOE0FgVoTl3DFKL6PXS
         jaBYhJjfXVPB6Lc020bNQBpvIhr57EFaW0JwlfkIkqzlDFacjR6yjp98wobgRxpzRzB4
         wfDUD9Heo/6/h1Kvy0tZM3RfHpwbIiGBffycjKV3qv3pWXOD4yQ/b8UmH8Ub1k0wNPNt
         znDvT0lnC9kn7wVDYiVznL3ppmTiBgsC7q43r71sYAjol7Bf9cBbMi4a05Eq9NjqfczT
         oCfg==
X-Forwarded-Encrypted: i=1; AJvYcCXEHTY0ejTGro/1X+/Uoes/9LPC6Nih6vnajk1fp4m2va78noOjUE4UhLBWkhEukIFe9GAkeErrUYg3/oUxu8BzwpqOr/ET5fZETQ==
X-Gm-Message-State: AOJu0YxKs93k4ma+JY5N2vVaevRfQT9wpFu6haI1tQVEFhh+joaaHhvs
	4Pd9jfiFpsmujoLq1rqPGsVTDeWNyqjoZbFP1CISRpMGjMKMutCRb9tQTlmMjAoroFExsFBtm6i
	CmGpKxE5j314tNwi4iPL6ALXrJsswtz04CSLNlA==
X-Google-Smtp-Source: AGHT+IF+ysnzqvijegluvjiwQKxRcx13O9ZDpCztSQtH8QXKxsIagGyKK5PKiNKWo1TCoNguxXwOTSWqBx38mQ3RLEE=
X-Received: by 2002:a05:6871:28a9:b0:220:8bd2:cd09 with SMTP id
 bq41-20020a05687128a900b002208bd2cd09mr12160806oac.32.1713182629917; Mon, 15
 Apr 2024 05:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414025826.64025-1-cuiyunhui@bytedance.com>
 <20240414025826.64025-2-cuiyunhui@bytedance.com> <Zhzo_gWFiURs_geD@bogus>
In-Reply-To: <Zhzo_gWFiURs_geD@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 15 Apr 2024 20:03:38 +0800
Message-ID: <CAEEQ3wkzvOpahzPuoD7=aMG3srjdyCA21tnh-j9PvY3Qerk_hg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/3] riscv: cacheinfo: initialize
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

Hi Sudeep,

On Mon, Apr 15, 2024 at 4:45=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Sun, Apr 14, 2024 at 10:58:25AM +0800, Yunhui Cui wrote:
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
> >  arch/riscv/kernel/cacheinfo.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinf=
o.c
> > index 30a6878287ad..ece92aa404e3 100644
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
> > @@ -78,6 +79,28 @@ int populate_cache_leaves(unsigned int cpu)
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
> > +             /* must be set, so we can drop num_leaves assignment belo=
w */
>
> I intentionally added this above comment to check and drop the below stat=
ement
> if it is already set. Please check if the value is already set when we ca=
ll
> into this function(which I think is the case).
>
> > +             this_cpu_ci->num_leaves =3D fw_levels + split_levels;

Uh,got it. I understand that there is no need to add this line:
"this_cpu_ci->num_leaves =3D fw_levels + split_levels; " , because in
the Master core first it will:
smp_prepare_cpus
     ->init_cpu_topology
          ->for_each_possible_cpu(cpu) {
                 fetch_cache_info(cpu); //num_leaves and num_levels will be=
 set
Then store_cpu_topology->update_siblings_masks->detect_cache_attributes->po=
pulate_cache_leaves().

Slave core will follow the logic of smp_callin->store_cpu_topology().
It's the same after I tested it, so I plan to remove that line and
update V3, what do you think?

Thanks,
Yunhui

