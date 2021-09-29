Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7317541C44B
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Sep 2021 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbhI2MJo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Sep 2021 08:09:44 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:37557 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244801AbhI2MJo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2021 08:09:44 -0400
Received: by mail-ot1-f53.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so2557841otv.4;
        Wed, 29 Sep 2021 05:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOD2JGNZk8v+mRUWU6qCnLPxFm8GKCd1aSiNdnVC1UI=;
        b=FHQYjSxzrwaYU1HDc0bhjTGseA+05QJLQBAnmIu9ZSS+OZgNQo8YcU5Y2aTgUNKuZB
         lUnF3S8q2YT1UYdKEXcG8kiQHK8mN5xhLxYAjpB+CCAE93BWIgY+LiHa+SskcduJCSAd
         X2J09mC+VuQNpZYy+nCU6W8S9kLMbV3AXN9hZmqbSM/tVXDiV27I9WSWN7cLwtbZySKk
         M3iS/Zdo1YJny8zF4H7cVRhbxDOmq6cECFLHZQV/dyQGOmjdJ8qGFM4uKTORnlesPWj5
         RH+gPf2Cyy2VlgNAJAlf9jBPCsC355ansJ8lDjkB6YerZriqgauYeAOrak1ND6+3ihj4
         HGvw==
X-Gm-Message-State: AOAM530hltOVEEXPa/9A18qho6Q2PmiPjT9VKhzpDaGfVNtEvspkBIyn
        mX68Kkq9eIHLP0FzbgY7HbNNZJN0ARvWneO+XEM=
X-Google-Smtp-Source: ABdhPJxMVCyh+TLDn+QjO1ONDrrdMlbRvA0UkC+rzTXfgidJEc2fjRlS01Q/3WWpPPHZkX8qGU1k9FzfRNmCVT4nNBM=
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr10087198otu.86.1632917283115;
 Wed, 29 Sep 2021 05:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210929104625.1112192-1-qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20210929104625.1112192-1-qtxuning1999@sjtu.edu.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Sep 2021 14:07:51 +0200
Message-ID: <CAJZ5v0jSpoEeL9vevWatiGJ6qbbaxSAoiPH1D4RaT1q0c7Sxmw@mail.gmail.com>
Subject: Re: [PATCH] acpi/processor_idle.c: Fix kernel pointer leak
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 29, 2021 at 12:56 PM Guo Zhi <qtxuning1999@sjtu.edu.cn> wrote:
>
> Pointers should be printed with %p or %px rather than
> cast to 'long' and pinted with %ld.
> Change %ld to %p to print the secured pointer.

In this particular case, id->driver_data represents a proper integer,
not an address, although technically it is a pointer data type.  It
shouldn't be printed with %p and the patch is incorrect.

>
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/acpi/processor_idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index f37fba9e5ba0..a9f4ab072583 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -73,9 +73,9 @@ static int set_max_cstate(const struct dmi_system_id *id)
>         if (max_cstate > ACPI_PROCESSOR_MAX_POWER)
>                 return 0;
>
> -       pr_notice("%s detected - limiting to C%ld max_cstate."
> +       pr_notice("%s detected - limiting to C%p max_cstate."
>                   " Override with \"processor.max_cstate=%d\"\n", id->ident,
> -                 (long)id->driver_data, ACPI_PROCESSOR_MAX_POWER + 1);
> +               id->driver_data, ACPI_PROCESSOR_MAX_POWER + 1);
>
>         max_cstate = (long)id->driver_data;
>
> --
> 2.33.0
>
