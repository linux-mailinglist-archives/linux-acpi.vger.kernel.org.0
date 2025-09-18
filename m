Return-Path: <linux-acpi+bounces-17108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F082B85C8D
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079397C1FEF
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 15:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A67831328D;
	Thu, 18 Sep 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+XB7tk1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50E312806
	for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210524; cv=none; b=frkvZDq1IJBqHnoOdoxGSkSMln3ljVTecr0AUszdmnjXzp/jAg7ddf4GXC8Z5E6ZsPUIeKHEONfiNPp6h78+cmufYRn8BsCYjYDpkhzoVcoEHp038rp3aba6V9lJ3KtrGiOFdyd8+RgvD1QRe+a+kjneY9wIxU6FB8SWeOxdkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210524; c=relaxed/simple;
	bh=bCfTUdZSKE/5xKZe/8DKJsQNVTMwQpu6YamEXF4M22g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSZDt2B4ajm83EIlcgw4+bECauDv7FTPEPsPOdu/GunL7sYyu5AaVE/PFy1sRS8REwJ6mIWhOnHgv1JiUUh08vS3lor75ulwHKj2iHlPGZhTrG2X+AGM3flNOjUtaSZARabdPO3GkioDGar7obAQBUyOYKNXCVwSYSkHX0u4j0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+XB7tk1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f30011eceso77865e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210521; x=1758815321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rx16FrktF4Q4jtrgrrHA5a6Ai0Ce3s0txUm84e73Hw=;
        b=G+XB7tk1ftPiL5CvwfE+NVRrWzxdK9U1rm/GGn+dCaITmvXAb/GSfWHgk5VGBnfuwI
         uwXrTDjolpMwb/z450MNxhnz1lmckI6e85q0Oa3UjR2CVfdum8UW3xLMBBkMtc/2WrH/
         xGZBm39hL2VaT/Wb8O2uKBGFX2iykjJ3StNSY+DVOI2fjRQoQG5SXFgnDa97FzMDUGls
         R2TVCAAo6GkKI1/omstMzH5h5aFYorEfxO7GvpB1sGU/6gLeazib+xpk7oIiqzTeSoTy
         9JAY9vfhxJWtl3gK6lSYJiHJfDMgUL3jteXObWGtLY22te8stW4JgfT360cSaVrtpqHH
         p1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210521; x=1758815321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rx16FrktF4Q4jtrgrrHA5a6Ai0Ce3s0txUm84e73Hw=;
        b=WT4eyQa2uQ+P9CLNp8NAwKx/GjFF/2Rc/mgExAsPVd9f/T2wdPdNCh91xwm3kgVelg
         UhDM2K7uRVjnbqTw2mJZkrejFApnbII0vBJ8qpeuWv3aZDEwHuKMDT5Vf+6b9TpDVM4s
         kB4o04il18zY5S5Bhx8xmkNsamqEduQE1qZlFcfSUln43IFh6hy6m1M/MC9dTQKo5sGe
         plgOUnrAPxRLA1KbzqEhcWxMqA4YUsOqv8YCN3sEg9Ir4yI8AzRdf4frvbre5rMlHE+7
         DGbAVqgfB7XJzJQehrUYzbzLfoE58v+MLzCtdunyBj1jJPjbUIJdFOn+bIRaVuLaxlVj
         2G2g==
X-Forwarded-Encrypted: i=1; AJvYcCXuGOxkphOVDbKbiSy7rncHwY5MG/zB5K8Vkat3yv8Lj6kj5D1mBOL21ga31AmNprjHJWimfHteWB0s@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ir9KEnb5wvMUd3l2MIqgvOXnOE1kVXviGuf/W1dpSNZVFKhZ
	qj/c3JvYh7WRnZwYCdWAUa7i7pWR1scdU991uRHECMn9Gy1znoIuRpdyZYOOLd2bLS9UcOYsjT4
	J05vKFF7/JpbDYcCNFmgfIbRCN24Ycglk4uPJ8b7H
X-Gm-Gg: ASbGncsxbRjn2ltDg0zvKME6gCIYbjh/6FOGk1B8CvygIqIu7gpdj7gUQez7JB6Rea7
	Z638VPRfh9KS27dMPNdmYi9fO41kbxokHXfTO+QKGlUH70BwvTx6wLnsw7GQYOKGcileXed9aCi
	ho/HI0r8NO/6/RQ5riJvkc8R8gGgLvSlXXssOHtGY0eFxOOvO2bhi5Q/sbrPAGE67cYSzhoJt4I
	onng3BvhCCIOEyzWC87DyBhv40qLt/lPKV8/8ePkLISWAhLEbBsNrVvJWHvaqNsLw==
