Return-Path: <linux-acpi+bounces-11260-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E1AA3A489
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 18:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A39188964E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 17:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9100C26F45A;
	Tue, 18 Feb 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxR8QWsi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805A2417DD;
	Tue, 18 Feb 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900778; cv=none; b=nNakr6nhWbNpOnU22MD6MmERpnWH8TEZTYL0AiOJpb/ZIxY2pOxSShXkqC/56J7sy4JK3/gsWHXZAghjFq/eVJpQ1lMadZBs/pZju7xMljJgfnQoJ7uKFeVFANzfPSH5Ai601idlmVTvwkxzEcD4u2xBxaDYwJuIIb39boO7TtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900778; c=relaxed/simple;
	bh=4NmUJ1yyXz/WLu3ith9HJJe7YogoGBBKEAbi3c2j0rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8bqIT3YEa9PBX5GPqX0Q/K7gSnUuL/l0Ieqjj+iOwRhen/cp/hHAMviX4rDzff21OpQ44Mhc7cj7fQWAxqUknalZrQcWlu6X646wmULALj/PKFWgC8Vix2ah2MY95BUjLE60fyf5ZGwn6mPyY8e27vsU59mQXVo02w9qXIPxjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxR8QWsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7102C4CEE2;
	Tue, 18 Feb 2025 17:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739900777;
	bh=4NmUJ1yyXz/WLu3ith9HJJe7YogoGBBKEAbi3c2j0rw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MxR8QWsiboVcwhzg1P6iua3xHZLcIw7TTBnDAhNykZnedtOMERnX02uLRVy/0uCT7
	 H7CjiCEPc181ocba7gkToU6eW8BA8/GDQ/ldWl7coKaG+ST0ERYd8yNIcVaaCqgdH1
	 SYxayxX/NlyMXDa3ieSXU/e4W7W7acFbVy+yvL0lmw+X3NCjE6WZzSyAvJ5SagXYil
	 BOAHV0HXM9AjkxA3HVyjvf5OSaM1hvd6YwAK0TGuMQAadApSQiMX+oPshbP0t3+6lC
	 9admtrnkWzkzkoRa2gbixx70wIBhWjGN6M6PAgW0AyV+PEaHS8Ds18px6UUtLXybi3
	 8L9DZk4Ud+a3Q==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72714016741so1925596a34.3;
        Tue, 18 Feb 2025 09:46:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvWta0m+P8N8LycHEWPQQX8EZDWAW+u/jg3gwaTMAhB4zTiUKRH1OvZ2YoesnQK7D4zzcRrY7+YaCb@vger.kernel.org, AJvYcCW4t9qWKRC/gKJ3C8oIkEbHIrrsSl/J/sXvy0/GymA2/htgV/u2rM7B3aXeHd79ZCYnoea7zUCbkxCIbdnq@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDn8KL9Frmi+nOkHtUnLXFXNqvu72JHyTLzpLV4GiMxHlxIev
	LGCEic6pcAOsRsbHUTP40CWc8rhUJ78LcN55f2G7Ck1XJpHcU1s1p4DL9m5GFO88Hvw+vC7nhcn
	OzZ+t4ZynWpwDIgASnjL7DTvfPmE=
X-Google-Smtp-Source: AGHT+IHRhp8qNHqtYiFvY/4SDElK2SXXOpyeLiZetExIjVE7j7ByBlZIoo68L35D53+QTuO7L1WmRIqJseQIC81mTpo=
X-Received: by 2002:a05:6830:4905:b0:715:4e38:a181 with SMTP id
 46e09a7af769-727120ba0d6mr9901251a34.25.1739900777217; Tue, 18 Feb 2025
 09:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208013335.126343-1-luoxueqin@kylinos.cn>
In-Reply-To: <20250208013335.126343-1-luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 18:46:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iz5wjJHp2o=OGkcuE3PeJ33vqp5p9pKnRG1=14Wx-dVQ@mail.gmail.com>
X-Gm-Features: AWEUYZkdtlpP9v27RlJHBCypT4RXA5mYOIlzYleZJARKzSHTYC_TTeWGYIaYj1o
Message-ID: <CAJZ5v0iz5wjJHp2o=OGkcuE3PeJ33vqp5p9pKnRG1=14Wx-dVQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: Fix incorrect comment about trip points
To: xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 2:33=E2=80=AFAM xueqin Luo <luoxueqin@kylinos.cn> wr=
ote:
>
> The function `acpi_thermal_get_trip_points()` no longer retrieves
> the "_CRT" resource.  Instead, it obtains "_ACi" trip points. Update
> the comment accordingly to reflect the correct behavior.
>
> Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  drivers/acpi/thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 95982c098d5b..0c874186f8ae 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -803,7 +803,7 @@ static int acpi_thermal_add(struct acpi_device *devic=
e)
>
>         acpi_thermal_aml_dependency_fix(tz);
>
> -       /* Get trip points [_CRT, _PSV, etc.] (required). */
> +       /* Get trip points [_ACi, _PSV, etc.] (required). */
>         acpi_thermal_get_trip_points(tz);
>
>         crit_temp =3D acpi_thermal_get_critical_trip(tz);
> --

Applied as 6.15 material with edits in the subject and changelog, thanks!

