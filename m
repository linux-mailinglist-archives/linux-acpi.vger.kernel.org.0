Return-Path: <linux-acpi+bounces-20412-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E2D38B53
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jan 2026 02:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 463EB303698E
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jan 2026 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4588726E6E8;
	Sat, 17 Jan 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5USWxNM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB019CD1D
	for <linux-acpi@vger.kernel.org>; Sat, 17 Jan 2026 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768614402; cv=pass; b=RQAXVYNNg20QJzKMXXrQy7DQlR1dkZ2pobCqPTYW4eH1bpoOLPJm5ZpihbeMrL1jGobMzLN7TG24yhbI+j8o3kZrSm7wBtOFir7x4nsvFcGJKOApxNzDN34Z8u75sEsT6nwcz6P0umKnu9pFczLQJIpVeO5qJqGigHz1FEFnwfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768614402; c=relaxed/simple;
	bh=rhGlXDGJVZh//kyAHEA9D+kTdWvg73LAXj19n+HVlEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsuQjEa7HhBVwM+AqZpg9QtGiXzbGnea9ehVH5mCIZgs6mTW7ZTcwoJnidEM1E0CMNCAoMGGForyLljCVTj3X5EBqros+tm/pj2YyGXo7dyEmPSz01L4TriGq0kDvOVuHCwOzg4/A6MQ7P/Dwbd2Rtk4HnezC8i64KtKgncouMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5USWxNM; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801cf7c2c7so11015e9.1
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jan 2026 17:46:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768614399; cv=none;
        d=google.com; s=arc-20240605;
        b=fFmf/mmaphaf0JhvMxI77v4db/fQOZiXceP1ZjkqvhEEF46n6gOC77X5qhNlslmqKm
         tucIGxGceLaXI5DgbiIAct6IuyjoEXMvP7uZ4va2C1k1Wk/wRkDgZNW0occQZvqH0GHU
         I+bkot7gTkkRaycN9g/J8vZw292RebKNNNF8Lb44oixU+OvpGS4ZxlcB5XRwgKml5c2T
         id4o6Da3fr2DgjHEgnTGk7wuriidJsG50RNIuSIupEJitgQVE0QNpF+LBKD3F4StQ20v
         zsYDOD/YJMEoHlBC/cuXLeVQoTXVKRAwWk9872aeoTRYXlK2fXwF1cS81nXbmH67LoXG
         Wb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QawnIC/rKqzEiT5sLO4diiV4bNp94xP9Rmr2Cmn3G2E=;
        fh=kx+twgjIxRyUbc+06c+QNMSeqX1/IkGWC7IsaRKsHXs=;
        b=MaZYQTCx4pNI0RSgFXlg/Sbx+D7mj+AqDM2m9+g/cZ+pEwaFS1IY0P3z2A2p4nF62W
         jO8oDHbKlkWYS/X+NoewscKmlbh0irlDMvXsLJFzn7GvreMfAUek4z3beQUINDkTIOhU
         0eXixJJ+OCgodjFYqzxu3I/4StabijOKQJlUG0xSpUJmBGJyv7JPWoAyCwOrNunAFeLE
         lo2e87Ag+r/YfVyZ/mlblaQ9IbxIxJtCEkAHW4+QVxCr0ZdhaQ2M6FpACqsbQ2bh/6TE
         GQWaoUlvWkfhRmTh5t8jVuRX3cvNIrvF1N8yZdS9hsCGxUgjyjxtOG84NId7N0MO+jK0
         GmXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768614399; x=1769219199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QawnIC/rKqzEiT5sLO4diiV4bNp94xP9Rmr2Cmn3G2E=;
        b=g5USWxNMS63TEdPoBmHk5Y9sNP1mQqE6FqRIGQY32DTaKWxT6qH5b4PU8OyMgLPjdX
         AcvSbirMGeMdGbtaBcwz+m3KOajUrj1SD/a6/nMT4fuCVQunvq2nJqF0aObUJ3U+nj5R
         0VYUAqGc4Hx81h3h8oZTQc6U11NOTHmMImSb+8JdHt6uP+v6Xv6znaeRktTYRxV9iEd1
         GQP9Bq+vtXVG6b9kiuDAVCvfGgzKKWuHOLpaNK44LeIpugi70fZwj+PSmZrZh64HXRhR
         xD/gsgyS81bxJxn6pS/er1v930grEDNZ7fvU6ro7WY3/gHwFeU5Zet2nlYaTEjGs+UtE
         CPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768614399; x=1769219199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QawnIC/rKqzEiT5sLO4diiV4bNp94xP9Rmr2Cmn3G2E=;
        b=xBfaN24Topn5pexQacjrQFNtdgDMb0EL+VqBSpuQHwwCf8k2Df16aQJ9SqKXAjKewh
         1u84uZeI+1wM7pDI9itXj1bFf5pxhV9U0qLJ4QPCh9jTVDaIyPTor0/nZBeL5LlvMHmK
         GAPykEk9slqlxHq0sss28/PMHZpMNVUAFz8j/uNdT2JhHv8LGBaUABfx//A7JaGGJzbd
         FpiqbqtyPGb4EpoKejYBXH7rCeXwbmpTd78+bsDWzupus80Ms3ccV/Q1bdNDS/e+pehb
         aGRlvNlnL/kyyC8/le3xuWYFG7ztvWqVGdYmLNqdVfAUtNgHK2R9ZdTW2A4CJnim/c4s
         A2tA==
