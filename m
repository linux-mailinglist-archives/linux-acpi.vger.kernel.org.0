Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9872CCE4
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jun 2023 19:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjFLRaN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 12 Jun 2023 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbjFLR3h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jun 2023 13:29:37 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F78FB
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jun 2023 10:29:36 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9787d11a410so97877166b.0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jun 2023 10:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590974; x=1689182974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJ+U9jAGmLf77BWOqCp1ifAftXMmdKAJaqWK7kiEeyc=;
        b=XWxc64jndXNGMnKZdzSPp944MlE/HUlXaow62KbCNR0iX/dnf8RUDj4fl+vAzkGQxI
         sT/yNIqs3iSDwO7TYQ8JZQXHBzm2ToWG9Qhj47KoHvhh7NNaKRX4jt7SyOl7KkL4RY5L
         QqNUUoAjoB/i0eUTant2Bo4mJViqtxciwTQfUOZsLiPJyg6VBI9LKgVtstQdWhZhgVPU
         miRK7ZiIENUke1Z/iid9UIRcaP10wE7T6zsNak1ilNbwOx/7XKxl4s3vZzSL7ph/Kb8b
         ++Y76yZAp8Tu/8PEu/JTy269aWjkX8HKa/frxOvhF6XcPJ8PRq2MC8+r9JePSKY1Kkj4
         PawQ==
X-Gm-Message-State: AC+VfDyrb7ZLgYqNe67CR/wVZVNJj6jfrpIWq50ifQloR7fHqGdryMiN
        /31cup4T48ui/d/Noz7cjdCRHKKalCHadSY74EHJLpto
X-Google-Smtp-Source: ACHHUZ50lbyQLpoZ+a2cbYlbNi0LS5cfVJBvO1C/OgnvG8PdOSSbl4o6LuLBBKSrtGToCJ5Zhyn2EOURxVI//6Yqvr4=
X-Received: by 2002:a17:906:56:b0:978:a991:c367 with SMTP id
 22-20020a170906005600b00978a991c367mr9191743ejg.2.1686590974432; Mon, 12 Jun
 2023 10:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230605103536.2427428-1-sudeep.holla@arm.com>
In-Reply-To: <20230605103536.2427428-1-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:29:23 +0200
Message-ID: <CAJZ5v0jgu5HhEb8c3u=rwTh60zwMfRi7RVkc0xALWQ_ytUDYTA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: FFH: Drop the inclusion of linux/arm-smccc.h
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 5, 2023 at 12:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The inclusion of linux/arm-smccc.h in acpi_ffh is unnecessary and can
> be even termed wrong. It is needed in the arm64 architecture callback
> implementation and probably is the leftover from the missed cleanup of
> the initial implementation.
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/acpi_ffh.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_ffh.c b/drivers/acpi/acpi_ffh.c
> index 19aff808bbb8..8d5126963dc7 100644
> --- a/drivers/acpi/acpi_ffh.c
> +++ b/drivers/acpi/acpi_ffh.c
> @@ -9,8 +9,6 @@
>  #include <linux/idr.h>
>  #include <linux/io.h>
>
> -#include <linux/arm-smccc.h>
> -
>  static struct acpi_ffh_info ffh_ctx;
>
>  int __weak acpi_ffh_address_space_arch_setup(void *handler_ctxt,
> --

Applied as 6.5 material, thanks!
