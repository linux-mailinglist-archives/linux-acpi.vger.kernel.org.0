Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67148045
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2019 13:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfFQLLx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jun 2019 07:11:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39449 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfFQLLw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jun 2019 07:11:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so5952392otq.6
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2019 04:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2SYsxnd78Hvl13uSih8O+0r8/7xSAtk+oSusdBmKzw=;
        b=XcFAvMy4p0UNBsUYhD3zy9k2j4KosOvgqtMA6WalIdHP2khuqKaVG/LnlJsk7VQsyd
         0tqp1kCXsGGqnm56XxeChCLKQM2UhbTMz2qJrxZSZJYxz1saT6H88KRmwmB7zTtCElka
         lshfYc8iva+4W0DOrmWXdH86DO212o5/3T0vWYI97UXOtn4kbZuNcQirAGEXRYkm5HX9
         6dumXLE0lDnoen1yowCXdVNP93e4ZewPEe8/P5IJHwJUZBcMm/3o61OstjXb1D85eVAb
         HzLOFcc+lBgb/m17t3u1cCeSM16QJGDku0W1n2AzHrIyWusDt448LOVBzk8bgk03J+XK
         6I/A==
X-Gm-Message-State: APjAAAXpaAMjJ+UNlYb5dSLpXCRFG2CpR9nGap8dF2VullGOG59uiBE7
        t6FX2X32jwgqe9JkST3mRGpN3W7y39WZP+Vwe1M=
X-Google-Smtp-Source: APXvYqxRnT1t79Bb9zvbYiWaR4EzAZj5+gI46fqqmMZC1qNnvAQIKISUOi7dVSxIDN2UVaSz5xQBKmCyBotsMBYBlCk=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr2033216oto.167.1560769911981;
 Mon, 17 Jun 2019 04:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <1560769335-62944-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1560769335-62944-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Jun 2019 13:11:40 +0200
Message-ID: <CAJZ5v0jyi-ZkcDU=+GJm5LxMGX36ce=a_j169A_7Ph2AG8_C+w@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update my email address
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 17, 2019 at 1:04 PM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> The @linaro.org address is not working and bonucing, so update the
> references.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

How do you want this to go it, via ARM or ACPI?

> ---
>
> v2: update the .mailmap to redirect the older email address which
>     is suggested by Marc.
>
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 07a777f..fd9b497 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -81,6 +81,7 @@ Greg Kroah-Hartman <greg@echidna.(none)>
>  Greg Kroah-Hartman <gregkh@suse.de>
>  Greg Kroah-Hartman <greg@kroah.com>
>  Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electrons.com>
> +Hanjun Guo <guohanjun@huawei.com> <hanjun.guo@linaro.org>
>  Henk Vergonet <Henk.Vergonet@gmail.com>
>  Henrik Kretzschmar <henne@nachtwindheim.de>
>  Henrik Rydberg <rydberg@bitmath.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496c..2fed10f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -364,7 +364,7 @@ F:  drivers/acpi/fan.c
>
>  ACPI FOR ARM64 (ACPI/arm64)
>  M:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> -M:     Hanjun Guo <hanjun.guo@linaro.org>
> +M:     Hanjun Guo <guohanjun@huawei.com>
>  M:     Sudeep Holla <sudeep.holla@arm.com>
>  L:     linux-acpi@vger.kernel.org
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> --
> 1.7.12.4
>
