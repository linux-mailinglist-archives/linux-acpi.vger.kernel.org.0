Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A013DB1BC
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 18:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439156AbfJQQAv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 12:00:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43997 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436580AbfJQQAv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2019 12:00:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so1927035pfo.10;
        Thu, 17 Oct 2019 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bKHsm49AjH+9+kS10xeon3ScfYzXimBKCUXUhQczC7c=;
        b=Jpj35KVo3sVfoKljx8sot28XsdRaIvkCMLBzWb6ssHzRgOFI+FN4uKedm44mjoDrGG
         KsGYXZE5gJ3gxbO9dga++kYO/US86ElI0Jz/QWSN/N1H1pMOnBGsBvEV0IqRmPT7JyBI
         6CKKU86QwjL6k3026BX6S/KoJrl0N03SFf6OvJgwFn0NpBwNIzbfVM+7jM6oieiq3Uyy
         wcIWZkUbloVvbhh4rFzcWJtDVBcnFcb4u/0CaaShng1iWg2SbGMWd9ymJb88Ncv5Ncsl
         egttf6ReYdLp2EWOAWaKmsZrdbgLlcq3+A3qLPd4mnidRb9svzpyDIP4zcQKS5iACMFY
         LJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bKHsm49AjH+9+kS10xeon3ScfYzXimBKCUXUhQczC7c=;
        b=Ri/D+WRmVfl9IfiZCeG9NnI8W3vjmz/jLq+5KUk/HNnrVqlSbkrbKb7bWR6l054xW0
         AqhSINKazIy/sxSyo6P2Lntkrho8/ntLwuNcrQT9y0RlTlNaR6x74/3nZsptHjNozzgQ
         h3uvjUEsTX9Dj5jjWxlonn7iiH/kXC3WNX/4X5A/8zZXud0rLP7SCR4NTdQ1spuA2fg7
         +AXbtyiIiHH0oWO/urm3wo/TSocdBs83Lqt3K9noGF6TIGX53yZ09Db8cLXx9KdEbeu2
         uyY3bmFJa4iPpTVC08jt+ioWqHnPsRXebMi/fsNiETB7aEpiVNVEM9K3s7Dyb9zkEQ9e
         GUMQ==
X-Gm-Message-State: APjAAAWawKHXhYd5p8P6SJ9/4mNqzzHbjHvhwJ/XJG5sbDhJvIoVsSkz
        TFiZ8REgfzCJ4s3eXI7el9xKdWPW
X-Google-Smtp-Source: APXvYqxdUs3K8kdiwaLrIGbUOjwLrBiCkBP9lXNhqoPWli5kV2DcKOLnS8b57cZ07KNDaTySvpea2Q==
X-Received: by 2002:a17:90a:356a:: with SMTP id q97mr5232709pjb.50.1571328050138;
        Thu, 17 Oct 2019 09:00:50 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w134sm3502756pfd.4.2019.10.17.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 09:00:48 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:00:46 -0700
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
Message-ID: <20191017160046.GF35946@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-11-dmitry.torokhov@gmail.com>
 <20191014073720.GH32742@smile.fi.intel.com>
 <20191015182206.GF105649@dtor-ws>
 <20191016075940.GP32742@smile.fi.intel.com>
 <20191016165430.GD35946@dtor-ws>
 <20191017071628.GD32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017071628.GD32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 17, 2019 at 10:16:28AM +0300, Andy Shevchenko wrote:
> On Wed, Oct 16, 2019 at 09:54:30AM -0700, Dmitry Torokhov wrote:
> > On Wed, Oct 16, 2019 at 10:59:40AM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 15, 2019 at 11:22:06AM -0700, Dmitry Torokhov wrote:
> > > > On Mon, Oct 14, 2019 at 10:37:20AM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Oct 11, 2019 at 04:07:17PM -0700, Dmitry Torokhov wrote:
> 
> > > > > 'stored inline' -> 'embedded in the &struct...' ?
> > > > 
> > > > I was trying to have a link "stored inline" -> "is_inline".
> > > > 
> > > > Do we want to change the flag to be "is_embedded"?
> > > 
> > > In dictionaries I have
> > > 
> > > embedded <-> unilateral
> > 
> > Are you trying to show synonym or antonym here? But I am pretty sure
> > "unilateral" is either.
> 
> Antonyms. The 'unilateral' is marked as so in the dictionary.

OK, that is not something that I would ever think of as an antonym, so
even though I am not a native speaker I do not think we should be using
it here as documentation and comments are supposed to be understood by
all people from around the world and not by English majors only.

Out of curiosity, is this dictionary available online? I would really
want to see to what particular meaning of "embedded" they assign
"unilateral" as antonym so that I know better next time I see it used.

> 
> > Antonyms for our use of "embedded" are likely "detached" or
> > "disconnected".
> > 
> > > inline <-> ???
> > 
> > "out of line" but I still believe "stored separately" explains precisely
> > what we have here.
> 
> No, 'out of line' is idiom with a special meaning.

Yes, and it is also a well defined term in CS.

Thanks.

-- 
Dmitry
