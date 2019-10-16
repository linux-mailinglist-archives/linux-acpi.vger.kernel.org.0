Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE2D9644
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 18:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391748AbfJPQBk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 12:01:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37061 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406061AbfJPQBc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Oct 2019 12:01:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id u20so11487363plq.4;
        Wed, 16 Oct 2019 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VS8Uu9XK5BYTkXggZlLRkkUxjyNh72QfWUUWr6EbcIw=;
        b=FCCfI0klLQS4Z10j8a1gIL9eEdoCIDOTwlIxRe+brd8tt5hCVC3BQmQYA/ysjE5VnZ
         /tYu+pzk/Z86PPN+4tWnwQYjJOwMTBWNSrYqW4vuEBvfiTePimU/Exd1azq+Ukl8fTjW
         Omr1gBKfg/DlYYDQeyAei7PW1B9OxXQe4foYjVRel4TxiDxB2NIeJFCl4gWlFT+puw/q
         o9kz4hWfuPQssQZCIGmyeDCV5CtKYXWfIv9nrA4kiRtpQDovSpT/eP198g0hM2qcu9Kc
         o0FKMahbxxatLHomN/1uDGTB5DEo+zDebecv7Twe6gFOaCbPVBTCG29RDh486x6egQna
         gMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VS8Uu9XK5BYTkXggZlLRkkUxjyNh72QfWUUWr6EbcIw=;
        b=KmXqi25tBxd+l619QPbrdG9vHoTf9/nbxA1cMQ2pLvr6pa+h4UVoJDHvyGsr4iK2Tw
         d+AmuTnog7QzGEcfppXNNKO5VxL8l6manvabdYPlbqU0ks8xKH8BjnW7F51U6/yE3Mbs
         bhLfQMrj/Iq114IivNJS9LYtZTcalgZFSU7sISHgTnK6Hbt/+I+1IpSr3oTyJcoeDdT3
         9r7bPWR1gQgW4UD0NExo1E1iVlmq+n8l7iFsyytd7hOeZSspD8NJouwrcp6PjStx3rHJ
         ZzrGOjh6aebOVgoDWyqv/wrRlHrrOnrMWR1dr1zjBUGiShiSNu6HLDqcYqGbP2Om1dHE
         80rg==
X-Gm-Message-State: APjAAAXuHD4xmEg8Vud/O1657aFSHLtEjr8iy6oJNF0JJyIHIoLy6pe5
        A+37rc/bZOxcNTmvu32ZhoSrVDha
X-Google-Smtp-Source: APXvYqzMMiW8EFwqe9wnTpSPSy4ylIuRniI/O8VbWuqZbnC/HrQraMYZeYYjbDNiqE8h/l9g5dgjxw==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr42268039plp.172.1571241690785;
        Wed, 16 Oct 2019 09:01:30 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i37sm3092913pje.23.2019.10.16.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 09:01:28 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:01:26 -0700
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
Message-ID: <20191016160126.GB35946@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-12-dmitry.torokhov@gmail.com>
 <20191015122028.GI32742@smile.fi.intel.com>
 <20191015182553.GG105649@dtor-ws>
 <20191016074857.GN32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016074857.GN32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2019 at 10:48:57AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 15, 2019 at 11:25:53AM -0700, Dmitry Torokhov wrote:
> > On Tue, Oct 15, 2019 at 03:20:28PM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 11, 2019 at 04:07:18PM -0700, Dmitry Torokhov wrote:
> > > > When copying/duplicating set of properties, move smaller properties that
> > > > were stored separately directly inside property entry structures. We can
> > > > move:
> > > > 
> > > > - up to 8 bytes from U8 arrays
> > > > - up to 4 words
> > > > - up to 2 double words
> > > > - one U64 value
> > > > - one or 2 strings.
> > > 
> > > Can you show where you extract such values?
> > 
> > the "value" union's largest member is u64, which is 8 bytes. Strings are
> > pointers, so on 32-bit arches you can stuff 2 pointers into 8 bytes,
> > while on 64-bits you have space for only one.
> > 
> > > 
> > > > +	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
> > > > +		/* We have an opportunity to move the data inline */
> > > > +		const void *tmp = dst->pointer;
> > > > +
> > > 
> > > > +		memcpy(&dst->value, tmp, dst->length);
> > > 
> > > ...because this is strange trick.
> > 
> > Not sure what is so strange about it. You just take data that is stored
> > separately and move it into the structure, provided that it is not too
> > big (i.e. it does not exceed sizeof(value union) size).
> 
> You store a value as union, but going to read as a member of union?
> I'm pretty sure it breaks standard rules.

No, I move the values _in place_ of the union, and the data is always
fetched via void pointers. And copying data via char * or memcpy() is
allowed even in C99 and C11.

But I am wondering why are we actually worrying about all of this? The
kernel is gnu89 and I think is going to stay this way because we use
initializers with a cast in a lot of places:

#define __RAW_SPIN_LOCK_UNLOCKED(lockname)      \
        (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)

and C99 and gnu99 do not allow this. See
https://lore.kernel.org/lkml/20141019231031.GB9319@node.dhcp.inet.fi/

Thanks.

-- 
Dmitry
