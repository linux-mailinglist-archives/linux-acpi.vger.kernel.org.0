Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F5C3A905A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 06:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhFPENs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 00:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhFPENr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 00:13:47 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39827C061574
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 21:11:42 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id x196so1060736oif.10
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 21:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aVE95PNmkfCHpI5uXPBdM/5Mvs46rQ7fDVdDbS5iwko=;
        b=SpIr/g9c+AY3zVTkCu1+W65emEbBORv+3IAuCVUKztdX4qUaUG+vJDVkNIU/onNtu0
         dmmENUekxBw/XCDDIe2Us8UBuHcxPtElaU+jMs2QWa484nrP6Ex1wPgDqMxWbZYajgHY
         3asnEswfv52MsvpWd0hMTNFNgvsZthUexFTSkGvGJBqganuVmU4ug1Ahk6LUOl6X/lrS
         KDwCprqKzZFRngwwVOOXk0+dUAlplV8gO/Yp34r273K6tuAmKOPqbRMFWUEGD1GPqaaR
         dIJ6e44GueTA/YHHV+1jszeY60ty1O+WWkMajmYrVm9wOFqmhQGt32EUhjN0gkehaKsU
         fK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aVE95PNmkfCHpI5uXPBdM/5Mvs46rQ7fDVdDbS5iwko=;
        b=G/RzbTiJjr/5w+4JaGzdDm+xTpe8GE749Kea83SgmZFfxNFjJe8FGfolcrbKzMoEVO
         OaH16dfEkhv2e3Hf+rjBK1pnzmw710MBJIhQCA3jyV+VBh8yv2KUfol4XMxZPMHWrWOQ
         NH3ovahwDY8Kz1MZ6i4lKUpEB91a03h+MGmvEKhmV8ha3/KkbgD5+r1Nkv5gm/z7x0PU
         bkHCKsDTnxtLuc4vX2ZKoMDW+rtGvF2FKhS8r5RM8n5L2h/8jNQSZ183R1YHCcKdpMg+
         DQLlzGNTLwvAMxPcuspSNW+dfq6u3yzWQmEhWwg1r5VJGUZmppyKyt2F3Dvly5JTHc5t
         vlvg==
X-Gm-Message-State: AOAM5327fTjGEmcDsM8Fk6WltRIaLZrdjhlc8myEAtQPinWAGyUhjZ6o
        5oIjuCY14NVwrwuvmNh2L4U=
X-Google-Smtp-Source: ABdhPJyfbj4dKnVqHZzAGsDxKtOJdu0uX1qB6eg6rW9cqSKdO4Y3Gk+u+M4/7rDKmDj4Vs5hyRKnTg==
X-Received: by 2002:aca:f547:: with SMTP id t68mr5565494oih.75.1623816701524;
        Tue, 15 Jun 2021 21:11:41 -0700 (PDT)
Received: from fedora ([2601:283:4400:c0:96c1:9c48:12a7:2c7c])
        by smtp.gmail.com with ESMTPSA id b22sm228113oov.31.2021.06.15.21.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:11:41 -0700 (PDT)
Date:   Tue, 15 Jun 2021 22:11:32 -0600
From:   Clayton Casciato <majortomtosourcecontrol@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] apci: sysfs: Fixed void function style code issues
Message-ID: <YMl59Ez79goPxgW7@fedora>
References: <20210612200910.1094351-1-majortomtosourcecontrol@gmail.com>
 <CAJZ5v0g1iO2_+Pp9j2Y366acnwfgPv9tLDH0PWFHKw+HFWULEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g1iO2_+Pp9j2Y366acnwfgPv9tLDH0PWFHKw+HFWULEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 14, 2021 at 05:30:25PM +0200, Rafael J. Wysocki wrote:
> On Sat, Jun 12, 2021 at 10:10 PM Clayton Casciato
> <majortomtosourcecontrol@gmail.com> wrote:
> >
> > Fixed coding style issues.
> >
> > Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> > ---
> >  drivers/acpi/sysfs.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> > index d25927195d6d..d6626aba4a6a 100644
> > --- a/drivers/acpi/sysfs.c
> > +++ b/drivers/acpi/sysfs.c
> > @@ -582,8 +582,6 @@ static void delete_gpe_attr_array(void)
> >                 kfree(counter_attrs);
> >         }
> >         kfree(all_attrs);
> > -
> > -       return;
> >  }
> >
> >  static void gpe_count(u32 gpe_number)
> > @@ -598,8 +596,6 @@ static void gpe_count(u32 gpe_number)
> >         else
> >                 all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
> >                              COUNT_ERROR].count++;
> > -
> > -       return;
> >  }
> >
> >  static void fixed_event_count(u32 event_number)
> > @@ -612,8 +608,6 @@ static void fixed_event_count(u32 event_number)
> >         else
> >                 all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
> >                              COUNT_ERROR].count++;
> > -
> > -       return;
> >  }
> >
> >  static void acpi_global_event_handler(u32 event_type, acpi_handle device,
> > @@ -914,8 +908,6 @@ static void __exit interrupt_stats_exit(void)
> >         sysfs_remove_group(acpi_kobj, &interrupt_stats_attr_group);
> >
> >         delete_gpe_attr_array();
> > -
> > -       return;
> >  }
> >
> >  static ssize_t
> > --
> 
> Applied as 5.14 material with edited subject and changelog.
> 
> Thanks!

I'm not sure how to find the edits.
Did you note them for transparency or would you recommend I do something
different in the future?

These are my first patches and any feedback you'd be willing to provide
would be appreciated.

Thank you, Rafael!
