Return-Path: <linux-acpi+bounces-6826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E293992BF85
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 18:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1472887F1
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FA119CCE2;
	Tue,  9 Jul 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d96WxjWr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F0158A36
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jul 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541867; cv=none; b=QcePzPN6dGZKTJp2igA06G6QsS6fwiNn/HJ8wCjZKdMSCIcr5ZFq85slsxH1FpuLybQgV3dMJMtPkBHhQiFEZgH/U/4yCN6rwYBkZDHeU9sfgiNiMewzjbJK8/VNeyLEWY+HeltTgMjWdDNN8SSD4CAhnldLcWom2TwAwRUsSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541867; c=relaxed/simple;
	bh=fBoKUbhsv7qlQeNZyBi3+nuc4sYePBUuh4gTmiVhkIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEGYAvrKkurI8/GVWbyxNgvrjEQaGmQoJ/8U0LVfcHEVfQS7g7/b8JEpFMJqgzUDnYvw7ZWGiA57qCDkhpEc0xJsia0su6PJxpsjyK2yJQkxbdDyuzl94Tj7KQTlkOOxHtVgGBJKWsWN1UMhCxM5RrNeqk1xv1tBNhHNj3v9yTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d96WxjWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F86C3277B
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jul 2024 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541866;
	bh=fBoKUbhsv7qlQeNZyBi3+nuc4sYePBUuh4gTmiVhkIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d96WxjWrk1NQKrizQXtbVh+sEuZYCcSF0i89ESHQh+m0hgq49NgN7eGFuUGxlnJ3N
	 PfFYam1FlQid2igdqcghWpNfcrRIKR7WD8uaB+wOUYA4mfMens+HmKoabqgQ2pc3T8
	 Xnrn8BSsshx1fFAfFcuD12YUibUJHluX/rjtqPJVRW8SobDPHmEhYK0rv/w/7L6v92
	 pM9acgaYPzZJNcryuCviC402NUr/gV4VPEKEWlklCv7GzHW7BbxYVx3z7oQZpN4P+j
	 vElz7/Mv8d2PKRDPmfObLhfcFLzyi6fA25kLBu/t/VCd/tUHGHLai9oOIzpk7AoVqs
	 EmLYq3kG+WYIQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70378348d59so33561a34.1
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jul 2024 09:17:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YyycDLuUX7y1G1ROEyL/7Ffh9S/qQnk+D005vlAfPBpZPp5mpGi
	mTiXZCQHgZjzPhIrbn7qrLlf6/W6jJS0g0xgyuKnkaAPV+X6mIicBlWIOc/F6LWG95BNf3WRwOM
	AaGupRRX1EC2f3QMqDaT0ml/yZkA=
X-Google-Smtp-Source: AGHT+IGiaVBnDR833egpbpJ6NmM18xpFMy/jM9BJ6vGVNncJmKRTGjECbKGERj7/7+mjzxA7x865HjbO59SKT1BfSqY=
X-Received: by 2002:a4a:b245:0:b0:5c4:7895:93b8 with SMTP id
 006d021491bc7-5c68e130336mr2987049eaf.1.1720541866102; Tue, 09 Jul 2024
 09:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708000557.83539-1-tamim@fusetak.com>
In-Reply-To: <20240708000557.83539-1-tamim@fusetak.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jul 2024 18:17:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hEjH8Etuzk0X_QRQMW=irfvVVf3XtbRiap_GyFYZyWfw@mail.gmail.com>
Message-ID: <CAJZ5v0hEjH8Etuzk0X_QRQMW=irfvVVf3XtbRiap_GyFYZyWfw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MJ
To: Tamim Khan <tamim@fusetak.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	Amber Connelly <amb3r.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:06=E2=80=AFAM Tamim Khan <tamim@fusetak.com> wrote=
:
>
> Similar to other Asus Vivobooks, the Asus Vivobook Pro N6506MJ has a DSDT=
 table
> that describes IRQ 1 as ActiveLow, whereas the kernel overrides it to Edg=
e_High.
> This discrepancy prevents the internal keyboard from functioning properly=
. This
> patch resolves this issue by adding this laptop to the override table tha=
t prevents
> the kernel from overriding this IRQ.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218929
> Tested-by: Amber Connelly <amb3r.dev@gmail.com>
> Signed-off-by: Tamim Khan <tamim@fusetak.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index b5bf8b81a050..7478805df3a2 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -524,6 +524,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
>                 },
>         },
> +       {
> +               /* Asus Vivobook Pro N6506MJ */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "N6506MJ"),
> +               },
> +       },
>         {
>                 /* LG Electronics 17U70P */
>                 .matches =3D {
> --

Applied as 6.11 material, thanks!

