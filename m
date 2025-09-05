Return-Path: <linux-acpi+bounces-16435-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14635B4640A
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 21:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0E65A327B
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 19:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512CE286881;
	Fri,  5 Sep 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFK3YZRP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA95E55A
	for <linux-acpi@vger.kernel.org>; Fri,  5 Sep 2025 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102355; cv=none; b=VcFG+DjwugVB6Tc4okjoOWIuR1fyq7e8qdSdOGSL5hnfzLUMn+cQ3ijktquYR1wWGKLsWh6J7pm7j2AqRuhBk0mUduPiefyA4L1C5SFCnW/upHOkOEJt5KQOIWD7h5LVIEfuKlLkdDFyxz3dMNTr2X104pyUMsrXS5mvxm5t7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102355; c=relaxed/simple;
	bh=dTXwNkGUGhqxNFcxfOfFHqibu4Eb6fGIZ6ldoynPVlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmZ83suuUseFhIuZjC4j7bQ0PClQgMaXS1J8i0JADmodrgkBBk/egqn/bC4djEC3Aw+74r0D/YyrKo8c4xWFui0nChm/yRhG/CSd2VGIh7tJTXG0t8gCJQYRS72BhEq2k1rgVBp9kLDCiuFdyYJxvmqpz5vc4SC/Jvyzq0yvZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QFK3YZRP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so16705e9.0
        for <linux-acpi@vger.kernel.org>; Fri, 05 Sep 2025 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757102352; x=1757707152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPcGZxnKXbZjc5LXwo68zrNMzrsx0r/f8oHKhVbqs4w=;
        b=QFK3YZRPtf3qT4N2X8PCmmlzc9fFn3b5m3M5limiwL8sC5Xnhb9X+oK9AFYbk3/eMp
         1+OvY+ZWFmqUobG4vHxVeklSfXc+uKdcKr7MKONG655H3st8AzvipJqvnm9SnAgXbkqN
         nNyNqXALd9owg7easHJ1+6s1cy2RJwtJB83Civnk4rSMqc4ZjlqQcHT5OkmDVpG+RnLP
         Kc7AESJ3vUmXZahpRlo4C571v9p0DdbjHx+gKq1wkYTn/39R+GkYJdlRXY5VBbTWO/vw
         4/+epapZndfWlEyWqSOdZ9wVJM67Yz4kUBuLvmQfwz75DbhMKn2kRxALcKOYv+igvFlr
         jBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102352; x=1757707152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPcGZxnKXbZjc5LXwo68zrNMzrsx0r/f8oHKhVbqs4w=;
        b=C2dNdXCBFGcxSn7HA8tCGmE8t3/HOK/IOt+7uUTHNpKFUbq3mbKrEo0V4zoLb2H8Hh
         HqfXZW1mzP4kMxyoio5GuNDizeZJUgZvxiGsUYSARhY8Kc5WzMmyIsEiN+sUY1KhfRD1
         cKRo/OU3QrAi13FwJfBfz79gNcR9ccDvyFumbsw0oClTRt50RTslfbV9ocgEQJvZcIrp
         HQvbKxBntH3s3QZ+sLarIagaADpU0wkgN9I7T1F+KcU13852RqOF+q7lRpYHH0MnX5EG
         g6wo6WRvHOfZbxHvGxyAJBlhf/qJc+gs+G43kQjXpkKf6mzut3+h9gXs8xiJnX+Eems0
         zJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVi66X9MI+sDAFFnXRWpkszp623G7n81/RMhkefyfIQ/PIyxx7zJM9MMVNyqrDJaq/IKzRfehuldX2@vger.kernel.org
X-Gm-Message-State: AOJu0YzZqG0EVkIwIyaRXVYWFDER+Z1hYez9PXPtgrWkgCSkwmmKjFBb
	mrStsJHaWDDYqqe4pirG71ignTqbts5NOV8fI7cWDjosE61ROrBlYbIJxUuJU/cd7Vak25fgyJx
	CJVj82U+vXGqSG7qJuVfBJ5cZ2Zu/MCwRGpKtKjNK
X-Gm-Gg: ASbGnct+c5x5nD9vRtq6+1N79QF0ltzXesKSd2WTRyFn94pptzEhIHaPxMLN/cdKxip
	WNXQWjo5h+IAU/YA0mNHZwwYt3SY+pBEDbOPYrxoQU+utHStEU6/8pcBfb1TxBPF/22HI5fHx4h
	0QLLvUZ4Q+325PnG344Jjv8ir4gn+peJL1yxzeKVlaKZrN8ftfVcsIHzKsOVV6aLdeQ6jXpLmDC
	gol/OAPv67IQ9vfNIjVKUObroUOD+5Ctwt63A4ep0/NH4k6h+yxK5U=
X-Google-Smtp-Source: AGHT+IGS90KLyGGX5srXBtIiKQCUAFaGimJMeYsja8yPWy0QHghibtIhzRV7homXu3nDuj1kGEU2ICQp5naEBqxMPRg=
X-Received: by 2002:a05:600c:8b6b:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-45ddda84d71mr223665e9.2.1757102351419; Fri, 05 Sep 2025
 12:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904155720.22149-1-tony.luck@intel.com> <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3> <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
 <aLspJ5Tpqp4qRDk2@agluck-desk3> <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
