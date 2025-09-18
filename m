Return-Path: <linux-acpi+bounces-17107-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D10B85BD6
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 17:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644C14844C2
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C99430F942;
	Thu, 18 Sep 2025 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBYB+u2C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D430C0FE
	for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210246; cv=none; b=g6yDo0fzvpMILJHL2gFjPHAiRK2UtDzpkHndB6hivfhU97IErnzfEl67rYUXl4/Q+QEW2xceirFjfsVaYwmE4JbfJA+jzfV+rRD+w3oKKLuuv2/6uoqBou9aGdsK9bDWviREj9Lz/SrW0sody9m1kQSx/iYmsAUekTTO1P8CtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210246; c=relaxed/simple;
	bh=kq9o/eEagt0/pAqdQUTz3RfdvhcUZHUhzvQ+PwKXcHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=es4mAIMZIldh6Hkhz3DQc+uTptrumqyO6+R6A0wwjcnS2ymBusGPeXIwW1bJI1dcHTCrh0vesNyRCRCK4Cs1LYIgvPVENzdM7hsiozZq9w2KUHwemd0KnvyDiFwLoD9eqHYxEDl5l41WnBL5I2DDDD7UxuvyOm0jZbWXe8tp9PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mBYB+u2C; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f28aba94cso87885e9.0
        for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210243; x=1758815043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+D+JfJ/Jq0/jdAS21NjzfpdXlFqTr3y01BMsRdUEi8=;
        b=mBYB+u2CBF3gHFyTFHvnxkdTPscGLlKbIQB4JQDzlq+t12DMwNPjuvKQCWpbqNrrOd
         CT5ukpAQDEQ5CEZBtdsrfMx5Qzad2j845MVmiRvNNlGFhA06ceYWBqYxWJNxrh5lpFz+
         NPurbCTsL3W1D6SL6MZ04+7zjSiWoIEFUJTtsPxXzX6GljI6nQREwvV95B1yOyo2cOiA
         zed6haUY1z2PR+7x5qslfzuihWPqJsstofv426MVIVxS9wGUWJGTBzbbWqv0MmBe1J0H
         lp/4lF94ysuUpG51bCOcXzHcGPVXM7qyyHLAwbT0fzLMcBoSlMImTRPd6/HWEdTVa/kA
         w1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210243; x=1758815043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+D+JfJ/Jq0/jdAS21NjzfpdXlFqTr3y01BMsRdUEi8=;
        b=vn5B2Hl5GC2jcc3hcfn5m7u4SfwYesOS89rQZBbefJtCnu+tZ8J0fA4vhG3fW8qkFe
         pK71LdiGfL6tYtdI8iHi/50bc0bwm53ImTlEbojPLImz3wWyCXrg6Leq64JGPgyUPalF
         mcBZkysBJvwUHjZ+yRVHGXPynxRebOKBZyQ26TcoF0fFS27ZDZpDEmhAZeQvMB9mFq2q
         K7jd+LphBJ0fTp1S5lYoxukEP5D+P0fhIu8PAGLPJ+M/TPrVrlywcvRwahw6A0zANdA4
         nk5EaYwjw/Zsh6GRXMFPy0GdwW3RuBe5uLfS2Fpqv8+ymytLmBqNcdZeK2oaR46RvB6f
         9u8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFuTQ2qAymLSAjVOrp8IpWsXUvvGbSVaKSn6kYS6jzuR3jY7cu56g0OuSbstVIWOx5ijgTHchyfi18@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jhjcOTCdVTJ7FucddtqJ1Fq3L/liUW2xvkSnBGqSYBJrZfJy
	bWu8qh+vnW9lN/OBEjaJEkormmy9B2mUpb5bybam4iRanwTsOeMFCHmd1Mk/jsVJmHro5LCuylh
	joGAVoplZkksFrQHSXVRUZG8SqNpJQlfSn+joHwyU
X-Gm-Gg: ASbGncscwek6sMhC2vFfJVSwYvQbrykcs9Z+Y4D+uBLsdLa+1tl0erlWGmEGDreWE+O
	+sSpOzY92eh+G/Mb2r/nrS1VwigFsHRvyq1xUv1NBVhQJHGayeM6yvpm7q0okFml3Un50hFT9b2
	6Y/2IV3ixI0WBaUHL2fqzzrnQ3Qc+UEyV9L4jSlxIgBiz4lV6xPYp9v86PG3uoomJ3AP0dAXAoY
	b889hJtrtbw/3TJgD/Pe+wCdDuGC95sx/r2QN2HBqnTOnFVUzW0u/aJftTo/JsH0A==
