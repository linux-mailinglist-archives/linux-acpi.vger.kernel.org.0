Return-Path: <linux-acpi+bounces-16329-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2029AB42227
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 15:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A56E189AC5A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16F730BF71;
	Wed,  3 Sep 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gREu3S3c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834130BF6A;
	Wed,  3 Sep 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906899; cv=none; b=SFVLLA1CNLMmc0IIt1E3XCjQM5Ic0bOJBOKonqiyi3+Cp3TUwXYPiShhpiwvgOjPWctbA+NyG6a2WgTuejcmfoXKASrQ0P8RxNzLD5A8rDaAEgnd2CfEsclApNeEQS6wMDg9SkpmiqggH95foAztDy8QfeteXEk1uoAUY+/Tt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906899; c=relaxed/simple;
	bh=GdyS+4iaGJbGIJ9ctC+uFtQbJ57ANyqF8rmhb7Dc65Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFbJ0Le3PUFkOrJqEengX1MF4dIUeITZjfS2KHRpKUSSBtNYfGzVlUfN858Rfs+iJXw/vmTuKBjYMk6rp06aigOX6FtzoKiQ2140HwYHTTC5iplO/OkNQzCN8gPtd5BHf2RyLHeeDnX24cCFN41qfmbSQiIRhBTQLrm1QsifT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gREu3S3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61503C116B1;
	Wed,  3 Sep 2025 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756906899;
	bh=GdyS+4iaGJbGIJ9ctC+uFtQbJ57ANyqF8rmhb7Dc65Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gREu3S3cIIExxWuJPsc+munhlGaJtSwRMnS15DA4v0a6bQz6CWCrmik3TzYj/QUJj
	 3ZloY/8FCzhwS85PBka4CYNFeEOJbr7uVgfvXPdZeoAikj7Uo0dnGkAxWxGkG+5qsO
	 Ubyh/2IuzT8yKsZ/kPtNv09e6T7qhzcGrsaH6Y8fwLeZyjglfWVXXhr2JNPe5wC7Yw
	 F1Qxtcff4RNjFLRfNMG69ZKoOHxIslevyytvdomIhf8ZQZp2ywnG4IJCrefXprlYQy
	 PWeQU1n7TY41TrGtpOURB7CSxfyFAU/wyFf1li3R+PGyBGvuiJDKyH0k8eoNUsZlzO
	 OT60wNUwudvhQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74526ca7a46so2280712a34.2;
        Wed, 03 Sep 2025 06:41:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/p3a8EPDERcHmI1P6qQVw4oZR8D+lWTKE43U+I9nGKd3Bh0yjBpEFvhwNHgKYcfmeJnMeD1vPvewG@vger.kernel.org, AJvYcCWUZ364SPGBPTe4/uoklpvIx02dg8SQ2eRopy8vOqlAm2kLWbHdNbv9o8/em/EE5wGcgD5snmBrBKV76TZe@vger.kernel.org, AJvYcCWl37KVHw2ojYCCgcwTASgdJmwX255FBTU1XgtzYiZ8whtRGdqJa7ULenXBj489Qa666aBvAVbXfckt6Q==@vger.kernel.org, AJvYcCXMlh2r5ia4HZ3BdH5MxYUtWVSHP4GG2grYrDLb+sMMUxRD1pRbrmcG5zMYyJO9HLlG1HeGi8EbHII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAawdUAm1JBb2LnhBMTNKOlEpoBxbl0Kn0G5Cbpgu+vy5U9Tqr
	frL+WbFbN2DxC/aIPpAOdyngsOljStXfU0lioCGN415p/B2EzzfU/ywfm2YXwOMdlevDOQEZDzA
	y3kazovhWLfR2sfY183BUdWK2kBMRcYA=
X-Google-Smtp-Source: AGHT+IE8CKY9R9M90mIkT56C6rGxrcA7dBv19VhPe7gEVCnw2r6FCP2pLXabMt9+rlKIM6nRFLb5/otuT90mPVIOHdY=
X-Received: by 2002:a05:6808:8219:b0:434:97b:5eb9 with SMTP id
 5614622812f47-437f7d74afbmr6249755b6e.28.1756906898553; Wed, 03 Sep 2025
 06:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903131733.57637-1-zhangzihuan@kylinos.cn>
 <20250903131733.57637-11-zhangzihuan@kylinos.cn> <34b5e01e-2f4a-4d57-93ca-ab4549681b17@kernel.org>
In-Reply-To: <34b5e01e-2f4a-4d57-93ca-ab4549681b17@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 15:41:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hisM6vfdNXaY7qCGtcMb1FENGxiBb=E=tkqDbRyjs=bA@mail.gmail.com>
X-Gm-Features: Ac12FXyg097RI81OLcVmXs8LtZCLVL9SQzq0jRH5EJZq7nDwUhDORw8eege7vFE
Message-ID: <CAJZ5v0hisM6vfdNXaY7qCGtcMb1FENGxiBb=E=tkqDbRyjs=bA@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] PM: EM: Use scope-based cleanup helper
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Zihuan Zhang <zhangzihuan@kylinos.cn>, "Rafael J . wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
	Ben Horgan <ben.horgan@arm.com>, zhenglifeng <zhenglifeng1@huawei.com>, 
	Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
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

On Wed, Sep 3, 2025 at 3:22=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/09/2025 15:17, Zihuan Zhang wrote:
> > Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> > annotation for policy references. This reduces the risk of reference
> > counting mistakes and aligns the code with the latest kernel style.
> >
> > No functional change intended.
> >
> > Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> > ---
> >  kernel/power/energy_model.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > index ea7995a25780..99401678e809 100644
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -451,7 +451,7 @@ static void
> >  em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_stat=
e *table)
> >  {
> >       struct em_perf_domain *pd =3D dev->em_pd;
> > -     struct cpufreq_policy *policy;
> > +     struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D NULL=
;
>
> This is not really correct coding style. Please read how to use
> cleanup.h expressed in that header. You should have here proper
> constructor or this should be moved. Or this should not be __free()...

I gather that this is what you mean (quoted verbatim from cleanup.h)

 * Given that the "__free(...) =3D NULL" pattern for variables defined at
 * the top of the function poses this potential interdependency problem
 * the recommendation is to always define and assign variables in one
 * statement and not group variable definitions at the top of the
 * function when __free() is used.

and thanks for pointing this out!

