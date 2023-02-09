Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25458690955
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 13:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBIMy2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Feb 2023 07:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBIMy0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2023 07:54:26 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F0B5C889;
        Thu,  9 Feb 2023 04:54:17 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id dr8so5952791ejc.12;
        Thu, 09 Feb 2023 04:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHBz9vMVl9sVKFZ9dAgK8GS9XLLYozpdplINKKhz8lE=;
        b=w+tBCQzt0oI0p8dddYOqB5dW1GkPcwclygW11vPdGVY4HK2vRJbhcv7cMjAgaEXeNs
         ggYDL5lua0yDOdMvpxnay4hHS35pExIrwhiLG21/IRMSQYKhnRCLRHf5o64OSePP6HYC
         DEuwMJFioejwmW9aQVTv9rxEIctkfhwxD7Z9Dw0qG9QcmNY0CMo6jik3h2tslnkmcTYM
         AlQpPLx3CEXWQHXP8N4JObeC8HMBjDuiAVgzgvdNIb9O0NFbsA+z0cULplp69o9sgcPN
         njQUQyLfc2vC4diXpAZRS6YuEkahcz+xMLSZIDs83snyVWqtT5915kr+7DWw2fC5xyBJ
         ZaaQ==
X-Gm-Message-State: AO0yUKVlw4XIa2wemT+B1d2YwwzTREgRKDqBHTUEyhtCVSEzSwzAkexu
        3m8km9ZLQmlh+bAVeKfXwsT3NU1IFT4ZEN90Kei7ALCt
X-Google-Smtp-Source: AK7set/qjFgUq9QsoEQ4JPS0G6KQvTsaS/kHeSFPznfAgqYcWbMAi541EKmGK3m/HkBuje2EfPeAxFgHyBjEdZuHKJQ=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr2663625ejb.274.1675947255222; Thu, 09
 Feb 2023 04:54:15 -0800 (PST)
MIME-Version: 1.0
References: <1bebe2a62539988a1b5fd26665ab5221a7eddbb2.1675835625.git.lukas@wunner.de>
In-Reply-To: <1bebe2a62539988a1b5fd26665ab5221a7eddbb2.1675835625.git.lukas@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 13:54:00 +0100
Message-ID: <CAJZ5v0jQ7KmvpN7kkNspqJ_ojbLYJ_XvG8jA-yb9J=yFNRQEgA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix typo in CDAT DSMAS struct definition
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 8, 2023 at 7:07 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> ACPICA commit 9d8bd58d5f3495ce76d1b9767ec0b92251cbc366
>
> Link: https://github.com/acpica/acpica/commit/9d8bd58d5f34
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Dave Jiang <dave.jiang@intel.com>
> ---
>  include/acpi/actbl1.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 72884ef..cdedccc 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -346,7 +346,7 @@ enum acpi_cdat_type {
>
>  /* Subtable 0: Device Scoped Memory Affinity Structure (DSMAS) */
>
> -struct acpi_cadt_dsmas {
> +struct acpi_cdat_dsmas {
>         u8 dsmad_handle;
>         u8 flags;
>         u16 reserved;
> --

Applied as 6.3 material, thanks!
