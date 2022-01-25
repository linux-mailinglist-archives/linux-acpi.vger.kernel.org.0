Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073F149B6F1
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jan 2022 15:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580693AbiAYOvt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 25 Jan 2022 09:51:49 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:43577 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580430AbiAYOtt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jan 2022 09:49:49 -0500
Received: by mail-yb1-f173.google.com with SMTP id g81so62397069ybg.10;
        Tue, 25 Jan 2022 06:49:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zgx4gBR0L+57aNQSWEp0GvsGWvVZvYtZgO+7WGNB4q0=;
        b=LctuK5YlVHzSmsLoiR7nhhF5+3EvRQ4aiJz2pjWsBBchg0BMNhGtVupiR4L7CkN+w8
         IuSERE6663mBZ0JAppnAOjD+J0P3PmtzXHgwvArCkMYYQhYJW5JFp2KKOp+LQNOyODKo
         z+QmMG7EXXnks9qwQSLWWxYNNeKu7oIrQZsziVlpUURW/3XXmj7FnZJlk9fa4Vk2z3oR
         NdOr+C4z9p6qkrh6v11fHnkZGS8ySUVpggKF15E1HoMY0IhWwaE6BMea72rCla59hggw
         fFGSuVmRVRqq18tQvymX1ceLQT4+byIFiwlkDAmO5L7Rfr5RU8jv8A/Zl4naaAeYqkVf
         VKlQ==
X-Gm-Message-State: AOAM532cO2wuAY7xnx4BcJXdo4JBAkpJ3F6I0pm6brvRF/tv27HONMnZ
        VtGe7DHWmcQsPALHrspdA303GFNI0i7SBLKuAcY=
X-Google-Smtp-Source: ABdhPJyg9YYefj34XDUGWt3IBNgqsWQzu0auukw1l8VDw8HGwC0stDvtak/M5bHUKsDMMgYhybNNmdMJAQPhnGB7X8Y=
X-Received: by 2002:a25:1bd5:: with SMTP id b204mr33391054ybb.552.1643122186838;
 Tue, 25 Jan 2022 06:49:46 -0800 (PST)
MIME-Version: 1.0
References: <1b871357-2231-336d-099c-cdccae03f837@boldcoder.com> <82f254a1-c765-0a87-f017-8c07c8ef07cd@boldcoder.com>
In-Reply-To: <82f254a1-c765-0a87-f017-8c07c8ef07cd@boldcoder.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jan 2022 15:49:34 +0100
Message-ID: <CAJZ5v0hRgzGm=axigeW9aPw+ai5hMCy975=vgdY4dGYZFzzMTA@mail.gmail.com>
Subject: Re: Patch: Make ACPI subsystem provide CEDT table
To:     Robert Kiraly <me@boldcoder.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 25, 2022 at 7:30 AM Robert Kiraly <me@boldcoder.com> wrote:
>
> This is a simple ACPI patch. I'm submitting a revised version to
> linux-acpi per Rafael Wysocki and linux-cxl per Dan Williams.
>
> The patch has been moved to the message body and a Signed-off-by tag has
> been added. Thunderbird has added CRs so "patch -p1 -l" is needed. To
> address other points:
>
> Q. Dan Williams said: Yes, although I don't see much incremental benefit
> to developers publishing a root only raw table... So, not opposed to the
> patch, but I want to direct you to the sysfs representation of the CEDT
> and CFMWS in /sys/bus/cxl/devices... Platform firmware CXL details are
> modeled as "CXL root" objects in the /sys/bus/cxl device model.
>
> A. The patch is being submitted in connection with work on a CXL bridge.
> The developers would like to express appreciation for the "sysfs" point.
> They find it useful to be able to do initialization through the table
> but will look at the "sysfs" approach.
>
> Q. Rafael J. Wysocki said: I'm not sure why the #ifdef is needed.
>
> A. I reviewed cxl-next and decided to add the #ifdef to ensure that the
> code would compile regardless of the direction that the codebase takes.

ACPI_SIG_CEDT is defined in 5.17-rc1 AFAICS, so the #ifdef is redundant.

> ==== start of patch ====
> Subject: Make ACPI subsystem provide CEDT table
> Signed-off-by: Robert Kiraly <me@boldcoder.com>
>
> This is a simple patch to the ACPI subsystem. The patch adds ACPI
> _SIG_CEDT to table_sigs[] in  "drivers/acpi/tables.c".
>
> Presently,  CXL code isn't able to make use of the  CEDT table at
> the initrd stage. Subsequent to the change, the CEDT table can be
> used.
>
> If  a developer  plans to use the CEDT table to  program  the CXL
> ports,  this change is needed.  Otherwise,  it isn't  expected to
> make a difference.
>
> I certify  compliance with  Developer’s Certificate of Origin 1.1
> as listed in:
> https://www.kernel.org/doc/html/v4.10/process/submitting-patches.
> html
>
> --- linux-5.16.old/drivers/acpi/tables.c
> +++ linux-5.16/drivers/acpi/tables.c
> @@ -500,6 +500,9 @@
>         ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> +#ifdef ACPI_SIG_CEDT
> +       ACPI_SIG_CEDT,
> +#endif
>         ACPI_SIG_NHLT };
>
>   #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
> ==== end of patch ====
>
>
