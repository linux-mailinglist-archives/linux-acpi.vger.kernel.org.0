Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A31D97F6
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 18:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfJPQye (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 12:54:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36572 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfJPQye (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Oct 2019 12:54:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23so14646749pgk.3;
        Wed, 16 Oct 2019 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VWaIAT+NIDKyZZqlxsr5yjIRMKyrU2W1SmxhpCA3akw=;
        b=CX9jJvlCJgqdx644ullcaHmHVFaLYUbiQLuRkMSy1pZwwRhIKLBvQvRgTtCC16ag/U
         3GC67I3dPFUAIe5+8cAr2O3T4kVxFvMVSWGovbHCxQdb2YJT8EC4XCR1RrXyJNcuTvN1
         IUmKI8pMEgYbgkFCywzY8WWLTFv5RzlHUlYriN9p6bkHJ1eWAE3QTfC87vqy5YxBuvLh
         BTP7QMbWuA8mTjZ33boNGOyO/esbkgXNSbJPX6lyCXgS7xl1nsdE4BDuO3mGuv2Z19ti
         IGuqzbr34/Tb1TCYQezYnfZ6TGIv+TU34ATEl+YtTrS/687b2T5SGlps9JOglirLaS9K
         j5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWaIAT+NIDKyZZqlxsr5yjIRMKyrU2W1SmxhpCA3akw=;
        b=kMO+VhNDMEECTF/PArgXc38IVFES7ninio6+SnDbXxYJO0i1+XPEPXIyue6az2GmWx
         30FcnNduZCPtMrlqsrWT/d3SVS1W02LyV76D7KsmhodyyCTBd0EJlQpZAZSIubS+pt6Y
         VkJAH80/rHIznZoaHaHX+V9cVQ3MUSAwPQ0nvWuBAsVV6WKYn163kKmIcf4T3Kki0Ft1
         k+p413G/M1aCMmqn1L6rAHEwxW2PWtfTXNNPxrWrYmRaPiqEEPS6J+jzWpcwckAPSAgS
         uIN+Ze+dIePukM4GHZSJYRdMNQna0LcWaP1iF9DbnpiR8v6Q28+yVhHFXb95UtauSWtA
         42VA==
X-Gm-Message-State: APjAAAX8ngkRAJ1uh5yY/Pz1ZeUF1tDh3KddZPQoPPgkbe3uerQqcKrj
        0ClDBqRU/AOtXjHxNAkjnqE=
X-Google-Smtp-Source: APXvYqwS5IJwPJhOsLM+llJ8huzG+KnbDTsk7VAndmiSyqCoCvrSTXYRJcIRhsrVPy3hVniVV6U5jA==
X-Received: by 2002:aa7:8e16:: with SMTP id c22mr45557155pfr.116.1571244873756;
        Wed, 16 Oct 2019 09:54:33 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h4sm25090979pfg.159.2019.10.16.09.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 09:54:33 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:54:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 10/14] software node: rename is_array to is_inline
Message-ID: <20191016165430.GD35946@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-11-dmitry.torokhov@gmail.com>
 <20191014073720.GH32742@smile.fi.intel.com>
 <20191015182206.GF105649@dtor-ws>
 <20191016075940.GP32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016075940.GP32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2019 at 10:59:40AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 15, 2019 at 11:22:06AM -0700, Dmitry Torokhov wrote:
> > On Mon, Oct 14, 2019 at 10:37:20AM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 11, 2019 at 04:07:17PM -0700, Dmitry Torokhov wrote:
> > > > We do not need a special flag to know if we are dealing with an array,
> > > > as we can get that data from ratio between element length and the data
> > > > size, however we do need a flag to know whether the data is stored
> > > > directly inside property_entry or separately.
> > > 
> > > > -	if (prop->is_array)
> > > > +	if (!prop->is_inline)
> > > 
> > > > -	if (p->is_array) {
> > > > +	if (!p->is_inline) {
> > > 
> > > > -	if (src->is_array) {
> > > > +	if (!src->is_inline) {
> > > 
> > > May we have positive conditionals instead?
> > 
> > I was trying to limit the context churn. I can definitely change
> > property_get_pointer(), but the other 2 I think are better in the
> > current form.
> > 
> > > 
> > > > + * @is_inline: True when the property value is stored directly in
> > > 
> > > I think word 'directly' is superfluous here.
> > > Or, perhaps, 'stored directly' -> 'embedded'
> > 
> > I'm OK with "embedded".
> > 
> > > 
> > > > + *     &struct property_entry instance.
> > > 
> > > > + * @pointer: Pointer to the property when it is stored separately from
> > > > + *     the &struct property_entry instance.
> > > 
> > > 'separately from' -> 'outside' ?
> > 
> > Umm, I think I prefer "separately" actually.
> > 
> > > 
> > > > + * @value: Value of the property when it is stored inline.
> > > 
> > > 'stored inline' -> 'embedded in the &struct...' ?
> > 
> > I was trying to have a link "stored inline" -> "is_inline".
> > 
> > Do we want to change the flag to be "is_embedded"?
> 
> In dictionaries I have
> 
> embedded <-> unilateral

Are you trying to show synonym or antonym here? But I am pretty sure
"unilateral" is either.

Antonyms for our use of "embedded" are likely "detached" or
"disconnected".

> inline <-> ???

"out of line" but I still believe "stored separately" explains precisely
what we have here.

Thanks.

-- 
Dmitry
