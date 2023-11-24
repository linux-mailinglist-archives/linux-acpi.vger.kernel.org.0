Return-Path: <linux-acpi+bounces-1822-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4EB7F7E98
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 19:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7495B213F1
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1142E655
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019251BDA;
	Fri, 24 Nov 2023 10:28:51 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f947682bfdso249027fac.0;
        Fri, 24 Nov 2023 10:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700850530; x=1701455330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLMFfODH5jS5YDFDQszChNMcGREuaPeTgi8qOTAaUV4=;
        b=Dud0luotF7MeDx3pnMruQU57XyPHns2evqyITZ3plpa0J26zuCXq4X1nGCt5wS3ddu
         QDvSl1EeNo1/H/M2g1YwLedzjqQGMzcyi9CfNvz6qW2zrBs3O7nJe4kX1ztEYLWnn5be
         zvCQ9Q2jkUUup3NcYDDwHM0mamgp3B0liKA5sVAHfOrrz8yNA6AB0zcxqeKjuz2rYW1G
         95dxlWAbNrw55lNtVvznaxtQgyOuhs6DxuQcbM5H0EtLOjwKG4GwqJTSdBjAF9TSJCUt
         nlF2cE5XlJwfe5PhRt1nBIiFQ10lZ+XytLtdEh6beu1zJ4cWh4GqrtTDGSZBHNHUzzmp
         eCmQ==
X-Gm-Message-State: AOJu0YwnhntB6fZObdO/xLo3rop38pGun5wKZ/Vvzfk+VRkr6bYuz7Tz
	V+RThvFgFKuEmJIccsAg+hjhRwqtdgzmkqiq0DQ=
X-Google-Smtp-Source: AGHT+IFA23KXKUtBvwZXL0qoxd/H2xL519xL2sSsV0wJ/6Bp+k3CisKabYhut6LpNi87nfOtk/l9p04HId0O/+d5TrU=
X-Received: by 2002:a05:6870:d914:b0:1f9:602e:7b0d with SMTP id
 gq20-20020a056870d91400b001f9602e7b0dmr5597329oab.2.1700850530254; Fri, 24
 Nov 2023 10:28:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123070010.4013969-1-arnd@kernel.org>
In-Reply-To: <20231123070010.4013969-1-arnd@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 24 Nov 2023 19:28:39 +0100
Message-ID: <CAJZ5v0gNE8expsADwoTgDEoTa_5G-R_sBobFEiqLOh0VS5yVug@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal_lib: include "internal.h" for function prototypes
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Zhang Rui <rui.zhang@intel.com>, 
	Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 8:00=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added functions are declared in a header that is not included
> before the definition:
>
> drivers/acpi/thermal_lib.c:46:5: error: no previous prototype for 'acpi_a=
ctive_trip_temp' [-Werror=3Dmissing-prototypes]
>    46 | int acpi_active_trip_temp(struct acpi_device *adev, int id, int *=
ret_temp)
>       |     ^~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/thermal_lib.c:57:5: error: no previous prototype for 'acpi_p=
assive_trip_temp' [-Werror=3Dmissing-prototypes]
>    57 | int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_tem=
p)
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/thermal_lib.c:63:5: error: no previous prototype for 'acpi_h=
ot_trip_temp' [-Werror=3Dmissing-prototypes]
>    63 | int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
>       |     ^~~~~~~~~~~~~~~~~~
> drivers/acpi/thermal_lib.c:69:5: error: no previous prototype for 'acpi_c=
ritical_trip_temp' [-Werror=3Dmissing-prototypes]
>    69 | int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_te=
mp)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 6908097aa5a7 ("ACPI: thermal_lib: Add functions returning temperat=
ure in deci-Kelvin")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/thermal_lib.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/thermal_lib.c b/drivers/acpi/thermal_lib.c
> index 646ff6bda6dd..4e0519ca9739 100644
> --- a/drivers/acpi/thermal_lib.c
> +++ b/drivers/acpi/thermal_lib.c
> @@ -9,6 +9,7 @@
>  #include <linux/acpi.h>
>  #include <linux/units.h>
>  #include <linux/thermal.h>
> +#include "internal.h"
>
>  /*
>   * Minimum temperature for full military grade is 218=C2=B0K (-55=C2=B0C=
) and
> --

Applied, thanks!

