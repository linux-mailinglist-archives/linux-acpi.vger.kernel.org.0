Return-Path: <linux-acpi+bounces-342-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD4C7B5A0D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 20:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9D4E6281C0C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F381EA90
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 18:31:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CDB199B2;
	Mon,  2 Oct 2023 17:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F76C433CB;
	Mon,  2 Oct 2023 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696268297;
	bh=iWdE3PqQIPm1Gr1G+cGg8YEe3oOezdwkHyl6G540MoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CT+4DRXpnC5j+/uds8hb4RkFktfLHPXRzs7ng/fqmchLUYBjSOfxhkVmkzyYWbDQi
	 V2NKwsjYFiNrwDRX9/hqIbvH9C1g7AC3wq0gH4iH1dx7W5JxhwjMPt9D1V+ZVMGkJH
	 ot8nEr/JrPQAHK3yOq58eYA7GmIKvU3QSm8hT2ZnsnaezArtuBJH9OIXFuGo3RTOdS
	 qMwYuSEoExlbap3JJ56Y8Tl+XjF1UuM5ZKexyPZsJVcZM22kQ/1dUGmLIO41GuhAyW
	 ZKDtjfh876sfAeqwiLXAHl+b26xiUchF6LOtNy8YLubK4RSTIUOd/DAU8R0rppFcEp
	 4GXrTwOX+ZI6g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5043a01ee20so23238653e87.0;
        Mon, 02 Oct 2023 10:38:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLyaoUrxT1gSrb4/c8XUfJpKhxLqhVSQltjsR8bHxwy/hqJ24W
	aMBk/XqwzR42E/MLn+IvU3mh9KyA6BfxcgvM8Q==
X-Google-Smtp-Source: AGHT+IHZCP1YjecGYLwuoNyiko6dwgVXU8NRIFmzW6rhvr0X9Wrzo354jdzX9XwyQDAw5K8Is07bvjVR175Cr9/ex30=
X-Received: by 2002:a05:6512:6c7:b0:504:7e12:4846 with SMTP id
 u7-20020a05651206c700b005047e124846mr11636183lff.30.1696268295338; Mon, 02
 Oct 2023 10:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002132635.2595382-1-andriy.shevchenko@linux.intel.com> <20231002132635.2595382-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231002132635.2595382-2-andriy.shevchenko@linux.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 2 Oct 2023 12:38:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKfg14iW2_DjN5NzbDwapeAwHK_r-XBMMPytrOjQdFY+A@mail.gmail.com>
Message-ID: <CAL_JsqKfg14iW2_DjN5NzbDwapeAwHK_r-XBMMPytrOjQdFY+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] amba: bus: Enable compile testing
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Frank Rowand <frowand.list@gmail.com>, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 2, 2023 at 8:32=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is no architecture specific code in the implementation of
> AMBA bus, let's enable compile testing for it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> v2: new patch to make it easier to compile test on non-ARM
>
>  drivers/amba/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
> index fb6c7e0b4cce..9ff4638550c8 100644
> --- a/drivers/amba/Kconfig
> +++ b/drivers/amba/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config ARM_AMBA
> -       bool
> +       bool "AMBA bus support" || if COMPILE_TEST

Other than not compile testing a compile test enabling patch, it's
really "Arm (AMBA) Primecell Device bus". Despite the naming, AMBA
encompasses lots of Arm defined buses, but what this bus type is is
just peripherals which have the Primecell device ID registers.

Rob

