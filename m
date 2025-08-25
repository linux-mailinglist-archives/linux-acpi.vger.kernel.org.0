Return-Path: <linux-acpi+bounces-16046-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E7B3497A
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 19:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C445E7A0C
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 17:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2714308F0F;
	Mon, 25 Aug 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWVJqaeO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC11308F08
	for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144714; cv=none; b=iqqFPaQFpI6jgqKzp6E0ybfT46t09HvoE45YxmulFGcFeEwvVXwEmhP0/9YGjT/vnCgwd0hW8RmBLCUY+NdRkX7nk/DEmIKOA+FsN5ts/w/DLcECrnSQiXMisI6WsP0eQT/i1GBKt+LbaVVBf0qFxhWPjZS9Ec9BHwAYXmZCtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144714; c=relaxed/simple;
	bh=2ukWM2rpOWZWYuwRv/Vk/ZErRVjUVZsb8scUEbQDWuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMTgqpLPHn3SjRk3tyjzKKlJbowm0aH0Rg2N2nYoYDid/fYFqIaFQR37f2lSuWGloq6/CkYtT8sstKeuXvnfOjUHwooYMocUXI2G44FB2Ks3RCzK+RGA6ZhbupF8alYgfAB4HYQrSW+lXo4xSUmu7usGVijK7RQjBgo8AUyj+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWVJqaeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF945C116C6
	for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756144713;
	bh=2ukWM2rpOWZWYuwRv/Vk/ZErRVjUVZsb8scUEbQDWuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nWVJqaeOwRuBKVDLdMVbdrFBoDy5JHVp1Yo1Ye4vN6IZUpbcKNsanS39jIkOILPDj
	 47tYptZTxEig8eb0LQ1mSZ2fVapuc4hw4n3a39mlfnQZ/tMHipwLajbhRWVvdWXSzO
	 /Sq/2UyS/eu1e9IS1n98za/DLEIyRyGyecx5gZJZoAiO9nz/ZQwfb/rWISoZ+QgQ4L
	 IWgvUmyHPu9treSDXW/fAPCYUtAhaXonHIy1zMk6llcHI4toM49QGIHKaOrxDcVIwk
	 kJKUVhGoEg4nmkgI8ZsW+YP9zxg4Agfs16xoVjrlXjQB1cCpZEYimI0zVHacBiHpJl
	 BlsBOGMM6sb1g==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce8c3afaso2942950fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 10:58:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAvVI8fTrF/HH8DZ3rMSHNGuriyS0ZGO+HNokb2ncJXllLcXcyEx+O3wRDoE93AAXqTR6QYNTxcVW6@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSFa2pHy7rjnxkc77M0i0Gs4qmSuK5V8zB+AJTes8rmiCNRhp
	Ijjqfm5bJwTBYu52twIYPRVnmJ2vrIvAzSGEgS+zPTSvjZoMTiE91xgho03dffXqHoS8ei2Q+Xu
	MfCUJurC7E1PDtS+xYuNPYd0sHV2lris=
X-Google-Smtp-Source: AGHT+IEMhic5625tNI9PADD4za00lU0OQOvu4/pkjQL98z33TtGtemDOVxF8H+pr4SYUrJBaet5ImtuNaWgqsqisb+w=
X-Received: by 2002:a05:6870:c0cf:b0:2e4:c5be:8e6c with SMTP id
 586e51a60fabf-314dcabe825mr5378914fac.1.1756144712989; Mon, 25 Aug 2025
 10:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820044309.4133802-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250820044309.4133802-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 19:58:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gUBsr6Q=A6Nfr=pSEJA6mBv++iaT7a7uq1yd5rX=oxig@mail.gmail.com>
X-Gm-Features: Ac12FXwNn3wEMxmEibZsqjKBULBDXWno1kfHpepO4sknuwzMhjr_EbATbIS5_C4
Message-ID: <CAJZ5v0gUBsr6Q=A6Nfr=pSEJA6mBv++iaT7a7uq1yd5rX=oxig@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Battery: Fix incorrect fallthrough in extract_package()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 6:44=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Fix incorrect fallthrough behavior in the ACPI_TYPE_BUFFER case of
> extract_package().
>
> The current code processes ACPI_TYPE_BUFFER data and then falls through
> to also process it as ACPI_TYPE_STRING data, which is incorrect. The
> buffer case should copy the buffer data and then break, not fall through
> to the string handling code. This ensures that buffer and string types
> are handled correctly and independently in the switch statement.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/acpi/battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6905b56bf3e4..18fc5d828e70 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -445,8 +445,9 @@ static int extract_package(struct acpi_battery *batte=
ry,
>                         case ACPI_TYPE_BUFFER:
>                                 if (len > element->buffer.length + 1)
>                                         len =3D element->buffer.length + =
1;
> +                               strscpy(ptr, element->buffer.pointer, len=
);

Why do you think that duplicating code is a good idea?

>
> -                               fallthrough;
> +                               break;
>                         case ACPI_TYPE_STRING:
>                                 strscpy(ptr, element->string.pointer, len=
);
>
> --

