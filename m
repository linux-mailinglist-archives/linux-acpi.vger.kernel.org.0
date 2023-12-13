Return-Path: <linux-acpi+bounces-2379-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E19811224
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 13:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86441C208ED
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8829D11;
	Wed, 13 Dec 2023 12:54:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF111135;
	Wed, 13 Dec 2023 04:54:20 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d9d6f8485eso881268a34.0;
        Wed, 13 Dec 2023 04:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472060; x=1703076860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crfJNz0NkMSgeWJLA+8VmC2tAn5+LLBTeE17x+YD3zU=;
        b=IBfaxsTw1YAxxZVBiqYcWshZomsbKgyB/093BsgmmFo3aSm3CxLFSqG9oO8qBJ3rkO
         MuKhx0VSrbaYFzpptWInZmJ6pLAsawC/VH3SSaKK8jTCqrL3fqk0eCNzCrZNm5C3Avbz
         rOUkxmZNHTcVUsZ3jdBh293I0NWddVpmsczN5opoCjZ4ySMHiHtE9VkqSLM4qvgc3I2f
         oIXG6dFks8qCYeuni41Yl5pU5Z2k0D8v3GJsHnkJPUjA+yn2oeCgtHcpOeVJp3a8M9YB
         KWOlYs7lANBs2RTzzog/+oyRpiZ1JYfhCrdwup8URtYVSV8MmDrgAPV7/x1ybqRJBZJd
         d5pQ==
X-Gm-Message-State: AOJu0YyFcVLxd84gLOQygcy3aPg6CY1E9UWjHsFdc+wREMSxaPMD1aCk
	vy6eZLw0H70QSwdzpVZpGzi5Z0KGKst7TDVBUWA=
X-Google-Smtp-Source: AGHT+IGTjq/sWv6/5ezFagRPcm/+m5+0/03bDruODCWo4EA6LeQXWlw8BBuzZ1wmN8iH4LPg+xKop62digTZ8Cldh6g=
X-Received: by 2002:a05:6870:1484:b0:1fa:f0ee:ba9c with SMTP id
 k4-20020a056870148400b001faf0eeba9cmr15174841oab.2.1702472059801; Wed, 13 Dec
 2023 04:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212214843.256622-1-arnd@kernel.org>
In-Reply-To: <20231212214843.256622-1-arnd@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 13:54:09 +0100
Message-ID: <CAJZ5v0jMcHCJpDBFO90217Q264JN1LLtc215oP5YQhBk8s1wVA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: arm64: export acpi_arch_thermal_cpufreq_pctg
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sumit Gupta <sumitg@nvidia.com>, Srikar Srimath Tirumala <srikars@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:48=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The cpufreq code can be in a loadable module, so the architecture support
> for it has to be exported:
>
> ERROR: modpost: "acpi_arch_thermal_cpufreq_pctg" [drivers/acpi/processor.=
ko] undefined!
>
> Fixes: 310293a2b941 ("ACPI: processor: reduce CPUFREQ thermal reduction p=
ctg for Tegra241")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/arm64/thermal_cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/th=
ermal_cpufreq.c
> index d524f2cd6044..582854914c5c 100644
> --- a/drivers/acpi/arm64/thermal_cpufreq.c
> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/acpi.h>
> +#include <linux/export.h>
>
>  #include "../internal.h"
>
> @@ -18,3 +19,4 @@ int acpi_arch_thermal_cpufreq_pctg(void)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(acpi_arch_thermal_cpufreq_pctg);
> --

Applied, thanks!

