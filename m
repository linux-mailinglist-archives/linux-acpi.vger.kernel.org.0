Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3A32D2BA
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 13:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhCDMRx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 07:17:53 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:46420 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhCDMR2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 07:17:28 -0500
Received: by mail-oi1-f176.google.com with SMTP id f3so29816757oiw.13;
        Thu, 04 Mar 2021 04:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUiOBKkXK+Jh5+zsj5WyFodzkdDQgGmSGTctqy8YfXY=;
        b=aLNTMW8/B0ehf/s9KvlHIU5uSIayvErzkX+tKhSXcmAqMDV2N7TKYPVDi8rQShmbYD
         RWbnTbes1XKWxPmtjN07+64blQdKu5y37rL1DVST/SgCkvyO3OvOcxrpUHA3/MWSaWNc
         6A5+9sBPM6NavuKzsidimqbuiGsK2QfiR2BbDWIgHW8jh4y+VpskSxM8IPtjUjXA37XC
         uzk92iCKew7ErItMrCsfy/YmsZhAe3dR2Gs/8uTUC3sccGi0EoMW9cD4ZynMzIFzUI9n
         MlZdDgo/RXhCc+lBU9LzXuMPO3kc4YiHKLz7QoBnZvWx6KSR9uq8LcTpIJwFZTsguCXK
         kTmg==
X-Gm-Message-State: AOAM533QjGAOjDtDCyBBaKSbGkrhxGL0Nro71fN2SLrlgsfZTJyvy4m8
        KxOqgkJppTxhSAfxlf27Tj5nJVkjal+EUpJ6sAoWRWBa
X-Google-Smtp-Source: ABdhPJxd+exJGAZxfRE/tPACXE5fhBIaLa5ELf+HF2YRHtyF4Q+9IqTnU5KrNEHi6+Elt6CwxKny40WHtWoLdtvcsdg=
X-Received: by 2002:aca:f245:: with SMTP id q66mr2644509oih.69.1614860207448;
 Thu, 04 Mar 2021 04:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20210302133548.88230-1-andriy.shevchenko@linux.intel.com> <20210302133721.GG3@paasikivi.fi.intel.com>
In-Reply-To: <20210302133721.GG3@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Mar 2021 13:16:36 +0100
Message-ID: <CAJZ5v0iDKk-eB1M8otPON0r7T9Z4tpXzCS2arJ7_z_O2B0_3Zg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: bus: Constify is_acpi_node() and friends
 (part 2)
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 4, 2021 at 1:31 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Tue, Mar 02, 2021 at 03:35:48PM +0200, Andy Shevchenko wrote:
> > The commit 8b9d6802583a ("ACPI: Constify acpi_bus helper functions,
> > switch to macros") only changed functions for CONFIG_ACPI=y case.
> > This part adjusts the rest.
> >
> > Fixes: 8b9d6802583a ("ACPI: Constify acpi_bus helper functions, switch to macros")
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Thanks!
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied, thanks!
