Return-Path: <linux-acpi+bounces-16655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B2B52C89
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 11:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA1F486857
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD72E7192;
	Thu, 11 Sep 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPYTV+iw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566BA2E6CA8
	for <linux-acpi@vger.kernel.org>; Thu, 11 Sep 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581310; cv=none; b=GFri+WF4Wy1PfND8qen8fSq4I3QW04/VRkGO9YjMkiTrloJLYauK2mBR6ml628OWknp0uOweNlNn9CYIYYHqfARO4noyKXsNoBikUHjwdkN0GU1ZZDe+Va2630SrgkywHpIdIGUrzM6i8KoNG0AN+f1nN3qXKDuB8giSlacSdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581310; c=relaxed/simple;
	bh=qxbp7e+9AR8Ux/3zOexCQyN5CyaAPlVDs5uMsXFj02A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GA8LCxZLnanP5UAghLkGA9tFa8sIfIcV13ldX6e37wgw23UsDYCu4NYnBbUYJ3BDyCbGFgSoL/gfoOoMEPMMhEpt3sqysD2JgJhF2u1WU3fR4DKVdhPEpU9yTp/PlqNCQBf5/34hg7Lo82lbHS8RMWq3oKPzEHFbn+TYOnNvJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPYTV+iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DFEC4CEF7
	for <linux-acpi@vger.kernel.org>; Thu, 11 Sep 2025 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757581310;
	bh=qxbp7e+9AR8Ux/3zOexCQyN5CyaAPlVDs5uMsXFj02A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rPYTV+iwgXuGwjp/bQLLjjDvBNMZaYSj2jDj4fV1Hmo5a7mi5ICWDDFiNrAgvxKup
	 viWSVPZ7Bt8O3ue+OQCd7Kw3Wghw2DYTHR/4EKKcJzvht2NdLSh0IfbVlPPsTceem2
	 cq5Ca4LFTGh63VomC3h9w2ARm307MAYpbXQAWxV7ndRFnk6Kxd+gB8BpYWkN4oTu4/
	 JJq8IWj6al4thKt2abndyKrB0a7/JwlAZTQDJ7y6WOfwCv8V0pRlHpHa7SQm4zvLBV
	 auSVFRevEiehiZfOq1hEPnKOINpZ5ByxsaXhEhrns8x9+kIT6aH+987uxmy/iKw9SF
	 UXzHaT6a3DbJQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61bd4e002afso116320eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 11 Sep 2025 02:01:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOOomnLCIfYO8yVC3Y9OHhRDcp1vIrvJQpPUWi60s3z+N0/7tGjhRHuEKCgGDcnq45Tpnc/P5shJcJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56CR8jOuytexsXjlYjNixZPuFvR2nOTFUQkJ/kXWaiq5gbf45
	NvYSdECrh9hGlSv+8EFvaVe1zlhsySIh8h9VZ2Ewi7pd9iaa6HebRn7IPT/SNCuBf4iQSD0/1BU
	ntnqpvmSwWlIHXcfBg2mT7y1iZECWgLk=
X-Google-Smtp-Source: AGHT+IFzYQyTb2IoEwLR0cafe5J8DGh3piPjf9LgxHTSThCZ1W9DpzlxIJhX79txh5ZADWhHIX6nd8Gej0v6iMMftAc=
X-Received: by 2002:a05:6820:1ace:b0:61f:f932:8d64 with SMTP id
 006d021491bc7-621789f9f7emr8400231eaf.1.1757581309120; Thu, 11 Sep 2025
 02:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2797300.mvXUDI8C0e@rafael.j.wysocki> <bb565554-f7f8-4e40-8ca4-d265f59aec9e@kernel.org>
In-Reply-To: <bb565554-f7f8-4e40-8ca4-d265f59aec9e@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 11:01:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hX6v7Zn7_mbdNWQg-muMbfz1HDA8pp1eg7Lfpx=UZjww@mail.gmail.com>
X-Gm-Features: Ac12FXx0-0bnXjtXJvznPr5PN6XI0qzTrvm767eJGc1L9O9t90vs_ilIV1vf8BE
Message-ID: <CAJZ5v0hX6v7Zn7_mbdNWQg-muMbfz1HDA8pp1eg7Lfpx=UZjww@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: ACPI: Use on_each_cpu_mask() in drv_write()
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R . Shenoy" <gautham.sheoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:38=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> On 9/9/25 6:41 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make drv_write() call on_each_cpu_mask() instead of using an open-coded
> > equivalent of the latter.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> I feel you should also update the comment before do_drv_write() to
> mention it's called with a NULL conditional to
> smp_call_function_many_cond(), or just drop that comment.

I'll drop it.

> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Thanks!

> >   drivers/cpufreq/acpi-cpufreq.c |    8 +-------
> >   1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -335,14 +335,8 @@ static void drv_write(struct acpi_cpufre
> >               .val =3D val,
> >               .func.write =3D data->cpu_freq_write,
> >       };
> > -     int this_cpu;
> >
> > -     this_cpu =3D get_cpu();
> > -     if (cpumask_test_cpu(this_cpu, mask))
> > -             do_drv_write(&cmd);
> > -
> > -     smp_call_function_many(mask, do_drv_write, &cmd, 1);
> > -     put_cpu();
> > +     on_each_cpu_mask(mask, do_drv_write, &cmd, true);
> >   }
> >
> >   static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufre=
q_data *data)
> >
> >
> >
>

