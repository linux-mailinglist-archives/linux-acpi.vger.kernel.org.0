Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09EF629C97
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Nov 2022 15:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiKOOt1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Nov 2022 09:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiKOOtY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2022 09:49:24 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989A91116F
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 06:49:23 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id o13so7491224ilc.7
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 06:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPWe0KF7eq8DKxnolJjuTFcFJKXT1LcGdHCFJWm+kGc=;
        b=rAXYjJIS6QrGlgrkqdRBzkh34MsGpWJdggMBEd47L1mdYkrJK3eLJqyhvI2zSDTvmi
         K0N0ZpUJ3+Hj08jXEA5TA+ZgODEGlhGiutv42FCeuMYqpujCWZg8Eh9zvIWR4YHZ3YFx
         FE+OJKtCYmJV+mwVjsSaxZ8NGurysdVCDDCb4pfckE52lzlqYPJRHc3oPZnBSj60ghEZ
         JuIGwl4NIgiFMyT5iauHGH/BZGxKtxUg20dyz2+2eTD6MzPJoJ3jYwVmB3mNp4bTXOlF
         fsCF1dma4icz/n1gIBkbJ9FhWb6x3IWy9okBsTqh+TU6M+vFYswwRB0x1RWBxhlgywO2
         KL3Q==
X-Gm-Message-State: ANoB5pm5qOysZZgk5KmzT/htAhjTHhuj7kQnaMe3RZ3VAsKLaS2oYs31
        Ev0awsFZDxsDo8Dea51hMm0dDhvcygtOj36cZnY=
X-Google-Smtp-Source: AA0mqf4n6NhevE10+NgUdHzuYIaVktWoaQl2j1BW3tZ3ciSaG28yT2X2Ch6vnJb0iizHLPNaqGla5D+p5AAENN8uKoQ=
X-Received: by 2002:a92:c907:0:b0:300:f44c:bfeb with SMTP id
 t7-20020a92c907000000b00300f44cbfebmr8301143ilp.106.1668523762883; Tue, 15
 Nov 2022 06:49:22 -0800 (PST)
MIME-Version: 1.0
References: <e0f06714-5a49-a4e6-24e6-c4103c820819@alu.unizg.hr>
 <9ef3674afd370050b86a68e44c97e4f0257f1adf.camel@linux.intel.com>
 <bd1f0d2a-d456-92cc-ecca-23e480aea4b1@alu.unizg.hr> <e5d3d561bb3a9c68bc903cfc35c27629a4a9225c.camel@linux.intel.com>
 <d034dbbc-613c-1a5e-df64-d0251453c8eb@alu.unizg.hr> <6c2f47c8-d6b5-074a-4c8f-e9cd04f62ef4@alu.unizg.hr>
 <180b1a4fb9cf78c8905f275e0373e009224d4639.camel@linux.intel.com>
 <78e347e9-c8b1-f228-ca32-0ad6186a6285@alu.unizg.hr> <a4457f46-72c9-f9b0-b87a-cb3dd5cd066f@alu.unizg.hr>
 <CAJZ5v0jfHtOXDFUFYj8EOGMT74iWfkQqEW3L2D2dZv6Y1jFSrw@mail.gmail.com> <1523587b-9c31-ebed-3f32-28235452d025@alu.unizg.hr>
In-Reply-To: <1523587b-9c31-ebed-3f32-28235452d025@alu.unizg.hr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Nov 2022 15:49:12 +0100
Message-ID: <CAJZ5v0j3_nX2eUvG5naoTVCayfUUqOoNB0NMQQhCQDcv5P8DWw@mail.gmail.com>
Subject: Re: BUG: bisected: thermald regression (MEMLEAK) in commit c7ff29763989bd09c433f73fae3c1e1c15d9cda4
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 15, 2022 at 3:40 PM Mirsad Goran Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> On 28.10.2022. 20:25, Rafael J. Wysocki wrote:
> > On Thu, Oct 27, 2022 at 8:20 PM Mirsad Goran Todorovac
> > <mirsad.todorovac@alu.unizg.hr> wrote:
> >>
> >> Re-sending compressed attachments to fit into the size limit.
> >>
> >> On 27. 10. 2022. 20:03, Mirsad Goran Todorovac wrote:
> >>> P.S.
> >>>
> >>> Forgot another useful thing you've mentioned: please find attached the
> >>> dmesg output.
> >>>
> >>> Good luck!
> >
> > I'm wondering if the problem is reproducible with this patch applied:
> >
> > https://patchwork.kernel.org/project/linux-acpi/patch/20221019073443.248215-1-chenzhongjin@huawei.com/
>
> Dear Rafael,
>
> Thousand apologies. Your email was still bold in my Thunderbird, which
> means that I failed to notice it and open it.
>
> The patch applied successfully to commit c7ff29763989 and it is
> currently building and still has to undergo torture tests.

Actually, that fix was problematic too.

I would recommend testing with this one applied instead:

https://patchwork.kernel.org/project/linux-acpi/patch/2669303.mvXUDI8C0e@kreacher/
