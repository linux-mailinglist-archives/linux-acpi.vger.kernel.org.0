Return-Path: <linux-acpi+bounces-9365-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29879BF688
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FF41C21F5E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7268208234;
	Wed,  6 Nov 2024 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mjNND1x6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272BD17B4FF;
	Wed,  6 Nov 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921524; cv=none; b=C/gbpOwi4NoQScTwXJ+94f5sJ7lqTL6H7j9/JL+pUWJCIayYP88fjrqYhXRfRSqZ/I6K2EN1KWmc77itFal2bHVkUDOub2SPqKdGzK/5pDTbDJ7O3RCViRcJaJg5c9X7MhtL/2fOKhooggwwIVywBDhUQmHfxZc86piI8DWkXXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921524; c=relaxed/simple;
	bh=TYKWR9DYBBL55wxoxPY3TsrD/AdbkcYTUKyQd7y0/AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZyKmXb/tYIAKjQC+QpVsqA+JS/G8SNWPPH92eXOY27WLw8i4f/Stjb/ybd1ytT8Z16oEhc08bWoKU2nwHYaOJx4K0xFouEvh/Zz66rWKcK0YfFqFwk2edsYyWGq9w1TivbZBFQCPvoOJdBjVSfL4PVUzSUqbZ4v4bsxzmyxWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mjNND1x6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730921450; x=1731526250; i=w_armin@gmx.de;
	bh=KIbzjUgUFUY+n6O++/E6r42sDRr1hTbs7/CdD6QYLjU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mjNND1x6jOo42ZfvQhbA0hCH43q0bPV8Nn/LDeZt/HXJp1GWjkF5Bi5vvCEy51lj
	 91joEnueK4zdZ5oic46Yo0LGxdOh7iOH7CCl+lBmuvw4ncsXGdjDT4Q9ElmSBD2Ym
	 y9vz3HBhJHmkuiuYY/8CXShb72Dcn5CGaVwiL30mw/HjHnpiIgciI0CRwiJuESN0I
	 5WM94EYHjOYon0HXolmbwBkSkcy3djTmdcOVXqKtoA4MipwH1YURKDaOTbQfzQjRV
	 kQmvK1xMuyXvakC1b6Wfnst40b0K4pl1zOmGkWnFtjra4DrXhk4tqc6KShhPIGlCq
	 e17cIoKkL5/rbDBTfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1t00IT4252-004nbU; Wed, 06
 Nov 2024 20:30:50 +0100
Message-ID: <bff49c3b-2151-4795-aec4-ae1187765a9d@gmx.de>
Date: Wed, 6 Nov 2024 20:30:43 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/20] platform/x86/amd: pmf: Drop all quirks
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-20-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-20-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rRVCbRzphPVAZ6+vW+/uBuCps+005x+T1afnQ1mJWWq4Pa2O6Qi
 JVqG1g0lbf/DMjA4AxwgT5xomZUT+9Y5yCrGhDRgLJiI/BzyFweS6zqz0w9oDq47YygwdFu
 hs6J32Mtq63TTcIWBBlywQrr+7Vg+rl7dbCPkjg62swSzZDuiqMAa9t2O/Cu/r/KWaGMUX3
 XB+DG6BbHMH5OLGYH1FIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j5qyZvuXwxM=;6zPwP8NCVRsbDkstVL82SxdRUg3
 MTZTaDsI8arljzrqdJyDyBxGfxwcaFlotnRJzn7eWuM5533MOr3b1NmK5PrR3wGXBb+MCuHXd
 SdYC41UihbbtkccYAr2CV081H25mp30oyAYrVBSsWRtghfuC0qKWMVrywtMIlutpr3FhcTLyh
 Fx7DVrYOVhNXtiyfjxGFUq5JA3zll05XSp6N/idLZD+v7dozK5bAjuMUCGQOZlmtzmBzYFZ3N
 /JQZzAQqNXMuGLR2neIqQsFNWmeayaTYdHlG72v9TmpLDJqC71SUoHZsGzMEHKWXeboWQolfr
 14XpldZp1Y2kdovpPE19AJI/+ZCl/WliD6nEbPr68IM7ZKxguZx09dCI6gTqXD02JjyRVkSV5
 eNWPETkVq45gbOhNidpeZFPTUIHO5pAn4nPRCLeSAzB57Z4Ba1JOaQ2ewsPJLVIhDV7yNOgAg
 qHwmoVBrzLz3ik02sYPAiy/w0T2XA1+0uTludxGwUwyN4y6tdMS5FMGbA4ro+RP/3WNBOXj26
 UmT3VPtcq11j9njXjQTdSrjZmW0ngNP8OnUEGZvzGqcYOEnfE0zGWX/1WU0xMcRJT7oQpf7yn
 25x0eNtnh0NQC1MhDucsU32Zy9+1YTr0W+w7uG6WykpF4JR031PFgRqbrRaiJ9l1iSAkX+isl
 4ffDAw6GlpS0JfOIyBc7qXyzXgw41Ve+clR3c4ixl6rfQxpWajg09zMx08d38DGxOAsVsiLYc
 HM46NbleIb8+yJc5c4Pk31QZ4ZlomFU9kpx04Hd6h5+QDuqesspcZiGa9HjG36OLr+48G3bWL
 JZiPRQu+5uboDrvwU3Kn4wtg==

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> As multiple platform profile handlers can now be registered, the quirks
> to avoid registering amd-pmf as a handler are no longer necessary.
> Drop them.

