Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A09AF0AA9
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 00:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfKEX5C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Nov 2019 18:57:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39785 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfKEX5A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2019 18:57:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so14132428pfo.6;
        Tue, 05 Nov 2019 15:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lyd/uQwCMyHvu0EwXvw/80bYdPYYHY4g1rXnVpIYvtQ=;
        b=QUBzc0rQ+6OSXZ6QoHFh7qoNgThIJgzdzc+UcxyU3G/RUF4bLMI8JGxLftWHgt2X7H
         nmHUOLAxFBgQFQgeu/QJoC3WRDETTCsdRAB5L89zXLZGvUqwy5AJZYzQWMb5uEDY1hVC
         ncY/51LRWT+JvGoOqhJqo896nyMeRsDLO/QQaU2MbluuwnchgsOijC6iB6WnL+VNtt2I
         xVcnV7j4QY86iD4aEZJ1cWcUlo3ZcgHwDRKfe4toB1OSf6Eu+uXgLzdSmTpAFZAmHNg1
         QivA+SZSuL29lwcneC10YMMvbvpLTXPn9km3/HrkOa08C1rXu0puE5rmtQ8xOZXF8tUc
         h4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lyd/uQwCMyHvu0EwXvw/80bYdPYYHY4g1rXnVpIYvtQ=;
        b=ZANrDJl5eC6fW3M8tvzTv/FxYeuknppAWmyD1Fb0q33GIMCIAgAJ+q1Ov2qF/jjL67
         XS1s9P7zASTXVo0YKzu60oAeUD9NQe6E4rDlGoVQnzP8gODn6reTX92CsMRjsEU2F01G
         oGbQZEKti7XQKrEVscbIj6fUqiKp4PvGM5EgEKhm41EIAvp5zELIR/ZkbkgTA/S+VQhQ
         mWUZp45yuj44Mm3RDYbxV8z1J1ru17Frszm3/AX1OXCYk2TgSuBIuDC/By00RClXkwVu
         Pz0kbjK3/EOqxjutTdIh+PHpSV7Qb5xMjtSWDXWK8Q8aeS0L438AVP1yq26yrXg6IMIZ
         4PNA==
X-Gm-Message-State: APjAAAVgCIjHGzRPrgVFHv8ch9rt9pXkIxPbdE2rvDo1UiesM16k1s5I
        /EDgeaIjsZgZs18Y4Hvh2dl5fBj8
X-Google-Smtp-Source: APXvYqw1tZlGJpnft6JBqkIg80ds5OGJJXsVz3MvtryZMlCAINilHgvNVbjSVNUMeenci+2YHQO2CQ==
X-Received: by 2002:a65:404b:: with SMTP id h11mr39237598pgp.28.1572998218903;
        Tue, 05 Nov 2019 15:56:58 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q34sm564387pjb.15.2019.11.05.15.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 15:56:58 -0800 (PST)
Date:   Tue, 5 Nov 2019 15:56:56 -0800
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
Message-ID: <20191105235656.GW57214@dtor-ws>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
 <20191023200233.86616-12-dmitry.torokhov@gmail.com>
 <47671501.dVG71sAca0@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47671501.dVG71sAca0@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Wed, Nov 06, 2019 at 12:42:02AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, October 23, 2019 10:02:29 PM CET Dmitry Torokhov wrote:
> > When copying/duplicating set of properties, move smaller properties that
> > were stored separately directly inside property entry structures. We can
> > move:
> > 
> > - up to 8 bytes from U8 arrays
> > - up to 4 words
> > - up to 2 double words
> > - one U64 value
> > - one or 2 strings.
> 
> Yes, we can do that, but how much of a difference does this really make?

Arguably not much I think, but it was pretty cheap to do.

> 
> Also, how can one distinguish between a single-value property and an inline
> array which this change?  By looking at the length?

We do not really need to distinguish between the 2. The device
properties API is typically wrap single values around arrays (i.e. it is
perfectly fine to use scalar API to fetch first element of array and use
array API to fetch a scalar). So we have property of certain type with
certain number of elements, and it can either be stored inside
property_entry structure, or outside of it. They are 2 orthogonal
concepts.

> 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/base/swnode.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index 18a30fb3cc58..49e1108aa4b7 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -280,6 +280,16 @@ static int property_entry_copy_data(struct property_entry *dst,
> >  	if (!dst->name)
> >  		goto out_free_data;
> >  
> > +	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
> > +		/* We have an opportunity to move the data inline */
> > +		const void *tmp = dst->pointer;
> > +
> > +		memcpy(&dst->value, tmp, dst->length);
> > +		dst->is_inline = true;
> > +
> > +		kfree(tmp);
> 
> This would have been more useful if we had been able to avoid making the
> allocation altogether.

OK, I can do that and re-send this patch and the one with the tests. In
the mean time, can you please consider patches 12-14? They can be
applied even if you temporarily drop this one (#11).

Thanks.

-- 
Dmitry
