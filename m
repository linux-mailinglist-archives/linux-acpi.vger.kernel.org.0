Return-Path: <linux-acpi+bounces-16575-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE62BB51670
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 14:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B5D7ACD94
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BAB31B83D;
	Wed, 10 Sep 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rsexfsst"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E14331B835
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505700; cv=none; b=TwWNb9Wdb2OBbBUJlkY/cHaafXSr3O3QTnvRj/678l3YVUpY4i+j5A56vIL0hePNE9QB66EZla3+vhGgg0OX5WTCksXC/zYhBKKFf2Lehkwl6q359M4ao4JUQwAQ0PFgWB+iEjaxD+ysmAbViZavQPz0L6F1zCbsLrAJGDTBL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505700; c=relaxed/simple;
	bh=q7q78drzXiKAUcp4TX10uJS3Ui+QbaBZIzkWxDYUaSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOfUZxm2gm4lTH9ZrqS7kftxfLh8tKQzZWJLAI1piZ7WMr1M0JvSSagPoCn1JMR/WzMK4gii6LSLoCw4jQwRm9jSQ5SrxwofuApKiin4e47MJH30HHUzG6/QdhmStZERSA2n2Xic933nFkt9f4iC7dXBIrqjZx2qSdB3bC6XalQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rsexfsst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57C8C4CEF0
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757505699;
	bh=q7q78drzXiKAUcp4TX10uJS3Ui+QbaBZIzkWxDYUaSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rsexfsstohf0LMB4rNxHdL+d0SOwTlwX9w0Es+1u7a3oXFNrLU55nmw/psGdM2PG4
	 UyHapTdzCO17xBpUQrTgz9OYLsCIZ1mZOiIo1YVlrKRv3BNedCM95H0Cq0mCF+6Jeb
	 o8TzpQ6pEBR2YQcgvTIdv2ei3FMVyITT4MvBhciY0dbbNOBy5rsuKHdwJwDt0e2mDR
	 wrRbbIA4wx2rD36KXhQ0nWB+Y3MSzb/lhaecJwULKD1YJdzzGbgoI7NTKWY0yzhtmj
	 yA/llQl8Oaxb91hYZqY+pdOF5o7wHcue43/Vb1YgotVCzP5ulnHCc9yc0ODiAHi8wi
	 06DvBZ4yNftNA==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-746d5474a53so2264723a34.2
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 05:01:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrYS/hDc/4vXhtKEFrTCYnUYgJcOpjbtaquNvFjDbaiMMwS4SyP3z3X6QqmZtmseNqfer0tIFNhBGd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0Xii9l2bmTWP3eXMO2gy3ag8BT/kTpkKmqDcJE9ILZ/3lqD+
	w5VQDb0BBAeEUT1z3tOmwAIi0adaZ/0WFQXMJ430ZPIJRkSeEEaVZt0pLl1+VZxuRaIMuPyYX1y
	bmgsUOEM9ta/bxknNl8drrIB5gmzQ4P0=
X-Google-Smtp-Source: AGHT+IFrO/ARxn2+pn+H/jgdGSskG+5HqHzwzQA7Fcamf///NbmjsRp1nadipREjIcejf7Yv7LCCEAJMMm+0x5m/zs4=
X-Received: by 2002:a05:6830:370a:b0:73e:7f48:e6bc with SMTP id
 46e09a7af769-74c6f023596mr7471623a34.2.1757505694328; Wed, 10 Sep 2025
 05:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904155720.22149-1-tony.luck@intel.com> <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3> <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
 <aLspJ5Tpqp4qRDk2@agluck-desk3> <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
 <CACw3F538k+dshTs1_rxbpYoRdFyX3tLYzfaWj-_d7Lq5Dd2Jsg@mail.gmail.com>
 <aL8rIgSImDh7Nj7E@hpe.com> <aL82BsIJht3HIIS3@agluck-desk3>
