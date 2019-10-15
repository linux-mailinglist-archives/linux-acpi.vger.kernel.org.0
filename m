Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A545D7ECE
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 20:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfJOSWL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 14:22:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34267 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfJOSWL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2019 14:22:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so13020395pfa.1;
        Tue, 15 Oct 2019 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B0ZQCxvBi0y2iOrN3mpMsR3fw1XURF/DFzcwKIrxLgI=;
        b=W4rVJXeLoirv8jlO9UIRClLvUd/SJQKQg21q+noq0ZEBXMh7Habf2KXXOpgnObeazJ
         6qpeuF/Z4LZN8PllE9Htd3mAyvIyNVB91kMyVcKn9/4yI+8C30LHETKNNxIFNlyhgbGS
         wEi9vz7m57w8S9lLRi8tEniIR8TK91Sndgy+lgyVFyu2UJZLSiBh7JMj8/u2iUwhqg2C
         QMV2+7JUALk2sdOpTbLmQl1GGJ8nB8IcREtyDp0Ax2Vvxm4fY+46Y+UPJKgJfDS/DOcd
         9cZ4yzdt8YNrupdBLz4hOHBszxMBB9jGf2tccjrbpDpCs9pGuEBFJtdliK7Tbk73AY/U
         xeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B0ZQCxvBi0y2iOrN3mpMsR3fw1XURF/DFzcwKIrxLgI=;
        b=U3PJ/CMYz95ay9HPtLXWpYNGNT7QAO0NOFuk7gdSJgOr8U37imKrb8mOLIln9vuJW2
         nUE9JmTPdrUZJFhAS/I0qZISC+tm0fZbLPYwOaLsM0s5OCq2Xga2z4Pydq4t3V3yvRaF
         gwk291EoLDxBUiCT75J+e5W6Yc9MCTLIPK4U7kcjwLFpZ1qTFh0wAJKKuwZwkOG9TVu6
         EdHbUclC5rYAA3rXrROwgAqYnlQ4pKwBN5E0EfabikoOdcgQRl7+1i40cBxJs6wb5GGQ
         apsfHHA8uA7kIKXK3O0TrmPxfraDRfvHVVqIQKTM7mi/0sM9GbcDj7kIEq/cJxrmqPNK
         rwWw==
X-Gm-Message-State: APjAAAXmaCpd/2Je8LPhXyvFUCzJRnLzRF81shIW394e3wmlwLmf33nO
        T/sj883cFeYAbRHm9GmsHzY=
X-Google-Smtp-Source: APXvYqyS0y9uov8WuqQrc7h/cNRoVI01vyrxz+6+qncO1Kb9LXBgyx34I+o0+rVjFXVbD98fUz+gDg==
X-Received: by 2002:a63:e145:: with SMTP id h5mr40644649pgk.447.1571163729964;
        Tue, 15 Oct 2019 11:22:09 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b69sm31692842pfb.132.2019.10.15.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:22:08 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:22:06 -0700
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
Message-ID: <20191015182206.GF105649@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-11-dmitry.torokhov@gmail.com>
 <20191014073720.GH32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014073720.GH32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 14, 2019 at 10:37:20AM +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 04:07:17PM -0700, Dmitry Torokhov wrote:
> > We do not need a special flag to know if we are dealing with an array,
> > as we can get that data from ratio between element length and the data
> > size, however we do need a flag to know whether the data is stored
> > directly inside property_entry or separately.
> 
> > -	if (prop->is_array)
> > +	if (!prop->is_inline)
> 
> > -	if (p->is_array) {
> > +	if (!p->is_inline) {
> 
> > -	if (src->is_array) {
> > +	if (!src->is_inline) {
> 
> May we have positive conditionals instead?

I was trying to limit the context churn. I can definitely change
property_get_pointer(), but the other 2 I think are better in the
current form.

> 
> > + * @is_inline: True when the property value is stored directly in
> 
> I think word 'directly' is superfluous here.
> Or, perhaps, 'stored directly' -> 'embedded'

I'm OK with "embedded".

> 
> > + *     &struct property_entry instance.
> 
> > + * @pointer: Pointer to the property when it is stored separately from
> > + *     the &struct property_entry instance.
> 
> 'separately from' -> 'outside' ?

Umm, I think I prefer "separately" actually.

> 
> > + * @value: Value of the property when it is stored inline.
> 
> 'stored inline' -> 'embedded in the &struct...' ?

I was trying to have a link "stored inline" -> "is_inline".

Do we want to change the flag to be "is_embedded"?

Thanks.

-- 
Dmitry
