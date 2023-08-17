Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA70F77FD0A
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Aug 2023 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjHQRb5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 17 Aug 2023 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354015AbjHQRbb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Aug 2023 13:31:31 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB89BF
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2023 10:31:30 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56d26137095so11318eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2023 10:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692293490; x=1692898290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAnNvJFPyOKScRV6b+f0B2/xCdji87Zfn6pP272UWYE=;
        b=iSStarjve1L3g1msG/0EoospyytAa07uUFuXX7gnlzhJruWd0Fnqnt64JMnV7lQOrN
         pYAJKwXMFfonP8CxmZyobGdI9r2Xp46LpLKZP6pasBp7fX6bMtLo9HH2XxDbZTTSoGbO
         N3ssbH1ZZ/zuhgOhOXaC7fMxGQhOXmBe3qJLBE324k5QjtKnJ5Si4ygTwo0oPIGayHGn
         N/lSnzPkhxeaPgANpKtP0V81lMxbSbTAGGUN9g1XaINNYbHWJO4e7wO3x43WGKYElOUu
         J/nS9VAg7SoKTWBscCF5ARsnyjgqE32GAsQyyPbbdUT2Y759Qq4MakWa2oOV4AcTnPTP
         jNDQ==
X-Gm-Message-State: AOJu0YzB1aKCgrDAKcrQhx6wrwY7p50/ZfHsIwjYo25DHdDe8mFmaMK+
        GYNDr8zfXVxjCclYruE/L9Q34BnvNFQehbV+XFnUhG+x
X-Google-Smtp-Source: AGHT+IHfN/7WzAOlmiiu9eZAZBO6qB3ZXEl8+PUPm3CiGBFa78oYboFMrAeXZRhNv4Y3dBRIQChM9SjQR5GcZ926Nzw=
X-Received: by 2002:a4a:d581:0:b0:56e:487f:8caa with SMTP id
 z1-20020a4ad581000000b0056e487f8caamr407090oos.1.1692293489991; Thu, 17 Aug
 2023 10:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230807094408.242069-1-hdegoede@redhat.com>
In-Reply-To: <20230807094408.242069-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 19:31:18 +0200
Message-ID: <CAJZ5v0iBZQGzmYi0kJkwyY1=gE5UYz+FgHFRYSWGxzWNEGOWow@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Apple
 iMac12,1 and iMac12,2
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 7, 2023 at 11:44 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Linux defaults to picking the non-working ACPI video backlight interface
> on the Apple iMac12,1 and iMac12,2.
>
> Add a DMI quirk to pick the working native radeon_bl0 interface instead.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1838
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2753
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 18cc08c858cf..7cceaf31d928 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -486,6 +486,24 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "iMac11,3"),
>                 },
>         },
> +       {
> +        /* https://gitlab.freedesktop.org/drm/amd/-/issues/1838 */
> +        .callback = video_detect_force_native,
> +        /* Apple iMac12,1 */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,1"),
> +               },
> +       },
> +       {
> +        /* https://gitlab.freedesktop.org/drm/amd/-/issues/2753 */
> +        .callback = video_detect_force_native,
> +        /* Apple iMac12,2 */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
> +               },
> +       },
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
>          .callback = video_detect_force_native,
> --

Applied as 6.6 material, thanks!
