Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF37D7E5A
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 20:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfJOSCm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 14:02:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39426 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOSCl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2019 14:02:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so9949036plp.6;
        Tue, 15 Oct 2019 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z8vZY3UjYGee0rVR6bJWDTeILO13q3DsBmT7g8D5CqE=;
        b=Yh1LUCBfKlisSW5aft0X27Z7Yn3scBV0ebad7io6LVBj2c3tHvRnoHTaJSqLf296+9
         uhJPZm4gc5jGPcAg5fHjzTXFXl31R34LQGTU6ZRCXeIc+gMrTv7OJ4goNXrSNViX9X/n
         qXQmTSElNpCuTSInmJXKBaetLLKyZZdzJeHhdte7UDazZdJWMms4NI0XXpLk0+ghINhA
         SZx1w5QoVQgFXFNbZdeK2zX+cVOj54vnVvgtEgQHPU0OucR8uY7jzbOJvk4pJUHPl8Uv
         NRSs4bM/nGvnflwGssWNzXexl/UM2a8u/UyMJV3y7Tlngg+/M0Bd5w5FqxQXGZTHHkdy
         3Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z8vZY3UjYGee0rVR6bJWDTeILO13q3DsBmT7g8D5CqE=;
        b=iZv5lQ6o+/kQkqJH8m4/jQP19MfREaFVWkm+e/Kv2XuoZmar+1LElMBdWTubaGfwB5
         LDEAMQ70AGY60AfzMK8u3VNI4i0ubqWHjZ88yuNnyZKPq8HMA2urCQQru1QBDm45spJe
         A6GXM9cfZflj6y5y0ZVg8NVrOHl2aety5Y4nv9Bf+I0QD/9qtlmUk9+ABi72FdQP+1M9
         9UnfaBCEqogv2/qPOtfnvnbjzGglcARTFFxfsMmL5c5pq94Oosgf0BRpb/EnHJWHZpOW
         U1Z/hJTDoW7MHxOwnzAC1L6+toA/ityQnztV1+RKDLg51DoossPa9+stPb0KDiXUBwnf
         xmCw==
X-Gm-Message-State: APjAAAWTttbgDfTVo/ScZbu0ITLITz4dTt8bCrib5iYB6Hl8lJMJwihx
        YO8f9rOxiimyhftN8P3jouWHM/fd
X-Google-Smtp-Source: APXvYqxkWnBL+x9PExP4ITEzDQtYCrjG6zT3F068IaSil8nFMxXZpISLdsrwWxHkwZQFeT8LyPU6rA==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr37290040plq.335.1571162560542;
        Tue, 15 Oct 2019 11:02:40 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c1sm33439904pfb.135.2019.10.15.11.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:02:39 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:02:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 03/14] efi/apple-properties: use
 PROPERTY_ENTRY_U8_ARRAY_LEN
Message-ID: <20191015180236.GB105649@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-4-dmitry.torokhov@gmail.com>
 <20191015120149.GD32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015120149.GD32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 15, 2019 at 03:01:49PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 04:07:10PM -0700, Dmitry Torokhov wrote:
> > Let's switch to using PROPERTY_ENTRY_U8_ARRAY_LEN() to initialize
> > property entries. Also, when dumping data, rely on local variables
> > instead of poking into the property entry structure directly.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/firmware/efi/apple-properties.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
> > index 0e206c9e0d7a..5ccf39986a14 100644
> > --- a/drivers/firmware/efi/apple-properties.c
> > +++ b/drivers/firmware/efi/apple-properties.c
> > @@ -53,7 +53,8 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
> >  
> >  	for (i = 0; i < dev_header->prop_count; i++) {
> >  		int remaining = dev_header->len - (ptr - (void *)dev_header);
> > -		u32 key_len, val_len;
> > +		u32 key_len, val_len, entry_len;
> > +		const u8 *entry_data;
> >  		char *key;
> >  
> >  		if (sizeof(key_len) > remaining)
> > @@ -85,17 +86,14 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
> >  		ucs2_as_utf8(key, ptr + sizeof(key_len),
> >  			     key_len - sizeof(key_len));
> >  
> > -		entry[i].name = key;
> > -		entry[i].length = val_len - sizeof(val_len);
> > -		entry[i].is_array = !!entry[i].length;
> > -		entry[i].type = DEV_PROP_U8;
> > -		entry[i].pointer.u8_data = ptr + key_len + sizeof(val_len);
> > -
> > +		entry_data = ptr + key_len + sizeof(val_len);
> > +		entry_len = val_len - sizeof(val_len);
> > +		entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key, entry_data,
> > +						       entry_len);
> 
> I would rather leave on one line.

I am trying to stay withing 80 char limit by default, but do not have
strong opinion on the code I do not maintain. Up to Ard I suppose.

> Nevertheless,
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for looking the patches over.

> 
> >  		if (dump_properties) {
> > -			dev_info(dev, "property: %s\n", entry[i].name);
> > +			dev_info(dev, "property: %s\n", key);
> >  			print_hex_dump(KERN_INFO, pr_fmt(), DUMP_PREFIX_OFFSET,
> > -				16, 1, entry[i].pointer.u8_data,
> > -				entry[i].length, true);
> > +				16, 1, entry_data, entry_len, true);
> >  		}
> >  
> >  		ptr += key_len + val_len;
> > -- 
> > 2.23.0.700.g56cf767bdb-goog
> > 
> 

Thanks.

-- 
Dmitry