X-Google-Smtp-Source: AGHT+IGKDPhFW7QY2ThA23Eiqh7Jb4gB3IAedet7C/hbJyJis0arTM7d/07UQoRXJ2ALik0wfBJpwlDyK2X2eoThyyw=
X-Received: by 2002:a05:600c:621a:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-4616dbbbb8fmr4089715e9.2.1758210242387; Thu, 18 Sep 2025
 08:44:02 -0700 (PDT)
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
 <aL8rIgSImDh7Nj7E@hpe.com> <7d3cc42c-f1ef-4f28-985e-3a5e4011c585@linux.alibaba.com>
In-Reply-To: <7d3cc42c-f1ef-4f28-985e-3a5e4011c585@linux.alibaba.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 18 Sep 2025 08:43:51 -0700
X-Gm-Features: AS18NWBE_Rh3aqLAP0Y0-SJP8rZCEq2FVPADSEjBbJ_MtsZw23_iRMOUp4qz4C8
Message-ID: <CACw3F50hU3BCP=A++Dx_V=U8PKvsTvTa1=krULxfQdeK2kVBrw@mail.gmail.com>
Subject: Re: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Kyle Meyer <kyle.meyer@hpe.com>, jane.chu@oracle.com, 
	"Luck, Tony" <tony.luck@intel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, surenb@google.com, 
	"Anderson, Russ" <russ.anderson@hpe.com>, rppt@kernel.org, osalvador@suse.de, 
	nao.horiguchi@gmail.com, mhocko@suse.com, lorenzo.stoakes@oracle.com, 
	linmiaohe@huawei.com, david@redhat.com, bp@alien8.de, 
	akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz, 
	linux-acpi@vger.kernel.org, Shawn Fan <shawn.fan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:39=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/9/9 03:14, Kyle Meyer =E5=86=99=E9=81=93:> On Fri, Sep 05,=
 2025 at 12:59:00PM -0700, Jiaqi Yan wrote:
>  >> On Fri, Sep 5, 2025 at 12:39=E2=80=AFPM <jane.chu@oracle.com> wrote:
>  >>>
>  >>>
>  >>> On 9/5/2025 11:17 AM, Luck, Tony wrote:
>  >>>> BIOS can supply a GHES error record that reports that the corrected
>  >>>> error threshold has been exceeded. Linux will attempt to soft offli=
ne
>  >>>> the page in response.
>  >>>>
>  >>>> But "exceeded threshold" has many interpretations. Some BIOS versio=
ns
>  >>>> accumulate error counts per-rank, and then report threshold exceede=
d
>  >>>> when the number of errors crosses a threshold for the rank. Taking
>  >>>> a page offline in this case is unlikely to solve any problems. But
>  >>>> losing a 4KB page will have little impact on the overall system.
>
> Hi, Tony,
>
> Thank you for your detailed explanation. I believe this is exactly the pr=
oblem
> we're encountering in our production environment.
>
> As you mentioned, memory access is typically interleaved between channels=
. When
> the per-rank threshold is exceeded, soft-offlining the last accessed addr=
ess
> seems unreasonable - regardless of whether it's a 4KB page or a huge page=
. The
> error accumulation happens at the rank level, but the action is taken on =
a
> specific page that happened to trigger the threshold, which doesn't addre=
ss the
> underlying issue.
>
> I'm curious about the intended use case for the CPER_SEC_ERROR_THRESHOLD_=
EXCEEDED
> flag. What scenario was Intel BIOS expecting the OS to handle when this f=
lag is set?
> Is there a specific interpretation of "threshold exceeded" that would mak=
e
> page-level offline action meaningful? If not, how about disabling soft of=
fline from
> GHES and leave that to userspace tools like rasdaemon (mcelog) ?

The existing /proc/sys/vm/enable_soft_offline can already entirely
disable soft offline. GHES may still ask for soft offline to
memory-failure.c, but soft_offline_page will discard the ask as long
as userspace sets 0 to /proc/sys/vm/enable_soft_offline.