X-Forwarded-Encrypted: i=1; AJvYcCVz1gQG/lJI1bzDK+MwT3WISS51/Wh3VTAKedsWa0PauEp8Ltb3eElba8evcEkr55gAKN8DfoUu6sVa@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPNGkbR2dDtixOgawjFI21DqlDJ41XhQMHakV8P5qYzqS/R0U
	BAr2i2V9ZVBrC45Zr/hcchqRnwwiNPXMqLlF+qJrtrrgTnZh+EBOb4O9ZY6rOVVVt2/B/9wFtXt
	hTM+NA1i71z2naoEMNYHC60psSHdfMcL7zlWQmABV
X-Gm-Gg: AY/fxX5bUiJxlgjKVzpBsJC3ZQOcncsk8MhM7ceOQ64R6+XX+6U9I6G47XcQW0T/nc4
	EetZRtoFZHKD4u4cXoYcv2qY2WZAKGacqN0sIXOxKx6cK019dZhUsjvnE9rVReCI7L5ss379EJE
	A0QE0oyBTgPYKlrAWFkBclxL0RBI4xRcxLpxNxuWIN2Quq2AfjK4tN7AJjhdV7c/owJRE554zzS
	2+c+tzAfa5H/DJAtuMCSBGxybB5CIKDX8nFbruopELYHUkbCby5GAne/bmvAotoTm+TPlw23eBm
	k7PRWDVcMDw7LYF9Pqk2HzmPVw==
X-Received: by 2002:a05:600c:2159:b0:47d:7428:d00c with SMTP id
 5b1f17b1804b1-4802831ff1bmr125265e9.17.1768614398594; Fri, 16 Jan 2026
 17:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102184434.2406-1-ankita@nvidia.com>
In-Reply-To: <20251102184434.2406-1-ankita@nvidia.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 16 Jan 2026 17:46:27 -0800
X-Gm-Features: AZwV_QgWqDDKvf2998qT7WGKusfsVNwwlVxtPgQtBBUSk5Pxl571jMObyaPcU9E
Message-ID: <CACw3F51k=sFtXB1JE3HCcXP6EA0Tt4Yf44VUi3JLz0bgW-aArQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: Implement ECC handling for pfn with no struct page
To: ankita@nvidia.com
Cc: aniketa@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com, mochs@nvidia.com, 
	skolothumtho@nvidia.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
	akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, tony.luck@intel.com, bp@alien8.de, rafael@kernel.org, 
	guohanjun@huawei.com, mchehab@kernel.org, lenb@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, cjia@nvidia.com, kwankhede@nvidia.com, 
	targupta@nvidia.com, zhiw@nvidia.com, dnigam@nvidia.com, kjaju@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-edac@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com, 
	Smita.KoralahalliChannabasappa@amd.com, u.kleine-koenig@baylibre.com, 
	peterz@infradead.org, linux-acpi@vger.kernel.org, kvm@vger.kernel.org, 
	Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 10:45=E2=80=AFAM <ankita@nvidia.com> wrote:
