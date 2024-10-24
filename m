Return-Path: <linux-acpi+bounces-8949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE169AE2C4
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 12:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C25F283CB5
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31C01C57B2;
	Thu, 24 Oct 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijZjmT05"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10451C4A35;
	Thu, 24 Oct 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766402; cv=none; b=MEuGijlXF5X4Zn5ShjKjPKUP4rapPj+GVTySfYTclF3UuetR4VyqBCHj6Kh1sNnRoYKF0PLqRqvokCze5WPDX18htktjrOVmMsXGzXH7Jf+Px/fBoHZOU1o4cBRmod5PUJBXEJGc8P0vG2IcRrhyFLfWHcDSCpFjNsw3G4IxZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766402; c=relaxed/simple;
	bh=xpKzc+yti+VywMW+rD7x7G+PO/MU0Lu9i53Q4xsuIl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7YOOaxc7vTLY3RF3IT7iVNkvLDSzo0dO7B0FCWFJXQS8Y4V97eHzYNx6hftC0pJ3E/YizgeXOOVE0eVISx915nf46s5f9+q/p8+IVXysDxQNSmbNYxyyxxrPjV5GY3q3xsW25j/mdPR0qaiUoH4BuRbXwA/gBmOQYXB1W9OcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijZjmT05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428CFC4CECD;
	Thu, 24 Oct 2024 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729766402;
	bh=xpKzc+yti+VywMW+rD7x7G+PO/MU0Lu9i53Q4xsuIl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ijZjmT05WgTszLdqjOiFi7t7wHxWX4oaYB7o4b0YN3JYpYMbHNMCOmR1U8euf5Fgt
	 IhgDaB1AApsRClVnWPyEXUHnSgPEatHIWpQPQxTbgSsq/09Q+8PWFqRsDadJ4gyawI
	 cJB0ooX6RToroas1eSNHiI2OCfarROx9Y9iW3dkg5RI7u2uA/eRAPHXw30y+jibGA5
	 DBMd1Fheu6Hp16DKCzvJaZTOeQG7Gx7q4mj4vU/QRpTg3Ii6yJJPM4aL0ERJJKRdkg
	 P7h8FQCqKiSq1r77i5bd/bL4C1CEV1z/OijO7CjVmO+GLN1eQL6HLco3tPmdfAf/u3
	 Z3F3GeS3ZetdQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e690479cso790872e87.3;
        Thu, 24 Oct 2024 03:40:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDjBetQjx/PuHglW9lnBlkaind/jc8IlCn8AvYTv9fyQ6DaZWjr3AsLo0oOe0Gq34VIvNpU0jT74xnguCe@vger.kernel.org, AJvYcCW5AfEDQdOgQAY7V9ZL6OohNikMtEJK7hObh3ONlj+6OWk4xjt9pxVAN2fMgBWJ25ewyY5cVsLz1vYJ1uI+/Xk=@vger.kernel.org, AJvYcCWFujwWxiTntYAo3/qwRk4mM0mvqd8IKZYvP5kvu13aSwx+ooZvoFNCA4NVcPngV3JxLmWmr0gRTZn0dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvURc0lnVzi7oT1hsRN6UUnCxcICxZlwyGT9TZ+ZvVui7tqPvK
	zylttOw4HkqxGDIseXtVf4cZu3m+kJnYk56iVfq7CoQ3NaBFaxUYZaSAHQ4EX08+CBR8fyd1Nx4
	45mGJIvedigd7Cir4TMDV3LD7gDc=
X-Google-Smtp-Source: AGHT+IF4H6zTrna94vNlhEwFT8vm1ZoovqZTBEfuw+/mvfaWRMzzqJ4nAtwpbrDyFaY+Z2r9nr6H6301ydnonp7guLE=
X-Received: by 2002:a05:6512:23a9:b0:52e:9b2f:c313 with SMTP id
 2adb3069b0e04-53b1a313464mr3298161e87.22.1729766400515; Thu, 24 Oct 2024
 03:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3777d71b-9e19-45f4-be4e-17bf4fa7a834@stanley.mountain>
In-Reply-To: <3777d71b-9e19-45f4-be4e-17bf4fa7a834@stanley.mountain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 24 Oct 2024 12:39:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFRUhkCyN0PjLrtw1uSCuy4m=9g=pwNO9tkxckj-koijg@mail.gmail.com>
Message-ID: <CAMj1kXFRUhkCyN0PjLrtw1uSCuy4m=9g=pwNO9tkxckj-koijg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PRM: Clean Up guid type in struct prm_handler_info
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Koba Ko <kobak@nvidia.com>, Len Brown <lenb@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel-janitors@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 10:07, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Clang 19 prints a warning when we pass &th->guid to efi_pa_va_lookup():
>
> drivers/acpi/prmt.c:156:29: error: passing 1-byte aligned argument to
> 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
> unaligned pointer access [-Werror,-Walign-mismatch]
>   156 |                         (void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
>       |                                                  ^
>
> The problem is that efi_pa_va_lookup() takes a efi_guid_t and &th->guid
> is a regular guid_t.  The difference between the two types is the
> alignment.  efi_guid_t is a typedef.
>
>         typedef guid_t efi_guid_t __aligned(__alignof__(u32));
>
> It's possible that this a bug in Clang 19.  Even though the alignment of
> &th->guid is not explicitly specified, it will still end up being aligned
> at 4 or 8 bytes.
>
> Anyway, as Ard points out, it's cleaner to change guid to efi_guid_t type
> and that also makes the warning go away.
>
> Fixes: 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

In case this wasn't implied already,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> Sorry for the unfair Fixes tags since you obviously aren't to blame.  But it's
> more practical if we avoid breaking the build in backports or etc.  Fixes tags
> are quite often unfair in this way...
>
>  drivers/acpi/prmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index d59307a76ca3..747f83f7114d 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -52,7 +52,7 @@ struct prm_context_buffer {
>  static LIST_HEAD(prm_module_list);
>
>  struct prm_handler_info {
> -       guid_t guid;
> +       efi_guid_t guid;
>         efi_status_t (__efiapi *handler_addr)(u64, void *);
>         u64 static_data_buffer_addr;
>         u64 acpi_param_buffer_addr;
> --
> 2.45.2
>

