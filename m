Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92787A525C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 20:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjIRSwR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 18 Sep 2023 14:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIRSwR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 14:52:17 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F93F7;
        Mon, 18 Sep 2023 11:52:12 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-578a49f7e57so662521eaf.1;
        Mon, 18 Sep 2023 11:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063131; x=1695667931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdL/6uftB+J4I/ndQOVq05dAe+clS7lBFdeUffIv3uU=;
        b=KpKxMGt8kQjEW6VJm3uCcFm+HfDXwX5rVJ1Tt/u0CRK7xtrGza4oEqOM1j0F1EHYQw
         XAmZq1JJBcy0QUfQh4BUSPbLy/ZO66ir7ywuiBE1iFPG8laYitCU/BgeoD7Ukg7TBiNu
         QaIDKGLajGuwJIOs49TdF8oSp3fxup6CE46v9alOjKCfVVQwE7Ko0U9DHwXeqSE+dSVv
         0dWIuUmBFfttOlgNc2Z+GuxP441u4VsEEV6INMrbQNSBkN3ATJZRYPTFdEF/x7h8834e
         vncHyQThU5X5hzKQwPVz/urMWrHhIZdhSepMigKVwTEiSwyzLwgWV/VBW/lnDb1rpIYt
         mVlA==
X-Gm-Message-State: AOJu0YzSn1gP1iYm6/+V6JPJkqreMugBQc1KdWI4DzUgUH7guxe33Yhg
        ysdbQpbcGpv1nCGCZMEaVN+VxMe3xWQ+SPk2B8M=
X-Google-Smtp-Source: AGHT+IE2fe+Bw9uo4vjaQMg+BX3VYGdTMhku0J6X9OOJCb6Zcl4R3QCb8sKwlRcje24tIdTz/tBAc5rAZ1Qu6giDw4s=
X-Received: by 2002:a4a:b24b:0:b0:57a:bbca:a041 with SMTP id
 i11-20020a4ab24b000000b0057abbcaa041mr8867242ooo.1.1695063131582; Mon, 18 Sep
 2023 11:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230912100827.303590-1-hdegoede@redhat.com>
In-Reply-To: <20230912100827.303590-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Sep 2023 20:52:00 +0200
Message-ID: <CAJZ5v0gipS4Ughq0h08D29W735nmF3XMm1w9LTaBHNNUDj6Zog@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org
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

On Tue, Sep 12, 2023 at 12:08 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Like various other ASUS ExpertBook-s, the ASUS ExpertBook B1402CBA
> has an ACPI DSDT table that describes IRQ 1 as ActiveLow while
> the kernel overrides it to EdgeHigh.
>
> This prevents the keyboard from working. To fix this issue, add this laptop
> to the skip_override_table so that the kernel does not override IRQ 1.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217901
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 32cfa3f4efd3..8116b55b6c98 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -439,6 +439,13 @@ static const struct dmi_system_id asus_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
>                 },
>         },
> +       {
> +               .ident = "Asus ExpertBook B1402CBA",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
> +               },
> +       },
>         {
>                 .ident = "Asus ExpertBook B1502CBA",
>                 .matches = {
> --

Applied as 6.7 material, thanks!
