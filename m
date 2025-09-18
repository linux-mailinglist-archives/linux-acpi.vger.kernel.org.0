Return-Path: <linux-acpi+bounces-17099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E1B82C5F
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 05:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAE83AFD0A
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 03:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40291F099C;
	Thu, 18 Sep 2025 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uEAPl0RM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06D1C84D7
	for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166797; cv=none; b=oWT+c7eDR/R5eWOlRFHELSGTX3Oq32xOIL9jBLCQ0TSS8w9gEiifEm6HBpMCP2vd6HHwJaXmGjAzKq6MsJoZeM0/NZoPmCNf5Zd7CYn1pvuiAiRsb6kyWu517r+WlHwh3l1Dd+KFMt6XUWBpml3SiAp5zqGito71L/vZJO71zNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166797; c=relaxed/simple;
	bh=Vhft+mRHQjr5AUo5l+BmuxQym7Hro4224axumB/k2Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7NzLe0PNf5I8KcNxXQcZe0TmkXTJDhldGphyU8UjW9fCliqyUKuUjSmdWgmKKCRhxLMnk+ORiyX5dEg8jseHV6AeHe0Ur2dEYsU3pCmjdtxpEuFh1oHHGPL3zTyf0yM5tUZkUNEKKJylihI6/RTjPbR18Zk0iXP9A2H3TN+tEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uEAPl0RM; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758166786; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xYVy/gmUNLATO0N4l/CoYAjcvd2P1j3UppG+aVdlgxg=;
	b=uEAPl0RM9X1CS00QTa2VDHoerdAOSvGdyawmn2kPDIcBSr6OnAw0aPxURjZQV3yqMppKNToFAr12Hy65xjz8p7GRzXaVVfaZbFexRmUeY9ITsQoP07et5ly+Sw1L5ZJ4dSce7qNHZni2ev0aKoUhNdGDzNbIaAAucsAN7XkNWzY=
