Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB045B3C87
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Sep 2022 18:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiIIQBM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Sep 2022 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiIIQBL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Sep 2022 12:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681B1BD772
        for <linux-acpi@vger.kernel.org>; Fri,  9 Sep 2022 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662739267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkilgVlqA2kdgmhZQ0iReqC0oZWmONGkCnLgx6F5YI4=;
        b=eape8K73ZXyvYRy5FycUbxm1SD1+5DWria3y1r4BtWIjCmWLhrl/7vHvjd5IFx4ksS6PO/
        CV0qJP8WT+2DOUrD+INjZzjdx8BwEQ6McStTtoha1Et6HcZb8zOiaWQl0Zo6cmT5Qs09uE
        fUDEBM2zv4U1xyHssxklkX8SU9iKrWo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-ild_9W8bOaeu3NiLyuG9qg-1; Fri, 09 Sep 2022 12:01:06 -0400
X-MC-Unique: ild_9W8bOaeu3NiLyuG9qg-1
Received: by mail-ej1-f71.google.com with SMTP id gs35-20020a1709072d2300b00730e14fd76eso1252879ejc.15
        for <linux-acpi@vger.kernel.org>; Fri, 09 Sep 2022 09:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MkilgVlqA2kdgmhZQ0iReqC0oZWmONGkCnLgx6F5YI4=;
        b=liocRX0k7NN47sNnAD2ZunsyccFbGxMpb7cVHsEJ36eOnClVEeN4Oa95kMh2MvQvbG
         7ptHmEv0rW9b1cAUQCTPnffNtaePbhwXd4slL7f5mMNYbU4RXSuNEVZH/NdVsU2ZE+RP
         NOUsxhprQcD3KWa7fp6kC++OY/h9hkw5SqNzcdK72lB+LktsKZeSnjlrEqaNwVqa6Y+i
         KHbVPbIF5Ye+lc9yb8y5txVY1ih3hNTIP6PkqxNf17D4Z/pUT9ISmu/GZw0yh3n6GvDD
         3fSXq5DtET2b8Sn4kLoPR9qsJPu3F2t1yAruLtuLnr97dmmUkTkswuTJvgMYmRYr6e9F
         YvoQ==
X-Gm-Message-State: ACgBeo13k/CLTjd9ZCkb6eLn4jiVGlXUqJXNbsbUgt/aOfXC8flVOgCj
        fGMduxS6yE1cvNvRkHkPmbXxW3A2t2FMWb/Gssnp2ADkAEkC1yIuTBV9aohkQVsVO/gV1FV9VXG
        d9t2A7jmIePJ/PjBzvuuHDA==
X-Received: by 2002:a05:6402:43c4:b0:43b:c5eb:c9dd with SMTP id p4-20020a05640243c400b0043bc5ebc9ddmr11996990edc.402.1662739264695;
        Fri, 09 Sep 2022 09:01:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR72OcWlz0Jbmm54CZLQ/xuPVPgg8tPeaEAnwi8Y5sOr7fgQ3xJUzER4kEnNijxbdDbaF4EzCw==
X-Received: by 2002:a05:6402:43c4:b0:43b:c5eb:c9dd with SMTP id p4-20020a05640243c400b0043bc5ebc9ddmr11996963edc.402.1662739264420;
        Fri, 09 Sep 2022 09:01:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id q16-20020aa7cc10000000b0044e84d05cd8sm640965edt.0.2022.09.09.09.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:01:03 -0700 (PDT)
Message-ID: <75e632e6-07df-5b97-d9d7-c4b60a5a3b9b@redhat.com>
Date:   Fri, 9 Sep 2022 18:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/4] Add some extra debugging mechanisms for s0i3
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
References: <20220829162953.5947-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220829162953.5947-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On 8/29/22 18:29, Mario Limonciello wrote:
> Recently there have been reports of problems where the system consumes
> too much power after certain interrupts occur that would notify the
> kernel of some event but those events aren't marked for wakeup.
> 
> These problems have been root caused to the timing of the kernel moving
> the cores into ACPI C3 relative to other events from the previous wakeup
> not being settled.  Linux will more aggressively move the cores into C3
> for s2idle than Windows does for Modern Standby.
> 
> To aide with debugging this class of problems in the future add a new
> set of optional debugging infrastructure.
> 
> Mario Limonciello (4):
>   ACPI: s2idle: Add a new ->check() callback for platform_s2idle_ops
>   platform/x86/amd: pmc: Add defines for STB events
>   platform/x86/amd: pmc: Always write to the STB
>   platform/x86/amd: pmc: Add an extra STB message for checking s2idle
>     entry


Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
>  drivers/acpi/sleep.h           |  1 +
>  drivers/acpi/x86/s2idle.c      | 14 ++++++++++++++
>  drivers/platform/x86/amd/pmc.c | 32 ++++++++++++++++++++------------
>  include/linux/acpi.h           |  1 +
>  include/linux/suspend.h        |  1 +
>  kernel/power/suspend.c         |  3 +++
>  6 files changed, 40 insertions(+), 12 deletions(-)
> 

