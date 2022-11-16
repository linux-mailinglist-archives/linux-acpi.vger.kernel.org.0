Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF562C897
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Nov 2022 20:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiKPTAS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Nov 2022 14:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiKPTAR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2022 14:00:17 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F00154B0A
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2022 11:00:15 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id s4so11316468qtx.6
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2022 11:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5aHUHf7y84PMLO+S1e8aeaooNKQPYgghPbbQkT/3x4=;
        b=ZhQTjvZes8ePqqhmrt/F9WXjgaE+L9zTfdXgXm0MxazlMX+VTchvn3ZjvtRTGML0iI
         xbjl5LiVE3lqlNZ+0RsPlB1zc9LRGTvFvc1O9dWlasLntWJOeexKf5nmBX+mXTGYS2l0
         DNqPBd70lq1rQ8ffMgpYwJkkBf5FzF83Q8N9zBUgmeRjTMkmWbfiz5fysKMVIl88vwdi
         1GbKowl+6JZwdbyplWzmvylcB4cdivCa4hVlGKsOul2xVXrFzpXWkyCC4t9eU2aT/L9W
         8wdkwDv0p/++EGdVu9HADBNhxEQm5rFZjAppyWi2ty8xaKIBmNAKmphm5MfJkPvhF0QI
         aN2Q==
X-Gm-Message-State: ANoB5pkANCI+obgOm+8t4oc9t4CNnDA+xpXXWhVFxK9waROYQKBKAyWr
        4D8xxGDVD4710PFUZIaaSGj+vXdbl7bBOL96v1E=
X-Google-Smtp-Source: AA0mqf5XNn/NZNWjllw9RKkMNoA8XTiGSI9kD/dNkpoZre6HAOUBP6SetCEE6Ujk0FjkzgqzGZCT6jYMtlROEOmzpYc=
X-Received: by 2002:ac8:708d:0:b0:3a5:4678:5b24 with SMTP id
 y13-20020ac8708d000000b003a546785b24mr21989660qto.411.1668625214650; Wed, 16
 Nov 2022 11:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20221116074930.3292121-1-sudeep.holla@arm.com>
In-Reply-To: <20221116074930.3292121-1-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Nov 2022 20:00:03 +0100
Message-ID: <CAJZ5v0jh6QRBWTUdOkr_YFjCv4i46qZj4RV0VUHrrJOvCwmexA@mail.gmail.com>
Subject: Re: [PATCH 0/5] ACPI: Bunch of fixes to silence missing prototype warnings
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 16, 2022 at 8:49 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Rafael,
>
> Initially I thought of bundling all in one patch, but I see you have
> different branches for different sub-components, I split them. You can
> squash them as needed.
>
> Also I have marked all reported by LKP though it was just 3/5 as that
> triggered to post these fixes :).
>
> Regards,
> Sudeep
>
> Sudeep Holla (5):
>   ACPI: APEI: Silence missing prototype warnings
>   ACPI: processor_idle: Silence missing prototype warnings
>   ACPI: FFH: Silence missing prototype warnings
>   ACPI: PM: Silence missing prototype warning
>   ACPI: processor: Silence missing prototype warnings
>
>  drivers/acpi/apei/apei-base.c |  1 +
>  include/acpi/processor.h      | 10 ++++++++++
>  include/linux/acpi.h          |  6 ++++++
>  3 files changed, 17 insertions(+)
>
> --

All applied as 6.2 material, thanks!
