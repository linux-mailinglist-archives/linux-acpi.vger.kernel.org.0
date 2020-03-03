Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF317858C
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2020 23:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCCWXY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 3 Mar 2020 17:23:24 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46746 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCWXY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Mar 2020 17:23:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so4712602oid.13;
        Tue, 03 Mar 2020 14:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t5x1nQ/2cd3iRTnJ5bqPpexORRJrGQYgbji7W2ye2JU=;
        b=Q/JTqJByVKc5TM/1S9/y3bh5yYhRYwxtE6Mf/AOWfSo78jkQtyokH5XgC+4a+vWbXf
         ZilRRrug8sxh2+cKrR7ZphG/vCpbUWVKI7jVCx3jNsmfG8WB14JPuxBe6ZOqPLm3dh5a
         eazHzmc7ax/nl8tLxdZtRzlNH/6bE5V20OCw+SuiICzzEv9MwTOILOHiZbfjLq5YCG2O
         xszC7rHVoIcj0RZUY50WT9a9aDQnJQ+WgrsOgMOdhHFtMUiN7cZio9QsyFQMDYQcrGuN
         bZq7g1Ij03HwcNv2Xc5STp22/BLVXTHD7bR7bSvBB7Ni4btUL+R+9pffPjl5rNrIBSo9
         oZkg==
X-Gm-Message-State: ANhLgQ1hZJMlJM8Ryj0T8n9eJ4qrRzh1kRM6n+Ym/sov+Mz97FgGN8nK
        nN4PdfxkW9QmeViiRpKql810d0JrAB7deVnGWeo=
X-Google-Smtp-Source: ADFU+vuTXmKtBbImASbgUaaJFYvKWEvg0GEjaRr8XCRdkp5Pd4AeAmO6ILQy5ObMgknzgx+7IMsrcpuj/08qB4jdhGc=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr564709oiy.110.1583274203313;
 Tue, 03 Mar 2020 14:23:23 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
 <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
 <CAJZ5v0gB9yuVmPjJ_MvfT8aFpvP-X5JRsNfZn8+Mv5RwTednGg@mail.gmail.com>
 <CAJZ5v0imqwdmXzKayqs1kgHOb-mXrkr61uNxVka8J9bKca989Q@mail.gmail.com>
 <CAPpJ_efvF0XzjevA1eL3BUJqBwxRTOPLcqWKN40Azj-n1AtjcA@mail.gmail.com> <CAJZ5v0hie79+jG+3h4t5Q8r0M7E37HY-7i8ijg8DpvS0RXZSiQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hie79+jG+3h4t5Q8r0M7E37HY-7i8ijg8DpvS0RXZSiQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Mar 2020 23:23:12 +0100
Message-ID: <CAJZ5v0hwrZX4+4m-g0c2bUTHxJO=1+kenXBjLz1ChWdcxSLJbA@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 3, 2020 at 10:09 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 3, 2020 at 8:29 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
> >
> > Rafael J. Wysocki <rafael@kernel.org> 於 2020年3月2日 週一 下午7:45寫道：
> > >

[cut]

> >
> > Originally, ec_install_handlers() will return the returned value from
> > install_gpio_irq_event_handler() from acpi_dev_gpio_irq_get(), which
> > is -EPROBE_DEFER, instead of -ENXIO.  However, ec_install_handlers()
> > returns -ENXIO directly if install_gpio_irq_event_handler() returns
> > false in patch ("ACPI: EC: Consolidate event handler installation
> > code").  Here needs some modification.
>
> Thanks, I forgot about the -EPROBE_DEFER case.

The top-most commit in the git branch at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-ec-work

has been updated to take that case into account (I think that it
should be spelled out explicitly or it will be very easy to overlook
in the future).

Please test this one if possible.
