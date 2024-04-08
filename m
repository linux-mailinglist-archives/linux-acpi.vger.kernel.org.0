Return-Path: <linux-acpi+bounces-4757-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6595089C778
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20373283EF2
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B013EFFB;
	Mon,  8 Apr 2024 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuoBhsmx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9913EFEC
	for <linux-acpi@vger.kernel.org>; Mon,  8 Apr 2024 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587739; cv=none; b=lgAzlMWscJjzvq7YZFlNumPF3AGb6w+CkfejmD1j/ZoiYvaBOPeqs8JDzAMSzzqoPX4M11O60DGT+pgTMgGU6MI/lTxihcRzhTbNSIQPTpe+gz8spbAP8c5LNpe14J4lLCcYa/SvdFRCgdxZF+RYYgjFqz3HrFrtRs9MLTYMUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587739; c=relaxed/simple;
	bh=s7HDm5zS3QP8RruO1RbKEF3rqpjETLZuHiFLYpk8s8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpBolOHQKLYejhlMAzM+T3Op7N/4TvEJa5NN7zE7rURx/T87vokvQ1138ObjgFS1JnAC7BG3qKwjQP9wte2IIUuIHqw3WrGfMHFv89EBdOtxyU6PfQ+3lZtAw1ks8YKz+khfZUf7KXkSO3pShhsmp4zIA2ZnUpcnj3ckVMVhPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuoBhsmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842CFC433F1
	for <linux-acpi@vger.kernel.org>; Mon,  8 Apr 2024 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712587738;
	bh=s7HDm5zS3QP8RruO1RbKEF3rqpjETLZuHiFLYpk8s8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UuoBhsmxvmb/sE/iZLgz/w53P8jq9O0Mb85MMHhyhNzIqiU8B3TruNsibLPmuWI69
	 uU5yDKC2ML8oJRH+aYC8OKp21PyaFgrAHvIoVvK0XwhdoP/h1Z8eQNDtXoHJ4akfUv
	 RU06NLMAr3FB+xxXDMvHEVIxdFw/N7fu4eG+gFO5i+x76xmgkAhnP4JGKT+Md0I9hk
	 nEXvUkPpe8hx2VGeO44UvkDS6Xijux0Np+CYEVRZ6EzNFJts7nvwZCr6QJryLCs6C/
	 FcoMcHPhM9SuDSXh1OCb2S+Tzv8tY6nuoSTMXm981vgNh7I3us/81s0omarV3rx0nj
	 Pnfd1LeKLr9XQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ea1572136eso450154a34.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 Apr 2024 07:48:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5ka+NYdmsX50VJgzjB58ik2wshBNZ3uO2U7i3MPExhLMVC9rv61WtUrHVfPJ4ML6bZhFslvR1f0N6H9F24I9t19lQK0cCY6tdsw==
X-Gm-Message-State: AOJu0Yw/wpIjeOqoaNEZeuB3dwBdS/9E+hfVtK9rRxJIWh/RRJzK4v39
	c0e9UkpwH/zqdhtrBjB/cwrr7dFLHbZNbG4x3KcLzNSPly5opMrz+ZK+rFyTlacU8qF5J2CWYhU
	Mxx16eBRnPQQTAeowVJ2p/QQ3nnE=
X-Google-Smtp-Source: AGHT+IGl2dRwjeDWf3qdNh7spp35IWsWt/WuWiAUgS7cTpmY89eN4E6LUZETkO5m9D6ssvbo7pOb5yK2488L4u4yvb0=
X-Received: by 2002:a05:6808:15a2:b0:3c5:d3eb:2c1b with SMTP id
 t34-20020a05680815a200b003c5d3eb2c1bmr9404376oiw.2.1712587737860; Mon, 08 Apr
 2024 07:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406114052.4884-1-hdegoede@redhat.com>
In-Reply-To: <20240406114052.4884-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:48:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iApfHiCJ-_9eLE9yuZa8RD3vQ+5aBZjpFpnzMS4+TbvQ@mail.gmail.com>
Message-ID: <CAJZ5v0iApfHiCJ-_9eLE9yuZa8RD3vQ+5aBZjpFpnzMS4+TbvQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Do not increase dep_unmet for already met dependencies
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 1:43=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> On the Toshiba Encore WT10-A tablet the BATC battery ACPI device depends
> on 3 other devices:
>
>             Name (_DEP, Package (0x03)  // _DEP: Dependencies
>             {
>                 I2C1,
>                 GPO2,
>                 GPO0
>             })
>
> acpi_scan_check_dep() adds all 3 of these to the acpi_dep_list and then
> before an acpi_device is created for the BATC handle (and thus before
> acpi_scan_dep_init() runs) acpi_scan_clear_dep() gets called for both
> GPIO depenencies, with free_when_met not set for the dependencies.
>
> Since there is no adev for BATC yet, there also is no dep_unmet to
> decrement. The only result of acpi_scan_clear_dep() in this case is
> dep->met getting set.
>
> Soon after acpi_scan_clear_dep() has been called for the GPIO dependencie=
s
> the acpi_device gets created for the BATC handle and acpi_scan_dep_init()
> runs, this sees 3 dependencies on the acpi_dep_list and initializes
> unmet_dep to 3. Later when the dependency for I2C1 is met unmet_dep
> becomes 2, but since the 2 GPIO deps where already met it never becomes 0
> causing battery monitoring to not work.
>
> Fix this by modifying acpi_scan_dep_init() to not increase dep_met for
> dependencies which have already been marked as being met.
>
> Fixes: 3ba12d8de3fa ("ACPI: scan: Reduce overhead related to devices with=
 dependencies")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/scan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7c157bf92695..d1464324de95 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1843,7 +1843,8 @@ static void acpi_scan_dep_init(struct acpi_device *=
adev)
>                         if (dep->honor_dep)
>                                 adev->flags.honor_deps =3D 1;
>
> -                       adev->dep_unmet++;
> +                       if (!dep->met)
> +                               adev->dep_unmet++;

Nice catch!

>                 }
>         }
>  }
> --

Applied as 6.9-rc material, thanks!

