Return-Path: <linux-acpi+bounces-16499-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D97B496D8
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 19:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D21163D17
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F73731280C;
	Mon,  8 Sep 2025 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a29NeqFS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37616215F4A;
	Mon,  8 Sep 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352028; cv=none; b=KKk30V/10tUdI1luXwxJmmEBTveHOlVkATV0CwNbxaNqDAgoReiM/7/2aLnlTz+Ikj395QyqJf9C1UfopuUtOQm8GQ5YGXX4ubbNJTFz1BMU0+CphxzemUzz5yY49F3qZoyqNxOkIeefvsAVY34NovHJGPQtkiJBS8WE/U/G8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352028; c=relaxed/simple;
	bh=WG6cG0RC7lf6sWYUt9oDwjKz1esgUSQzcQgi7vvimIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiZPjdHXTaVlhCgSNvdiRy6xDZkqydY7/RObD3+CNa3fP4u6d601CA5Ll4cpZu+8qlAlwHJ7IEm75MiSrmhCtJ93OZIH7dklqsEFs0iD8dVdOeIrBmNLcfB/YrI8C2nVRy5l1j69BaGVKAK3rJYh//enA/vIgpg+pEGqPfcIKKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a29NeqFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF679C4CEF1;
	Mon,  8 Sep 2025 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757352027;
	bh=WG6cG0RC7lf6sWYUt9oDwjKz1esgUSQzcQgi7vvimIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a29NeqFSGpEF+96xbTO1WNJwcaERIetmb81Xgnn4IU83YBoLk8Rutt4IWOwFALEE0
	 Alo/yrF5Txar4LbjfsLU96+5JIOUdLTBbOWWhj863dRSEotYftRw8791NUViEN37uH
	 7vL5SDt8lxvdJgFnXs8yyk5LmDGIhAqer9EnM8XSTbl9he/b2vz7jBdIztMdZ26zOW
	 j7J5aPbexf2saw4lZKNoquB5ePSISpTgK86xUvgoCV98gqE2ZZaswqTjzpouutGG+Z
	 JZZF8UXIBG4kOyYZQKC8Xcwpe9a9BxIFcAWHPiQ0O9LXBnyQ3FExVITht/Di+oXYzE
	 U7DGVsfPwYeGA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74526ca7d64so3982335a34.2;
        Mon, 08 Sep 2025 10:20:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2bTPPTYpaS8NCi/XsLcDbxS38D26LN9AKlNc6bC1HosjmhM5hW23kvnTeOeOilLYxcREZ/x5sBbny@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuxh4bBgBgEAsxRjIaoLlXC62MyvVC8ZyOArB8/OnHbmsq2PwH
	L2yM2qMh7kkV520OH5ZcUNX3mlYRrvSes7fK4V4vX6K0nRab80t87gNBduGUB4Hu9zbyei+AxAU
	/YbyhB/I+DrlSg7wrfAwQgKDLxBR+lQA=
X-Google-Smtp-Source: AGHT+IGXpy+OU2UasaskUg2nePmnXAYN4fXokbNZNAf4Iw8rD1AI0zGefB9ESZkm15LcjA+jXp80pFZFT6EmdeISh+o=
X-Received: by 2002:a05:6808:181a:b0:43a:2e17:3ba8 with SMTP id
 5614622812f47-43b2988c314mr4081572b6e.0.1757352027077; Mon, 08 Sep 2025
 10:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908163127.2462948-1-maz@kernel.org> <20250908163127.2462948-3-maz@kernel.org>
In-Reply-To: <20250908163127.2462948-3-maz@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Sep 2025 19:20:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSJ6yMnfZgYDSZRqL_KMLc6f4kcY06dWGSPCFYjdcbfg@mail.gmail.com>
X-Gm-Features: Ac12FXwlVf4kn-tU9YEBjTnrid6i7WBV3fExLJM7cADt4nyooosqwvUywi8aWZo
Message-ID: <CAJZ5v0hSJ6yMnfZgYDSZRqL_KMLc6f4kcY06dWGSPCFYjdcbfg@mail.gmail.com>
Subject: Re: [PATCH 02/25] ACPI: irq: Add IRQ affinity reporting interface
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:31=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> Plug the irq_populate_fwspec_info() helper into the ACPI layer
> to offer an IRQ affinity reporting function. This is currently
> only supported for the CONFIG_ACPI_GENERIC_GSI configurations,
> but could later be extended to legacy architectures if necessary.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/acpi/irq.c   | 15 +++++++++++++++
>  include/linux/acpi.h |  7 +++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index 76a856c32c4d0..22f93fe23ddce 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -300,6 +300,21 @@ int acpi_irq_get(acpi_handle handle, unsigned int in=
dex, struct resource *res)
>  }
>  EXPORT_SYMBOL_GPL(acpi_irq_get);
>
> +const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
> +                                           unsigned int index)
> +{
> +       struct irq_fwspec_info info;
> +       unsigned long flags;
> +
> +       if (!acpi_irq_parse_one(handle, index, &info.fwspec, &flags)) {
> +               if (!irq_populate_fwspec_info(&info) &&
> +                   info.flags & IRQ_FWSPEC_INFO_AFFINITY_VALID)
> +                       return info.affinity;
> +       }

I would prefer fewer logical negations to be used in this, for instance:

if (acpi_irq_parse_one(handle, index, &info.fwspec, &flags))
      return NULL;

if (irq_populate_fwspec_info(&info))
       return NULL;

if (info.flags & IRQ_FWSPEC_INFO_AFFINITY_VALID)
       return info.affinity;

return NULL;

> +
> +       return NULL;
> +}
> +
>  /**
>   * acpi_set_irq_model - Setup the GSI irqdomain information
>   * @model: the value assigned to acpi_irq_model
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 1c5bb1e887cd1..c506ae4bacc86 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1509,12 +1509,19 @@ static inline int acpi_parse_spcr(bool enable_ear=
lycon, bool enable_console)
>
>  #if IS_ENABLED(CONFIG_ACPI_GENERIC_GSI)
>  int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource=
 *res);
> +const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
> +                                           unsigned int index);
>  #else
>  static inline
>  int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource=
 *res)
>  {
>         return -EINVAL;
>  }
> +static inline const struct cpumask *acpi_irq_get_affinity(acpi_handle ha=
ndle,
> +                                                         unsigned int in=
dex)
> +{
> +       return NULL;
> +}
>  #endif
>
>  #ifdef CONFIG_ACPI_LPIT
> --

