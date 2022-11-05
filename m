Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D7661DCDD
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Nov 2022 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiKESDe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Nov 2022 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKESDe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Nov 2022 14:03:34 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12940BF5A
        for <linux-acpi@vger.kernel.org>; Sat,  5 Nov 2022 11:03:33 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id e15so5001672qts.1
        for <linux-acpi@vger.kernel.org>; Sat, 05 Nov 2022 11:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3Qu4YyFde1q61kBKcifgOatPmMPyq5Eee9DU/i3vkI=;
        b=wcTH4Vz+CZ1mUA8E0s5sRMp14LAGSHEoY53AGphVxeQG4LVW/TWO1Rn9Iqb9w3bDKa
         nTKxAPuF61N+lG7gXCvNcXpLpGUJh6VQijLU1TnvkzLejQSUbE7ccOrbHTaCHjfyQMQF
         dmOVhIh61KvhMryCJjwNZqPuJSwqcalg7v3tgTUyELKlavkf+uYJmYuE1fCx14pvAr+L
         W0VaxNg7Mqvaed4Ekj7ve001soJ7m2Us5Ul7Tjnuu2tRB0tfJlBwSFYNq1rB18nwyzK2
         Ga0GifyP/g2MCBq5tfGZDvnYr7WiKji2SsuVVS1ZVRA1UTMFRgEx7aFB1faOdB/eQs2L
         WBnQ==
X-Gm-Message-State: ACrzQf19cFhBLtqg1ZpjjFGYUAYpFQSyyAvZnLftCa6BtIhTHvvQen/k
        UkPRN5kxVl37DglJO5BRy2jvZCpHTB/geCX09cKOE0vE4kA=
X-Google-Smtp-Source: AMsMyM4iiRDz5qwuYxLyrt4xiPdWvthtPmgkvSBdTJcPwEUteyzmZQEC2IoAIL+qEeQRNni3aC8B1oYG4jjtYl467HI=
X-Received: by 2002:a05:622a:4c07:b0:3a5:27ec:6dd3 with SMTP id
 ey7-20020a05622a4c0700b003a527ec6dd3mr25912211qtb.411.1667671412216; Sat, 05
 Nov 2022 11:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221104212108.73537-1-hdegoede@redhat.com>
In-Reply-To: <20221104212108.73537-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 5 Nov 2022 19:03:18 +0100
Message-ID: <CAJZ5v0h8FvqLwTixFALfOT2xbgiSqbT3XCMCbubwad4fHpK0hQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: video: Fix backlight regressions in 6.1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 4, 2022 at 10:22 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> Here is a series of patches to fix known (and likely also unknown)
> regressions caused by the backlight-detect refactor landing in 6.1.
>
> This builds on top of the earlier Chromebook fix which went upstream
> through platform-drivers-x86.git/fixes. as such I believe it would
> be best for this series to go upstream through the pdx86 tree.
>
> Can you please give your Ack for merging this through the pdx86
> git tree?

Sure, feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to these patches.

Also note that I'm going to drop the previously applied

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=6a377205da554cec45c8fd1cd8395030b448de31

from my tree.

Thanks!
