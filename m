Return-Path: <linux-acpi+bounces-7829-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5079C95F738
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 18:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C27A2828FE
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8172D197A72;
	Mon, 26 Aug 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrigSJ+S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D17194AF6;
	Mon, 26 Aug 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691344; cv=none; b=k29KVT74R7TP4kJHuH2yNdUVnKIzbSVgFmSihhs3ytmqiWsZ+NAdkJ0ufKps4CTBw0dlx3qw5o6qCRFSHlYBPR8TB7JUZFDMh827VrQrAUV6VTdwnd00irlj2lm9mhlmfOIDDWnov1zrH+pH/RhBel2No2TukfVmr6NP1THoR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691344; c=relaxed/simple;
	bh=GBAMfUuh5G20pya2ZI/Zh7FGgVvgajbUdQYDU4Z/id4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGwIYLQpDnG98g5+SPeTP0WNdnNaWheJJ7nylL4+HjSz8BI0EImNzdSNS+X6XkC9t1P1k6qMZimwF/XTGraBm2hOXqkPVXAPptpZWIBdEKttKz+MKXK9eNN9jBY24I70H0b3hEiSC+SsX6FvN5hSi13ByKvWV0p7hSiMlhJdXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrigSJ+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5A1C4FE8A;
	Mon, 26 Aug 2024 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724691343;
	bh=GBAMfUuh5G20pya2ZI/Zh7FGgVvgajbUdQYDU4Z/id4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WrigSJ+Sudw0B0qD1HRCvXw152MoCmtLbvWG68aurAKPlaPV34RIGqZbvz/o6o9F7
	 AWOu9NVlNhnygBpnFIXCvBLB4Uc4Nd16v9yoEbKzt+eTgXITVq2LHsZLVSP40JmcML
	 Ms6RKY1AyjAwjU7LFAdja4sdQNw2CGIjg9/7VT4tlL7OOqju3yaLZ9GJQT4HYWpERd
	 sK45IxL+U7yiWwnhmjAJHTByDmZVIQG9nl36RHiMvZxdrSssk7FmrxH/C2gJvNKxtw
	 +dRVRkr61ACvYToNonK9FjNjThBM7M3IZeO3dObZU6Yhv4knRNpwFQxluU52hxqY1m
	 liOoBZAOVNlDA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2701a521f63so3675464fac.0;
        Mon, 26 Aug 2024 09:55:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGqJVpCCjPxdb+v/EPFOMFHyAPyUBRXhWfLNGDYQ4N12+tVULmwnqd+twrE3gSvUkcFv8yAreNa6xH@vger.kernel.org, AJvYcCWTxcdfbF6slBhnhOBiDYOEOwORwPpWDu1ZGMucHBiyGV+izB1I+JkKpfhytCHeTtWpM2BZgR9yWK93cPmR@vger.kernel.org
X-Gm-Message-State: AOJu0YzIh3CP2ommXfZjmgkiEDGf9wTBNW23sYRVvEkkdGap1WwF+gwa
	j9rkvkH7zl8OJL0UD8v2jR+JY+npNXxW/P0lZNpd00z/gXIuvTK1oBT0L65JaZa3iI7rLwI6Ah+
	Ieja1OpJiYO7tcnoKVXcdNZicPMY=
X-Google-Smtp-Source: AGHT+IE+yvdi3mcT7jaBFx1R19262ytVNA2p+Y7ErduADLovJo2GaiKdwy9rr8B42nR2S9dq38X9+Vxy6oX7P/GYlA8=
X-Received: by 2002:a05:6870:b252:b0:261:360:746c with SMTP id
 586e51a60fabf-27759d5012emr273549fac.19.1724691343210; Mon, 26 Aug 2024
 09:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y15e6n35.wl-me@linux.beauty>
In-Reply-To: <87y15e6n35.wl-me@linux.beauty>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 18:55:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jeDFx4q7jDsBQbdDHh_jC3fqytiOyyn1wH0hDjrsqZAw@mail.gmail.com>
Message-ID: <CAJZ5v0jeDFx4q7jDsBQbdDHh_jC3fqytiOyyn1wH0hDjrsqZAw@mail.gmail.com>
Subject: Re: [PATCH V2] ACPI: resource: Do IRQ override on MECHREV GM7XG0M
To: Li Chen <me@linux.beauty>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 10:13=E2=80=AFAM Li Chen <me@linux.beauty> wrote:
>
>
> Listed device need the override for the keyboard to work.
>
> Cc: stable@vger.kernel.org
> Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platfo=
rms")
> Signed-off-by: Li Chen <me@linux.beauty>
> ---
> Changes since V1:
> [1] https://lore.kernel.org/lkml/MN0PR12MB610178FBE11426B042C61A24E22AA@M=
N0PR12MB6101.namprd12.prod.outlook.com/T/
>
> - replace DMI_SYS_VENDOR + DMI_PRODUCT_NAME with DMI_BOARD_NAME
> - rebase on top of next-20240802
>
>  drivers/acpi/resource.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index df5d5a554b388..aa9990507f34c 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -554,6 +554,12 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>   * to have a working keyboard.
>   */
>  static const struct dmi_system_id irq1_edge_low_force_override[] =3D {
> +       {
> +               /* MECHREV Jiaolong17KS Series GM7XG0M */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
> +               },
> +       },
>         {
>                 /* XMG APEX 17 (M23) */
>                 .matches =3D {
> --

Applied as 6.12 material, thanks!

