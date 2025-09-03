Return-Path: <linux-acpi+bounces-16310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09401B41C96
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 13:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86773ADAD3
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170382F3C38;
	Wed,  3 Sep 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psxDQFNq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35792D8781;
	Wed,  3 Sep 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897474; cv=none; b=X71FzGPyoeGN2tDYB5fBqePOUqB1gSx3Rg4Q7DnkrYu4dHEYcJXtqg15dMHz2rt+KKyAVNaWCOsNU0rIDZ0UY9jyJu12klrQ2jywlXhJ77LJg8qM2hxP89Poq1Hnj7sXyB1X4MLiSjh0A3sIOA1L5PuOXzI1TP1qak1kqL+KHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897474; c=relaxed/simple;
	bh=cR6pggU98t/+Ukijic5qu6ZCN/k9GzBjkSxa8gGSKqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCwNC9FELv5wDd68lo9rSEmGjoppuUyoKTNlkBkz9n2m6lcAmNNccKR+3V+b9qj5FXyH16TZ22LICZjVxY841C93b3YG3NPfEc7gUHvjV2503p7rCmO/L7B90bAqCX6YJfijcL+bL+l09m9FWbIULkMAz3bHo5OEQa/KohwhvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psxDQFNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56170C113CF;
	Wed,  3 Sep 2025 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756897472;
	bh=cR6pggU98t/+Ukijic5qu6ZCN/k9GzBjkSxa8gGSKqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=psxDQFNqUA0AxnW1agDCBjM86eBgZ74JT2Cd1rJz0r6c6YIg9L5yDWVB/dyKfbNqY
	 7ZLsa748GOiB7mhjhAd7ZfA8Kf0yz16s0PmWze8zgCN+oiV63DSrvCAm5l4CmHbQDL
	 oSTTmG5f6r+rVGC89dPywgVkBtO5/2saXzd0zWbC+lwxN43IbLc/N2JIFlZvmatvZL
	 wbA8HXmaSHcOjOr4RYxkDguj3NEv01VtIYQp0kZf52jVOP92S6DDJ4Ekq7SVZovP5I
	 yLR8QJOzVUwT5t4hf2flXG4hKNUFCxAwpJ3IHOkAiFFWl4mOkwRLbpmr6WQ2TSehUN
	 mmSq/SUEn6fUA==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74382041c9eso4142971a34.3;
        Wed, 03 Sep 2025 04:04:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUy+/M7r5M6ueeQOQtuQM/GUfNd66ua1DbRCFOHd1X8yO0perZFhXF9X99beWOhLE4QBvRL2U1zgVQ=@vger.kernel.org, AJvYcCVOP/MrB39/YvbS7zIiZzHG2N4DXfhN905GsxuiYriPQiZ/dY/sdXfrHK/5CLVGHdJurGoiDF0FY/e5JQ==@vger.kernel.org, AJvYcCVu5xNWe4QxP4i96a55dU9BKUmqj1c9GKs7xaDM3IO6wD0V7wubHFJgURa11EEBXmH8pBikrtysfWox@vger.kernel.org, AJvYcCW4oWJ7QzkycxQBfNND/mudIseCU8Mqowrl5yGAmACCfdIv38dLpGI1apn6lHHbK/PliMHk+8jebz9QnE86@vger.kernel.org
X-Gm-Message-State: AOJu0YyJcwJXNWa86HEzYnv9uydSuWunn2DDcSw78BlfmRkcYDEVloaL
	1iX28VbbsdPy5CLNVR6oqWsJnePfBOJFarxW7yGthWz4Z8jvfNpRx+0NejMtXfsyU8e7WTJc7Eq
	PmBvHmWL6n/4RiSNiUyGh3mzFV+68Gik=
