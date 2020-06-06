Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72F41F0811
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jun 2020 20:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgFFSEk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Jun 2020 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgFFSEj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Jun 2020 14:04:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6752FC03E96A;
        Sat,  6 Jun 2020 11:04:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so4982240plb.11;
        Sat, 06 Jun 2020 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JPH5ctOxyMCdjLHMVbCVgL0WBomDEBN4mofIceuo0GU=;
        b=t7hLn6wlwoTPvo4w1gGCsYXJNz5CF3z4rUYs1tB8I/gM2uAs23I6VJkAqNl00Kv+uA
         h+VVza0e2viw0mPFY1WymqYYt7SmqPX+mIJc0ZECF72H+bQfYeZe4NPN5HUwFvhTCWoa
         OIY1U6B1Gfw9pkNRiKNw8GznaWPkaxUUr0jWXRft9k0c72eeLciIRu2IwU89FI492Afs
         tpGh4TFX61N1W0wF5iQ5/wMMzKuC+oBxbW4YcVSDTXKmCpiWih3Zhl9jLW2xF3YsD9mB
         JISTpfF/5KDhEpB2GOtQI5Eo+qCSlJnndD44HWquI5DVI7WCAWUDbCsvp+JWUrzbUdyR
         HdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JPH5ctOxyMCdjLHMVbCVgL0WBomDEBN4mofIceuo0GU=;
        b=kqmV4BG6NZ9WNy0Lw2znZVniLrfuRUpjBzL1k1d+t+7KlMJrkBXY4S6BcirPw6NdUK
         A1JioBlGXdxBrEEmcMM6MIP3PQRsS2nS+oMmBTsZ7TB36o+7PDyGerLxhiDn4iHdUQfY
         srmd5+vu3r0lmNzPXivhNONA1hVJhk6Kb7uFDvo8m8vu5OGY2RbfCrPoxgBjUwQ3OYaH
         s+PrZT0YzN9R9LKkt/ACLSsrn9J3/RQMq32rD46/cAlZ7llmlOwEjxDE1rYXcH+wBgsH
         lyEttwbuao8QZio4q+vixBRKpNSofaPgp+Np/BgMUw/6Mc5w4wf2uHocMusKhO8HPcFd
         Rbfw==
X-Gm-Message-State: AOAM5327ErEnkk+At8VaCn/Zl0ZWpliSSuqa6u8C/fZwESo98LoUolUM
        oTlNF7BLWETk4dn3gq6rSikyag8T
X-Google-Smtp-Source: ABdhPJwpEhGJh9hj4x8vH2tqTdMACMiacQSV9exWCdyerOpLoWL+4lj0PJFYgbPFCxf5X55Kmu3hrQ==
X-Received: by 2002:a17:902:c3cb:: with SMTP id j11mr6948030plj.171.1591466678666;
        Sat, 06 Jun 2020 11:04:38 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id j7sm2827317pfh.154.2020.06.06.11.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 11:04:37 -0700 (PDT)
Date:   Sat, 6 Jun 2020 11:04:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
Message-ID: <20200606180435.GQ89269@dtor-ws>
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
 <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
 <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com>
 <10490419.gsntqH5CaE@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10490419.gsntqH5CaE@kreacher>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Fri, Jun 05, 2020 at 01:17:15PM +0200, Rafael J. Wysocki wrote:
> 
> First off, GGL0001 is not a valid ACPI device ID, because the GGL prefix is not
> present in the list at https://uefi.org/acpi_id_list
> 
> There are two ways to address that.  One would be to take the GOOG prefix
> (present in the list above), append a proper unique number (if I were to
> guess, I would say that 0001 had been reserved already) to it and then
> put the resulting device ID into the firmware, to be returned _HID for the
> device in question (you can add a _CID returning "GGL0001" so it can be
> found by the old invalid ID at least from the kernel).

This is not going to happen, as there are devices in the wild with such
firmware (i.e. Samus - Google Pixel 2 - was shipped in 2015). Even if
Google were to release updated firmware (which is quite unlikely), it
does not mean that users who are not using Chrome OS would apply updated
firmware.

> The other one would
> be to properly register the GGL prefix for Google and establish a process for
> allocating IDs with that prefix internally.

I think it depends on whether there are more instances of "GGL" prefix.
I thought we mostly used GOOG for everything.

Thanks.

-- 
Dmitry
