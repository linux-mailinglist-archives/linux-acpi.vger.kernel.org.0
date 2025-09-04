Return-Path: <linux-acpi+bounces-16365-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD09B44070
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 17:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F19E3A65B4
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016CB224AE6;
	Thu,  4 Sep 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsQtRLOn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B923DE;
	Thu,  4 Sep 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999434; cv=none; b=ZT6qq/057fPrCdaKdC0xwe18SQa2fw9E8auA/OyqzX5g5YgMc4UdtPr6KBc1X8GgZr3HH//FR+khQv4VNVic+8vmaHCwM9BkvWZ0aTm77QDTPOy512oE5r//a5Jep9FCsinJYLO56SBA+Bl6VbTPi4SEpBmvGkWHHzF2RTSwnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999434; c=relaxed/simple;
	bh=DTD1nqz0ntz4vkg7uz5L3+P7Dz9bdTkUku5ya2dgGfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbiVrAzXqgmYhWQHwPE0vxi7pA11ULfao9V0t0zDAIJBvGJD3KT20KaSY8p0RLQArEeiF8N9EH3sl9wVLI1/8+xYJbyVGnV4nRGllSiNvqljthRmKYpk96EvsjKeCeNeNhiUH22aMI+0uq1lRiLRyJlw88js/gEcwl50XM9DPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsQtRLOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59345C4CEF9;
	Thu,  4 Sep 2025 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756999434;
	bh=DTD1nqz0ntz4vkg7uz5L3+P7Dz9bdTkUku5ya2dgGfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CsQtRLOnnkPRIoPgyZOJ5iUJduJnN2WQOeZyB1cz+RWsoGw/BJmnKoyDSyRPQfbMP
	 kvM2PFgQlZkKMg4uTol9sDNTAcEvpYjzZ5SrepTyraHKyX1PXfxaJ0jzAOebcmz5OI
	 q3sWgpXY8zgb/UwpuZ3jrwYDbM2CY1xrMEYk8yFdOD8pBzCq/Y4gSGYuC/3KppQUx0
	 nn16rVfVtFSTnhiKjsJCF2q0XcEa+E5PVTvh5Wg9CVV2ig2PEF+9ihgudVCDsCmBjU
	 vmpHl65VvjRpvuJS0qoymGVDKojFfYnj6IH7yR7+jHTZeIK2tU+yaMrWB0LOtyZ6Pr
	 mD57WrqRcB0KA==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-746d7c469a8so180662a34.3;
        Thu, 04 Sep 2025 08:23:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBuObOuS7Gm07sctN+wp9MxPVYME8pMRT50JnwKBGgju04AMt5VXZbsS3nYyXYi/+vhnbEYR2v0o1U@vger.kernel.org, AJvYcCVDZqwCA+vnnduvFYymjb32ly/As+ELhlj81osRQ+psmA+sucD0Ecd1nowMo2ijUV6WcazW5POp7IX0b2Jd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SBANdVbbJqvgmcfc4ed1+EvXYfEUDtjkIz5Les2jLZndHrxf
	ZZhbg3XpZhxahWVfwvctVEDcPrbTYN6geU7d1ATfbZwDMjnanK/saTcVhF39+lGGVFe34oeIJJV
	+xPhiv8h6n2jhcqnxnDreyO8+uy41IS0=
X-Google-Smtp-Source: AGHT+IEc0eucpLBHmtBv9D19e1yOkOVmF6jcfbEsrlDk7x+4EOkapUXUMhilLT1XJIXQpj61cGlpB5L7m7O7UDPw3V8=
X-Received: by 2002:a05:6830:280b:b0:745:50ec:c369 with SMTP id
 46e09a7af769-74569ece49dmr9917538a34.34.1756999433611; Thu, 04 Sep 2025
 08:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904121131.2610989-1-lihuisong@huawei.com>
In-Reply-To: <20250904121131.2610989-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 17:23:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jewY9X5rTQmgsgbpjzy=2bzMPTSV60g9kMkXOcKcS_Ng@mail.gmail.com>
X-Gm-Features: Ac12FXxloCfJ4RZ3u65Xd2xdeXU6okg-2cVMshEClaDQxWPv2o_MNnAgbN7BVgI
Message-ID: <CAJZ5v0jewY9X5rTQmgsgbpjzy=2bzMPTSV60g9kMkXOcKcS_Ng@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Fix function defined but not used warning
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:11=E2=80=AFPM Huisong Li <lihuisong@huawei.com> wr=
ote:
>
> If CONFIG_ACPI_PROCESSOR=3Dn and CONFIG_ACPI_PROCESSOR_IDLE=3Dn, we may
> encounter some compling warnings as the following link said.
> So remove these empty function definition because they are just used
> in processor_driver.c and if CONFIG_ACPI_PROCESSOR is selected and
> CONFIG_ACPI_PROCESSOR_IDLE also be selected automatically.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508300519.tZQHY6HA-lkp@i=
ntel.com/
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  include/acpi/processor.h | 34 +++-------------------------------
>  1 file changed, 3 insertions(+), 31 deletions(-)
>
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 360b673f05e5..a4e1081fd0da 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -417,40 +417,17 @@ static inline void acpi_processor_throttling_init(v=
oid) {}
>  #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>
>  /* in processor_idle.c */
> -extern struct cpuidle_driver acpi_idle_driver;
>  #ifdef CONFIG_ACPI_PROCESSOR_IDLE
> +extern struct cpuidle_driver acpi_idle_driver;

Are the changes above related to the warning?  If not, maybe move them
to a separate patch?

>  int acpi_processor_power_init(struct acpi_processor *pr);
>  int acpi_processor_power_exit(struct acpi_processor *pr);
>  int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
>  int acpi_processor_hotplug(struct acpi_processor *pr);
>  void acpi_processor_register_idle_driver(void);
>  void acpi_processor_unregister_idle_driver(void);
> -#else
> -static inline int acpi_processor_power_init(struct acpi_processor *pr)
> -{
> -       return -ENODEV;
> -}
> -
> -static inline int acpi_processor_power_exit(struct acpi_processor *pr)
> -{
> -       return -ENODEV;
> -}
> -
> -static inline int acpi_processor_power_state_has_changed(struct acpi_pro=
cessor *pr)
> -{
> -       return -ENODEV;
> -}
>
> -static inline int acpi_processor_hotplug(struct acpi_processor *pr)
> -{
> -       return -ENODEV;
> -}
> -static inline void acpi_processor_register_idle_driver(void)
> -{
> -}
> -static inline void acpi_processor_unregister_idle_driver(void)
> -{
> -}
> +extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
> +extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);

Please remove the "extern" from these declarations.

>  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>
>  /* in processor_thermal.c */
> @@ -473,11 +450,6 @@ static inline void acpi_thermal_cpufreq_exit(struct =
cpufreq_policy *policy)
>  }
>  #endif /* CONFIG_CPU_FREQ */
>
> -#ifdef CONFIG_ACPI_PROCESSOR_IDLE
> -extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
> -extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
> -#endif
> -
>  void acpi_processor_init_invariance_cppc(void);
>
>  #endif
> --

