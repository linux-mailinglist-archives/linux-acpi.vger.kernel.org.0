Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E4934D616
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 19:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC2RdT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 13:33:19 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:42673 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhC2RdR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 13:33:17 -0400
Received: by mail-oi1-f173.google.com with SMTP id n140so13775455oig.9
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 10:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzYMJqwz4D/0TeCNn5PNrlk3/ofhoElRVoHBiCOadAY=;
        b=EszGWaMOT8jhQiWoTJo1G/bgAnO/L5krGbBzZTycwA4mc0MmTlyTkLYfQUZrlIFHy4
         /jSeu2F8da645XIYnXpWIPLqym0Uj0EgLBGOnshXOrVTBci4jDGBnb0+3e3kkZwl7Bou
         mYRWfk1UrS7L5/GJCyWg1FqMniMAwuj2u69QdJNfPLlr/l4iVHcW50zJvKjIynY9XQeC
         DXvtu//1hw50XzykuC6vVQgfluVkro9QkhX4abmqJ7mbPx5OVNpdwQCGTJjgivg9lfWv
         z1qr6yfWeow/JbRSv2+k+AtGBb86n6pWiWaOobblLcpgHF2KSqpP2dkd8fTb8GuEQAbg
         P2tw==
X-Gm-Message-State: AOAM531+orpzYQaynsZUkbSgsaAtPeZvr+f2MdDNMcAQUcsYDzb787Tp
        xqPBrntKepXg86Nn7hq6w//0E1K2NYizDJkvCrIKIoeE
X-Google-Smtp-Source: ABdhPJy2/qa4mMBbA4F/Co8UJ9zdJKywEOf3NlSgIRrVFkbUSSzEiSKQgdlTpL2T9Gmj6QYO2K27Hi9g2xO+wj61VbE=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr152346oib.69.1617039196542;
 Mon, 29 Mar 2021 10:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210329154649.16056-1-hdegoede@redhat.com>
In-Reply-To: <20210329154649.16056-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Mar 2021 19:33:05 +0200
Message-ID: <CAJZ5v0jJrj+OjeWXJGSQfuNte90qH6pEm7cAkmKW8cVCuTFP-Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Fix _STA getting called on devices with
 unmet dependencies
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 29, 2021 at 5:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 71da201f38df ("ACPI: scan: Defer enumeration of devices with
> _DEP lists") dropped the following 2 lines from acpi_init_device_object():
>
>         /* Assume there are unmet deps until acpi_device_dep_initialize() runs */
>         device->dep_unmet = 1;
>
> Leaving the initial value of dep_unmet at the 0 from the kzalloc(). This
> causes the acpi_bus_get_status() call in acpi_add_single_object() to
> actually call _STA, even though there maybe unmet deps, leading to errors
> like these:
>
> [    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
>                [GenericSerialBus] (20170831/evregion-166)
> [    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
>                (20170831/exfldio-299)
> [    0.123618] ACPI Error: Method parse/execution failed
>                \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)
>
> Fix this by re-adding the dep_unmet = 1 initialization to
> acpi_init_device_object() and modifying acpi_bus_check_add() to make sure
> that dep_unmet always gets setup there, overriding the initial 1 value.
>
> This re-fixes the issue initially fixed by
> commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to initialize
> ACPI_TYPE_DEVICE devs"), which introduced the removed
> "device->dep_unmet = 1;" statement.
>
> This issue was noticed; and the fix tested on a Dell Venue 10 Pro 5055.
>
> Fixes: 71da201f38df ("ACPI: scan: Defer enumeration of devices with _DEP lists")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied as 5.12-rc material, thanks!
