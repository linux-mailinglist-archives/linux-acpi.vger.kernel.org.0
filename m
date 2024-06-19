Return-Path: <linux-acpi+bounces-6526-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE3790F4DA
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 19:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817D71C21B2A
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391FE155398;
	Wed, 19 Jun 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5jtBk9C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2211C3E;
	Wed, 19 Jun 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816987; cv=none; b=qXvthoJQ47aOiYhxb8aFW0Up/M0dBNo3y7L23sDm3UUamj3ZzBfOt1IXdYBNq30Wl8FIZ8Um6tGn+1HFwZF4aDZooJZZMie5le5xKjQBswXPKZ3k/SdEcYxX2NREOkAiRw+9NFdIFnok+06egx0an/We3XW6fKpzu1AqtJudSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816987; c=relaxed/simple;
	bh=9CMNUv/EbEPQ8no+tR5gxROXmRGYdqZRxr+kp5I4E3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ej/x2oeZuQg4OMafGN2XLCr12kxevyPn97pnwmfvnTdEPtfYtsIN4chNWqlhn2mB7LW1L4kjXWnxjMBhYAvUOXaX4lmgL4Y7co7HpnjdbsCRRSz7jmMhscqt4PMqp9g8NtdXXp3JnggJ+yKJgLImuQ6NBkAp9tFZKGLGhlh8rsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5jtBk9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20C9C4AF07;
	Wed, 19 Jun 2024 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718816986;
	bh=9CMNUv/EbEPQ8no+tR5gxROXmRGYdqZRxr+kp5I4E3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h5jtBk9Cyl/yP3iJt2RztG1vPVKNktYwJj09k79If4Cyt71eUgJFlHyR3Yn6EL3Ga
	 5sQF2qKQk8qU7Ey1GfHrTE8sQyl5yzM2ZrZED91s+791DY4kIcxHmgcacvYSx+wFmi
	 2o634Wf8+dkGlKKLQJzOLDU+wloO6EUAzJvj/ntRhCXZzr6QoRwkpYyjysouCLpaE2
	 xEdTryNSl3kM4/BHua+7vJm5zvsTapWt//B6/JocQ6oN5+Ct0xiMjFK6R9pY9PgbXa
	 Lm36+yvLQTAVC6c1Ol/u3kfa9nEjc4dDuxt5M3BRUcCxYIAdbMCdmylRaD1qLhqu0q
	 j2cuCgjGXPoWQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-254f646b625so13861fac.0;
        Wed, 19 Jun 2024 10:09:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXftWBX38KUOblJYRogJTZ+xsQcbLRR5bTBsqgdpMKPQk4gEf/kDNt4zcbWgHHyr3OVzldDVRZ5cjsmwFcvxj2RCBJ0BsOiQtfNE2RBgbegmieO/LJZNIeSaaqvPf5iPyZ5TUkmirDLPQ==
X-Gm-Message-State: AOJu0YxejemIJaOlvuS2gsOdflwfBh7hpA3DPlTbt1P9o7E4gWXuFW3Y
	OUYyiUQrphwc58lrjARap+5hWQ8HksIJhoNvNPV/vH0TckaaTigKNDvqL75GW+TJwz/mXHAAL22
	3NhTBLlta44/1E2LmPteoGFu4w7g=
X-Google-Smtp-Source: AGHT+IFnVIs7qSVlLi41292Pqa2L4YxENvIxso1hyO4nfZ7rk9IxBHHcak04fnlkplGBaApB+0YZgL1YINHD2KZ3qiw=
X-Received: by 2002:a4a:7619:0:b0:5ba:ca8a:6598 with SMTP id
 006d021491bc7-5c1ad90b829mr3531916eaf.0.1718816986143; Wed, 19 Jun 2024
 10:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com> <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com> <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com> <ZnHfNbLTgY1op3Zv@kf-XE>
 <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com> <ZnHtPbszYT8afOOk@kf-XE>
 <c6bda238-166e-4de6-b0c7-4bddfb8ef6f4@amd.com> <ZnIAX9P5XSco4cZw@kf-XE> <ZnJfmUXmU_tsb9pV@kf-XE>
In-Reply-To: <ZnJfmUXmU_tsb9pV@kf-XE>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Jun 2024 19:09:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
Message-ID: <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	mmikowski@kfocus.org, Perry.Yuan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 6:33=E2=80=AFAM Aaron Rainbolt <arainbolt@kfocus.or=
g> wrote:
>
> acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
>
> The _OSC is supposed to contain a bit indicating whether the hardware
> supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> be considered absent. This results in severe single-core performance
> issues with the EEVDF scheduler on heterogenous-core Intel processors.

While some things can be affected by this, I don't immediately see a
connection between CPPC v2, Intel hybrid processors and EEVDF.

In particular, why would EEVDF alone be affected?

Care to explain this?

> To work around this, provide a new kernel parameter, "ignore_osc_cppc_bit=
",
> which may be used to ignore the _OSC CPPC v2 bit and act as if the bit wa=
s
> enabled. This allows CPPC to be properly detected even if not "enabled" b=
y
> _OSC, allowing users with problematic hardware to obtain decent single-co=
re
> performance.
>
> Tested-by: Michael Mikowski <mmikowski@kfocus.org>
> Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
>
> ---
>
> V2 -> V3: Move bit ignore to before switch.
> V1 -> V2: Rewrite to work in cpc_supported_by_cpu.
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index b600df82669d..af2d8973ba3a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2063,6 +2063,12 @@
>                         could change it dynamically, usually by
>                         /sys/module/printk/parameters/ignore_loglevel.
>
> +       ignore_osc_cppc_bit
> +                       Assume CPPC is present and ignore the CPPC v2 bit=
 from
> +                       the ACPI _OSC method. This is useful for working
> +                       around buggy firmware where CPPC is supported, bu=
t
> +                       _OSC incorrectly reports it as being absent.
> +
>         ignore_rlimit_data
>                         Ignore RLIMIT_DATA setting for data mappings,
>                         print warning at first misuse.  Can be changed vi=
a
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index ff8f25faca3d..0ca1eac826af 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -11,8 +11,20 @@
>
>  /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */
>
> +static bool ignore_osc_cppc_bit;
> +static int __init parse_ignore_osc_cppc_bit(char *arg)
> +{
> +       ignore_osc_cppc_bit =3D true;
> +       return 0;
> +}
> +early_param("ignore_osc_cppc_bit", parse_ignore_osc_cppc_bit);
> +
>  bool cpc_supported_by_cpu(void)
>  {
> +       if (ignore_osc_cppc_bit) {
> +               return true;
> +       }
> +
>         switch (boot_cpu_data.x86_vendor) {
>         case X86_VENDOR_AMD:
>         case X86_VENDOR_HYGON:
>