In-Reply-To: <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 5 Sep 2025 12:59:00 -0700
X-Gm-Features: Ac12FXxHINd3qYDaZlwQQ89HLW2T-j_NQxkA_uJ8_hkcYnzLr5gduEyyYyn_TWE
Message-ID: <CACw3F538k+dshTs1_rxbpYoRdFyX3tLYzfaWj-_d7Lq5Dd2Jsg@mail.gmail.com>
Subject: Re: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
To: jane.chu@oracle.com
Cc: "Luck, Tony" <tony.luck@intel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, surenb@google.com, 
	"Anderson, Russ" <russ.anderson@hpe.com>, rppt@kernel.org, osalvador@suse.de, 
	nao.horiguchi@gmail.com, mhocko@suse.com, lorenzo.stoakes@oracle.com, 
	linmiaohe@huawei.com, david@redhat.com, bp@alien8.de, 
	"Meyer, Kyle" <kyle.meyer@hpe.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	vbabka@suse.cz, linux-acpi@vger.kernel.org, Shawn Fan <shawn.fan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:39=E2=80=AFPM <jane.chu@oracle.com> wrote:
>
>
> On 9/5/2025 11:17 AM, Luck, Tony wrote:
> > BIOS can supply a GHES error record that reports that the corrected
> > error threshold has been exceeded. Linux will attempt to soft offline
> > the page in response.
> >
> > But "exceeded threshold" has many interpretations. Some BIOS versions
> > accumulate error counts per-rank, and then report threshold exceeded
> > when the number of errors crosses a threshold for the rank. Taking
> > a page offline in this case is unlikely to solve any problems. But
> > losing a 4KB page will have little impact on the overall system.

Hi Tony,

This is exactly the problem I encountered [1], and I agree with Jane
that disabling soft offline via /proc/sys/vm/enable_soft_offline
should work for your case.

[1] https://lore.kernel.org/all/20240628205958.2845610-3-jiaqiyan@google.co=
m/T/#me8ff6bc901037e853d61d85d96aa3642cbd93b86

> >
> > On the other hand, taking a huge page offline will have significant
> > impact (and still not solve any problems).
> >
> > Check if the GHES record refers to a huge page. Skip the offline
> > process if the page is huge.
> >
> > Reported-by: Shawn Fan <shawn.fan@intel.com>
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >
> > Change since v2:
> >
> > Me: Add sanity check on the address (pfn) that BIOS provided. It might
> > be in some reserved area that doesn't have a "struct page" which would
> > likely result in an OOPs if fed to pfn_folio().
> >
> > The original code relied on sanity check of the pfn received from the
> > BIOS when this eventually feeds into memory_failure(). That used to
> > result in:
> >       pr_err("%#lx: memory outside kernel control\n", pfn);
> > which won't happen with this change, since memory_failure is not
> > called. Was that a useful message? A Google search mostly shows
> > references to the code. There are few instances of people reporting
> > they saw this message.
> >
> >
> >   drivers/acpi/apei/ghes.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index a0d54993edb3..c2fc1196438c 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -540,8 +540,17 @@ static bool ghes_handle_memory_failure(struct acpi=
_hest_generic_data *gdata,
> >
> >       /* iff following two events can be handled properly by now */
> >       if (sec_sev =3D=3D GHES_SEV_CORRECTED &&
> > -         (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> > -             flags =3D MF_SOFT_OFFLINE;
> > +         (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED)) {
> > +             unsigned long pfn =3D PHYS_PFN(mem_err->physical_addr);
> > +
> > +             if (pfn_valid(pfn)) {
> > +                     struct folio *folio =3D pfn_folio(pfn);
> > +
> > +                     /* Only try to offline non-huge pages */
> > +                     if (!folio_test_hugetlb(folio))
> > +                             flags =3D MF_SOFT_OFFLINE;
> > +             }
> > +     }
> >       if (sev =3D=3D GHES_SEV_RECOVERABLE && sec_sev =3D=3D GHES_SEV_RE=
COVERABLE)
> >               flags =3D sync ? MF_ACTION_REQUIRED : 0;
> >
>
> So the issue is the result of inaccurate MCA record about per rank CE
> threshold being crossed. If OS offline the indicted page, it might be
> signaled to offline another 4K page in the same rank upon access.
>
> Both MCA and offline-op are performance hitter, and as argued by this
> patch, offline doesn't help except loosing a already corrected page.
>
> Here we choose to bypass hugetlb page simply because it's huge.  Is it
> possible to argue that because the page is huge, it's less likely to get
> another MCA on another page from the same rank?
>
> A while back this patch
> 56374430c5dfc mm/memory-failure: userspace controls soft-offlining pages
> has provided userspace control over whether to soft offline, could it be
> a more preferable option?
>
> I don't know, the patch itself is fine, it's the issue that it has
> exposed that is more concerning.
>
> thanks,
> -jane
>
>
>
>