In-Reply-To: <aL82BsIJht3HIIS3@agluck-desk3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 14:01:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hihNmnnB2x9q2JobGQJirmj0Q5oHFmKfOsqesjGvD4-A@mail.gmail.com>
X-Gm-Features: Ac12FXzERbz1mwe0hhW3ABLRaK1GOuCwiKZgFxzAjarjVxa6UFAJjjTQrUg5u8o
Message-ID: <CAJZ5v0hihNmnnB2x9q2JobGQJirmj0Q5oHFmKfOsqesjGvD4-A@mail.gmail.com>
Subject: Re: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Kyle Meyer <kyle.meyer@hpe.com>, Jiaqi Yan <jiaqiyan@google.com>, jane.chu@oracle.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, surenb@google.com, 
	"Anderson, Russ" <russ.anderson@hpe.com>, rppt@kernel.org, osalvador@suse.de, 
	nao.horiguchi@gmail.com, mhocko@suse.com, lorenzo.stoakes@oracle.com, 
	linmiaohe@huawei.com, david@redhat.com, bp@alien8.de, 
	akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz, 
	linux-acpi@vger.kernel.org, Shawn Fan <shawn.fan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Mon, Sep 8, 2025 at 10:01=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> On Mon, Sep 08, 2025 at 02:14:42PM -0500, Kyle Meyer wrote:
> > Optionally, a 3rd setting could be added to /proc/sys/vm/enable_soft_of=
fline:
> >
> > 0: Soft offline is disabled.
> > 1: Soft offline is enabled for normal pages (skip hugepages).
> > 2: Soft offline is enabled for normal pages and hugepages.
>
> Seems like a solid plan.
>
> Needs an update to Documentation/admin-guide/sysctl/vm.rst
> to match the new functionality and describe the reason that
> users might want to avoid taking huge pages offline.
>
> Also this line in existing text:
>
> - On ARM, the request to soft offline pages from GHES driver.
>
> should read:
>
> - On ARM and X86, the request to soft offline pages from GHES driver.
>
> >
> > Maybe something like...
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index fc30ca4804bf..efa535d405a8 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -64,11 +64,17 @@
> >  #include "internal.h"
> >  #include "ras/ras_event.h"
> >
> > +enum soft_offline {
> > +     SOFT_OFFLINE_DISABLED =3D 0,
> > +     SOFT_OFFLINE_ENABLED_SKIP_HUGEPAGES,
> > +     SOFT_OFFLINE_ENABLED
> > +};
> > +
> >  static int sysctl_memory_failure_early_kill __read_mostly;
> >
> >  static int sysctl_memory_failure_recovery __read_mostly =3D 1;
> > -static int sysctl_enable_soft_offline __read_mostly =3D 1;
> > +static int sysctl_enable_soft_offline __read_mostly =3D SOFT_OFFLINE_S=
KIP_HUGEPAGES;
>
> This is changing the default behavior (which allowed offline
> of huge pages). I'm in favor of the change. But you should call it
> out explicitly in the commit message when you write up a patch.
>
> >
> >  atomic_long_t num_poisoned_pages __read_mostly =3D ATOMIC_LONG_INIT(0)=
;
> >
> > @@ -150,7 +156,7 @@ static const struct ctl_table memory_failure_table[=
] =3D {
> >               .mode           =3D 0644,
> >               .proc_handler   =3D proc_dointvec_minmax,
> >               .extra1         =3D SYSCTL_ZERO,
> > -             .extra2         =3D SYSCTL_ONE,
> > +             .extra2         =3D SYSCTL_TWO,
> >       }
> >  };
> >
> > @@ -2799,12 +2805,20 @@ int soft_offline_page(unsigned long pfn, int fl=
ags)
> >               return -EIO;
> >       }
> >
> > -     if (!sysctl_enable_soft_offline) {
> > -             pr_info_once("disabled by /proc/sys/vm/enable_soft_offlin=
e\n");
> > +     if (sysctl_enable_soft_offline =3D=3D SOFT_OFFLINE_DISABLED) {
> > +             pr_info("disabled by /proc/sys/vm/enable_soft_offline\n")=
;
> >               put_ref_page(pfn, flags);
> >               return -EOPNOTSUPP;
> >       }
> >
> > +     if (sysctl_enable_soft_offline =3D=3D SOFT_OFFLINE_ENABLED_SKIP_H=
UGEPAGES) {
> > +             if (folio_test_hugetlb(pfn_folio(pfn))) {
> > +                     pr_info("disabled by /proc/sys/vm/enable_soft_off=
line\n");
> > +                     put_ref_page(pfn, flags);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +     }
> > +
> >       mutex_lock(&mf_mutex);
> >
> >       if (PageHWPoison(page)) {
> >
> > > > I don't know, the patch itself is fine, it's the issue that it has
> > > > exposed that is more concerning.

Is the $subject patch still relevant?

I gather from the conversation following it that it isn't.

