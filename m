Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908563AD09B
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhFRQnY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 12:43:24 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40628 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbhFRQnY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 12:43:24 -0400
Received: by mail-ot1-f45.google.com with SMTP id q5-20020a9d4b050000b029044ecc922d44so17626otf.7
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 09:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+62Y99wuACs/Z+XenwE5BupJlRA2Dz6XYt5PJ8mzs5A=;
        b=WFqpWPSMqMrasWgRfzzNHkzLZkObIphmzEaBsCt/uM+EW7Twz3OyDlwsPN0HEbVrG7
         ydGw/OoGUKn1KYWg9mRwyJSKys742ZGm1YjNI9YAbkP0TBTbxR43wYaKOSAesz578UEi
         0e4xn/pvKVWWigtnMiYY1fYUHZK8UQOObNlGcIGRKb6a99TcDwG9Dn/yxSZdV1s+8B0Z
         RoR7KU9fJNkSTgzYaQKwPinmRAfzIvQ6X7XCWBfc5fJGWi1SD//DGXKYuFRxs1xASfsB
         gELJLfbXqr/ahXevCnv8tjHK8hpHsMoh4ZZSZZ7/dhmrlDjRcjutdXdST5NPriXeFQx1
         lMHQ==
X-Gm-Message-State: AOAM5316I7V2XmK79htVYwKplXl6EuqfQFx+UUx6+NWNIhjT2TxrvWA7
        u/ph/5VR3u5A54pTj5AKT8kCwhqVaGd9mivwRM4=
X-Google-Smtp-Source: ABdhPJwKlD9DGYcMMvDOYFRt5/l0PMDyKaMz3Tzjb0EqhaM33HoUdzGIu4mdPk5jOmqM1tTPskZCBOpbzQSbjrO+mkI=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr2547346otm.260.1624034474912;
 Fri, 18 Jun 2021 09:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210617164212.584-1-mario.limonciello@amd.com>
 <20210617164212.584-3-mario.limonciello@amd.com> <CAJZ5v0gryewS7GFY_vBd4QAc_5hSG3PH2pZ4xyjStt7TxeCO0Q@mail.gmail.com>
 <5e5bef84-3bbb-05a1-1a28-e01a016007b5@amd.com>
In-Reply-To: <5e5bef84-3bbb-05a1-1a28-e01a016007b5@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jun 2021 18:41:03 +0200
Message-ID: <CAJZ5v0gj9Hk6h-_=Smk7Ut6i91iSmzeY8rwCAFpDkFgm0ObGCg@mail.gmail.com>
Subject: Re: [PATCH 3/5] ACPI: PM: s2idle: Add support for multiple func mask
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Julian Sikorski <belegdol@gmail.com>, teohhanhui@gmail.com,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 18, 2021 at 6:34 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 6/18/2021 11:30, Rafael J. Wysocki wrote:
> > On Thu, Jun 17, 2021 at 6:42 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> >>
> >> Required for follow-up patch adding new UUID
> >> needing new function mask.
> >>
> >> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> >
> > Your s-o-b is missing.
>
> My apologies.  If I need to spin the series I'll explicitly add it with
> all the other tags that have come through, otherwise:
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

OK

Applied as 5.14 material along with the rest of the series, thanks!
