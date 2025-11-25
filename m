Return-Path: <linux-acpi+bounces-19272-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3062BC8732C
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 22:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA09E3B6C5B
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C578B2F7ADC;
	Tue, 25 Nov 2025 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUpg6aPn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE62DF6E9
	for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105484; cv=none; b=RgAKKSV/Q75fSEo5Q2ChSFkuQUY6BF9v1PCMcmFaTgqxStwtqG+W57KlJC0Ws/YVsiLRGV/pDniDiNkrwOTx8gsb2QKMTe6ILNHf2Neud21XXesAywpySRAmXmu1O/DbevaCd6KVjuYvuW6anDXaTFtzhHfU2+fQwvhOZnK2KVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105484; c=relaxed/simple;
	bh=LiRD5vHxBE38ie6B34CGODf++VHvO0/SOZrGlDjhIFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aR1RuJC5mh9CDIlr6BPGCdPNjjVHeLIVjO5xGR9Zgp2t8oFp58J2N9aY0DMTyNkbaw8UCdzFO0Mf0G5XmWz6wozc2WkwrJEbRXvoXaeRMjgUYGaKSuu24PFngP6LP2TDOVk1fxRDoSfk4Q3/YAUU3Wn6JpH3R6do9TtghWyuA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUpg6aPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8B7C19421
	for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 21:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764105484;
	bh=LiRD5vHxBE38ie6B34CGODf++VHvO0/SOZrGlDjhIFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RUpg6aPnVNV8i0kFIoHNKVCg8aT+8wDSfGO8f1pWXQrHPIjhm8b3eGGzhZHkPyT09
	 SL7g8swpTHliceiFCtgWnrS9KzzpwQwubA4q+8d90inwb5pJUsXA5jolFM3dmYxA5u
	 nGr1MWQwNkaWG5f4oibCuF+6kh93xQU9/bzeC9oYo7iH+Jvob+IzYx7fvp8lgtEcdV
	 VWtuFCnV6r1ASY8fZDxcQDVIgO3yv3GTp8Yeujt22ZFAfObCLvuvu1e6Hi5xxvXTVG
	 FzuADpJae039rJ4rW50xJUWBL9IAMaMJLsjcmvG8UPM9G/TcrLbviOBZT41rrYcjoz
	 +1QOLB6YpTfRA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3d47192e99bso266405fac.0
        for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 13:18:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVX2ePrO1EHq/v+tp23nxfPmq6BDcQ7hCAZ3fM4VigP8ENo2GEyk/uD050WqlgI0pFsMHFf+XxpCebf@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNO3vejbKUFiPVIcLfuxXOLTbsd/qxFvR3A1BDNvxbS1EMvPN
	kaZ+ZUXZiZ6wsRB/wCtjq1Yioku2Nx8bSw1Wukz2i8NxmYmH4MrxUuEbJ+AnWjaUSunXbWnXUxa
	oVDtwvLwvEYH2ixB0lexHc/i61W96tms=
X-Google-Smtp-Source: AGHT+IGl24DqAdtPvfQc1UeKOr4bXETZ2IqJBtSD5gHioi/8CH/XX3Zz+JipVjcQxKCqIi4+u8LxqJlallRyz7yFfns=
X-Received: by 2002:a05:6808:1904:b0:450:c7dc:d7f6 with SMTP id
 5614622812f47-45101e88b0fmr7886822b6e.25.1764105483512; Tue, 25 Nov 2025
 13:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-acpica-v1-1-99e63b1b25f8@linux.dev>
In-Reply-To: <20251125-acpica-v1-1-99e63b1b25f8@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 22:17:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g8hzQWSqPpg4Z4foXCAJUf9iKO9XvY2o-swSLTvGFaxQ@mail.gmail.com>
X-Gm-Features: AWmQ_bm98sFVDep-jGOP3efToVIawBWYCBLpMjadz82v83dpVrWgOiWk3PQ98Lk
Message-ID: <CAJZ5v0g8hzQWSqPpg4Z4foXCAJUf9iKO9XvY2o-swSLTvGFaxQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Avoid walking the Namespace if StartNode is NULL
To: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>, 
	Kexy Biscuit <kexybiscuit@aosc.io>, Wentao Guan <guanwentao@uniontech.com>, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, Cryolitia PukNgae <cryolitia@deepin.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 9:14=E2=80=AFAM Cryolitia PukNgae
<cryolitia.pukngae@linux.dev> wrote:
>
> ACPICA commit 1c1b57b9eba4554cb132ee658dd942c0210ed20d
>
> Since commit 0c9992315e73 ("ACPICA: Avoid walking the ACPI Namespace
> if it is not there") fixed the situation that both StartNode and
> AcpiGbl_RootNode is NULL. The Linux kernel mainline now still crashed
> on Honor Magicbook 14 Pro[1]. Due to the access to the member of
> ParentNode in AcpiNsGetNextNode, the NULL pointer dereference will
> always happen, no matter whether the StartNode equals to the
> ACPI_ROOT_OBJECT or not. So we move the check of StartNode being NULL
> out of the if block.
>
> Unfortunately, all the attempt to contact with Honor has failed, they
> refused to provide any technical support for Linux. The bad DSDT
> table's dump could be found on GitHub[2].
>
> DMI: HONOR FMB-P/FMB-P-PCB, BIOS 1.13 05/08/2025
>
> 1. https://gist.github.com/Cryolitia/a860ffc97437dcd2cd988371d5b73ed7
> 2. https://github.com/denis-bb/honor-fmb-p-dsdt
>
> Signed-off-by: Cryolitia PukNgae <cryolitia@deepin.org>
> Link: https://github.com/acpica/acpica/pull/1061
> Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
> ---
>  drivers/acpi/acpica/nswalk.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
> index a2ac06a26e92..5670ff5a43cd 100644
> --- a/drivers/acpi/acpica/nswalk.c
> +++ b/drivers/acpi/acpica/nswalk.c
> @@ -169,9 +169,12 @@ acpi_ns_walk_namespace(acpi_object_type type,
>
>         if (start_node =3D=3D ACPI_ROOT_OBJECT) {
>                 start_node =3D acpi_gbl_root_node;
> -               if (!start_node) {
> -                       return_ACPI_STATUS(AE_NO_NAMESPACE);
> -               }
> +       }
> +
> +       /* Avoid walking the namespace if the StartNode is NULL */
> +
> +       if (!start_node) {
> +               return_ACPI_STATUS(AE_NO_NAMESPACE);
>         }
>
>         /* Null child means "get first node" */
>
> ---

Applied as 6.19 material with adjusted subject and some edits in the change=
log.

Thanks!

