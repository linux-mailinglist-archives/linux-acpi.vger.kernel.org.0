Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6856079A93
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2019 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbfG2VDy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Jul 2019 17:03:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39023 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfG2VDx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jul 2019 17:03:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so43025016lfa.6
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2019 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLwaZEH25wNqGZTB2HC+4XfUpsEwrKsTiwJGEkrXZM0=;
        b=h0yQPRrjNKlXGfFBoWoylITmjbz4SK0JegbN37szOKfhSVCcgDFpmM6/f4t2Mu9tMG
         ZWd1EFVeGSDBJhC5biZ3ZtwATb2l99NNxnlGXA9y2m7IcmKrIXcPQs0AB2aVeLDcxgIp
         zH57jcOguVqz4e5oNCbnoYI9t15QxN/XOs5TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLwaZEH25wNqGZTB2HC+4XfUpsEwrKsTiwJGEkrXZM0=;
        b=lGNGfDySPM1pqhFsHca4rJBa4VPQ6VbCKSSMTaSWPRVlSGIsMcNSLgJ1nqsVvkRfj3
         J8xWRvd+/bOPI5YF+HoP2G7DNUdler40cAzdvhN3NTOkH9HdNe5GrQF4jddSGLzJlXlE
         FBWSrDXj7128/b6ozjNqawPB+rbNBnpWteyO8pZnrhcl6GFoB1nD849LWqTiST9Qw7Wr
         wz+WxDu+xQT6q1BMGTrbrA/iKrvuwmDot5qOQZvck3qHrKpYddk36aXQ6QvQMJcaXKSr
         5BPItxMOCkJ/QGD7qEKWdYIGlAvup9vxdS3MPeU5hRg8ECOKvcG8g2yN61JMPy/Bt3Ks
         hNjg==
X-Gm-Message-State: APjAAAXbwSMB3weBLNc/LP8xpKqlDqnr8I+xVvzbMzFFETRU2EL63REd
        v4AOMekXBxQLUn6KmshyBQ5EseFqPng=
X-Google-Smtp-Source: APXvYqxRzrPR42dVEVvHlGWbNVW5dcWcpXgIbQB9cralb+rIzJBz0UqxqvKYtnou86RlViVFNuSWwg==
X-Received: by 2002:ac2:4565:: with SMTP id k5mr52884544lfm.170.1564434231436;
        Mon, 29 Jul 2019 14:03:51 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id x22sm10989104lfq.20.2019.07.29.14.03.47
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 14:03:49 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id m23so59880345lje.12
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2019 14:03:47 -0700 (PDT)
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr31685480ljg.83.1564434227544;
 Mon, 29 Jul 2019 14:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190729204954.25510-1-briannorris@chromium.org> <20190729205452.GA22785@archlinux-threadripper>
In-Reply-To: <20190729205452.GA22785@archlinux-threadripper>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 29 Jul 2019 14:03:35 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOOqOAWg9LnSPUs9d9Ai8G_4xkdUGC+CCduQQLBzC4kQA@mail.gmail.com>
Message-ID: <CA+ASDXOOqOAWg9LnSPUs9d9Ai8G_4xkdUGC+CCduQQLBzC4kQA@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: return -ENXIO for missing GpioInt
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Salvatore Bellizzi <salvatore.bellizzi@linux.seppia.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enrico Granata <egranata@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 29, 2019 at 1:54 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Mon, Jul 29, 2019 at 01:49:54PM -0700, Brian Norris wrote:
> > Side note: it might have helped alleviate some of this pain if there
> > were email notifications to the mailing list when a patch gets applied.
> > I didn't realize (and I'm not sure if Enrico did) that v2 was already
> > merged by the time I noted its mistakes. If I had known, I would have
> > suggested a follow-up patch, not a v3.
>
> I've found this to be fairly reliable for getting notified when
> something gets applied if it is a tree that shows up in -next.
>
> https://www.kernel.org/get-notifications-for-your-patches.html

I didn't send the original patch. I was only debugging/reviewing
someone else's patch, and jumped in after its authorship (as it hit
issues in our own CI system). So it was more of a "drive-by" scenario,
and it doesn't sound like that page addresses this situation.

Brian
