Return-Path: <linux-acpi+bounces-16590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C62B51E17
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 18:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E7D3B74C1
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC9527815B;
	Wed, 10 Sep 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqv5MW5b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AC2727E7
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522681; cv=none; b=MVx1K8BUCqW5+CI129rP9EqPlv+aVN0uYc93k5x+rLIuFkUQ8RDaWqq+Jf/II7kh5FwwUtJqpzh9gGgzfZzogcaJEOocFVPOBwGhiywjo1me5anDkgEHaKS8nsNUKsYEUCozGAeyhf7iuhIGuPzJ+EceA9saZM/kYeFBQIF0PvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522681; c=relaxed/simple;
	bh=2nLvrFeT0eNyx6VObrrBKPVue1n9P/pv5TjzXIGVUY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsQi05Drn2aKhCBPwbcH8ks/gw+k+dmDnvKhPFDBbw0UYMXM0Tb5HI48/AzpbPb2hTISJYQIVxNg5g10y3F4rSodfGRxLtQWVz1pB8OMJGRY6sDnSPcPakYohP6RPwR15dMAIytdOcJ0GVKrofZ1A5osCAbolWs0I+Qqkzzz9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqv5MW5b; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de54bfc36so1385e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757522677; x=1758127477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8djFOJ+gM1iYSlPzwE6pCiywCzk1B+3Ytmse7uaXQ0=;
        b=bqv5MW5bdpOV17ImcMPJioshxne46wOQ8NxMVmDbU/WXVupH4rAuKjOJ4cVwmt+RhN
         OgP1b1DTYp4qHcFFgg8phXAQ0RFv6+zSVdwvngT5+7n0rRUvWKyqmzxncVLUTJ8H1QEf
         sr/gHqBhmyRskp0nF/WDwB6toWg5BPsLKenA0qrfNX/czJzyj+VuV/c17XquAU9Sf6/z
         iSG+QUD3bVHfMVxXOx0lAD9kBvClqcyleAM+VbCtaFwBAEnAbe+cknjts40Nb1JUODkZ
         k97pXHHm7NpKZTl0gsEuTPWMUQUu6+N7UhATd9H82dJuIcIeHUBoQ8QZcCDmD1BShJE+
         mPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522677; x=1758127477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8djFOJ+gM1iYSlPzwE6pCiywCzk1B+3Ytmse7uaXQ0=;
        b=arVxOKJCQUWGGRGY1RgxX03mgdEuRoXyVfCDF3ZeDkNTYsFv3+4rnirX30AdY4T6nZ
         j5f0ceRaSTaVld9KLOu0Cb55RU35V0407eH9xrnKqICEU7w5J95dLrtqC1xW3zBQBoFT
         9YS7SMUqxWhXboBLjLTUX8b1f/dhdASbo2Dl4JdOPUeNptgNHlBzjH35CYkPiC/5LGZx
         P9N00f866p32UBQ1EhgJplW9s/+vnTbjYGlmymgm7ZAT57/oySeAB91FWthCilt2Nk3G
         tuWa8kMuqTmg2FhdzZABFfG1ugkzfgaaSYbpogvD/9Gfd8ZtPIEwaKF2zNwcmPXSWmul
         tcng==
X-Forwarded-Encrypted: i=1; AJvYcCVc7YtZZlSJyOuyRUU549iYqPojDT80ceyUixWL4/qF6tkBVFAhQN8T0pPfJs4BDxATY6f7HgZgkZ9c@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw23fncRusjjxeYT3BAackXup2vcE/nwJM7Be6gGOnhbt672bo
	KriWlhOJYvsqbmWn9RtvO/zYYCcFnlJMvz2Be0C/MffTl7FW3kx8kyFvdKlBa6mx6EdnIZ+YVXX
	CbxtBsvyCxLBBdWN6yrgowP9xfDqVi1r9JnLZMgrj
X-Gm-Gg: ASbGncuZJ9DpVInH6DSLtyPsD6I4milvXUFu4AUXYb2kacnlX/7yHl1oEdYYMCsXNSM
	xibehaMWwSyVqJuZ/3+DUy/F6IpN3Lbqyc1QmD2HjHG4h0Pvzlxu0I3FG458Ao0Sr/dPuExlmxe
	L6ZVtTcH9NxqdANNGrVy5rzR4ac6DgT/s6JXFwQkBOC6YSIJvrBqVz3NvixJuZSH7atzhN3YPNo
	l8nfUv0eARuHSfgmcOaN1qx7lxdMJmpkFgK+95ZA2lh
