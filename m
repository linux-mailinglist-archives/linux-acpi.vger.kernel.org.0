Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1094AF3CE0
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 01:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfKHA2s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 19:28:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45102 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKHA2s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 19:28:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id w11so2969270pga.12;
        Thu, 07 Nov 2019 16:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XOYj8fwd6G13bfB6dw7/4NRGSZvNUGATw6lJpkiiYaM=;
        b=HjepFhLAHHGMXWfYoZsWU1XQuk06LTghgV8wYT/gX3RxT3xx8+LZfeLNmJiIJhPOF9
         bxPwy4YkMtd40gtKIInMhP0kXius8osRpeZcm5l01c4ntTIG5UQDrVto96durcZgFRfV
         VB9FbsRLj68JGvbfoAfY5FTmvgy0dkXN2u7A9oh+vO/sXNnTBVK2FW5Y0aPNI0K3UrRW
         WbsmJhhJZeMnnrF67vhyorkSx+Ul5HcG4RxfL72PvDJ2Bjk0DrIw0eMpb3K1B4H+o+AI
         NvjqpT45kA8r4pqbsm/MehPVrbua68glFdW0STE2LwLC5SNh3HHXKJ3iFiCJLXPeF8E0
         ZFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XOYj8fwd6G13bfB6dw7/4NRGSZvNUGATw6lJpkiiYaM=;
        b=J7eK19qH53LrQKN0uvAArsBNL6EFwssEnbpri6nZsABq5ObQkEmUghe3MP4FVDAaaD
         +O+YRve1VvDvwITsHKPao5q/GTSiGUN3/6mJAeIytJhXjkLyaOONLumDA4uo/Y/M3eRI
         2nnh/Q7UFTVVl+ByfgelwDD7jKUnYwpu6IQZl/1snxNdUGy7sN/EJ5LctBDXivXGMNpJ
         ql47aERuvKCAPgInAMhh+CoKWOJg6DmAmKRPu+xZYfaLNViAOP1wh8jh7fBGt9hqxDAW
         h3BZq4DcQywXWUsELPwLjcVh0/VMsTtCEgqhYXJd0KCisIBZks7S24tkLPNTb4X+aqjP
         7a3w==
X-Gm-Message-State: APjAAAXwLaxBu+Q6WTMsALK9V1UQmZeSv5OO7xWFRrSBCqY67dwhxOYH
        I1bRgMwz8ne9yn78y0/+RO82C3IU
X-Google-Smtp-Source: APXvYqwDXVUG1PhSxibzdMEVEc2Jh8krEpZCg7wIuQ4j/1aj8LCH9y8ODJ8QwE6WItaRHlRyohawSw==
X-Received: by 2002:a63:9543:: with SMTP id t3mr8305265pgn.350.1573172926768;
        Thu, 07 Nov 2019 16:28:46 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f25sm4758197pfk.10.2019.11.07.16.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 16:28:46 -0800 (PST)
Date:   Thu, 7 Nov 2019 16:28:44 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v6 11/15] software node: move small properties inline
 when copying
Message-ID: <20191108002844.GX57214@dtor-ws>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
 <47671501.dVG71sAca0@kreacher>
 <20191105235656.GW57214@dtor-ws>
 <3310518.lfHdziMng4@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3310518.lfHdziMng4@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 08, 2019 at 01:04:31AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, November 6, 2019 12:56:56 AM CET Dmitry Torokhov wrote:
> > Hi Rafael,
> > 
> > On Wed, Nov 06, 2019 at 12:42:02AM +0100, Rafael J. Wysocki wrote:
> > > On Wednesday, October 23, 2019 10:02:29 PM CET Dmitry Torokhov wrote:
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
> > > Yes, we can do that, but how much of a difference does this really make?
> > 
> > Arguably not much I think, but it was pretty cheap to do.
> > 
> > > 
> > > Also, how can one distinguish between a single-value property and an inline
> > > array which this change?  By looking at the length?
> > 
> > We do not really need to distinguish between the 2. The device
> > properties API is typically wrap single values around arrays (i.e. it is
> > perfectly fine to use scalar API to fetch first element of array and use
> > array API to fetch a scalar). So we have property of certain type with
> > certain number of elements, and it can either be stored inside
> > property_entry structure, or outside of it. They are 2 orthogonal
> > concepts.
> > 
> > > 
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > >  drivers/base/swnode.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > > > index 18a30fb3cc58..49e1108aa4b7 100644
> > > > --- a/drivers/base/swnode.c
> > > > +++ b/drivers/base/swnode.c
> > > > @@ -280,6 +280,16 @@ static int property_entry_copy_data(struct property_entry *dst,
> > > >  	if (!dst->name)
> > > >  		goto out_free_data;
> > > >  
> > > > +	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
> > > > +		/* We have an opportunity to move the data inline */
> > > > +		const void *tmp = dst->pointer;
> > > > +
> > > > +		memcpy(&dst->value, tmp, dst->length);
> > > > +		dst->is_inline = true;
> > > > +
> > > > +		kfree(tmp);
> > > 
> > > This would have been more useful if we had been able to avoid making the
> > > allocation altogether.
> > 
> > OK, I can do that and re-send this patch and the one with the tests.
> 
> But if you do that, IMO it would be prudent to extend the definition of
> struct property_entry like this:
> 
>  struct property_entry {
>  	const char *name;
>  	size_t length;
>  	bool is_array;
>  	enum dev_prop_type type;
>  	union {
>  		union {
>  			const u8 *u8_data;
>  			const u16 *u16_data;
>  			const u32 *u32_data;
>  			const u64 *u64_data;
>  			const char * const *str;
>  		} pointer;
>  		union {
>  			u8 u8_data;
>  			u16 u16_data;
>  			u32 u32_data;
>  			u64 u64_data;
>  			const char *str;
> +			u8 u8_buf[sizeof(u64)];
> +			u16 u16_buf[sizeof(u64)/sizeof(u16)];
> +			u32 u32_buf[sizeof(u64)/sizeof(u32)];
> +			char char_buf[sizeof(u64)];
>  		} value;
>  	};
>  };
> 
> to make it clear that the value field is going to be used as an array in
> some cases.

Sorry, just sent out updated series before receiving your email. I can
cook up new patch cleaning this. I think we can drop scalars and only
have arrays and have initializers use <type>_data[0] to create initial
property entries.

> 
> > In the mean time, can you please consider patches 12-14?
> 
> I cannot find drivers/platform/x86/intel_cht_int33fe_typec.c in the mainline,
> so I cannot apply patch [13/15] now and I'm not sure how useful it would be
> to apply patches [10,12/15] without the other two.

Hmm, drivers/platform/x86/intel_cht_int33fe_typec.c used to be
drivers/platform/x86/intel_cht_int33fe.c I think.

I can either regenerate against your tree instead of -next (but then
there will be merge conflict) or we could postpone #13 and #14 (or #5
and #6 in v7) till after merge window.

Please let me know.

-- 
Dmitry
