Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD82F8F2D
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Jan 2021 21:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbhAPUYr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Jan 2021 15:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhAPUYZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2021 15:24:25 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0186BC061757;
        Sat, 16 Jan 2021 12:23:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g15so2900160pjd.2;
        Sat, 16 Jan 2021 12:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJcT2DByVAw9ygpQVE1Cu1D42e69pC0/D4yERSfO1vs=;
        b=cqvOCT9aGlsgaY+6t8ngHwL012YqGygdXVHowcHeQ37Qc9M6aWlqxI50cyv2E67O7p
         YhBaF5Ctj3FnPAXonjfwicrOIW+uY+3qlXxiTIjVRti7EMXhcUelHS41onGomzJFXAmm
         5jVzIR1s4+liUvfF2va9+RorHYikxTjPXQnuvzf+07fdNJZtGmhkM69rxVn/xc/LEA77
         h33gj9j4bnwH5aX9+CAQfEF3jaw9BjlupMLc2uD+fdnXoQZNHEndRlptioaUlcYjwnkx
         XfTQpf2jRMkASm+fHNeyF8CoHQ7dCUXkwGp1gLeDaoWw88v2fD4r6/3Vsyld6AB2iNSd
         pj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJcT2DByVAw9ygpQVE1Cu1D42e69pC0/D4yERSfO1vs=;
        b=pJFY2C1tiizckMN3QTdnSfJO1qG/9XmjlO2jQh6Ox1n8593kFUQMjXP9ZsdPFGDvQH
         +sgZQntaJIhMLSFLLSw3UCAQbYHf0TPrmb2fG+qZjd7/k3JPy/+Q8m3bmRp2zp0cQNf9
         uAp8d1QE3iUlvWVxg+EJBbHqYshgcevy39NzCU5FhwTw70IiiYn1sWgVEbO4v/lPZwgH
         HCjkQqC4/jmJxxr3PnlC0SUg9+bZXF58/ZTo8thMBdYok+auQHTIMZb0LU7GI8XJaS85
         ageGnnOlI6wer2sueww9jxQqqcJam2VinZDKs6P9ixKeGmYLT4gWkt0gITYSISHG16q0
         4FTQ==
X-Gm-Message-State: AOAM5339EJNuJRCub3y6miRxK2pUZ2NIze7+5c1qw3QqmeSeUcJWHJd+
        34kwayzpFd4ZnCde5eNILy+a92WOuSTCl3W+/u05sJYnLsqghg==
X-Google-Smtp-Source: ABdhPJw9qBR8ysjKdldStISGdFIiUBrlQ2yCfiUx+yQJg115xhaT1SXXGwHdf/DAS5D5i5pFzBybiNYaGDAyeWzCmXs=
X-Received: by 2002:a17:902:7e47:b029:de:7c27:c903 with SMTP id
 a7-20020a1709027e47b02900de7c27c903mr7284267pln.21.1610828624287; Sat, 16 Jan
 2021 12:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Jan 2021 22:23:28 +0200
Message-ID: <CAHp75Vc3xjaOugX3d8bohz12OEP=n4BAonNyQJQ=UgBfVZorOg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Remove one more platform_device_add_properties() call
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <greg@kroah.com>, Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 15, 2021 at 11:52 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> I'm now clearing the dev_fwnode(dev)->secondary pointer in
> device_remove_software_node() as requested by Daniel and Andy. Thanks
> guys, it's much better now. I also took the liberty of including one
> more PCI ID patch where I add PCI ID for the Alder Lake-P variant. I
> hope that is OK.
>
> Andy, I dropped your Tested-by tag because of the change I made to the
> first patch. If you have time to retest these, I would much appreciate.

Since Greg already grabbed a v3 I will test it when it appears in linux-next.

-- 
With Best Regards,
Andy Shevchenko
