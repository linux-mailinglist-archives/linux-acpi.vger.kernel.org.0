Return-Path: <linux-acpi+bounces-16017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F70B34498
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 16:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF9D1886523
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAFA2FC89C;
	Mon, 25 Aug 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkT3zNvF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF32FC88E;
	Mon, 25 Aug 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133510; cv=none; b=SU1hVyE+/W/xBwRplNkfItysTUzppR+nBUhqpTITFsU2hBwmKwKGEx7RlmP6uDmAoMw8MelaCCOZGgiIGkR3bBRHDxEnqL5iANwI8ACikLLX4kqUQqFDN+FFixMYp8rd/j/l4/TQStOleC5a9GUVB9xofTxSvelaO6J8Uj6K5mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133510; c=relaxed/simple;
	bh=XNzfJ1JsDQz0hb/rCFVVkG70jy0lCFDw+h6Jt0okoI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2G7Ujh/JbjDTKVmNbqUeY4qlOAelzDheOYxujGw+E/NY0MBiQcMMDFfEM+mzThxEjQiieHxBhlYZXm1U8U2recojjapy0UMsiHX5dm6VSp2wW8PZke4cA4ndgZx4Xrzyg6TSaaILvNJiQf8yvRxFoi+HvGTa2jwFpIu8r1izBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkT3zNvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4241AC19422;
	Mon, 25 Aug 2025 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756133510;
	bh=XNzfJ1JsDQz0hb/rCFVVkG70jy0lCFDw+h6Jt0okoI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WkT3zNvFs3flHRBnd/0pNN0i7SPbb1kL7MaWhCII3iHB4hNgwjzRdCFGDdtSWUUR5
	 0C0GLy+6XWwxgC/P63jjrzdKsqzAQmxG6w68eZgQz4AJY4fpMeA7VsQcMKQr8D9uJX
	 bhA4MWpKYX9utEdTmQlVEJzuNxgg1eR/nuKPOaVs7LEFSGKZmGgsBpsOksbtabHffC
	 kyrCnu9dk88FP3T5O9odIWoB2a/cFauKy8XwdmFrI9D/izATy19mimfbB/OoXFRRsO
	 tJTVyFFW34LSRgKq+iiyfs7UK4A/nWkK6S8OJQxBDBvqhbqZlg+cGkDJAL6MfrZVXU
	 WHwL3xdlR1UZg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74526ca79c2so221147a34.3;
        Mon, 25 Aug 2025 07:51:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUilzWk1iIrpLU0xTCXOR2xtImBdeBUsOc3YkSYew7/DreqdBwzeA5QRvmDosoryEnwgR6av77Q4SLx@vger.kernel.org, AJvYcCVOqEFwXO5OMYiHOoFZTs15KdmoXRUrYVBRGA1VPyEgDWivzk6kit8XolQ9g9FX/hEecjhm2AsSPSO5BZfB@vger.kernel.org, AJvYcCXkTBDG8bdYdNwC8vqC016/uwLdBqk86vPL7twGznfFubGk9g7/9gV+2Cq2ZeKGFSW0t6XPJJPsPtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Hj34hYNUdDGsvWRkVtxYQziNVZLy/HIQwwBdHcBaHPu3EudF
	UNXQcpXoXA5+jPUjmaE7y9arBC/im3a1/sZjeFp5ygXKDit0mob5lDgW9PGRDVNe3O9KUK1pBv0
	EnWa78/lgD/kAHmDf3Ae0vSOS8QZk7fc=
X-Google-Smtp-Source: AGHT+IHsaawNVSmwqBFDCR0lzMxX9J0lmDH1hUvNxpCLX05oS/GGF0gkk8X9vl4An8E3GcjsHVdcqqgmqzbYRvZ1Fqg=
X-Received: by 2002:a05:6830:3919:b0:742:29a0:1c6d with SMTP id
 46e09a7af769-74500af25c5mr8316235a34.27.1756133509576; Mon, 25 Aug 2025
 07:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814072934.1016694-1-tianyaxiong@kylinos.cn> <20250814073144.1022355-1-tianyaxiong@kylinos.cn>