X-Google-Smtp-Source: AGHT+IHCdi9zmwz6KoicCAR0Jv0+Vt/UGzR3h0GAFmH0mG+ENE/AB5F6T/JRMRgwDoGFU9ca4fFaXajfQ9zfPfYcnhA=
X-Received: by 2002:a05:600c:4ba8:b0:45b:74f7:9d30 with SMTP id
 5b1f17b1804b1-45df81fc22amr1324515e9.1.1757522676452; Wed, 10 Sep 2025
 09:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMGkAI3zKlVsO0S2@hpe.com>
In-Reply-To: <aMGkAI3zKlVsO0S2@hpe.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 10 Sep 2025 09:44:24 -0700
X-Gm-Features: AS18NWDIq2crh-gg2BM8GO2RnYKbsPnCvYRMI6YaiHazGhs_SQQK_MbAUFz62O0
Message-ID: <CACw3F50yTvMphcp111Qzh3PKm+FYoXX9g_sLpV5TPuubqK2+Qw@mail.gmail.com>
Subject: Re: [PATCH] mm/memory-failure: Disable soft offline for HugeTLB pages
 by default
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com, 
	linmiaohe@huawei.com, shuah@kernel.org, tony.luck@intel.com, 
	Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz, 
	jane.chu@oracle.com, joel.granados@kernel.org, laoar.shao@gmail.com, 
	lorenzo.stoakes@oracle.com, mclapinski@google.com, mhocko@suse.com, 
	nao.horiguchi@gmail.com, osalvador@suse.de, rafael.j.wysocki@intel.com, 
	rppt@kernel.org, russ.anderson@hpe.com, shawn.fan@intel.com, 
	surenb@google.com, vbabka@suse.cz, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 9:16=E2=80=AFAM Kyle Meyer <kyle.meyer@hpe.com> wro=
te:
>
> Soft offlining a HugeTLB page reduces the available HugeTLB page pool.
> Since HugeTLB pages are preallocated, reducing the available HugeTLB
> page pool can cause allocation failures.
>
> /proc/sys/vm/enable_soft_offline provides a sysctl interface to
> disable/enable soft offline:
>
> 0 - Soft offline is disabled.
> 1 - Soft offline is enabled.
>
> The current sysctl interface does not distinguish between HugeTLB pages
> and other page types.
>
> Disable soft offline for HugeTLB pages by default (1) and extend the
> sysctl interface to preserve existing behavior (2):
>
> 0 - Soft offline is disabled.
> 1 - Soft offline is enabled (excluding HugeTLB pages).
> 2 - Soft offline is enabled (including HugeTLB pages).
>
> Update documentation for the sysctl interface, reference the sysctl
> interface in the sysfs ABI documentation, and update HugeTLB soft
> offline selftests.
>
> Reported-by: Shawn Fan <shawn.fan@intel.com>
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>
> Tony's original patch disabled soft offline for HugeTLB pages when
> a correctable memory error reported via GHES (with "error threshold
> exceeded" set) happened to be on a HugeTLB page:
>
> https://lore.kernel.org/all/20250904155720.22149-1-tony.luck@intel.com
>
> This patch disables soft offline for HugeTLB pages by default
> (not just from GHES).
>
> ---
>  .../ABI/testing/sysfs-memory-page-offline     |  6 ++++
>  Documentation/admin-guide/sysctl/vm.rst       | 18 ++++++++---
>  mm/memory-failure.c                           | 21 ++++++++++--
>  .../selftests/mm/hugetlb-soft-offline.c       | 32 +++++++++++++------
>  4 files changed, 60 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-memory-page-offline b/Docume=
ntation/ABI/testing/sysfs-memory-page-offline
> index 00f4e35f916f..befb89ae39ec 100644
> --- a/Documentation/ABI/testing/sysfs-memory-page-offline
> +++ b/Documentation/ABI/testing/sysfs-memory-page-offline
> @@ -20,6 +20,12 @@ Description:
>                 number, or a error when the offlining failed.  Reading
>                 the file is not allowed.
>
> +               Soft-offline can be disabled/enabled via sysctl:
> +               /proc/sys/vm/enable_soft_offline
> +
> +               For details, see:
> +               Documentation/admin-guide/sysctl/vm.rst
> +
>  What:          /sys/devices/system/memory/hard_offline_page
>  Date:          Sep 2009
>  KernelVersion: 2.6.33
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admi=
n-guide/sysctl/vm.rst
> index 4d71211fdad8..ae56372bd604 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -309,19 +309,29 @@ physical memory) vs performance / capacity implicat=
ions in transparent and
>  HugeTLB cases.
>
>  For all architectures, enable_soft_offline controls whether to soft offl=
ine
> -memory pages.  When set to 1, kernel attempts to soft offline the pages
> -whenever it thinks needed.  When set to 0, kernel returns EOPNOTSUPP to
> -the request to soft offline the pages.  Its default value is 1.
> +memory pages:
> +
> +- 0: Soft offline is disabled.
> +- 1: Soft offline is enabled (excluding HugeTLB pages).
> +- 2: Soft offline is enabled (including HugeTLB pages).

