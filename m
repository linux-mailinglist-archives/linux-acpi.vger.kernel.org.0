Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8BAEA674
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2019 23:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfJ3WnJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Oct 2019 18:43:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32778 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfJ3WnI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Oct 2019 18:43:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id u23so2538452pgo.0;
        Wed, 30 Oct 2019 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y0oPUoFzTii7ISlKgBqFiFMQKVFEygUTi9cyMnkiLCk=;
        b=Hu5aYBUcdoSDd90QlvKV/W8VXrJZeQw3jJdITe9I0iSl/Lt8Jm0Y03uMXbwhymKSe1
         Eg/QToOWKxh6uOdgU38ghvs1Y+zwBpbgMmqRxZsgR8j4cK+EoLtPQvFUNwLEdfAHiXkH
         1fKRURZoRJJU01e0ljT5raVLUFZaONGBW+vEwoH8mUBFQYqFCDM8jdlGYloZBCPlq770
         VDvAAYHT5RF8XtZmrHoVbaLJyu7CMVcvgnXLeXKDDGPw6v7IZSIhn26BQDlHKFO0D6xM
         pdkczxZlkBPvfxnEqve1mTorhjZJYw/jaiyDvaCeAttFaU+m6qECOYbFWGJmsMTpcDvZ
         vEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y0oPUoFzTii7ISlKgBqFiFMQKVFEygUTi9cyMnkiLCk=;
        b=RG44ZwCbdHn3cAb+J88iYW5ZCag1KqaYf0F1/45q0g0HCq4ngFW7QThtpx9QggN0Go
         VlebkohWH1LfL3+oRyXfGhVrxATscnJV2ZX+8/dwGPgcE8ZLThYdtFpe+k+aE5xJrBRW
         Vf9SUrO6lbmrBLJnBrB7kAxoinhcgcFXAHQ4jnPvxA8JMWzQ/zuKPp3vuEnQX+33hQfq
         kQN9XHrzQe5gW17SA1M6exDVhYunIGQsHyRO8iJ/Kpd4RTgPBwvmfu2aOS+yDCIHZEUm
         n1PC2WWvwBX/kzt7S4lRP9GigpKbblOQzTv8oGZdla4QilMw6jGFqwA3PxYUZEynzdo5
         zVvQ==
X-Gm-Message-State: APjAAAVQz/h1QwCtOFqd1gURf9ysd+WJLXuzuJ4AmMSWwKkWK78Hf4mq
        bmaNzvOjxUru0kEuhb9KIGY=
X-Google-Smtp-Source: APXvYqyBfb9xuS39HM2yTn0aXyuVgz6M19c7eUmnE1VDN25ZFMX/dAt+2dtxP09MoQIhtjclqeUCog==
X-Received: by 2002:a17:90a:5d0f:: with SMTP id s15mr2135497pji.126.1572475387770;
        Wed, 30 Oct 2019 15:43:07 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x7sm1100750pff.0.2019.10.30.15.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 15:43:06 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:43:04 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v6 00/15] software node: add support for reference
 properties
Message-ID: <20191030224304.GH57214@dtor-ws>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Wed, Oct 23, 2019 at 01:02:18PM -0700, Dmitry Torokhov wrote:
> These series implement "references" properties for software nodes as true
> properties, instead of managing them completely separately.
> 
> The first 10 patches are generic cleanups and consolidation and
> unification of the existing code; patch #11 implements moving of small
> properties inline when copying property entries; patch #12 implements
> PROPERTY_ENTRY_REF() and friends; patch #13 converts the user of
> references to the property syntax, and patch #14 removes the remains of
> references as entities that are managed separately.
> 
> Patch #15 adds unit tests to verify that the handling of property
> entries is correct.

Do you have any concerns with the series? I think Andy did all the
reviewing that he could...

Thanks!

> 
> Changes in v6:
> - rebased onto next-20191023
> - fixed patch moving small properties inline
> - fixed handling boolean properties after is_array -> is_inline
>   conversion
> - changed comments around is_inline "stored directly" vs embedded
>   in one place (Andy)
> - added unit tests for property entries based on KUnit framework
> - added Any's reviewed-by/acked-by
> 
> Changes in v5:
> - rebased onto next-20191011
> 
> Changes in v4:
> - dealt with union aliasing concerns
> - inline small properties on copy
> 
> Changes in v3:
> - added various cleanups before implementing reference properties
> 
> Changes in v2:
> - reworked code so that even single-entry reference properties are
>   stored as arrays (i.e. the software_node_ref_args instances are
>   not part of property_entry structure) to avoid size increase.
>   From user's POV nothing is changed, one can still use PROPERTY_ENTRY_REF
>   macro to define reference "inline".
> - dropped unused DEV_PROP_MAX
> - rebased on linux-next
> 
> Dmitry Torokhov (15):
>   software node: remove DEV_PROP_MAX
>   software node: introduce PROPERTY_ENTRY_ARRAY_XXX_LEN()
>   efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN
>   software node: mark internal macros with double underscores
>   software node: clean up property_copy_string_array()
>   software node: get rid of property_set_pointer()
>   software node: remove property_entry_read_uNN_array functions
>   software node: unify PROPERTY_ENTRY_XXX macros
>   software node: simplify property_entry_read_string_array()
>   software node: rename is_array to is_inline
>   software node: move small properties inline when copying
>   software node: implement reference properties
>   platform/x86: intel_cht_int33fe: use inline reference properties
>   software node: remove separate handling of references
>   software node: add basic tests for property entries
> 
>  drivers/base/swnode.c                         | 263 ++++------
>  drivers/base/test/Makefile                    |   2 +
>  drivers/base/test/property-entry-test.c       | 472 ++++++++++++++++++
>  drivers/firmware/efi/apple-properties.c       |  18 +-
>  .../platform/x86/intel_cht_int33fe_typec.c    |  81 +--
>  include/linux/property.h                      | 178 +++----
>  6 files changed, 702 insertions(+), 312 deletions(-)
>  create mode 100644 drivers/base/test/property-entry-test.c
> 
> -- 
> 2.23.0.866.gb869b98d4c-goog
> 

-- 
Dmitry
