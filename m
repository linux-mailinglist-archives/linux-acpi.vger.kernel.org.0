Return-Path: <linux-acpi+bounces-16433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ABDB463F2
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 21:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CEA7C57C0
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE512773DB;
	Fri,  5 Sep 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoWEwhNT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA53AC1C;
	Fri,  5 Sep 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101823; cv=none; b=gLp+Fg4Y/ZToDBFjhCPOiZRGYljFBhNCcuxdAvXinXicfCr6DMGyqs50RgC6YJ4gZAIqIP5JyzgDA8/yqemK+EvySb39wKa6ltoMiNkNoCU5XqatJ45Dpd8BfU1uP+jZEBFcCyO6jgDLQv8wlCVITk0PBKGaPPEOxvDq5ddSYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101823; c=relaxed/simple;
	bh=CLXw4DN67XKGQfmhHzc4kdR7hzYM9eFmZ4ZDRbEwt+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q50MNNq9QH787XA5YQsONuz2oq0/chHS+Ym9gfD0md8XxuUSEuOhsdGsg0g5Pnr63YoieJHOOxkC/aBJIX/639qTDdst4l6eh3L8e3QVvXyc9Rp3+NHB98hZdZsBgsM0Xuz4/wsoNlWCSMUaFLTUAxSbvkIqp7NhEwIzW5Imofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoWEwhNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6DFC4CEF9;
	Fri,  5 Sep 2025 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757101823;
	bh=CLXw4DN67XKGQfmhHzc4kdR7hzYM9eFmZ4ZDRbEwt+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UoWEwhNTl2+lYYy/BEPgYCuCn99esPHsPKIqwp3Cz0QhMbbth5iaIFzok2mC9aYtL
	 Z6bl2VoMKBrIStUpbKbJl4bU8pP81dOYPNcaqm+5msC0fYUv+DlmT8z10VOnMruNvo
	 i1FityfKlT6kGmV7rhhc67R9EZz0LOP7xJq+anwXXMlfeUWmdHsr1f0eO358PBObKC
	 6NxRAgoc6CSgYEVWI9o0Hgw7NgFKaIshyNSeUNSwgg2/N/wwvDv0gNglfaMFnLBGYy
	 lZRS336IcydcJet+4ywLXnkatJUBEomTU+VWFhS36wh9/Ty6D8GjfT8/RQVGJN2Sgl
	 DmWJQvVk+xLBw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61dd3b5cdd7so773819eaf.1;
        Fri, 05 Sep 2025 12:50:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5JvcFyQTZ+4a3xsmRYe4wbviI+XXSqiKC7cGPNvN3Ju26ayLZ0aKqeqioNAQ9I9MchDVdsEtpk94q@vger.kernel.org, AJvYcCUBwZzV57L5KpxfvLCCzpl2BTF/2gZXFYiWdyDymhhPthtm9WHvuOIfsF5c4eBlraACjelixVousEQufVI7@vger.kernel.org
X-Gm-Message-State: AOJu0YzPg0U6UZx2AD4vTl3CWH2Biwil5UyrqAMQ0Q+TyqPprgQnFmGn
	pu+1rGWUFc4YHLeLTSPyan0GrXDVG4efbHLJoTniNKDoIRH2eX37+J/F8hWBPYYL6E9IEDqtkwW
	ULB6w9dOljwzFcKY58Dj2fOMVDcv8ris=
X-Google-Smtp-Source: AGHT+IF8sQYyCL9maiAio96EKgI4GjPLwuW+t4oZprRYAsEdtVg6Xdbc9lbCXJsNXFdo9GpYHEP7kGqxHN1ih8fmDLM=
X-Received: by 2002:a05:6820:54b:b0:621:7704:b55f with SMTP id
 006d021491bc7-6217704b9b3mr284095eaf.7.1757101822552; Fri, 05 Sep 2025
 12:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905081900.663869-1-lihuisong@huawei.com> <20250905081900.663869-3-lihuisong@huawei.com>
In-Reply-To: <20250905081900.663869-3-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 21:50:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jF=1QdHMVY1=Cp_iOEPA2sMOsqQC3vK4uYJMWnpXethw@mail.gmail.com>
X-Gm-Features: Ac12FXwfRtsokZks2As3V_9CBMMkOVJPNWPE2m83WSSpowp5qpMCSc5pKiq-LaU
Message-ID: <CAJZ5v0jF=1QdHMVY1=Cp_iOEPA2sMOsqQC3vK4uYJMWnpXethw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ACPI: processor: Remove unused empty function
 definition for processor_idle.c
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:19=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> If CONFIG_ACPI_PROCESSOR=3Dn and CONFIG_ACPI_PROCESSOR_IDLE=3Dn, we may e=
ncounter
> some warnings about function defined but not used.
> All external functions of processor_idle.c are just used in processor_dri=
ver.c.
> And if CONFIG_ACPI_PROCESSOR is selected and CONFIG_ACPI_PROCESSOR_IDLE a=
lso
> be selected automatically. So remove these empty function definitions.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  include/acpi/processor.h | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
>
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index ff864c1cee3a..d6a87dc42a9a 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -417,34 +417,14 @@ static inline void acpi_processor_throttling_init(v=
oid) {}
>  #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>
>  /* in processor_idle.c */
> -extern struct cpuidle_driver acpi_idle_driver;
>  #ifdef CONFIG_ACPI_PROCESSOR_IDLE
> +extern struct cpuidle_driver acpi_idle_driver;

The changes above don't belong to this patch IMV or at least I don't
see why they belong to it.

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
> -
> -static inline int acpi_processor_hotplug(struct acpi_processor *pr)
> -{
> -       return -ENODEV;
> -}
>  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>
>  /* in processor_thermal.c */
> --

