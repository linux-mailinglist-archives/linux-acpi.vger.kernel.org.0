Return-Path: <linux-acpi+bounces-12907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E399DA82761
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 16:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AB03AD921
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF425F796;
	Wed,  9 Apr 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV/c4HiR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB729A0;
	Wed,  9 Apr 2025 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207970; cv=none; b=pCoZbsDpPwJLj/GmwwSJS1Mcz0K0Wde8W6zSQg13QKL5A+Vth5J8BpLvs1b0NsktM9Yd0eSKAP4GR15u64rx7KiU5h8r6vAVxPvWlZ2NAF2tSBydtPzVhqxiUnX7QAqnIW39CH604R/auu6KLzvlj4fw49vyElACKzGeX4Z0JEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207970; c=relaxed/simple;
	bh=Vw/9BbWr42/S2TmbmC0tAGAkxyiMzz+D7XbIESFVGBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXn4HZ/fud3I84Bk66GXWjh+ebF8UfbmZvVRKouDj8rEXm9DFmg5N4Ax7wkqt0pjQILwz5FSfU2zYfeUgRfz7/DlVM2ajE6ASEtbfGx5T4299tOFybZ06vML3KzhN/R18judw0o07XwW6qDoj+gAbP84T9sBo5khHS70BGnD1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV/c4HiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD98C4CEE8;
	Wed,  9 Apr 2025 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744207969;
	bh=Vw/9BbWr42/S2TmbmC0tAGAkxyiMzz+D7XbIESFVGBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IV/c4HiRJ1k4xHbzWqZebkS9cmZrW2MxrIfo8hk4SRuOZ9OmYXKFumnZ/6bXf/NP8
	 zZpq2D5hvU4Fqw2zDQI0ZMMgUaogUdCJM25sCz8I3xLkO/QucaL+hbuRMAV7JK2r3e
	 1Bu+xdI7qOqIwM182WRgwb0CFEaJR5l55cDXUseoX3AMueFSYueaPLaLYr1NxA/jVz
	 E1BsE9ZVmHzzzdSxD5QAbea53PWbHiW9nokMyh0A5A/YXTFHbDIyKS/+nXVibjewhE
	 xh46uaYeSai9iL/PnDY/EOFC6cpFME14udNWDODGVc1Q7w2JcnQDSmGx7LAqjs3lFU
	 IiUPRoo/xAc5Q==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c818343646so4022740fac.3;
        Wed, 09 Apr 2025 07:12:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJMF2EgxNyB5xvDLyIwF/7/I8Ml0tvZrz0SU/vsAbfOZwguvs0u7314L+9My948X9DBd4ED0bRCVAv@vger.kernel.org, AJvYcCWW0DMPLDh/kbcSnZJR//Gitw/ymytvszYPd3bcZGXXNBGw0pWSAtEUqrZALJBlYxTZw3sE1WBqIhSyag==@vger.kernel.org, AJvYcCX1VbqQ1T/31jyaRnv1gYgUHHOI6GTsuUWnZAMfVYOt5KjaOlz90sa4yTytrRXQObkqsI3cYKgUfF4CFDCI@vger.kernel.org
X-Gm-Message-State: AOJu0YyGkNaR23hNpqbuU92OFnm6rIKNcL2INri1ZcsCFH0UKETlJEHO
	zUaykS1VSHsj3TWfWkedNHD5a1shOd024IP33N6FF5v5DwOeuejez+ouX7QITERVyVIUHtW29gf
	5poZCIWmLbN5oaRRfedu8ZIVhugA=
X-Google-Smtp-Source: AGHT+IEfbq1b6uZ6OUCvuexDfaJqZBDkEEa57XBGYlotEXlempsdj2+s4v7wD/x2wV4frJrZKXhB+Es/LZ+fKQADQ4Y=
X-Received: by 2002:a05:6871:a112:b0:29d:c709:a76c with SMTP id
 586e51a60fabf-2d08dccf9e9mr1872958fac.4.1744207968972; Wed, 09 Apr 2025
 07:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407183656.1503446-1-superm1@kernel.org>
In-Reply-To: <20250407183656.1503446-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 16:12:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g0w58KDpAJZq1RkM=hDg5W3QcoDPJsCfT3kEKntJ1d0A@mail.gmail.com>
X-Gm-Features: ATxdqUFO6iRoisnzTjoDivu2_kLVOfSVcGADUXAQj7WpXtpnpd_FrOi6U7v-kFg
Message-ID: <CAJZ5v0g0w58KDpAJZq1RkM=hDg5W3QcoDPJsCfT3kEKntJ1d0A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI: Add missing prototype for non
 CONFIG_SUSPEND/CONFIG_X86 case
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 9:02=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> acpi_register_lps0_dev() and acpi_unregister_lps0_dev() may be used
> in drivers that don't require CONFIG_SUSPEND or compile on !X86.
>
> Add prototypes for those cases.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502191627.fRgoBwcZ-lkp@i=
ntel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Add struct acpi_s2idle_dev_ops outside defines too
> ---
>  include/linux/acpi.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 3f2e93ed97301..fc372bbaa5476 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1125,13 +1125,13 @@ void acpi_os_set_prepare_extended_sleep(int (*fun=
c)(u8 sleep_state,
>
>  acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>                                            u32 val_a, u32 val_b);
> -#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
>  struct acpi_s2idle_dev_ops {
>         struct list_head list_node;
>         void (*prepare)(void);
>         void (*check)(void);
>         void (*restore)(void);
>  };
> +#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
>  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>  void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>  int acpi_get_lps0_constraint(struct acpi_device *adev);
> @@ -1140,6 +1140,13 @@ static inline int acpi_get_lps0_constraint(struct =
device *dev)
>  {
>         return ACPI_STATE_UNKNOWN;
>  }
> +static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg=
)
> +{
> +       return -ENODEV;
> +}
> +static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *=
arg)
> +{
> +}
>  #endif /* CONFIG_SUSPEND && CONFIG_X86 */
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else
> --

Applied along with the [2/2] as 6.16 material, thanks!

