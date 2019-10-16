Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE678D9811
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfJPRBD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 13:01:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45092 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJPRBD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Oct 2019 13:01:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so11530919pls.12;
        Wed, 16 Oct 2019 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KwEuYR87HPnv/4ymC/dnp2PQlBlu56yCgjQvKHxqMDY=;
        b=lqWvWcG36Dr+6xbOCkA7KBb8R9ftHLZy3op77dCbvivNTOdpZDATt346L5z0l5N8DZ
         iHlaM5A29y97VN7y7GzsBKnArFvx9Ev2xYa6JZndILd/Ze4J7Ce/9uXpnIyh/TBIyT8B
         7Sk0aAqDiybH5NNALj5HGmhFrRAOYMGiW2Lzk2cuXXQyMDha8MMgHyvW+xDtm2TUb0lT
         Xp9o2lqTH6yoGaToC9kTmQSI9EUjFgD3LTn2p0ido/l1sMPP/9YJ9cmNzuEkcSlfR0xp
         8FjJrCqrOrT6ULRh9+9F0rMqaVkzk3INjPL4yZLhA2z72dHItAacB3yIH5kxLePDSn9+
         g/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KwEuYR87HPnv/4ymC/dnp2PQlBlu56yCgjQvKHxqMDY=;
        b=SUsmDYbSOOkuR0QBIPDcyFxKnNgireDJ0hbq3tftjdtUa2qCc8DGRGIQRX30FoBIVn
         2BmTV87lk9e17GhCxdn/KdcyqKBBhw+9VInCRCazEAjPNMY4Tcr60hIZqdauF9RxLP7e
         gNtp809cBAUSlzRg5RC/yxOCShXZMQvoCd7KM+rX8ltehRZOxNZi2QlvMBzVr8+zdi68
         hUD2+H93UUybqwljY/MAAZfEUsC+0Kgo1NPYHQGmrZ0VvW1vGVz5CDc1YLAjWgB253+q
         x0wncA+9ybc/6yvIblm1QXLjubqG4k9aai5UGam+qKpWsYrsxOmf7BGfTM7tBU4sELz5
         TBwQ==
X-Gm-Message-State: APjAAAW0NvBuNViFiR1UdPZutls+N+kr3hRYwZVd13xywI1+AdYdOsjs
        8dqHSMOWLP6e72ZiVTo7oufJE9IH
X-Google-Smtp-Source: APXvYqxmTxXEY5vMcZWG4jH8CSBGkoA4x0BOwlghuIDIyUC1kokmfk535VYCa85Dwfz07DZx6o+BCw==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr42861942plq.27.1571245262316;
        Wed, 16 Oct 2019 10:01:02 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 4sm2988525pja.29.2019.10.16.10.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:01:01 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:00:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 05/14] software node: clean up
 property_copy_string_array()
Message-ID: <20191016170059.GE35946@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-6-dmitry.torokhov@gmail.com>
 <20191015120726.GG32742@smile.fi.intel.com>
 <20191015181211.GD105649@dtor-ws>
 <20191016075300.GO32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016075300.GO32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2019 at 10:53:00AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 15, 2019 at 11:12:11AM -0700, Dmitry Torokhov wrote:
> > On Tue, Oct 15, 2019 at 03:07:26PM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 11, 2019 at 04:07:12PM -0700, Dmitry Torokhov wrote:
> > > > Because property_copy_string_array() stores the newly allocated pointer in the
> > > > destination property, we have an awkward code in property_entry_copy_data()
> > > > where we fetch the new pointer from dst.
> > > 
> > > I don't see a problem in this function.
> > > 
> > > Rather 'awkward code' is a result of use property_set_pointer() which relies on
> > > data type.
> > 
> > No, the awkwardness is that we set the pointer once in
> > property_copy_string_array(), then fetch it in
> > property_entry_copy_data() only to set it again via
> > property_set_pointer().
> 
> Yes, since property_set_pointer is called independently
> on the type of the value.

We still call property_set_pointer() independently of the type of the
value even with this patch. The point is that we do not set the pointer
in property_copy_string_array(), so we only set the pointer once.

We used to have essentially for string arrays:

	copy data
	set pointer in dst
	get pointer from dst
	set pointer in dst

With this patch we have:

	copy data
	set pointer in dst

> 
> 
> > This is confising and awkward and I believe it
> > is cleaner for property_copy_string_array() to give a pointer to a copy
> > of a string array, and then property_entry_copy_data() use it when
> > handling the destination structure.
> 
> We probably need a 3rd opinion here.

I think I can still convince you ;)

Thanks.

-- 
Dmitry
