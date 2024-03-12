Return-Path: <linux-acpi+bounces-4288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E610879CCC
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 21:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29432283070
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 20:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535A1428F9;
	Tue, 12 Mar 2024 20:23:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0751386AA
	for <linux-acpi@vger.kernel.org>; Tue, 12 Mar 2024 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274995; cv=none; b=SLacdpIGzA9JgPwSPUC/kq7koMGsL74MeaNSoJ2Ig683IbPcGVREtW5k6cOS6cr2RaXj6HGj8WPOIer9LRdBRisfIE4Ze2idtjw8WhReohmcUoaJ9wk0UCsiS1yxrZfGsYCsE7nCu3LpwBAOftmDCfRb6LJkQfdTU8wI/vQp1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274995; c=relaxed/simple;
	bh=ak/yQH19P9k0J+RoKLAD9MnUhoKYd6YfaP/CGCW3POM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOLY7VQy6pZO3T6epojEmK6xNLQOBxkwdCN5HCZiU89cp9AjFq5EC9BUxffitgLSI+ntoEwJJQ+xEfr8xbGfo3inFj3OwSGg1A4sDAQfeu6IC+l6Qz2lVu94v944A4KSZXh0BW+5/l2EW/wCSYZAimCMSFgYLOcUnTYiz/CoSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-221d4c52759so702039fac.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Mar 2024 13:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274993; x=1710879793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oNPDiYdQTDD9PCuEzX5Vt0AGhjPLbxJIMwJQa4pJjo=;
        b=qZ+Ni2dxwt6qT4xVPWHITY0oh38ee7c1ziLUX6GTPal7bCMmoFhmQfWxE3QfdHuQv0
         mQRu/vrX2TUm4Hqa4dyMag7cyP7Han8QA7W7e4h9vLSrsrKOGP+rLZsFBeS6vePtCqBO
         JrglG/3X/A5OD+DkBx8YjsggLc+eAbogTi4EDU83x+XCHZsd5mVjteHpmPvgBOuan4bJ
         +9N/w1QoECq0LlrZpjSJWV/7/ao+y0a9teXebumeRWVoCvp1gu9RnT/YNpwvK2VJyLZM
         cw2sBUDerAvsIZ78M5gmQDKvLRom94zBNil3ieS8FLJy1gdef168WzXHNLE+hNo8HClg
         yoog==
X-Forwarded-Encrypted: i=1; AJvYcCVEASjUyylaVEJxzWXJOQIkA8kZpY2WDQwTFarugAjK2D/427aLjIhuXluBaXkdk2WNbTxUwEBWUL3ngnlz2n+1Ky0bJtChnvzWPQ==
X-Gm-Message-State: AOJu0YxuOEjqb/DFvYzGGB9xQFwBgkTjLw/ZSn/pHPBI7z0O4GPki0VY
	AIvwoV/RzPOPJSWm4hGhmZ0CuqLNiucyv5UhurHRjPKL+kVnyD6QkS4+sJV/7++ews6cn414Be4
	VX4IS4UNiyjLoz2ewhVfIjEWJK3Y29FQK
X-Google-Smtp-Source: AGHT+IH2KxK6iU3rTapuxmMcjX8/qlwYugq0mJqSofS8WAZcFMIXGlB+GrcnysVr2mMjNcNS3Yy8QY0aT11K+oRVCJ8=
X-Received: by 2002:a05:6870:6719:b0:221:a151:7f3d with SMTP id
 gb25-20020a056870671900b00221a1517f3dmr3328136oab.2.1710274992995; Tue, 12
 Mar 2024 13:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311101658.2343816-1-cezary.rojewski@intel.com> <20240311101658.2343816-3-cezary.rojewski@intel.com>
In-Reply-To: <20240311101658.2343816-3-cezary.rojewski@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Mar 2024 21:23:01 +0100
Message-ID: <CAJZ5v0iWv37TRPaiCXqQN6ks-ea67rm+KQcrJk7zYZvGQTo8dQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] ACPI: NHLT: Introduce API for the table
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, 
	amadeuszx.slawinski@linux.intel.com, pierre-louis.bossart@linux.intel.com, 
	andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:15=E2=80=AFAM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> The table is composed of a range of endpoints with each describing
> audio formats they support. Most of the operations involve iterating
> over elements of the table and filtering them. Simplify the process by
> implementing range of getters.
>
> While the acpi_nhlt_endpoint_mic_count() stands out a bit, it is a
> critical component for any AudioDSP driver to know how many digital
> microphones it is dealing with.
>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  drivers/acpi/Kconfig  |   3 +
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/nhlt.c   | 289 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/nhlt.h   | 181 ++++++++++++++++++++++++++
>  4 files changed, 474 insertions(+)
>  create mode 100644 drivers/acpi/nhlt.c
>  create mode 100644 include/acpi/nhlt.h
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 3c3f8037ebed..c45a4238c5fd 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -484,6 +484,9 @@ config ACPI_REDUCED_HARDWARE_ONLY
>
>           If you are unsure what to do, do not enable this option.
>
> +config ACPI_NHLT
> +       bool
> +
>  source "drivers/acpi/nfit/Kconfig"
>  source "drivers/acpi/numa/Kconfig"
>  source "drivers/acpi/apei/Kconfig"
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 12ef8180d272..197e1e7154cb 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -93,6 +93,7 @@ obj-$(CONFIG_ACPI_THERMAL_LIB)        +=3D thermal_lib.=
o
>  obj-$(CONFIG_ACPI_THERMAL)     +=3D thermal.o
>  obj-$(CONFIG_ACPI_PLATFORM_PROFILE)    +=3D platform_profile.o
>  obj-$(CONFIG_ACPI_NFIT)                +=3D nfit/
> +obj-$(CONFIG_ACPI_NHLT)                +=3D nhlt.o
>  obj-$(CONFIG_ACPI_NUMA)                +=3D numa/
>  obj-$(CONFIG_ACPI)             +=3D acpi_memhotplug.o
>  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
> diff --git a/drivers/acpi/nhlt.c b/drivers/acpi/nhlt.c
> new file mode 100644
> index 000000000000..599dce778334
> --- /dev/null
> +++ b/drivers/acpi/nhlt.c
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0-only

The part below should be a C-style comment as per the kernel coding style.

> +//
> +// Copyright(c) 2023-2024 Intel Corporation. All rights reserved.

And please drop the "All rights reserved" part.  The license is GPL
(v2), so some rights are in fact not reserved.

> +//
> +// Authors: Cezary Rojewski <cezary.rojewski@intel.com>
> +//          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
> +//
> +

The rest of the patch LGTM.

