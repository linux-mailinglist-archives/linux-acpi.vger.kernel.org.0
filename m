Return-Path: <linux-acpi+bounces-15106-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5DB021A0
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jul 2025 18:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADAE168207
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jul 2025 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB272EF2B2;
	Fri, 11 Jul 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="mOHIUOTX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217EB2EF28C
	for <linux-acpi@vger.kernel.org>; Fri, 11 Jul 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251061; cv=none; b=RBJSu8jRIPftmJC0AAAwb/zuKQeFcN3yoYwlPA+3tj4dRIL5+lTGipRTpi8p5Ji3A230V0KNl9Nrx6QmlQUBcpXbkdcfunwu1ZAoDxWJn6CtBEi/VglZmyVxIAd8+/OgN2UGSgQQbPjtY/7P3633cTnBNMxsq42xDXXDPaZKkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251061; c=relaxed/simple;
	bh=cMO21aNE8jePVmw//BGrQpUoEr6scyBmxSjxl2zqlxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVrSgpbLLsaQwuUVy5lTOHJi2BLkV0lohyVY+pe++QSbtlfkMNu8DQjcGS7yq28gP3fkkIF0n5Kpz/QpZXJZzgC2wnLA56ktXipNtED/FM0XeuQz5rkFiQEfAbwOBBQQIxZ1WI2JJU73NWs8rTa75zMBGFNPD5kLW5t9GAtofg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=mOHIUOTX; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3df3ce3ec91so8902455ab.2
        for <linux-acpi@vger.kernel.org>; Fri, 11 Jul 2025 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752251059; x=1752855859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrIf+wWA/D3VVdudVKE3VUjB5xcAA2WL2BSQ0S3Af6s=;
        b=mOHIUOTXm+35xXz47LMHxFTrV67n3/YSViVb0TjlVmhMKVSoOg2r2Zs85zcebwTotq
         nkt4cvdjUdImkrW6YPSlLGQ1MMc1EMDw9J96c99xNFNzWz5d19Khzh5Vgi2EAfCiEDdn
         gGU8O1noKHHTMQnVN4Kw4lYZ40avzHsSPnbfd13LWtlmp/JFYlhmA+PhJ+VE3S+lhJt7
         dagriTLodCExpIS/qlEubz5GrDYjr0X1bMdYgWYL7y34kF507S04U5RmzQ4jb9tzg9+k
         NIsi28+Vkk/9276bu7nVYf1yYZvKFyIIF7EgeS5lfCKZQASg3Ouyn3YZeXi5J28wAqGi
         M9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251059; x=1752855859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrIf+wWA/D3VVdudVKE3VUjB5xcAA2WL2BSQ0S3Af6s=;
        b=OmTfMErb1XbtLZGQwWRi9gh268PatYDy5xN6/7vfvzbNErnyLDPiR2lWZ3pybKKTKE
         P0HaA/PQO/2yN39ocS1u91eQJri/xo44wbF6jTpwZSN0QABwzY0fMl2FdrNmRuje6pan
         2GAWhjO/D+9nxFV7IKapl6+6e3OU/P0JAabTpxIySAvVsT2zCVKHUdoc5bH40fvGAH0Q
         CulNWh9SxZaxOZrWl2Ezf5ElbldWUkigLuffuKatD5JtNw9rPRBzH3TCDqGQkv4S0fZu
         ks1itWZ8GHQ5DTbSDpB/9xYzVE+LSviA2TPyTFjbFn9AQ6fYL5RYPXjv1mem0m+rqhuL
         oc0A==
X-Gm-Message-State: AOJu0YyWfAGGJby9ejSfivaJ2yBPMu6DJwaXIKquQAdKXejzA0/4Qbze
	yCD7EdAYCnCt2cjA5t8OS0dvVa6WjMpYdR04o5uy9D1yOAVc20l13XyoNZi/MhPOp+4fPfLJoqD
	22IuMMX+FOjkBH+ulkxCZ7g1iJiWdm9HBTWp9+qxkDQ==
X-Gm-Gg: ASbGncuSZU5y99cQP3PsfnyauIu00NBK/yARdGRqUJiCn8Xi+2PudfJu63q7Bkq5LuP
	lXXDCCKkt+51vsUFaPpwb08Qx/j2SGGnDSmNskwx6SNDhmH+rCH1mcvu8F5mE2v/6nm0ulSA9Sj
	f2X1vV0qFe6xPBM8+L5W4uoin3Yp7WoURwiVSw9j3QEFFGfcY+7y3YvNoqL78wEEDoFzo+L6MHd
	9+n/2Y=
X-Google-Smtp-Source: AGHT+IEgo0yoNtHXaZRHtcGwnexmwO8T42ro0oy6XMW829CWZxM0G/3ulBECSGHLVGNEjLJFmuCzUmfD9G4uz5kdDa4=
X-Received: by 2002:a05:6e02:1fc4:b0:3de:128d:15c4 with SMTP id
 e9e14a558f8ab-3e253fa39a0mr42624545ab.0.1752251058238; Fri, 11 Jul 2025
 09:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711140013.3043463-1-sunilvl@ventanamicro.com>
In-Reply-To: <20250711140013.3043463-1-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 11 Jul 2025 21:54:07 +0530
X-Gm-Features: Ac12FXwUkiRJWGtrJ4BJLcD_qt-SO7VTbgyLm_cGjFvtWTFEfiq5mlAj0Rq7ox0
Message-ID: <CAAhSdy00ztZoX4LF88RTmnyJwKGWseD5qcHkuBW2w_JP5bBL6Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: RISC-V: Remove unnecessary CPPC debug message
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 7:30=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> The presence or absence of the CPPC SBI extension is currently logged
> on every boot. This message is not particularly useful and can clutter
> the boot log. Remove this debug message to reduce noise during boot.
>
> This change has no functional impact.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/acpi/riscv/cppc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 4cdff387deff..440cf9fb91aa 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -37,10 +37,8 @@ static int __init sbi_cppc_init(void)
>  {
>         if (sbi_spec_version >=3D sbi_mk_version(2, 0) &&
>             sbi_probe_extension(SBI_EXT_CPPC) > 0) {
> -               pr_info("SBI CPPC extension detected\n");
>                 cppc_ext_present =3D true;
>         } else {
> -               pr_info("SBI CPPC extension NOT detected!!\n");
>                 cppc_ext_present =3D false;
>         }
>
> --
> 2.43.0
>
>

