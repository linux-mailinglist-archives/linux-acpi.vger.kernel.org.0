Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9522CA95B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 18:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLARQT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 12:16:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44469 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgLARQS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2020 12:16:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id f16so2344159otl.11
        for <linux-acpi@vger.kernel.org>; Tue, 01 Dec 2020 09:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zc+Lt5p1hWao+e3PNU0nffQgpPx9Uuspo+RlTzWsoNI=;
        b=snNXjtuVIc34KjtCewEtoEY0nTgcH44WalXwvZXegn+NevYFxNw02EFmuGvnGTj5VP
         U06GnM0DzjXHBFzAXFcMQn1eaD6LtnIcxOwtDnafQKMnc/gB3h/fRrDrseTvlf38/a6K
         8jqf/btT1pbW3PSsOhREJYB2dsHhvvmgVMvCF93aPtsWArO9QEwh1KVSWDo58dHauXvP
         3SY50PzZkdjlpNVBwzQR4BUTvJZ29fMBk1Q7fubdDf20dKeEUYnsJMbaWDvToNLmsMCi
         MBUP73ox0sQHvMEn1gCx4VCsje5nJZCBTapsxP5sw2b7tkXYk1kRjmoDyCKgTdXCMHxL
         UHcA==
X-Gm-Message-State: AOAM531744ZQL1gxAFlmhumMipBpB+Z9dQNrOv19T8dkrByzTZs4P9f2
        bBOUr6fuXsRg+9rqfaFqrQL5o9mL5BYKp3+9nvs=
X-Google-Smtp-Source: ABdhPJzsaraLmcgR3vy9QgN/lfIVVhAGV0JhluHngvpiizP/cVlY0Fa7Q+IQF9yzoROLBKEbvXXiau1AEwYVvmsv0+k=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr2589333ota.260.1606842938011;
 Tue, 01 Dec 2020 09:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20201130192048.3093726-1-erik.kaneda@intel.com>
In-Reply-To: <20201130192048.3093726-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Dec 2020 18:15:26 +0100
Message-ID: <CAJZ5v0iOYzD54DTi62diO3BYM9guHmb0qLBK+HU_NXCeySahEw@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPICA version 20201113
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 30, 2020 at 8:47 PM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This patch series contains the linux-ized release of ACPICA version
> 20201113. For Linux, the most notable change is a fix in a memory
> leak that occurs when evaluating _CID as well as handling orphan _REG
> methods for GPIO OperationRegions.
>
> Bob Moore (2):
>   ACPICA: Add 5 new UUIDs to the known UUID table
>   ACPICA: Update version to 20201113
>
> Colin Ian King (1):
>   ACPICA: Remove extreaneous "the" in comments
>
> Erik Kaneda (2):
>   ACPICA: Add function trace macros to improve debugging
>   ACPICA: Interpreter: fix memory leak by using use existing buffer
>
> Hans de Goede (1):
>   ACPICA: Also handle "orphan" _REG methods for GPIO OpRegions
>
>  drivers/acpi/acpica/accommon.h  |  2 +-
>  drivers/acpi/acpica/evregion.c  | 54 ++++++++++++++++-----------------
>  drivers/acpi/acpica/nspredef.c  | 10 +++---
>  drivers/acpi/acpica/nsprepkg.c  | 38 ++++++++++++-----------
>  drivers/acpi/acpica/nsrepair2.c | 39 +++++++++++-------------
>  include/acpi/acpixf.h           |  2 +-
>  include/acpi/acuuid.h           |  5 +++
>  7 files changed, 77 insertions(+), 73 deletions(-)
>
> --

All applied as 5.11-rc material, thanks!
