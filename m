Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CF821DA47
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgGMPj4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 11:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMPj4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2020 11:39:56 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF47C061794
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 08:39:55 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so14050539edz.12
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=du57OarKMFj2//aqQNh8usAhJGOEHYQoIDCsSqzfRrA=;
        b=p5NtX2gb+X8NBTzJ3q4wi1YSieEG+HNt+0otz/H/s/4MmLGrJII8dW/W0UVEpeW0Hg
         qC3dEPnVuhhvBwHhOLmT0GIL1CYUYMo9ubUoSer6T64yW74mkvzKKDKlZDVr19K+cYri
         LtlbMnBKoOcwmDXe/2csa9LQ7/dQV+rttec6lQsYqYKQLaZDSoi1NaLa2MvaowwAoBYv
         FeI+RRFcbGjItkCjE4SunsxqoBYnRp76pca1wVuHw/7y67Q/sHjhAzl/ezQtIiTEEG4j
         yQVjwihttrowt+w804UNoet1fmlmsFKNkFYmUigdIXnkpiItEwYkP2N/ahsYzcyDUeNq
         Dsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=du57OarKMFj2//aqQNh8usAhJGOEHYQoIDCsSqzfRrA=;
        b=TIyFcbMoged1/8YveKrfXLoFGtjXWpfi3Dizjn5fmDK922smwC/pML0WzPW26ZMZcl
         aWEu8OOBWW1yCsDeIAFTWRD4aniRM+MUaNwMD2GgZpfhdE3t7Cz8mU/f4dIyQzfIXm1F
         iU6zn9KnZIDwrivJ8UR6KG13GlEOg0Z9xXrhB/uxMsY4zeCHiT9lgfT9cV9QdadtXi+s
         grovlFbcaD1JpgifwVBzSz3Lbz6qAywQyueQL+uyKVdizbbNNbE9afWv9dUBdtc8l9GU
         iFZPaPz6tOA0DljIwDm6E8GBzx4YvzPZKFciI1/GKD4TwBaCZM/3OR/4oo53ywkQtIxT
         AqAA==
X-Gm-Message-State: AOAM533Fp7JOCwivWY2Sq3Wa5fHRIN72RtYIilGyPuLPySmgGJJeixQh
        S4lLNGIvPUkb/RpiHrOfIPFxmByn7NXXk+uH1BZM2A==
X-Google-Smtp-Source: ABdhPJwvCxFFHwbU4mztcnMn5QN22D7JN5cZqYOUrLmDBOAdReDdsMY67wCR/9JL04AtkGrUTxK3CfgbBEbrs6JuO2k=
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr95634335edo.123.1594654794604;
 Mon, 13 Jul 2020 08:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200712170945.GA194499@kroah.com>
In-Reply-To: <20200712170945.GA194499@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Jul 2020 08:39:43 -0700
Message-ID: <CAPcyv4h=7oB+PHEUa6otkoXYx+r_8GFbmuF-j_kOmHjpGB-=eg@mail.gmail.com>
Subject: Re: [PATCH v2 17/22] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jul 12, 2020 at 10:09 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 12, 2020 at 09:27:37AM -0700, Dan Williams wrote:
> > Use sysfs_streq() in device_find_child_by_name() to allow it to use a
> > sysfs input string that might contain a trailing newline.
> >
> > The other "device by name" interfaces,
> > {bus,driver,class}_find_device_by_name(), already account for sysfs
> > strings.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/base/core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 67d39a90b45c..5d31b962c898 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
> >
> >       klist_iter_init(&parent->p->klist_children, &i);
> >       while ((child = next_device(&i)))
> > -             if (!strcmp(dev_name(child), name) && get_device(child))
> > +             if (sysfs_streq(dev_name(child), name) && get_device(child))
>
> Who wants to call this function with a name passed from userspace?
>
> Not objecting to it, just curious...
>

The series that incorporates this patch adds a partitioning mechanism
to "device-dax region" devices with an:
    "echo 1 > regionX/create" to create a new partition / sub-instance
of a region, and...
    "echo $devname > regionX/delete" to delete. Where $devname is
searched in the child devices of regionX to trigger device_del().

This arrangement avoids one of the design mistakes of libnvdimm which
uses a sysfs attribute of the device to delete itself. Parent-device
triggered deletion rather than self-deletion avoids those locking
entanglements.
