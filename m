Return-Path: <linux-acpi+bounces-14278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6DDAD425F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 21:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8993E7A9F4D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D9B257449;
	Tue, 10 Jun 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N57LmcyE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C842571BD;
	Tue, 10 Jun 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582002; cv=none; b=AAIl3dtbxmIHTRBGpxFi+Lwz9hnuZvtrWGGPwziX0zuyCwsFZ9hQMBjzhGCu6OUxWW3F52DjgeGNDBvSOdlCvIfIJr8+REXI5VBUgxnWHiIdF9nYbn69htuRQ2IG1bipfRg2DTbfFmhJdpBPve0EFBzw42Ow4AjqMrAeG1A27sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582002; c=relaxed/simple;
	bh=s0c7Xmf12cfUyyoOFjeDnR/T9o/hmnWX0j4vP8nHfAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUFxXBHmXukYxG7FMDIrRoCAboBDIDWZE+YxtfVCar1xtZU1NCPn/k4RpZneYyjIn9HaUk4TPAsllypa4kZ40bSipDTgWzRTqUSELDGMT/Czv3KFpDHqyEbLQsxeivQOykz/NJfxabAAyZKv/Ep09e5xmIN4OFja0ZCMyrGeRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N57LmcyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE9AC4CEF2;
	Tue, 10 Jun 2025 19:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749582002;
	bh=s0c7Xmf12cfUyyoOFjeDnR/T9o/hmnWX0j4vP8nHfAQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N57LmcyEBzXNExyKfwjCB23EwZQVtNP3HOAKuZEf9GEDBitw5xlNHmGBOcZKm0koZ
	 KRbvKh5MUEZ+gcF7JzBmMRbEy7lADVrfrBEhr5ZC+u1rwTIuuauKuIrZFg39jwsdw1
	 +EKde0yLHgWaHZDOTL0/nUEslta46G7JrltjgRJWSOnyTIFQ4/sNF338J/28jFL4pq
	 rdsy2FpAxL2nNHN/tro/xxWavmB5xC2Go17KLLbJfA3OYtQQKOupMU28/1PGJbmeDQ
	 yLf3NT3jOzzv8bvO2bOm6S0eu7TVoCsLzMgZNeil0qm4g2CBN5LhpvwPXqBEldBsfy
	 ILn8SCersfnjw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4074997ce2bso1486931b6e.3;
        Tue, 10 Jun 2025 12:00:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWD8TPo88jax+M+N/2CmG6N2068t4nE9Om6Mlx69DOMDiBcC+AuUo3qKOdDtCxL4P7MXrcGcvpLv9BJ@vger.kernel.org, AJvYcCWpjNbRvsyGMcOuMuHlVgzh76U2cNlhc+3WkqVQ/PdfQYCUrc2+Jql0RY9xHYJFIVWeIvgBe6cnykuVpiPv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj2hiwUptDS/qPAhZjtIXb13x39iEKwEsHSvsqCpcERgWTPkBc
	mxQjLyY1eXn/+my2Zv6Wp9jJ9K8cfOSNmwQSMIrl5TWuf54HbeK5mNJLDKHsjeSGrdZtBzJSofb
	2CzhCcd6y3CmJGwogjMXUwlVxb96rEoU=
X-Google-Smtp-Source: AGHT+IHudCxeN25CKYb9NEpQCun/0hcTV28vDA5tQPywem9CXtsDmZahyN3Ukndjr8f1kVJQufTKd5TXgWyFUmVGnHo=
X-Received: by 2002:a05:6808:1b27:b0:403:3e86:ab4c with SMTP id
 5614622812f47-40a5d172cf1mr397617b6e.39.1749582001456; Tue, 10 Jun 2025
 12:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603122059.1072790-1-guanwentao@uniontech.com>
In-Reply-To: <20250603122059.1072790-1-guanwentao@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Jun 2025 20:59:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hUGYGZxht-XRRQeCYvDTLV=Ho4ywqW7cKFg0UFFHPDcA@mail.gmail.com>
X-Gm-Features: AX0GCFu84KlSjp60a-rImM1wqAe-OazhQAamtQywjpaphPQ0FcuYOZre_VxDJA0
Message-ID: <CAJZ5v0hUGYGZxht-XRRQeCYvDTLV=Ho4ywqW7cKFg0UFFHPDcA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Use IRQ override on MACHENIKE 16P
To: Wentao Guan <guanwentao@uniontech.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wangyuli@uniontech.com, zhanjun@uniontech.com, 
	niecheng1@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:23=E2=80=AFPM Wentao Guan <guanwentao@uniontech.co=
m> wrote:
>
> Use ACPI IRQ override on MACHENIKE laptop to make the internal
> keyboard work.
>
> Add a new entry to the irq1_edge_low_force_override structure, similar
> to the existing ones.
>
> Link: https://bbs.deepin.org.cn/zh/post/287628
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 531684a69c645..e12a318b38bec 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -653,6 +653,13 @@ static const struct dmi_system_id lg_laptop[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
>                 },
>         },
> +       {
> +               /* MACHENIKE L16P/L16P */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "MACHENIKE"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "L16P"),
> +               },
> +       },
>         {
>                 /*
>                  * TongFang GM5HG0A in case of the SKIKK Vanaheim relabel=
 the
> --

Applied as 6.16-rc material, thanks!

