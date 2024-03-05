Return-Path: <linux-acpi+bounces-4106-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A78715CD
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Mar 2024 07:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B551F220EB
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Mar 2024 06:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317F7D3E8;
	Tue,  5 Mar 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LE8ERebD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A846521
	for <linux-acpi@vger.kernel.org>; Tue,  5 Mar 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619794; cv=none; b=K9XtfwtsZR0AC5SJG6LPxg/Y/papsLAK2QyeA7zOYkaznH76BOKi7LK292HOnstm6rjBePnD8UlRlHkneL+1ToFtm5nB/SnF65RQgldMtHM4A/SbTkrEuCmTYgx2PgvkGK4yuE6/LQbzQkFD7gcUbfZ0aD/y5Zt0LMiDvG5xiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619794; c=relaxed/simple;
	bh=oSQv4NUxnf7rEIn+bi0UJt8ayyHupEoJoCDqI6CLoMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOL2cnBF1NYNZUvDZh8iCbVc/uNv9GWp/UimhSijiUe/MPcoeYrg9mDcfEwK8/jrFlMLfMaLS0UK4Cv3goUYBi6qPPnvUqGIatDT72z1eXE3kzMLbwQ0otf/LqpLzfGONYzGOwZTrYZegTP0njco8jibCTZiq6AY1eS2D8LGvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LE8ERebD; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d355374878so113044e0c.0
        for <linux-acpi@vger.kernel.org>; Mon, 04 Mar 2024 22:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709619790; x=1710224590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOnvvH2W03oK21Enygd77Kz3RD653oFonWkuoJk8SUU=;
        b=LE8ERebDii+cQmF5RG+dX0zlNm4JZ9MLewpjopaim/ryWpHJebOB9+ajkT5InRWjOj
         eI0Jfob4gzRx2w/do+JxUoZuhyNGl6onmSwU0Fdp6f8IeepPtM5e90PJSpnM3EMcjGO7
         z16WhKK3Tdg7VTYKfg6Cjf2iFpUXeIJNSWOQ8xqNprb+EP9xkSPKPFBqsz00ZBbNPxe4
         Mc08wgnPAZ2u+UM1aKYHTbAOOTBFBb1Tz6QoaRERMxLSfBZeyegh6FOlbmXUOlgaxHwJ
         xwIhWX81fBDRaONbuib7MOvyyDD1INms0iXN/2ixNLztNxw4yDaS/8yLa/8FrdwIEqAx
         mbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709619790; x=1710224590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOnvvH2W03oK21Enygd77Kz3RD653oFonWkuoJk8SUU=;
        b=dBNo/A+l7qofY880BgZv8QADSZoAHARl+R1KdG5wKRHEWuoon38q+JFwOPNTrYqHwG
         G47XAKwf1VWPh6a7RI/1D76d80mi8QdH5d3hyribfVb0fi+quWK3QD96rwuV58Zvrs7l
         UejLBE8WaxIAP54jBhvw1tG1JCOAmeYikoWWA8hhwOFiVmoFNDtJGvltL65Q60Xrdihv
         0HKnUqVFXmdumGAPdI+KHMLaPoDsLWDA9iVqUtuEm9FKszaOGCBCDk6VavgDw36PZizA
         KtNMoQ3vzCk31LQWF9g0Xq+zJW8qJlXqLqZ+CeimDuJke9e33+jn3u5h81WHr4j1+dNb
         rodg==
X-Forwarded-Encrypted: i=1; AJvYcCX7oH5p2wccu8w8sjodELB5gf3pnlx3/DxwDnvMdnDlJnptZ9ajHF+sJs9DCNZb2U+PlVcx6zLPxuovowhIgJH4wHWe4zoqzzqOVQ==
X-Gm-Message-State: AOJu0YzZPRsw2jS59DWaxcg+Zu8OJOn0KSMzl+e1KMpP+sEI/EEc994d
	R6ij2F6ZP4Qe7lSLh/ivOuIjgfIgYO+dM7Yx7CcAEg6Q5t32qwTMglkrxMOCSv/tIsdJbJSzjlD
	7PsA9UKlc3QRDzcHOsA20zKmfdkgZeCwjQeNKFA==
X-Google-Smtp-Source: AGHT+IF8wFchH2Tpcwl+m9+vC++9MiGH8pjEs4cet64MI10UrFTvnJG9+E2iM+RbR2/QpLJ5rn/dajElMcAyZ2RW5JY=
X-Received: by 2002:a05:6122:da7:b0:4ca:615e:1b61 with SMTP id
 bc39-20020a0561220da700b004ca615e1b61mr914463vkb.10.1709619790595; Mon, 04
 Mar 2024 22:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301082248.3456086-1-horenchuang@bytedance.com> <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 4 Mar 2024 22:22:59 -0800
Message-ID: <CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1 0/1] Improved Memory Tier Creation for
 CPUless NUMA Nodes
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com, 
	tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > The memory tiering component in the kernel is functionally useless for
> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the no=
des
> > are lumped together in the DRAM tier.
> > https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A=
@PH0PR08MB7955.namprd08.prod.outlook.com/T/
>
> I think that it's unfair to call it "useless".  Yes, it doesn't work if
> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
> please be specific about in which cases it doesn't work instead of too
> general "useless".
>

Thank you and I didn't mean anything specific. I simply reused phrases
we discussed
earlier in the previous patchset. I will change them to the following in v2=
:
"At boot time, current memory tiering assigns all detected memory nodes
to the same DRAM tier. This results in CPUless memory/non-DRAM devices,
such as CXL1.1 type3 memory, being unable to be assigned to the
correct memory tier,
leading to the inability to migrate pages between different types of memory=
."

Please see if this looks more specific.

> > This patchset automatically resolves the issues. It delays the initiali=
zation
> > of memory tiers for CPUless NUMA nodes until they obtain HMAT informati=
on
> > at boot time, eliminating the need for user intervention.
> > If no HMAT specified, it falls back to using `default_dram_type`.
> >
> > Example usecase:
> > We have CXL memory on the host, and we create VMs with a new system mem=
ory
> > device backed by host CXL memory. We inject CXL memory performance attr=
ibutes
> > through QEMU, and the guest now sees memory nodes with performance attr=
ibutes
> > in HMAT. With this change, we enable the guest kernel to construct
> > the correct memory tiering for the memory nodes.
> >
> > Ho-Ren (Jack) Chuang (1):
> >   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
> >     HMAT info
> >
> >  drivers/acpi/numa/hmat.c     |  3 ++
> >  include/linux/memory-tiers.h |  6 +++
> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
> >  3 files changed, 77 insertions(+), 8 deletions(-)
>
> --
> Best Regards,
> Huang, Ying

--=20
---
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

