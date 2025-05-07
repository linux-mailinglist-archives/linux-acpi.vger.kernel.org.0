Return-Path: <linux-acpi+bounces-13558-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D757AADD56
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C38C1BC10D2
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C3221730;
	Wed,  7 May 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7BNsChB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E121ABBF;
	Wed,  7 May 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617342; cv=none; b=JlZ6s5JwsDYtzw+0/IzAAGru4U7wcRRixPDE8NIg1QBhdbdd/0/uU0r/xT7o1sFgfTKjGP/0uLhEPg3T3UBqEfy0hHAjg9ifiLXp9Ck4PYcDvuLZImVc7hgOiF0O1F7kAzgxsLF3jtGPZKvMgxWIRgtW2eOOUtMKbW7rjd0Jr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617342; c=relaxed/simple;
	bh=gL9GrH9LRlGeNWayalBX1+8mY3QexRlc3zwztwPSya8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyunOyJbwi3ov/0Fuj3Mv2emL3vT//L1Br2cSmGEjCrfsAIg/5ZEUrIx07dbaeje/zzQDWDKgGWgiRVVTrHNGF5Cv/SsfX+A4XmHB5e5suFMDuMBNUWdMMeGWI/UheRClcJUIFbDrcE0iJr9dkbKrXyXa5sQ4IXWNWFz/1PgASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7BNsChB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BC3C4CEEB;
	Wed,  7 May 2025 11:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746617342;
	bh=gL9GrH9LRlGeNWayalBX1+8mY3QexRlc3zwztwPSya8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z7BNsChBGJ2mf1DFTbOUtovxHVQz5v6RTOtsZFt0AZ2zTbAlPP/X8MMQxs3XdmG6V
	 3RK/z32IvmQ/5IbDTbWLM+4Wn2GDU9gqzR8NSzrt/cAeKkUryhWF1VOjJh8VUqTjbP
	 6vT9NsJ232QHTZNs47Fx+b2dyYnBMDjTq6TstsnjDg80rF3UmzEQOeLOBM+jCmsuHF
	 /8HYKzeRbOjqfqnQxv5dFDseMFPsGWbbsqkgBC9V1FXGImEdMKWDpsNP9k0dRu5Xa7
	 nyUYFfy+27NT87eZsQXV6tHmzeosQjauc9xiHUrRwlYXLJk1s0aXP7lPH8StX3HHik
	 PMPD2blr5KXHg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c2504fa876so2421410fac.0;
        Wed, 07 May 2025 04:29:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVB0JUaa9cNQ49pibkmukihuJGs0CLV4vbrU6TL89OilB8xhoNP2nmP5uXCkA9YLnM6ZAZNIN2eEQ5Iim7Q@vger.kernel.org, AJvYcCXXCNVvNHDyW88wyVN5Yd41gz7xAHPyTK6XUbYIcU6cuaOLG4SZjxRJYmrSLaAhZEMzmNTU1SAp+x+4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UbG3/hCeL8V0vcWmGFVbym5WwPwqP23vxifY/LjdEUgdX03P
	TBUX/W6q6TwbOeUbj2Cscs5gp2/zBDZx771ufujVxPsl2LvxxmLsVZTOKIGw+XU5Z26QaSrU+Kg
	jhecMRgamcdHy3cuL8+NpeIdEGJU=
X-Google-Smtp-Source: AGHT+IEBYskXLaqTNCLxgDYvi9FRbS28r7jfYrouqU3dDVrpOdtm5fY9sf0Ks9vQv7wzI9vqPitdL815x3YML1A6+Q4=
X-Received: by 2002:a05:6871:4b0a:b0:2d6:6677:f311 with SMTP id
 586e51a60fabf-2db5bd76618mr1712749fac.3.1746617341395; Wed, 07 May 2025
 04:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com> <20250506213814.2365788-3-zaidal@os.amperecomputing.com>
In-Reply-To: <20250506213814.2365788-3-zaidal@os.amperecomputing.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 13:28:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4wTfSgLBx_UmjjQMrJO-+gG=06jVJUpPDc5X0ZyKCcg@mail.gmail.com>
X-Gm-Features: ATxdqUHK13HE6QUDuo8MyNcmoc3-NWwhN3yovKa5mW3cwHSr3r9OKCylSAEJ9uQ
Message-ID: <CAJZ5v0g4wTfSgLBx_UmjjQMrJO-+gG=06jVJUpPDc5X0ZyKCcg@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPICA: Add EINJv2 get error type action
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, 
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com, 
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com, Benjamin.Cheatham@amd.com, 
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com, 
	u.kleine-koenig@pengutronix.de, john.allen@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 11:38=E2=80=AFPM Zaid Alali
<zaidal@os.amperecomputing.com> wrote:
>
> Add EINJV2_GET_ERROR_TYPE as defined in the approved new ACPI
> specs[1][2].
>
> Proposed ACPI spces for EINJv2:
> Link: https://github.com/tianocore/edk2/issues/9449 [1]
> Link: https://github.com/tianocore/edk2/issues/9017 [2]
>
> This commit is not a direct merge, it will come from ACPICA
> project, see pull request[3].
>
> Link: https://github.com/acpica/acpica/pull/977 [3]
>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

An equivalent patch is already there in linux-next:

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/com=
mit/?h=3Dlinux-next&id=3D56b594fdb6dd68d085067a69f5f78171aa6f1657

> ---
>  include/acpi/actbl1.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index c701c434976c..f52d5cafaf76 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1034,7 +1034,8 @@ enum acpi_einj_actions {
>         ACPI_EINJ_GET_COMMAND_STATUS =3D          0x7,
>         ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =3D 0x8,
>         ACPI_EINJ_GET_EXECUTE_TIMINGS =3D         0x9,
> -       ACPI_EINJ_ACTION_RESERVED =3D             0xA,    /* 0xA and grea=
ter are reserved */
> +       ACPI_EINJV2_GET_ERROR_TYPE =3D            0x11,
> +       ACPI_EINJ_ACTION_RESERVED =3D             0x12,   /* 0x12 and gre=
ater are reserved */
>         ACPI_EINJ_TRIGGER_ERROR =3D               0xFF    /* Except for t=
his value */
>  };
>
> --
> 2.43.0
>

