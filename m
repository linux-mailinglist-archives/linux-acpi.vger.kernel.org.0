Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE744481F
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 19:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhKCSVq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 14:21:46 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43871 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhKCSVf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 14:21:35 -0400
Received: by mail-oi1-f172.google.com with SMTP id o4so4970508oia.10;
        Wed, 03 Nov 2021 11:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mg4euAY1KC0JDtts5aqpH876TSTS290bNkk/ITLN05s=;
        b=DerVTfaqbawVcqRaTKlVJxNVVx7ZJ1lAFDAPg7bpD0v/dlG18k3Fr9GPRWuMGfAYcU
         x9UYx7ANmXBLRd3FHBcd29gVYa9UEfGcW4L8ugTtc5586tRsAW2+lMGtF6yN2JOAZpi7
         e8edg90MKvabOLoBdGrTlqgr0hwPGqoTAGMFhpXRjUb/Z9ye1EiTwsHhg+cbmAmHfe5K
         eDE+BmYjlmcA4/nIXWoRc4eLgaDWl3/8JWV3Z9bJqlaq5JD2x7zSTbKbeOPGE1Z4sZfr
         KmUAJ+Eav+PRWKQGVAhJmAmi/hZVHd9U2QyPtBuhTvFekBzwJ5dIsCa6R9IVIRfs1MFw
         o7Hw==
X-Gm-Message-State: AOAM532oCBc+/hxs9KfQZp8MWQJlj4X6KVayGp2oFForQFjQr9PCD9d7
        /AhmuzSVjPTpD7bspA/7T8Oi+wFSGII0Yxim3cU=
X-Google-Smtp-Source: ABdhPJwoZwuP9fL0EYyTVOy2C4PXcr4TuRHUyjNf7x5eakoUVSWeiB/N4A9oUcgTpM/J3GlAAsFgaAJktwTbLYOKLmY=
X-Received: by 2002:a05:6808:128d:: with SMTP id a13mr12256199oiw.51.1635963538874;
 Wed, 03 Nov 2021 11:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211103055119.19312-1-wangzhitong@uniontech.com>
In-Reply-To: <20211103055119.19312-1-wangzhitong@uniontech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Nov 2021 19:18:47 +0100
Message-ID: <CAJZ5v0gS5Mo3REP-Y14gxUWge3avdiANHXi51R+mwz+EOBi_1w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: fix error "do not initialise statics to false"
To:     wangzhitong <wangzhitong@uniontech.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 3, 2021 at 6:52 AM wangzhitong <wangzhitong@uniontech.com> wrote:
>
> this patch fixes below Errors reported by checkpatch
> ERROR: do not initialise statics to false
> +static bool ec_freeze_events __read_mostly = false;
> ERROR: do not initialise statics to false
> +static bool boot_ec_is_ecdt = false;
>
> Signed-off-by: wangzhitong <wangzhitong@uniontech.com>
> ---
>  drivers/acpi/ec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 04ce2b96c3da..1255649a4da9 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -133,7 +133,7 @@ static unsigned int ec_storm_threshold  __read_mostly = 8;
>  module_param(ec_storm_threshold, uint, 0644);
>  MODULE_PARM_DESC(ec_storm_threshold, "Maxim false GPE numbers not considered as GPE storm");
>
> -static bool ec_freeze_events __read_mostly = false;
> +static bool ec_freeze_events __read_mostly;
>  module_param(ec_freeze_events, bool, 0644);
>  MODULE_PARM_DESC(ec_freeze_events, "Disabling event handling during suspend/resume");
>
> @@ -177,7 +177,7 @@ struct acpi_ec *first_ec;
>  EXPORT_SYMBOL(first_ec);
>
>  static struct acpi_ec *boot_ec;
> -static bool boot_ec_is_ecdt = false;
> +static bool boot_ec_is_ecdt;
>  static struct workqueue_struct *ec_wq;
>  static struct workqueue_struct *ec_query_wq;
>
> --

Applied as 5.16-rc material with rewritten changelog and subject, thanks!
