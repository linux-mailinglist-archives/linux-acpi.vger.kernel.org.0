Return-Path: <linux-acpi+bounces-1764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9CB7F51C0
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 21:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7DAB20C7A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7882225548
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57BAD45;
	Wed, 22 Nov 2023 11:50:32 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f92cc9b2c5so14869fac.1;
        Wed, 22 Nov 2023 11:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700682632; x=1701287432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i13eRCRuzIPfY/WqVtCzJrgnUD1kwRhCgNmFzwsG9Jo=;
        b=EqltRsny2ys42NR3GpDjB9nf0+/MKL5xt1jwvyQTripRBwwoq/el64XZHTuI3EkTOh
         Sq89DPpyEk5doe9QtrlBqq9ng7uP0FbOeczUSJUEl3GQ+hY2Hli56od2tp+FvV/eui+V
         KlF2evsl4vVsr/DWnbN/ShzmWeYUCzCKTJegFWXLmO77CjTuROhXu94R4R0up2ASKLrO
         P/uGOLgFAmjsBD20X61CcwHFonmEftqQBEWkzkdysak4UXMlfh2sOY8RahngmSIu8ccQ
         L6Ch5ZA2NYmffzsxWHfvMwiXZE8BENfhdiYA8UgsSpLYXpam/Z7JQkpcoAzvuOV/Yp2f
         9Y4Q==
X-Gm-Message-State: AOJu0YwV/sj+DKzWw5DpNUIxqoDu1mTpYMzSd8cYUNHanvgvPsyHaWst
	v7bnqo4EpylSwc6rzu1lY+VnLpaSNRA5IgLWCgI=
X-Google-Smtp-Source: AGHT+IFV368Lp2Xym8iwW46WxUk4gVpMUQnMSqrXsaUEikzxvKwKLNfIfCbnEeFUmmaywR6UDqe1cP5ID4UG0kr2Ovg=
X-Received: by 2002:a05:6870:2401:b0:1f9:5d11:cc7a with SMTP id
 n1-20020a056870240100b001f95d11cc7amr4006681oap.3.1700682631827; Wed, 22 Nov
 2023 11:50:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <430a1271-a45c-4f5a-90c7-a62703ac7cf4@ancud.ru>
 <CAJZ5v0gHgfscDCGo3P5JVn73uUTBkpfCqRJV3QcOnFt8FP7FhQ@mail.gmail.com>
 <CAJZ5v0jGSSevWuBKFK0z+bQ2QB9+GT=ofnY=MF=53N-r7QEhSw@mail.gmail.com> <cf813067-9b73-4eca-8c0a-668fc68ca6b0@ancud.ru>
In-Reply-To: <cf813067-9b73-4eca-8c0a-668fc68ca6b0@ancud.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Nov 2023 20:50:20 +0100
Message-ID: <CAJZ5v0gmRgcT=FsaAcE_dP92JnC3vEY-NF630caK3p03dLw43g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: LPIT: fix u32 multiplication overflow
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 8:41=E2=80=AFPM Nikita Kiryushin <kiryushin@ancud.r=
u> wrote:
>
> My reasoning was around something like:
>
> 1) tsc_khz is declared as unsigned int tsc_khz;
>
> 2) tsc_khz * 1000 would overflow, if the result is larger, than an
> unsigned int could hold;
>
> 3) given tsc_khz * 1000 > UINT_MAX is bad, tsc_khz > UINT_MAX / 1000 is b=
ad;
>
> 4) if UINT_MAX is 4294967295, than tsc_khz > 4294967.295 is bad, for
> example 4294968 would lead to overflow;
>
> 5) 4294968 kHz is 4294.968 MHz, which seems realistically high to me.
>
> For me, tsc: Refined TSC clocksource calibration: 3393.624 MHz
>
> (seems like, it is derived from the same value,
>
> pr_info("Refined TSC clocksource calibration: %lu.%03lu MHz\n",
>          (unsigned long)tsc_khz / 1000,
>          (unsigned long)tsc_khz % 1000);
>
> )

OK, fair enough.

> Not sure about the math above, but it seemed reasonable enough to me to
> switch to overflow-resilient arithmetic here.

