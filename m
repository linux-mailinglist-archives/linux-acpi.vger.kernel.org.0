Return-Path: <linux-acpi+bounces-11259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059ECA3A340
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 17:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFFD3A4181
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF226E65E;
	Tue, 18 Feb 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdaOIjRJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F826E658
	for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897612; cv=none; b=AzoIr9AKfSvVWM+ZilktHsCIX2caa8wkPPOVcStOVU42mPyIOKicF97TNg4d+dy6ITzuPftLOiQC2SKUmjs/pNY6HSKg1MoqPHrbH7j5IUZOwATtJxuuidn1MAybMi0HPz2E0FQWwXDGHXXaihIezjdP3Vc8R7HzkNg6Fk8SYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897612; c=relaxed/simple;
	bh=hR8MMXlNCW88X3koPZtJwoDpdxUn6JugP+51axQGeuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jp7ZJes/IGd6+PHN+Sf7D2nSKlQEJ3J+elblj6kgOED116R0EgKOUMs8PolkP7HmF00kjmq3LR3HbY7HCCvVIeKVNGdc8UWCTIvjlJwb6GxoK6EiW3ed9Ghv0s5GkKxbdd0c3/8Dds7XpdDvHs6Qx7fE38sEs5S6JHeMx7v136w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdaOIjRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C34C4CEE2
	for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739897610;
	bh=hR8MMXlNCW88X3koPZtJwoDpdxUn6JugP+51axQGeuQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FdaOIjRJg1ceTV16HUKb8y2wgSCLTDivORoSXHUSjrcZnPM+y8AP9EyEOzLiM20RW
	 uk+P8OjqPSp6fZ1kgq/0VabMWTf7vd+tAzhsGdI5qqW/XsKUdRz1SVPOKdlA7WaXN0
	 Kox9+G/4M2B3c5zlDsV5hfMwXF9SyaEH2Ja2gHAmQQ+qLNSlvzIaVhD3tBj1VkPNiH
	 yhSx8D4OOkjs/rORc+fn+/OQ2IlvY8BEFCjQHyBKUB9LM3SAGY56n+cZMwK7WIW0lS
	 RX5s1Kr0kEWf/YbYXCbFIsYLX5WgFjbBGTJkNnlA76u4pkSYnPe4j+yfz/6W0khB5L
	 kR2LczxaMDBTg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fcd124dd1cso1516051eaf.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2025 08:53:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWbleMWtDiSSroC4ElzkV3ptIEYajX2ohIZ1VibwJ7XpmxaeVDMgAEjUkEbtU0CX/r4Z3sN40bKE93@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Urg8PcywYgclRIdftWoOr8FFfWq9VLMXkq2Y9Y/Itm1BFRJm
	vXkKHzx1h0+gOaCzg3WzyC5OgbjCDSVBXcc2C99blROtWy4wuGK6VyNEaqKi5t1MuHI4v3MImiK
	WfY4XVsXbw4nD4CC3XWMTmxTbUO8=
X-Google-Smtp-Source: AGHT+IHOuaoPIYcmjF1YLjKbluYni5Lva5iX36d8J+egpUj94ze/3E6m4vqAUqnnVpjH17RrjH5O805Xni+3hYF3oKk=
X-Received: by 2002:a05:6871:2003:b0:2b8:d77:57d1 with SMTP id
 586e51a60fabf-2bd101dc29emr276000fac.15.1739897609983; Tue, 18 Feb 2025
 08:53:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204112219.3969629-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20250204112219.3969629-1-mika.westerberg@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 17:53:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0id3-we-MGKg6qJqKZXtqXUv=t+M=vFzzdnMtvPAEThBA@mail.gmail.com>
X-Gm-Features: AWEUYZmIlZ5hjlyvcXSA-Lh0HNmuPQ8jV1po5C2dN3GQp9h8iDF9riXgdRIQ44o
Message-ID: <CAJZ5v0id3-we-MGKg6qJqKZXtqXUv=t+M=vFzzdnMtvPAEThBA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Use my kernel.org address for ACPI PMIC work
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:22=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Switch to use my kernel.org address for ACPI PMIC work.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..d6283fad64df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -355,7 +355,7 @@ ACPI PMIC DRIVERS
>  M:     "Rafael J. Wysocki" <rafael@kernel.org>
>  M:     Len Brown <lenb@kernel.org>
>  R:     Andy Shevchenko <andy@kernel.org>
> -R:     Mika Westerberg <mika.westerberg@linux.intel.com>
> +R:     Mika Westerberg <westeri@kernel.org>
>  L:     linux-acpi@vger.kernel.org
>  S:     Supported
>  Q:     https://patchwork.kernel.org/project/linux-acpi/list/
> --

Applied as 6.15 material, thanks!

