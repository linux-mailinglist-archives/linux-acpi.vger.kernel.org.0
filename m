Return-Path: <linux-acpi+bounces-7241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C689945FCA
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 17:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D3C28363C
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321B021C170;
	Fri,  2 Aug 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk4hneuP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD214D2B1;
	Fri,  2 Aug 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610855; cv=none; b=U40Cnj099LZ/CBstP04zAACLxY4WrMiyLYssDOtcUo08zT2ToyKP9NOisoXNZT+PjHxXjXFEtZquw9R1mfLUHq9UG3W1UVn7mi/sUvSITUL9e8vOIfgbu3l2C5m3/ohLpZqrjdQGfybUTgN4hbUguXGUb8WBwiBQGeHRsLdCHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610855; c=relaxed/simple;
	bh=2ELiqG08xZ0LVQMoVoxBT2tDnoWcCGTYUiKxCU2w+5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfNPA6g4Cvbx3PzZk118C/KjyVRGwI3LZ12p5Cu6yztz7EA5DB//QRRxWY+ATmjKTwFY9vglneXlk+K1f5nltCE105NJAWUhbJE7aKR/zylG0lmWSYu4OMsoVta563O93o+mqozLZFwFSj9ouCI4YdSPbBb3++4CmED8WJ+VJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk4hneuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0DAC32782;
	Fri,  2 Aug 2024 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722610854;
	bh=2ELiqG08xZ0LVQMoVoxBT2tDnoWcCGTYUiKxCU2w+5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fk4hneuP+MQJnzmWN/EVZhIG0hIMPbAzRrzjCZTx7R5Kz7NDz4PxYXqiTlIh9wEr7
	 0gHP+3gw1fMqqjDHZ30AK1eRNe9s9wl0cIhAhhflN/J2s4EbVjl1G+31o7ChM9QTlb
	 bI2aAnZR42E+QckE7I9BgKS0e06P9IG+5rU0zeVBtwNyt2L9NOHjxTLdIzIRq0jJXk
	 b1tJl0JGN1ap954E7/lvggf8zfp6CYJfU1ur3uF+iWWPrJk/JyVATAARaiP+C4wzGl
	 mWWghU4/LYk0gSCVnC9Gb98/s8uehLpkKoLsYEVmj2GOpB7AVid7ftkDq6laZcG4Qw
	 2bOQq4wJmtrgQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2635abdc742so1202041fac.2;
        Fri, 02 Aug 2024 08:00:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBnPHZ5S74bep3pZCjLVJsWh1FmyI6k+4H+opaAO/DJNV1pYC1j7WIVdpTSJ+Cw049iP6KOinFrFD7KuRX@vger.kernel.org, AJvYcCULc/ptWTR81XQN2mNEbqLcIcIoIocewfngMva0GsDIItrg8n+cduWGooKvTKeKSw5vCprKj7QRDLKB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+p3JdmZWzR8+lPjf4GbjzQVJkI4+syyK+gP/iO8E7Y3sYFR/9
	ySDbzwBhmSBEIlkNTJhEDhrfkk57VvFcwgQjr+TcADV+W3ZF3ZDUEnBvPMGnOxeHGyUCM3NUioA
	X5SfbkGSb5AXwzxB8Ark0nerGTgI=
X-Google-Smtp-Source: AGHT+IFil9pYtmy806vMRAxxrPLbT21xjDWO7nO5I3lpA8dnUVKCrF7typyrR8Zta02XxEzmjqHf9wKk+cPl6EFymK8=
X-Received: by 2002:a05:6870:2054:b0:260:e5e1:2411 with SMTP id
 586e51a60fabf-26891e9f598mr2318205fac.6.1722610854101; Fri, 02 Aug 2024
 08:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719145330.9430-1-lirongqing@baidu.com>
In-Reply-To: <20240719145330.9430-1-lirongqing@baidu.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 17:00:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gUfsaUej19ts-M0ueB3GyvKQ2vPk-pqc7uk1+G-f7cew@mail.gmail.com>
Message-ID: <CAJZ5v0gUfsaUej19ts-M0ueB3GyvKQ2vPk-pqc7uk1+G-f7cew@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Silence per-cpu acpi_handle_info about
 idle states
To: Li RongQing <lirongqing@baidu.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 4:53=E2=80=AFPM Li RongQing <lirongqing@baidu.com> =
wrote:
>
> This made the CPU bootup faster, otherwise Linux spends lots
> of time to printing nonsense information for each CPU when
> there are lots of CPUs
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/acpi/acpi_processor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 9916cc7..a19ace9 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -985,7 +985,7 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u=
32 cpu,
>                 memcpy(&info->states[++last_index], &cx, sizeof(cx));
>         }
>
> -       acpi_handle_info(handle, "Found %d idle states\n", last_index);
> +       acpi_handle_debug(handle, "Found %d idle states\n", last_index);
>
>         info->count =3D last_index;
>
> --

Applied (with edited subject) as 6.12 material, thanks!

