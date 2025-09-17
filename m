Return-Path: <linux-acpi+bounces-17091-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA062B81B0E
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 21:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA707B4ECA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE12927E1C8;
	Wed, 17 Sep 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrgB+DW5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8027A929
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139008; cv=none; b=YmmdrI4/2qrLIBk2eqxhyCuRGQ05gojxla/tdKslw44gDv/u9HzNfxF2CZLfbrCBci45X3zjt98LmbIsE9sEzJpCwzn4MNm51AbyoZM9gkpAhbhNsW5QvFoBdT7YqIeTO2ZeIHJo2GoWgD/Wmb0aa0Zz0PhEGYc55d+4oBP1qdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139008; c=relaxed/simple;
	bh=zkYCeThjXGVc9K9cgkXWiT+imwcdgOAZ07NL5lOK0FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EY0B2RT4dTKhDzASyP08lWSfqPz4biLWbC+tVisqd1xxdujtEcKm/4AUNwHB57CLxu4F2NI5P/Eqo55abNHK9ymOpqE6nd1gRWJMp1Zf0ZjldlE38zT1Q/P9DzUDay69LEb1ZNuXcQ6CBgF45oLUOzeyIe1X6U8rohg4jHplTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrgB+DW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D67C4CEF7
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758139008;
	bh=zkYCeThjXGVc9K9cgkXWiT+imwcdgOAZ07NL5lOK0FM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FrgB+DW53zf1IrcBarnr/CTFuns3vz8KABXZQdPEAxxvYlpVSb2gUcTHaaacfYb3D
	 a/u2l7TyRDQUH4wUnHmYIxhDOPXdbAYgq93cI/GHBgm+JG/CzUdf4I+Hk0kPfjOZDI
	 33zlRK/Z1EPbvAb6ApeghoAMCpErV7xyRKqN5KzzGIUZFSur/Bz0ynddj7eyseLzMu
	 77jXBPWUgYaETSF2gk1Mah1y/8BlwAxG0niyMxoc77Z8dYl+rxxoEu4oS+JbM0VgBC
	 JH1AqSF5+Uyoh375Z75PhqfuL2Z2FfQF5URD6KHGJojbh1CQP1eJjaqRP0vmGeGUBw
	 HR0Xfmmd0nBrw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-621cecfcc04so141504eaf.2
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 12:56:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBjGCgc25EYQOogoc7w5/A08WAt5Z8kl0rsMbRa46tbLu/yoAFgwBRVbtlIaYy3C5QR8t9nXlAAuOv@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuD42CrMocGheiqBog/a0wQrzVzYP8joBuFbLL93J5+oABTqH
	F4bwIJUXIXCUOgk2/WKvOwZ9dtWqX34aERcJprkKCdKElPrtTj/1LHUXqdUU0Kx+r6fLP6Aows6
	bUN6gUxrVr70+66/8QrWQlz0Dx9b3nbE=
X-Google-Smtp-Source: AGHT+IHQVqexYJq9t5JCGXcCkIGvd8MopByJd95VnTnT55FBaju3b6Lh/QzF2ByiyJPE+EvO4HEzohL2z5yoPdZvApc=
X-Received: by 2002:a05:6820:1607:b0:621:b76e:66b9 with SMTP id
 006d021491bc7-624a5698d34mr1867267eaf.3.1758139007745; Wed, 17 Sep 2025
 12:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911112408.1668431-1-lihuisong@huawei.com> <20250911112408.1668431-3-lihuisong@huawei.com>
In-Reply-To: <20250911112408.1668431-3-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Sep 2025 21:56:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gzYECjqsFeaaQm+bG1ssLsM0fA6cfGQ8-fQ_tEpF7v8Q@mail.gmail.com>
X-Gm-Features: AS18NWBPtqI36wR3-xAg9LnQbiDgBSwU6IG9kuQynD7FmPoEOPiXWIRQmd-RzJ8
Message-ID: <CAJZ5v0gzYECjqsFeaaQm+bG1ssLsM0fA6cfGQ8-fQ_tEpF7v8Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ACPI: processor: Unify the place of function
 declaration of processor_idle.c
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 1:24=E2=80=AFPM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> To unify the place of function declaration of processor_idle.c, move
> acpi_processor_ffh_lpi_probe and acpi_processor_ffh_lpi_enter to one
> place. And remove 'extern' key word in declaration by the way.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  include/acpi/processor.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 2976a6d0c54f..6ee4a69412de 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -425,6 +425,8 @@ int acpi_processor_power_state_has_changed(struct acp=
i_processor *pr);
>  int acpi_processor_hotplug(struct acpi_processor *pr);
>  void acpi_processor_register_idle_driver(void);
>  void acpi_processor_unregister_idle_driver(void);
> +int acpi_processor_ffh_lpi_probe(unsigned int cpu);
> +int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
>  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>
>  /* in processor_thermal.c */
> @@ -447,11 +449,6 @@ static inline void acpi_thermal_cpufreq_exit(struct =
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

Applied as 6.18 material under a new subject and with a new changelog, than=
ks!

