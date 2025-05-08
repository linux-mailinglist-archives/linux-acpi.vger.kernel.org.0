Return-Path: <linux-acpi+bounces-13625-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D19AAF0C4
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 03:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1D43B9E7B
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 01:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4CF1B4F0A;
	Thu,  8 May 2025 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir0v+EGN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26EA28F4;
	Thu,  8 May 2025 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746669304; cv=none; b=Br4yWxiBi7ZfitlakjzXia2DoLTMHaAbmh6ulXhruyGMKbbgULyiFqQ7aRfWQAquQELE2LURIgJyl0m0AvxgJgeQzGdxf+czjOVG67ik7SMnqQb62cED+4jg2R3PBTrrbXQulSgVA1Gi9TRNB545HdUsAWoFVLmWkLWUOukjan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746669304; c=relaxed/simple;
	bh=dl8wVcGUAen/exJkdPhBaHcEBBDlS+cM57wzUTccp/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZgixBVwcpHAltLBNmiiQkbpCQdmu69TxXgIK/gSSUx+yr53yWXsHuY2WmlQCGRA0qCyTZNZbtMgDLfKcLMeUEuKeXhhNPJanIWFkoPA7EEdQQkdvYrnKg2DUDjbeRkm3cWjZGwAnY6/lXVD3s1GFmqS/FBKOCysbvXjdNemhT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir0v+EGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8D8C4CEF2;
	Thu,  8 May 2025 01:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746669304;
	bh=dl8wVcGUAen/exJkdPhBaHcEBBDlS+cM57wzUTccp/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ir0v+EGNNOM175/+WThwrq1VBgBWFsncg+fy5aviD3XTcerNT16lJ70M430PCZYCK
	 rsQ4HerFdjcJOgZL+V3sEyglwIgYusbS+XGM2aTGRVmEpn/7HT5D3/CNNrqQW1gY4p
	 1wXecwUyG68wkFnvmXrBBsJFCbhR8lE00wh/5P7D+4a84rImtX+CAGzBQOh5J+fXpz
	 u/+0DJVakMyhWDERFOHnL3elX+RMFDncpVMUkdKI0DWsJkPWvLcP+Eahyzw5w9R47G
	 3V+oFY2RaXrr1YH84fEH5KElbZOFRPDfOQ05Mf5QR4xo/+G7ratnIxvAzSDe1FJQkS
	 kx8OFxk6AkFAQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso643855a12.1;
        Wed, 07 May 2025 18:55:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdLk+g+9ejL/dIOUfNxCPHwKpE7/latn9Q+aUQ2zLku9jm3pFZJZQZfrHpIVjx0k5iDqIe6lGbMiTq@vger.kernel.org, AJvYcCXBrVGdao9tjDvC6/fexOMrBPEKB4nVpjwrH3D5ZJZIxMvIusJOmsMqhOjRiSSkxs00H3/bS2gcKJsZ@vger.kernel.org, AJvYcCXixd2l5kb2v7dohG8nQJTYZgNu1PmNpKszX7oiioixDjzfFkRz/AV4bzl6dmSKT6lLLatmsxlwi6AfsYEk@vger.kernel.org
X-Gm-Message-State: AOJu0YzdGHfCqTp8NZEM14q3ln8oAjsPqqrqLif5YJGGs6Rytkvt5jpR
	pN90vJJ9PHlanSrFk8s0PwH2/AR6GoyxKYeVVNRmv8WKhT5rA0rfMrrV7ephE9U+aohASJMKLw7
	HREGvigOg+nHJuupwUsGZTpHGZsQ=
X-Google-Smtp-Source: AGHT+IEzDcJ6Nujut03djLclbitM7VBQzX0IBIyzj1ZBgppTbip23+rin6MUYH6E+Qcco7dc7IzqUs7M1xomeOXYdGk=
X-Received: by 2002:a05:6402:278f:b0:5f7:eafe:76d5 with SMTP id
 4fb4d7f45d1cf-5fbe9dcacd1mr4590146a12.8.1746669302688; Wed, 07 May 2025
 18:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506062245.3816791-1-wangyuquan1236@phytium.com.cn>
 <20250507172436.00003888@huawei.com> <aBwNGG2hLMZBO0mh@phytium.com.cn>
In-Reply-To: <aBwNGG2hLMZBO0mh@phytium.com.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 8 May 2025 09:54:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6nnTNhKNq2FY-7hmX8NmGQW_S0=-_fmZiSdfuZ3EGnfQ@mail.gmail.com>
X-Gm-Features: ATxdqUE3P4RAx1nfYhEUwbSeEb96FNfeucjUlb2LWwN0o3G9NpKb3XLjAO5Afs8
Message-ID: <CAAhV-H6nnTNhKNq2FY-7hmX8NmGQW_S0=-_fmZiSdfuZ3EGnfQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com, rppt@kernel.org, 
	rafael@kernel.org, lenb@kernel.org, akpm@linux-foundation.org, 
	alison.schofield@intel.com, rrichter@amd.com, bfaccini@nvidia.com, 
	haibo1.xu@intel.com, david@redhat.com, linux-cxl@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 9:47=E2=80=AFAM Yuquan Wang
