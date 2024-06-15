Return-Path: <linux-acpi+bounces-6433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D559097AC
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Jun 2024 12:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2331284097
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Jun 2024 10:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1151282F4;
	Sat, 15 Jun 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxG8IVG5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895211CAA9;
	Sat, 15 Jun 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718447895; cv=none; b=I5qcC68b6SjixTQ2LXUhkJju/6oO/xwsS9nFucoA0iXo14UtbMuxqYhbqcD+Ar9tOT4XFoPcfPtq+Muo4UMXLNFu+T5tYFhHA7hozM9m352wQ7hSsxM4W+4BL0FJZqMPq/TakdPkBKkBlYGP6NZMStUbW0EToW0bW4IYPlXN4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718447895; c=relaxed/simple;
	bh=bQIHJFhN+jwux1gpEGfcRWklzbGenWnBc82tRmQGxqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2qr7vTRSRIGUSJneJGPWCYm83v4pl1Y5s0qtjENQOcUWNEaEHz6wc6ybhyDW9yX2WSlBbhEyoaCMCRZZc7vkOIJG8jcBrYsYHfqFyeaz3ovR5WaXF+Zq//jesLIQvayDUlKgRCcoc0ntrPOzldGDZbS7F9S4eaMtiqbKIdDnsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxG8IVG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08958C3277B;
	Sat, 15 Jun 2024 10:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718447895;
	bh=bQIHJFhN+jwux1gpEGfcRWklzbGenWnBc82tRmQGxqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jxG8IVG5bXOr/9JYhiITPvCZTw08Uv0FO8cKB2RcFkaexTa8zRBVIWaGB1FqwbzUe
	 L0WA8zJ9lj5RxivIZa3gQkCCvQabc3s7GQj1SM2NYku6v4LWar4O/N43k5rm9SfUQW
	 hNFhPYn+Q078cw8kRV5E/rMSWv6uqLpOKUmkt+YqYUtpXE1kSm8WU5r5p8oNBU4kcU
	 Tz3dSzFQR6WdJecqn1bkR8RPxCKF0uMQYlZNwVnsB7roX2AU4FgxNl+In9G1UbcgD4
	 8gx1xj4AogFSeW1zYggoZLNtjwBoLoo7OfbHt1U3TebYywYNa4WYfsZZy7Bnx3B70Y
	 YGhzalal/keag==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b3364995b4so209868eaf.0;
        Sat, 15 Jun 2024 03:38:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPe2zgHGyBKdd+vQelG+VuRgIs7MfDSsBPMNhW+P5j38pY8xyXsgVqlIrBijZtRga9FwPl8gCyOa0PzGA4OG5rd4bOQXBI/0fZCQ5r9IElAOOZTCzV4UG2qaRxkw5x4jCq1gDpI5Wrqg==
X-Gm-Message-State: AOJu0Yy6nB8ajqHjW/vDbVjxXOpRFNF00XG+j8RCRhIoXCAeL6W2q38w
	DHoNk/W4aIHVbu6WdWeBSXtx4+SUdAcLPWpPmhNJF7Iv3cR4w5KzCRAZjK1qBtVSDmwADQRk4rI
	Jz1Lj0269kvp1zynz20Ii29feKxg=
X-Google-Smtp-Source: AGHT+IF6OOSJEdFpmewIe43G9WIOjZOoEMqwz5to8488dVeN3OgvCuISjBU0Ohr5VwDKN0gOB1xmIuH5cSLg9u9jis4=
X-Received: by 2002:a4a:d027:0:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5bdadc10d0amr5196744eaf.1.1718447894200; Sat, 15 Jun 2024
 03:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614193241.7341-1-mario.limonciello@amd.com>
In-Reply-To: <20240614193241.7341-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 15 Jun 2024 12:38:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gMcR1wkOMkd5kHp8BZKdZd-HE9DrxByP9puCK-OUfGPA@mail.gmail.com>
Message-ID: <CAJZ5v0gMcR1wkOMkd5kHp8BZKdZd-HE9DrxByP9puCK-OUfGPA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Only evaluate the Intel _OSC and _PDC on platforms
 with HWP
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, CL Lin <clin41@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 9:33=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The UUID 4077A616-290C-47BE-9EBD-D87058713953 and _PDC methods are
> only used on Intel platforms with HWP support.

I beg to differ.  See arch_acpi_set_proc_cap_bits() definition.

> Attempting to evaluate them and showing messages on hardware without
> HWP is pointless needlessly noisy.
>
> Gate the code on X86_FEATURE_HWP.

Not really.

> Cc: PradeepVineshReddy (Pradeep Vinesh Reddy) Kodamati <PradeepVineshRedd=
y.Kodamati@amd.com>
> Suggested-by: CL Lin <clin41@lenovo.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/acpi_processor.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7a0dd35d62c9..84848b5e65d6 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -597,6 +597,8 @@ static bool __init acpi_early_processor_osc(void)
>
>  void __init acpi_early_processor_control_setup(void)
>  {
> +       if (!boot_cpu_has(X86_FEATURE_HWP))
> +               return;
>         if (acpi_early_processor_osc()) {
>                 pr_info("_OSC evaluated successfully for all CPUs\n");
>         } else {
> --
> 2.43.0
>

