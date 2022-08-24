Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8052A5A016E
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiHXSiU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiHXSiT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 14:38:19 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A72796A3
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 11:38:17 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-33db4e5ab43so1605767b3.4
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 11:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BlHaathUWeYi1fcXZiJX14RNs0JnHU9C0t9HjIXgI68=;
        b=j72BrKEBQYS7vQIOEo8C0W7oyRsaHYC9tNy85i6Xc1lX2QY6oiS5BgCie1Ev2m88Qi
         TAJbpbXqeKdPvL7WyP/lApsAroHUSpLtQBAxQKJ5TaimkdTShNW7wjiU1e1fayG6sDSm
         1n5REKD2S7BDR1pT7Uvn5Ai3z7IrI04LpPQIhyZBxi8t3qRcWa9Fv6xwtKxVXTLSLtgA
         9K1wfEMglJDcn4JADxLvXNDEcQ9KuhGOANYkj0/L1ajDzNpmu4DkCuiU8xpN8A96Ht1s
         sGXvTKpg8gEftBDj7eaKIKNSpkwJCPKprGSlKW7dHeHFleOZEjHTyhXDPa164i4uoLIC
         egwA==
X-Gm-Message-State: ACgBeo23E5droGTrTMmp2s6cHEZmAmdQ6E8bPLuqkMfwTtLIDbmlwGPB
        GKMH9jgCsafD2VN0LAVHAyL8vzMyykmmtlQgj1Manrh4
X-Google-Smtp-Source: AA6agR5zvTo7NAd+EgqwLXqD+e8SC/6oJROoI7cqQn8j8g7vq8mfXDaP98CnIlpcZiDUAI6T6bSopSvH4CEcOF+1dSA=
X-Received: by 2002:a81:104e:0:b0:336:37f1:9686 with SMTP id
 75-20020a81104e000000b0033637f19686mr525067ywq.149.1661366297245; Wed, 24 Aug
 2022 11:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220824115956.1971171-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20220824115956.1971171-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Aug 2022 20:38:06 +0200
Message-ID: <CAJZ5v0jAf=gaV3Weo_f7rOfYtpdFHu3a5xvuYxYBhc5ZN9hQdA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Ignore already existing data node tags
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

On Wed, Aug 24, 2022 at 2:00 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> ACPI node pointers are attached to data node handles, in order to resolve
> string references to them. _DSD guide allows the same node to be reached
> from multiple parent nodes, leading the node enumeration algorithm to each
> such nodes more than once. As attached data already already exists,
> attaching data with the same tag will fail. Address this problem by
> ignoring nodes that have been already tagged.
>
> Fixes: 1d52f10917a7 ("ACPI: property: Tie data nodes to acpi handles")
> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/acpi/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 7b3ad8ed2f4e6..fa97b31214a83 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -370,7 +370,7 @@ static bool acpi_tie_nondev_subnodes(struct acpi_device_data *data)
>                 bool ret;
>
>                 status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
> -               if (ACPI_FAILURE(status)) {
> +               if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
>                         acpi_handle_err(dn->handle, "Can't tag data node\n");
>                         return false;
>                 }
> --

Applied, thanks!
