Return-Path: <linux-acpi+bounces-16275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F3AB3FEAF
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 13:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A9F188B3AF
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E142FABEB;
	Tue,  2 Sep 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPfsH/6Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361112FA0ED;
	Tue,  2 Sep 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813666; cv=none; b=Vz7oGV6vUnV9q/XcFhVWvclnBqFJrNKDUL1SS9FamAC7YGJ1msjEBg8gRYfRNiRDuE3q3FUWbHeN28zNME2URZOQARYCJ9dO15hhmnBxn8M/FC+FUx5CsXHFMERBpK5oRCt4THtUambykTfLprgRci52P8vjJzTOHNeHXazOkw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813666; c=relaxed/simple;
	bh=gAWv/p7BEF+KhNFGeotQ/1FrGNmecWyX1X5tGPHcCbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUVymcAmNrmoSwQ0sxNi5UCk7K0Av9KqLQlO4IuHMACbdP+xfK/gR6RGhuv1TcIhDOWYXWoogC/8X3ZOYLA5ruoWt5WferrdOSX++IlBClivx3VQ4uJd7+mr/8YBuPN9BN1XF2nuEqlFnsisjFqiyRah7NIVcljrw92o/o2rGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPfsH/6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89A4C4CEFB;
	Tue,  2 Sep 2025 11:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813665;
	bh=gAWv/p7BEF+KhNFGeotQ/1FrGNmecWyX1X5tGPHcCbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HPfsH/6ZQcNOGF26sYaQeEFwmNMIdemb3Sta1S24MP4Zqrzhp4xCYmME5rlpIalRH
	 wypS78addLryNXm+pxr8ZGRJ6CcNSwygSiD1yVSMsso71z9NbVxptxqSwM6eYw/hYg
	 E0n3a2RupUKViIi/xlJEoNXhZ7BEfE1ktdGaf5/LFZ2Ez9stJf6othwGdlk629boGF
	 /qfOkz7gPd4OTUDCeTkBwoG5jhFrt7JDvzdGAjA8tfRoviw73ahpeW1eDDr4LJyfaL
	 kf0/YFTRyn96EDkuB2SQEiQU90yOjmPyWIIFwn87EXpdsYgRoiI9E5Ci5ZKOtauLQA
	 Z0F2061pPrGmQ==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74382048b8cso3236488a34.3;
        Tue, 02 Sep 2025 04:47:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVyZzEvDrpJiYpGPI18U++0rHWEWScfMbN+8RsmUNgReancPWdbpTviAo4PG0Yu53eShXJnkTrBOjPj659@vger.kernel.org, AJvYcCUx1L6stu8U7sZnJp72GOudNHstfwvOjUOQk855W1Uu6IzLyqVzgdL/ajHiLKPF/ruufMYSHpszEwg=@vger.kernel.org, AJvYcCWp/HlUVkWFej94prIo50z3kdd9jANokP5ZRNMo0bmok0m7ZISSXOOnmhlZ+PQ/E23KBSESreU4SjUsrg==@vger.kernel.org, AJvYcCWrK1n3rH1E6Cw0pywubB8/FWao+M0dXPSvp5W349D6enXAACrc0ojv8yK7hiu31Re7bGtaC3y8S2w2@vger.kernel.org
X-Gm-Message-State: AOJu0YxtA9p452iUBSYwF/IzrtQfQy8BBTDGS20i+GvQd9Iu5RCJry85
	mrrOLcJIQkmgHR6usm06eqcMXoCLSZ+Aba2as7zkA8nUYgQ8iwlQDPpqdUORHr6H6eQqBZC7ytA
	BNCmoenoubEmtvfE7KGxY+m3v0Dvenaw=
X-Google-Smtp-Source: AGHT+IECJJHjGAnU1NUr4ozcxCWnRFCL9WRpq+BEhjBinEbwysmqVcNyjx+zeZUwmYMUKeDdT6dFc6CYWYPr3CoZ3wk=
X-Received: by 2002:a05:6830:3746:b0:743:8af2:1b0e with SMTP id
 46e09a7af769-74569e90f29mr6034860a34.19.1756813664724; Tue, 02 Sep 2025
 04:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901085748.36795-1-zhangzihuan@kylinos.cn>
 <20250901085748.36795-4-zhangzihuan@kylinos.cn> <CAJZ5v0hu48NrMr6Vkjn_UyHywJMx7F5N6yWf2LiXxykZF79EKA@mail.gmail.com>
 <29890791-4ddf-49c7-a4f2-0ac83e6d53c6@kylinos.cn>
In-Reply-To: <29890791-4ddf-49c7-a4f2-0ac83e6d53c6@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Sep 2025 13:47:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvOKeLRkjWoKR5eVKZ-hib7c8D-VOBvtCvs1+HGfPUiQ@mail.gmail.com>
X-Gm-Features: Ac12FXxFwO1d3JYj5phS50T_U2DONG2wuxBfs8rK_GU-NaLU6wYAD3eFplzuixw
Message-ID: <CAJZ5v0jvOKeLRkjWoKR5eVKZ-hib7c8D-VOBvtCvs1+HGfPUiQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] cpufreq: intel_pstate: Use scope-based cleanup helper
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Thierry Reding <thierry.reding@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Ben Horgan <ben.horgan@arm.com>, 
	zhenglifeng <zhenglifeng1@huawei.com>, Zhang Rui <rui.zhang@intel.com>, 
	Len Brown <lenb@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Beata Michalska <beata.michalska@arm.com>, 
	Fabio Estevam <festevam@gmail.com>, Pavel Machek <pavel@kernel.org>, Sumit Gupta <sumitg@nvidia.com>, 
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:33=E2=80=AFPM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
>
> =E5=9C=A8 2025/9/1 23:17, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Mon, Sep 1, 2025 at 10:58=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
> >> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> >> annotation for policy references. This reduces the risk of reference
> >> counting mistakes and aligns the code with the latest kernel style.
> >>
> >> No functional change intended.
> >>
> >> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> >> ---
> >>   drivers/cpufreq/intel_pstate.c | 8 +++-----
> >>   1 file changed, 3 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_ps=
tate.c
> >> index f366d35c5840..4abc1ef2d2b0 100644
> >> --- a/drivers/cpufreq/intel_pstate.c
> >> +++ b/drivers/cpufreq/intel_pstate.c
> >> @@ -1502,9 +1502,8 @@ static void __intel_pstate_update_max_freq(struc=
t cpufreq_policy *policy,
> >>
> >>   static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
> >>   {
> >> -       struct cpufreq_policy *policy __free(put_cpufreq_policy);
> >> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D c=
pufreq_cpu_get(cpudata->cpu);
> >>
> >> -       policy =3D cpufreq_cpu_get(cpudata->cpu);
> >>          if (!policy)
> >>                  return false;
> > The structure of the code is intentional here and there's no reason to
> > change it.
>
>
> Got it. Thanks for clarifying.
>
> So for this case the current structure is intentional -

Note that I'm talking about this particular change only.  The other
change in the $subject patch is fine.

> should I also avoid similar changes in other drivers?

That depends on who maintains them, which is why I wanted you to split
the patch into smaller changes in the first place.

My personal view is that code formatting changes, which effectively is
what this particular one is, are pointless unless they make the code
much easier to follow.

