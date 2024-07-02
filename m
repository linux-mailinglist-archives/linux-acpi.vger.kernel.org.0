Return-Path: <linux-acpi+bounces-6741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF1292475D
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 20:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC491C245B6
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0011C9EC2;
	Tue,  2 Jul 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVsrmKKN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AD158DD1;
	Tue,  2 Jul 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945526; cv=none; b=oVXEE4v8Qjarto6S0S6q82WHxpJIxEVlFWkpDG71r6Id3oXQvxX9zAEb3urT1hu03mmxMmNAhJUX7PwE80DCO6H0yu3dwD0CnhIj9UCyo9T8T1rbUYK46W/rut02T8CyQrY+khKO6KLb3SBfCwzrjmmXtRWK0W1t4kVza+vkxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945526; c=relaxed/simple;
	bh=uAwmHr9SLo21MJ+46qLqwlvwev386jzirLkNTASJ850=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEMo9ZRp/IVk/oOD0B4eXHm+yifW5X1gKxWR98KM8v3OJIlivXX19gL2HDDn6q7Nbg6zfm01DIxnOvC4CWN0wE5udDxbnyfoLkFWndkfohji1zcUq1FUrFAN+FD+9yR1NoJqxy+uAWP5GGMcLEqbI5Lrocsju6+Sv6eCjTKeTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVsrmKKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFC5C4AF12;
	Tue,  2 Jul 2024 18:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945526;
	bh=uAwmHr9SLo21MJ+46qLqwlvwev386jzirLkNTASJ850=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LVsrmKKNbiFg4S4kUGs6bUi9H9GAYGPsZRlzox88UeEMfh6td6pwacbSoQRxhUANX
	 jiD1qNCoj30YX5QnY8OON0pGSoIuZClhx7tVTCPICOzihA5L5UPb50G2Dh7t7ZBreg
	 X4EHi1lY1IqzEERrqK81N3iNvwFsYaabSJTeP4nxuDOpqtxDisthm1ctzKCFpBpKNi
	 DVR/7a2nXVmmvVUDzvdCBltw5RKsk7mb62lrsV/xlTFsGECckmxIwU8l/j/KwB35GC
	 JolrqtqU3cYukRG90OWW0gggj/AWonFpe9py4MkGNuzQBEx65u1ikQMbFYaHZYOytj
	 v+iYYn+4IpVUw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c411d037b3so103932eaf.2;
        Tue, 02 Jul 2024 11:38:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWg5w6Qs8JqYQykfiQWI1UAqPALm4iEn0fdP+KXHK8h59dUsMwsl0praVupBmLl2Uvz7wLdIU99ISdEPjWqNeTKWBdUl+lop/hMNoGs4U/HeARsu9K1bqA3epvBfmBIq2+BBe232/7FZq8MKw3piJnmTuTTdvAD+YpvLL50pHkS3w==
X-Gm-Message-State: AOJu0YxuIGT1Fng8hKH8nqz05qtfqiZh4nKOf4fX0pg+M4Lnyc5beiLg
	IFHKznqe2Jzm+fjXb1c7e2NpFwuUvIcaMn/NCDMba62YuwP8sUt+xc9OwAxPDPRox4lSEo/G1Ax
	MBS0aE4/aO00wMWop8rLuXajlkjo=
X-Google-Smtp-Source: AGHT+IEGZaz0dhzEOPrGPinIraLvKWqZp3vSG9m+75+eb78BO5DkX/qAj5bvNyyPM2whqBQC6B6rCfMqFgPfeLiYAYs=
X-Received: by 2002:a4a:b3c4:0:b0:5c2:20aa:db25 with SMTP id
 006d021491bc7-5c438e43fa9mr9084162eaf.1.1719945525318; Tue, 02 Jul 2024
 11:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iY=S+WKWvDAAWxLcOwvpOG5Cck1gQv4p+FfW1Nca0Yqw@mail.gmail.com>
 <20240701205639.117194-1-visitorckw@gmail.com>
