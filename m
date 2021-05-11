Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F089137AC87
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhEKRAa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 13:00:30 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34349 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhEKRAa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2021 13:00:30 -0400
Received: by mail-ot1-f51.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso18127537ote.1
        for <linux-acpi@vger.kernel.org>; Tue, 11 May 2021 09:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMoWaIPB7ufClU6biMUlSQVdw+5zQrdgVAQ/W25T/08=;
        b=m3Ab2C1abbtU0GzCHZs4vMxoMjIncnH9wQFpqPfSd0X5qc+4y7Cex4HL5NxV053yXl
         h5KFc/uc/4Q2ieCuG1y8DeRK1KOuAOFgk/dqr7ywM6X8xpEyz7AoajBVWOQ0/+A+kx4a
         uKtS9AsxeZUwHUUT4PCrdkJJQ+bcVlNw02Kuk4nPUcf9gRbhEKx5yoBDRB+SutYl19b9
         718GN49A7M5SdoZqftUkiyNGxK1jT753uy2D8c6M0pTRka6XZFQnsf0SFduDIKvYb74y
         DbCOvsifJ/Wfq30oW5cf54L4ccaB/CTKgP79ZBRwj7FZn59gHKsuBfqwcnXS2rpfImFS
         /+nw==
X-Gm-Message-State: AOAM531eoUwVzye3win7IaMBda27UAi8eAuDjm9ifrXIp6NbJ/xPkg3V
        ChTDctEIckBNC7WOEFBVe5Ge4mrYlsQwEkzdrwI=
X-Google-Smtp-Source: ABdhPJz6y5oH21DeKgorJgqPba2qeZH/DfCGaI6H1G+5tg9h27bJ9KHpBZjC4hqQOy2ihR4lZug1d7RGftFW9f9EQHQ=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr27222045otd.321.1620752363651;
 Tue, 11 May 2021 09:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210511025024.10083-1-mario.limonciello@amd.com>
 <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com> <BYAPR12MB26937BC445598D567C964734E2539@BYAPR12MB2693.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB26937BC445598D567C964734E2539@BYAPR12MB2693.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 May 2021 18:59:12 +0200
Message-ID: <CAJZ5v0jRSUV7_MN6Ru0R6tNq11Qe7Swv3Wy4sfZYbrn0H8r-tw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 11, 2021 at 5:21 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> > Well, if find_deepest_state() looked at the target residency instead
> > of the exit latency, this would work I suppose?
>
> Unfortunately I don't think this would help - from an OEM system the following
> target residency values:
>
> # cat /sys/devices/system/cpu/cpu0/cpuidle/*/residency
> 0
> 2
> 800
> 700

But this means that not just S0ix, but cpuidle in general doesn't work
correctly on those systems and the latency quirk doesn't help here.

Well, it looks like the driver needs to sort the C-states table, then.
