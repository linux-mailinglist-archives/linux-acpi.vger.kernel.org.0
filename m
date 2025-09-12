Return-Path: <linux-acpi+bounces-16758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FD9B556D1
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 21:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E349A5C3329
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 19:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E22C21E7;
	Fri, 12 Sep 2025 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRzsyF70"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38924287259
	for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704511; cv=none; b=eyQ6so2XMX+wTs0sK+NwCEQZccapl9p2QNXNr9svE40ZCU9h8k/2G8vxY4Ej6ruXLdKu7PoGRoDh3YlxnXL/rbw4vvjjyQ/RXZ4WLE+DnqTNLeJqpHM5lxgweKBq7nwqnUfPFgNfOROEMjF+WNa11S0gAom6EvPdF8rPOnj8sqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704511; c=relaxed/simple;
	bh=TQ9VfjXfclB8dh8foLJE1O+GAfnD6lRseSo061flmAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nikoY5ogj+TrVWMwlRSY/LRq7Uha9JfC+6Rl6KhZSq5R2WIYjiUUbPqIB8KpimeNcEfuOGQdmi4Atr8Lk7BZxA0hqaKRkhv3YD5NNmjezCuoiJVqGhoPdHMS+CFNjE1QZAQWX6rjidxUsJauAC4Wv13gC+6T2eTPkkWFrOapH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRzsyF70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35DBC4CEF1
	for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757704510;
	bh=TQ9VfjXfclB8dh8foLJE1O+GAfnD6lRseSo061flmAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SRzsyF70MStqeKXB4IEk8QBWLL8+T8Fafs3jHgcEs2AElEJeC4rGOEAm0ofpHN4R3
	 pXLhGZgV1mrEvctG28E9c54JvHNOUegvvVIMXtyyF6ZlLqNb1Oq1XU9xRZ4RNeP1c5
	 rRVrCCbaRxGee+DztO37+V6SFWBklMF9RyllfW+fe7mLNeSuPdck35SCZc04LUR0Ix
	 Dz7uU3JVlMH27YCnBj8GKzp0LpG9Te1YVguh4TIQ9DYG3ei5CG8CtT2Ov77BUUX7iv
	 dmFDoMB57eFS7g81kIadtyzI9u0JmFs08kqZshVP3yJKnJDss99aLkvRoFhPVIBivO
	 FFt+QYruatLlA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-621b4d2b2f3so800188eaf.0
        for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 12:15:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUH2GNNWC5vvcK7xaUAhmNLfqhpsVYgPRV6jb8TuwEtO6FeJFE2nPNQ7+mkDQp5Qakffukwy4XR6Bku@vger.kernel.org
X-Gm-Message-State: AOJu0YyyBVCAC2W/i4yMtxnirp+CEDJfhRIAISbExwHM1HrePE3+51K2
	S5XoCT4x6UHn9n8IeB6LR3Umty/IOBZEc5IvVTrrlmQvcihKJP2lCT+hLtdT9UOd/WLEYeTkJ4e
	gY72LCZomgwfnHXwrLx1y4lqr+iRA0fo=
X-Google-Smtp-Source: AGHT+IFSMjCukwpRoJHHdvo7X9kkE10/cajgTTOGsw2M8TC6zIVI2Bpsk3zuGwwVvKA1mrGOEn0n8iWmSkA9BoO27MU=
X-Received: by 2002:a05:6820:6ac4:b0:61b:9bfa:593c with SMTP id
 006d021491bc7-621b2f4a501mr3957536eaf.3.1757704510142; Fri, 12 Sep 2025
 12:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912154735.158537-1-zilin@seu.edu.cn>
In-Reply-To: <20250912154735.158537-1-zilin@seu.edu.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Sep 2025 21:14:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iCQa0jr28YeT3j3OXSVp_sZmjw=617itt1UeGSE3t90A@mail.gmail.com>
X-Gm-Features: Ac12FXwa_QzUe68Np4TmR98_Gmn1m7p6kswAYO952SHTGbx7bnsU3LaTPZiddvU
Message-ID: <CAJZ5v0iCQa0jr28YeT3j3OXSVp_sZmjw=617itt1UeGSE3t90A@mail.gmail.com>
Subject: Re: [PATCH] acpi: replace ACPI_FREE with acpi_ut_delete_object_desc
To: Zilin Guan <zilin@seu.edu.cn>
Cc: rafael@kernel.org, robert.moore@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 5:47=E2=80=AFPM Zilin Guan <zilin@seu.edu.cn> wrote=
:
>
> acpi_ut_create_internal_object may allocate memory from a slab cache
> via kmem_cache_zalloc, but the code currently frees it with ACPI_FREE,
> which calls kfree. This mismatch prevents the object from being
> released properly and may lead to memory leaks or other issues.
>
> Fix this by replacing ACPI_FREE with acpi_ut_delete_object_desc, which
> matches the allocation method used for internal objects.
>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Please submit ACPICA updates as pull requests to the upstream ACPICA
project on GitHub.  Once merged there, corresponding Linux patches can
be submitted with Link: tags pointing to the original upstream ACPICA
commits.

Thanks!

> ---
>  drivers/acpi/acpica/nsxfname.c | 2 +-
>  drivers/acpi/acpica/utobject.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfnam=
e.c
> index 1db831545ec8..b6895a48ae68 100644
> --- a/drivers/acpi/acpica/nsxfname.c
> +++ b/drivers/acpi/acpica/nsxfname.c
> @@ -601,7 +601,7 @@ acpi_status acpi_install_method(u8 *buffer)
>  error_exit:
>
>         ACPI_FREE(aml_buffer);
> -       ACPI_FREE(method_obj);
> +       acpi_ut_delete_object_desc(method_obj);
>         return (status);
>  }
>  ACPI_EXPORT_SYMBOL(acpi_install_method)
> diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobjec=
t.c
> index 272e46208263..8362204b57b5 100644
> --- a/drivers/acpi/acpica/utobject.c
> +++ b/drivers/acpi/acpica/utobject.c
> @@ -148,7 +148,7 @@ union acpi_operand_object *acpi_ut_create_package_obj=
ect(u32 count)
>         package_elements =3D ACPI_ALLOCATE_ZEROED(((acpi_size)count +
>                                                  1) * sizeof(void *));
>         if (!package_elements) {
> -               ACPI_FREE(package_desc);
> +               acpi_ut_delete_object_desc(package_desc);
>                 return_PTR(NULL);
>         }
>
> --
> 2.34.1
>
>

