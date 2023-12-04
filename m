Return-Path: <linux-acpi+bounces-2122-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10456803A66
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 17:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF43C28071F
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855172583
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 16:35:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A2B198;
	Mon,  4 Dec 2023 07:26:19 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1fb1620a00eso552542fac.1;
        Mon, 04 Dec 2023 07:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701703579; x=1702308379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIUtVPpyS8fYPGpGVIiSGAPMUKiBnO1J7wrsfSDkQ8w=;
        b=uoAskszJc7PrAdQub6c2RdQFtDovUjznT6B4V9tFf3a6fwC4QaQ18EI/ABNAje/y5N
         yK+GBorjK/w675u7m7ZcgpqPNJs+CLqdFoey6XuVEU/zV+JRbVnYdZVyLEVOecGGefjG
         fO2DYvAfm3rp0x7u3VHhy1upqzU4iNYcinexfBgAHEperZKYRertgzdTmSB83mA9Cy1c
         YJhpK4GYHDDBpAgQFeeMXlPzDWl21Qz5nCx3A4ODTqOlbetliTZ5SaH6QShGk6auZjhI
         qZM43+0V2NHg0FkpUans5zJvpxCSR0HFpZMmx1s7UwNhomqqAwulvv+2+WrCMaFBTiJU
         YfMg==
X-Gm-Message-State: AOJu0YxW9pX+8dlDoXIaGiPLfzw9PeMe+ap4coigtO8Hh6pXHgToiW8K
	dwHEW8eL7unFZhQNYlSYDL7Hj8iyL4kRwsUWt5E=
X-Google-Smtp-Source: AGHT+IFwRKdE6quLrQ8usAvmvfukiG7/emkxnLDLXtzCuNE4oiv6TjvNZ1qHrFHd/ntBRYj5JCmvp3F/FTWIrUaO9oM=
X-Received: by 2002:a05:6870:e38a:b0:1fb:25fb:fabc with SMTP id
 x10-20020a056870e38a00b001fb25fbfabcmr5889457oad.5.1701703578877; Mon, 04 Dec
 2023 07:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3281896.aeNJFYEL58@kreacher> <3552364.iIbC2pHGDl@kreacher>
In-Reply-To: <3552364.iIbC2pHGDl@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Dec 2023 16:26:02 +0100
Message-ID: <CAJZ5v0jkHLGa2XxB4TMqzrBBdZYXY79+sh1Z0ZF6keYdLDyfkg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] ACPI: OSL: Use GFP_KERNEL for work item allocations
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 3:33=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After the recent modification changing the ACPI SCI interrupt handler
> into a threaded one, the SCI interrupt handler code does not run in
> interrupt context any more and acpi_os_execute(), that may be invoked
> by it, need not use GFP_ATOMIC for allocating work items.
>
> Make it use GFP_KERNEL instead.

This change is premature, because acpi_ev_detect_gpe() still disables
local interrupts around acpi_os_execute() calls, even though it runs
from a kernel thread now.

Withdrawing.

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/osl.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Index: linux-pm/drivers/acpi/osl.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/osl.c
> +++ linux-pm/drivers/acpi/osl.c
> @@ -1084,8 +1084,7 @@ acpi_status acpi_os_execute(acpi_execute
>          * parameters we can't use the approach some kernel code uses of
>          * having a static work_struct.
>          */
> -
> -       dpc =3D kzalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
> +       dpc =3D kzalloc(sizeof(struct acpi_os_dpc), GFP_KERNEL);
>         if (!dpc)
>                 return AE_NO_MEMORY;
>
>
>
>
>

