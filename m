Return-Path: <linux-acpi+bounces-11268-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03FA3A56D
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE7D18882FF
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7463D2356AE;
	Tue, 18 Feb 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8Z+jwDM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3872356A8;
	Tue, 18 Feb 2025 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903193; cv=none; b=MyAE7Bdc0knZSWyzM6TDlmIA13brSKfG6q/O6tTmPX5i/YRMTVSg6rRrOd+UYj1JgEka4MYr0guoMtLl5gqdft4+/3NdEfI+kOc4udB1R5mVTLsyBIj9vhdSEvFd9yPANYl5HIWI9mtEJBwcDcnUr2YbDK8aCED5IgyxWdjEEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903193; c=relaxed/simple;
	bh=gFWPA467fFhdrxcjz8YmJO5wpVcMCxyFzJOhdv74iJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eASAMKNZeTwaipCdZlQ9nGEaIPaSAQ9lOFHvLGkxMi8UGEX5GwQS1gahnI6P/SvXgUH6Ytrps76W9RvP6/xmAH+Vygq4OADxO1OEUBiHJF56gpO6uIS/YMie2Zvw76wJOZBnthdcUXYNDxX4BfNsdM3EksdpkdGi3oRnpDIoPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8Z+jwDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1402C4CEE4;
	Tue, 18 Feb 2025 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903192;
	bh=gFWPA467fFhdrxcjz8YmJO5wpVcMCxyFzJOhdv74iJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q8Z+jwDMftXQ30oDa75WpBjkYwQU/B6hSvtzqeMcJKLr/29D60MM+Gmc75e3dLtII
	 3fu161KB0OKHpCU1I20ytqCYZhgD1CgWv4NjgSuW2Im/Oaq/p4VVqACtPC0LEi6fYL
	 17zPNR+GRLm3vwoSGS2YyRX8qgTRWJMw4ZI+airDPGlkOM5t6e7lB0tTemULKrblTD
	 If0MYpoMD+utUwXLOHqluF0+ClMlu8q6x4d9iL6zCQ5SHVmog0qV6zqvtQMJlfhyBX
	 f1owRj597J6Qr4xQYwMqaNcpjDCKWrOdFQjtzTqOfarZvf1LcCa5xblSX4S8spuw/l
	 7KUot/tWGVYfA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f405e2c761so756912b6e.1;
        Tue, 18 Feb 2025 10:26:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBhTtnXI13Q5pY/09YIh6b58Q39CKwYaTyjLoaAWor9C3VvI5Y+VdPzpYuWJgGaUVLEQe5b4GYzD2I@vger.kernel.org, AJvYcCVWYzz4HHHgd9civBp5rLu76TeYeDt9K3bVhuADS7baVll/7qfuMDn3b+lv9VKCBqgid9VHZDpSAPX5Cl29@vger.kernel.org
X-Gm-Message-State: AOJu0YxuxvPMQSoF6uGXMZpxiZmBPM47qiWI+YmTBrdbXEkRYFwJNJU9
	85CuKFj4zHGODrpS0qVOKMtZgVHJz2BVRxp9m+QcLyLxG8OeZYRrJ1MHGcpuyf5/6hgwWWjE2MF
	gSKz9jckVVLWzOUV40ih9OR7hy0E=
X-Google-Smtp-Source: AGHT+IEtPSsv1kpfazgkvUXQ/rk/DfLvbYdLEOQIpbLBOwhPffIIamBCRZosp2SHVFVXB/b5zgBE+kurnVhlh8adRTc=
X-Received: by 2002:a05:6808:10c5:b0:3f3:be96:5113 with SMTP id
 5614622812f47-3f40f1f8b0amr530337b6e.22.1739903192105; Tue, 18 Feb 2025
 10:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212063408.927666-1-tanxiaofei@huawei.com>
In-Reply-To: <20250212063408.927666-1-tanxiaofei@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 19:26:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hK4fB2oh14L=_qqBAL9vhar-4WuvP1bmnF9XwRrG9+NQ@mail.gmail.com>
X-Gm-Features: AWEUYZkuAJqmehZnM1wNSSYOgZwMIZcVcCTNW6JrX6wMkKScIQmx0gmwSd65mFY
Message-ID: <CAJZ5v0hK4fB2oh14L=_qqBAL9vhar-4WuvP1bmnF9XwRrG9+NQ@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: HED: Always initialize before evged
To: Xiaofei Tan <tanxiaofei@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com, 
	mchehab+huawei@kernel.org, roberto.sassu@huawei.com, shiju.jose@huawei.com, 
	prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:41=E2=80=AFAM Xiaofei Tan <tanxiaofei@huawei.com>=
 wrote:
>
> When the module HED is built-in, the module HED init is behind EVGED
> as the driver are in the same initcall level, then the order is determine=
d
> by Makefile order. That order violates expectations. Because RAS records
> can't be handled in the special time window that EVGED has initialized
> while HED not.
>
> If the number of such RAS records is more than the APEI HEST error source
> number, the HEST resources could be occupied all, and then could affect
> subsequent RAS error reporting.
>
> Change the initcall level of HED to subsys_init to fix the issue. If buil=
d
> HED as a module, the problem remains. To solve this problem completely,
> change the ACPI_HED from tristate to bool.
>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  -v4: Fix register HED device twice issue found by Nathan, and change
> patch name following Rafael's advice.
> ---
>  drivers/acpi/Kconfig | 2 +-
>  drivers/acpi/hed.c   | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index d81b55f5068c..7f10aa38269d 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -452,7 +452,7 @@ config ACPI_SBS
>           the modules will be called sbs and sbshc.
>
>  config ACPI_HED
> -       tristate "Hardware Error Device"
> +       bool "Hardware Error Device"
>         help
>           This driver supports the Hardware Error Device (PNP0C33),
>           which is used to report some hardware errors notified via
> diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
> index 7652515a6be1..3499f86c411e 100644
> --- a/drivers/acpi/hed.c
> +++ b/drivers/acpi/hed.c
> @@ -80,7 +80,12 @@ static struct acpi_driver acpi_hed_driver =3D {
>                 .remove =3D acpi_hed_remove,
>         },
>  };
> -module_acpi_driver(acpi_hed_driver);
> +
> +static int __init acpi_hed_driver_init(void)
> +{
> +       return acpi_bus_register_driver(&acpi_hed_driver);
> +}
> +subsys_initcall(acpi_hed_driver_init);
>
>  MODULE_AUTHOR("Huang Ying");
>  MODULE_DESCRIPTION("ACPI Hardware Error Device Driver");
> --

Applied as 6.15 material with changelog edits, thanks!

