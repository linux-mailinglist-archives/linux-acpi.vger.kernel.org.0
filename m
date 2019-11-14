Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB2FCA01
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 16:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfKNPfl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 10:35:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43313 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfKNPfk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 10:35:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id l14so5185754oti.10
        for <linux-acpi@vger.kernel.org>; Thu, 14 Nov 2019 07:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oE+kdPYfv4VNWybGbNk3Lh/oWidkpNIB5RysE/WGAAs=;
        b=J1fIZ5y/n4sndDLcbA3TY2ccE2zErqf+2xFsmMoiuVTwMVyUnW0R/KRAR8KrNbydQJ
         v5KBbKLby/pByA+mv7DAd5NscSGrfUX5CF2edwI0nmgdcuP1SWlbtmJ8JPiR3LdJvgQ1
         VaV48I7kD1aN7V8tHCTeEoeaG6mwEUHInpIXeZ2MFn+AdqWIp+EgNjJ9zrBkq8Q06tGe
         2h/7CDbfUbUf0cpoA4F2SCW+zuU+YAXEydIFpIR7aaIBZd7ZqAUujSMQp1+q+sqQP7CI
         qxtC/SmuxGXhr8oQrPJ/5gKWunTx0AWMlWKJjbJiX63v+TmYY8/LD7fy3lpF91T8GP4d
         dxIg==
X-Gm-Message-State: APjAAAUmEE1PR0BJ0lsgdXn1PIkGSrJ4VcGryg6l9RZlo8ds05bzVZxv
        FfqgL93xYyxEFtGh4k6Mo5/c1KNJMNyG5Dj+Cqs=
X-Google-Smtp-Source: APXvYqy4TWO5mjwzvI5NOulEbyXKTaAs0MK73LzupYJOIx1LsSopUyYf6whDnv39kG2dyCvVFwGCe6qMHLcODMV/Ye8=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr7175772otn.167.1573745740212;
 Thu, 14 Nov 2019 07:35:40 -0800 (PST)
MIME-Version: 1.0
References: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
 <CAJZ5v0iZ9pR8ou95q2kQnawWWmuOqpnEivRVx4H12sa4FGveSg@mail.gmail.com> <cd3bd414-50c8-4751-8370-6a17b3b338f6@www.fastmail.com>
In-Reply-To: <cd3bd414-50c8-4751-8370-6a17b3b338f6@www.fastmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 16:35:29 +0100
Message-ID: <CAJZ5v0hN2PrFUQkWtTB2DfDVtyGubS+iPRU7WA1wM--1R+N7kQ@mail.gmail.com>
Subject: Re: how to disable the "button" kernel module?
To:     Bruno Dantas <kernel@dantas.airpost.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 3:50 PM Bruno Dantas <kernel@dantas.airpost.net> wrote:
>
> > Why exactly do you want to disable it?
>
> I'd like to disable it because I want my laptop's lid switch state to be 100% invisible to userland--as if the lid switch were broken and always in the "open" state.

I wonder why?

Anyway, you can try to echo the lid device name to
/sys/bus/acpi/drivers/button/unbind to unbind the button driver from
the lid device.

That name should be something like PNP0C0D:00 (note that you need to
escape the colon when in a shell).
