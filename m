Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073162AD30B
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 11:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgKJKDI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 05:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJKDH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 05:03:07 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F46C0613CF;
        Tue, 10 Nov 2020 02:03:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so10948042pfq.11;
        Tue, 10 Nov 2020 02:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXNZTLerM3WOezIWBdHkzPI9UZi2f8IsIDfLKv1idEg=;
        b=nEw39IvY8rC+sw/wBUd7N3ilIgVKWGcXNtMgng4yeG1u7bxAO/+p7uz1a0Mv9aFo+y
         0lwNn6rF7lsrZPRlLpDS2pqjGDuCBWNnfpFIG9MN6xadZMBmArznQJvK9GKUA3Tfiel3
         lqS/mVSHiMHKvVXZBsQVq9SxC9l2hGEhbEhvPCglZ3hgyqG81dxuuMgd0XNEoYY3ZU8K
         Og5DiHJjZj/sc0Ufi9EA0gBfvdtkQRVedWWOeLnylhLk5LSKypt7bPETRlVMLc+Hqa9U
         u44A4ICdjA/tUMFQTLzmjHPmAC8FHVwYAK9hUfQAAX9mgc+yyZTVTdsH/fpWOy3SJyN+
         fe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXNZTLerM3WOezIWBdHkzPI9UZi2f8IsIDfLKv1idEg=;
        b=s0U+h0V9afsNfepDslf+beAbacQYkyOsFZtjaoR1vbUwLt/BLmhkfD3SNPU730Oist
         FE1ddfaTIH1an175hDETsSjznXSbswFHy0aPZdVOGnb496pdonifHDp5K9gMQLRWd/AE
         OMW43cmEEcCYlQNsFmZz6AUSQWq5u5lMa2V8QYo0pcaMNtMrGqe3oQTgO1sV1+wxEm/R
         UaTlzzEUhcEOSj6VunbupmpoOPHlSKNc435SNF4lWV8UVXStbdliUXb8pD9Xdw+w9HBf
         S43LKy3GS4EvWVZWm6DnY/TCFBElgYySRrrkcq39lwlsVYsEd837dfWRjHpWTtG1eQN7
         pdnw==
X-Gm-Message-State: AOAM532cOouHUn+HHfKzNzTA+k3wbO9Y+qc2osBwXseoFjUJnBc5nryO
        kBffN0TENSbk+vJw0HQhnT9Z4sVPSWOaQfVTJ30=
X-Google-Smtp-Source: ABdhPJw2kh7O70s6W4ALCwCviIae/wzpgIEjGopcj/UgUbX9Fr/W96ICR3fHNqcAx6/ZIUmBYeeQQBhrlXFzelev4Vc=
X-Received: by 2002:aa7:8c4f:0:b029:18b:f361:4aa3 with SMTP id
 e15-20020aa78c4f0000b029018bf3614aa3mr280698pfd.73.1605002587346; Tue, 10 Nov
 2020 02:03:07 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201110033124.3211-1-markpearson@lenovo.com>
 <20201110033124.3211-2-markpearson@lenovo.com>
In-Reply-To: <20201110033124.3211-2-markpearson@lenovo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Nov 2020 12:03:56 +0200
Message-ID: <CAHp75VfeE06S5M_GTFo3nKPdMeUJY-aLYfFmsFy7E2zv1fRvZw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 5:35 AM Mark Pearson <markpearson@lenovo.com> wrote:
>
> On modern systems the platform performance, temperature, fan and other
> hardware related characteristics are often dynamically configurable. The
> profile is often automatically adjusted to the load by somei
> automatic-mechanism (which may very well live outside the kernel).
>
> These auto platform-adjustment mechanisms often can be configured with
> one of several 'platform-profiles', with either a bias towards low-power
> consumption or towards performance (and higher power consumption and
> thermals).
>
> Introduce a new platform_profile sysfs API which offers a generic API for
> selecting the performance-profile of these automatic-mechanisms.

>  .../ABI/testing/sysfs-platform_profile        | 66 +++++++++++++++++++

Is this in reST format?
Mauro have been converting ABI to be reST compatible (at least).

-- 
With Best Regards,
Andy Shevchenko
