Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEA6D85F5
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Apr 2023 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjDES1u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 5 Apr 2023 14:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjDES1t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Apr 2023 14:27:49 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784823596
        for <linux-acpi@vger.kernel.org>; Wed,  5 Apr 2023 11:27:48 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id er13so102337545edb.9
        for <linux-acpi@vger.kernel.org>; Wed, 05 Apr 2023 11:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680719267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uD1j74jvFT+9Cl5CeOCl9yNrzGFgl62Sp6Az0seqGP0=;
        b=gztm4AKMYSbOv910ZyU210Jlc3DbfsCZyURsg8ENTEt1/qD0v4vHJU8uzSedHypbOf
         RVrGvG3f6JBsMuXPtW/CrZIsdCPtieXyZ9yEjdKVFvDCdBiKDwWJzEo2ia10aKXAgc5u
         cwbTX37N7KyDwDOt4YoSPYpz8dUp86rSE3NogsvF4XEJkdwnODXlsQci/6n0OAZKvv0Y
         6Lnk7IHZ68htE3rVMHeLdAHidGXh27YXuiqg2+mADg4ZZe1DrMd4AQgWOhnfC4uI8LH3
         asWcmmpZ6APa8A6WpNd2Tim0U2x/YCtLDZHuU4QhkkeDRzbvxCZ8IfvC/7getr5vrowK
         6lYg==
X-Gm-Message-State: AAQBX9eT+ZhqNYTmEFRoOqDqTHtgFzc7e3oFzyD0Yuqhy4JsLxECarb3
        maImKUG7kwsgxnVjxuuzJReXPBBGNFdg9DDUbUc=
X-Google-Smtp-Source: AKy350atjlzHWCuTbi9mCIJIWN9IgDQJHUzrvKWX/0NN2ayHxoPWbjrNQxk07LOaoo5CljONAP2f81Yb8nwEwnvHaWg=
X-Received: by 2002:a17:906:6d55:b0:947:c623:2c84 with SMTP id
 a21-20020a1709066d5500b00947c6232c84mr2052989ejt.2.1680719266996; Wed, 05 Apr
 2023 11:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230404110251.42449-1-hdegoede@redhat.com>
In-Reply-To: <20230404110251.42449-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Apr 2023 20:27:35 +0200
Message-ID: <CAJZ5v0jNjj2RhJo59hc+u7LOksq5kNPvYurnPnHF_OR_0zy18A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ACPI: video: Fix missing acpi_video# devices on
 some systems
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Dadap <ddadap@nvidia.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On Tue, Apr 4, 2023 at 1:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> Here is my v2 of this series, changes in v2:
>
> - Add Mario's Reviewed-by to the series
> - Fix typo in commit-message for 5/6
> - Drop no longer used video_detect_force_none() in 6/6
>
> This patch series consists of 2 parts:
>
> 1. Fix missing acpi_video# devices on some systems, currently in kernels
>    >= 6.1.5 and >= 6.2.0 acpi_video# backlight class devices will only
>    get registered (by default) when a GPU driver asks for this by calling
>    acpi_video_register_backlight(). This is causing backlight control to
>    be missing on some systems.
>
>    Patches 1-4 fix this and ideally these should be send to Linus for
>    an upcoming 6.3-rc# release.

So I've applied these for now.

Note that I generally hate to do things like this so late in the
cycle, so this generally is an exception AFAIAC.

> 2. Now that the dust has settled a bit on the backlight refactor we can
>    do some further cleanups. This is done in patches 5 + 6. Note that
>    patch 5 depends on patch 2.

And I will queue up these 2 for 6.4 later.

Thanks!
