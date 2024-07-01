Return-Path: <linux-acpi+bounces-6715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6243F91E6C0
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71C71F24404
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914DA16EB59;
	Mon,  1 Jul 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAQem2J7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208277115;
	Mon,  1 Jul 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855414; cv=none; b=XHCdNfoP/z4sKMwgw3dHtMhNGzcS4ofiQKcBEeyr6UdQfaUTclsvIT0VVvjfpsntohP5jWMyE5zMQp6OnQLRcW4NX2rx5PT1zmn4yPkVNLX4xm/TQZEjK6bjRqn44TfV6XvmxUW2AJlQCrXI3p70SpZbCfB0a4g+uTymNiKRrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855414; c=relaxed/simple;
	bh=AJ43U8TxBFG1R0W4PvfAZW+pIgCbJ/wmU+LmsAUrYjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WH2iT0gGPn6LvVv8rgvk6FBaSaE2fs5T6MDhWLdR/KoxzcPz8NX1r2B1xGNMDf7PtNyH6Pa1nQoRnPvBkkU/7R2IG8zu2erw/K2yMV62tBSpf6nl9L5f9o4Z3DWS4uKjiG1QglybVBUwfwVsSVpCUQDLgDZvTGTHIMtGstcmP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAQem2J7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90DCC4AF12;
	Mon,  1 Jul 2024 17:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719855413;
	bh=AJ43U8TxBFG1R0W4PvfAZW+pIgCbJ/wmU+LmsAUrYjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GAQem2J7raFxA9lVH1y/ketnYyyQZqQuNgSlgcormbdqA2tFRR6DN/a/dm9X5gmE4
	 C0tl9VQBQr8ZDrVNlCp9IGe6wnCBdQnJtbnRlVPcbeFOMzQE/djT5Ol/0ThKZ0iviR
	 QTA1LIEvrrAJqitmAGmvFuTQ2OzGd2+tM8H0K195ySIgZ1C+f8oesPwR74lZsLzAmR
	 uwB9V+PJuHLxarOivu9iQkb59MHjnE98JlrR814m9MkBiIOizRrhpWg1/KQphZl4oY
	 g1cDEZA8Leus4rSBd+V8R4IxckGHbR5CLU0/MW+gp8syg1YkVybnyCorrkddk55gLr
	 O0Mg0T3/IxMHg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c411d037b3so81915eaf.2;
        Mon, 01 Jul 2024 10:36:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1Ul/XM1yTV2HwuuOAvoDbYYOM9CngT608aMReZF1JyfEnlk3Y8//1dqAwKwEdEKl1D1GuNkANUExULrL/gEBu7czI0G3oLnalSqAOYGfOtE4rG5DRTH/10zrSaEQdBoWGH5UWUOdhU5XZT6/lGnEk7G9wLUTqe45FQs85UBx7WA==
X-Gm-Message-State: AOJu0Ywz+OgTOEQwVSfTRT0i3NqVGxjS9cxj7AX1Ow5JJoRV1R9bYJtU
	lzYif4zRT7pQjgVJorTF7nj72H8RSFCbRkConiA46bX/GqfbgRRmk66vBHupTfXTqQ1bvOcPyxF
	++d+a9x8tFK/JB+Io4hEvQ0OWQ4o=
X-Google-Smtp-Source: AGHT+IHwSaJ1hicMo5mBvoWp89o0ASG0KBJLQ81cNcOTGZ3yBfDdae3nh4KtC0AqPvla0OZvfnqwU4SaJJoAWy55Gc8=
X-Received: by 2002:a4a:c914:0:b0:5ba:ca86:a025 with SMTP id
 006d021491bc7-5c438d51dfcmr5664269eaf.0.1719855412448; Mon, 01 Jul 2024
 10:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <46742c5a-5df4-46d1-bf5f-b74067866fec@amd.com> <20240701161039.80008-1-visitorckw@gmail.com>
In-Reply-To: <20240701161039.80008-1-visitorckw@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 19:36:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iY=S+WKWvDAAWxLcOwvpOG5Cck1gQv4p+FfW1Nca0Yqw@mail.gmail.com>
Message-ID: <CAJZ5v0iY=S+WKWvDAAWxLcOwvpOG5Cck1gQv4p+FfW1Nca0Yqw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: processor_idle: Fix invalid comparison with
 insertion sort for latency
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com, 
	akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw, alexdeucher@gmail.com, 
	belegdol@gmail.com, regressions@leemhuis.info, linux-acpi@vger.kernel.org, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 6:10=E2=80=AFPM Kuan-Wei Chiu <visitorckw@gmail.com>=
 wrote:
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
> v2 -> v3:
> - Remove #include <linux/sort.h>
> - Cc @stable
>
> Note: I only performed a build test and a simple unit test to ensure
>       the latency of valid elements is correctly sorted in the randomly
>           generated data.
>
>  drivers/acpi/processor_idle.c | 36 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index bd6a7857ce05..17cc81340b4b 100644
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
> @@ -386,25 +385,21 @@ static void acpi_processor_power_verify_c3(struct a=
cpi_processor *pr,
>         acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
>  }
>
> -static int acpi_cst_latency_cmp(const void *a, const void *b)
> +static void acpi_cst_latency_sort(struct acpi_processor_cx *arr, size_t =
length)

s/arr/states/ please.

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
> -
> -       if (!(x->valid && y->valid))
> -               return;
> -       swap(x->latency, y->latency);
> +       for (i =3D 1; i < length; i++) {
> +               if (!arr[i].valid)
> +                       continue;

Please add an empty line here (and analogously below).

> +               for (j =3D i - 1, k =3D i; j >=3D 0; j--) {
> +                       if (!arr[j].valid)
> +                               continue;
> +                       if (arr[j].latency > arr[k].latency)
> +                               swap(arr[j].latency, arr[k].latency);

And here.

> +                       k =3D j;
> +               }
> +       }
>  }
>
>  static int acpi_processor_power_verify(struct acpi_processor *pr)
> @@ -449,10 +444,7 @@ static int acpi_processor_power_verify(struct acpi_p=
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

