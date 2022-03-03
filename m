Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F514CC5F3
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 20:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiCCTXI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Mar 2022 14:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiCCTWs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2022 14:22:48 -0500
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EEF19DE90
        for <linux-acpi@vger.kernel.org>; Thu,  3 Mar 2022 11:22:01 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2dc585dbb02so3673857b3.13
        for <linux-acpi@vger.kernel.org>; Thu, 03 Mar 2022 11:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=270cAaBxZU0tbjWjOsQfCYofcKwdXKDpek+iMrJUfDE=;
        b=N9DsSvMiJwwjRg4w6oehvMScY9JUGeZ/396VZ5oKOUFv7dDeVY+1RQAK6haM1Dmkl2
         YkpJoZWsMZcjmqyc8HSdej6aMw1lf2+bdXy9Jp+l7eY5qU7dM9lQyNRJxvgk/t67vnqy
         6jhQKiKKXrj/U5esSptyQOwJuyZFwz4WoQ/yPDuSDxz6BQCYehMO65okNGI0E1KxrVdO
         cS1zUSw6Um5sGLGAiJjyXqPoyee5OWnNPMNTBIu6TUsRcMUS1hz4F8+pkcjyf3YSTuQy
         egOWXmOVTS8N490XQ5ERIuFd2qR2aWjQyiOx+UpegHY2t+0NURLEQ1O5EROk/EVTorps
         dL/A==
X-Gm-Message-State: AOAM530w5X1W9oLCxOaM6kVPZXpjiTPrlgDVP3GCb0KTpCRSAhPNTC23
        l3lqDfVTdiH32KO3lIxqoVvHrYBS17zifDTF8W0=
X-Google-Smtp-Source: ABdhPJwaKLDQEN2VlPLqqhMtBqYcDtTiM72wDSon70ag8Fd4dbmFBmX1H8OyOTAkmUrxACFSl6nX0s4vJwyqJAuZaeI=
X-Received: by 2002:a81:1cd8:0:b0:2d6:b74b:5b55 with SMTP id
 c207-20020a811cd8000000b002d6b74b5b55mr36591811ywc.149.1646335320497; Thu, 03
 Mar 2022 11:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20220225190646.1045695-1-mario.limonciello@amd.com>
In-Reply-To: <20220225190646.1045695-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Mar 2022 20:21:49 +0100
Message-ID: <CAJZ5v0jE33-kKp_jRO5s4WO_H23Pwhpu6E=1fw0Ud5UL3_OaQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Avoid enabling LPI on non-ARM
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 25, 2022 at 8:11 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On some AMD platforms the platform _OSC negotiation will lead to
> `osc_pc_lpi_support_confirmed` being set and because the ACPI tables are
> populated with `_LPI` entries the kernel will attempt to enable LPI.
>
> On non-ARM kernels LPI is not supported and both
> `acpi_processor_ffh_lpi_probe` and
> `acpi_processor_ffh_lpi_enter` will return error codes.
>
> When this happens there is no recourse though; the cpuidle code does
> not switch to `_CST` mode, but rather it will continue to behave as though
> LPI has been enabled and the CPU will remain in a high power state.
>
> This patch series shifts the checks around while enabling LPI to detect
> this situation and let the system continue to set up in _CST mode.
>
> Link to v1: https://lore.kernel.org/linux-acpi/20220225031255.3647599-1-mario.limonciello@amd.com/T/#m90282a6e29c334d14b2854a27d7225fc57a22aa6
>
> Mario Limonciello (2):
>   PSCI: cpuidle: Move the `has_lpi` check to the beginning of the
>     function
>   ACPI: processor idle: Check for architectural support for LPI
>
>  arch/arm64/kernel/cpuidle.c   |  6 +++---
>  drivers/acpi/processor_idle.c | 15 ++++++++++-----
>  2 files changed, 13 insertions(+), 8 deletions(-)
>
> --

Both patches in the series applied as 5.18 material, thanks!
