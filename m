Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00C91AC81A
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Apr 2020 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441887AbgDPPDZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Apr 2020 11:03:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44667 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441866AbgDPPDW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Apr 2020 11:03:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id j4so3279909otr.11;
        Thu, 16 Apr 2020 08:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhtvBsFZKdhQx8mKpVCXLThI3U9c+Uba7tx4ykyajRs=;
        b=TjWUJ5zAuCMKV/+9WBC7+fgsepgjKJGw5BNJxKstk4dvwFxvrezwHpHP2pgqF9g1Sa
         ykQ3P98d/lzrc792jcX+/73oqFW4l3p6lxRewsKMMKX2cbwnRdLfQP+GgSLhNCm+Yv9p
         Y47OJ4yCIQQCMuDvjINUbPOZlbHVLhS7sr6EwfnB64StesHwecxn+xMl+o+laC3/LC1h
         CrrnmcxxOWgKztvfIb6M4c+sscwI7/gkqjXBFzREVHpUFQTlwvClpm2fx/2I7ha5nQwT
         VPVK0eBGvihSBNUBAvLmUgtcI143osl9ypIkhFYFZasG4bNE6zt4vOB9HiA0ONmXpa8d
         IDAw==
X-Gm-Message-State: AGi0PuYJKqmpcKDs1zNoaXVrxJBDUJY9BsBpw9EV/4sBm432My/+F8t4
        lC1onZKu7x8/SHEQdgDpVF1gYQtzO+YqvTy8/kI=
X-Google-Smtp-Source: APiQypLc72efPpd7dodFB4nuqP83ZjD9NEcQPJztmkP3OAt5POv/APtHv3UB3jo4tqdUx+X1Km+yjqmHUlsSbehRlls=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr25695278otm.167.1587049401160;
 Thu, 16 Apr 2020 08:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com> <20200416141730.GE185537@smile.fi.intel.com>
In-Reply-To: <20200416141730.GE185537@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Apr 2020 17:03:06 +0200
Message-ID: <CAJZ5v0ihzD4knW=pKFmcsW0Q9c5rfyJMFh2ChiePe5SWO6G_TQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] platform/x86: intel_cht_int33fe: clean up series
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 16, 2020 at 4:17 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 08, 2020 at 07:09:00PM +0300, Andy Shevchenko wrote:
> > When I started looking into the intel_cht_int33fe driver for an example of use
> > software node API, I have noticed that it's hard to get and code a bit messy.
> > Here is a clean up, main part of which is to introduce node groups and API to
> > register and unregister them. This and some pre-existing APIs can be used in
> > the driver.
> >
> > So, because of cross-subsystem nature of this series, I may recommend to create
> > myself the immutable branch which can be pulled to Rafael's and Greg's trees
> > respectively. I'm also open for other proposals how to proceed.
>
> Greg, Rafael,
> any suggestion how to proceed with this series?
>
> (It has been reviewed and tested).

You can merge them through platform/x86 as far as I'm concerned, or
please let me know if you want me to pick them up.

Cheers!
