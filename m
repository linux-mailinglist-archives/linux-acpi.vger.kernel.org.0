Return-Path: <linux-acpi+bounces-17096-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E691BB8221A
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 00:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD5A3BB94A
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 22:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700BD28B407;
	Wed, 17 Sep 2025 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQpR0Z7q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73802820B7
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147356; cv=none; b=segaXcYMPE+rF86rFePLZyBT+4cxAacD7qqkj4aHdK12Sz8mgT5EVfIDfhSFoflQ3fEg5pWrk+U0ultNoAEaUAztPvMPzI0AWikO6W/AYsHn/INZoo8kIHGYYa1CXWT1NMoDU3OuZivQCDe7L/j0J60e62fHuIRm2kq6V9c4r+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147356; c=relaxed/simple;
	bh=Kd9UGKeQ1gYpGY/Nhf4uQCQ+fFAnl1+Ce2pz+iw3ShI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N48UBG0R8jOQPRYDP4Zxs7DzGGdv74Q2C9ZQdDhvAhN5nL3q25ZRqq6qtqPEA+lZaLn1/4hFhCYwdRmeJZLzeULqKE1U07aF2wOd0E/xXN4E/prr/S3AY/ajiKQDnBGuILrkNzY7N+A31/4Jswydao9nd/1JkSeS0HOVpbIb7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQpR0Z7q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f30011eceso12785e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758147353; x=1758752153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p4ncEV/0Oe5T32Jx5hlprtEOLrd/1ewkvxiGL3vw0c=;
        b=BQpR0Z7qp1dbuQ0hwtjW+YEh67E4ir9mX8LKgw3ZtqZxOQyR0zMR1VGvczXhk8NXPB
         bFKEGEEIacBv27NmS+oUUdGFR21akiwXj1j937IGHrsW8L1QLJNm/J343Y9iJZ1HF8vH
         lFB/Y++NgNCVx+IclVLmef0aButZMoFmvbMVP0VMB0Xr5AAbFnjxqC37M9HyzJfJ5twB
         50b/3UHcAenuwa10gaSfWnA5KXyKLN9WoLD9GrijgZRVplpCrsRHISADc0Hmr0a97uMW
         dc0dmdUkt6e/pwsqh3xGJeeGlqbyLHjXfvzwfbRTDa3IIoh4Eo89dqhN3x/NQWgu62GK
         wZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758147353; x=1758752153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1p4ncEV/0Oe5T32Jx5hlprtEOLrd/1ewkvxiGL3vw0c=;
        b=WJ65nesrFn7G+YDb39BEbet88uQ8Bmse4ipYMtyHZ/p2qebjRF4KbU7SnjVb0ypQ6E
         Avw5tK4/aZTcswBE4T3Mgrk3ksw4jt4kQqKlVC95GrROtOvBDVbYcrN9fdeaOPTCu+q+
         bT2zhc7Ah60zx34urUScnlFoK85LNOqDBLSy+1E2YHfjWzt+uShHEfZCaHAlYXGIUVEZ
         TKQSDDex2S0vQPunUHbEk9dTuX8mzJ8ABURRwdb1OP/btsRO32zIuyL2Z4SObupaGrmW
         0hChh47vdWK3b0Xuk2JqSmu9PGGEWKljQQGi/gAevMHSj2pdzoseGE2KTmEM3QsJxv+u
         GaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsyhWLx5DyQAEWfsohtI+r/TI9k7wek6OHM/tqMt0FxCE13cmaRcnXQrN5RgEg2evrNh+gGB/FYaIT@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBTBNTBN3UwqWPZ+skwmFpUcASErL4hHA617szRlTMUQGlyWd
	jfHDL3enGst9m8NLpWs/QVdkxteYDbgd0oCspeftJ0D4tFRBxQybQa0psh1ASpv2WOnv/V1tMIs
	WOsVdH2PXu032POxIW8JizssVYMghWrIo66SRj8PO
