Return-Path: <linux-acpi+bounces-6879-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B892FFBA
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 19:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF1C1C20CAB
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F431EA90;
	Fri, 12 Jul 2024 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL7zn3ZE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4917BCD;
	Fri, 12 Jul 2024 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805119; cv=none; b=mio5+8832O/jR0EujsktV3yWsYs4R77/3kP69AZkUeg2va8wiWsX1fzkhcwcrBzM4aMJKeJhRugeziWPngP9itRnv1o5rOgnI97duqT5WIx7q5TDOMP7qiLJzDYfGLR119vbx/1VdRs0y9aR6tAvfuLjD8ZuFtWwPvfzk6ocYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805119; c=relaxed/simple;
	bh=EHHm0Sx1Rf/GXUncn/Q9g3D2TSgJHw2pODcLQHE2toE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcI2z5o1kgrmfWjM9AZ6RllljB960p45VKjr8EJEbZ1/eHSHakDIQzIYz+R2Hh44RVNNUraz+qmao9aNh3l07vY5RapDBV15NmDhP4V20VdMG0XlZZY96JO8U5CRZsGp2o3BEoMYrDNpc5cWYkeZFvkXQO9J2qJERJhAjkMTJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL7zn3ZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57990C4AF0B;
	Fri, 12 Jul 2024 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720805119;
	bh=EHHm0Sx1Rf/GXUncn/Q9g3D2TSgJHw2pODcLQHE2toE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gL7zn3ZElLG62Hhp169bHN0LxJlvNV4m39PQD46rXeCanhuNsxPeyjIOegbOPDH9S
	 8rjuPlpQ8rCXw52FQb90MVrgYDQ4HC/gU9vvpjXGSBhaZvfPnzP/9O+09rDVLL5Pia
	 woFrYOaU1pR7mK9jMYyVSdVNDjnsSDmRDD3bzWeNuJLizWvqMiBcXVEXOBlw1wKu9M
	 Blw39eLnRKOHpInWyX4S86dOxL7r0eIsh6UX32CCUzDuzKUlOlzm7I9X6+wZckQsv+
	 LeTP4RpEA+fOR/T3AJ3oS4emRHlGBFxxWf8VM30RQ05Q2QkoVVLhEO6i4Ku14OyiLM
	 EnYw/az9duLWw==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d92563bea4so108488b6e.3;
        Fri, 12 Jul 2024 10:25:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUho2e2Tqyitfd9L4/9IH5HBSkQW+9WZp+pSF4DDc3ehLuMittbAjZOIcz63PjlGjyGkVAiQT+ZkYIskj2NYyu46L9s7fYP+kMnM9OzIxPP7hiKnGwtKlh+7Snlb2lxmdUGzoCYGq2XIA==
X-Gm-Message-State: AOJu0YwfHOVxE24VgwxAZKcaObCS6EFEWYk6dxq5NhZRb/3OiuRcHsks
	Z2dpMZvtXL1eumJ+OSr/iqBxL7nXvKRpqJMj+libsLNnDl06vRtMFSW62jziIpSmwDGQQSbbh6h
	6T1Uu8gPRPqOlwEB27u5gyqT6ALQ=
X-Google-Smtp-Source: AGHT+IFDYkb+iK07P6LlWHxtrvE9/weXybYbirPlqOe6CMZK+cRqSK3AHUS+VIgORVfPw5lvByKCGnue0BqrIxS46cQ=
X-Received: by 2002:a05:6871:582c:b0:25e:b7e1:d20d with SMTP id
 586e51a60fabf-2603a351666mr5953094fac.0.1720805118471; Fri, 12 Jul 2024
 10:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-fix-modpost-warning-default_dram_nodes-v1-1-8961453cc82d@kernel.org>
 <87jzhsa05p.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJZ5v0gHHkFnJEf2CQ5Rmz9+_7u1EqBPiycuFL1huPJf9Pvc6Q@mail.gmail.com>
 <23ab3394-8862-4da5-97ee-1355d9a21e40@intel.com>
In-Reply-To: <23ab3394-8862-4da5-97ee-1355d9a21e40@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Jul 2024 19:25:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jyPKoQM6DCqKtXR11ZwBrs64Nd8BApjcFk1Gv7F0YPpg@mail.gmail.com>
Message-ID: <CAJZ5v0jyPKoQM6DCqKtXR11ZwBrs64Nd8BApjcFk1Gv7F0YPpg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: HMAT: Mark hmat_set_default_dram_perf() as __init
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Len Brown <lenb@kernel.org>, Ho-Ren Chuang <horen.chuang@linux.dev>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 6:59=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 7/12/24 2:40 AM, Rafael J. Wysocki wrote:
> > On Thu, Jul 11, 2024 at 8:56=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Nathan Chancellor <nathan@kernel.org> writes:
> >>
> >>> After commit 4dc70b711dbc ("memory tier: consolidate the initializati=
on
> >>> of memory tiers"), there is a modpost warning when
> >>> hmat_set_default_dram_perf() is not inlined into its callsite, as it
> >>> appears that default_dram_nodes may be accessed after its memory has
> >>> been freed.
> >>>
> >>>   WARNING: modpost: vmlinux: section mismatch in reference: hmat_set_=
default_dram_perf+0x18 (section: .text) -> default_dram_nodes (section: .in=
it.data)
> >>>
> >>> The single callsite, hmat_init(), is __init, so this warning is not a
> >>> problem in reality but it is easily solvable by marking
> >>> hmat_set_default_dram_perf() as __init, which should have been done w=
hen
> >>> this function was added in commit 3718c02dbd4c ("acpi, hmat: calculat=
e
> >>> abstract distance with HMAT").
> >>
> >> Good catch!  Thanks for your fix!  If it's necessary, feel free to add
> >>
> >> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >
> > Thanks for the patch and the review!
> >
> > I'm expecting Dan/Dave to take care of it (or please let me know if
> > I'm expected to pick it up).
> >
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>> Closes: https://lore.kernel.org/oe-kbuild-all/202406292310.hlRATeZJ-l=
kp@intel.com/
> >>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >>> ---
> >>> I left off a fixes tag as I assume this is going to be squashed into =
the
> >>> former change mentioned above, as it is still in mm-unstable, but fee=
l
> >>> free to add one if the patch is going to be standalone.
>
> Should this be picked up by Andrew instead since it's already in mm-unsta=
ble?

This works too as long as someone picks it up. :-)

