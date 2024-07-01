Return-Path: <linux-acpi+bounces-6719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E8791E749
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 20:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F2E284D2F
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43639155736;
	Mon,  1 Jul 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6vFl5q+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2992BB04
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jul 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857828; cv=none; b=cMIEhxRFmJhIWnva9vfxFxqSn/guFxIedooRWTpgRyvSAhyEkoNMMFu0UHu2EolvusfjtMuTQgwzi5Y96VD72GF6ZsPfH0LAXQS+NZeYtjXC6bb8GFWUE5PWWQMS6l3818xwnMFCjMK+M0QJryVSx6BleV/VCMC2/fAOduvWt8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857828; c=relaxed/simple;
	bh=TILYq2qiGjkBNb+mppshU9VBqnTCQZeeObjxostB9vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXaLvIMKuIbAeTF+C13Xvg/t0vrIdb5r1nZlK7FOlwsPQU/YwsxC5YehyLAT4QeH3vkM+Emdubjb32xLC69k+QQQ2UIfekS/j7QXrSTtTxK1xdYzCjZAXvFjTtlkLhuFK9mDbCoH9bNE8MLnprwXGWj+GWupJkyc+OvZFN7BofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6vFl5q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6ACC32786
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jul 2024 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719857828;
	bh=TILYq2qiGjkBNb+mppshU9VBqnTCQZeeObjxostB9vg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N6vFl5q+OxfvVE3XXu82otoT3JFRGWD68rlByai65uTuONBz46RlwmpUCG2hjUCME
	 fdTEhzI1cYHUgjFrmpLokgcmAxkGIrqaWtxX2mTH9quQs+0iHJOZDSl10khJHNL9rI
	 qc43AsgY5Fgz9wVOgGw9oRvFWuxRYFx1zQRID/jnWWca6tuDGHHUac2InwKIHKVJ9A
	 An79lC7HkRaM86iSWk03LmdYb02G4/hUjk4AQ8FIvT5X5oazjt47ByXa61X8eNNWKM
	 +QZk2vFmnv50vcKAmgNW2AMqt9lUKxjOKIFkZmHkmJNUPYCTmNGPpIePT1e2oKDyZ4
	 1wmw1nt5Mz5bg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25cb5ee9d2dso528690fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jul 2024 11:17:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yze0QyxZ+WW3XJtY61mvy/q9Gs1TDYZSDPT37E9xY6aUYGdkHbm
	T/zAG9NmS0iTiKUPfoAyEtcCOeJm2Z4P1e0IKWXuoktYEu9wlGFMVHLSC6mLEF6kpRlKYF/ztlj
	j7MKSXlUqbOl7k+ngmgtVfGGjGcU=
X-Google-Smtp-Source: AGHT+IEOE/s9vuOClG4AbRfeOe0ZMUEjr/Y8//3p3jzKa1QBWWHqIyMEU2RDBoGDr5LDV5Zp+Eq2oBOO+pxqBLEo7PQ=
X-Received: by 2002:a05:6870:64a5:b0:25d:7935:43b7 with SMTP id
 586e51a60fabf-25db3065aa5mr5999191fac.0.1719857827256; Mon, 01 Jul 2024
 11:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626135113.1527954-1-prabhakar.pujeri@gmail.com>
In-Reply-To: <20240626135113.1527954-1-prabhakar.pujeri@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 20:16:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ik580ADbdaC=rSB1Lpi3xU8XdUAYyFfsb0brBW7iKdvg@mail.gmail.com>
Message-ID: <CAJZ5v0ik580ADbdaC=rSB1Lpi3xU8XdUAYyFfsb0brBW7iKdvg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Use str_plural() Function for Argument List Handling
To: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 3:51=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@gmail.com> wrote:
>
>
> This patch enhances acpi_ut_display_predefined_method by using the str_pl=
ural()
> function to handle argument pluralization. It improves readability and
> maintains consistency in displaying argument counts.
>
> this patch generated using coccinelle.
>
>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
> ---
>  drivers/acpi/acpica/utpredef.c | 2 +-

ACPICA code changes need to be submitted to the upstream ACPICA
project on GitHub.  Once accepted there, a Linux patch can be
submitted with a Link: tag pointing to the corresponding upstream
ACPICA commit.

>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utprede=
f.c
> index 29d2977d0746..5f148715f316 100644
> --- a/drivers/acpi/acpica/utpredef.c
> +++ b/drivers/acpi/acpica/utpredef.c
> @@ -248,7 +248,7 @@ acpi_ut_display_predefined_method(char *buffer,
>         printf("%4.4s    Requires %s%u argument%s",
>                this_name->info.name,
>                (this_name->info.argument_list & ARG_COUNT_IS_MINIMUM) ?
> -              "(at least) " : "", arg_count, arg_count !=3D 1 ? "s" : ""=
);
> +              "(at least) " : "", arg_count, str_plural(arg_count));
>
>         /* Display the types for any arguments */
>
> --
> 2.45.2
>
>