<wangyuquan1236@phytium.com.cn> wrote:
>
> On Wed, May 07, 2025 at 05:24:36PM +0100, Jonathan Cameron wrote:
> > On Tue, 6 May 2025 14:22:45 +0800
> > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> >
> > > acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> > > with the expectation that numa_cleanup_meminfo moves them to
> > > numa_reserved_meminfo. There is no need for that indirection when it =
is
> > > known in advance that these unpopulated ranges are meant for
> > > numa_reserved_meminfo in support of future hotplug / CXL provisioning=
.
> > >
> > > Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
> > > ranges directly.
> > >
> > > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > This is v2 take 2.  There were tags on the previous version (pre longar=
ch
> > change).
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > (Also Dan Williams).
> >
> > Easiest option when this happens is spin a v3 with a change log to
> > say the loongarch issue is resolved and you picked up tags.
> >
> Hi Jonathan,
>
> Thanks for your tips. Would this v2 version trigger the kernel test
> robot? It seems like only a new version of patch would trigger that.
> I would publish v3 of this patch as soon as possible.

The kernel test robot operates on linux-next, so there's probably no errors=
 now.

Huacai

>
> Yuquan
> >
> > > ---
> > >
> > > Changes in v2 (Thanks to Dan & Alison):
> > > - Use numa_add_reserved_memblk() to replace numa_add_memblk() in acpi=
_parse_cfmws()
> > > - Add comments to describe the usage of numa_add_reserved_memblk()
> > > - Updating the commit message to clarify the purpose of the patch
> > >
> > > By the way, "LoongArch: Introduce the numa_memblks conversion" is in =
linux-next.
> > >
> > >  drivers/acpi/numa/srat.c     |  2 +-
> > >  include/linux/numa_memblks.h |  1 +
> > >  mm/numa_memblks.c            | 22 ++++++++++++++++++++++
> > >  3 files changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > index 0a725e46d017..751774f0b4e5 100644
> > > --- a/drivers/acpi/numa/srat.c
> > > +++ b/drivers/acpi/numa/srat.c
> > > @@ -453,7 +453,7 @@ static int __init acpi_parse_cfmws(union acpi_sub=
table_headers *header,
> > >             return -EINVAL;
> > >     }
> > >
> > > -   if (numa_add_memblk(node, start, end) < 0) {
> > > +   if (numa_add_reserved_memblk(node, start, end) < 0) {
> > >             /* CXL driver must handle the NUMA_NO_NODE case */
> > >             pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %=
d [mem %#llx-%#llx]\n",
> > >                     node, start, end);
> > > diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblk=
s.h
> > > index dd85613cdd86..991076cba7c5 100644
> > > --- a/include/linux/numa_memblks.h
> > > +++ b/include/linux/numa_memblks.h
> > > @@ -22,6 +22,7 @@ struct numa_meminfo {
> > >  };
> > >
> > >  int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > > +int __init numa_add_reserved_memblk(int nid, u64 start, u64 end);
> > >  void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi=
);
> > >
> > >  int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
> > > diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> > > index ff4054f4334d..541a99c4071a 100644
> > > --- a/mm/numa_memblks.c
> > > +++ b/mm/numa_memblks.c
> > > @@ -200,6 +200,28 @@ int __init numa_add_memblk(int nid, u64 start, u=
64 end)
> > >     return numa_add_memblk_to(nid, start, end, &numa_meminfo);
> > >  }
> > >
> > > +/**
> > > + * numa_add_reserved_memblk - Add one numa_memblk to numa_reserved_m=
eminfo
> > > + * @nid: NUMA node ID of the new memblk
> > > + * @start: Start address of the new memblk
> > > + * @end: End address of the new memblk
> > > + *
> > > + * Add a new memblk to the numa_reserved_meminfo.
> > > + *
> > > + * Usage Case: numa_cleanup_meminfo() reconciles all numa_memblk ins=
tances
> > > + * against memblock_type information and moves any that intersect re=
served
> > > + * ranges to numa_reserved_meminfo. However, when that information i=
s known
> > > + * ahead of time, we use numa_add_reserved_memblk() to add the numa_=
memblk
> > > + * to numa_reserved_meminfo directly.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, -errno on failure.
> > > + */
> > > +int __init numa_add_reserved_memblk(int nid, u64 start, u64 end)
> > > +{
> > > +   return numa_add_memblk_to(nid, start, end, &numa_reserved_meminfo=
);
> > > +}
> > > +
> > >  /**
> > >   * numa_cleanup_meminfo - Cleanup a numa_meminfo
> > >   * @mi: numa_meminfo to clean up
> >
>

