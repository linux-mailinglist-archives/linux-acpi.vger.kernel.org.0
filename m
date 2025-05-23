Return-Path: <linux-acpi+bounces-13863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA3AC25BA
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 16:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FB254496B
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DDA293B76;
	Fri, 23 May 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnPc1M4f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C68145B27;
	Fri, 23 May 2025 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012210; cv=none; b=Uw9Olsv9RLG7S3lcLY65nAz3e8NTmmj54wg2S7Hz1/SUaAaGjO2KMYS4Uun1y13EPXJkYweKgr9h4G/TUKus0oYlOi1JG1T/bUohgy0qgnmAgsYo8Bqgo7OVCzEI78G1reFdhF5qs17lFsV/CbBTCdy82z83Gt44I/km4sK1yJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012210; c=relaxed/simple;
	bh=cCb/DvoMu0CWp6siRJR1jsaJg2IToKhu0I//iY/ilOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZ8Hn8OA61y/dln+lMUfJ0++80u5mOcevxrutUx2Fw6TG0FE8gP8x/ViyewvkAC5jspZ5ej1ZCMqCvU5Jfop52G6YylChoe/7d3QfsN06pBu2g8wyw0jck12So9YodDWWScEiXynkDCAB9l3hSnxO1LPGqRj4Dk/49Z05guu3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnPc1M4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99086C4CEE9;
	Fri, 23 May 2025 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748012209;
	bh=cCb/DvoMu0CWp6siRJR1jsaJg2IToKhu0I//iY/ilOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pnPc1M4f7iZql5mFbdV6759mYAQIPvCLIt0+R1Ve+GgvjneXSkluCg/5I6gIIV/Y0
	 H7HIGhdjsJ9nEni+4Oux2DA9q5JT2S41VchiFQiQ2YR2C/wtlyHvtaUvnHuyMJwuhW
	 Gfb7USpWkYLiQAfojRCQbusk9SpYBbOjK9WWFFvPB3UK1XpJGGXDcXVfjJgfSMcVfe
	 jBsVSdwlUH392r51aiyRh9m8tBrKLWSDRXb+GjxkD6q9ZNIYCAD1fYb7yF+N/3zECG
	 M1gwgkVpMeVjvnWevsvxOVmvPaQLZ++7E5xlTddGIagP2N7g9iIITcZZvqKjGh+x1L
	 WtOXhvYERP4Qg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-605ff8aa9d2so6159eaf.0;
        Fri, 23 May 2025 07:56:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/PfP9KNrYNyny8+QHZAoJkh2hdZYywyP/gpvFkfgHubwjYLZ0qIC9Ozp0u20KGi+y5Cf7Zw8UECMKTktp@vger.kernel.org, AJvYcCX+/ACzWA2qjkDMEAIr9mgxc1QjdyL1XM3x9xkUlAmxX9+timo3su0FMS45kdr9C4aMrGYb+r9+BVoJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCOsPn7MQRtu3Ul1qUMZ6zQFryhK8UQQebSahkmCsphNtRof4
	1+Wk4Z+wcU6lcv3f4s2yoEW46UwaY030cHUpwFHlBxfPwlb201reG7QZN6HFgf+Apy9lufERbU3
	IfZHz2wcJOcLa5ib0bSKGn21DCIb93QU=
X-Google-Smtp-Source: AGHT+IE2/o4D3OwyITiRDKyOH8lTlKZom5kbxW0as6DVJ82ORWnTo+EonsZuJW755ZVfXOW5bWm9xx7T1dw+g+Tbvng=
X-Received: by 2002:a05:6820:998:b0:60a:6b3:3b4a with SMTP id
 006d021491bc7-60a06b33c1fmr14725847eaf.3.1748012208993; Fri, 23 May 2025
 07:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518185111.3560-1-W_Armin@gmx.de> <20250518185111.3560-2-W_Armin@gmx.de>
In-Reply-To: <20250518185111.3560-2-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 16:56:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h91htjq4JzMkL3+K-oE1Zw+s5dvR5WPWnesSi7=97Eww@mail.gmail.com>
X-Gm-Features: AX0GCFvNEAo6WSG95yeoXO7McaJJ88fA1QwU1RTnUTg2QPf0f8vHNBW7uH9hV94
Message-ID: <CAJZ5v0h91htjq4JzMkL3+K-oE1Zw+s5dvR5WPWnesSi7=97Eww@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: bus: Bail out if acpi_kobj registration fails
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, j@jannau.net, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 8:51=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> The ACPI sysfs code will fail to initialize if acpi_kobj is NULL,
> together with some ACPI drivers. Follow the other firmware subsystems
> and bail out if the kobject cannot be registered.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/bus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 058910af82bc..c2ab2783303f 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1446,8 +1446,10 @@ static int __init acpi_init(void)
>         }
>
>         acpi_kobj =3D kobject_create_and_add("acpi", firmware_kobj);
> -       if (!acpi_kobj)
> -               pr_debug("%s: kset create error\n", __func__);
> +       if (!acpi_kobj) {
> +               pr_err("Failed to register kobject\n");
> +               return -ENOMEM;
> +       }
>
>         init_prmt();
>         acpi_init_pcc();
> --

Applied as 6.16 material, thanks!

