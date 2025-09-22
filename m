Return-Path: <linux-acpi+bounces-17205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1058B9261C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 19:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DB52A6098
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC4731352B;
	Mon, 22 Sep 2025 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViUAK2/2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2522E9743
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561486; cv=none; b=Z1Re8h4XTrF4/8uDlC3wmBHPvOS+xGc8xS8ZH44Rx53qSZtkCqkv2aFe/HYKSUGZeHwYJGelldvgT0MidxmUwV/O0LGsQ+rwypCalxBYis1jbm2d7oHupRDzhS/GWRqaagZDiHbv9s4PeWpI060TEG+EGeVUab12Fa39RQdFTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561486; c=relaxed/simple;
	bh=enZkKfhodSYHXmBDcDR/RNv7c8/uGVx7TcD8skb9/3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHaBgWfPjnphY/vKUSZPSvu7gEKQMifBHpuAIAeMl0a7g8Z8IUxcIloHDPkUhpOiOxA7oXM7uiHbr8cI3VeEbFbOSQXe+HKCzBlBz4+bu5GOzyytX7iQOEH2EoCaqsyL1aLb2D4yTZnhsH6aCrfaHqeI0CFRLpXGo9BRUF84nn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViUAK2/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FE6C4CEF5
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758561483;
	bh=enZkKfhodSYHXmBDcDR/RNv7c8/uGVx7TcD8skb9/3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ViUAK2/2Bs6wgIQDrLCZe7FKrUhCfsoix+i+a9c+175bcfD4fDIlLWSPbT+gyh+RP
	 HyfwwJbSRdqxnIFEzedbkjuLt12HyfBaQcXByfhkGHFoD/pN7iH5RO41CWm15D8Gy0
	 yne90/8PZ2jM65puCYb2rfWzvFyxRWV9wG/5iaOOAt3ibBNEds/rdgUA7FTON5EbLY
	 q63JRDeoJt8OnUipt5orC9+5jZJfbX2iFKVCqstlwMxwQOah7JKUDI7dX9nHoNaSXi
	 xyT9EvAdABsaqHw/9d4Wb6me4RfrJpf27tWHkq4mwUL9ghFWNXzuCVHb4E0IEGO5j0
	 isispriu0juCA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-746d7c469a8so3958657a34.3
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 10:18:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4ghZkfebAJiJGRc/5G/jxx+EwOdLQ7vKPt9+giyPYJbsjOMZz754igq0tN+hSOq0KIa9UxKpo/heX@vger.kernel.org
X-Gm-Message-State: AOJu0YzECMP1484N2MiIMVNKzt8Ahs8Yjg3I581fn0fABr6/q8vWllwW
	gr1d34uQmY6rJQfoAe4296yKlJD2nLPcfO4m9Vcw0WuJypQXDAgMOj0WHxd7NBNqAs2li3cirnq
	xGM/xNmx2TNSZP3UvnD8SA0JfKclvyGs=
X-Google-Smtp-Source: AGHT+IHUncAFS4+QQtYH5NVFMfrisxjDMaSw0Buwa14WXCBucunJv2D41mo7ZP/+DLAN5ZyKrPso6qKfSQDig76a7Pg=
X-Received: by 2002:a05:6808:f0c:b0:438:3ae6:d5ab with SMTP id
 5614622812f47-43d6c29ca28mr6873088b6e.41.1758561482723; Mon, 22 Sep 2025
 10:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915204318.696058-1-superm1@kernel.org> <20250915204318.696058-2-superm1@kernel.org>
In-Reply-To: <20250915204318.696058-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 19:17:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jN57sT1Z9Dpth5_9q4aeSbNM-onWRkiOHknpxzowVZ8A@mail.gmail.com>
X-Gm-Features: AS18NWCZHJSjhg1qxPjcDy8x7aZL6MRk1ArmSXo6VfPCQOdNaLx3nDC79l625EA
Message-ID: <CAJZ5v0jN57sT1Z9Dpth5_9q4aeSbNM-onWRkiOHknpxzowVZ8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/acpi/cstate: Remove open coded check for cpu_feature_enabled()
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:43=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> acpi_processor_power_init_bm_check() has an open coded implementation
> of cpu_feature_enabled() to detect X86_FEATURE_ZEN.
> Switch to using cpu_feature_enabled().
>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  arch/x86/kernel/acpi/cstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.=
c
> index 8698d66563ed6..0281703da5e26 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -89,7 +89,7 @@ void acpi_processor_power_init_bm_check(struct acpi_pro=
cessor_flags *flags,
>                  */
>                 flags->bm_control =3D 0;
>         }
> -       if (c->x86_vendor =3D=3D X86_VENDOR_AMD && c->x86 >=3D 0x17) {
> +       if (cpu_feature_enabled(X86_FEATURE_ZEN)) {
>                 /*
>                  * For all AMD Zen or newer CPUs that support C3, caches
>                  * should not be flushed by software while entering C3
> --

Applied as 6.18 material, thanks!

