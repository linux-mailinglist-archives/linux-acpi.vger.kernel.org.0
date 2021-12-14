Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4077F474E6B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Dec 2021 00:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhLNXFA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Dec 2021 18:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbhLNXE7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Dec 2021 18:04:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA35C06173E
        for <linux-acpi@vger.kernel.org>; Tue, 14 Dec 2021 15:04:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso2140059pjf.3
        for <linux-acpi@vger.kernel.org>; Tue, 14 Dec 2021 15:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M2BFbMJaVwMNM4RS4xLE2tjwuVQHsGBUmE2Hk9fOAug=;
        b=TiFP6w2bj9LlQ33+ScgY0eGfLoigi+0Ao+OjORy5YkzW15X59Q6Lytt/c0+S2wCjss
         mdMbfgIdiGrM0h64qsMvdbKzwz3AD1mGZssJeT7syS+pewMwVDMgchViqwTUe7c/7o9R
         afgTjXMDqPj1yd/HjGjkwzpmOrAH24ZkaHKzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2BFbMJaVwMNM4RS4xLE2tjwuVQHsGBUmE2Hk9fOAug=;
        b=aULITA/2eWrgu8uDXh9TaP0sCpD8SFkipLCgsRTlPnBj/W/v4PRMczx8cNC+Logoay
         8qhMaxatFiDmmAYLAc/Krx45JQ6jgpSa4zQX7Zh31AkNjRk1SToGveDBZ/ZLDOEX2E71
         Hqth3tGwmWDNvJkVTFiWDGo5R8KDP1BwxwSM88aFPqcq2ruq0GlU0ssNwFW7776G1NdV
         DDqph6zf6fiIZLSLM0RjX5nh0TXQvjAcz9kbllEp44/o1zYPC+r7LYsPLOW+OEWx+9fe
         vjbmwYYtZ9o8wxVxfY2GklFcx5QU0mfsaYJql7dJ4Azo0ns9XLcIMAwGytrDNqvZxqpf
         3iXA==
X-Gm-Message-State: AOAM5310sxt0+lQ1/82gWWmpVusDl4zsZ4y2zCp03uONxhLyx7TcGkVF
        1guqFtR8yL0+q/qNbvzpOH8BRA==
X-Google-Smtp-Source: ABdhPJwNDRkNv0tjAX5S3YBqoEQjC3y4dtBnPaCbfBBWzUSQcnpEx+d0aV1f9ocu/hymnGerkVgLaQ==
X-Received: by 2002:a17:902:b197:b0:148:a2e7:fb4d with SMTP id s23-20020a170902b19700b00148a2e7fb4dmr1630928plr.142.1639523099026;
        Tue, 14 Dec 2021 15:04:59 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e9a1:b79a:d9a5:5e56])
        by smtp.gmail.com with ESMTPSA id lp12sm48343pjb.24.2021.12.14.15.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 15:04:58 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:04:57 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] acpi: Store _PLD information and convert users
Message-ID: <YbkjGaDxxzkBKHHX@google.com>
References: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Heikki,

On Mon, Dec 13, 2021 at 01:32:38PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> I'm now using the helpers device_match_acpi_dev() and
> device_match_fwnode() like Andy suggested. No other changes.
> 
> 
> The original cover letter:
> 
> This removes the need for the drivers to always separately evaluate
> the _PLD. With the USB Type-C connector and USB port mapping this
> allows us to start using the component framework and remove the custom
> APIs.
> 
> So far the only users of the _PLD information have been the USB
> drivers, but it seems it will be used also at least in some camera
> drivers later. These nevertheless touch mostly USB drivers.
> 
> Rafael, is it still OK if Greg takes these?
> 
> Prashant, can you test these?

I'd sent an email earlier, but not sure why it's not showing up in
lore.kernel.org. So I'll send it again. FWIW, for the series:

Tested-by: Prashant Malani <pmalani@chromium.org>

Thanks,

-Prashant