In-Reply-To: <20250814073144.1022355-1-tianyaxiong@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 16:51:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iM1GZppArfDQ5T7oNC8i7nr4OatYvdA80vDZwgms8VQA@mail.gmail.com>
X-Gm-Features: Ac12FXxOrQ--ZkFXII1v1zM3tUh9-6weMp8tifiLJuDIACpJG6G_zX3YFVFfiJ8
Message-ID: <CAJZ5v0iM1GZppArfDQ5T7oNC8i7nr4OatYvdA80vDZwgms8VQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle: Add interface to get cpuidle_driver by
 CPU ID
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lenb@kernel.org, 
	robert.moore@intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, Shaobo Huang <huangshaobo2075@phytium.com.cn>, 
	Yinfeng Wang <wangyinfeng@phytium.com.cn>, Xu Wang <wangxu@phytium.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 9:32=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.c=
n> wrote:
>
> Some drivers need to obtain the cpuidle_driver via CPU ID before the
> cpuidle_device is registered. Therefore, this interface is added.
>
> Tested-by: Shaobo Huang <huangshaobo2075@phytium.com.cn>
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> Signed-off-by: Shaobo Huang <huangshaobo2075@phytium.com.cn>
> Signed-off-by: Yinfeng Wang <wangyinfeng@phytium.com.cn>
> Signed-off-by: Xu Wang<wangxu@phytium.com.cn>
> ---
>  drivers/cpuidle/driver.c | 16 ++++++++++++++++
>  include/linux/cpuidle.h  |  4 ++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 9bbfa594c442..8647f8165863 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -353,6 +353,22 @@ struct cpuidle_driver *cpuidle_get_cpu_driver(struct=
 cpuidle_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver);
>
> +/**
> + * cpuidle_get_cpu_driver_by_cpu - return the driver registered for a CP=
U.
> + * @cpu_num: a valid cpu num
> + *
> + * Returns a struct cpuidle_driver pointer, or NULL if no driver is regi=
stered
> + * for the CPU associated with @cpu.
> + */
> +struct cpuidle_driver *cpuidle_get_cpu_driver_by_cpu(int cpu_num)
> +{
> +       if (cpu_num < 0 || cpu_num >=3D nr_cpu_ids)
> +               return NULL;

What about changing the __cpuidle_get_cpu_driver() parameter type to
unsigned int and also passing unsigned int to this function?  The
first check above can go away then.

> +
> +       return __cpuidle_get_cpu_driver(cpu_num);
> +}
> +EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver_by_cpu);
> +
>  /**
>   * cpuidle_driver_state_disabled - Disable or enable an idle state
>   * @drv: cpuidle driver owning the state
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index a9ee4fe55dcf..aebbaae6a501 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -200,6 +200,7 @@ extern void cpuidle_disable_device(struct cpuidle_dev=
ice *dev);
>  extern int cpuidle_play_dead(void);
>
>  extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_devi=
ce *dev);
> +extern struct cpuidle_driver *cpuidle_get_cpu_driver_by_cpu(int cpu_num)=
;
>  static inline struct cpuidle_device *cpuidle_get_device(void)
>  {return __this_cpu_read(cpuidle_devices); }
>  #else
> @@ -240,6 +241,9 @@ static inline void cpuidle_disable_device(struct cpui=
dle_device *dev) { }
>  static inline int cpuidle_play_dead(void) {return -ENODEV; }
>  static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
>         struct cpuidle_device *dev) {return NULL; }
> +
> +static inline struct cpuidle_driver *cpuidle_get_cpu_driver_by_cpu(
> +       int cpu_num) {return NULL; };
>  static inline struct cpuidle_device *cpuidle_get_device(void) {return NU=
LL; }
>  #endif
>
> --
> 2.25.1
>

