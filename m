Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF222C570B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 15:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbgKZOYx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 26 Nov 2020 09:24:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41700 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390200AbgKZOYx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2020 09:24:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id h3so2430609oie.8;
        Thu, 26 Nov 2020 06:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ma7jF4FBZDmd9R/twbwrp0/mysqZHGyLK1RbuJEdcLc=;
        b=JKjoJauJsv4CjgzlaAhpsbXVcjzrwsOGEWXF9tX8ktwe5iv8zKDB/FfHqgt3t5j4vp
         sCWBSX+nmCqcQcAiKAgoOk06uj6O2fMzAhvY+XrYbvk0/yMAtKZJjUXMlMY5t39jjKji
         6lqYaTnwg+TfjCbFTVnv441lMP9+MLXH6UU1VwvA5AxHg0LEeichzV2MKKI2i4NkG2Yn
         GAo08C14/PshR+WJBa1O8ARPQP6M69RJcUxzdyWAh6UC6sHL10IPCbXs+RmvqXS2ZSf3
         rrmhcVAuzoWQ8QXfdIffs7JvPZPfhei5JgStn4tJs8a21C5kg9r/kauhUjUxK6ThkWNB
         hCNg==
X-Gm-Message-State: AOAM533NCKC4t29ey7CCx+ii12aluhN7iXy4YZprkoD2+bfxMzMm15kI
        Ce53JlgfJisgmpHFRoystZ9N8pkbQWOy4dDJvJY=
X-Google-Smtp-Source: ABdhPJygVJjgAQbh2bP1pMP91cmxdaW/EtMLmawmto/nu5guiks3OcLAy0gHnQ9MiYdUJYc8dZ8wlrj/A1J1Qjt2d+I=
X-Received: by 2002:aca:6541:: with SMTP id j1mr1377761oiw.157.1606400692179;
 Thu, 26 Nov 2020 06:24:52 -0800 (PST)
MIME-Version: 1.0
References: <1606324841-217570-1-git-send-email-john.garry@huawei.com>
 <1606324841-217570-3-git-send-email-john.garry@huawei.com>
 <CAJZ5v0j=H4NVdvdrC6nCd36zEA2n1xpiRSgKN-OV6+GLasA+Jw@mail.gmail.com> <7b9e1500-f520-24a8-548e-d4952dab028c@huawei.com>
In-Reply-To: <7b9e1500-f520-24a8-548e-d4952dab028c@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Nov 2020 15:24:39 +0100
Message-ID: <CAJZ5v0hnF_fWEoGQ8+ricGakB9TLsgNoaK664tEh4yoFdi1gFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] ACPI: Make acpi_dev_irqresource_disabled() public
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 26, 2020 at 9:49 AM John Garry <john.garry@huawei.com> wrote:
>
> On 25/11/2020 17:43, Rafael J. Wysocki wrote:
> > On Wed, Nov 25, 2020 at 6:25 PM John Garry<john.garry@huawei.com>  wrote:
> >> To allow the platform device to "put" an irq, make the function to reset
> >> an ACPI companion device irq resource public.
> >>
> >> Signed-off-by: John Garry<john.garry@huawei.com>
> > I'd rather move it to kernel/resource.c as it is not ACPI-specific and
> > its only connection to ACPI is that it is used in the ACPI resources
> > management code.
> >
>
> Hi Rafael,
>
> That's ok, but we could also just put in include/linux/ioport.h as a
> static inline as it’s so small. Not so important, I guess.
>
> And I'm not sure how this part could be merged, so maybe I can do as 2x
> patches now - 1. add resource.c function 2. remove ACPI duplicate. - so
> we have the option to merge ACPI part later if it makes things easier.

That would work too.

My point really was that exporting that function from ACPI was rather confusing.