X-Google-Smtp-Source: AGHT+IGt8cths8yMLXGw+ylAbBkNMXTKhbmkwbSixaLVjPRLTHE/ydd0R+Ek9LJwycoLKhw9INB3N/62z1RFfHnhrtQ=
X-Received: by 2002:a05:6830:6d0e:b0:731:cac7:3636 with SMTP id
 46e09a7af769-74569d7940cmr8468523a34.6.1756897471467; Wed, 03 Sep 2025
 04:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901085748.36795-1-zhangzihuan@kylinos.cn>
 <20250901085748.36795-4-zhangzihuan@kylinos.cn> <CAJZ5v0hu48NrMr6Vkjn_UyHywJMx7F5N6yWf2LiXxykZF79EKA@mail.gmail.com>
 <29890791-4ddf-49c7-a4f2-0ac83e6d53c6@kylinos.cn> <CAJZ5v0jvOKeLRkjWoKR5eVKZ-hib7c8D-VOBvtCvs1+HGfPUiQ@mail.gmail.com>
 <40706b1f-e23c-417b-b3e1-2dc839828588@kylinos.cn>
In-Reply-To: <40706b1f-e23c-417b-b3e1-2dc839828588@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 13:04:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g=riWtqaB=pGcxormmnaeFyRaeG1LZyEDBzpUGrH4kEA@mail.gmail.com>
X-Gm-Features: Ac12FXznI_bHraDGh_P16Ypv18F94Duvp6HYWc01eg81rI5FCsWpKSsYAvb2qr0
Message-ID: <CAJZ5v0g=riWtqaB=pGcxormmnaeFyRaeG1LZyEDBzpUGrH4kEA@mail.gmail.com>
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

On Wed, Sep 3, 2025 at 2:51=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.cn=
> wrote:
>
>
> =E5=9C=A8 2025/9/2 19:47, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Tue, Sep 2, 2025 at 12:33=E2=80=AFPM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
> >>
> >> =E5=9C=A8 2025/9/1 23:17, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>> On Mon, Sep 1, 2025 at 10:58=E2=80=AFAM Zihuan Zhang <zhangzihuan@kyl=
inos.cn> wrote:
> >>>> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> >>>> annotation for policy references. This reduces the risk of reference
> >>>> counting mistakes and aligns the code with the latest kernel style.
> >>>>
> >>>> No functional change intended.
> >>>>
> >>>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> >>>> ---
> >>>>    drivers/cpufreq/intel_pstate.c | 8 +++-----
> >>>>    1 file changed, 3 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_=
pstate.c
> >>>> index f366d35c5840..4abc1ef2d2b0 100644
> >>>> --- a/drivers/cpufreq/intel_pstate.c
> >>>> +++ b/drivers/cpufreq/intel_pstate.c
> >>>> @@ -1502,9 +1502,8 @@ static void __intel_pstate_update_max_freq(str=
uct cpufreq_policy *policy,
> >>>>
> >>>>    static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
> >>>>    {
> >>>> -       struct cpufreq_policy *policy __free(put_cpufreq_policy);
> >>>> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D=
 cpufreq_cpu_get(cpudata->cpu);
> >>>>
> >>>> -       policy =3D cpufreq_cpu_get(cpudata->cpu);
> >>>>           if (!policy)
> >>>>                   return false;
> >>> The structure of the code is intentional here and there's no reason t=
o
> >>> change it.
> >>
> >> Got it. Thanks for clarifying.
> >>
> >> So for this case the current structure is intentional -
> > Note that I'm talking about this particular change only.  The other
> > change in the $subject patch is fine.
> >
> >> should I also avoid similar changes in other drivers?
> > That depends on who maintains them, which is why I wanted you to split
> > the patch into smaller changes in the first place.
> >
> > My personal view is that code formatting changes, which effectively is
> > what this particular one is, are pointless unless they make the code
> > much easier to follow.
>
>
> UnderStood, Thanks!

Although I think that it would be cleaner to move the code executed in
each step of the for_each_possible_cpu() loop to a separate function.

