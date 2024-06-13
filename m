Return-Path: <linux-acpi+bounces-6377-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683D0907BC0
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D2F2852CC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 18:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFD814A09C;
	Thu, 13 Jun 2024 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BexmCDAv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E56139CFE;
	Thu, 13 Jun 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304566; cv=none; b=dIm8QPOKk2hqItcnhV+wzOxacbk2dRRJpMf3EAywlcsGE7dQ2WUvPKvtKCn+PxVEwMJ57VX60AsV1E6uhPvsIZ4BtwlPxScwPmoIIusjxbpLJxEm6yRA/dcB7UZEUIiKyyS0t2TUQOji7a16hF0qBjiywno3pQsz6JMROm1XPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304566; c=relaxed/simple;
	bh=2ik+Qo/zt+8LDrO1DIrupts/0wjBHoGmG3SQ2ZnUMPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyY5q9SRDwi0MmLuciWdmGSOZqamRxr5qsWIEyZR4KNL/JjCP6p76+0SxVMF73JUGK2Tq+DsH+OMDwJDO06qQBy5ASJwJlljTXaffkntjEzxQxqSMCIXGaR/AusJOHxZstpJJFrFZ/k4x3KxAnkwJQU2PVs+u2ywJ69OV0vHJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BexmCDAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1658C2BBFC;
	Thu, 13 Jun 2024 18:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718304565;
	bh=2ik+Qo/zt+8LDrO1DIrupts/0wjBHoGmG3SQ2ZnUMPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BexmCDAvSVztnWtbz+Hq45Tl24kb7DVWbuZSyn0W4Nd7c7N1VlfrOu/bLYwK25kOA
	 NKoXoIkRmcoL/Farwe38kFs/Txuf+ZLDyOrhvuHylJT+36XI9/tyfg7nJCrAx+2lVD
	 ZZaZa3/oLlm4pI2ZYcwKhgL08jmzNhJdYuJsFYMhAzGumPgQnWsc+xwWmwz5JPzrdX
	 hPBNmkG7+5ZShiDekJ4EfW2+j1oZdEld/Jl9RPm5NtBwIPWT1Ns8HIFUXTWb+VAgmM
	 icKLuOa1Ol/lf7mXwIS2yOpGeTeHPMHUDWqkfzLo88zV/HnkXnMNYUgjL8ezHspbPc
	 aN68Ziv7IDMkw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5baf76164fbso79666eaf.1;
        Thu, 13 Jun 2024 11:49:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWewWgfF9lovCs30gjw8LYG+AVHHZQR7SVm7ialVS9DRim0n++0blltoCxMoZBaWqxtDgl8Fhd1JBDbuC6vuNuBLcSFWYmoXFq4g8IYt5j7SrrAGGWiN0syxQ7jx/ZTm8TI2oL5vIRg0A==
X-Gm-Message-State: AOJu0YyMX5nu9GVpCvNQlP3gse4yfgEfkcxx8wucYDWkfYl3C4QMSw+3
	sxGGBZN4BfexeTyAD/CJs99mv0xSzZr8jUkiYg5ikdextW2n0QpdHLUzzjK2GIl42vShevaQhRM
	t2K6As4Z+rghYvB6YfzgTqRTbH/8=
X-Google-Smtp-Source: AGHT+IG+y1NnFsf9CL5HTejz+JcY60pm4OiJTuauWfmWi2ByDCXBhv1Q765cmL9PMKVMH44b9X/MQGmoZJqncbi7gOo=
X-Received: by 2002:a4a:d6cd:0:b0:5bd:af39:c9d9 with SMTP id
 006d021491bc7-5bdaf39caa2mr120946eaf.0.1718304565026; Thu, 13 Jun 2024
 11:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609210908.4470-1-W_Armin@gmx.de>
In-Reply-To: <20240609210908.4470-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 20:49:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ikNSWKsy6Z_WPX8SkBt2mKb0HH6WuWhs4ZUFeO245E4Q@mail.gmail.com>
Message-ID: <CAJZ5v0ikNSWKsy6Z_WPX8SkBt2mKb0HH6WuWhs4ZUFeO245E4Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acpi_pad: Still evaluate _OST when _PUR evaluation fails
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 11:09=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> The ACPI specification says that if no action was performed when
> processing the _PUR object, _OST should still be evaluated, albeit
> with a different status code.
>
> Evaluate _OST even when evaluating _PUR fails, to signal the firmware
> that no action was performed.
>
> Compile-tested only.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/acpi_pad.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index bd1ad07f0290..350d3a892889 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -25,6 +25,10 @@
>  #define ACPI_PROCESSOR_AGGREGATOR_CLASS        "acpi_pad"
>  #define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
>  #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
> +
> +#define ACPI_PROCESSOR_AGGREGATOR_STATUS_SUCCESS       0
> +#define ACPI_PROCESSOR_AGGREGATOR_STATUS_NO_ACTION     1
> +
>  static DEFINE_MUTEX(isolated_cpus_lock);
>  static DEFINE_MUTEX(round_robin_lock);
>
> @@ -382,16 +386,23 @@ static void acpi_pad_handle_notify(acpi_handle hand=
le)
>                 .length =3D 4,
>                 .pointer =3D (void *)&idle_cpus,
>         };
> +       u32 status;
>
>         mutex_lock(&isolated_cpus_lock);
>         num_cpus =3D acpi_pad_pur(handle);
>         if (num_cpus < 0) {
> -               mutex_unlock(&isolated_cpus_lock);
> -               return;
> +               /* The ACPI specification says that if no action was perf=
ormed when
> +                * processing the _PUR object, _OST should still be evalu=
ated, albeit
> +                * with a different status code.
> +                */
> +               status =3D ACPI_PROCESSOR_AGGREGATOR_STATUS_NO_ACTION;
> +       } else {
> +               status =3D ACPI_PROCESSOR_AGGREGATOR_STATUS_SUCCESS;
> +               acpi_pad_idle_cpus(num_cpus);
>         }
> -       acpi_pad_idle_cpus(num_cpus);
> +
>         idle_cpus =3D acpi_pad_idle_cpus_num();
> -       acpi_evaluate_ost(handle, ACPI_PROCESSOR_AGGREGATOR_NOTIFY, 0, &p=
aram);
> +       acpi_evaluate_ost(handle, ACPI_PROCESSOR_AGGREGATOR_NOTIFY, statu=
s, &param);
>         mutex_unlock(&isolated_cpus_lock);
>  }
>
> --

Applied as 6.11 material, thanks!

