Return-Path: <linux-acpi+bounces-1748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE887F4D14
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 17:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2192812C1
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A54C617
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1gSCxG6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A25F1B9
	for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2023 06:56:41 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cc642e4c69so8326777b3.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2023 06:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700665000; x=1701269800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlRpn0YExbwmZYTM470D32GCVHZUUU3U4GDP0MEdp30=;
        b=R1gSCxG635L3tmxoUHRdp5rXmgsQ/CbMt8l9I2pK/qrWMssJ1GqLiByJW4+GmSdPZU
         1xBfEfPr+dOX2dLJyJIh8GaDea7MvKJirgsAyuGPokRgcnEGdqZfr5ngvnCnS2q9qp/R
         XRGsQkehfDjXLEUxaNwmlAbcGfr3WRhMdYDrv4dATMXlwN2P7DRALUtIdCZNgwDEhJkf
         IwkcHxyGyFPV92Jm9MUzt9Wi7HU0AWeg7ZYpQMFYXS5E9ujrXkU7a6twQyAv8ec+aXQs
         RIJ27P1/u+9F1KcWawzX9CpxZbyH91UbsEc96vfrayk4Prdevwl1UHaJCnJ2tF2uUOHZ
         xIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665000; x=1701269800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlRpn0YExbwmZYTM470D32GCVHZUUU3U4GDP0MEdp30=;
        b=ifagm4QyFbqCD68v9NLg8CuMie9zR2UxSoHavsN9HX5PxFVIBOaHDkDekzD8u6uzLP
         /oHDJgWY4awy95xUv6BoxLvd7ih1gzqA6TSsvSL4KjOrRaLbVXCgm0YDYFEbJe+/E0tQ
         mUReYsjj4AEgDqySPj3XvWnUSJQyjlF5tDHVL8jX80BP/6LOfg7COHyx06QXQjsHQQrR
         JmyCzb9ZCasvLF6IzuWR1QeYdVRYMIly4tALVMNFM/mINrLBIjPAOukk33SVQYW6ItpO
         9FabWNzjOqkdyAxbLNXOtZLWNldTTZpK06U3uCmOyF9lT0hAfZjr0NmuhPyTwBEIajlj
         1UvQ==
X-Gm-Message-State: AOJu0YxB6rGGW56rzBSfKgT8wfGU0KW3voGI/UOdGfL1u2XPnESqF8x0
	MDnpK0Q0IisL8b46NEtcfZjtmj1d1KrXedYbUpRHCw==
X-Google-Smtp-Source: AGHT+IETkyDkyc+qmERQdITDeir1SD3U7sHru8ZIboVSSWeeQw5dcf2O6tuEhcqqPh/BIaHsLICfH+aUOCCIoZE93wc=
X-Received: by 2002:a0d:d692:0:b0:5c9:e98c:a6ae with SMTP id
 y140-20020a0dd692000000b005c9e98ca6aemr2364566ywd.4.1700665000626; Wed, 22
 Nov 2023 06:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170060515641.2447486.11798332619205301829.stgit@djiang5-mobl3>
In-Reply-To: <170060515641.2447486.11798332619205301829.stgit@djiang5-mobl3>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Nov 2023 15:56:28 +0100
Message-ID: <CACRpkda-YFDH6JB=V5n4QXMAHyHc22pfhUfW97hj7WaHX7-mpg@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
To: Dave Jiang <dave.jiang@intel.com>
Cc: rafael@kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org, 
	robert.moore@intel.com, Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, 
	guohanjun@huawei.com, arnd@arndb.de, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, cfsworks@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:19=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> =
wrote:

> Linus reported that:
> After commit a103f46633fd the kernel stopped compiling for
> several ARM32 platforms that I am building with a bare metal
> compiler. Bare metal compilers (arm-none-eabi-) don't
> define __linux__.
>
> This is because the header <acpi/platform/acenv.h> is now
> in the include path for <linux/irq.h>:
>
>   CC      arch/arm/kernel/irq.o
>   CC      kernel/sysctl.o
>   CC      crypto/api.o
> In file included from ../include/acpi/acpi.h:22,
>                  from ../include/linux/fw_table.h:29,
>                  from ../include/linux/acpi.h:18,
>                  from ../include/linux/irqchip.h:14,
>                  from ../arch/arm/kernel/irq.c:25:
> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target envi=
ronment
>   218 | #error Unknown target environment
>       |  ^~~~~
>
> The issue is caused by the introducing of splitting out the ACPI code to
> support the new generic fw_table code.
>
> Rafael suggested [1] moving the fw_table.h include in linux/acpi.h to bel=
ow
> the linux/mutex.h. Remove the two includes in fw_table.h. Add include of
> linux/acpi.h in fw_table.c before the fw_table.h include.
>
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0idWdJq3JSqQWLG5q+b+b=3Dzk=
EdWR55rGYEoxh7R6N8kFQ@mail.gmail.com/
> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common=
 lib")
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This works fine on my end.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

