Return-Path: <linux-acpi+bounces-16044-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F219B34951
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 19:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C051B2253F
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8A30274D;
	Mon, 25 Aug 2025 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM5rIDWl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4E301028;
	Mon, 25 Aug 2025 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144162; cv=none; b=Y9ISJAs2cPCnUJuvn/P+Ckz6HxkL+VAnqVJQOIK3gq6a9ALUw/Ca01+vnyQf0ycDbvU5Yw78m+ZR/IgETDYs0m2BMx6KpgHWM4/uPQqkEDHTx1h7AlCUppMT5huWskPNgh9qv0dxOWsXnywle4fQCP8Nu88s/ccjvRxrJkUfS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144162; c=relaxed/simple;
	bh=cEUhbMRCFKmm+uFN3EMPbSNsPyu9bPCOJ8ppa/HAe8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9R17gf4ZmmAwDNbdhjTJidUWmpMoG2n3tDK16MVmoogJKJ8yVIvBAXV+LQV2AOIqvIoEnn84jilJlaFFJc+knRrZV4pdJSDzeBfdFuJ1E1sfvAAFBc/nG1Pl3TUbtXYz9MFanGpIs3eQ4VT4ifVgbkZeYK+eu0NQp3jOST04/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM5rIDWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D379BC4CEED;
	Mon, 25 Aug 2025 17:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756144161;
	bh=cEUhbMRCFKmm+uFN3EMPbSNsPyu9bPCOJ8ppa/HAe8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HM5rIDWlZyfQqmKyGBXOUMQQCwl+fhHBcnU6hnjEkRsCfYu+MqouD0G0RV9moGRkW
	 c3XJm3kI3hccXkNUzwWLS8Yk6bWzqyoqhEneCgcxndXcMlYEmcV4dD6roJwt8HbV9x
	 QZv+vqOTomoaeBDV/CBD2eQxLpPYY1LIzMuNX45b+THINiF207f5U1lO1W0YcOhenA
	 8cQqE4CPX4loLL4NzCFBROC/1o1LvGkb7OkXWKpeffDaS1lv7tgGFWv8DXiE8Us6rR
	 cH3K/dhyMVfzQvl8xBtF2XsdvzytY7CdmukdqscWPkL+kg0Z6dR0o188u0AOZXfh4X
	 XJA56DtmfFLYw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce90227aso1556557fac.1;
        Mon, 25 Aug 2025 10:49:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUt6IP4xix/NL/ogwEfx3g+DCWSRXjc4ZZC/4/5yHEfMvjFttnBE9dZBdDRw0mJrMgT5iOHljC25BNk@vger.kernel.org, AJvYcCVPN1tai6DFdZZYNqjh8N3vPYyh0yGielBLUPPVevAVl7aHkE7UUjGx94K3zbzFdUsTfK8nWn8Uc6dtRL/W@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fBkG0D7M2Mh+LP5tL91ppJS+VlaEeKU46gALo6MEBxEQs2KX
	BDc86oSrJFQN0XCd50OV7DPc8unW+WaV+9g6wIJ/6l3tr8Pt7LKwF5qwuRxzqMKGekR9pnII+5R
	S/OVOsfTzSyuL3eFcrhpyJDBogPTz5RI=
X-Google-Smtp-Source: AGHT+IE6mDpyqsUnzu3XQeVctx9ajbuKtjmqSz7jYzI2BuY4v0JQLpEDtCNXYDbNn1WhYg0gg8xnahdKa9SE7C4UOnk=
X-Received: by 2002:a05:6871:e805:b0:314:b6a6:68a0 with SMTP id
 586e51a60fabf-314dcdadd0dmr5498726fac.40.1756144161192; Mon, 25 Aug 2025
 10:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_FEF72BEF631815ED2479A6D1E32C34797B05@qq.com>
In-Reply-To: <tencent_FEF72BEF631815ED2479A6D1E32C34797B05@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 19:49:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gAz5J99ig7eu9AVhEHkusRpW_G=PXRy+E9vGc+MVE6rg@mail.gmail.com>
X-Gm-Features: Ac12FXyBPCJ5ujevKH8qsi1mzK5PBNu_lyz37sIUPVBFyPzPNNwUWZBiumxRqS0
Message-ID: <CAJZ5v0gAz5J99ig7eu9AVhEHkusRpW_G=PXRy+E9vGc+MVE6rg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PRM: Optimize the judgment logic for the PRM handler_address
To: shangsong <shangsong2@foxmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shangsong2@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:28=E2=80=AFAM shangsong <shangsong2@foxmail.com> =
wrote:
>
> From: Shang song (Lenovo) <shangsong2@lenovo.com>
>
> If the handler_address or mapped VA is NULL, the related buffer
> address and VA can be ignored.
>
> Signed-off-by: Shang song <shangsong2@lenovo.com>
> ---
>  drivers/acpi/prmt.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index be033bbb126a..3a501fcd78df 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -150,15 +150,28 @@ acpi_parse_prmt(union acpi_subtable_headers *header=
, const unsigned long end)
>                 th =3D &tm->handlers[cur_handler];
>
>                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid=
);
> +
> +               /*
> +                * Print a error message if handler_address is NULL, the =
parse of VA also
> +                * can be skipped.
> +                */
> +               if (unlikely(!handler_info->handler_address)) {
> +                       pr_err("Skipping handler with NULL address for GU=
ID: %pUL",
> +                                       (guid_t *)handler_info->handler_g=
uid);

pr_info(), please.

> +                       continue;
> +               }
> +
>                 th->handler_addr =3D
>                         (void *)efi_pa_va_lookup(&th->guid, handler_info-=
>handler_address);
>                 /*
> -                * Print a warning message if handler_addr is zero which =
is not expected to
> -                * ever happen.
> +                * Print a warning message and skip the parse of VA if ha=
ndler_addr is zero
> +                * which is not expected to ever happen.
>                  */
> -               if (unlikely(!th->handler_addr))
> +               if (unlikely(!th->handler_addr)) {
>                         pr_warn("Failed to find VA of handler for GUID: %=
pUL, PA: 0x%llx",
>                                 &th->guid, handler_info->handler_address)=
;
> +                       continue;
> +               }
>
>                 th->static_data_buffer_addr =3D
>                         efi_pa_va_lookup(&th->guid, handler_info->static_=
data_buffer_address);
> --

