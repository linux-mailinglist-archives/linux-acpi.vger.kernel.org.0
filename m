Return-Path: <linux-acpi+bounces-9331-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B619BD72E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 21:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545471F23D4D
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBDA1F9434;
	Tue,  5 Nov 2024 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9mghXbR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905451CB9E6;
	Tue,  5 Nov 2024 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839468; cv=none; b=CGMGEuJPKbBEqMiUBjuhL1kYxvCNkT143bJZG7m+s0R2Q6zulexujUAFLeqHw36PPN9QUUqXnm06q6gJIzeVjS9HbZXg+FJl6YUzo2r4s87jieXsZtHVz3Va5US7FtRpjT+5DuI4i+wyZsSBqaoxMyQaiIF4yRcnIptIdvgnxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839468; c=relaxed/simple;
	bh=oPw9NdpDDLnz8rs83YdqEqUHVVctUKHOXEqimv5CgeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2wZdycNSpdp8t08sGI8AMVjpzkwXrTDNQPajp7o3FEisT2OXW97o9OhQJtL0kU2KBvJqYl10u728vy44UZkwTGixO91edJoo3IP/Ajs1SwjbgmIOcVL/DMDA4AwVFu3QS4xCqI/R2h/KN+6FH3TRPlUWIX8jNjO8KIpyyxenn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9mghXbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105D5C4CED1;
	Tue,  5 Nov 2024 20:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730839466;
	bh=oPw9NdpDDLnz8rs83YdqEqUHVVctUKHOXEqimv5CgeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c9mghXbRvq0iilLhQYpGukf+ZffuzNQC7q5iTEkmOHcZinljH1ZzZ+Yg2QnxQi0X6
	 aIQCTsi5Z79gWFLeOyfIYNotdVksJb21nhlKooYvFGhOn/By7Tv23+dlhj14LW4U0e
	 JsLajrgdZdGfZWA/NzAT+jFNbiJwtaSLbaTGBAoRD94MkuQHClwxjEsnxaFL6Zsl7u
	 RyUxX3aNqDXpwgFqWVBZQRzcOw43ZdtMgIQ2v0St1saXjNC1IWX9a9po0wSCURqy81
	 oGBQJFJteaCcB7mDwg9Sw1rfOeo94ulCWllX/tipLS/h//RVM9RLisoNs6qGFK2ntv
	 fgyolpX3jX4/Q==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-290ff24354dso2750425fac.0;
        Tue, 05 Nov 2024 12:44:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU643Jn9VH3qXEDzrT5eIHkn8skMhQaf87XAWVSS0iZh5PZVdFqdMslxd3r0rOBJ7FXSmKNHjknYPzJ@vger.kernel.org, AJvYcCVDvRRfneTz4pRe5spaKqQMPkNddDpwQJEt+kO5ygCl9DvrteDsfxuOEqfoP+YmZ4H1r5xvLKRfYZL7Gk45@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHKBbbsXj/z0Rk8h8xF5XHwiI3FI3uEI91XVM+mZ8XdVr9k2z
	wzNvKtwVyROUOTr3JUphVJb9ApT7rM9Mhr0hKCaF7pVBEnxl66T3JaouZPaV496dTPBGfoRFmYc
	FZXysX+TjIkiMNMMZbuTfJVZeA4Y=
X-Google-Smtp-Source: AGHT+IEYRC2oYocCJtFwkv7gITL7XNVhQKQ8mesVoyI/BViogf+LiF3JmzOwLEjp3lINSSoVS/PbDGhWrlolHc/BCp0=
X-Received: by 2002:a05:6870:d14c:b0:286:f24f:c231 with SMTP id
 586e51a60fabf-2949ee54c2amr15117878fac.25.1730839465312; Tue, 05 Nov 2024
 12:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030123701.1538919-1-arnd@kernel.org>
In-Reply-To: <20241030123701.1538919-1-arnd@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Nov 2024 21:44:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iU6q=6bUznR2Fyn2Qhr-KHuV4KvVPUxKiQoUXe7zRcvQ@mail.gmail.com>
Message-ID: <CAJZ5v0iU6q=6bUznR2Fyn2Qhr-KHuV4KvVPUxKiQoUXe7zRcvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [v3] acpi: processor_perflib: extend X86 dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:37=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The majority of the processor_perflib code is only used by cpufreq
> drivers on the x86 architecture and makes no sense without the
> x86 SMI interactions that rely on I/O port access.
>
> Replace the existing #ifdef checks with one that covers all of the
> code that is only used by x86 drivers, saving a little bit
> of kernel code size on other architectures.
>
> There is likely more code under CONFIG_ACPI_PROCESSOR that falls
> into this category, but changing those would require a larger
> rework.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is not needed for correctness, only as a small optimization.
>
> v3: fix build warning
> ---
>  drivers/acpi/processor_perflib.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_pe=
rflib.c
> index 4265814c74f8..53996f1a2d80 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -24,8 +24,6 @@
>
>  #define ACPI_PROCESSOR_FILE_PERFORMANCE        "performance"
>
> -static DEFINE_MUTEX(performance_mutex);
> -
>  /*
>   * _PPC support is implemented as a CPUfreq policy notifier:
>   * This means each time a CPUfreq driver registered also with
> @@ -209,6 +207,10 @@ void acpi_processor_ppc_exit(struct cpufreq_policy *=
policy)
>         }
>  }
>
> +#ifdef CONFIG_X86
> +
> +static DEFINE_MUTEX(performance_mutex);
> +
>  static int acpi_processor_get_performance_control(struct acpi_processor =
*pr)
>  {
>         int result =3D 0;
> @@ -267,7 +269,6 @@ static int acpi_processor_get_performance_control(str=
uct acpi_processor *pr)
>         return result;
>  }
>
> -#ifdef CONFIG_X86
>  /*
>   * Some AMDs have 50MHz frequency multiples, but only provide 100MHz rou=
nding
>   * in their ACPI data. Calculate the real values and fix up the _PSS dat=
a.
> @@ -298,9 +299,6 @@ static void amd_fixup_frequency(struct acpi_processor=
_px *px, int i)
>                         px->core_frequency =3D (100 * (fid + 8)) >> did;
>         }
>  }
> -#else
> -static void amd_fixup_frequency(struct acpi_processor_px *px, int i) {};
> -#endif
>
>  static int acpi_processor_get_performance_states(struct acpi_processor *=
pr)
>  {
> @@ -440,13 +438,11 @@ int acpi_processor_get_performance_info(struct acpi=
_processor *pr)
>          * the BIOS is older than the CPU and does not know its frequenci=
es
>          */
>   update_bios:
> -#ifdef CONFIG_X86
>         if (acpi_has_method(pr->handle, "_PPC")) {
>                 if(boot_cpu_has(X86_FEATURE_EST))
>                         pr_warn(FW_BUG "BIOS needs update for CPU "
>                                "frequency support\n");
>         }
> -#endif
>         return result;
>  }
>  EXPORT_SYMBOL_GPL(acpi_processor_get_performance_info);
> @@ -788,3 +784,4 @@ void acpi_processor_unregister_performance(unsigned i=
nt cpu)
>         mutex_unlock(&performance_mutex);
>  }
>  EXPORT_SYMBOL(acpi_processor_unregister_performance);
> +#endif
> --

Applied along with the [2/2] as 6.13 material, thanks!

