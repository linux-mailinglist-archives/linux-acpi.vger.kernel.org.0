Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A026B39DED1
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFGOdg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 7 Jun 2021 10:33:36 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:37555 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGOdf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 10:33:35 -0400
Received: by mail-oi1-f170.google.com with SMTP id h9so18237118oih.4
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 07:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8w+RC5UdRCIRdcC/p1hMB8aCbqm3HDEpWzlzanh/fBE=;
        b=ZHEUvUcblNl1oANcY+GC3q1jgY9LkL1ZvhC8CY8IL+9w3dYku+6jzvfP4dBcZknnij
         CYNH5Erm7sz0xMljdvkxrVq54Ew258jw0V2RLzxAMhjy6MFOGqEjnvONQNoJ2/jfyeuu
         +w0V2v1j42tXMR38sZ5r2bgX1zZ+v8xnDbySaHlvSyII7wU5wQgIM6Y1DQWBb/QJ8tdi
         8Sx/FQFqst7/cZ0Kf534gTYzB8AuRvZdm3vZq5+nJo3LpzAInHFRnJ472qsGm5PZDl9L
         h5kpkkJmhAsC6SWjFAz+oKoLqNYMeiqK97lPE1nPtl6ihkrPmHKcVxbU9FtMWN/AcRSq
         KVkA==
X-Gm-Message-State: AOAM532O0CIPl3/cmtT5XVoGf88Luo5GCbcc0ih9/deNRjqgjgucnHz5
        wQq2hTeFBTPDpU5uTVmwa+8X1+PGudsGLluMYRs=
X-Google-Smtp-Source: ABdhPJy1+P7DIZWy5QLrzAhiLnkKrsfeTeNmluq1GF6r6l4sIfgzDNlre4MJLkHAooNQEyOTWs1f4I+hBX3YRkdlaAQ=
X-Received: by 2002:aca:650d:: with SMTP id m13mr3412883oim.157.1623076290321;
 Mon, 07 Jun 2021 07:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210603171201.801071-1-kw@linux.com> <20210603175657.GA2128066@bjorn-Precision-5520>
In-Reply-To: <20210603175657.GA2128066@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 16:31:19 +0200
Message-ID: <CAJZ5v0hBSQubNK4yrYYuPDQMwXeE=-HFQmM6+CJgf65+rLi0AA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: sysfs: Fix a buffer overrun problem with description_show()
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lance Ortiz <lance.ortiz@hp.com>,
        Joe Perches <joe@perches.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 3, 2021 at 7:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jun 03, 2021 at 05:12:01PM +0000, Krzysztof Wilczyński wrote:
> > Currently, a device description can be obtained using ACPI, if the _STR
> > method exists for a particular device, and then exposed to the userspace
> > via a sysfs object as a string value.
> >
> > If the _STR method is available for a given device then the data
> > (usually a Unicode string) is read and stored in a buffer (of the
> > ACPI_TYPE_BUFFER type) with a pointer to said buffer cached in the
> > struct acpi_device_pnp for later access.
> >
> > The description_show() function is responsible for exposing the device
> > description to the userspace via a corresponding sysfs object and
> > internally calls the utf16s_to_utf8s() function with a pointer to the
> > buffer that contains the Unicode string so that it can be converted from
> > UTF16 encoding to UTF8 and thus allowing for the value to be safely
> > stored and later displayed.
> >
> > When invoking the utf16s_to_utf8s() function, the description_show()
> > function also sets a limit of the data that can be saved into a provided
> > buffer as a result of the character conversion to be a total of
> > PAGE_SIZE, and upon completion, the utf16s_to_utf8s() function returns
> > an integer value denoting the number of bytes that have been written
> > into the provided buffer.
> >
> > Following the execution of the utf16s_to_utf8s() a newline character
> > will be added at the end of the resulting buffer so that when the value
> > is read in the userspace through the sysfs object then it would include
> > newline making it more accessible when working with the sysfs file
> > system in the shell, etc.  Normally, this wouldn't be a problem, but if
> > the function utf16s_to_utf8s() happens to return the number of bytes
> > written to be precisely PAGE_SIZE, then we would overrun the buffer and
> > write the newline character outside the allotted space which can have
> > undefined consequences or result in a failure.
> >
> > To fix this buffer overrun, ensure that there always is enough space
> > left for the newline character to be safely appended.
> >
> > Fixes: d1efe3c324ea ("ACPI: Add new sysfs interface to export device description")
> > Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
>
> Looks right to me.  I think the critical part of the commit log is the
> fact that utf16s_to_utf8s() may put up to PAGE_SIZE bytes in the
> buffer, and we add a newline *after* that.
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Applied as 5.14 material, thanks!

> > ---
> >  drivers/acpi/device_sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index fa2c1c93072c..a393e0e09381 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -448,7 +448,7 @@ static ssize_t description_show(struct device *dev,
> >               (wchar_t *)acpi_dev->pnp.str_obj->buffer.pointer,
> >               acpi_dev->pnp.str_obj->buffer.length,
> >               UTF16_LITTLE_ENDIAN, buf,
> > -             PAGE_SIZE);
> > +             PAGE_SIZE - 1);
> >
> >       buf[result++] = '\n';
> >
> > --
> > 2.31.1
> >
