Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018CDD97C7
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393418AbfJPQoy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 12:44:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34230 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389763AbfJPQoy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Oct 2019 12:44:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id k20so7267632pgi.1;
        Wed, 16 Oct 2019 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/WDEkNwc8G5QTZd2e72it5kKVnpD1ylukdGEnQJYfE=;
        b=SkFJTuqXoZYZcZqFW/C6M1Y3k96KD5vp5KNmJM9xVY67oEK2D9Y4KXnYUIVENq9VI2
         Yq+GGJVwQAtbWnLmdwqCLV2nXStNNvLu0gvYXxVaXwtR4D3DHa5CoX/15exi5jzLqrN9
         9YqFP20QvsxBNpLWgVUka0YEszyOkpe8V2Ez05qb3DpRjdadgLTvgwXlh5H5AfvB8MXV
         Is/xceJhkjfBTQfAw0Cv1lG3ehWRHx6CS3Mbo47WAbr+oFp6wAGMX+Rl2YgMQOYTTXwx
         H2tg5xk12+4rf97ubjTDduB0Ath32HIe5gqtb6N4d+fH/uUjAgb/ZaaZ9Hh+EpeVffUE
         kOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/WDEkNwc8G5QTZd2e72it5kKVnpD1ylukdGEnQJYfE=;
        b=Br+DNcWdAsjMrvkSIYs37s7fn21nvCd0mVBeZBd+VhftnDDfqPjMoTQH3AvYsAllJ5
         pyeFB9W+y37lqEDdIz2lRV3rfzsQZxeHDFH+i96XGTPE4wHWCkD6vmVRwfCeCz6XA1YT
         vI898syM03kczNkNZTgRV8ZsOE1xIEbUhU7ZyzH6oyVL0HTpyefij/Xo+eZZV+AU5wj6
         EpcSFT0nIqM2HvfeKQASICeFMzn5aVcjblohvFYN5HPeRLAKXd2LEigXpWdJmkKi2d0Q
         JV9n6M0XQBI0kNAJv/dnRb2FkxGKWiS+6zlOF/8BQqqNZc4GH6ruwaeYXJG9XdMsK+Ui
         tR4w==
X-Gm-Message-State: APjAAAXChkqnb11bMpvgsU92cfv/MOb2pAUsLr42G88CJsfYCgl6vVWk
        784rUJXu0UHnI2muCdD9SzM=
X-Google-Smtp-Source: APXvYqzW3Ewyi/n4N5PdP1FoT+CUckCZuJnajQppbavxfEZ4XWt6gsuOMYaRaEYLVRhHWskMtAKypg==
X-Received: by 2002:a62:ed01:: with SMTP id u1mr31459977pfh.122.1571244292975;
        Wed, 16 Oct 2019 09:44:52 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x10sm9793405pgl.53.2019.10.16.09.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 09:44:52 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:44:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 11/14] software node: move small properties inline
 when copying
Message-ID: <20191016164450.GC35946@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-12-dmitry.torokhov@gmail.com>
 <20191015122028.GI32742@smile.fi.intel.com>
 <20191015182553.GG105649@dtor-ws>
 <20191016074857.GN32742@smile.fi.intel.com>
 <20191016160126.GB35946@dtor-ws>
 <20191016161845.GX32742@smile.fi.intel.com>
 <20191016162308.GY32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016162308.GY32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2019 at 07:23:08PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 16, 2019 at 07:18:45PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 16, 2019 at 09:01:26AM -0700, Dmitry Torokhov wrote:
> > > On Wed, Oct 16, 2019 at 10:48:57AM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 15, 2019 at 11:25:53AM -0700, Dmitry Torokhov wrote:
> > 
> > > > You store a value as union, but going to read as a member of union?
> > > > I'm pretty sure it breaks standard rules.
> > > 
> > > No, I move the values _in place_ of the union, and the data is always
> > > fetched via void pointers. And copying data via char * or memcpy() is
> > > allowed even in C99 and C11.
> > > 
> > > But I am wondering why are we actually worrying about all of this? The
> > > kernel is gnu89 and I think is going to stay this way because we use
> > > initializers with a cast in a lot of places:
> > > 
> > > #define __RAW_SPIN_LOCK_UNLOCKED(lockname)      \
> > >         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
> > > 
> > > and C99 and gnu99 do not allow this. See
> > > https://lore.kernel.org/lkml/20141019231031.GB9319@node.dhcp.inet.fi/
> > 
> > This is simple not a cast.
> 
> 4.62 Compound literals in C99
> ISO C99 supports compound literals. A compound literal looks like a cast
> followed by an initializer. Its value is an object of the type specified in the
> cast, containing the elements specified in the initializer. It is an lvalue.

Yes, these are compound literals. And they can not be used as
initializers:

https://lore.kernel.org/lkml/CAHk-=wgXBV57mz46ZB5XivjiSBGkM0cjuvnU2OWyfRF=+41NPQ@mail.gmail.com/

Thanks.

-- 
Dmitry
