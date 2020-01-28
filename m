Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621F614C2F5
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 23:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgA1WbA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 17:31:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34417 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgA1WbA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jan 2020 17:31:00 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so13675414otf.1;
        Tue, 28 Jan 2020 14:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iX2V9T24wEabMeqlN5Cam7uCTsFLrLNLsDKY3xVe4h4=;
        b=W158dTfG1Kag4hB030mDOlfLaMBoFl0ivZTNeoxoAjhtPESVt272+iwTZp6By+XMo5
         K+Bldk80KimNMr/atmJTiju0kZqfSHrZvG2ZSNwy3VstY3Y5q4VXRE0HcSGl/h3covXJ
         nwaLJkK8Ngw1ixR4li+kAKYnYDVpk8xRqKQM9hnDNaZqnBrqtjWyKR5WKScikvEOYlom
         bLu5EWsYN+iaVHVjKgx8PsZbMV0OCCDBCfQ28g+98wz3FbLFy6OM4l2UelNIwQbgPNrO
         l8oAAFXm5DpP7o/JSdxD9JEPojH6xF9PI9DxW5Zt6yyeTzQvpcYzM7/YbuQokGE5FBNA
         ariw==
X-Gm-Message-State: APjAAAUjmqblSRxQTXAoy9YrU2AG4rRdIju+xWO0nhls2PQKGgFduK/0
        bXBPus2/I5pCWEFGLYINzAZCC2sVsCvi2T8VqEM=
X-Google-Smtp-Source: APXvYqwGxKHqpIKx0p0HtWL/2AntxlhWrFJg6cZnB3vFs65wxLJRTCzWHYF5xUPi3qJz56SLgzHqLM6lwO6EnUxqlT4=
X-Received: by 2002:a9d:7559:: with SMTP id b25mr2289937otl.189.1580250659687;
 Tue, 28 Jan 2020 14:30:59 -0800 (PST)
MIME-Version: 1.0
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <CAOesGMiCVSvL8H+haLoz=xyiX1CxBSRL_pbCgx-DLhN+5xRn9g@mail.gmail.com>
 <4c6462e3-e368-bd9f-260f-e8351c85bcc2@huawei.com> <CAJZ5v0jN5ED_U2s06--8Rx-S4g-wuVxw9YPR12_WL3TnV81_Ag@mail.gmail.com>
 <b6cc7edd-fbb9-ed7a-412e-0d75e4c8ec2b@huawei.com>
In-Reply-To: <b6cc7edd-fbb9-ed7a-412e-0d75e4c8ec2b@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jan 2020 23:30:48 +0100
Message-ID: <CAJZ5v0jbh_zU8getDO2VdsQ7qzjnwkTXjsNd+j+j=K4PPDO05w@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Olof Johansson <olof@lixom.net>,
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

On Tue, Jan 28, 2020 at 8:28 PM John Garry <john.garry@huawei.com> wrote:
>
>
> >>>>
> >>>> Signed-off-by: John Garry <john.garry@huawei.com>
> >>>> ---
> >>>>    drivers/soc/Makefile       |   1 +
> >>>>    drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
> >>>>    2 files changed, 103 insertions(+)
> >>>>    create mode 100644 drivers/soc/acpi_generic.c
> >>>>
> >>>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> >>>> index 8b49d782a1ab..2a59a30a22cd 100644
> >>>> --- a/drivers/soc/Makefile
> >>>> +++ b/drivers/soc/Makefile
> >>>> @@ -3,6 +3,7 @@
> >>>>    # Makefile for the Linux Kernel SOC specific device drivers.
> >>>>    #
> >>>>
> >>>> +obj-$(CONFIG_ACPI_PPTT)                += acpi_generic.o
> >>>>    obj-$(CONFIG_ARCH_ACTIONS)     += actions/
> >>>>    obj-$(CONFIG_SOC_ASPEED)       += aspeed/
> >>>>    obj-$(CONFIG_ARCH_AT91)                += atmel/
> >>>
> >>> Based on everything I've seen so far, this should go under drivers/acpi instead.
> >>
> >> soc drivers seem to live in drivers/soc (non-arm32, anyway), so I
> >> decided on this location. But drivers/acpi would also seem reasonable now.
> >
>
> Hi Rafael,
>
> > Any reasons for not putting it into drivers/acpi/pptt.c specifically?
> > .
>
> I don't think so.
>
> One thing is that the code does a one-time scan of the PPTT to find all
> processor package nodes with ID structures to register the soc devices -
> so we would need some new call from from acpi_init() for that.

Or an extra initcall or similar. [Calls from acpi_init() are basically
for things that need to be strictly ordered in a specific way for some
reason.]

Why would that be a problem?