X-Google-Smtp-Source: AGHT+IEn14QDHuxEiqb1VXaCf6P34UADIYCw+R0AK6s/lF2DWM9aPjYC73nNm/t1rUXn6RFFu321KBvFpJntXFLW+cw=
X-Received: by 2002:a05:600c:8a09:10b0:45f:2940:d194 with SMTP id
 5b1f17b1804b1-4614faff8e6mr2807655e9.2.1758210520602; Thu, 18 Sep 2025
 08:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMiu_Uku6Y5ZbuhM@hpe.com> <20250915201618.7d9d294a6b22e0f71540884b@linux-foundation.org>
 <aMkOCmGBhZKhKPrI@hpe.com> <SJ1PR11MB60831F028E2FEB6B5A3390D9FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aMmlhPghbpnlCZ09@hpe.com> <SJ1PR11MB60833884799B6AA2BC18ECE7FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <LV4PR11MB9513A6EFA88B082E554CB8D6EB17A@LV4PR11MB9513.namprd11.prod.outlook.com>
 <aMsE9XjWKEYTIQyV@hpe.com> <1211fd9a-93e6-4ebe-a80d-083601138b70@linux.alibaba.com>
In-Reply-To: <1211fd9a-93e6-4ebe-a80d-083601138b70@linux.alibaba.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 18 Sep 2025 08:48:29 -0700
X-Gm-Features: AS18NWCH3-wHHtOkOjDEZ08ReQ721l4iWXSb56ihFpAN8Dh9hynFjggen97xtxQ
Message-ID: <CACw3F53=9+rSdUt7yqTz=GineyRxJf1FBgXQ4omYvFkwFDqZQA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Kyle Meyer <kyle.meyer@hpe.com>, "Fan, Shawn" <shawn.fan@intel.com>, 
	"Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"corbet@lwn.net" <corbet@lwn.net>, "david@redhat.com" <david@redhat.com>, 
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"jane.chu@oracle.com" <jane.chu@oracle.com>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"bp@alien8.de" <bp@alien8.de>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "jack@suse.cz" <jack@suse.cz>, 
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "laoar.shao@gmail.com" <laoar.shao@gmail.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"mclapinski@google.com" <mclapinski@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "osalvador@suse.de" <osalvador@suse.de>, 
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "rppt@kernel.org" <rppt@kernel.org>, 
	"Anderson, Russ" <russ.anderson@hpe.com>, "surenb@google.com" <surenb@google.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:34=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/9/18 02:59, Kyle Meyer =E5=86=99=E9=81=93:
> > On Wed, Sep 17, 2025 at 06:35:14AM +0000, Fan, Shawn wrote:
> >>>> My original patch for this just skipped the GHES->offline process
> >>>> for huge pages. But I wasn't aware of the sysctl control. That provi=
des
> >>>> a better solution.
> >>>
> >>> Tony, does that mean you're OK with using the existing sysctl interfa=
ce? If
> >>> so, I'll just send a separate patch to update the sysfs-memory-page-o=
ffline
> >>> documentation and drop the rest.
> >>
> >> Kyle,
> >>
> >> It depends on which camp the external customer that reported this
> >> falls into:
> >>
> >> 1) "I'm OK disabling all soft offline requests".
> >>
> >> or the:
> >>
> >> 2) "I'd like 4K pages to still go offline if the BIOS asks, just not a=
ny huge pages".
> >>
> >> Shawn: Can you please find out?
> >>
> >>
> >> -> Prefer the 2nd option,  "4K pages still go offline if the BIOS asks=
, just not any huge pages."
> >
> > OK, thank you.
> >
> > Does that mean they want to avoid offlining transparent huge pages as w=
ell?
> >
> > Thanks,
> > Kyle Meyer
>
>
> Hi, Shawn,
>
> As memory access is typically interleaved between channels. When the
> per-rank threshold is exceeded, soft-offlining the last accessed address
> seems unreasonable - regardless of whether it's a 4KB page or a huge
> page. The error accumulation happens at the rank level, but the action
> is taken on a specific page that happened to trigger the threshold,
> which doesn't address the underlying issue.

Does it mean the soft offline action taken by the kernel is almost
useless from hw's PoV? Or, the current signals/info about the
corrected errors kernel get from firmware are insufficient to make the
kernel do anything meaningful?

>
> I prefer the first option that disabling all soft offline requests from
> GHES driver.
>
> Thanks.
> Shuai