In-Reply-To: <20240701205639.117194-1-visitorckw@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 20:38:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gKqH83dedAxOfK9b7bym8ApjnF7kLAME37Lqss+FwrwQ@mail.gmail.com>
Message-ID: <CAJZ5v0gKqH83dedAxOfK9b7bym8ApjnF7kLAME37Lqss+FwrwQ@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: processor_idle: Fix invalid comparison with
 insertion sort for latency
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com, 
	akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw, alexdeucher@gmail.com, 
	belegdol@gmail.com, regressions@leemhuis.info, linux-acpi@vger.kernel.org, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 10:56=E2=80=AFPM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> The acpi_cst_latency_cmp comparison function currently used for sorting
> C-state latencies does not satisfy transitivity, causing incorrect
> sorting results. Specifically, if there are two valid acpi_processor_cx
> elements A and B and one invalid element C, it may occur that A < B,
> A =3D C, and B =3D C. Sorting algorithms assume that if A < B and A =3D C=
,
> then C < B, leading to incorrect ordering.
>
> Given the small size of the array (<=3D8), we replace the library sort
> function with a simple insertion sort that properly ignores invalid
> elements and sorts valid ones based on latency. This change ensures
> correct ordering of the C-state latencies.
>
> Fixes: 65ea8f2c6e23 ("ACPI: processor idle: Fix up C-state latency if not=
 ordered")
> Cc: stable@vger.kernel.org
> Reported-by: Julian Sikorski <belegdol@gmail.com>
> Closes: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df=
@gmail.com/
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> v3 -> v4:
> - Rename the parameter 'arr' to 'states'.
> - Add empty lines to enhance readability.
>
> Note: I only performed a build test and a simple unit test to ensure
>       the latency of valid elements is correctly sorted in the randomly
>       generated data.
>
>  drivers/acpi/processor_idle.c | 37 +++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index bd6a7857ce05..831fa4a12159 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -16,7 +16,6 @@
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <linux/sched.h>       /* need_resched() */
> -#include <linux/sort.h>
>  #include <linux/tick.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpu.h>
> @@ -386,25 +385,24 @@ static void acpi_processor_power_verify_c3(struct a=
cpi_processor *pr,
>         acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
>  }
>
> -static int acpi_cst_latency_cmp(const void *a, const void *b)
> +static void acpi_cst_latency_sort(struct acpi_processor_cx *states, size=
_t length)
>  {
> -       const struct acpi_processor_cx *x =3D a, *y =3D b;
> +       int i, j, k;
>
> -       if (!(x->valid && y->valid))
> -               return 0;
> -       if (x->latency > y->latency)
> -               return 1;
> -       if (x->latency < y->latency)
> -               return -1;
> -       return 0;
> -}
> -static void acpi_cst_latency_swap(void *a, void *b, int n)
> -{
> -       struct acpi_processor_cx *x =3D a, *y =3D b;
> +       for (i =3D 1; i < length; i++) {
> +               if (!states[i].valid)
> +                       continue;
>
> -       if (!(x->valid && y->valid))
> -               return;
> -       swap(x->latency, y->latency);
> +               for (j =3D i - 1, k =3D i; j >=3D 0; j--) {
> +                       if (!states[j].valid)
> +                               continue;
> +
> +                       if (states[j].latency > states[k].latency)
> +                               swap(states[j].latency, states[k].latency=
);
> +
> +                       k =3D j;
> +               }
> +       }
>  }
>
>  static int acpi_processor_power_verify(struct acpi_processor *pr)
> @@ -449,10 +447,7 @@ static int acpi_processor_power_verify(struct acpi_p=
rocessor *pr)
>
>         if (buggy_latency) {
>                 pr_notice("FW issue: working around C-state latencies out=
 of order\n");
> -               sort(&pr->power.states[1], max_cstate,
> -                    sizeof(struct acpi_processor_cx),
> -                    acpi_cst_latency_cmp,
> -                    acpi_cst_latency_swap);
> +               acpi_cst_latency_sort(&pr->power.states[1], max_cstate);
>         }
>
>         lapic_timer_propagate_broadcast(pr);
> --

Applied as 6.10-rc material, thanks!

