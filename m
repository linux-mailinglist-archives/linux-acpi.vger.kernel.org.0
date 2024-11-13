Return-Path: <linux-acpi+bounces-9542-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97309C6E9B
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 13:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD8A281842
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C75B200C90;
	Wed, 13 Nov 2024 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCFTfPCt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485320013C;
	Wed, 13 Nov 2024 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499412; cv=none; b=KdUZADaIJasZ6n/AxpEKSigcFZAHXt02zM3Ofl/Vxt7kQKgoCvlZDiG0r24PuJQVk53Mggy9UKahUWn3W79J0cUiUvpWUSJ36w07dBSAzIMYsJL/PExfY21NK3TIRApe2W581/vcL3b9EBdamYiCbw5y3rWLNHWlaP6KCbcOxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499412; c=relaxed/simple;
	bh=rGOfvbNtb4Ia1Lk0a9J2zhWu7ewhCinn8DL8Jrbn8H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eqcsh7PEtJj6Vrg3IDMC6073JTAaTSRtKFQ7nlQaCnnSOIntonih+/256fUbvwjEfcDe8CgzMMeVJrx/JxN7AoecNxS4xPU9C1QLjp4koGMUvNTgyTCP69RazhuaVBu3EcBYvb+ebrmqV5emD6/Yw/fbY58NVUijzTvTEA9/VQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCFTfPCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14010C4CECF;
	Wed, 13 Nov 2024 12:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731499412;
	bh=rGOfvbNtb4Ia1Lk0a9J2zhWu7ewhCinn8DL8Jrbn8H4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KCFTfPCt5zSx+4JcGf4Tol6D5FH8vk23OaHFYQZTkvqnLetofGPiCCid/5S6KTB+n
	 sETcl0d3jM4eNnc6Z0kqX8UBcDmGoTY5spYGpMWpaT6IUX35VMAizUhILRYwI+Wajk
	 DPCJ7JKchqJLzOKMum9I7OOybMKnDr/havBFZzpx1L9Wq5BJPmVS5hjgf0bLVtLCk4
	 nAiQqBPBbwNKxtb/x8FdfhVuLIodPYtOcL+yiNliSaQH8lZYlSMYTaZPXqOjDmx+zD
	 5/fjhGr9SAJaLX30mWwd+9844f2nPv0nbZPPVZrr0i3vVewyW06iq43Ot+6oFXxfXx
	 jtZrmSfVNq35Q==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e60e57a322so4069347b6e.3;
        Wed, 13 Nov 2024 04:03:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsdDlFfIgpsg83zi8SL5Y8Neab9VVTi/6bNOFqN0ZW55ffD/9VMH6pa/qi+1136UYyRbkAl5i0Hhaw@vger.kernel.org, AJvYcCVx0yLfSo/OAO9fmhie8/d2TSepNBmfSImeZQIJygFWM6Aknh8LOs9OCrm050uS6E0KR8bGXqrpwkEmDy7C@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4XU03zSa5+C33letADesy/3ezFcKeVpog0kDbDl6LwXa2rKUv
	FITcpUOiqWa4VoVObML8q9+7NLHnamoWnNGunKDX7WkxpFUCVfMcvN+PxmVUbUty29H+4EMUKG+
	y/aNrCObp9eQGW3zk40QptP3+v8c=
X-Google-Smtp-Source: AGHT+IGtoaPn3VmeKVXHI7wDguqv+ttul1SRDXk5SdmsoXRcQdSIflU9u+JYSpQiqP125d0aSSH1EbWFjR7l5ECOMg4=
X-Received: by 2002:a05:6808:1445:b0:3e2:92ca:92d3 with SMTP id
 5614622812f47-3e79473829emr16958490b6e.34.1731499411383; Wed, 13 Nov 2024
 04:03:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113103309.761031-1-zhenglifeng1@huawei.com>
In-Reply-To: <20241113103309.761031-1-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Nov 2024 13:03:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jW4JKVm==+qnH1QKhvbFm+kjwZX87wyYN-=P3sjs44qQ@mail.gmail.com>
Message-ID: <CAJZ5v0jW4JKVm==+qnH1QKhvbFm+kjwZX87wyYN-=P3sjs44qQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Fix cpc register setting issue.
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	fanghao11@huawei.com, cleger@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:33=E2=80=AFAM Lifeng Zheng <zhenglifeng1@huawei.=
com> wrote:
>
> Since commit 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage"), CPC
> registers cannot be changed from 1 to 0. It turns out that there is an
> extra OR after MASK_VAL_WRITE(), which has already ORed prev_val with the
> register mask. Remove the extra OR to fix the problem.
>
> Fixes: 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1a40f0514eaa..c1f3568d0c50 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1146,7 +1146,6 @@ static int cpc_write(int cpu, struct cpc_register_r=
esource *reg_res, u64 val)
>                         return -EFAULT;
>                 }
>                 val =3D MASK_VAL_WRITE(reg, prev_val, val);
> -               val |=3D prev_val;
>         }
>
>         switch (size) {
> --

Applied as 6.13 material, thanks!