Received: from 30.246.178.33(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoEX-ch_1758166783 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 11:39:44 +0800
Message-ID: <7d3cc42c-f1ef-4f28-985e-3a5e4011c585@linux.alibaba.com>
Date: Thu, 18 Sep 2025 11:39:43 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
To: Kyle Meyer <kyle.meyer@hpe.com>, Jiaqi Yan <jiaqiyan@google.com>
Cc: jane.chu@oracle.com, "Luck, Tony" <tony.luck@intel.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, surenb@google.com,
 "Anderson, Russ" <russ.anderson@hpe.com>, rppt@kernel.org,
 osalvador@suse.de, nao.horiguchi@gmail.com, mhocko@suse.com,
 lorenzo.stoakes@oracle.com, linmiaohe@huawei.com, david@redhat.com,
 bp@alien8.de, akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz,
 linux-acpi@vger.kernel.org, Shawn Fan <shawn.fan@intel.com>
References: <20250904155720.22149-1-tony.luck@intel.com>
 <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3>
 <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
 <aLspJ5Tpqp4qRDk2@agluck-desk3>
 <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
 <CACw3F538k+dshTs1_rxbpYoRdFyX3tLYzfaWj-_d7Lq5Dd2Jsg@mail.gmail.com>
 <aL8rIgSImDh7Nj7E@hpe.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aL8rIgSImDh7Nj7E@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/9 03:14, Kyle Meyer 写道:> On Fri, Sep 05, 2025 at 12:59:00PM -0700, Jiaqi Yan wrote:
 >> On Fri, Sep 5, 2025 at 12:39 PM <jane.chu@oracle.com> wrote:
 >>>
 >>>
 >>> On 9/5/2025 11:17 AM, Luck, Tony wrote:
 >>>> BIOS can supply a GHES error record that reports that the corrected
 >>>> error threshold has been exceeded. Linux will attempt to soft offline
 >>>> the page in response.
 >>>>
 >>>> But "exceeded threshold" has many interpretations. Some BIOS versions
 >>>> accumulate error counts per-rank, and then report threshold exceeded
 >>>> when the number of errors crosses a threshold for the rank. Taking
 >>>> a page offline in this case is unlikely to solve any problems. But
 >>>> losing a 4KB page will have little impact on the overall system.

Hi, Tony,

Thank you for your detailed explanation. I believe this is exactly the problem
we're encountering in our production environment.

As you mentioned, memory access is typically interleaved between channels. When
the per-rank threshold is exceeded, soft-offlining the last accessed address
seems unreasonable - regardless of whether it's a 4KB page or a huge page. The
error accumulation happens at the rank level, but the action is taken on a
specific page that happened to trigger the threshold, which doesn't address the
underlying issue.

I'm curious about the intended use case for the CPER_SEC_ERROR_THRESHOLD_EXCEEDED
flag. What scenario was Intel BIOS expecting the OS to handle when this flag is set?
Is there a specific interpretation of "threshold exceeded" that would make
page-level offline action meaningful? If not, how about disabling soft offline from
GHES and leave that to userspace tools like rasdaemon (mcelog) ?

 >>
 >> Hi Tony,
 >>
 >> This is exactly the problem I encountered [1], and I agree with Jane
 >> that disabling soft offline via /proc/sys/vm/enable_soft_offline
 >> should work for your case.
 >>
 >> [1] https://lore.kernel.org/all/20240628205958.2845610-3-jiaqiyan@google.com/T/#me8ff6bc901037e853d61d85d96aa3642cbd93b86
 >
 > If that doesn't work for your case, I just want to mention that hugepages might
 > still be soft offlined with that check in ghes_handle_memory_failure().
 >
 >>>>
 >>>> On the other hand, taking a huge page offline will have significant
 >>>> impact (and still not solve any problems).
 >>>>
 >>>> Check if the GHES record refers to a huge page. Skip the offline
 >>>> process if the page is huge.
 >
 > AFAICT, we're still notifying the MCE decoder chain and CEC will soft offline
 > the hugepage once the "action threshold" is reached.
 >
 > This could be moved to soft_offline_page(). That would prevent other sources
 > (/sys/devices/system/memory/soft_offline_page, CEC, etc.) from being able to
 > soft offline hugepages, not just GHES.
 >
 >>>> Reported-by: Shawn Fan <shawn.fan@intel.com>
 >>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
 >>>> ---
 >>>>
 >>>> Change since v2:
 >>>>
 >>>> Me: Add sanity check on the address (pfn) that BIOS provided. It might
 >>>> be in some reserved area that doesn't have a "struct page" which would
 >>>> likely result in an OOPs if fed to pfn_folio().
 >>>>
 >>>> The original code relied on sanity check of the pfn received from the
 >>>> BIOS when this eventually feeds into memory_failure(). That used to
 >>>> result in:
 >>>>        pr_err("%#lx: memory outside kernel control\n", pfn);
 >>>> which won't happen with this change, since memory_failure is not
 >>>> called. Was that a useful message? A Google search mostly shows
 >>>> references to the code. There are few instances of people reporting
 >>>> they saw this message.
 >>>>
 >>>>
 >>>>    drivers/acpi/apei/ghes.c | 13 +++++++++++--
 >>>>    1 file changed, 11 insertions(+), 2 deletions(-)
 >>>>
 >>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
 >>>> index a0d54993edb3..c2fc1196438c 100644
 >>>> --- a/drivers/acpi/apei/ghes.c
 >>>> +++ b/drivers/acpi/apei/ghes.c
 >>>> @@ -540,8 +540,17 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 >>>>
 >>>>        /* iff following two events can be handled properly by now */
 >>>>        if (sec_sev == GHES_SEV_CORRECTED &&
 >>>> -         (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
 >>>> -             flags = MF_SOFT_OFFLINE;
 >>>> +         (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED)) {
 >>>> +             unsigned long pfn = PHYS_PFN(mem_err->physical_addr);
 >>>> +
 >>>> +             if (pfn_valid(pfn)) {
 >>>> +                     struct folio *folio = pfn_folio(pfn);
 >>>> +
 >>>> +                     /* Only try to offline non-huge pages */
 >>>> +                     if (!folio_test_hugetlb(folio))
 >>>> +                             flags = MF_SOFT_OFFLINE;
 >>>> +             }
 >>>> +     }
 >>>>        if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
 >>>>                flags = sync ? MF_ACTION_REQUIRED : 0;
 >>>>
 >>>
 >>> So the issue is the result of inaccurate MCA record about per rank CE
 >>> threshold being crossed. If OS offline the indicted page, it might be
 >>> signaled to offline another 4K page in the same rank upon access.
 >>>
 >>> Both MCA and offline-op are performance hitter, and as argued by this
 >>> patch, offline doesn't help except loosing a already corrected page.
 >>>
 >>> Here we choose to bypass hugetlb page simply because it's huge.  Is it
 >>> possible to argue that because the page is huge, it's less likely to get
 >>> another MCA on another page from the same rank?
 >>>
 >>> A while back this patch
 >>> 56374430c5dfc mm/memory-failure: userspace controls soft-offlining pages
 >>> has provided userspace control over whether to soft offline, could it be
 >>> a more preferable option?
 >
 > Optionally, a 3rd setting could be added to /proc/sys/vm/enable_soft_offline:
 >
 > 0: Soft offline is disabled.
 > 1: Soft offline is enabled for normal pages (skip hugepages).
 > 2: Soft offline is enabled for normal pages and hugepages.
 >

I prefer having soft-offline fully controlled by userspace, especially
for DPDK-style applications. These applications use hugepage mappings and maintain
their own VA-to-PA mappings. When the kernel migrates a hugepage to a new physical
page during soft-offline, DPDK continues accessing the old physical address,
leading to data corruption or access errors.

For such use cases, the application needs to be aware of and handle memory errors
itself. The kernel performing automatic page migration breaks the assumptions these
applications make about stable physical addresses.
Thanks.
Shuai

