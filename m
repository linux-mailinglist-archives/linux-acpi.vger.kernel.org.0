Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502F4D7E7F
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 20:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfJOSJd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 14:09:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38896 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfJOSJd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2019 14:09:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so12980880pfe.5;
        Tue, 15 Oct 2019 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62+UvjhVj4PZqlBOSItwZ7z6d9zXJ9mRJozCye0lC6A=;
        b=Q7kKCDTRa2hDiCA8hPhj6+ACbtfgnHCOU1AtP6ne6UyD08NeAV5Xy7ms/ls0aVsQlI
         +HSZ+STfRMtY6Pqpy9zoR4EW+bR9Im2xyU/m7LQ+9Y0BHADomGF7chpOLNWpQ9/z8hTw
         HwrdZHlvJ8gRvoWjj6AV0MqKEqGAcLAmT2W+v5Rp2ymq336v8TFKUt4Iw37aZRvxA88b
         OVauuGWQXtzmDiK2sXkRqpSMKCMWXcZjPtKxpVfhxAA9YhrCCiGwPMBEI0qjA82LMlc/
         iAPr/rdTrs+BgW+y4mdL10Kr8I2SSHmslCJwGysecYP5Ic6RR7AVXqIi1nCPC3UE+ddW
         Pl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62+UvjhVj4PZqlBOSItwZ7z6d9zXJ9mRJozCye0lC6A=;
        b=Lyh9imdVaiSIC9RdrWANUbs+blxbNsGjhL1SYzbefKXIJBkxY/gs5in9tYernB5qUo
         nFjqUacOT7nwvXWMctEJwD13g15hYlGTwXZG9IpYEg7/ZyzpR6jh7LJ4EAySeB4QV2aS
         4/6VV0zEcNKIknzUS0ezVeGA4rdswjBnx2jKHXll8FVsUAMfeKCPoEE3lUwkBnQHCJhY
         NZKgELgHZBS02O8uvvfnR8YuQ7ngPCpMKZR8RS7DW+tuhyi/BlvDeP83lb4EguIdHkR0
         /ZZUMhz8ZecxiOrtrAkH0ImDGuSr1+5CDiY8M673g52Ec13KlI/92TZZBdoHepwwPCMs
         OR/g==
X-Gm-Message-State: APjAAAVNyiZoXGtOaCJwzXNC2LaeGT4Hk+61lbMe86BDy7uJqqXV1PdK
        topt/9GwfnE786GO4IO3nOA=
X-Google-Smtp-Source: APXvYqwt0Gh6CCpQ/dWNjZyyYxiMGcFeaVhnTfrL5j3a7lrELEUCNWH0touy4gxSaQ4Hl4bx9NhGMQ==
X-Received: by 2002:a17:90a:cc12:: with SMTP id b18mr42015957pju.141.1571162972322;
        Tue, 15 Oct 2019 11:09:32 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i10sm27447578pgb.79.2019.10.15.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:09:31 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:09:29 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 04/14] software node: mark internal macros with double
 underscores
Message-ID: <20191015180929.GC105649@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-5-dmitry.torokhov@gmail.com>
 <20191015120350.GF32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015120350.GF32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 15, 2019 at 03:03:50PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 04:07:11PM -0700, Dmitry Torokhov wrote:
> > Let's mark PROPERTY_ENTRY_* macros that are internal with double leading
> > underscores so users are not tempted to use them.
> 
> We may undef them at the end of file, right?

No... the macro substitution happens at the point of final use, so
somewhere in .c file.

Thanks.

-- 
Dmitry
