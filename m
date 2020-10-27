Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8929C6E0
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 19:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827455AbgJ0SYd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 14:24:33 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:45621 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1827330AbgJ0SYc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 14:24:32 -0400
Received: by mail-oo1-f65.google.com with SMTP id j41so463141oof.12;
        Tue, 27 Oct 2020 11:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK/7DVUQkZfUgaeA5ixT5hPkE29Eu8FLcSkV/JAkh7A=;
        b=gE9EPrdKHu3GonDGsmfVfCi8Y5gRB4Qsn09KA7PVwLUuwQIGi17BBNpWEZAlrFymnr
         zsz//YwI8PE5R+i4K8r3JmxR83dRMW9eL31/ej19aajYhuu9TBt0bNJn4nM+7fVX7PJX
         84XBCxRAn1oUBgU+i4EPsMapu5eMxbcfSSZJHDfXL9I7fYm2ioG+bvr0LodNJWgcuJAe
         QhGCovJbtN2wfNVYmXwwx7OP+6jDo6Ap8HieDUaTaYw+N0cWcCMurq5qFvGWWK5jkF4U
         HsjW/O9kwci0XpkZ6wrQ7pmRvyS9RKqhL5uc9eFzFXtMhR6rSR+dnY9zyT+LmWpY+8CQ
         EOmg==
X-Gm-Message-State: AOAM531EQK3d8ZxdQTW3FT/Tm7AmoOf10t+MfuTHXv0cxAV9UTYlxUsD
        CjBJsM4qdZ3Bnwa5+0empXwftHoH8sivGSLsz5Q=
X-Google-Smtp-Source: ABdhPJztV7IBCmVLmFevDpdsKnKPMUOF8vFqYsOXZ2vQQC8OeuUIRS2fgbc8VMXrKYJP1sSr5PRI+JF7z7eQrp0KPX4=
X-Received: by 2002:a4a:dc0d:: with SMTP id p13mr2747758oov.2.1603823071429;
 Tue, 27 Oct 2020 11:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603469755.git.mchehab+huawei@kernel.org> <1e3d69e0890a36303f4c804ae9c523df9f098d6a.1603469755.git.mchehab+huawei@kernel.org>
In-Reply-To: <1e3d69e0890a36303f4c804ae9c523df9f098d6a.1603469755.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Oct 2020 19:24:20 +0100
Message-ID: <CAJZ5v0jDbSMVJHeCn1tkTp8jjUP8PS1F7HCGPtTbaZKG+PFpTg@mail.gmail.com>
Subject: Re: [PATCH v3 24/56] PNP: fix kernel-doc markups
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 23, 2020 at 6:38 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> It sounds that there were function renames. Update the kernel-doc
> markups accordingly.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/pnp/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
> index 3bf18d718975..a50ab002e9e4 100644
> --- a/drivers/pnp/core.c
> +++ b/drivers/pnp/core.c
> @@ -51,7 +51,7 @@ static void pnp_remove_protocol(struct pnp_protocol *protocol)
>  }
>
>  /**
> - * pnp_protocol_register - adds a pnp protocol to the pnp layer
> + * pnp_register_protocol - adds a pnp protocol to the pnp layer
>   * @protocol: pointer to the corresponding pnp_protocol structure
>   *
>   *  Ex protocols: ISAPNP, PNPBIOS, etc
> @@ -91,7 +91,7 @@ int pnp_register_protocol(struct pnp_protocol *protocol)
>  }
>
>  /**
> - * pnp_protocol_unregister - removes a pnp protocol from the pnp layer
> + * pnp_unregister_protocol - removes a pnp protocol from the pnp layer
>   * @protocol: pointer to the corresponding pnp_protocol structure
>   */
>  void pnp_unregister_protocol(struct pnp_protocol *protocol)
> --

Applied as 5.10-rc material, thanks!