>
>  >>
>  >> Hi Tony,
>  >>
>  >> This is exactly the problem I encountered [1], and I agree with Jane
>  >> that disabling soft offline via /proc/sys/vm/enable_soft_offline
>  >> should work for your case.
>  >>
>  >> [1] https://lore.kernel.org/all/20240628205958.2845610-3-jiaqiyan@goo=
gle.com/T/#me8ff6bc901037e853d61d85d96aa3642cbd93b86
>  >
>  > If that doesn't work for your case, I just want to mention that hugepa=
ges might
>  > still be soft offlined with that check in ghes_handle_memory_failure()=
.
>  >
>  >>>>
>  >>>> On the other hand, taking a huge page offline will have significant
>  >>>> impact (and still not solve any problems).
>  >>>>
>  >>>> Check if the GHES record refers to a huge page. Skip the offline
>  >>>> process if the page is huge.
>  >
>  > AFAICT, we're still notifying the MCE decoder chain and CEC will soft =
offline
>  > the hugepage once the "action threshold" is reached.
>  >
>  > This could be moved to soft_offline_page(). That would prevent other s=
ources
>  > (/sys/devices/system/memory/soft_offline_page, CEC, etc.) from being a=
ble to
>  > soft offline hugepages, not just GHES.
>  >
>  >>>> Reported-by: Shawn Fan <shawn.fan@intel.com>
>  >>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>  >>>> ---
>  >>>>
>  >>>> Change since v2:
>  >>>>
>  >>>> Me: Add sanity check on the address (pfn) that BIOS provided. It mi=
ght
>  >>>> be in some reserved area that doesn't have a "struct page" which wo=
uld
>  >>>> likely result in an OOPs if fed to pfn_folio().
>  >>>>
>  >>>> The original code relied on sanity check of the pfn received from t=
he
>  >>>> BIOS when this eventually feeds into memory_failure(). That used to
>  >>>> result in:
>  >>>>        pr_err("%#lx: memory outside kernel control\n", pfn);
>  >>>> which won't happen with this change, since memory_failure is not
>  >>>> called. Was that a useful message? A Google search mostly shows
>  >>>> references to the code. There are few instances of people reporting
>  >>>> they saw this message.
>  >>>>
>  >>>>
>  >>>>    drivers/acpi/apei/ghes.c | 13 +++++++++++--
>  >>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>  >>>>
>  >>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>  >>>> index a0d54993edb3..c2fc1196438c 100644
>  >>>> --- a/drivers/acpi/apei/ghes.c
>  >>>> +++ b/drivers/acpi/apei/ghes.c
>  >>>> @@ -540,8 +540,17 @@ static bool ghes_handle_memory_failure(struct =
acpi_hest_generic_data *gdata,
>  >>>>
>  >>>>        /* iff following two events can be handled properly by now *=
/
>  >>>>        if (sec_sev =3D=3D GHES_SEV_CORRECTED &&
>  >>>> -         (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
>  >>>> -             flags =3D MF_SOFT_OFFLINE;
>  >>>> +         (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED)) {
>  >>>> +             unsigned long pfn =3D PHYS_PFN(mem_err->physical_addr=
);
>  >>>> +
>  >>>> +             if (pfn_valid(pfn)) {
>  >>>> +                     struct folio *folio =3D pfn_folio(pfn);
>  >>>> +
>  >>>> +                     /* Only try to offline non-huge pages */
>  >>>> +                     if (!folio_test_hugetlb(folio))
>  >>>> +                             flags =3D MF_SOFT_OFFLINE;
>  >>>> +             }
>  >>>> +     }
>  >>>>        if (sev =3D=3D GHES_SEV_RECOVERABLE && sec_sev =3D=3D GHES_S=
EV_RECOVERABLE)
>  >>>>                flags =3D sync ? MF_ACTION_REQUIRED : 0;
>  >>>>
>  >>>
>  >>> So the issue is the result of inaccurate MCA record about per rank C=
E
>  >>> threshold being crossed. If OS offline the indicted page, it might b=
e
>  >>> signaled to offline another 4K page in the same rank upon access.
>  >>>
>  >>> Both MCA and offline-op are performance hitter, and as argued by thi=
s
>  >>> patch, offline doesn't help except loosing a already corrected page.
>  >>>
>  >>> Here we choose to bypass hugetlb page simply because it's huge.  Is =
it
>  >>> possible to argue that because the page is huge, it's less likely to=
 get
>  >>> another MCA on another page from the same rank?
>  >>>
>  >>> A while back this patch
>  >>> 56374430c5dfc mm/memory-failure: userspace controls soft-offlining p=
ages
>  >>> has provided userspace control over whether to soft offline, could i=
t be
>  >>> a more preferable option?
>  >
>  > Optionally, a 3rd setting could be added to /proc/sys/vm/enable_soft_o=
ffline:
>  >
>  > 0: Soft offline is disabled.
>  > 1: Soft offline is enabled for normal pages (skip hugepages).
>  > 2: Soft offline is enabled for normal pages and hugepages.
>  >
>
> I prefer having soft-offline fully controlled by userspace, especially
> for DPDK-style applications. These applications use hugepage mappings and=
 maintain
> their own VA-to-PA mappings. When the kernel migrates a hugepage to a new=
 physical
> page during soft-offline, DPDK continues accessing the old physical addre=
ss,
> leading to data corruption or access errors.

Just curious, does the DPDK applications pin (pin_user_pages) the
VA-to-PA mappings? If so I would expect both soft offline and hard
offline will fail and become no-op.

>
> For such use cases, the application needs to be aware of and handle memor=
y errors
> itself. The kernel performing automatic page migration breaks the assumpt=
ions these
> applications make about stable physical addresses.
> Thanks.
> Shuai

