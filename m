Return-Path: <linux-acpi+bounces-16508-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36277B49A8A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56E53BA5B7
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3572D7D35;
	Mon,  8 Sep 2025 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="GN8GDlNl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DF2D6407
	for <linux-acpi@vger.kernel.org>; Mon,  8 Sep 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361626; cv=none; b=k66G3MZzV6aa6bGSAvlG06SGPXuUk3/eVzdIXt8ye1kQZRQChkhcv7rPcvDcr0zZGlBjGiGDyqHc1MY8l7JTmKBElLCVoqaAOJVvvpxxFynTkIZJgu2HyNsefB55fWlDLbOXem1AD5XvRaSjvuuiPZOBUp/a9HFwE1v2R/SOaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361626; c=relaxed/simple;
	bh=HbCu2jL5HruCBM3HpB7LbClkYM+jptIZUYXUXKNbbUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijPXLN3ICrytB/Sz4d4bh//VgvUhwlXUHIuppB99Rr96ukGBaSYf3iHHp11ecIxOho65+OJ+JWxq5ZfBhiRaYjd7gXWQH5O/HMjgwKHqJI+b+rKXefThilBQP3Ujb9/wC8Wxo1RMNUpVcgBB0P73qQybzFJupUTtFYbzfhx0lNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=GN8GDlNl; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588I2wxm007907;
	Mon, 8 Sep 2025 19:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=zO
	ecQmwq+DoDshGPB4oxxE5lmlvV6iB0dGFX8T5PHy8=; b=GN8GDlNlNhYylpGGye
	zge9N2XOMeb58LuWTEOnE6aF2ravmwwyDyJ6Ur/pwbn4EK+r711pmj1EN0Rq748d
	K8TYpryqrL5pOUtU+MhP4FWTkZikd0tDxnup5kXyE1nxRlG6cX0uwLU3RED8keqE
	CM6+wcIPdA0F0829UmveTqQwO0SmQlFnLhbJPdTLSYpsEdNsHpIDFpbLv36mfS5s
	gpVOUqMeZvrXOQgrekWrmbyQEdPOXdcShFzbaRg1KquQI/SAuRVW7fDpPxSjPsFs
	nTdD8brbC+TC0djjT/dvpiLyttWABdvmGN9cQ5ZVA2kXO8kPNqNbNQJ+JuTNuvAp
	hlMg==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 491x8qmesh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 19:14:58 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E274B805E2F;
	Mon,  8 Sep 2025 19:14:46 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 5A013802FD4;
	Mon,  8 Sep 2025 19:14:44 +0000 (UTC)
Date: Mon, 8 Sep 2025 14:14:42 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: jane.chu@oracle.com, "Luck, Tony" <tony.luck@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, surenb@google.com,
        "Anderson, Russ" <russ.anderson@hpe.com>, rppt@kernel.org,
        osalvador@suse.de, nao.horiguchi@gmail.com, mhocko@suse.com,
        lorenzo.stoakes@oracle.com, linmiaohe@huawei.com, david@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        vbabka@suse.cz, linux-acpi@vger.kernel.org,
        Shawn Fan <shawn.fan@intel.com>
Subject: Re: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
Message-ID: <aL8rIgSImDh7Nj7E@hpe.com>
References: <20250904155720.22149-1-tony.luck@intel.com>
 <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3>
 <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
 <aLspJ5Tpqp4qRDk2@agluck-desk3>
 <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
 <CACw3F538k+dshTs1_rxbpYoRdFyX3tLYzfaWj-_d7Lq5Dd2Jsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F538k+dshTs1_rxbpYoRdFyX3tLYzfaWj-_d7Lq5Dd2Jsg@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDExNCBTYWx0ZWRfX9h5ZGXmPvvws
 MWHA6QxpDtNHnKvEtXivLGKwkMt9sAgdbyGgyNgBGJFNHHCbg/Lw5MJUk62fyxjcr2nFtVi9i+T
 jMSU+eaw831+iNBrs8usa1MzW8TQApJw7s5EncaIXAckxxQRQfOcL0H8z1h+K7JKP1OIxqOhnwA
 JR+fM8n/lX1vrQrnn2LYRLTfMjnovNSRaQm8A7uW9SlBKUdPfUF0pJeq2wprLnIHogmldjyCvLq
 iYEZj2QMYBj5A9vH7k8PETzimn9yZ2aOjOI1yNw6c/DFD6EqL9qAU0bPI99NU4i3BENBNxPBRim
 ckmCS9yROHZbuDWyIFe+VjvCuKm/lJ8JwUP06gmtg9elwOZmhHggV0MKdcNsFPIco2uHpZ0x44z
 R3bDwrOC
X-Proofpoint-ORIG-GUID: lzDVQmIxlZm2_XmX0P6I_MbY6uRwcZUk
X-Proofpoint-GUID: lzDVQmIxlZm2_XmX0P6I_MbY6uRwcZUk
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bf2b32 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=168LhWg8FaowOX8s28cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080114

On Fri, Sep 05, 2025 at 12:59:00PM -0700, Jiaqi Yan wrote:
> On Fri, Sep 5, 2025 at 12:39 PM <jane.chu@oracle.com> wrote:
> >
> >
> > On 9/5/2025 11:17 AM, Luck, Tony wrote:
> > > BIOS can supply a GHES error record that reports that the corrected
> > > error threshold has been exceeded. Linux will attempt to soft offline
> > > the page in response.
> > >
> > > But "exceeded threshold" has many interpretations. Some BIOS versions
> > > accumulate error counts per-rank, and then report threshold exceeded
> > > when the number of errors crosses a threshold for the rank. Taking
> > > a page offline in this case is unlikely to solve any problems. But
> > > losing a 4KB page will have little impact on the overall system.
> 
> Hi Tony,
> 
> This is exactly the problem I encountered [1], and I agree with Jane
> that disabling soft offline via /proc/sys/vm/enable_soft_offline
> should work for your case.
> 
> [1] https://lore.kernel.org/all/20240628205958.2845610-3-jiaqiyan@google.com/T/#me8ff6bc901037e853d61d85d96aa3642cbd93b86 