X-Gm-Gg: ASbGnct4ndNOiqnLJn3Bp3P/Jp3pHbfTi0zvS+awiWG53li0iVhnzYEcgVg8ynu4Bgg
	HseQCtFKzAVWa4hmR9xNS14PpucKkIVIAIemMl+fvDAjBGm86zYcVhw3laLTVElRqOV+AFyf7JL
	2+9aA5XlWxwJOxKOggR3+9yNS/Zu4zPSWbbGlU4FYypjKu6V3UHWtWPHGHMKVdj3eILkZmhp13m
	+xeRame7N1Hc52cQ8KjorurDEAmswI83jsEH5k05ytwYChH7xS24p7KKefvYT0=
X-Google-Smtp-Source: AGHT+IETa168RMgXYCyuMbREDGOaHVmJadjLDpn2kmhrTSuNtoIw5sYpaUJCBGdkIQavpq6g1JLeI6FZ1TdA3bdskYU=
X-Received: by 2002:a05:600c:3f0e:b0:45f:2e6d:c9ee with SMTP id
 5b1f17b1804b1-4615364d0efmr2582795e9.6.1758147352822; Wed, 17 Sep 2025
 15:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMiu_Uku6Y5ZbuhM@hpe.com> <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
 <8c3188da-7078-4099-973a-1d0d74db2720@redhat.com> <aMsDJ3EU1zVJ00cX@hpe.com>
 <cd71fac2-bb9d-4e84-a074-2b695654e655@redhat.com> <CACw3F52p45t3iSZPjx_Lq9kBn1ZGTDZsxk+iQ-xFA1zdvdqqrw@mail.gmail.com>
 <aMsR4Tr9ov1pfucC@agluck-desk3> <aMsqdesM1ImJp1yt@hpe.com>
In-Reply-To: <aMsqdesM1ImJp1yt@hpe.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 17 Sep 2025 15:15:41 -0700
X-Gm-Features: AS18NWB0Be2bZgwB40bum70rJy1DrSew59KlnBWueOxwtEk5FxFH7XCa5Jb7Kdo
Message-ID: <CACw3F51w=HfA1no7BqpaKX4ta+O6KAwp8NnRMdePc7wFW1yQmA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, David Hildenbrand <david@redhat.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org, corbet@lwn.net, 
	linmiaohe@huawei.com, shuah@kernel.org, jane.chu@oracle.com, 
	Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz, 
	joel.granados@kernel.org, laoar.shao@gmail.com, lorenzo.stoakes@oracle.com, 
	mclapinski@google.com, mhocko@suse.com, nao.horiguchi@gmail.com, 
	osalvador@suse.de, rafael.j.wysocki@intel.com, rppt@kernel.org, 
	russ.anderson@hpe.com, shawn.fan@intel.com, surenb@google.com, vbabka@suse.cz, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:39=E2=80=AFPM Kyle Meyer <kyle.meyer@hpe.com> wro=
te:
>
> On Wed, Sep 17, 2025 at 12:54:09PM -0700, Luck, Tony wrote:
> > On Wed, Sep 17, 2025 at 12:32:47PM -0700, Jiaqi Yan wrote:
> > > +1. Given /proc/sys/vm/enable_soft_offline is extensible, I would
> > > prefer a compact userspace API.
> > >
> > > > would create a new file, and the file has weird semantics such that=
 it
> > > > has no meaning when enable_soft_offline=3D0.
> >
> > So the expand the bitmask idea from earlier in this thread?
> >
> > Bit0  0 =3D soft offline disabled. 1 =3D Enabled (but see other bits)
> > Bit1  0 =3D allow offline of 4K pages, 1 =3D suppress 4K offline
> > Bit2  0 =3D allow offline of hugetlb, 1 =3D suppress hugetlb offline
> > Bit3  0 =3D allow breakup of transparent huge pages to just offline 4K,=
 1 =3D suppress transparent breakup
> > Bit4+ Reserved for suppressing other page types we invent in the future
> >
> > Values 0 and 1 keep their original meaning.
> >
> > Value 5 means: offline 4K, keep hugetlb, breakup transparent huge pages=
.
>
> Do you happen to have any use cases or reasoning for why someone might wa=
nt
> to disable soft offline for 4K pages or transparent huge pages? I'd like =
to
> understand the motivation for adding the extra bits.

Not sure if making sense, but something I can think of are: one may
really not want performance impact as THP will be split, THP and 4K
pages will be migrated, and even wildly willing to defragment with 4K
pages with corrected errors?

>
> Thanks,
> Kyle Meyer

