Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478324CAF72
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Mar 2022 21:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiCBUKj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Mar 2022 15:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCBUKj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2022 15:10:39 -0500
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C68BF67
        for <linux-acpi@vger.kernel.org>; Wed,  2 Mar 2022 12:09:55 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id b35so5656674ybi.13
        for <linux-acpi@vger.kernel.org>; Wed, 02 Mar 2022 12:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unEvXXtUmbqdzvkggwB1rsZWpxRmnKxPkPCLVNXM7Bk=;
        b=r/j0wMcrmb1ZXtGZpdabIZ4bPIu/JnjWraR1u5j38RQoCB01qhD8Zv5p6BjE+36gkQ
         0U8Cu5tvtQH581Z4hF5fA3G1zqAkdIKEitPbeDzwJfFWh6zC9mAOJev5Ep6PDiufcoQ4
         HNuGSc5ib/JlUPHdwLmk6Kh4Oh1ouyvxOYk90qTVVXBxf3tdIBQTeAh77ZZMA3K+L053
         Z7su9Mm3aGKoWLGo8ZNVeb1PGXUqWrXRjIxi1szXDr9exuSEOSson79+QGiGb7OEGa4F
         Kd+e0URBP6FXs9pkbzXngZiqzYHXuaQHoV4lZZfYF2H81Bao5Yk/5mBA4ZBWhQ21tLPz
         iYdA==
X-Gm-Message-State: AOAM532tu0Ec/TgFMdT6Ycnf5cBuAkAXdiZzfEIQ2ZVweLp7sLzfvKW+
        /sWCqSucbIgVktU6GMUfo+blAXaUUK11+S47hi91+QVS
X-Google-Smtp-Source: ABdhPJxa3nSv20zswC0tUEcuPSizku31in6LEfK22wnEFeZgoN4nYF027fgQgFsPK66J1wBFNlyCWJ7dUW95TpagI/w=
X-Received: by 2002:a25:f306:0:b0:628:9a03:9ab8 with SMTP id
 c6-20020a25f306000000b006289a039ab8mr5074520ybs.622.1646251795141; Wed, 02
 Mar 2022 12:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20220301124908.1931221-1-mario.limonciello@amd.com>
In-Reply-To: <20220301124908.1931221-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Mar 2022 21:09:44 +0100
Message-ID: <CAJZ5v0iK2CAqossLs+sm+wuxi44xq1vbbNwr+pmOraEt+a=_nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ACPI: APEI: Adjust for acpi_run_osc logic changes
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Xiaomeng.Hou@amd.com, Aaron.Liu@amd.com,
        Huang Rui <Ray.Huang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 1, 2022 at 1:52 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> As this function calls the OSC with the OSC_QUERY_ENABLE set in
> OSC_QUERY_DWORD, ensure that it continues to operate the same if
> the function has returned AE_SUPPORT.
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
> * No changes
>  drivers/acpi/apei/apei-base.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index c7fdb12c3310..f7d1aa687fd9 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -780,6 +780,7 @@ int apei_osc_setup(void)
>  {
>         static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";
>         acpi_handle handle;
> +       acpi_status status;
>         u32 capbuf[3];
>         struct acpi_osc_context context = {
>                 .uuid_str       = whea_uuid_str,
> @@ -792,12 +793,12 @@ int apei_osc_setup(void)
>         capbuf[OSC_SUPPORT_DWORD] = 1;
>         capbuf[OSC_CONTROL_DWORD] = 0;
>
> -       if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle))
> -           || ACPI_FAILURE(acpi_run_osc(handle, &context)))
> +       if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>                 return -EIO;
> -       else {
> -               kfree(context.ret.pointer);
> -               return 0;
> -       }
> +       status = acpi_run_osc(handle, &context);
> +       if (status != AE_SUPPORT && status != AE_OK)
> +               return -EIO;
> +       kfree(context.ret.pointer);
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(apei_osc_setup);
> --

Applied as 5.18 material along with the rest of the series.

Thanks!
