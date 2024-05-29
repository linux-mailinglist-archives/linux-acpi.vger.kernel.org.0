Return-Path: <linux-acpi+bounces-6073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDB8D324C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2024 10:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E209928801A
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2024 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B4917F389;
	Wed, 29 May 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ3vFxff"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB117F376;
	Wed, 29 May 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972583; cv=none; b=gMfLGGtBC/1MOsIjbivoTPUUWOUFY9BUIqLw5QIEBqKu+j+3SFnrws8WhZlMwAf5z1vakWj2sXwK6UzekedPsyBW0ZAsVL8xbXtH2whUf9MCsAX5Rlf1yCCioR3RlsvvmWL0AxZ0jt6JbfBGpp6IhUm/tpbGAp2W7w5sogzeUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972583; c=relaxed/simple;
	bh=oXs1Lc37Mxk8x9catadbvHDsc/E6WhT/Inpb76eDDHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWpj71PNnYZZkNeNdbi/KIwYrzIum0C1TkWZ0PDXNeHHJEvFq/x7c6j/gDnUHJN7ni7H5PBXKJ4R+quUOL7sPMOenkn/2rrr/NLr6ElVJs8cim7AKFCmT9qRxyJXEGGn8H6oJtBdvU2nvkI9syid40YcwcNp4rTTETHEzf9FiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ3vFxff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01170C2BD10;
	Wed, 29 May 2024 08:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716972583;
	bh=oXs1Lc37Mxk8x9catadbvHDsc/E6WhT/Inpb76eDDHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XZ3vFxffA1yGqcEdQk4ksMu6nQIFKdwGwVfeExHsTs8FTcbMKZs7uCiJt9RQMQu7v
	 B/GYua/Y/vlLCX78hxvhSEti9MJyqwp/A0Ak0GyXUEIzwm30+kuK/lsZ4MADJo5Npf
	 Nk85BaDFgBE85jKDLH98D7BFzp9C+4z9AFH3vUh9PO6GasRUwZ8XlL9xYnU8DJQJ7v
	 qJsFUtoZNSWfG9BtJBn2T1jj+urRSfgpfPrVPDYjDRy0TASqJ4+ShlEEbhO1cZnbn/
	 XuEKEUcYNez7FCte/zlXg9W91w2G8Qlvy+eIB4q2vMGCci54KsMYeNHWThEjeAorOw
	 hI7ya43NzEa0g==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a034697fbso677338a12.0;
        Wed, 29 May 2024 01:49:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3zY5RbY0y6wzjGbM8QbG31BdgI3X79sOW7zl7dCVorWnPr6Lmq2K9Z8/pFVS7j+ZyERuDF1ucIaBM/ETy5dBwJULSGi2ltDciJuttaMGJsfzB76hgbXCRZ/iyvCZ7E5Oax0lBUagZmg==
X-Gm-Message-State: AOJu0YxohrdnYhowB5s7Gi9vAINSJvMkKDeOtSPildpCAwKEl0aK6BhV
	42m60Q/fCKPkEoRU4LTv5QpIkIYCp/NAPUVO/uGuklgB2+15UgGmbb/UNEhp3JEaDLb3W1WVX0G
	k2nvaXH+8JLOED8MaXYsMAYK60kM=
X-Google-Smtp-Source: AGHT+IEa9zFQw77QTbSE85f4ZyWRnsf3NbfS/MlK2CGqwVDmeIh8FNXu0ZQntETEW1GOD+3THytyK/iwTIaOVlCe30Y=
X-Received: by 2002:a17:906:55ce:b0:a59:c3dd:db2a with SMTP id
 a640c23a62f3a-a62641aaf08mr896630366b.11.1716972581608; Wed, 29 May 2024
 01:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529063206.30421-1-yangtiezhu@loongson.cn>
In-Reply-To: <20240529063206.30421-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 29 May 2024 16:49:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4db5C4vw9XT+kB3baMXbGNJC86Aq81p5Wic90LD3QSgQ@mail.gmail.com>
Message-ID: <CAAhV-H4db5C4vw9XT+kB3baMXbGNJC86Aq81p5Wic90LD3QSgQ@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch: Remove CONFIG_ACPI_TABLE_UPGRADE in platform_init()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: rafael@kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thank you.

Huacai

On Wed, May 29, 2024 at 2:32=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> acpi_table_upgrade() and acpi_boot_table_init() are defined as
> empty function under !CONFIG_ACPI_TABLE_UPGRADE and !CONFIG_ACPI
> in include/linux/acpi.h, there are no implicit declaration errors
> with various configs.
>
> As Huacai suggested, CONFIG_ACPI_TABLE_UPGRADE is ugly and not
> necessary here, just remove it. At the same time, just keep
> CONFIG_ACPI to prevent build error and give a signal to tell
> us the code is ACPI-specific, and also put acpi_table_upgrade()
> under CONFIG_ACPI.
>
>   #ifdef CONFIG_ACPI_TABLE_UPGRADE
>   void acpi_table_upgrade(void);
>   #else
>   static inline void acpi_table_upgrade(void) { }
>   #endif
>
>   #ifdef        CONFIG_ACPI
>   ...
>   void acpi_boot_table_init (void);
>   ...
>   #else /* !CONFIG_ACPI */
>   ...
>   static inline void acpi_boot_table_init(void)
>   {
>   }
>   ...
>   #endif        /* !CONFIG_ACPI */
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/kernel/setup.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index ea6d5db6c878..08a077e4efd7 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -353,10 +353,8 @@ void __init platform_init(void)
>         arch_reserve_vmcore();
>         arch_reserve_crashkernel();
>
> -#ifdef CONFIG_ACPI_TABLE_UPGRADE
> -       acpi_table_upgrade();
> -#endif
>  #ifdef CONFIG_ACPI
> +       acpi_table_upgrade();
>         acpi_gbl_use_default_register_widths =3D false;
>         acpi_boot_table_init();
>  #endif
> --
> 2.42.0
>

