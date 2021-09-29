Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696A741C71C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Sep 2021 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344528AbhI2Oqy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Sep 2021 10:46:54 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:45860 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344616AbhI2Oqx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2021 10:46:53 -0400
Received: by mail-oo1-f49.google.com with SMTP id y16-20020a4ade10000000b002b5dd6f4c8dso813864oot.12;
        Wed, 29 Sep 2021 07:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RT4RSQcjF/lr1PC0ah9CB0w9YTR+h1wKajpzR8xHnIk=;
        b=b62ppoGvo4kq1pPr3NuCu9CwowbENvSJ+JvuvqzCbRST9u2d+T9DHrPtONcx/JzriI
         tp7qYQ3ppLA8deeo/3xPjDbr6ltbxzpYR5NRIjUpftHuQfmn4ZuN16lWA7mZkoVHfVJa
         LroKby50EdPVaYx3kglevzCL93AcZIF89RtQGtnLxENJs4LCu+UpbJz3Qbu0C/wnMpJf
         yxZIQ3e9B4tlovgtKrfTPHRyyWCL5WfY3usn416v8nTozI8BFgck2MmIS9i2au/Nzc6I
         L+V8sW2KuO5sOkdie3Un2kM1YuaiitasnH+tvmwMKQDOg+6Zb4IySAHfqYX6d0NLAXu1
         l2og==
X-Gm-Message-State: AOAM531DQtcdsupPEHLu2eCbdGazZMGNUoAWspYTQQYkNL3fIal7fgkm
        ZkwF9L4B4DULLy4Ri0yric1VCqgzpFgUvfKFgFo=
X-Google-Smtp-Source: ABdhPJx5OI/plqamNTLFGs+ZYoz4EPJp763qZ2WfuoSYi0/EBqmzxWYpXpBk9+SNIxls7MS00WtuXwN/bSraJXfXH8c=
X-Received: by 2002:a4a:c292:: with SMTP id b18mr248301ooq.64.1632926711722;
 Wed, 29 Sep 2021 07:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210922133116.102-1-richard.gong@amd.com> <CAJZ5v0jpOzNS5TFdJNXdxa_p2D_5QQMwwRcSMe8JmjOaTjR8gg@mail.gmail.com>
 <3b26b179-69ba-64a2-807e-8d7609fbeb6e@amd.com> <CAJZ5v0g+VcGz65s=iu4fzWmkHS7Z0Dx9tMpDgFZ46f3U4jRkoQ@mail.gmail.com>
 <7b8a7c2a-027f-16c9-0258-d91917c39bac@amd.com> <52fd74a5-c0cb-0dcc-b5da-fc84651c2253@amd.com>
 <28f9ca92-85c3-9c3e-6685-2c35a757e616@oracle.com>
In-Reply-To: <28f9ca92-85c3-9c3e-6685-2c35a757e616@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Sep 2021 16:45:00 +0200
Message-ID: <CAJZ5v0jnFEx5OGyUEFzc72FBW_aVWs=dZDmyt4-0HmArhdEuog@mail.gmail.com>
Subject: Re: [PATCHv1] ACPI: processor idle: Allow playing dead in C3 state
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "Lazar, Lijo" <lijo.lazar@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Gong, Richard" <richard.gong@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 29, 2021 at 4:09 PM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
>
> On 9/29/21 1:37 AM, Lazar, Lijo wrote:
> >
> >
> >
> > Apologies to barge in. This is regarding the patch you added years back - https://www.spinics.net/lists/linux-pm/msg27003.html
> >
> > Do you recall why C3 was not considered for offline/play dead scenarios in the original patch?
>
>
> Not really. Perhaps processors from that time (at least AMD ones) did not support C3?

OK, thanks!

I guess the only way to find out is to try it and see then.