>
> From: Ankit Agrawal <ankita@nvidia.com>
>
> Poison (or ECC) errors can be very common on a large size cluster.
> The kernel MM currently handles ECC errors / poison only on memory page
> backed by struct page. The handling is currently missing for the PFNMAP
> memory that does not have struct pages. The series adds such support.
>
> Implement a new ECC handling for memory without struct pages. Kernel MM
> expose registration APIs to allow modules that are managing the device
> to register its device memory region. MM then tracks such regions using
> interval tree.
>
> The mechanism is largely similar to that of ECC on pfn with struct pages.
> If there is an ECC error on a pfn, all the mapping to it are identified
> and a SIGBUS is sent to the user space processes owning those mappings.
> Note that there is one primary difference versus the handling of the
> poison on struct pages, which is to skip unmapping to the faulty PFN.
> This is done to handle the huge PFNMAP support added recently [1] that
> enables VM_PFNMAP vmas to map at PMD or PUD level. A poison to a PFN
> mapped in such as way would need breaking the PMD/PUD mapping into PTEs
> that will get mirrored into the S2. This can greatly increase the cost
> of table walks and have a major performance impact.
>
> nvgrace-gpu-vfio-pci module maps the device memory to user VA (Qemu) usin=
g
> remap_pfn_range without being added to the kernel [2]. These device memor=
y
> PFNs are not backed by struct page. So make nvgrace-gpu-vfio-pci module
> make use of the mechanism to get poison handling support on the device
> memory.
>
> Patch rebased to v6.17-rc7.
>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>
> Link: https://lore.kernel.org/all/20251026141919.2261-1-ankita@nvidia.com=
/ [v4]
>
> v4 -> v5
> - Removed pfn_space NULL checks. Instead a wrong parameter would cause
> a panic. (Thanks Andrew Morton for suggestion)
> - Log message to mention kmalloc allocation error and the failure to
> kill a process. (Thanks Andrew Morton)
> - Comments with 80 chars.
>
> v3 -> v4
> - Added guards in memory_failure_pfn, register, unregister function to
> simplify code. (Thanks Ira Weiny for suggestion).
> - Collected reviewed-by from Shuai Xue (Thanks!) on the mm GHES patch. Al=
so
> moved it to the front of the series.
> - Added check for interval_tree_iter_first before removing the device
> memory region. (Thanks Jiaqi Yan for suggestion)
> - If pfn doesn't belong to any address space mapping, returning
> MF_IGNORED (Thanks Miaohe Lin for suggestion).
> - Updated patch commit to add more details on the perf impact on
> HUGE PFNMAP (Thanks Jason Gunthorpe, Tony Luck for suggestion).
>
> v2 -> v3
> - Rebased to v6.17-rc7.
> - Skipped the unmapping of PFNMAP during reception of poison. Suggested b=
y
> Jason Gunthorpe, Jiaqi Yan, Vikram Sethi (Thanks!)
> - Updated the check to prevent multiple registration to the same PFN
> range using interval_tree_iter_first. Thanks Shameer Kolothum for the
> suggestion.
> - Removed the callback function in the nvgrace-gpu requiring tracking of
> poisoned PFN as it isn't required anymore.

Hi Ankit,

I get that for nvgrace-gpu driver, you removed pfn_address_space_ops
because there is no need to unmap poisoned HBM page.

What about the nvgrace-egm driver? Now that you removed the
pfn_address_space_ops callback from pfn_address_space in [1], how can
nvgrace-egm driver know the poisoned EGM pages at runtime?

I expect the functionality to return retired pages should also include
runtime poisoned pages, which are not in the list queried from
egm-retired-pages-data-base during initialization. Or maybe my
expection is wrong/obsolete?

[1] https://lore.kernel.org/linux-mm/20230920140210.12663-2-ankita@nvidia.c=
om
[2] https://lore.kernel.org/kvm/20250904040828.319452-12-ankita@nvidia.com

> - Introduced seperate collect_procs_pfn function to collect the list of
> processes mapping to the poisoned PFN.
>
> v1 -> v2
> - Change poisoned page tracking from bitmap to hashtable.
> - Addressed miscellaneous comments in v1.
>
> Link: https://lore.kernel.org/all/20240826204353.2228736-1-peterx@redhat.=
com/ [1]
> Link: https://lore.kernel.org/all/20240220115055.23546-1-ankita@nvidia.co=
m/ [2]
>
> Ankit Agrawal (3):
>   mm: Change ghes code to allow poison of non-struct pfn
>   mm: handle poisoning of pfn without struct pages
>   vfio/nvgrace-gpu: register device memory for poison handling
>
>  MAINTAINERS                         |   1 +
>  drivers/acpi/apei/ghes.c            |   6 --
>  drivers/vfio/pci/nvgrace-gpu/main.c |  45 ++++++++-
>  include/linux/memory-failure.h      |  17 ++++
>  include/linux/mm.h                  |   1 +
>  include/ras/ras_event.h             |   1 +
>  mm/Kconfig                          |   1 +
>  mm/memory-failure.c                 | 145 +++++++++++++++++++++++++++-
>  8 files changed, 209 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/memory-failure.h
>
> --
> 2.34.1
>
>

