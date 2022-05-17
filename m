Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D752A5CA
	for <lists+linux-acpi@lfdr.de>; Tue, 17 May 2022 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243523AbiEQPOi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 May 2022 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243212AbiEQPOg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 11:14:36 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363704BB93;
        Tue, 17 May 2022 08:14:34 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id s23so19505665iog.13;
        Tue, 17 May 2022 08:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbFG0j0OOb8L9zhN2w48Y4xmkuGMCVJKy6dA52/T7lY=;
        b=Oe2oZ4fRNldQ2RrA3y4TuzVMwHgFBnJJFsDcII6BiLBtCcecpKJkYEtaYUVNX1jRxp
         RqOJ6pPxt+Rhc6xgGHxQaQSo8EOV8lUc4wtJbYXmAEsIOcV7RwcZSGjWOAK00lhvUTan
         eW43CY5IGdWWCuldiSwSXkWHHFm+Ew2vYIcY0LiAit/Y7wrGBq6gOcxU51BWchULamXO
         bdaiWk2D4/xFIXEPgy4CJdEICEtXfNcFBAaeps7P8s4gPx0hnLA2Bna1CQRfvkNv4Ga+
         ShbYa5smC7CHTmV2T+EXjsmu5xWUpIxXT8QstKF9rWC+Fa6MKnC/cUy3pVyCtcrcamgp
         1Y4g==
X-Gm-Message-State: AOAM533zT/fbiJZu/oRqguWHfT+J+alEDblKxXSINUtinWtu03KTAoAF
        iO/zQY0GhzIO4pJ+SngNCu2CYV3Zy+v15JuqAVk=
X-Google-Smtp-Source: ABdhPJw5xQpiFWoBi/dY9A7l3qiBSYaoqRi7wvq1y38zlaEpSiq91Cpu4sxBMJ0hvEtSAzij38P5pYCiRnixLE2uvw0=
X-Received: by 2002:a05:6638:3289:b0:32e:2c45:93b5 with SMTP id
 f9-20020a056638328900b0032e2c4593b5mr6150196jav.96.1652800473303; Tue, 17 May
 2022 08:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220505015814.3727692-1-rui.zhang@intel.com> <20220505015814.3727692-8-rui.zhang@intel.com>
In-Reply-To: <20220505015814.3727692-8-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 17:14:22 +0200
Message-ID: <CAJZ5v0jt1OND_d08mC0TC1LZ-JGANDY5fiDmH5RUfdtRk1vZFw@mail.gmail.com>
Subject: Re: [PATCH 7/7] rtc: cmos: Add suspend/resume endurance testing hook
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, kvalo@kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        merez@codeaurora.org, mat.jonczyk@o2.pl,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Len Brown <len.brown@intel.com>
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

On Thu, May 5, 2022 at 3:58 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Automated suspend/resume testing uses the RTC for wakeup.
> A short rtcwake period is desirable, so that more suspend/resume
> cycles can be completed, while the machine is available for testing.
>
> But if too short a wake interval is specified, the event can occur,
> while still suspending, and then no event wakes the suspended system
> until the user notices that testing has stalled, and manually intervenes.

If the wakeup event occurs while still suspending, it should abort the
suspend in progress, shouldn't it?  But the above implies that it
doesn't do that.

If this is fixed, wouldn't it address the issue at hand?
