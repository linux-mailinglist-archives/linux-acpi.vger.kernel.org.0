Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84A14C0B2
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 20:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgA1TLX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 14:11:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37995 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgA1TLX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jan 2020 14:11:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id l9so11416802oii.5;
        Tue, 28 Jan 2020 11:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNNOCuQSs0b+Bg9qnijy+wvnc+l1Z6weLpF7DGLouRM=;
        b=Xti8kK76P/zodGTLf+rzOVXy3Dkt6ja8A4anmVg9HPbmSBuI2Nx5C3iekwOOxZQXx6
         ISdGt0c3PoTbKtGguE567IZIAauS8phQ75S4XHzRGjTmhB9pJxT6cbUJfeQk3umYHXAI
         p9puzmFubXIFEzPaMn6okpsNPuX4dk/DGFHbbh9gDF+s8VtZ9QVv92BQlSq3rRo9xkOQ
         VZvV2/1s6brPVk2D+lnF4QmamdGNduXupfI9DiWU5X/ps9gguYhSnuSMHdLf2BOiXjZ5
         y2tUGFx1RVCXPmZkh/SI9MdHnAsn403KiyP497XjzMAWsm9a7B7H8sL0Og0Xhe2m8xXJ
         EHlQ==
X-Gm-Message-State: APjAAAWI1Krpij/0iN/yUhjWLLZLV8YQfVt/ZDGA7ShrI2No4MuEg5ht
        6EUu5D/nB6c9+A1CiIvKeo6cDudwukemm4ayHMiGBg==
X-Google-Smtp-Source: APXvYqyswnl/kbFGgEGbLCI3EBtRyojOzXbLz9Znqzg8153YI37HpR+JrjHT8F8lwk9IU9HCjAHw7g+KBjUJi0ckAy8=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr4002306oig.103.1580238682900;
 Tue, 28 Jan 2020 11:11:22 -0800 (PST)
MIME-Version: 1.0
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <CAOesGMiCVSvL8H+haLoz=xyiX1CxBSRL_pbCgx-DLhN+5xRn9g@mail.gmail.com> <4c6462e3-e368-bd9f-260f-e8351c85bcc2@huawei.com>
In-Reply-To: <4c6462e3-e368-bd9f-260f-e8351c85bcc2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jan 2020 20:11:11 +0100
Message-ID: <CAJZ5v0jN5ED_U2s06--8Rx-S4g-wuVxw9YPR12_WL3TnV81_Ag@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     John Garry <john.garry@huawei.com>
Cc:     Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 28, 2020 at 7:22 PM John Garry <john.garry@huawei.com> wrote:
>
> On 28/01/2020 17:51, Olof Johansson wrote:
> > Hi,
> >
> > On Tue, Jan 28, 2020 at 3:18 AM John Garry <john.garry@huawei.com> wrote:
> >>
>
> Hi Olof,
>
> >> Add a generic driver for platforms which populate their ACPI PPTT
> >> processor package ID Type Structure according to suggestion in the ACPI
> >> spec - see ACPI 6.2, section 5.2.29.3 ID structure Type 2.
> >>
> >> The soc_id is from member LEVEL_2_ID.
> >>
> >> For this, we need to use a whitelist of platforms which are known to
> >> populate the structure as suggested.
> >>
> >> For now, only the vendor and soc_id fields are exposed.
> >>
> >> Signed-off-by: John Garry <john.garry@huawei.com>
> >> ---
> >>   drivers/soc/Makefile       |   1 +
> >>   drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 103 insertions(+)
> >>   create mode 100644 drivers/soc/acpi_generic.c
> >>
> >> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> >> index 8b49d782a1ab..2a59a30a22cd 100644
> >> --- a/drivers/soc/Makefile
> >> +++ b/drivers/soc/Makefile
> >> @@ -3,6 +3,7 @@
> >>   # Makefile for the Linux Kernel SOC specific device drivers.
> >>   #
> >>
> >> +obj-$(CONFIG_ACPI_PPTT)                += acpi_generic.o
> >>   obj-$(CONFIG_ARCH_ACTIONS)     += actions/
> >>   obj-$(CONFIG_SOC_ASPEED)       += aspeed/
> >>   obj-$(CONFIG_ARCH_AT91)                += atmel/
> >
> > Based on everything I've seen so far, this should go under drivers/acpi instead.
>
> soc drivers seem to live in drivers/soc (non-arm32, anyway), so I
> decided on this location. But drivers/acpi would also seem reasonable now.

Any reasons for not putting it into drivers/acpi/pptt.c specifically?
