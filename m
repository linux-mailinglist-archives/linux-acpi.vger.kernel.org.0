Return-Path: <linux-acpi+bounces-1716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314C37F378E
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 21:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D1F1C20431
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D75101B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344D19B;
	Tue, 21 Nov 2023 11:56:47 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d7e4e61bedso61948a34.1;
        Tue, 21 Nov 2023 11:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596606; x=1701201406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZOeqvRu3LxXiXrSd8uRhoWsi+0XXhfdsm4I1VLjf3E=;
        b=rJIJzUrRnpbYgZK6BkjlbrWcfpssqPzIHQB3LBNOHypWzREeicTzqfu7ffvU0EbpPp
         1PhyBExusenPeV3CVQinpZxJc62ZOem5jBi7BOqB/KzRXGkqOJ2rWHsYQ45Q0HoVS8Hn
         79N6ayKJpPXLcAhQ2l687o2ajBpRlXbUkJZhDmhEE8MsLC8TTQ/LepMYrH0aXHIuSK4s
         HPizehaAJPd5OU/Kzag0NLTYMZs8kRg0BqlmOWQwrBPa5zg4BvdQjOFbfjn/JUaP2Qfq
         3NzX4buu/zfcn5hyHShX+s/02l59ZauC4H1QE+VMHBeJaWaKphbSyoGANyQr8sXalaDP
         wTOA==
X-Gm-Message-State: AOJu0YzDJjk2tBzKjKjoHkIL9qZY4XWRanEowdD/I61Tq64VjF2SXUa+
	PnrAE37E4FsbVeK3dIY1YzaOC7luafdBuWGh7g0=
X-Google-Smtp-Source: AGHT+IGfoh2AoQ1+r30cMz7Wi8VaxFkshXC+ngX/S9+JfPwwxHfOaJ4eH6D9XO8XC+cmqNdq15Zv1NpUwr2qAfyohqM=
X-Received: by 2002:a05:6820:311:b0:58c:e80a:537d with SMTP id
 l17-20020a056820031100b0058ce80a537dmr411410ooe.1.1700596606357; Tue, 21 Nov
 2023 11:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <430a1271-a45c-4f5a-90c7-a62703ac7cf4@ancud.ru>
In-Reply-To: <430a1271-a45c-4f5a-90c7-a62703ac7cf4@ancud.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Nov 2023 20:56:35 +0100
Message-ID: <CAJZ5v0gHgfscDCGo3P5JVn73uUTBkpfCqRJV3QcOnFt8FP7FhQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: LPIT: fix u32 multiplication overflow
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:09=E2=80=AFPM Nikita Kiryushin <kiryushin@ancud.ru=
> wrote:
>
> In lpit_update_residency there is a possibility of overflow
> in multiplication, if tsc_khz is large enough (> UINT_MAX/1000).

That would be a TSC ticking at hundreds of millions of kHz if I'm not
mistaken.  Why is it really a concern?

> Change multiplication to mul_u32_u32.

So why is this better?

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: eeb2d80d502a ("ACPI / LPIT: Add Low Power Idle Table (LPIT) suppor=
t")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>   drivers/acpi/acpi_lpit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> index c5598b6d5db8..794962c5c88e 100644
> --- a/drivers/acpi/acpi_lpit.c
> +++ b/drivers/acpi/acpi_lpit.c
> @@ -105,7 +105,7 @@ static void lpit_update_residency(struct
> lpit_residency_info *info,
>                 return;
>         info->frequency =3D lpit_native->counter_frequency ?
> -                               lpit_native->counter_frequency : tsc_khz =
* 1000;
> +                               lpit_native->counter_frequency : mul_u32_=
u32(tsc_khz, 1000U);
>         if (!info->frequency)
>                 info->frequency =3D 1;
>   -- 2.34.1
>

