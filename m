Return-Path: <linux-acpi+bounces-13911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC3DAC4F91
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 15:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27003A8A78
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD224271443;
	Tue, 27 May 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvSYCtDq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8036C139E;
	Tue, 27 May 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352079; cv=none; b=uSIGwVjgLhWjmsYhZn0CcvQx3y8lRTLGyMj7GVTEP2LzZ/tlzgnror8KrQT2DOS0T7GSCuKIVdVXKeu4HrX1INwjRc0V9rSSYDRUqP2RI/U5dk/leRt91XZBGrr9a0b2tV+1UFPczOChmnbuIlA6GNzzrLKEJBFWvpbvUooIofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352079; c=relaxed/simple;
	bh=fp9luBBetLAP0B/DgHuAdGyoO1Vry5JUr7H5DC4G4HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iETVDwob/C286q9t3JpbjL7WMUKP/qdzhsUTnMIFwXMmySWJ9dORveMaTkYOkuxsWteh0Bgyp1y1huuJrBddmNsnG58ox1DQ6up+RO5w9LE4uPr9vA28uDwltV0eFgHIY0Snylj44W4k6jEJbubrvT70BwmwkCMVnylj/rSjQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvSYCtDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFCEC4CEEB;
	Tue, 27 May 2025 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748352079;
	bh=fp9luBBetLAP0B/DgHuAdGyoO1Vry5JUr7H5DC4G4HI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SvSYCtDqgahkC+5NUsg3f9lwPIdRRKsBkCr3P1gUQUXmFcwUjDnv5FY6Uvm+RT+U0
	 6eoYz1korr1a+9BwDMEdgCl3M2Du0/gMjzQIb/3NYwDVbsr5sz0OU/Fi5CWuLGwIKn
	 tgtwE/oNTr85+y9RNhZeN6tfHCxGLRmfy1C45rFWj9BZ758wCuUe8u8vNmNLi90a56
	 sBWJN1RuNFN1RoWn6DABasgaMqD092fY7BGgluR4sEGyQXuVG00u11dzRQ7fqF+WPB
	 O70jGDftMLfGXFZ12OrFFEcvcHn0Yv1bBN4D5x41T81f/tYf64rof0/tpoG9xwnmkJ
	 dCr+hSusFc3FQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-401be80368fso398453b6e.1;
        Tue, 27 May 2025 06:21:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5IJjAQ752QasvZw13Su0JfPl4ukOrNohlwYgXmUAIpbyVeZsO6dLm2JE99Hc0JyHQBgRjbOVACEJSWIlt@vger.kernel.org, AJvYcCUB2ipMIIHfctMD3epx4VNAhQ5Izi8vSvPOWSsKJoNCIHfEa6GeSgL3eOv2EA9Z4KeynbN1p7kVMVJXCg==@vger.kernel.org, AJvYcCVKoCkdb0KbYsLLrDkGh5zbFAdOCE/k9NZNQWoe16wjknvdVUFlYgacfRUPYuAig1ukSfF+vO4o8yIyIEsYPpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0SOUrjGU+SYEeZ9LkbxrJZGZAKkR54+HpyfcZXkYcGVrkUG8g
	vOTkp/R2EO0wRSJ/givmwTvou0MCWRdNVg1Q330JQyKXtmMHnYZRZQvKT4NvgWR86ci2RET4jf4
	CDACkTBldoSjkYdsOECFr3IKrcbnPyUQ=
X-Google-Smtp-Source: AGHT+IGh97Bf/315jIDDLCVQau8WC5fWsBAGJ/xi73UpowPj2sPBAO+dga4Q2MnB2Vokwwb9oIyCR4/b7oelhXZX1dI=
X-Received: by 2002:a05:6808:7006:b0:3fa:daa:dd8e with SMTP id
 5614622812f47-4064686c16bmr7438233b6e.35.1748352078738; Tue, 27 May 2025
 06:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aDVRBok33LZhXcId@stanley.mountain>
In-Reply-To: <aDVRBok33LZhXcId@stanley.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 May 2025 15:21:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0im_642kBUqryy=70-+JikM+dhg=w=Shc3Df4HKPhDCsA@mail.gmail.com>
X-Gm-Features: AX0GCFtQtSn0J7mIK2LqJJVYnxD13WNcOWk7YSKyky1S9-K_McoA751MogP26pY
Message-ID: <CAJZ5v0im_642kBUqryy=70-+JikM+dhg=w=Shc3Df4HKPhDCsA@mail.gmail.com>
Subject: Re: [PATCH next] ACPI: APEI: EINJ: Clean up on error in einj_probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Sudeep Holla <sudeep.holla@arm.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jon Hunter <jonathanh@nvidia.com>, Ira Weiny <ira.weiny@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:43=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Call acpi_put_table() before returning the error code.
>
> Fixes: e54b1dc1c4f0 ("ACPI: APEI: EINJ: Remove redundant calls to einj_ge=
t_available_error_type()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/acpi/apei/einj-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index ca3484dac5c4..fea11a35eea3 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -766,7 +766,7 @@ static int __init einj_probe(struct faux_device *fdev=
)
>
>         rc =3D einj_get_available_error_type(&available_error_type);
>         if (rc)
> -               return rc;
> +               goto err_put_table;
>
>         rc =3D -ENOMEM;
>         einj_debug_dir =3D debugfs_create_dir("einj", apei_get_debugfs_di=
r());
> --

Applied, thanks!