Would it be better to keep/inherit the previous documented behavior "1
- Soft offline is enabled (no matter what type of the page is)"? Thus
it will have no impact to users that are very nervous about corrected
memory errors and willing to lose hugetlb page. Something like:

  enum soft_offline {
      SOFT_OFFLINE_DISABLED =3D 0,
      SOFT_OFFLINE_ENABLED,
      SOFT_OFFLINE_ENABLED_SKIP_HUGETLB,
      // SOFT_OFFLINE_ENABLED_SKIP_XXX...
  };

> +
> +The default is 1.
> +
> +If soft offline is disabled for the requested page type, EOPNOTSUPP is r=
eturned.
>
>  It is worth mentioning that after setting enable_soft_offline to 0, the
>  following requests to soft offline pages will not be performed:
>
> +- Request to soft offline from sysfs (soft_offline_page).
> +
>  - Request to soft offline pages from RAS Correctable Errors Collector.
>
> -- On ARM, the request to soft offline pages from GHES driver.
> +- On ARM and X86, the request to soft offline pages from GHES driver.
>
>  - On PARISC, the request to soft offline pages from Page Deallocation Ta=
ble.
>
> +Note: Soft offlining a HugeTLB page reduces the HugeTLB page pool.
> +
>  extfrag_threshold
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc30ca4804bf..cb59a99b48c5 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -64,11 +64,18 @@
>  #include "internal.h"
>  #include "ras/ras_event.h"
>
> +enum soft_offline {
> +       SOFT_OFFLINE_DISABLED =3D 0,
> +       SOFT_OFFLINE_ENABLED_SKIP_HUGETLB,
> +       SOFT_OFFLINE_ENABLED
> +};
> +
>  static int sysctl_memory_failure_early_kill __read_mostly;
>
>  static int sysctl_memory_failure_recovery __read_mostly =3D 1;
>
> -static int sysctl_enable_soft_offline __read_mostly =3D 1;
> +static int sysctl_enable_soft_offline __read_mostly =3D
> +       SOFT_OFFLINE_ENABLED_SKIP_HUGETLB;
>
>  atomic_long_t num_poisoned_pages __read_mostly =3D ATOMIC_LONG_INIT(0);
>
> @@ -150,7 +157,7 @@ static const struct ctl_table memory_failure_table[] =
=3D {
>                 .mode           =3D 0644,
>                 .proc_handler   =3D proc_dointvec_minmax,
>                 .extra1         =3D SYSCTL_ZERO,
> -               .extra2         =3D SYSCTL_ONE,
> +               .extra2         =3D SYSCTL_TWO,
>         }
>  };
>
> @@ -2799,12 +2806,20 @@ int soft_offline_page(unsigned long pfn, int flag=
s)
>                 return -EIO;
>         }
>
> -       if (!sysctl_enable_soft_offline) {
> +       if (sysctl_enable_soft_offline =3D=3D SOFT_OFFLINE_DISABLED) {
>                 pr_info_once("disabled by /proc/sys/vm/enable_soft_offlin=
e\n");
>                 put_ref_page(pfn, flags);
>                 return -EOPNOTSUPP;
>         }
>
> +       if (sysctl_enable_soft_offline =3D=3D SOFT_OFFLINE_ENABLED_SKIP_H=
UGETLB) {
> +               if (folio_test_hugetlb(pfn_folio(pfn))) {
> +                       pr_info_once("disabled for HugeTLB pages by /proc=
/sys/vm/enable_soft_offline\n");
> +                       put_ref_page(pfn, flags);
> +                       return -EOPNOTSUPP;
> +               }
> +       }
> +
>         mutex_lock(&mf_mutex);
>
>         if (PageHWPoison(page)) {
> diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/te=
sting/selftests/mm/hugetlb-soft-offline.c
> index f086f0e04756..7e2873cd0a6d 100644
> --- a/tools/testing/selftests/mm/hugetlb-soft-offline.c
> +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> @@ -1,10 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Test soft offline behavior for HugeTLB pages:
> - * - if enable_soft_offline =3D 0, hugepages should stay intact and soft
> - *   offlining failed with EOPNOTSUPP.
> - * - if enable_soft_offline =3D 1, a hugepage should be dissolved and
> - *   nr_hugepages/free_hugepages should be reduced by 1.
> + *
> + * - if enable_soft_offline =3D 0 (SOFT_OFFLINE_DISABLED), HugeTLB pages
> + *   should stay intact and soft offlining failed with EOPNOTSUPP.
> + *
> + * - if enable_soft_offline =3D 1 (SOFT_OFFLINE_ENABLED_SKIP_HUGETLB), H=
ugeTLB pages
> + *   should stay intact and soft offlining failed with EOPNOTSUPP.
> + *
> + * - if enable_soft_offline =3D 2 (SOFT_OFFLINE_ENABLED), a HugeTLB page=
 should be
> + *   dissolved and nr_hugepages/free_hugepages should be reduced by 1.
>   *
>   * Before running, make sure more than 2 hugepages of default_hugepagesz
>   * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048kB:
> @@ -32,6 +37,12 @@
>
>  #define EPREFIX " !!! "
>
> +enum soft_offline {
> +       SOFT_OFFLINE_DISABLED =3D 0,
> +       SOFT_OFFLINE_ENABLED_SKIP_HUGETLB,
> +       SOFT_OFFLINE_ENABLED
> +};
> +
>  static int do_soft_offline(int fd, size_t len, int expect_errno)
>  {
>         char *filemap =3D NULL;
> @@ -83,7 +94,7 @@ static int set_enable_soft_offline(int value)
>         char cmd[256] =3D {0};
>         FILE *cmdfile =3D NULL;
>
> -       if (value !=3D 0 && value !=3D 1)
> +       if (value < SOFT_OFFLINE_DISABLED || value > SOFT_OFFLINE_ENABLED=
)
>                 return -EINVAL;
>
>         sprintf(cmd, "echo %d > /proc/sys/vm/enable_soft_offline", value)=
;
> @@ -155,7 +166,7 @@ static int create_hugetlbfs_file(struct statfs *file_=
stat)
>  static void test_soft_offline_common(int enable_soft_offline)
>  {
>         int fd;
> -       int expect_errno =3D enable_soft_offline ? 0 : EOPNOTSUPP;
> +       int expect_errno =3D (enable_soft_offline =3D=3D SOFT_OFFLINE_ENA=
BLED) ? 0 : EOPNOTSUPP;
>         struct statfs file_stat;
>         unsigned long hugepagesize_kb =3D 0;
>         unsigned long nr_hugepages_before =3D 0;
> @@ -198,7 +209,7 @@ static void test_soft_offline_common(int enable_soft_=
offline)
>         // No need for the hugetlbfs file from now on.
>         close(fd);
>
> -       if (enable_soft_offline) {
> +       if (enable_soft_offline =3D=3D SOFT_OFFLINE_ENABLED) {
>                 if (nr_hugepages_before !=3D nr_hugepages_after + 1) {
>                         ksft_test_result_fail("MADV_SOFT_OFFLINE should r=
educed 1 hugepage\n");
>                         return;
> @@ -219,10 +230,11 @@ static void test_soft_offline_common(int enable_sof=
t_offline)
>  int main(int argc, char **argv)
>  {
>         ksft_print_header();
> -       ksft_set_plan(2);
> +       ksft_set_plan(3);
>
> -       test_soft_offline_common(1);
> -       test_soft_offline_common(0);
> +       test_soft_offline_common(SOFT_OFFLINE_ENABLED);
> +       test_soft_offline_common(SOFT_OFFLINE_ENABLED_SKIP_HUGETLB);
> +       test_soft_offline_common(SOFT_OFFLINE_DISABLED);

Thanks for updating the test code! Looks good to me.

>
>         ksft_finished();
>  }
> --
> 2.51.0
>

