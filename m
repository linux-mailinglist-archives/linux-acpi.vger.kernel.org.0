Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2985059EB11
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Aug 2022 20:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiHWScp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Aug 2022 14:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiHWSc0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Aug 2022 14:32:26 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9DC10A76E
        for <linux-acpi@vger.kernel.org>; Tue, 23 Aug 2022 09:53:49 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3246910dac3so394734677b3.12
        for <linux-acpi@vger.kernel.org>; Tue, 23 Aug 2022 09:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NCk5kO2oY1yzOyTcQEaeipuJczC4lYTBO6dlH6jUCHQ=;
        b=2qazrMOJtAfEeCoj1of6dy0R5mvkXgF4uZbVUImSlBNqQ0N1VFDZwtdlS8HqqQQ4cj
         XJAGoxc+8rBrWUYiIYSrbjEJrj7lyXC34pvNqDkgpzThbdnvphrJFnB895alTZeMqKz3
         LdMoOpzaqiXG3bfPvRgHoGCX0fR6aKj3BuU68V/cmFkdLzAjxjsQfvNwrQ81jBJ5e+g3
         aOfc77hkwIuw2UKw3Zo6DiY4ELG9eXV2JyuuImmb5uMIQSdsViZQYb5pdETRXOK4VDAt
         2IAOSOvzCFRvkHHX6IzzKOSjCYimbhUcFhox7BB2PjlA9OPImpjDWwUCmKEgb4alW5W7
         NHHg==
X-Gm-Message-State: ACgBeo2dEaB0a8pgv/Y00ISrJcgjEZ3XUhUTQrV/4GTDsyjhKoOFnFhZ
        tuHrmf6yfuXO+DC2utg+3Tl2HAROysNwg5Ehw3w=
X-Google-Smtp-Source: AA6agR6qRa51eiAcmslrU1djpt/18+gdIAefZULhMwSqJHYjEpFhXHDFCg1A1IUomdw0F+bd31ESHOkxsO4jrcK2cjE=
X-Received: by 2002:a81:4850:0:b0:33c:922b:5739 with SMTP id
 v77-20020a814850000000b0033c922b5739mr9104860ywa.515.1661273628544; Tue, 23
 Aug 2022 09:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220818055156.7456-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20220818055156.7456-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 18:53:37 +0200
Message-ID: <CAJZ5v0gdZzYbv88Jsx9PzB1GDF5+ZyzKq-8JW=-UPAocfHm+tQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: Fix acpi_dev_state_d0() documentation
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Thu, Aug 18, 2022 at 7:52 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> The documentation for acpi_dev_state_d0() referred to
> Documentation/firmware-guide/acpi/low-power-probe.rst that does not exist,
> the right file name is Documentation/firmware-guide/acpi/non-d0-probe.rst.
> Fix this.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/device_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 130b5f4a50a3d..fc5ffdb544cae 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1438,7 +1438,7 @@ EXPORT_SYMBOL_GPL(acpi_storage_d3);
>   * not valid to ask for the ACPI power state of the device in that time frame.
>   *
>   * This function is intended to be used in a driver's probe or remove
> - * function. See Documentation/firmware-guide/acpi/low-power-probe.rst for
> + * function. See Documentation/firmware-guide/acpi/non-d0-probe.rst for
>   * more information.
>   */
>  bool acpi_dev_state_d0(struct device *dev)
> --

Applied as 6.0-rc material, thanks!
