Return-Path: <linux-acpi+bounces-3982-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA36869CD6
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 17:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806D028291F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B2208CE;
	Tue, 27 Feb 2024 16:53:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061EB20B38
	for <linux-acpi@vger.kernel.org>; Tue, 27 Feb 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052803; cv=none; b=CFsFSBhdZKipppUoP7LtM01eJnVUR5uzt6t8U/8+dGTxoWfM2fyE+YxZpuNQR2wxaff1vEgPGfII9JSQw/erqwNeOuJ7kWSdNE6zeBKkd8Wl4mjKV9MdCWzsFCbApgzicnW2UTgKxa1ihEVW/ZJ5BKv17CadEyUdcjnV7BHVYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052803; c=relaxed/simple;
	bh=XO8U3UXJDnqh1S9jpTsd392IIv1O/Bg1kxApTAw5BYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O++ofx0Bocn2oLXoEn9ZkAlK5GsRpSmm8yzGkc16A7lo9GHXpxba9XPxDILH0SQNcH5m2VCiJeNRLIFX9HB40acGjKi9Xo2eTYjamJfWJkQiDG96Oopij63WELsy6OkxeCB12F49LWIWtVsdtmYiOCP5SyiBiuoVrgPDd7UwOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a05210e560so331249eaf.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Feb 2024 08:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052801; x=1709657601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBv/eynRGNumgIDvw5MoNJpuLVnJNY3nVzYp2JVRlIk=;
        b=edAKMuT0y4dGd7BZCd4mM/foSy+1N13vnt7vuK9kyAVY0MgtIK+9eBbCg1HdqP9aqm
         60EQUsVAIYWS+BvlQWFiB2Y85cAgm+l/VhTJROxn/ZkXkslxnpr5dpFozaSZiYV+8gzu
         HKLIgZyGKSDf0r+u++wGLIrdXJVCbQG6eGUFxnEg9I4V5KFwvjkTOOTVm5KXxtlW8vGn
         KDBNtv8O14MXh+fkg7CYoQ7XVT7BVcJSh636d21QtM4edj72P3gVqy8Lsdj71tNqDhJN
         17mcpYq7pO53j7gccwpD470ukboW+Y3KfQ24iORdp/mqLZeF3Js9NcUSWtTR9OA/pTVo
         9Fig==
X-Forwarded-Encrypted: i=1; AJvYcCUCRPU0oaCdLGyk0f9fapMujweAwnnz1ivb63Zv47Hxlli1P35cgakFgCe5upu2sxw6RGIMLDb2xYfFLW0SX8L3JfQzKkSMF21XBQ==
X-Gm-Message-State: AOJu0YzHb+CegDEKvGlPpeILzVUNZYxz1uD2BHzphYA3xeIw0MW6RwiS
	rf9aIin5LPALPev2cX8MaC73danptEfDcILGrX2N4wUHLP+sCWd+G1SylxQjmmZxP4d2EUaZZfy
	mmD7AvdM5rQb4pSTLLxSl/q0WsS6fCG4X
X-Google-Smtp-Source: AGHT+IEtHv2wZtdVLw96M5w8OsEG18faMHhqVnceHb8iz7W4YK3yJZ4ymBHJzzOxus16Ap0fe8MM+mheaaGCwnV5HYE=
X-Received: by 2002:a05:6820:c04:b0:5a0:2cbe:43dd with SMTP id
 eh4-20020a0568200c0400b005a02cbe43ddmr9705695oob.1.1709052801086; Tue, 27 Feb
 2024 08:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAa5hjU-QV8LQtiNW5uuh_z1Gvge_q36LzmLqj7FiK7tT6JsOg@mail.gmail.com>
In-Reply-To: <CAAa5hjU-QV8LQtiNW5uuh_z1Gvge_q36LzmLqj7FiK7tT6JsOg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Feb 2024 17:53:10 +0100
Message-ID: <CAJZ5v0g4PtZCbNmyvn8OPy9K5tCGWqJkRkhbQUjzOz7puzaNwA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override
To: Uldyk <m.kudinovv@gmail.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 5:24=E2=80=AFPM Uldyk <m.kudinovv@gmail.com> wrote:
>
> A known issue on some Zen laptops, keyboard stopped working due to commit
> 9946e39fe8d0 fael@kernel.org("ACPI: resource: skip IRQ override on AMD
> Zen platforms")
> on kernel 5.19.10.
>
> The ACPI IRQ override is required for this board due to buggy DSDT, thus
> adding the board vendor and name to irq1_edge_low_force_override fixes
> the issue.
>
> Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platfo=
rms")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217394
> Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@=
redhat.com/
> Tested-by: Maxim Trofimov <maxvereschagin@gmail.com>
> Signed-off-by: Maxim Kudinov <m.kudinovv@gmail.com>
> ---
> If you need more info (dmesg, dmidecode), then please let me know.
>
> P.S. Sorry Rafael for sending it to you again, my email client was in
> HTML mode, so
> the email was rejected from the mailing list.
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index dacad1d846c0..f681fd66d32b 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -588,6 +588,13 @@ static const struct dmi_system_id
> irq1_edge_low_force_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
>                 },
>         },
> +       {
> +               /* MAIBENBEN X577 */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "MAIBENBEN"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "X577"),
> +               },
> +       },
>         { }
>  };
> --

Applied as 6.9 material, but:
(1) whitespace was all converted to spaces (please fix your email
client or use a different one to send patches),
(2) your S-o-b tag didn't match From:, so I used the name from the
former  for the latter.

Thanks!

