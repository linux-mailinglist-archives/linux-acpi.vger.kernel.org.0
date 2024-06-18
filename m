Return-Path: <linux-acpi+bounces-6504-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85D590DCBD
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 21:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539862839AE
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 19:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6316DC21;
	Tue, 18 Jun 2024 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOwRUN7j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6318F15ECFD;
	Tue, 18 Jun 2024 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740019; cv=none; b=i/4ugX7nX3Z0e+ghJzAZ7yjgiCPIE6pIe5rl4nQ0dDFBA31QCI0Ej6yw79Ansp8pke9ryqhPw9VbNuKZmugH5zKbpKBjUQcPWBXG6kjixVh+Mv1U7TfQSmHQsnQxLKctdPKyzXahySMpJra2o/Ru6A6At4XhNOr4AMRRUkfojCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740019; c=relaxed/simple;
	bh=aiweN8R/tdFh9tP/DAknkCDgF5q3E4DWtC81UsdOq8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVb4NBteUQN9RVgRhw5iGqvT6VTvF6IeQdbPgSsonxOIO4+vck7FnGQBRrWN4bGXid5G5m5JxlC+s9nFWSq4Hpdi1xCkPWTY/pIS0XxIXsZgoasEuY+bS7mearue6aOzgOz5cROAUUK+ZsTucGXKTAjWJkewtKFo/RYsgWtfGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOwRUN7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CBAC4AF1C;
	Tue, 18 Jun 2024 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718740019;
	bh=aiweN8R/tdFh9tP/DAknkCDgF5q3E4DWtC81UsdOq8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jOwRUN7js75Taukqp7gPAkHipNPzWCDe2Uf5YbmxYv35fShcsSQiXevAM3zRVGQj6
	 PobX5Oysm9UQ37ZzIH7ebqL5XDF/oUXoDpFaJpQckiL4EIa+GjJyIFkV94pcbspHhV
	 Wse4zEyUfMrr4AGaXBACED6YMI237HN5FkK/so+ZF1n8akLRU9UwhoOOuj7DQvbQ7w
	 ML3/6ljvsXatah74gCD14g9FK17MBtMfSJpYoFYkJYg4HQ+L4Rsdu8J/RT8I6AMvmA
	 ISQkIpscXBb9U495uFQRey+o1X4G8zUjIH6VA2cBxuN1ELwT+woeY4G5rchtB0JA9B
	 1F1XBms1/6sBg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5bad7941dcfso326455eaf.3;
        Tue, 18 Jun 2024 12:46:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/ifHYlZqKsdg8Gdu2UAE2V5t90oZPJP4dP0YpwaQ/2mP/geKK+yRdFt9p/X9dal0Xo70UGZQJNG6GksqbKuHCAllv8W4QNk77ZdSARBoo2PGDxromg6FqBILwvPMPU05Y6aM+WIObvA==
X-Gm-Message-State: AOJu0YxmwcQEuPwQA0py1zZCT2YdsLB7StcLok3iDewg7geHRMEIjugb
	vz5s3q+T/l6D1AhccmnxGCPY8ykNEkBH8KGcbCH3UjcEcKjZuCa+XkUzF2XNFg+cL1NjNMlgdgT
	zyHLOeBEeD/lMQvsfogUa/4J+dHI=
X-Google-Smtp-Source: AGHT+IF+vr1jR35veCH/PAscHVF1nHi8FYG1cX55iyLK03KK8llcRZc9D/G7OanVNXebl308gN/LJJzK1mNaUMIqEhw=
X-Received: by 2002:a05:6871:5823:b0:250:826d:5202 with SMTP id
 586e51a60fabf-25c94d792d0mr857583fac.3.1718740018130; Tue, 18 Jun 2024
 12:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614193241.7341-1-mario.limonciello@amd.com>
 <CAJZ5v0gMcR1wkOMkd5kHp8BZKdZd-HE9DrxByP9puCK-OUfGPA@mail.gmail.com> <50fcefb1-e910-435d-be0d-d0f45071d179@amd.com>
In-Reply-To: <50fcefb1-e910-435d-be0d-d0f45071d179@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Jun 2024 21:46:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iFUBb41i8rRX3kN_PHL7b=s8LFPvQXRguc1jyeZ+1J7Q@mail.gmail.com>
Message-ID: <CAJZ5v0iFUBb41i8rRX3kN_PHL7b=s8LFPvQXRguc1jyeZ+1J7Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Only evaluate the Intel _OSC and _PDC on platforms
 with HWP
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, CL Lin <clin41@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 9:33=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 6/15/2024 05:38, Rafael J. Wysocki wrote:
> > On Fri, Jun 14, 2024 at 9:33=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> The UUID 4077A616-290C-47BE-9EBD-D87058713953 and _PDC methods are
> >> only used on Intel platforms with HWP support.
> >
> > I beg to differ.  See arch_acpi_set_proc_cap_bits() definition.
>
> Ah I see; thanks for sharing.  I agree with you.
>
> >
> >> Attempting to evaluate them and showing messages on hardware without
> >> HWP is pointless needlessly noisy.
> >>
> >> Gate the code on X86_FEATURE_HWP.
> >
> > Not really.
>
> I guess this really started getting noisy in 6.6 (9527264).
>
> Would you be open to downgrading to debug instead?

That would be fine, thanks!


> >
> >> Cc: PradeepVineshReddy (Pradeep Vinesh Reddy) Kodamati <PradeepVineshR=
eddy.Kodamati@amd.com>
> >> Suggested-by: CL Lin <clin41@lenovo.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/acpi/acpi_processor.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_process=
or.c
> >> index 7a0dd35d62c9..84848b5e65d6 100644
> >> --- a/drivers/acpi/acpi_processor.c
> >> +++ b/drivers/acpi/acpi_processor.c
> >> @@ -597,6 +597,8 @@ static bool __init acpi_early_processor_osc(void)
> >>
> >>   void __init acpi_early_processor_control_setup(void)
> >>   {
> >> +       if (!boot_cpu_has(X86_FEATURE_HWP))
> >> +               return;
> >>          if (acpi_early_processor_osc()) {
> >>                  pr_info("_OSC evaluated successfully for all CPUs\n")=
;
> >>          } else {
> >> --
> >> 2.43.0
> >>
>

