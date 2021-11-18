Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B814559B6
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 12:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbhKRLMu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 06:12:50 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:33765 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbhKRLLf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 06:11:35 -0500
Received: by mail-ot1-f49.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso10378013ote.0;
        Thu, 18 Nov 2021 03:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWgYNrUmMljpo7Y7JutxYTC8Cvzbn+L/BGR+AUjM/C8=;
        b=OVqQQNK+0V2fom0nNKQgjN8rN8mO8c7EvmYbk1tXz69Gym/Ya9qrPqaXwHmM51rwkp
         FPAcV9krvwjZI4nSZ2eBBYvDZSWNykYG8w1sK++RqnFu34XBK1AV285vJ8Dw60QErJ+9
         uiHp7a/wz2EYDNM97TQchtrrwsDZscgsMtJLJO3qasbi4/H6szoz2B4cHgbHlxv7p8P7
         Lj1bi+BxS01g5/Jvy6edTMf5qXd7dXdD1XQ1cOxPQ+5xY88fMdDBdk4UYsr1a8H77JhI
         I77DWXvs36mmHds3ICyneklp2XLmn8ihbq46V9xokqE98xfkzPW5ZxRXiJUsRjjhk1bd
         ATqw==
X-Gm-Message-State: AOAM532G/z0RSkJbVcjekTVQriKR8WqgUI+akOOYHpg/9z3PEi7Comug
        o0o2eeVmGN54K+nHuV0qHJ0eafL//yQ84vBOOjo=
X-Google-Smtp-Source: ABdhPJz8fgTSjmX7h3ucHvoP5LfNQ/bF+MNlcYGYKMlggPTQ8sXQJrBDTCIS1XUfJQXT5WiujgVQF+HLNFJdxsyBOWw=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr20183159otg.198.1637233714146;
 Thu, 18 Nov 2021 03:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20211117220118.408953-1-hdegoede@redhat.com>
In-Reply-To: <20211117220118.408953-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 12:08:22 +0100
Message-ID: <CAJZ5v0hDWN4cKh+ZcB__wrWHChm=FjhwvCShXzseECQOFotM6w@mail.gmail.com>
Subject: Re: [PATCH 5.16 regression fix 0/5] ACPI: scan: Skip turning off some
 unused objects during scan
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 17, 2021 at 11:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
> unused objects") adds a:
>
>         bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
>
> call to acpi_scan_init(). On some devices with buggy DSDTs calling
> _PS3 for one device may result in it turning off another device.

Well, I'm going to revert this commit.  I'm sending a pull request
with the revert later today.

> Specifically the DSDT of the GPD win and GPD pocket devices has a
> "\\_SB_.PCI0.SDHB.BRC1" device for a non existing SDIO wifi module
> which _PS3 method sets a GPIO causing the PCI wifi card to turn off.
>
> I've an earlier, in some ways simpler, fix for this here:
> https://fedorapeople.org/~jwrdegoede/0001-ACPI-scan-Skip-turning-off-some-unused-objects-durin.patch
>
> But the sdhci-acpi.c MMC host code already has an older workaround
> for it to not toggle power on this broken ACPI object; and this
> simpler fix would require keeping that workaround. So then we would
> have 2 workarounds for the same issue in the kernel.
>
> Thus instead I've come up with a slightly different approach which
> IMHO has ended up pretty well.
>
> Patches 1-3 of this series are this different approach and assuming
> they are considered ok must be merged into 5.16 to fix the regression
> caused by commit c10383e8ddf4 on these devices.

So I'll have a look at these and if they look good, we can do that
instead of the problematic commit in 5.17.

> Patch 4 removes the now no longer necessary workaround for the same
> issue from the sdhci-acpi.c code. Once 1-3 are merged this could
> also go to 5.16 but 5.17 is fine too.
>
> Patch 5 is a small bonus cleanup to the sdhci-acpi.c code.

Thanks!
