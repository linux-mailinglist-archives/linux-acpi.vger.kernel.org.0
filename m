Return-Path: <linux-acpi+bounces-15235-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD11B0A85E
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jul 2025 18:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653FC5A3981
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jul 2025 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CC42BD00C;
	Fri, 18 Jul 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rma34hoR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB6156678;
	Fri, 18 Jul 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855771; cv=none; b=tZuvVkQNBr33dzEvvh9XgAXaXK2iz9bBxTF3iP5m8EDpiwsWme4Y3BJQ57BnSm3IcslAjkoE8OpfTdOLQliE7Q4Xt1D+FZ9T14JbeVeKkkqGiu5ihtO0CY5aW7Y0ClY0Bij3XKfajGiM61Yunmwjqo+2DJELvjOD+RMTh4O/2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855771; c=relaxed/simple;
	bh=lZOegOglXk4xU/hemcOetcD5q4qLzYayydy6MftPr28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajJg11kJL4ttnRvwvV8EYyzGe4rgdYC+9wXzL5X9985WrsaipAlBREjfN7t+k31fcVwyWh4lnSw2I7TtT5WWJ5eCYPFnwWYvl31Qo9EY0MtOtXuFMLDrUuJtlqzfXatiuHVzbh2HEjYSuTgo1birYNeG50NTYiie+7XvnTJwKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rma34hoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0C0C4CEEB;
	Fri, 18 Jul 2025 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752855771;
	bh=lZOegOglXk4xU/hemcOetcD5q4qLzYayydy6MftPr28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rma34hoR1ccL5wsZo5/39UPxVLkPERXvYx/kHPVyQDwp6QID2w159tpk5naI/Natx
	 qjOEnvJgoSVG01YFr9somZusDY6r+3D9IQTFU1sP9zeSdqUBfvgA884fYvspHaETRX
	 RjHmS7eDd8sYe8Pk2KVcQljKUjY480UUW0hiJZB2GcqiNcwgl8fBv5PD6wWAWzcl7w
	 Z3GP+8vaLTtFOYEwcUzG5PS6gzRUc1gGOr84keIh+aQqCSab1CR7EH1XPnm7dG1TS4
	 ByvxIGysc94dchqcJq5W+qPmSr5Idjkm7vDzH4ZjMNcA63qe+rhCahOwbBq1Q4xeTI
	 LJQLCINR1bL4g==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-41b6561d3c5so711981b6e.1;
        Fri, 18 Jul 2025 09:22:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjFSkvuLAybn4IA72zjT8ewX16g+ppQa5YbchJs1o/WoADN3TX/Uu16H0r80N83iqrltWqcLa3N4dP@vger.kernel.org, AJvYcCXno3av0k418Qh4BM/2o3d1cn5eg9nLF1+CIjxBG+s+2ZEvLvecMzR3XKyIhbCMrqScV1zAjGmL0XEKG/ed@vger.kernel.org
X-Gm-Message-State: AOJu0YwqinyXyGOoC6xgEJ6QGRwugsQbwa+L+P/OA5eFAfHS7uixFYHr
	QNx62n/1dwdUP7EiRBBn1/JMVCN5kJXGsHrhL+jTGVkD7z20Z/9Nd5mfnvox7g4x+qOk0Iwsjz2
	xMeoPkWf8ZS17T/KSQLr+jeaPS9U6QuQ=
X-Google-Smtp-Source: AGHT+IG96SBHjvpZ41A9He6ZMbLGNPAaM6KgH+eg0n43knbxejP/GAYLR3Lhdhn9dnaTNQTeZKSml7XlnM6KL61ja+c=
X-Received: by 2002:a05:6808:6f98:b0:41c:2a71:86e3 with SMTP id
 5614622812f47-41d0545e1e2mr9202154b6e.34.1752855770327; Fri, 18 Jul 2025
 09:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718020312.856168-1-lijiayi@kylinos.cn>
In-Reply-To: <20250718020312.856168-1-lijiayi@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Jul 2025 18:22:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jJu2=MbdQ2z8a9JF8Lfz_Mci1+3oncHu8VCb4b3fA_Gg@mail.gmail.com>
X-Gm-Features: Ac12FXwdfE7oX68Ge00c5nCi4iYoVta2s2v5f0imACcVA2t47LMaPJ6jhFKlo8g
Message-ID: <CAJZ5v0jJu2=MbdQ2z8a9JF8Lfz_Mci1+3oncHu8VCb4b3fA_Gg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Fix initial QoS constraint application order in PPC initialization
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jiayi_dec@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:03=E2=80=AFAM Jiayi Li <lijiayi@kylinos.cn> wrote=
:
>
> The original initialization sequence was:
>
> cpufreq_policy_online()
>     acpi_cpufreq_cpu_init()
>         acpi_processor_get_platform_limit()
>             freq_qos_update_request(&perflib_req)
>     blocking_notifier_call_chain(...)
>         acpi_processor_ppc_init()
>             freq_qos_add_request(&perflib_req)
>
> This caused a race condition where the QoS request was added after the
> initial platform limit update.

To me, the description above is useless for figuring out what's going on, s=
orry.

This is not a race, but an ordering issue.

The cpufreq driver calls acpi_processor_register_performance(), which
among other things causes acpi_processor_get_platform_limit() to be
called, from its ->init() callback which is invoked by the cpufreq
core before CPUFREQ_CREATE_POLICY notifiers and the policy frequency
QoS requests are added by acpi_processor_notifier(), so they don't
exist when acpi_processor_register_performance() gets called and they
cannot be updated by the acpi_processor_get_platform_limit().

You want them to be updated as soon as they have been added, which is
kind of reasonable, but it needs to be done only if
acpi_processor_register_performance() has been called by the cpufreq
driver.

> The new sequence explicitly ensures:
>
> cpufreq_policy_online()
>     acpi_cpufreq_cpu_init()
>         acpi_processor_get_platform_limit()
>             freq_qos_update_request(&perflib_req)
>     blocking_notifier_call_chain(...)
>         acpi_processor_ppc_init()
>             freq_qos_add_request(&perflib_req)
> +           acpi_processor_get_platform_limit()
> +               freq_qos_update_request(&perflib_req)
>
> The critical change adds an immediate platform limit update after the
> QoS request is registered. This guarantees that the initial P-state
> constraint is applied before any subsequent updates, resolving the window
> where constraints could be applied out-of-order.
>
> Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of cp=
ufreq notifier")
> Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
> ---
>  drivers/acpi/processor_perflib.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_pe=
rflib.c
> index 64b8d1e19594..3e7fe95c21d1 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -173,6 +173,9 @@ void acpi_processor_ppc_init(struct cpufreq_policy *p=
olicy)
>  {
>         unsigned int cpu;
>
> +       if (ignore_ppc =3D=3D 1)
> +               return;
> +
>         for_each_cpu(cpu, policy->related_cpus) {
>                 struct acpi_processor *pr =3D per_cpu(processors, cpu);
>                 int ret;

So AFAICS  this loop needs to check pr->performance in addition to pr.

> @@ -193,6 +196,11 @@ void acpi_processor_ppc_init(struct cpufreq_policy *=
policy)
>                 if (ret < 0)
>                         pr_err("Failed to add freq constraint for CPU%d (=
%d)\n",
>                                cpu, ret);
> +
> +               ret =3D acpi_processor_get_platform_limit(pr);
> +               if (ret)
> +                       pr_err("Failed to update freq constraint for CPU%=
d (%d)\n",
> +                              cpu, ret);
>         }
>  }
>
> --

