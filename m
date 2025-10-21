Return-Path: <linux-acpi+bounces-18056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 859D5BF8466
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 21:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 742524F2D94
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82126CE22;
	Tue, 21 Oct 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P89UT1ZC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2E225761
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075265; cv=none; b=TIkxhneL7hLHZKwDBAaKUDTY/7EcmEIaxELMcE61/TQPsVl8A9ffEfVYO+gKhBerZ4Ot7CYweUPQhOl+4MxRngb1AdrkwQ//9oYq3+e8sOoY2Q3H+9CzW4F3asAj6fHWsr+95PN0r1He+rGJdy6T96byAo0IVlUothV41PEys+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075265; c=relaxed/simple;
	bh=V5qBLi3zK77pXgOVJaV6ksMZC32XpEnGEdrJWDwYmY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WReQFgeZttWW99dMACmrTfTUJU10XqHqMdw2mMvCtF7GIDf7tTaBx50gApDadZZoP4M7veNNRbE/bCCxHL2dEd/gQWIZCLRgKXJyDgzqk2emfa1Lg1gsmHdRQAzYNkNR6OrPmFniULkHeQCZZsPl8xlukybmLida2QOwPB8+SYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P89UT1ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E34C116C6
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761075265;
	bh=V5qBLi3zK77pXgOVJaV6ksMZC32XpEnGEdrJWDwYmY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P89UT1ZCRzeTW0VeLj7ijZRnK+wnC8EzhHG9fU98VmqZ0bpkzhSCQFB/6IVZd35W/
	 I2jwIz1yZIiKUG8ShKT+gBSH3BaU03mlRuq3NJWt6zLmndNACRKQOqq6WDpxG3wAaV
	 2rM8aqYOO4lz92Oxf0H0eSm56kXFKKkQ2PiWdM7ew+EweOOJc4jrBFeeU0VtP1Pvrx
	 g3UB95Z+XrsIJjmeZLDiApy9BlA8qdUuQHe1M52+V8To+Y6avEaXDgDMZkPdsCJIBX
	 Xp6BDN88SShFtcKqvBc7kDryfs/b77lPaJM15Ty+HMMU6GYXiIrvedcRcd3pD1okL7
	 m0x5uB3RwiHhQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c2730d8fb0so3794956a34.3
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 12:34:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJGoo9AJHEDKxOKFVP7cWfrcnYyQmwrD59oR2pXYfLev0c+T1DqF8UpchZ1OE+eK4cEKD7MmFcv2cI@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAzYE5bN/o85JvtBQFEJphWVjuWWOSRdPZD/A+H8e/kcqbVip
	75hZYK2Y3ytt4Y/uIm9HhzaoDBDcnSvSoBdoS93abY/KbavCChlkEi4HlK22osLln10nuWUZ3HP
	QeI04T7uSAKAFD5Os+8ydxNuBZOFaOFs=
X-Google-Smtp-Source: AGHT+IEjJ240LLD4aWTURSy3Kpfjl2K/yWW+oTYgs4nkYbRCFKp2r4stFggEJLs+i2X79N/a8vB54125GN5q2x352V0=
X-Received: by 2002:a05:6808:2508:b0:441:8f74:fba with SMTP id
 5614622812f47-443a319b0d4mr8130709b6e.55.1761075265025; Tue, 21 Oct 2025
 12:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com> <20250929093754.3998136-3-lihuisong@huawei.com>
In-Reply-To: <20250929093754.3998136-3-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 21:34:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ikPpwKA4WLvwon3p+e8+53fOQuudOioOr-KD-Ee-E0dA@mail.gmail.com>
X-Gm-Features: AS18NWDwIWNmRUJAP79s28jwKq8U8tt1PZxDilox8o7Jt0mZ-BpZaOIJ7hov73E
Message-ID: <CAJZ5v0ikPpwKA4WLvwon3p+e8+53fOQuudOioOr-KD-Ee-E0dA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] ACPI: processor: idle: Return failure if entry
 method is not buffer or integer type
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei.com> =
wrote:
>
> According to ACPI spec, entry method in LPI sub-package must be buffer
> or integer. However, acpi_processor_evaluate_lpi() regeards it as success
> and treat it as an effective LPI state.

Is that the case?  AFAICS, it just gets to the next state in this case
and what's wrong with that?

> This is unreasonable and needs to
> return failure to prevent other problems from occurring.
>
> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Id=
le(LPI) states")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 5acf12a0441f..681587f2614b 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -958,7 +958,9 @@ static int acpi_processor_evaluate_lpi(acpi_handle ha=
ndle,
>                         lpi_state->entry_method =3D ACPI_CSTATE_INTEGER;
>                         lpi_state->address =3D obj->integer.value;
>                 } else {
> -                       continue;
> +                       pr_err("Entry method in LPI sub-package must be b=
uffer or integer.\n");
> +                       ret =3D -EINVAL;
> +                       goto end;
>                 }
>
>                 /* elements[7,8] skipped for now i.e. Residency/Usage cou=
nter*/
> --