I love it when we can get rid of quirk tables, so:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/amd/pmf/Makefile     |  2 +-
>   drivers/platform/x86/amd/pmf/core.c       |  1 -
>   drivers/platform/x86/amd/pmf/pmf-quirks.c | 66 -----------------------
>   drivers/platform/x86/amd/pmf/pmf.h        |  3 --
>   4 files changed, 1 insertion(+), 71 deletions(-)
>   delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>
> diff --git a/drivers/platform/x86/amd/pmf/Makefile b/drivers/platform/x8=
6/amd/pmf/Makefile
> index 7d6079b02589c..6b26e48ce8ad2 100644
> --- a/drivers/platform/x86/amd/pmf/Makefile
> +++ b/drivers/platform/x86/amd/pmf/Makefile
> @@ -7,4 +7,4 @@
>   obj-$(CONFIG_AMD_PMF) +=3D amd-pmf.o
>   amd-pmf-objs :=3D core.o acpi.o sps.o \
>   		auto-mode.o cnqf.o \
> -		tee-if.o spc.o pmf-quirks.o
> +		tee-if.o spc.o
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/=
amd/pmf/core.c
> index 47126abd13ca0..6ad00b3d472fe 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -455,7 +455,6 @@ static int amd_pmf_probe(struct platform_device *pde=
v)
>   	mutex_init(&dev->lock);
>   	mutex_init(&dev->update_mutex);
>
> -	amd_pmf_quirks_init(dev);
>   	apmf_acpi_init(dev);
>   	platform_set_drvdata(pdev, dev);
>   	amd_pmf_dbgfs_register(dev);
> diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platfor=
m/x86/amd/pmf/pmf-quirks.c
> deleted file mode 100644
> index 7cde5733b9cac..0000000000000
> --- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * AMD Platform Management Framework Driver Quirks
> - *
> - * Copyright (c) 2024, Advanced Micro Devices, Inc.
> - * All Rights Reserved.
> - *
> - * Author: Mario Limonciello <mario.limonciello@amd.com>
> - */
> -
> -#include <linux/dmi.h>
> -
> -#include "pmf.h"
> -
> -struct quirk_entry {
> -	u32 supported_func;
> -};
> -
> -static struct quirk_entry quirk_no_sps_bug =3D {
> -	.supported_func =3D 0x4003,
> -};
> -
> -static const struct dmi_system_id fwbug_list[] =3D {
> -	{
> -		.ident =3D "ROG Zephyrus G14",
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA403U"),
> -		},
> -		.driver_data =3D &quirk_no_sps_bug,
> -	},
> -	{
> -		.ident =3D "ROG Ally X",
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "RC72LA"),
> -		},
> -		.driver_data =3D &quirk_no_sps_bug,
> -	},
> -	{
> -		.ident =3D "ASUS TUF Gaming A14",
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "FA401W"),
> -		},
> -		.driver_data =3D &quirk_no_sps_bug,
> -	},
> -	{}
> -};
> -
> -void amd_pmf_quirks_init(struct amd_pmf_dev *dev)
> -{
> -	const struct dmi_system_id *dmi_id;
> -	struct quirk_entry *quirks;
> -
> -	dmi_id =3D dmi_first_match(fwbug_list);
> -	if (!dmi_id)
> -		return;
> -
> -	quirks =3D dmi_id->driver_data;
> -	if (quirks->supported_func) {
> -		dev->supported_func =3D quirks->supported_func;
> -		pr_info("Using supported funcs quirk to avoid %s platform firmware bu=
g\n",
> -			dmi_id->ident);
> -	}
> -}
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/a=
md/pmf/pmf.h
> index 8ce8816da9c16..b89aa38434faa 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -795,7 +795,4 @@ int amd_pmf_smartpc_apply_bios_output(struct amd_pmf=
_dev *dev, u32 val, u32 preq
>   void amd_pmf_populate_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf=
_enact_table *in);
>   void amd_pmf_dump_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_ena=
ct_table *in);
>
> -/* Quirk infrastructure */
> -void amd_pmf_quirks_init(struct amd_pmf_dev *dev);
> -
>   #endif /* PMF_H */

