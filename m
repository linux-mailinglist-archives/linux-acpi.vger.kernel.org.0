Return-Path: <linux-acpi+bounces-6524-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC790F170
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E551C2478B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77E44374;
	Wed, 19 Jun 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8ycIJZa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629831D54A;
	Wed, 19 Jun 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809071; cv=none; b=Ti5h2K2YFh186lqx2TuoWUxBhOqk5hsPvHW8pn4pNGeyk2bhFlaUIsUh4sk9T62s3Uvx6ugN/6ZGpHqKVofDAlr/8sm1atOaw2SDE/t9C57Sa0dMkbP7a5PiYpD7IJuMDhVprOhDspkVfRW3BbKzUfl4qViHJmftFVgLjbNsHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809071; c=relaxed/simple;
	bh=ZkMHEgPxztw8pKKbY0XOy/xm8b5k/AZM4TZxny+/PJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XB1ngE60VCkLoTHUjy5mfj/ZAooZqPa47JN1EDoOyOxqwL3yMTYPZY0TJSll+8rLhzpnC+e6jnSaYa7AlOj7XZ8b6PqjVCmhVk6m5Ip44xyEUmgkb/4UGCspx3Bxqy5I7hU99TogvCuNto3xAiKp/Pr5gUbinZ/+B7r4THnAylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8ycIJZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E985C32786;
	Wed, 19 Jun 2024 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718809071;
	bh=ZkMHEgPxztw8pKKbY0XOy/xm8b5k/AZM4TZxny+/PJw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C8ycIJZagzNnNSA+hC1cRBGft8bjUMJJJNDCtyWe+er+1VmrnAdMkX/y2QINJe2E1
	 Morft4ce9ZM45q9RlD+idaF9h1DH/mc/4yXgkWaD+GWIFyQDEy4DZXWn/xTUMQWX8G
	 dJ/qgsByJzU0GmHmGaGiJLTJEPmYU9SSLmzdgc+56L/dUukihp7Tn90vDfRojJ+Fx+
	 el3iGGx/7Fzmzv423Oi2iqo5N1S0WjxKJcu7RUkmrO1a/40QJx9MFKRigXfp0RohMv
	 QYysRrpEfOyeMhV2XE238/ge4fW5UVdk4ads9jy6pvuZ1ntwgBsjC+AkUJ1u3d+rqO
	 NhbsfPkAo7OxQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5bad4e45863so240571eaf.3;
        Wed, 19 Jun 2024 07:57:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVI46MCO0l/rToRJ7OHdF/6S2Uye2McgAmCd6qp3x0y8hLBu4ryPwMkSAanxIdSei4ttecHCWQvcQ89GZkIdCFQxLH/YRouJUAs2KlInmZk6EqVMbjbKchqBwXPw1WxmZBY1YGxMulYrA==
X-Gm-Message-State: AOJu0Yz2b4XU7mpENx35HHVCvP2mxRlIgCJuLh7Vul/raDrFnz/30B3X
	9AahFzC7HXB+9p7PIYlsEdQwz0Jw1hk5f+cLzkPvjDWejs1Ynk7Mtm9O/GFH5+12kF0P+tUNOth
	4eLqptudmFNx5horaKpc7riVEfx4=
X-Google-Smtp-Source: AGHT+IGlpxlBrETuifBLsq18z7u9FT21s8dDGcIjFPkGNfc0Cnok6+3k27UncVRS6CwnMyMIXet28xE49ro39s40OV8=
X-Received: by 2002:a4a:c60f:0:b0:5bd:af39:c9d9 with SMTP id
 006d021491bc7-5c1ad9093ebmr3302786eaf.0.1718809070470; Wed, 19 Jun 2024
 07:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618214225.50953-1-mario.limonciello@amd.com>
In-Reply-To: <20240618214225.50953-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Jun 2024 16:57:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJaF16OT03V_8YAmRwQWgtQohTTw6pDKFS2hk0nDg59A@mail.gmail.com>
Message-ID: <CAJZ5v0hJaF16OT03V_8YAmRwQWgtQohTTw6pDKFS2hk0nDg59A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Downgrade Intel _OSC and _PDC messages to debug
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, PradeepVineshReddy.Kodamati@amd.com, 
	clin41@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:42=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 95272641338a ("ACPI: processor: Use _OSC to convey OSPM processor
> support information") introduced messages related to determining processo=
r
> support from the firmware.
>
> The UUID 4077A616-290C-47BE-9EBD-D87058713953 and _PDC methods are
> only used on Intel platforms, but all X86 platforms emit the messages.
>
> Attempting to evaluate them and showing messages on which are used is
> unnecessary for most users.  Downgrade the messages to debug instead.
>
> Cc: PradeepVineshReddy (Pradeep Vinesh Reddy) Kodamati <PradeepVineshRedd=
y.Kodamati@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/acpi_processor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7a0dd35d62c9..e82ec4f126bc 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -598,9 +598,9 @@ static bool __init acpi_early_processor_osc(void)
>  void __init acpi_early_processor_control_setup(void)
>  {
>         if (acpi_early_processor_osc()) {
> -               pr_info("_OSC evaluated successfully for all CPUs\n");
> +               pr_debug("_OSC evaluated successfully for all CPUs\n");
>         } else {
> -               pr_info("_OSC evaluation for CPUs failed, trying _PDC\n")=
;
> +               pr_debug("_OSC evaluation for CPUs failed, trying _PDC\n"=
);
>                 acpi_early_processor_set_pdc();
>         }
>  }
> --

Applied as 6.11 material, thanks!

