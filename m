Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB94103152
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2019 02:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKTB5m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 20:57:42 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:44094 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKTB5m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2019 20:57:42 -0500
Received: by mail-qk1-f172.google.com with SMTP id m16so19883773qki.11
        for <linux-acpi@vger.kernel.org>; Tue, 19 Nov 2019 17:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=jDLYL+zBe4kreijHVGC8TNgtqSKIWy0jlSmvFFF1wow=;
        b=XE3eYNarcfPSYm9f+g9Svrep/XeafIOM6otEnnSlC2RmjZGnO3N/k496JOpdpWzMB/
         HHVsh6HuL7MBfdqEWd80aeHe8TMnsc2WnXvWuZ1I7R1B+JvoKa0MrrQRZ2K7vQSBdfTU
         CsCGSQPTDV9/bkYMAE9dOGSGd7Iv+27Kd74U9MFKxa3/zkXE1Q9Dd99CeALch/N1GG76
         rGG0ah/Im8iCmQMxvKmXqmm4alUxEKwyrNa+ZoWxoNp/ae1g3il95HJLQ1jxKi80ItqH
         MQt1BTIIlWZkcv+EvQpPyrmSuklqPYvo/u2kpLy/OhJaJnjqon5TD3vnH4GZLFbdJ1H4
         PmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=jDLYL+zBe4kreijHVGC8TNgtqSKIWy0jlSmvFFF1wow=;
        b=il3PF+HXJVImmeI7eNhdeZg8MaSvc8sm08274AP3PO/z9NBLP3ePr11m3KY0+mj+ex
         vJQiIbjVdGy8XtM+jSPIY8zeBagOActY1/7BXM1HUbf4VyYae1QIAyNTFYjw5cMojVzE
         fEql6R1RxfZUfndRp1U6/ClcByH4Z8jVtLNnjdXs8lEt/5bUSN/hc+qy5G7Bk6+0Pfew
         biIa+gFFyyKa2MWDMM2DHA8uTDv2cnRYPUzPLV4tnN8Mzlcs70+ttKW+GLlw5YL7YX94
         KlgB+7v+jK4mTGz+v3imukQjbT4QE/Ldhxzv8N3zMYi5CiWcpy1Y3PG8VhbLsuljHrWx
         Sqvw==
X-Gm-Message-State: APjAAAW9pYuEHWH63aXGftzl4E81C42fptpK9nZOup7FrbHPrTp29E3e
        EhzGd++IhB5lWfzKb/tBHbR/JtTLWsvaPJwZpHSN3IFQ
X-Google-Smtp-Source: APXvYqxGGyIXJ2afy9maPHp0aKxd0uhUW+6mA0F6Rw5OkLcYe0amj160qW/Gxu/ndP9Pqtl5ER8it9mgZtdysvm9tQs=
X-Received: by 2002:ae9:e501:: with SMTP id w1mr263813qkf.271.1574215061060;
 Tue, 19 Nov 2019 17:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20191119233047.5447495C0DE7@us180.sjc.aristanetworks.com>
In-Reply-To: <20191119233047.5447495C0DE7@us180.sjc.aristanetworks.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Tue, 19 Nov 2019 17:57:30 -0800
Message-ID: <CA+HUmGi_7b1Ywt4dqhqkDds4La=fuAmGaYLGOZHS1+4qrMLaCQ@mail.gmail.com>
Subject: Re: Kernel panic when reading /sys/firmware/acpi/tables/data/BERT
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Francesco Ruggeri <fruggeri@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2019 at 3:30 PM Francesco Ruggeri <fruggeri@arista.com> wrote:
>
> If I run
>
> for ((i=0; i<10; i++))
>         do for ((j=0; j<1000000; j++))
>                 do cat /sys/firmware/acpi/tables/data/BERT >/dev/null
>         done &
> done
>
> I see this panic in 5.3.11. I see a similar panic in 4.19.84.
>

The issue seems to be that acpi_os_map_cleanup does not execute under
mutex_lock(&acpi_ioremap_lock), so more than one process may end up
freeing the same map.
I will prepare a patch.

Francesco Ruggeri
