Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1613586AB
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Apr 2021 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhDHOQB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Apr 2021 10:16:01 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37659 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhDHOQB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Apr 2021 10:16:01 -0400
Received: by mail-oi1-f180.google.com with SMTP id k25so2322380oic.4;
        Thu, 08 Apr 2021 07:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKaKZwwBYbSDypnMTwWmdNXdv3aMqiPbwiFjzwyaea8=;
        b=Xx/1Bg/cJt6mnLmJiM3r5f5HI8GHEIsW1GzjotZbAS5UP/VqOXN7forf8LLTboHjMp
         Z9wvU8C+zvjccMc5rXblJ3sbG3uWK0/TJ2lqqwprFUv9Ybgx+opc5Hg7TeCmbgHjO8T9
         TLBn7wDOCuLktq1rCUgmQNOpBuF2QAcYGwyRihA5nNitGJzmxPnz/VlOYCpXNtrrFRQj
         dyZEAAQ61sqYopcfO8UAMvKFitiRF/bijtjazNPFELZVJNr/g5ya+hpwygMWRpMS+BQV
         +gD86POF9xJXTaWXTunLTVRDdcs0Z07hNpZ0RN1UytC/tHhDtv+i09rFhMh0nzsoj/sI
         JPpw==
X-Gm-Message-State: AOAM531C6hAC1qAEgFppjxQrjjQgIBQMdPYS43Aw/NYIhiEJ3rMbNW3Q
        Yg295xhI7n6lAwLq+c+UK1TRLO0YDPfi/0PF4TU=
X-Google-Smtp-Source: ABdhPJwiALjwekHCc+Ich21y+wp6AEm2/FF2HTVRjPXNXvRSaLwP5ctEddxdWnsyLrEAUjsssVgRp2Eaf33o6knW/CA=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr6343068oie.157.1617891348563;
 Thu, 08 Apr 2021 07:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com> <YGRXmOMfCTxy31Rj@kuha.fi.intel.com>
In-Reply-To: <YGRXmOMfCTxy31Rj@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 16:15:37 +0200
Message-ID: <CAJZ5v0jJCYD9+j57-CL-OqiZKL7bBQ7NetcewE_37wODOG_Jkg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] software node: Free resources explicitly when
 swnode_register() fails
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 31, 2021 at 1:06 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Mar 29, 2021 at 06:12:02PM +0300, Andy Shevchenko wrote:
> > Currently we have a slightly twisted logic in swnode_register().
> > It frees resources that it doesn't allocate on error path and
> > in once case it relies on the ->release() implementation.
> >
> > Untwist the logic by freeing resources explicitly when swnode_register()
> > fails. Currently it happens only in fwnode_create_software_node().
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> It all looks OK to me. FWIW, for the whole series:
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Whole series applied (with some minor changelog edits) as 5.13 material, thanks!
