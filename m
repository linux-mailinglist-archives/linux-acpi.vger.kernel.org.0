Return-Path: <linux-acpi+bounces-18461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B510C2D1A9
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 17:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3075F4E57E3
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343CA315D5A;
	Mon,  3 Nov 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efrspeYY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7AE315D41
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187101; cv=none; b=eg8SHClUT6xOv5C1aLWjW48C19eiXpVDkWma9mLvLMVB/L/ah37UKBWPV+TNE2vtoUNeWF6Rr80llk+vcdoLCg91CS5Yawao8IBfLlx79rQuYcU/7nJvzswEthnWTVv3j265tJzydpYULhaX/V9aKA5PU4SSfyhACqE9budIarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187101; c=relaxed/simple;
	bh=AHuFY9xO+A63UmFyS210/4TY04941JIQj5CIWs6/YUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Haetf78fF+aS37XNpuKhb9FfXrDQyWoZuvAtOdZxq5IOH2pPX/OLNlqSZlVD2UqNuxogABeL6wfV/3ChURdZkZFF0Qu/3roVtqUcP3vdlzGe0jiwbMmGPsHb6nXduOxKtLyuYvR7xMrN2mu27+cA9DXQpKCSTrmCo/pC81hNf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efrspeYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B14C113D0
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762187100;
	bh=AHuFY9xO+A63UmFyS210/4TY04941JIQj5CIWs6/YUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=efrspeYYlN91uFxlgNfqcsLywdGs0TPacQA/M8791NnWH3fukwY0rBOeT8+eWTVKg
	 vcvVJsnmrAjXgGTOxVZwfD/nPIdReArj5DU54NLpuTOkDph6G8lF5ms7HET/C0ohIg
	 eGkR8LfSGkxlw6nLgqev8jy0hAt1NJqvkcaQ0QOA01Khv4eckUc315q4RjnA3Z3RxK
	 bTWR60pqdYIg/PTuEFAyX8rpNnPFH3KmEDBhEqGDSraoq6lt+kAS5mGUZOcI6nD5S5
	 66+w+01Yg4ulbM92sZf4jGaBPQ+Xl0L2dfPcU7cq2gNzGdp//k7zhkIPJa2ncqs/Cx
	 grr5xmIJN6/uw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3d1cf5c2805so5476079fac.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 08:25:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqQ5V76whOrUDYdw5C1OkSygl5k9nV5G/yI/47lo8DRKaiEyx9chL3s9UY5luBZGN4O5M7Qf7HeK2j@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+Ra8sv0qlbbyYlx+Y/NatJdMIebi6nZJF9Fm6BvfGWvmNcHj
	ftUBLgRrChxtlWrbv1DV+AgmWaGEMMUR9x17RgkS/lxUALW2PnLJXym6iKlImquoBaBrV4NybNB
	pTMeMYXDFn8TcB2APYEiri6M7DlSJ/Mk=
X-Google-Smtp-Source: AGHT+IEf4PcRjvwRSJTmh34zMmlTzmMI8gkWOvhnI9v4RtrHXDFj1hiNW5j3HkHqu2dVd9x9esCxguwYsP5kG9RwS1Y=
X-Received: by 2002:a05:6870:e0d1:b0:3c9:79f5:470e with SMTP id
 586e51a60fabf-3dacdb72630mr6578654fac.34.1762187099896; Mon, 03 Nov 2025
 08:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031055240.2791-1-chuguangqing@inspur.com>
In-Reply-To: <20251031055240.2791-1-chuguangqing@inspur.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 17:24:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jB4Q=1d6dLLmRrUAYjfT7TcprE0946itrT3gimJEfh+A@mail.gmail.com>
X-Gm-Features: AWmQ_bkLSz07d3TndpqT-Zqb4Lv6xZYP5eBY_GUjapgrNNGkY_nqh5rYNLBHMNg
Message-ID: <CAJZ5v0jB4Q=1d6dLLmRrUAYjfT7TcprE0946itrT3gimJEfh+A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Fix a typo error
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 6:53=E2=80=AFAM Chu Guangqing <chuguangqing@inspur.=
com> wrote:
>
> The correct term here should be "package"
>
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index ab4651205e8a..6c684e54fe01 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -750,7 +750,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>         }
>
>         /*
> -        * Disregard _CPC if the number of entries in the return pachage =
is not
> +        * Disregard _CPC if the number of entries in the return package =
is not
>          * as expected, but support future revisions being proper superse=
ts of
>          * the v3 and only causing more entries to be returned by _CPC.
>          */
> --

Applied as 6.18-rc material with modified subject and changelog.

Thanks!

