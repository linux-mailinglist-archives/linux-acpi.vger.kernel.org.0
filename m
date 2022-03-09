Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57EA4D2FFA
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Mar 2022 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiCINd1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 08:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiCINd0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 08:33:26 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5DD13C39D
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 05:32:25 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id w16so4295889ybi.12
        for <linux-acpi@vger.kernel.org>; Wed, 09 Mar 2022 05:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7p0JckL1w/2NfmH5tXvE+QWrfz+oN2oxWMLVUvmaHw=;
        b=PL69+DTCUFGcHkYPhl0CVrwvVXwpX1mBXrtmaeuYQxfd5uMkBCxElDt9mMHcHdmnjG
         37XM5ZgWOIesjtfKHpF+JJRTgYHJDhQprHOyN/I35nwbtonIZ8PgZgcoLZ68X0lnYhcO
         TCfBu2MlNxP6XPCdCz68mjtCfl9Z2pmWqW4t/GpZAd4EfTZvLtxPxpY7NCBtKO1hAhx5
         YHB9KIXmhlCg7eYR5Xcuj1IFcJkQ0uhKbmFWdCeTLp/ZnyVElGO42t5aZFvmEeYy2FIm
         T3YYXJ15iPrQwEDqtYtF1hb5TK7/qs5VvS0OTCTy8lZBiFDbF9wrCe3DCsJf+dfXWNL+
         2lsw==
X-Gm-Message-State: AOAM533+j2lQfrZ47C6Ynsc6E22ed8vWg0A5yWLJtestWdNb2Q9ouUJM
        hUf4a3GXDIHRxBtixHtCucgJL3NfR9keBQzHOTOH4aiDlmc=
X-Google-Smtp-Source: ABdhPJzIKIQJgDDiw0vldyFEblNuijIE30ygwalOz2SpVDqHXbuYizAlzdgx5Zz9xM/nAdfODCnTHFkADca8mQN2lkU=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr16188953ybk.482.1646832744226; Wed, 09
 Mar 2022 05:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20220308224200.2691564-1-mario.limonciello@amd.com>
In-Reply-To: <20220308224200.2691564-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Mar 2022 14:32:11 +0100
Message-ID: <CAJZ5v0ixsSuH_d+CCiU_Mn7HaCf6mLekOadte9j33NKg4aH20w@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Add support for `AE_SUPPORT` in _OSC queries
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
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

On Tue, Mar 8, 2022 at 11:44 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit a412caea5a2d ("ACPI: bus: Allow negotiating _OSC capabilities")
> added support for `acpi_run_osc` to return `AE_SUPPORT` when negotiating
> an _OSC.
>
> This was fixed in other kernel consumers, but `acpi_pci_run_osc` was
> missed.  Update the function to detect when called with `OSC_QUERY_ENABLE`
> set and attempt to negotiate up to 5 times.

This is not how it is designed to work, though.

acpi_pci_query_osc() is for that.

>
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Fixes: a412caea5a2d ("ACPI: bus: Allow negotiating _OSC capabilities")

So I'm seriously thinking about dropping that whole lot at this point.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/pci_root.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 6f9e75d14808..2eda355fde57 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -171,7 +171,7 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
>  static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
>
>  static acpi_status acpi_pci_run_osc(acpi_handle handle,
> -                                   const u32 *capbuf, u32 *retval)
> +                                   u32 *capbuf, u32 *retval)
>  {
>         struct acpi_osc_context context = {
>                 .uuid_str = pci_osc_uuid_str,
> @@ -180,7 +180,26 @@ static acpi_status acpi_pci_run_osc(acpi_handle handle,
>                 .cap.pointer = (void *)capbuf,
>         };
>         acpi_status status;
> +       u32 *capbuf_ret;
> +       int i;
> +
> +       if (!(capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE))
> +               goto skip_negotiate;
> +       for (i = 0; i < 5; i++) {
> +               status = acpi_run_osc(handle, &context);
> +               if (status == AE_OK || status == AE_SUPPORT) {
> +                       capbuf_ret = context.ret.pointer;
> +                       capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> +                       kfree(context.ret.pointer);
> +               }
> +               if (status != AE_SUPPORT)
> +                       break;
> +       }
> +       if (ACPI_FAILURE(status))
> +               return status;
>
> +skip_negotiate:
> +       capbuf[OSC_QUERY_DWORD] = 0;
>         status = acpi_run_osc(handle, &context);
>         if (ACPI_SUCCESS(status)) {
>                 *retval = *((u32 *)(context.ret.pointer + 8));
> --
> 2.34.1
>
