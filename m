Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7AD6F0A2F
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Apr 2023 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbjD0QrL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 27 Apr 2023 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243777AbjD0QrI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Apr 2023 12:47:08 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2264C34
        for <linux-acpi@vger.kernel.org>; Thu, 27 Apr 2023 09:47:04 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9594916df23so161075266b.1
        for <linux-acpi@vger.kernel.org>; Thu, 27 Apr 2023 09:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614023; x=1685206023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjsrLK++1Ok9mkPQh5RzlJPsuvae+2fAnwHy/bXuTZQ=;
        b=f5AnjhThfcyLnyC7v+3eWWzgwGuiDgicvdBgLp8B/IRH8Iv21GcIv5WYalp6E9NKmI
         nEV8rj/4qVu+drIcW1wMSOOQlm1J4b52vjdZxste21tyIKliO+bU0YjOhRSVoRWKmi6o
         A3a5j1PBDpQVhQfgL2C0NnkKadGjfUzxI5VgCd9eP2btbZ0gixe2eNtTM4lsSrvYd1vG
         w5xu+eoSRVKYK6Q5Xp6TNoFwbldh1orkFJ/irfJ2Am+eCfuuOZ67ygobqRlJIklFkYDC
         hAwwDcsdNl8Ko5oXVZeaJa4a1zr4JxnzaqnqtVnpQWMim3QbU8AgX2d0ngqPWqiJ4zEO
         BMEQ==
X-Gm-Message-State: AC+VfDxuJMto8WoB2YcaycEOWJjzL9w8OGMHNVArACk4ZYzkAmUPkaL7
        vSACWsOU8vpI0Mk9NKilKKSg6KHiqL+xLpeF3dQ=
X-Google-Smtp-Source: ACHHUZ7D1zPxvk3A3EfX41SNrGI4Oj+vvVgaiLJaFUX28cuiAeNQp++k07zyro+shIsRsSfHNs5lDdKbXwvh2ifcbAQ=
X-Received: by 2002:a17:906:64c4:b0:930:7f40:c1bb with SMTP id
 p4-20020a17090664c400b009307f40c1bbmr2189658ejn.4.1682614022494; Thu, 27 Apr
 2023 09:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230420110220.23168-1-hdegoede@redhat.com>
In-Reply-To: <20230420110220.23168-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Apr 2023 18:46:51 +0200
Message-ID: <CAJZ5v0jUC24BanTT_-RTm=5z0Hnpdvyse4VgFsV-VFsM1nbxHg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Do not turn of unused power resources on the
 Toshiba Click Mini
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
        =?UTF-8?B?R8OpIEtvZXJrYW1w?= <ge.koerkamp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 20, 2023 at 1:02 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The CPR3 power resource on the Toshiba Click Mini toggles a GPIO
> which is called SISP (for SIS touchscreen power?) on/off.
>
> This CPR3 power resource is not listed in any _PR? lists, let alone
> in a _PR0 list for the SIS0817 touchscreen ACPI device which needs it.
>
> Before commit a1224f34d72a ("ACPI: PM: Check states of power resources
> during initialization") this was not an issue because since nothing
> referenced the CPR3 power resource its state was always
> ACPI_POWER_RESOURCE_STATE_UNKNOWN and power resources with this state
> get ignored by acpi_turn_off_unused_power_resources().
>
> This clearly is a bug in the DSDT of this device. Add a DMI quirk
> to make acpi_turn_off_unused_power_resources() a no-op on this
> model to fix the touchscreen no longer working since kernel 5.16 .
>
> This quirk also causes 2 other power resources to not get turned
> off, but the _OFF method on these already was a no-op, so this makes
> no difference for the other 2 power resources.
>
> Fixes: a1224f34d72a ("ACPI: PM: Check states of power resources during initialization")
> Reported-by: Gé Koerkamp <ge.koerkamp@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216946
> Link: https://lore.kernel.org/regressions/32a14a8a-9795-4c8c-7e00-da9012f548f8@leemhuis.info/
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/power.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 292cec3691cc..5dc792961ab8 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -23,6 +23,7 @@
>
>  #define pr_fmt(fmt) "ACPI: PM: " fmt
>
> +#include <linux/dmi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -1022,6 +1023,21 @@ void acpi_resume_power_resources(void)
>  }
>  #endif
>
> +static const struct dmi_system_id dmi_leave_unused_power_resources_on[] = {
> +       {
> +               /*
> +                * The Toshiba Click Mini has a CPR3 power-resource which must
> +                * be on for the touchscreen to work, but which is not in any
> +                * _PR? lists. The other 2 affected power-resources are no-ops.
> +                */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE Click Mini L9W-B"),
> +               },
> +       },
> +       {}
> +};
> +
>  /**
>   * acpi_turn_off_unused_power_resources - Turn off power resources not in use.
>   */
> @@ -1029,6 +1045,9 @@ void acpi_turn_off_unused_power_resources(void)
>  {
>         struct acpi_power_resource *resource;
>
> +       if (dmi_check_system(dmi_leave_unused_power_resources_on))
> +               return;
> +
>         mutex_lock(&power_resource_list_lock);
>
>         list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
> --

Applied as 6.4-rc material, thanks!