If that doesn't work for your case, I just want to mention that hugepages might
still be soft offlined with that check in ghes_handle_memory_failure().

> > >
> > > On the other hand, taking a huge page offline will have significant
> > > impact (and still not solve any problems).
> > >
> > > Check if the GHES record refers to a huge page. Skip the offline
> > > process if the page is huge.

AFAICT, we're still notifying the MCE decoder chain and CEC will soft offline
the hugepage once the "action threshold" is reached.

This could be moved to soft_offline_page(). That would prevent other sources
(/sys/devices/system/memory/soft_offline_page, CEC, etc.) from being able to
soft offline hugepages, not just GHES.

> > > Reported-by: Shawn Fan <shawn.fan@intel.com>
> > > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > > ---
> > >
> > > Change since v2:
> > >
> > > Me: Add sanity check on the address (pfn) that BIOS provided. It might
> > > be in some reserved area that doesn't have a "struct page" which would
> > > likely result in an OOPs if fed to pfn_folio().
> > >
> > > The original code relied on sanity check of the pfn received from the
> > > BIOS when this eventually feeds into memory_failure(). That used to
> > > result in:
> > >       pr_err("%#lx: memory outside kernel control\n", pfn);
> > > which won't happen with this change, since memory_failure is not
> > > called. Was that a useful message? A Google search mostly shows
> > > references to the code. There are few instances of people reporting
> > > they saw this message.
> > >
> > >
> > >   drivers/acpi/apei/ghes.c | 13 +++++++++++--
> > >   1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > > index a0d54993edb3..c2fc1196438c 100644
> > > --- a/drivers/acpi/apei/ghes.c
> > > +++ b/drivers/acpi/apei/ghes.c
> > > @@ -540,8 +540,17 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
> > >
> > >       /* iff following two events can be handled properly by now */
> > >       if (sec_sev == GHES_SEV_CORRECTED &&
> > > -         (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> > > -             flags = MF_SOFT_OFFLINE;
> > > +         (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED)) {
> > > +             unsigned long pfn = PHYS_PFN(mem_err->physical_addr);
> > > +
> > > +             if (pfn_valid(pfn)) {
> > > +                     struct folio *folio = pfn_folio(pfn);
> > > +
> > > +                     /* Only try to offline non-huge pages */
> > > +                     if (!folio_test_hugetlb(folio))
> > > +                             flags = MF_SOFT_OFFLINE;
> > > +             }
> > > +     }
> > >       if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
> > >               flags = sync ? MF_ACTION_REQUIRED : 0;
> > >
> >
> > So the issue is the result of inaccurate MCA record about per rank CE
> > threshold being crossed. If OS offline the indicted page, it might be
> > signaled to offline another 4K page in the same rank upon access.
> >
> > Both MCA and offline-op are performance hitter, and as argued by this
> > patch, offline doesn't help except loosing a already corrected page.
> >
> > Here we choose to bypass hugetlb page simply because it's huge.  Is it
> > possible to argue that because the page is huge, it's less likely to get
> > another MCA on another page from the same rank?
> >
> > A while back this patch
> > 56374430c5dfc mm/memory-failure: userspace controls soft-offlining pages
> > has provided userspace control over whether to soft offline, could it be
> > a more preferable option?

Optionally, a 3rd setting could be added to /proc/sys/vm/enable_soft_offline:

0: Soft offline is disabled.
1: Soft offline is enabled for normal pages (skip hugepages).
2: Soft offline is enabled for normal pages and hugepages.

Maybe something like...

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc30ca4804bf..efa535d405a8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -64,11 +64,17 @@
 #include "internal.h"
 #include "ras/ras_event.h"
 
+enum soft_offline {
+	SOFT_OFFLINE_DISABLED = 0,
+	SOFT_OFFLINE_ENABLED_SKIP_HUGEPAGES,
+	SOFT_OFFLINE_ENABLED
+};
+
 static int sysctl_memory_failure_early_kill __read_mostly;
 
 static int sysctl_memory_failure_recovery __read_mostly = 1;
 
-static int sysctl_enable_soft_offline __read_mostly = 1;
+static int sysctl_enable_soft_offline __read_mostly = SOFT_OFFLINE_SKIP_HUGEPAGES;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
@@ -150,7 +156,7 @@ static const struct ctl_table memory_failure_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= SYSCTL_TWO,
 	}
 };
 
@@ -2799,12 +2805,20 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return -EIO;
 	}
 
-	if (!sysctl_enable_soft_offline) {
-		pr_info_once("disabled by /proc/sys/vm/enable_soft_offline\n");
+	if (sysctl_enable_soft_offline == SOFT_OFFLINE_DISABLED) {
+		pr_info("disabled by /proc/sys/vm/enable_soft_offline\n");
 		put_ref_page(pfn, flags);
 		return -EOPNOTSUPP;
 	}
 
+	if (sysctl_enable_soft_offline == SOFT_OFFLINE_ENABLED_SKIP_HUGEPAGES) {
+		if (folio_test_hugetlb(pfn_folio(pfn))) {
+			pr_info("disabled by /proc/sys/vm/enable_soft_offline\n");
+			put_ref_page(pfn, flags);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	mutex_lock(&mf_mutex);
 
 	if (PageHWPoison(page)) {

> > I don't know, the patch itself is fine, it's the issue that it has
> > exposed that is more concerning.

Thanks,
Kyle Meyer

