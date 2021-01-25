Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF0302808
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 17:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbhAYQiq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 11:38:46 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43834 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbhAYQh4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 11:37:56 -0500
Received: by mail-oi1-f170.google.com with SMTP id i25so3971254oie.10;
        Mon, 25 Jan 2021 08:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xeQ4V23Ajf5fj66wtkSzJjEt/RWXVdHo+ey/AICDyc=;
        b=VOll5fIetLOoVM3BeLXFViqKbB5IDiO+Fai63pU6CAGdvx0X8JbSyWaWgd1sPvxHi+
         tia3y1VubWv2LKo4GzYEdmp87DvBcjsNvyUXNfoqk9t4iPosDKvdF3uQrb/5eqdxjX1W
         F8FesaDNPsz6iLLzxyJGA55WQ5ZobyQZ3vV9m4+hgK+dY/8+lsFgB55IDDOrfya/qCDn
         zp4obSIVdDZalmHvJuXe1Y02zeJpEJWSslQxeWfaNyWB0t0/8meZWgUXsR/CXY13yfck
         +nGJfX7+QYRH/MoLTZz5/qdhlyKH5rTBcEDlcMyTKlHQOk6wtk+blas0/diNtIemtcTM
         kb4A==
X-Gm-Message-State: AOAM530yUPfsffsCJRnVoxC6sE4dJooLalc8XsvImVJv1SCtdn/a0lxg
        x7ttqrKhGQd5Vo+5D28O4aUKV50Y5CWKmNyFrmo=
X-Google-Smtp-Source: ABdhPJxjRlUgCEKHb3d4EfwuMsvvXF/vB9vBF321DUZ5odkmJ08s6Xskq8JzSa+KaGuiD2jSk/yXwGJx+kFv8DTR/UI=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr641643oii.71.1611592635634;
 Mon, 25 Jan 2021 08:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20210124113252.733716-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20210124113252.733716-1-christophe.jaillet@wanadoo.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jan 2021 17:37:03 +0100
Message-ID: <CAJZ5v0hooTkVjXg-Emsr49aqV3PukEJYSJw03PEXxPYtSu+j0w@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Common: Fix a typo
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 24, 2021 at 12:35 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> This module is 'cmfsize', not 'cfsize'.
> Fix it.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

I'm leaving this one to Bob and Erik, thanks!

> ---
>  tools/power/acpi/common/cmfsize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
> index 9ea2c0aeb86c..185b8c588e1d 100644
> --- a/tools/power/acpi/common/cmfsize.c
> +++ b/tools/power/acpi/common/cmfsize.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
>  /******************************************************************************
>   *
> - * Module Name: cfsize - Common get file size function
> + * Module Name: cmfsize - Common get file size function
>   *
>   * Copyright (C) 2000 - 2021, Intel Corp.
>   *
> --
> 2.27.0
>
