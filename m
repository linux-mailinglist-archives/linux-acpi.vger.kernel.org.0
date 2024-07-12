Return-Path: <linux-acpi+bounces-6865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA892F818
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720AE281D78
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9374D14884E;
	Fri, 12 Jul 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLPjIF7J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10E143C6E;
	Fri, 12 Jul 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777217; cv=none; b=Buiyc2wvpySBTY6+OloJHSyOQrA9kcybXW1olRESa3Fny5wqf812nyK9Rl9sFakzxYri7wxzD0NCSwPGYS1X4T47Lb7/9rNijF8DVbbr3UxGh4fC1cl9V/uSl3jBoqipq3qviS1JtyQeALg7TPfGTu7Mm1oNpvh26QdvjTeMUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777217; c=relaxed/simple;
	bh=0QB4avtqHAByN9Y/i8mu+GJUKZUD7/BNSTgpqU9Kt0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9RtEsQJYsgywKOB76uclqBxvOF4/gHcrlL21fu1sQXe5+qiZe8QkzK9MBv9x+iI+wPJurYlXL9/M8WaRbKQeWSSQi4tHSaEYq1rockvrlUbb4sOynCTQxfo+M84ZiJ7AZVhXR+QAWd1xKkqTWC48G9domZn6guipSoFEEGJutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLPjIF7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46A6C4AF0B;
	Fri, 12 Jul 2024 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720777216;
	bh=0QB4avtqHAByN9Y/i8mu+GJUKZUD7/BNSTgpqU9Kt0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FLPjIF7JNbVupl7884yK+FwM2TxooTjLKaA4sd/uigakeIBP89NOytxLO3wp1g5Xe
	 JMrGPBXpKpeVghpqk7XnBPVu65MOGLlEr+dTt5AnKVG6BxGFIA2QLv5LAg4VSdeOtA
	 zJZYjRi8U8zFUmiwJKaf3Zevjq3Rm+z3OSjKh3wJhPiBsHua6i1kRw7CB2WI2gBW6Q
	 jkgJHwayT1McgLLb8xSgdshlHYsEfZZ5BA+yJa0sV1W4KBLgnf4isygCRwn3InQ5ux
	 n99bKorxL6i9Jnw4BfqhEHgZ4eLe5VBPNj1QA7JF0Y+cH7WJUU8XpAd8SIalgZnGqk
	 CsVHhGXfdpIWQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c680f40faeso49850eaf.1;
        Fri, 12 Jul 2024 02:40:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIB8o7YD99s7wDqw47/9CwWSsLpniS46Bm3XiBE4OWtVi2uAxDmUg/TKE0S60yJxf7MmtQkzB8nfO4385fcz+LXayK9Y6IYpHBk5nZoh/0IOVISJzLHIFpaVaaL5xliS8a9IHGSfjxkA==
X-Gm-Message-State: AOJu0Yy3Q6qGB00wMwRk2RO2S/sMrqOeevIwkf+idZkWt5dfHc6tyU13
	UV7oo9C19ViIptZ8hrSCMdcTrbpSGpV7Ew0E4sYSWjcHoh72uGozCQVuuQIXM7izs7TpARohqSY
	pGPD3Ib5vwNRJzyzsXIHFK22/2SI=
X-Google-Smtp-Source: AGHT+IEdhCaEWm8tJiXywb0s1a3ZSyKgNu5DyhAYYzrFaZq8wv5wjQ5n5SaUqhfGoTbY5Fdoi4gdY6AJTTGZvtWNZqE=
X-Received: by 2002:a4a:e088:0:b0:5cd:13e0:b0d3 with SMTP id
 006d021491bc7-5cd13e0b282mr857068eaf.2.1720777216176; Fri, 12 Jul 2024
 02:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-fix-modpost-warning-default_dram_nodes-v1-1-8961453cc82d@kernel.org>
 <87jzhsa05p.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87jzhsa05p.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Jul 2024 11:40:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gHHkFnJEf2CQ5Rmz9+_7u1EqBPiycuFL1huPJf9Pvc6Q@mail.gmail.com>
Message-ID: <CAJZ5v0gHHkFnJEf2CQ5Rmz9+_7u1EqBPiycuFL1huPJf9Pvc6Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: HMAT: Mark hmat_set_default_dram_perf() as __init
To: "Huang, Ying" <ying.huang@intel.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Ho-Ren Chuang <horen.chuang@linux.dev>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 8:56=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Nathan Chancellor <nathan@kernel.org> writes:
>
> > After commit 4dc70b711dbc ("memory tier: consolidate the initialization
> > of memory tiers"), there is a modpost warning when
> > hmat_set_default_dram_perf() is not inlined into its callsite, as it
> > appears that default_dram_nodes may be accessed after its memory has
> > been freed.
> >
> >   WARNING: modpost: vmlinux: section mismatch in reference: hmat_set_de=
fault_dram_perf+0x18 (section: .text) -> default_dram_nodes (section: .init=
.data)
> >
> > The single callsite, hmat_init(), is __init, so this warning is not a
> > problem in reality but it is easily solvable by marking
> > hmat_set_default_dram_perf() as __init, which should have been done whe=
n
> > this function was added in commit 3718c02dbd4c ("acpi, hmat: calculate
> > abstract distance with HMAT").
>
> Good catch!  Thanks for your fix!  If it's necessary, feel free to add
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Thanks for the patch and the review!

I'm expecting Dan/Dave to take care of it (or please let me know if
I'm expected to pick it up).

> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202406292310.hlRATeZJ-lkp=
@intel.com/
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > I left off a fixes tag as I assume this is going to be squashed into th=
e
> > former change mentioned above, as it is still in mm-unstable, but feel
> > free to add one if the patch is going to be standalone.
> > ---
> >  drivers/acpi/numa/hmat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index a2f9e7a4b479..ca0c0ea3e1ef 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -933,7 +933,7 @@ static int hmat_callback(struct notifier_block *sel=
f,
> >       return NOTIFY_OK;
> >  }
> >
> > -static int hmat_set_default_dram_perf(void)
> > +static __init int hmat_set_default_dram_perf(void)
> >  {
> >       int rc;
> >       int nid, pxm;
> >
> > ---
> > base-commit: 17bcc624e67da6383060ee24483db77aa17276aa
> > change-id: 20240710-fix-modpost-warning-default_dram_nodes-38b6faffe3da
> >
> > Best regards,
>
> --
> Best Regards,
> Huang, Ying
>

