Return-Path: <linux-acpi+bounces-16378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB690B4456C
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 20:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BE6A4079E
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39414253B67;
	Thu,  4 Sep 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUp8EIYE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14320251791
	for <linux-acpi@vger.kernel.org>; Thu,  4 Sep 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010653; cv=none; b=c30JCCjpQQ6A9Ab0B0cOjUV8LnX+ox6iJbuTsmupA3AZIojEX6HsET3+sZUJ6V6nZlYym4EI82u+9KYKbCa7EC5Aj5WwAsnCLUUxeuiv6XZUOPSUo1z/L+oq+SCBN+Fj91gytmXfgMPFId9BPQCmKuS++tRf8E4s6BGCSReKq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010653; c=relaxed/simple;
	bh=w9jXHNsJCRm991eNtu7Vt87Z+zkxLPYSK9gsqrrtRPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJNTcsX6V7WQ0Of4KiqdL8H/hi4lmdE3hP/SfOW1g7Xg6eC/NEM5H4qNiL4zomKV88VwqnWRR+E4Z/BomuGNsKi/AE2HXWbwqIXDiHYzaL96LBc5AKPj2EkIaMwgpEGy8LZhfo6rsbBBJjdEUTaVAvrH3kzlT4hnRpW1a/Ql4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUp8EIYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9143AC4CEF0
	for <linux-acpi@vger.kernel.org>; Thu,  4 Sep 2025 18:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757010652;
	bh=w9jXHNsJCRm991eNtu7Vt87Z+zkxLPYSK9gsqrrtRPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XUp8EIYENfbzWoWio2ro4d+m6ZrspnpITC85zCPCJAaUDD29lWJUdjjvTeG8ET5oe
	 cjf5Ev21yccap6ZYnWqqdU7l4U/173Z++zaZCoZVwrVEYsriKBov7up+9F4KM8zcBZ
	 RnyaACVMF1xoqMHBuiTXIzO+e2DkkIZR2miMLyvGF/ft4fXcRkJZy+rgp4odJq40Vt
	 29qdWPZXos24RFy3CdThWhyqwKNLvr+9+iyfFO9HoBvOhpjL3CbcELawIAEMND/4WG
	 OAFCBcrwdwo+bLK4T40UzrN57MwC3a0GYOo/7UCoF70H5ACPygufPpF/S1vx5cpQSA
	 HdzD4GrKrN+8A==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74526ca7a46so566353a34.2
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2025 11:30:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YyGYqXtJdEHJLQXy9X63v+75j1a9JeKDsXz9WSeCiIbNOkxo+PW
	0Ox//nlx/VedLDtC8J24IQo/vwcQ9q/xDruZ8XK5MUDjwcgyF2Kqr0GYdL98SaJOCxdWA20WFuc
	jlD8WG8ckVFg/ECN/OC6l2z0UKZ2HQPY=
X-Google-Smtp-Source: AGHT+IF7IyOretU3C7zkpilB+C/jocUrV5MzKDeF1pccx4yLcMEqkod4dcUfW57sp92zkISYkrsP60VX8YrOavIvSlA=
X-Received: by 2002:a05:6830:2aac:b0:742:f996:ef34 with SMTP id
 46e09a7af769-74569ed6ae0mr11120338a34.27.1757010651866; Thu, 04 Sep 2025
 11:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829145221.2294784-2-sam@tehsvk.net>
In-Reply-To: <20250829145221.2294784-2-sam@tehsvk.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 20:30:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gCPFm7GVyuzNsSSBf_8CLNmu_sn1kE+yG3Tweyrm4pbg@mail.gmail.com>
X-Gm-Features: Ac12FXxOypJ0mDMyznoueZMKIYMe-wY6xMBzSFKpLnidE9PbROmUdrQ4mhKmZgs
Message-ID: <CAJZ5v0gCPFm7GVyuzNsSSBf_8CLNmu_sn1kE+yG3Tweyrm4pbg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS Vivobook Pro N6506CU
To: Sam van Kampen <sam@tehsvk.net>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 4:52=E2=80=AFPM Sam van Kampen <sam@tehsvk.net> wro=
te:
>
> Just like the other Vivobooks here, the N6506CU has its keyboard IRQ
> described as ActiveLow in the DSDT, which the kernel overrides to
> EdgeHigh, causing the internal keyboard not to work.
>
> Add the N6506CU to the irq1_level_low_skip_override[] quirk table to fix
> this.
>
> Signed-off-by: Sam van Kampen <sam@tehsvk.net>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index b1ab192d7a08..ddedb6956a0d 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -510,6 +510,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "N6506M"),
>                 },
>         },
> +       {
> +               /* Asus Vivobook Pro N6506CU* */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "N6506CU"),
> +               },
> +       },
>         {
>                 /* LG Electronics 17U70P */
>                 .matches =3D {
> --

Applied as 6.18 material, thanks!

