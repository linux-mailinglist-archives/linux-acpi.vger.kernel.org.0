Return-Path: <linux-acpi+bounces-20335-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C49D2033F
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 17:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52219300E461
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492393A35A0;
	Wed, 14 Jan 2026 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFmFlMAi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264482C032C
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408065; cv=none; b=mmpIkk1hixGVrraJtRPU7MPXkj6vcLiZ6hWdA0aol12/UUbqYM4wpJi5bJWmOJ/dAvUT7AjLUeNZ0UQzIrsDXXLr1ehC1vXsUPhOk1bCVP2W2rbhjoHjboeUjVhBlDk/LGM3IBE5pVZN3+SZj7+XSiVGl+3skZXf9QHkmPKGcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408065; c=relaxed/simple;
	bh=CSJWuVycmZlJgJqX+Tqzcfnb9dgZQmRgxUIWTqPck7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBWGbYEPWbAzUXhDY4Pzan6AdiWs/8J2VZ6Q0wc/OlrzKvDNC9ab73hn6LuezMSVZ0X5rJEcwdZJkNBoieiAWtRDzQaUFAk8ZAjoOjSYk4DcU8MGZc9zkCQK1LUG+zBxgXDeTsF0Odcs+TPhhBg/AvWQfywkAV5iaoG8/0yNH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFmFlMAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA585C19424
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768408064;
	bh=CSJWuVycmZlJgJqX+Tqzcfnb9dgZQmRgxUIWTqPck7s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JFmFlMAizxuWHEVaTy9ePwWrepz67n9QB8FXUqb4e1JVZmjSPsOJ9bEZZwJD4MIqP
	 W/JQZ93IZko/9X7Tz1173hH53KBDqtqusvxfHFel/elVuvGxxKd2TdGS+gM1Bil2C3
	 OV+rISAWz242y3vfrMbwCqrg1g/uuot7iIEBs7Mlt1Kr3S51BVVaj663FWm1ke4rZy
	 ZtIeakWUQ8j+kc0a+2uJg7nsL7JwYNYJ6Q08GpiCsNHhIthK2oTQls1I9lG/mRBfYZ
	 hSbDJSSTPvdve0cZyfohlQL5/fQAqYk7Hoc5AqXcRhP3Fooa5/m9vfTBkN+BYfuOC/
	 8PGxthNKF5FHg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cdf7529bb2so6454862a34.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 08:27:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAxuLCKfxwFSdlTgSHOOFR/8oguJju+TYAIaMGLELLPVZfPQxqYQ2Ml2telx6vomGltFBDNlO3CKvU@vger.kernel.org
X-Gm-Message-State: AOJu0YymUJD4PHYWaQltc/8kwTdpkMygScdj3S8sMnzdlyIBaXRIfw0e
	ezeO/wRw0ssYu2g5Wc67WwaHD9hkXEaTr8XPzBBuavTgpq11+Es7d/9AnvT0A0T3PMkaIW7inrn
	kU3Kn1S3RDivExBqgVa5XCkNpC0ekHgg=
X-Received: by 2002:a05:6820:814:b0:65b:26c8:d9e7 with SMTP id
 006d021491bc7-661006a89e9mr2323712eaf.31.1768408063899; Wed, 14 Jan 2026
 08:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113072719.4154485-1-aichao@kylinos.cn>
In-Reply-To: <20260113072719.4154485-1-aichao@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 17:27:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hV+0_U=+DibrzqbRhV2=GRWJ4x18h_W-t8de-5euSuVQ@mail.gmail.com>
X-Gm-Features: AZwV_QgfeJSTTjoY0RtHgb5ywWTKAwiPKKNQEmJHWHl8Ub1P9KmckTkr28wniDo
Message-ID: <CAJZ5v0hV+0_U=+DibrzqbRhV2=GRWJ4x18h_W-t8de-5euSuVQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Add JWIPC JVC9100 to irq1_level_low_skip_override[]
To: Ai Chao <aichao@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 8:27=E2=80=AFAM Ai Chao <aichao@kylinos.cn> wrote:
>
> Like the JWIPC JVC9100 has its serial IRQ (10 and 11) described
> as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh which
> breaks the serial.
>
> irq 10, level, active-low, shared, skip-override
> irq 11, level, active-low, shared, skip-override
>
> Add the JVC9100 to the irq1_level_low_skip_override[] quirk table to fix
> this.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>  drivers/acpi/resource.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index d16906f46484..bc8050d8a6f5 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -532,6 +532,12 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "16T90SP"),
>                 },
>         },
> +       {
> +               /* JWIPC JVC9100 */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "JVC9100"),
> +               },
> +       },
>         { }
>  };
>
> @@ -706,6 +712,8 @@ struct irq_override_cmp {
>
>  static const struct irq_override_cmp override_table[] =3D {
>         { irq1_level_low_skip_override, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACT=
IVE_LOW, 0, false },
> +       { irq1_level_low_skip_override, 10, ACPI_LEVEL_SENSITIVE, ACPI_AC=
TIVE_LOW, 1, false },
> +       { irq1_level_low_skip_override, 11, ACPI_LEVEL_SENSITIVE, ACPI_AC=
TIVE_LOW, 1, false },
>         { irq1_edge_low_force_override, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTI=
VE_LOW, 1, true },
>  };
>
> --

Applied as 6.20 material, thanks!

