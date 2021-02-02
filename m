Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EDB30B964
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 09:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBBIPv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 03:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhBBIPi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 03:15:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE7C061573
        for <linux-acpi@vger.kernel.org>; Tue,  2 Feb 2021 00:15:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v15so19460845wrx.4
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2021 00:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hqt3Tq2IV5R4WiXTtDJbZrsLXSk61GOL768nUQ/gTfU=;
        b=qbqVkwRfMQkqjroRuCKsLSvylT0HvI1J5iLNFX3b0SI7TMhz1r6LjCMlDaGcm7/Nqy
         aLq84pCPljkmmMBPN6uKITMawTGDyiW7i54Ruf6Zd5ACkgdujS+IqIBr8vJa54vyn5oz
         wxW/tE4GIzcP9rH8BYtXacM7cDoCQajIToBvnoXGje8OhuwKMJkhMxuKoswlxGuzx5Rq
         V08fikWi0Oqu6A+j1YsTjm0X23qW9jbQttsYrVCHS8UAGrJWs77U32zdLiEtFTf8wv3N
         Spmr8R8l3VMs4PQrok8Qdz6I31bWtvhkPl7/Yu4Jvtrl6y/S0UGJQ0QByZmkCgf/NSg0
         3k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hqt3Tq2IV5R4WiXTtDJbZrsLXSk61GOL768nUQ/gTfU=;
        b=uSEjNMnPjGaJ8pvfpziFDev3hlY9BF0Q4/UtBSw4mQO2OItNjbL/NGjOxx8ciHDvv2
         xePxtF7H2gb6oZQ/GNMKhJTAQPX9BjMbACRl6r5Ypui9jRHRJDLzlgVFvUg0mEvOJTk7
         c3ZYwVJwGz6v7rawKW5qTOOrb+TWFLAZM20tHHcCrdF1JpAIj3VJ8al92MHicYXOxakU
         jChni0obVSI5AmI5l3lDPFPBoDV0P+1F6Wv4F6zTDWlEgR2/ZrMgPPclWeh0f4bCJiTZ
         VQZiPy46VKoi37Zcbrst4UmvbfWOdvRU2OJssDogtBsSXJuc/4Fd0c3AK2UJDbjCiiZv
         bOUg==
X-Gm-Message-State: AOAM5315C67/LKs07js2HVCK1W6XYjFP4Pa+sgoPWAjxWp4mLhJKSkSK
        w5ZFQWOUa4l6vi40WAfTcDqpzw==
X-Google-Smtp-Source: ABdhPJxE4ohxXWISsDLkRM6l6XN06/LSVRAdMmpWvGBcb6TD6kkqRKCojZH/xeofJCe4nYk7W1n/Xw==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr7510655wrl.344.1612253722232;
        Tue, 02 Feb 2021 00:15:22 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p12sm1798673wmq.1.2021.02.02.00.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:15:21 -0800 (PST)
Date:   Tue, 2 Feb 2021 08:15:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
Message-ID: <20210202081519.GY4774@dell>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
 <20210126082101.GD4903@dell>
 <YA/xfxcwCabETug6@smile.fi.intel.com>
 <YBhLuNZ7xmHdhurU@smile.fi.intel.com>
 <CAJZ5v0jQLZ7hEn7nDN8AADy7djnrQRrC4jtXKY-YqZiO609_2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jQLZ7hEn7nDN8AADy7djnrQRrC4jtXKY-YqZiO609_2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 01 Feb 2021, Rafael J. Wysocki wrote:

> On Mon, Feb 1, 2021 at 7:45 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Jan 26, 2021 at 12:39:59PM +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 26, 2021 at 08:21:01AM +0000, Lee Jones wrote:
> > > > On Mon, 25 Jan 2021, Andy Shevchenko wrote:
> > > >
> > > > > This is a second part of the Intel MID outdated platforms removal.
> > > > > First part is available as immutable branch [1]. The series has functional
> > > > > and build dependencies, so the mentioned branch should be used as a base
> > > > > for these changes.
> > > > >
> > > > > Note, that some of the drivers, that arch/x86 covers, seems never appeared
> > > > > in the upstream (like msic_ocd).
> > > >
> > > > What platforms stop working after this removal?
> > >
> > > Intel Moorstown, Medfield, Clovertrail.
> > >
> > > > Are you sure no-one is using them?
> > >
> > > Definitely.
> > >
> > > > I wouldn't be keen on breaking Janet's PC that she's been using daily
> > > > and keeping up-to-date since the 90's.
> > >
> > > They never were in PCs.
> > >
> > > All of them were supported by Android and Janet won't update her phone or even
> > > Android tablet for sure they never ever run any kind of Linux than Android.
> >
> > So, I hope you are satisfied and we may proceed with removal.
> 
> Speaking of which, the patches here are requisite for SFI support
> removal, so I'd like to route them through the ACPI tree if that's
> fine by all of the interested parties.

Shouldn't cause too much disruption.

Ack provided.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
