Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7AD5ED8
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2019 11:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfJNJ3R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Oct 2019 05:29:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34950 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbfJNJ3R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Oct 2019 05:29:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id x3so13200515oig.2;
        Mon, 14 Oct 2019 02:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsNTcuXws2GkYhReW0QEL4QdQI7fzEajZVNN3skykrE=;
        b=V/CNaT/vzXxLWM5/lK8YIIrguJQKraHVUvHNTSoHUZNUQdysSxg1UpHtDDLJXYF7Ad
         hYzInXDsSW0cT9s2z+o3mvPuwhlOOFaD8DSaivRF1v3fpqBioDpk5fEqTMjV5uyry/PU
         At3Z2W90XssVqK4st091LDenJ/3pSYgXVPt1VycVWwYX9VEiWjZmZ+zGTvypWY6Y65+e
         kmHdffm4Xb/GvXW6hnM3cqsOFqDHwVjsot/puBaPrPYXpmYyKteJOomq1FPKkbtt5RbW
         KZQQPBUcyxdS/z41GN1lbxsYIg2enMBy01TpQUrlLjv4Jap+4DDdK/NCEK1w2Lwe94kB
         4i1w==
X-Gm-Message-State: APjAAAWCfZBvl+yOE7kY2LwG34jVUqdRlHV2L1RAVnhsUDsauFiRJemP
        /0kPzWNSgSg133XPsm7cDB8oqGV1HoGD8+yY4Cr48A==
X-Google-Smtp-Source: APXvYqwg6Om3eg/KoHpqe9l2WGVS21Mw5/J40648F7V+7Bx3F4+pQ7e007L6NJrS0ISBEAabdJZtUenqCG025PJdQKY=
X-Received: by 2002:aca:5885:: with SMTP id m127mr24294219oib.110.1571045355051;
 Mon, 14 Oct 2019 02:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191013030723.31391-1-jpack61108@gmail.com>
In-Reply-To: <20191013030723.31391-1-jpack61108@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Oct 2019 11:29:03 +0200
Message-ID: <CAJZ5v0gBngPbSqLnNqt000s+9qQet1EZoD=cg6SCEhQ3ET6cdw@mail.gmail.com>
Subject: Re: [PATCH] ACPI Documentation: Minor Spelling Fix
To:     James Pack <jpack61108@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <trivial@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 13, 2019 at 5:07 AM James Pack <jpack61108@gmail.com> wrote:
>
> Very minor spelling fix in ACPI documentation
>
> Signed-off-by: James Pack <jpack61108@gmail.com>
> ---
>  Documentation/firmware-guide/acpi/namespace.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/firmware-guide/acpi/namespace.rst b/Documentation/firmware-guide/acpi/namespace.rst
> index 835521baeb89..3eb763d6656d 100644
> --- a/Documentation/firmware-guide/acpi/namespace.rst
> +++ b/Documentation/firmware-guide/acpi/namespace.rst
> @@ -261,7 +261,7 @@ Description Tables contain information used for the creation of the
>  struct acpi_device objects represented by the given row (xSDT means DSDT
>  or SSDT).
>
> -The forth column of the above table indicates the 'bus_id' generation
> +The fourth column of the above table indicates the 'bus_id' generation
>  rule of the struct acpi_device object:
>
>     _HID:
> --

Applying as 5.5 material, thanks!
