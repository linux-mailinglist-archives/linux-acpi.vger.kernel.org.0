Return-Path: <linux-acpi+bounces-20382-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9441AD24A94
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 14:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F86530249E1
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEF239E184;
	Thu, 15 Jan 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1pDuuBi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8A39C65B
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482385; cv=none; b=EWdog08+Gh5R3u+kKwoziuE2gXpyH/DDftdeF2J47+xd8TcY/DpP89oQQcqJVkskjvkhZvDq9j8bI/4GqlJ9aawPPkZ3rx9Zgz6GR6SqSobOlffvD1rzqjug6aSsmGpPMgfxEVTeHKTJt9SlPtU9+0RzIYAQdFTMkVp0EKjh4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482385; c=relaxed/simple;
	bh=+rDv8sjG1JO+Ybz6Ohrc4oxoGy5Ta+Ha10MKEHl0vKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZhsc7ON+oMi5e8ThNOZH/3bJPJb8N+jCzvLonfSf9sfbseeYHY8vOzU4QKV5NrAmYHDCBb8cTnSrX/qFbfKY0fBvZK2u7eAwHmUAfxuLc4EOiloUq+UUJpllwRo/23T6YwDPyVKHyDi27+DnxmyqR3l9VmWpvqhQWQwF8FbxWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1pDuuBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C417C19424
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768482385;
	bh=+rDv8sjG1JO+Ybz6Ohrc4oxoGy5Ta+Ha10MKEHl0vKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X1pDuuBiOWhlezYzM7qTq/gcrHUiD1hCPrDwZ1z4zM7AF4y6M7rc2sM/7Ukmcoyu6
	 MD39L1MMtLAO09BBDsKvgEhGdULJjPYtOPUNwi1VlHF/R3TxL0m8FM693sJweH92CH
	 p1puJF971FoPBovXMiKHP7ISKMcomB6oA38/LDFEu7LSx41eIGJaND6dAryQAKv41D
	 D56DhQGalufLYDzO+WC75CmzioNAOS6lx527dixQtZEdogosALTkttVJMFnenGeGfv
	 6VgWWFX96wwj/wegvs/FmpYkDpXzFsxhXuRDNxm5XeaRKgnKPPTbn5yk9QQgMI30Hu
	 tqk338cXNLruA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45c89d754dfso308561b6e.1
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 05:06:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6oyZHW95foLWTW2SpcDRD8HjausK9A/SASy67EHvDxPEYR4FQSusfPr+UZsLqrn0JLx+VjQTtC/RL@vger.kernel.org
X-Gm-Message-State: AOJu0YwAVWrtNYYyB9RgvUBG+jEmo+Max6h2ooqqUe3+GAwukGNX7FyE
	opvbFucPTPNiXE2mC/j6qkQB+Ez1bpfkPQjr5bjSak/f64Bnn2um2u6BckIVnjFmaaedMPzDDfw
	Npods5JB08W3XmKOKuBZmcBVFfq3/qMo=
X-Received: by 2002:a05:6830:4ac5:b0:7cf:d91b:c49e with SMTP id
 46e09a7af769-7cfd91bc670mr881361a34.18.1768482384068; Thu, 15 Jan 2026
 05:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125065210.3670266-1-lihuisong@huawei.com>
 <20251125065210.3670266-2-lihuisong@huawei.com> <CAJZ5v0j9Mp5AqQwpakVLWDmK10cjOOiKtetfCr2OSSukekdPhQ@mail.gmail.com>
 <2b1a456f-b9e3-4722-84ba-ba4fdd4b2ece@huawei.com>
In-Reply-To: <2b1a456f-b9e3-4722-84ba-ba4fdd4b2ece@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jan 2026 14:06:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hfwWCSOdyhqn_ZHGnHrbZ1YcXk8t5o8=cGXDbc1WfnEw@mail.gmail.com>
X-Gm-Features: AZwV_QjNRYF4sFwqyMbPfNlmzw1FiCm9B0qYJ4bV3EaKo1e5WBRdIqDG8teAe8s
Message-ID: <CAJZ5v0hfwWCSOdyhqn_ZHGnHrbZ1YcXk8t5o8=cGXDbc1WfnEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: processor: idle: Relocate and verify acpi_processor_ffh_lpi_probe
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 1:09=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
> Hi Rafael,
>
> On 1/15/2026 1:27 AM, Rafael J. Wysocki wrote:
> > On Tue, Nov 25, 2025 at 7:52=E2=80=AFAM Huisong Li <lihuisong@huawei.co=
m> wrote:
> >> The platform used LPI need check if the LPI support and the entry
> >> method is valid by the acpi_processor_ffh_lpi_probe(). But the return
> >> of acpi_processor_ffh_lpi_probe() in acpi_processor_setup_cpuidle_dev(=
)
> >> isn't verified by any caller.
> >>
> >> What's more, acpi_processor_get_power_info() is a more logical place f=
or
> >> verifying the validity of FFH LPI than acpi_processor_setup_cpuidle_de=
v().
> >> So move acpi_processor_ffh_lpi_probe() from the latter to the former a=
nd
> >> verify its return.
> >>
> >> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >> ---
> >>   drivers/acpi/processor_idle.c | 10 ++++++++--
> >>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_id=
le.c
> >> index 5f86297c8b23..cdf86874a87a 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -1252,7 +1252,7 @@ static int acpi_processor_setup_cpuidle_dev(stru=
ct acpi_processor *pr,
> >>
> >>          dev->cpu =3D pr->id;
> >>          if (pr->flags.has_lpi)
> >> -               return acpi_processor_ffh_lpi_probe(pr->id);
> >> +               return 0;
> >>
> >>          acpi_processor_setup_cpuidle_cx(pr, dev);
> >>          return 0;
> >> @@ -1264,7 +1264,13 @@ static int acpi_processor_get_power_info(struct=
 acpi_processor *pr)
> >>
> >>          ret =3D acpi_processor_get_lpi_info(pr);
> >>          if (ret)
> >> -               ret =3D acpi_processor_get_cstate_info(pr);
> >> +               return acpi_processor_get_cstate_info(pr);
> >> +
> >> +       if (pr->flags.has_lpi) {
> >> +               ret =3D acpi_processor_ffh_lpi_probe(pr->id);
> >> +               if (ret)
> >> +                       pr_err("Processor FFH LPI state is invalid.\n"=
);
> >> +       }
> >>
> >>          return ret;
> >>   }
> >> --
> > Please reorder this behind the next patch in the series.
> Patch 2/3 depends on this patch.
> So I don't know how to reorder this patch.

I should have been more precise, sorry.

Please first convert acpi_processor_setup_cpuidle_dev() to a void
function and then make the changes from this patch on top of that.

