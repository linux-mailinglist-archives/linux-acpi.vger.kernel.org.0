Return-Path: <linux-acpi+bounces-16650-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79235B5265C
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 04:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2EBA1C248C9
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 02:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F251F63CD;
	Thu, 11 Sep 2025 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6Bjdsbo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004EF9D9
	for <linux-acpi@vger.kernel.org>; Thu, 11 Sep 2025 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557081; cv=none; b=lYvhIa7rkx8hPj2RTLL+TVMkrXho27+EAlvJHxO4TTuAoNt5E3c1UjNFNsC84qLDjzypiKvmV77kH1DLBfXD/Jwlh9arDBoKObC98FqPTnSZtXeVUpo6O35ykRy3BUgHhZZT5pQ0kyuOpNM9o8VGewd77KNh56WAAfK2qKcKgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557081; c=relaxed/simple;
	bh=nYawT0S0r84O3kejVk86qaXhzqw5n4MNW8eUYnka/sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isMd6OveV6ENSBj0o5WW912FR5WAEF4G7HUXaKU8/IaDLmJo6b39pj8h9BHepRsz6RhDwCyIB2Ttedlgu/11Xm41O9XNmrv+G+a32UWwi8hkFYhCC6yMugdp1vHTxIni9dSvfF4xrN4XRzZ+sXwc8+8XKbKgrEYIp/Vp7Xj77T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6Bjdsbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1196AC4CEFA
	for <linux-acpi@vger.kernel.org>; Thu, 11 Sep 2025 02:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757557081;
	bh=nYawT0S0r84O3kejVk86qaXhzqw5n4MNW8eUYnka/sA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M6BjdsboTD+sxprYyXOZNyaUouEl25XIY+XabD9URKz56WOxMux0C9ElwvPo9ARmp
	 /eoNtdPmNXR2fIJkW+U1N7XhAFUHnE++pAeHMd0xtoTbH4zfZyVxXQnfzDZNDA5ufi
	 2L2bR/AvXO2vYt4y92bWfsigFsYcsQ98eiSRuri4QaiT+PCFDHi1ZQScv7DgNxVmvl
	 u2UGkMRd4lg7fVqiTOaMP/NKTOpRWO6oJSJk04l9d9I2JvS45rWPIclBUcBUO51WL/
	 RC+uChitPnL2b2+9wLpIg4j76uPXDU561hlF6JPvbzmr3yaFlxDhcRzaIJqLygOaBq
	 yc+T6DoMaP6sw==
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3dae49b1293so104191f8f.1
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 19:18:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/vX5rbpTwIupcApVcEriHPGYl8rlnRQHMObjLMOJqBEJ6voTUCmq4ZrtbVKhQrxjJdyXcOqnegNUb@vger.kernel.org
X-Gm-Message-State: AOJu0YymQpUMXNRL3Cav2e980XV6aDFqBwAaumUfQKNLcacs4H3lnEAk
	jgFYKO5/uppDcOeeVTo5fDE9KLu2c5/YPA7mxTEIlBQC/3LRj2lZmFqUMBAHXUAsMqg8rZaWKqZ
	3nsF+vHULxj7ZjAKuE4I4XxzBIEkjZrk=
X-Google-Smtp-Source: AGHT+IEl56ERV90rY96BMIiXjgsqHH/v5w5dvDTsjqWW55cq67r2jbS/KGtOaBuH1EZUvuffDCWYdF1rAN1g41WgfDQ=
X-Received: by 2002:a05:6000:40dd:b0:3d4:a64:6725 with SMTP id
 ffacd0b85a97d-3e636d901d5mr9600219f8f.10.1757557079613; Wed, 10 Sep 2025
 19:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910094136.4423-1-cp0613@linux.alibaba.com>
In-Reply-To: <20250910094136.4423-1-cp0613@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 11 Sep 2025 10:17:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTiBkNGAu92OrzoHLUgSrs1E7xPjkA3hmFRvngApn5enw@mail.gmail.com>
X-Gm-Features: AS18NWC5_0Lyszg7t0ofqGlkg96h39BiNBkeJBEHYYd0jSYOeMHx4INUDvLeDYs
Message-ID: <CAJF2gTTiBkNGAu92OrzoHLUgSrs1E7xPjkA3hmFRvngApn5enw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SPCR: Add support for DBG2 RISC-V SBI port subtype
To: cp0613@linux.alibaba.com
Cc: rafael@kernel.org, lenb@kernel.org, jeeheng.sia@starfivetech.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 5:42=E2=80=AFPM <cp0613@linux.alibaba.com> wrote:
>
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> The commit 4aca2bef90bd1296 ("ACPICA: Headers: Add RISC-V SBI Subtype
> to DBG2") has added the definition of ACPI_DBG2_RISCV_SBI_CON.
>
> This patch continues to implement its function so that the parameters
> of uart can be configured correctly. Subsequent calls to setup_earlycon
> to reuse the earlycon based on sbi.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  drivers/acpi/spcr.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index cd36a97b0ea2..208d6bbc65e0 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -141,6 +141,9 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool=
 enable_console)
>         case ACPI_DBG2_16550_NVIDIA:
>                 uart =3D "uart";
>                 break;
> +       case ACPI_DBG2_RISCV_SBI_CON:
> +               uart =3D "sbi";
> +               break;
Yes, SPCR lacks ACPI_DBG2_RISCV_SBI_CON, and ACPICA has adopted it.
So, it's time to add ACPI_DBG2_RISCV_SBI_CON support in spcr.c. It
would solve the UEFI + ACPI early debug problem.

LGTM!

Reviewed-by: Guo Ren (Alibaba Damo Academy) <guoren@kernel.org>

>         default:
>                 err =3D -ENOENT;
>                 goto done;
> --
> 2.49.0
>


--=20
Best Regards
 Guo Ren

