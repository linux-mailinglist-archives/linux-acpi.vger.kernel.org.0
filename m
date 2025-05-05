Return-Path: <linux-acpi+bounces-13448-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC9EAA9333
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CF31893CF0
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801E250C06;
	Mon,  5 May 2025 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="NZqj8GCx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA21F9F70
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448337; cv=none; b=EY5Ip6sZo3hsaxDcUqqBWle25Rglvjz5icIGXXwiaDLL5weZVM7O0HDzM2AHYlbqTtizEYgxsp0vzP7jCwWn7CfC2l2EOgliuAMaFHT+7H61tiBN+G1ysnPPon0uNbrGIlMlx2Fgy4L2GqghJGgC1/EyBQWKZf8PYBYzq9HKiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448337; c=relaxed/simple;
	bh=z9yc6YZ8/bzyIza72DBETn31TjUPwyUy4wMzJdbZb6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0uXwZQlGSBAA5P/nq03ohDtXKIUUGATnT4oEswqimiFjR/qXRTZT+gYHqhEEHTNAT4bH02nTqkT3/DaCahTAW3XSJzmII3K/mTfcBxAiCtTjrux/w42xae55P9S6MFbMhCAIbyfcNgDgEPfG5QbTw5yznszrYS+4WF85rJomuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=NZqj8GCx; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d589ed2b47so14043275ab.2
        for <linux-acpi@vger.kernel.org>; Mon, 05 May 2025 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1746448333; x=1747053133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ROvQBGSdDBOd+A03xhzhhLZdwd+Yr3g8998GOj2eyg=;
        b=NZqj8GCxTJO8JUfpyTyKZyynZcZ3zqTF6hQ4OfdcjKNX1oqWuZT/e6mmPJwa6R/ta2
         gWzO6TIyMDlHwllSmfYd7eTwPm/0RRECRN3LEx4pCPqShNw0oqBS72RwmBDEy2UtrxNa
         VG+tDvCrlhjKuQwNoA+xRwK7xF6aao+bNqEF6j207i9X24zgYij4O+z4RSiTPITaN3eX
         98E0yO6AS2N5Q+2v43Yz+cHbmeaLp+5sscLdo89ljp5ghOXGhP0nB7FPMkNcLwIObCGx
         i/6gsjEOk/eyHyBgOyBsMX0g3HxbyTBnm08cyRrXhyoKLDyeNmnp1qmtPQOh63yrgm3M
         FUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448333; x=1747053133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ROvQBGSdDBOd+A03xhzhhLZdwd+Yr3g8998GOj2eyg=;
        b=v3H0SBIv3ibX8jkdAstoAIds7U1S4OKmdbHzKpPpfQ2tWTRn94q24K8/nz74Huy8XG
         G8QDBj/NFCWZtU5xP13Q4t4VSqwFN/M8xJNnGxUqttjN0jH5f6oh7g/WI9Hq88f4t8Mu
         lznscaK31lTpwQuX/yJ7TvPsWK4jXoVydkgKpCpoW/GbjfAxz0lnRa1VDvvYVxPTYcuO
         +2fW+eGVZFNV9RdjkHFbjAjUFx8PpYZzbSVb5Yu24QetxCb9/5KLG5C63194ztlUrY8r
         XJP40Lf7LqoV+GVetpOhergiidDzowhg+cha6vrOWLmT5SnEsgOvpdWn/kdOGqQkwO8f
         7h0w==
X-Forwarded-Encrypted: i=1; AJvYcCWQ811G8LaDw1A9kJbDCBylnfMEtkrEtjpPDA3s2kPEncXKEQARwaPQqQS/rVeyHbfLdNPAR0sTpajo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5djbo05vjCGuQRyUtz2DX7NtoDVivZukpuNo0iGrmXP6pMBpj
	JQS6vr0Y1wbBaLKFBwIF3Z52HpJxBL1FkaYmSyZppprxBky6HzhzQl6hkMlByHKfxXVqqC8mR6a
	XjMOnGOA/B/JiAYWShMv4mQbc/+9R1IZf3kj8xA==
X-Gm-Gg: ASbGncvc0Ap2vWOHve1DrH438ZcdXQHMUrD7L0q4g5FA9S6m2U1Tw/f9Jc2tj2IDCbL
	93n0MuwtLX3J+L7GmZ9rGGXz2OTE6EB6eL9UqGtYJdsSO5fpeSxb7zzO/F2Eh0mQu6ASWsKqKyR
	YQUsrOS50GOsDyzCzmD+AMqcc=
X-Google-Smtp-Source: AGHT+IGKfyVuSpXvhyCqr3MzLrMWyvS/DXDaTYYmrBeFPlCthPJdi1/XEIr6vTapFuhwTG/+VDZdp44YaLe79OiDUvE=
X-Received: by 2002:a92:ca4e:0:b0:3d8:2023:d048 with SMTP id
 e9e14a558f8ab-3da569fc0fdmr78214885ab.22.1746448332626; Mon, 05 May 2025
 05:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com> <20250227123628.2931490-2-hchauhan@ventanamicro.com>
In-Reply-To: <20250227123628.2931490-2-hchauhan@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 5 May 2025 18:02:03 +0530
X-Gm-Features: ATxdqUH3w6mQ0qSoQ0tXhdBpHdmtraVQBLRXb-lEZsWxpb787pmCQYQjNjM4yWg
Message-ID: <CAAhSdy1bupf80qpio6-HpwzC53MW3UguKj+zxd3Zmduxay4rpg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/10] riscv: Define ioremap_cache for RISC-V
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, 
	conor@kernel.org, cleger@rivosinc.com, robert.moore@intel.com, 
	sunilvl@ventanamicro.com, apatel@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 6:08=E2=80=AFPM Himanshu Chauhan
<hchauhan@ventanamicro.com> wrote:
>
> bert and einj drivers use ioremap_cache for mapping entries
> but ioremap_cache is not defined for RISC-V.
>
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  arch/riscv/include/asm/io.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 1c5c641075d2..e23a4901e928 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -30,6 +30,9 @@
>  #define PCI_IOBASE             ((void __iomem *)PCI_IO_START)
>  #endif /* CONFIG_MMU */
>
> +#define ioremap_cache(addr, size)                                      \
> +       ((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
> +

There is a compile error observed with this patch applied
on the latest Linux-6.15-rcX kernel.

To fix compile error, we need the following change:
s/_PAGE_KERNEL/PAGE_KERNEL/

Regards,
Anup

