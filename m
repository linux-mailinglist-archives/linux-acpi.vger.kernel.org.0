Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040646368FF
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Nov 2022 19:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiKWSeH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Nov 2022 13:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbiKWSdn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Nov 2022 13:33:43 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4D71F1F
        for <linux-acpi@vger.kernel.org>; Wed, 23 Nov 2022 10:33:12 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id j26so5921552qki.10
        for <linux-acpi@vger.kernel.org>; Wed, 23 Nov 2022 10:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oclx3dMBHD3fGp1zWmT0o+vlITWjqxp7OD7shAaazPk=;
        b=4DfDMln4se+xrTJMcWvYQsdWeJ84kS6MdnGZw6CBToZvBbJcos83mQu3bTWeH9JT4p
         RNsuqRlomYbq/rOrEpd+jEO2sU4P7B1fu2R9oRWVXbqGpaMaL+FXwc8GAt6n8U2Acb9C
         wdsqXELl+EuY9oBKzvMmbf0nWiQjBYqH2lYvbbKLLiGSzLuSuROBBh/O0GbuHkZVYgAD
         Hft/xq9JqpPVFWJK58dFfpGdD4xXMKkPIppXMiUxatOmV0jbwASfU20Aj+0k6o9Cv6v6
         KWukdG/3R+hEBwYtASq2W1MNID7d4rNqCRv+eBdmr/kcXhzIWZ0AF/FIGaoMWhcWXlfa
         Wisg==
X-Gm-Message-State: ANoB5plgouRC6zcEF1CBWwJRfuHs1F9KMKCFGV///Kl6CpipaOlSbG1m
        40Kky5UHZH5IOcvMLaGmI4IojN8rkkWcl1dTf9zvmE3V7sI=
X-Google-Smtp-Source: AA0mqf4GzwvkOpNWi152Q01q4lPESo5gQM1/wptiiU1vqXh8xwbvrshxR1ZTyN5XpCcgpOqhOFj+y9lAmoNoNWFGqg4=
X-Received: by 2002:a05:620a:51ca:b0:6ec:fa04:d97c with SMTP id
 cx10-20020a05620a51ca00b006ecfa04d97cmr10037747qkb.764.1669228391803; Wed, 23
 Nov 2022 10:33:11 -0800 (PST)
MIME-Version: 1.0
References: <1669107208-16226-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1669107208-16226-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 19:33:00 +0100
Message-ID: <CAJZ5v0gh-3dOb+6M1trsD1Z8m+bkBkxxuGC9vY8yAX2UzL6o_w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: Bail out if extract package failed
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 22, 2022 at 10:08 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> Bail out if we extract the _FIF package failed, or we will end
> of referencing the garbage information in fields[], the fan control
> will be in mess, fix it.
>
> Fiexes: d445571fa369 ("ACPI: fan: Optimize struct acpi_fan_fif")
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/acpi/fan_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 52a0b30..9dccbae 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -236,6 +236,7 @@ static int acpi_fan_get_fif(struct acpi_device *device)
>         if (ACPI_FAILURE(status)) {
>                 dev_err(&device->dev, "Invalid _FIF element\n");
>                 status = -EINVAL;
> +               goto err;
>         }
>
>         fan->fif.revision = fields[0];
> --

Applied as 6.2 material, thanks!
