Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC70278D7E
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgIYQCX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 12:02:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42640 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYQCX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 12:02:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id x14so3263042oic.9
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 09:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZZkyNv/Q80uR6iY6cI6ytzJ9Zi95ztjXdPC9ueuc1E=;
        b=GSdtXuzZpHWA6yqJWv3rC+zt2vsDA/ZGNLsnmOiuRaq6wqqEhwl0iQPkWe8j7KQlBK
         sVi3pl5CTlM3RImmBSEI5uR8lDvEtCOMt/jsGQncjWCuamZdJucUlLB6u9ZKfG5uDo0R
         7s+ug7QCI24ZFM/O2z7iUjsNNV18gCpGbE8wvhjEbgRvkOYgE22gabrjzYsZuErw0Yjq
         KjjwiVblp5BifhiRj9MTuFLDr00sjgjNn/78IEdDoLKmSvLUjX5ZTnsLpzaEPMllaAZh
         adrBQqD1EBqiuTsFZdTOqFVXPCd9MJjq6vkbIvktBnUdzFO6dkkfwax18p6RYjqQSLzL
         BHfA==
X-Gm-Message-State: AOAM531dpYqZTVUTuxkIfYPGdtvtAFar9KRd8aoxBREK/MpJko01W5dV
        kdYUm8hUFZn74M4O/DH9KKz3vx1aNdO3WEFVaD4=
X-Google-Smtp-Source: ABdhPJxxvilp2h2YM6KiJLPRAemj4qo8GYbVsy7zwG77PTtGLI+O4p12zXC4jkG1lGbPDttByhQ8IpOlpF3hZDIipNE=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr18674oid.110.1601049742288;
 Fri, 25 Sep 2020 09:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <1600044290-12475-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1600044290-12475-1-git-send-email-tiantao6@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 18:02:11 +0200
Message-ID: <CAJZ5v0hroFMPs0-ju4msnPo3Zj99DUs9CGh9QoMwPaKGx=aH0w@mail.gmail.com>
Subject: Re: [PATCH] PNP: Fix duplicate included pci.h
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 14, 2020 at 2:47 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> linux/pci.h is included more than once, Remove the one that isn't
> necessary.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/pnp/quirks.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
> index de99f37..ac98b99 100644
> --- a/drivers/pnp/quirks.c
> +++ b/drivers/pnp/quirks.c
> @@ -226,8 +226,6 @@ static void quirk_ad1815_mpu_resources(struct pnp_dev *dev)
>         dev_info(&dev->dev, "made independent IRQ optional\n");
>  }
>
> -#include <linux/pci.h>
> -
>  static void quirk_system_pci_resources(struct pnp_dev *dev)
>  {
>         struct pci_dev *pdev = NULL;
> --

Applied as 5.10 material with some subject and changelog edits, thanks!
