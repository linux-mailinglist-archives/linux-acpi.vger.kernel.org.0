Return-Path: <linux-acpi+bounces-8875-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F8D9A6735
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 13:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E061F211D7
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 11:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C31E8858;
	Mon, 21 Oct 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPtKl6Bg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786FD1E884E;
	Mon, 21 Oct 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511798; cv=none; b=nBVVvYw6Kwc7ec6WjVaXBpvcedKckg3Z3vNcZMAuSItN1CAuBtIseTchs4Q4P5m6GrvdRxJxgnqNEDiWss53v35so07DH3L06qQNt0nPLFF22K3CtJfFpf8nEzNX6EQ2BfFK1KTYKkZqQAIiAPOXpa1Si9/gW5Zypcocdy3lT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511798; c=relaxed/simple;
	bh=iZKzS4vmBiEZsEttEtxZcIb92mfcq/gi05eIuco9YVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUHwda2d8VLiNRTPBIBzdyOgxTtmo1ad7c8L/1h/RT8SSEiGJ/1uhHfsC9rVKnM1IvcwBBhlO7fyg1fYKOxdCLudKOGdryw/MxcovJGN8cCSiqBkghWAp318vOx1fBPPe47lSWNAPK0Qci7qJ6jQSsfTzz3Pwf82kt0Tnp8qwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPtKl6Bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C44EC4CEE8;
	Mon, 21 Oct 2024 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729511798;
	bh=iZKzS4vmBiEZsEttEtxZcIb92mfcq/gi05eIuco9YVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GPtKl6Bggt4/TamihrTZBB77XXeeJpGHQQXXlzjlEZKJsozvj2Agb8oOpdfFEhHP5
	 /zCWStUHugubB24PJxmQXJdvgtMhwxMvXUVKcyfD8ru0bvCBIYUUxJfT+MZfKsmKDc
	 f16aEDpzRJ3CkV+e2dizG+4/aCHSNSJD9GaI0Qxl/QeDdAqxDD3xTFJSfR65jyNGU4
	 HTOD/YuqWJhbOm3uAYUWLqXarDdM6dT/LI+PuVvi72JOwitrLkBqF7guAxaZG0kOYg
	 a2xuMBZ0w6MnBxy+uEc83TPLO9xrdlISEStDlXNMqIOLI3Vhn0YnDR01I3pN5GvYi9
	 HAyvCdcW3W2fg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e5f9712991so2075948b6e.2;
        Mon, 21 Oct 2024 04:56:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU25diKch/9lrvlhuHyH2Wvnn0h661i/OZpfP5hKVTLZrfBGOhHq789yxoqGAXGREZp8S7sU2qlpKks@vger.kernel.org, AJvYcCU3ufUWMwhKo9ZZs6a3jXJS9t/l8qAK+H37FtAl9enmaGsdThmqSYgnm8Z8gei59VnsRHRX7idgyVwL11Dl@vger.kernel.org, AJvYcCWPeqMcbm2JHiUhqicYX+WhsmiO1PYwkUNuU/dT7O5FWiz7G2QG0ekUonOTFWgZpkvxUCZGgCjB@vger.kernel.org
X-Gm-Message-State: AOJu0YwDR36VDb1o/0ZDdg3g/Dy2fD/DL4xTMNufRB2X6vJGMFFTIC4L
	XyKqhGv0MVjujfYje1NY2kQEuISdylgLeBwVoLooLISLqaf2yF9skD8Nr319zyyNha6AJ+98GKr
	oRL5087oa2GtVoNJ2qky+ybIjf5c=
X-Google-Smtp-Source: AGHT+IG5XhnUvagQdAMqem7+z6gKQWhQFAFH3ahh4zbsV1c6ekkCAHEo7YEbfB1J8j3e+1DzqVdfJ0Kk90T2t2VoakA=
X-Received: by 2002:a05:6871:5824:b0:277:c28c:147e with SMTP id
 586e51a60fabf-2892c352bb2mr8523011fac.21.1729511797250; Mon, 21 Oct 2024
 04:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-lg-gram-pro-keyboard-v2-1-7c8fbf6ff718@heusel.eu>
In-Reply-To: <20241017-lg-gram-pro-keyboard-v2-1-7c8fbf6ff718@heusel.eu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:56:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hkNWNb912Ye7cgPVhLyCEHynNFtf0=xWiv0hBbPPwsAw@mail.gmail.com>
Message-ID: <CAJZ5v0hkNWNb912Ye7cgPVhLyCEHynNFtf0=xWiv0hBbPPwsAw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: resource: Add LG 16T90SP to irq1_level_low_skip_override[]
To: Christian Heusel <christian@heusel.eu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dirk Holten <dirk.holten@gmx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:16=E2=80=AFPM Christian Heusel <christian@heusel.=
eu> wrote:
>
> The LG Gram Pro 16 2-in-1 (2024) the 16T90SP has its keybopard IRQ (1)
> described as ActiveLow in the DSDT, which the kernel overrides to EdgeHig=
h
> which breaks the keyboard.
>
> Add the 16T90SP to the irq1_level_low_skip_override[] quirk table to fix
> this.
>
> Reported-by: Dirk Holten <dirk.holten@gmx.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219382
> Cc: stable@vger.kernel.org
> Suggested-by: Dirk Holten <dirk.holten@gmx.de>
> Signed-off-by: Christian Heusel <christian@heusel.eu>
> ---
> Note that I do not have the relevant hardware since I'm sending in this
> quirk at the request of someone else.
> ---
> Changes in v2:
> - fix the double initialization warning reported by the kernel test
>   robot, which accidentially overwrote another quirk

Applied as 6.12-rc material, thanks!

> - Link to v1: https://lore.kernel.org/r/20241016-lg-gram-pro-keyboard-v1-=
1-34306123102f@heusel.eu
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 129bceb1f4a27df93439bcefdb27fd9c91258028..7fe842dae1ec05ce6726af2ae=
4fcc8eff3698dcb 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -503,6 +503,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
>                 },
>         },
> +       {
> +               /* LG Electronics 16T90SP */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "16T90SP"),
> +               },
> +       },
>         { }
>  };
>
>
> ---
> base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
> change-id: 20241016-lg-gram-pro-keyboard-9a9d8b9aa647
>
> Best regards,
> --
> Christian Heusel <christian@heusel.eu>
>

