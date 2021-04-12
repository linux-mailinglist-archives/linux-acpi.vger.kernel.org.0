Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D51F35CF8A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 19:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbhDLRfj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 13:35:39 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37672 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbhDLRfi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Apr 2021 13:35:38 -0400
Received: by mail-oi1-f174.google.com with SMTP id k25so14226278oic.4;
        Mon, 12 Apr 2021 10:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQ/lurYpXN3VwQox6aFUpBiN7VUzu07uS3TQtD1HRNQ=;
        b=FC65Nj0IL7OVtsEPDR+fSyxHmDBK58U0k0lwWq1d1DJ7XeBo2gBSpkmxi5UXSNWlQf
         w2ZtS0WMMh/nz7ALNP4O+j4oxV4Fs4OA5oI7Vf69PaRPBKlWhQwZMxSO6ROH+0ykTzJD
         sg0coVWxFMqah10npgeN9K+wOxy5Tcr4aWCk/mZQdwbUDTECpcVycW1trbBcXrZskTOA
         dwhk4SCwThnsTMZ26Vp+4aO6VlfRjeK5MgqxxkJGX4hfez3UFviRj5U5uY+ztUlnR/yJ
         qEzEMprxUCpUNe/mwe3oXoKbw3Sk3+evIjUzS690tJQnHoUCVs6zcTPNllbgOKat6L2V
         CfFA==
X-Gm-Message-State: AOAM532hvYCGS2g9yUAs0oTGRf0aSr0rheo0hDCcpnufayVlN80CM50K
        9D376rksrKOrA5lLvJ13lYN7qpmCzQUnFvqKlIs=
X-Google-Smtp-Source: ABdhPJwDErsXU1nN5NgQZy/6xypurKvi7xkp48Z2sQ4Me3Mi5BK9mGAQY3+apKxWpP1CtlLt9EDMIFpFgYfdCPW5KEY=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr185906oib.69.1618248920250;
 Mon, 12 Apr 2021 10:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210410140253.1966892-1-andy.shevchenko@gmail.com>
In-Reply-To: <20210410140253.1966892-1-andy.shevchenko@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Apr 2021 19:35:09 +0200
Message-ID: <CAJZ5v0gFiLgEeBCuhn1cKMA=G-+_Z+VLDa0OnagU+d4Vgn-Gmw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: scan: Utilize match_string() API
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Apr 10, 2021 at 4:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> We have already an API to match a string in the array of strings.
> Utilize it instead of open coded analogues.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/acpi/scan.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index b1d1f1a8ce69..bba6b529cf6c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -756,27 +756,25 @@ static bool acpi_info_matches_ids(struct acpi_device_info *info,
>                                   const char * const ids[])
>  {
>         struct acpi_pnp_device_id_list *cid_list = NULL;
> -       int i;
> +       int i, index;
>
>         if (!(info->valid & ACPI_VALID_HID))
>                 return false;
>
> +       index = match_string(ids, -1, info->hardware_id.string);
> +       if (index >= 0)
> +               return true;
> +
>         if (info->valid & ACPI_VALID_CID)
>                 cid_list = &info->compatible_id_list;
>
> -       for (i = 0; ids[i]; i++) {
> -               int j;
> +       if (!cid_list)
> +               return false;
>
> -               if (!strcmp(info->hardware_id.string, ids[i]))
> +       for (i = 0; i < cid_list->count; i++) {
> +               index = match_string(ids, -1, cid_list->ids[i].string);
> +               if (index >= 0)
>                         return true;
> -
> -               if (!cid_list)
> -                       continue;
> -
> -               for (j = 0; j < cid_list->count; j++) {
> -                       if (!strcmp(cid_list->ids[j].string, ids[i]))
> -                               return true;
> -               }
>         }
>
>         return false;
> --

Applied as 5.13 material, thanks!
