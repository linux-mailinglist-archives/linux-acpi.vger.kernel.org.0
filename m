Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4187F61277
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2019 19:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfGFRtH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Jul 2019 13:49:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34898 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGFRtH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Jul 2019 13:49:07 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so16336330ioo.2;
        Sat, 06 Jul 2019 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1N+ORYkUAXiG8XtCiY3phbUyj5YEJ/P62m0Q4FBLNUw=;
        b=IQEGFDSF6JZgGfJot1/SB3CFvBcNiSYtXyU1Wvuf4gHhXnhvhfJyFGpjLXgF2EzgNx
         tFKSo3odCaLmEDyblizh0d+hPCSTrZ75c7B0SdggxGNpQwgLG+Uidz2T01tvYVo5HnKH
         KPsYOpQAxzaReaO4ffPmm8sy6EyTadq+vIIppDDIPg2JCZCMfiF0sP33NuAuiTUJEJUv
         xPpvZ3ssPq1f7AGpMo0BrzJji/JtgHYMlyP0iznLjdduikW87nCM4aQ2L6zi6uOAW7Ki
         1Ve8QfQ0+qo0aoG2EXZhs1gnCAbDRd81QtcAy+nFVWk95B3oiSlfnJI2B6AJuuP6MjRZ
         vOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1N+ORYkUAXiG8XtCiY3phbUyj5YEJ/P62m0Q4FBLNUw=;
        b=PrKZIBDyKDA7XBU3ydDJ8xsUgnnY7mTb9iofVwrGU/UP++AZrNc30Lg/aF8op+buAC
         qKUQHKVGLGcAG8yuhKdjTYzeTL08KJWTBMHGzNu3lL/gSys0xFHK7RkOPZkgr0MEZXOB
         ETJrzl0ldd4bFyv3UnJpSIDQW7vQN+adbVDQKhR3nJ5SqJUa40x2LSdYzxh5iDmh1RBt
         aF93Zba9mOt5TrWRQgZcsTJcC1O9KPtSq2+GbtYMPoGLOjlO3dMm3EXhEv38napL5Pxv
         3dkpUnxOq5Te2GZcR2ZhwJWunXSXuAJFU3SCWi/FxIBT3ZBysR37YwwsNRxdV3/fB9gg
         EZdA==
X-Gm-Message-State: APjAAAWOfyv09LhoP0OX8kfnj3eVRMr1T7df77ENwakhkYOq4kVOF4Bl
        6c0yfF0vikEoeD+82JFySBHMYCL2MhI8wF3ZkIOf9i24
X-Google-Smtp-Source: APXvYqy5L8aQNCtiln6FAVslu6YPVHug8M2aYQsbLQwGtje3bprjiC2mWmQtxIF4BsZJ3xM1Gwwh8RNTVY3Jd91DMGU=
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr10070868iog.43.1562435346410;
 Sat, 06 Jul 2019 10:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181109142138.54770-1-heikki.krogerus@linux.intel.com> <20181109142138.54770-7-heikki.krogerus@linux.intel.com>
In-Reply-To: <20181109142138.54770-7-heikki.krogerus@linux.intel.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sat, 6 Jul 2019 10:48:55 -0700
Message-ID: <CAKdAkRTCV5Jk2PDtRTs7OcRoN0sHx-WFXt0i5aHDFDTQY=yaEA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] device property: Remove struct property_set
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Heikki,

On Fri, Nov 9, 2018 at 6:22 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Replacing struct property_set with the software nodes that
> were just introduced.
>
> The API and functionality for adding properties to devices
> remains the same, however, the goal is to convert the
> drivers to use the API for software nodes when the device
> has no real firmware node, and use the old API only when
> "extra" build-in properties are needed.

Why do we want to do that though?

If I am reading the code correctly, the change as it is implemented
broke some of the current users of device_add_properties() (i.e. in
i2c core when we instantiate a new i2c-client from a static board
info) because it will fail to remove the properties (as the software
node will be set up as primary and device_remove_properties explicitly
looks at the secondary) on device removal.

What is wrong with having device_add_properties() and
device_remove_properties() to continue properly handling both cases
(swnode only vs mix)?

Thanks.

-- 
Dmitry
