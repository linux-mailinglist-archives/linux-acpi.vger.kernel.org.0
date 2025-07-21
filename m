Return-Path: <linux-acpi+bounces-15254-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83085B0C527
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB83540223
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DBD2D8DDC;
	Mon, 21 Jul 2025 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB/WpQxs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB22C327C;
	Mon, 21 Jul 2025 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104441; cv=none; b=X20nv9JSnXE9sd6eD1/D9RWNb8fXEUH3k9yV6RODMFvCh7OKqsVf7ILzFSJtnG8Z7xIOrqja0JnRN0N7KFOuW/kByHjx5mIGQ32SGIgKpsnP99jQoX24pN1sR+pBznFaj+OYbSDL9/FTljCtVfTt2q45CAsWCTSJFfD/M+Sgo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104441; c=relaxed/simple;
	bh=cKOIaF/9e9LosSSyIlZcltURlxLbaR2oPOKVD+Xx1AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXD3BRQ27bQ27ZnxjbBGpQ0b8QG33txzizXAFinUOilpa1Jz0BD7fJEEhfNcBQjaIApmsWbnxZyLprASHoBiSHra26WbTP5TIHGA17Q/uZPHh0z1fYmjuU01ne6mRNv8cYVDLcSrx4Erd4PLXu+6y4jK+Z+rfPaFvXBS4bE4fx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB/WpQxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D5AC4CEED;
	Mon, 21 Jul 2025 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753104440;
	bh=cKOIaF/9e9LosSSyIlZcltURlxLbaR2oPOKVD+Xx1AY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YB/WpQxsu1YfRmlro/e24s/Vfd6LrcRL6asIIxZodVEBzfBm7FHBnYrsIhxA/Mpz8
	 IxLhbOJ0WtZV8LFypaDcX8aq4OMvi9S3ynjvFFKe9RdMZP3DEQ55n/1QYt2vlpkU/X
	 Ubm3LRRKLtAzO/l5SBio67sj+MulsHpAoiwR38EM6pzV6mCuzfdf0quKHN494bD5T6
	 aJoqKv1/ok/a+0xCuT18TlhUlB4ShKYy4jKMx+v2xpND6sExMuMPXQ5NrRqrqkhv52
	 zgyaVW9nzflEhD6BN9ItGS8c4kntjPjIzypW6GItltRXEPKQiSrOV8eBlGl0s2I4Sy
	 ZikbQJCGEUJDA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-615bda72cc1so768541eaf.2;
        Mon, 21 Jul 2025 06:27:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+1PVNMdyAB/oPq0UOvJi0uMD2FqhRitjNexBcSyTFy7YasULQ+/ClhJBOzdBf9z41cpE9oS7bh8E5iBTR@vger.kernel.org, AJvYcCXPO6K5GU7/y92X5reRvkTNfXvD88IDxKjQ7bbeFJ7OkdtD57rIzR1wY/mOmmz2BeFlCaETApsqEl/B@vger.kernel.org
X-Gm-Message-State: AOJu0YxOo063tuuqLuTkqDHsQnRKC/gg8rUTRRl85liqzXvD6MFU6tmT
	+oSW9YlMsUAcasCFpbxdgu1QT22V49apgAQSom0H2oPsrO+TNn1mJCfFuX1iotSmX8AxMdZhMN4
	V5jMNM08wQqz9GBSGBZgwB4qAxT3hhaE=
X-Google-Smtp-Source: AGHT+IEvddJwMY1Z1PmRABXKYKann2akoFsKkyfETHzAWJrAbllziuwBoMtm+BcZi6441BEYlIZLpD9/qyWKyrD0sns=
X-Received: by 2002:a05:6820:220f:b0:615:c868:2541 with SMTP id
 006d021491bc7-615c86825d2mr7397019eaf.3.1753104439939; Mon, 21 Jul 2025
 06:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718020312.856168-1-lijiayi@kylinos.cn> <20250721032606.3459369-1-lijiayi@kylinos.cn>
In-Reply-To: <20250721032606.3459369-1-lijiayi@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 15:27:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gf5wb1cNS0CJm9-vhMF63d2BzTEfBciiO9ZhdJHYpDnQ@mail.gmail.com>
X-Gm-Features: Ac12FXwrzJD0hWFzMewpQ5ouXApA-U82Afkv9Z0asWZhUvTxXi_PsCnqFDycwP0
Message-ID: <CAJZ5v0gf5wb1cNS0CJm9-vhMF63d2BzTEfBciiO9ZhdJHYpDnQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Fix initial QoS constraint application order in
 PPC initialization
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: rafael@kernel.org, jiayi_dec@163.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 5:26=E2=80=AFAM Jiayi Li <lijiayi@kylinos.cn> wrote=
:
>
> This patch fixes an issue where _PPC frequency limits set by the BIOS
> failed to take effect due to incorrect call ordering. Previously,
> freq_qos_update_request() was being called before freq_qos_add_request(),
> causing the constraint updates to be ignored. With this fix, the frequenc=
y
> limits are now properly enforced as intended.
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
> v1 -> v2:
> - Modify the commit.
> - Add pr->performance check in acpi_processor_ppc_init loop.
> ---
> ---
>  drivers/acpi/processor_perflib.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_pe=
rflib.c
> index 64b8d1e19594..56f2b8354d62 100644
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
> @@ -180,6 +183,9 @@ void acpi_processor_ppc_init(struct cpufreq_policy *p=
olicy)
>                 if (!pr)
>                         continue;
>
> +               if (!pr->performance)
> +                       continue;
> +
>                 /*
>                  * Reset performance_platform_limit in case there is a st=
ale
>                  * value in it, so as to make it match the "no limit" QoS=
 value

Applied, but I have consolidated the pr and pr->performance checks above.

I have also made some changes in the subject and changelog.

Thanks!

> @@ -193,6 +199,11 @@ void acpi_processor_ppc_init(struct cpufreq_policy *=
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

