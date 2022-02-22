Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2567C4BF857
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Feb 2022 13:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiBVMuP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Feb 2022 07:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBVMuO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Feb 2022 07:50:14 -0500
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC1F128658
        for <linux-acpi@vger.kernel.org>; Tue, 22 Feb 2022 04:49:49 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id y189so19232864ybe.4
        for <linux-acpi@vger.kernel.org>; Tue, 22 Feb 2022 04:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIovHm0TBH/skoMTuPHUa2kU5sd+QmaGYcINmbWWwuU=;
        b=4U1rVih9NgAvpyltTSiw7DfYZCTqe8gvEhXbNnar7XH7gy+QEE+7MXEVQ1XM4M7U6Z
         CiBfWcDfLGx9kROZbFXMz7Ygix8JZJJ76JqGsnKxMJFW1JOBj4qTl5IX/s/UO8XNN3m+
         CiMFSUbnSG2+rBUCxQm3ETMQyOW6/ACn86tuvjF0Cyb6HLmn8iP1P0ZuD1+x22Qfoy4/
         lpjss6ZcLRf38n91I4NAI/0LHZfgoHu+jSP21Lh+bRWhGkzr7dYFjLyLLMG/nFJWhu2E
         SmoGPtiPGKdxGUdd3fEerkuI7ytoroO8iGrwJP6mWczK07eGzaGDyMNLGPzx02v/LIUq
         8g7A==
X-Gm-Message-State: AOAM530vEuZeUrOFRwnYkLm9jsV0m0oRA9nXD+GsHdb5KEst+HPh05fd
        gByLitRLOJG+S0yl9FyAky9IJEbi+Xj4d5MvVolDMjuuRbU=
X-Google-Smtp-Source: ABdhPJz2Gj0kb/t6aRjHUaCjQJX9I0uCYMbjS14UXRSsr51a4kW6tPSyibVJi9zCMXUuZ0u3/QevaaFWhiaFXxMQCP8=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr22220020ybk.482.1645534188986; Tue, 22
 Feb 2022 04:49:48 -0800 (PST)
MIME-Version: 1.0
References: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com>
 <BL1PR12MB5157E2CDD68BA585C5F4CF2BE2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0ho8PHGp0gAUp5KkUstTXLyUMsaQ7wTL=8xDJtjtXjPRw@mail.gmail.com>
 <CAJZ5v0j3Ma1HuUWoTmJvZDsUtm9hi84njJxJbBZMwe76eATSYQ@mail.gmail.com>
 <BL1PR12MB5157589AB3D9BC55C6D77EB4E2389@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0jmQaeSKj7wB1Jx+cxDHVxtHzbnTKZ4TcxnydHa5NOn+A@mail.gmail.com>
 <BL1PR12MB51570F5BD05980A0DCA1F3F4E23A9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0iNoeUv0XjHWyazu5X8Y5=WXKabKtxB+bwHONgKab8fEA@mail.gmail.com> <BL1PR12MB515755CA3C1649F83ED3DF9BE23A9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB515755CA3C1649F83ED3DF9BE23A9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Feb 2022 13:49:37 +0100
Message-ID: <CAJZ5v0gCb9=W7tCtrk4gZJ+p8K7XvEaeUPZUD1c9Kgnn-u2yRg@mail.gmail.com>
Subject: Re: Regression in 5.16-rc1 with suspend to idle
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 21, 2022 at 9:14 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only]
>
> >
> > OK
>
> https://lore.kernel.org/platform-driver-x86/20220221200728.2323469-1-mario.limonciello@amd.com/T/#u

The comment in amd_pmc_resume() doesn't match the code, because the
QoS request is updated to "don't care" in there.  Also, I'd move that
update to the end of the function in case what happens in
amd_pmc_resume() interferes with idle states.

Moreover, since the "no idle states" period covers the entire suspend
time now AFAICS, I would use a small int (eg. 3) instead of 0 in the
cpu_latency_qos_update_request() call in amd_pmc_verify_czn_rtc() to
allow C1 to be entered via cpuidle during that period (which shouldn't
really hurt).  And the comment would need to be updated accordingly.

> >
> > > Long term - are you opposed to drivers/acpi/x86/s2idle.c moving to
> > drivers/platform/x86/?
> >
> > It is tied to the code in sleep.c, so I'd rather not move it.
>
> OK if we're keeping it there, would you be open to a patch exporting a symbol to
> let other drivers register another callback after LPS0?  It's somewhat similar to what my
> test hack did and might be a better long term solution if so.

Well, please send the patch and I will tell you if it looks good to me.
