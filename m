Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8BBF3D0F
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 01:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfKHAtu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 19:49:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45255 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKHAtt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 19:49:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id z4so3541338pfn.12;
        Thu, 07 Nov 2019 16:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hwb43y+jLIox8nSvT7pHc3LiVl+PmFS4UWcmUl9yhJU=;
        b=mjtg0SU5PpT+un45KEok3VlIeGRLj/hsxTt++HnNKOuETC1hSG7QU/Rt5JrUhYe4EO
         0JXB/LY6BmKQ8R0ooTjxiZI//EyuKqYHJaXYXoon9Wlq5CAc9wmdvwgPSoD9UVq/HFbI
         aHNi43NdYRFhRC4nyzD4OqfipwKeNGFGrY5k0AU3Y5rBfXWYGFhjZWVKkrdwAmdMbBTC
         6ooLCFj+xdaAW6uv5BLHrvy6lQOfW27B3LvkiZOqf/RfPgAhuEi2ZDQ8kJ+N+tXhm405
         ly5lbPD0vXffsSvL5KPP3r4RHFRMzqycX3LWThJsaSLJCxc0abXfJlFPDr6S6iTIiiDf
         tKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hwb43y+jLIox8nSvT7pHc3LiVl+PmFS4UWcmUl9yhJU=;
        b=bPPee6VEHTYZJZxshRbEON8xDZzF7mGAzgYbCQfQMwrQKS40vC9frIWg9vn2kpsPHF
         eMzPpzyPH6NALOxSN1UDtTQqtrxm20BWCEX63X6YAZMyKnjEYEkOerb4kDCl44MmVcTv
         Z57bAaYIEC4T+tjlbbREyxVmAIaBhamTkYOez/Tg6bMnpGsyHSzSF2d0zsKPTWlg7KoI
         3y4u9xJfBApLkKEJgxmLRYf/2PvSW5RzuokejpHzx0vJ9IqwHcYqu7Y7uXTzPQh439HD
         UzzpZl3Jy0WYn9hMLKoF5vkT4Xaie/hV5dIK1geNpXW1axK5Emtryz4oM1FfzEsgxke4
         g7TQ==
X-Gm-Message-State: APjAAAUIjvyDRl0jdE20uxbDdstS1F4jJ4pqNlCG0/fQSBBNRPINGNUW
        Vqf44B93wMPYl9KMfjrhO0Q=
X-Google-Smtp-Source: APXvYqwJieRK9semqdhgyGD+Ks5P2vZ4OM/abNUFxbvlWXyHsaeFe6bzW9aAyMQf4AOhkrh/jM8Iqw==
X-Received: by 2002:a63:fa0e:: with SMTP id y14mr8085453pgh.174.1573174188375;
        Thu, 07 Nov 2019 16:49:48 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c10sm3543012pgb.76.2019.11.07.16.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 16:49:47 -0800 (PST)
Date:   Thu, 7 Nov 2019 16:49:46 -0800
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
Message-ID: <20191108004946.GY57214@dtor-ws>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
 <3310518.lfHdziMng4@kreacher>
 <20191108002844.GX57214@dtor-ws>
 <9656909.LrxhuH3ECW@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9656909.LrxhuH3ECW@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 08, 2019 at 01:45:03AM +0100, Rafael J. Wysocki wrote:
> On Friday, November 8, 2019 1:28:44 AM CET Dmitry Torokhov wrote:
> > On Fri, Nov 08, 2019 at 01:04:31AM +0100, Rafael J. Wysocki wrote:
> > > On Wednesday, November 6, 2019 12:56:56 AM CET Dmitry Torokhov wrote:
> > > > Hi Rafael,
> > > > 
> > > > On Wed, Nov 06, 2019 at 12:42:02AM +0100, Rafael J. Wysocki wrote:
> > > > > On Wednesday, October 23, 2019 10:02:29 PM CET Dmitry Torokhov wrote:
> > > > > > When copying/duplicating set of properties, move smaller properties that
> > > > > > were stored separately directly inside property entry structures. We can
> > > > > > move:
> > > > > > 
> > > > > > - up to 8 bytes from U8 arrays
> > > > > > - up to 4 words
> > > > > > - up to 2 double words
> > > > > > - one U64 value
> > > > > > - one or 2 strings.
> > > > > 
> > > > > Yes, we can do that, but how much of a difference does this really make?
> > > > 
> > > > Arguably not much I think, but it was pretty cheap to do.
> > > > 
> > > > > 
> > > > > Also, how can one distinguish between a single-value property and an inline
> > > > > array which this change?  By looking at the length?
> > > > 
> > > > We do not really need to distinguish between the 2. The device
> > > > properties API is typically wrap single values around arrays (i.e. it is
> > > > perfectly fine to use scalar API to fetch first element of array and use
> > > > array API to fetch a scalar). So we have property of certain type with
> > > > certain number of elements, and it can either be stored inside
> > > > property_entry structure, or outside of it. They are 2 orthogonal
> > > > concepts.
> > > > 
> > > > > 
> > > > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > > ---
> > > > > >  drivers/base/swnode.c | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > > > > > index 18a30fb3cc58..49e1108aa4b7 100644
> > > > > > --- a/drivers/base/swnode.c
> > > > > > +++ b/drivers/base/swnode.c
> > > > > > @@ -280,6 +280,16 @@ static int property_entry_copy_data(struct property_entry *dst,
> > > > > >  	if (!dst->name)
> > > > > >  		goto out_free_data;
> > > > > >  
> > > > > > +	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
> > > > > > +		/* We have an opportunity to move the data inline */
> > > > > > +		const void *tmp = dst->pointer;
> > > > > > +
> > > > > > +		memcpy(&dst->value, tmp, dst->length);
> > > > > > +		dst->is_inline = true;
> > > > > > +
> > > > > > +		kfree(tmp);
> > > > > 
> > > > > This would have been more useful if we had been able to avoid making the
> > > > > allocation altogether.
> > > > 
> > > > OK, I can do that and re-send this patch and the one with the tests.
> > > 
> > > But if you do that, IMO it would be prudent to extend the definition of
> > > struct property_entry like this:
> > > 
> > >  struct property_entry {
> > >  	const char *name;
> > >  	size_t length;
> > >  	bool is_array;
> > >  	enum dev_prop_type type;
> > >  	union {
> > >  		union {
> > >  			const u8 *u8_data;
> > >  			const u16 *u16_data;
> > >  			const u32 *u32_data;
> > >  			const u64 *u64_data;
> > >  			const char * const *str;
> > >  		} pointer;
> > >  		union {
> > >  			u8 u8_data;
> > >  			u16 u16_data;
> > >  			u32 u32_data;
> > >  			u64 u64_data;
> > >  			const char *str;
> > > +			u8 u8_buf[sizeof(u64)];
> > > +			u16 u16_buf[sizeof(u64)/sizeof(u16)];
> > > +			u32 u32_buf[sizeof(u64)/sizeof(u32)];
> > > +			char char_buf[sizeof(u64)];
> > >  		} value;
> > >  	};
> > >  };
> > > 
> > > to make it clear that the value field is going to be used as an array in
> > > some cases.
> > 
> > Sorry, just sent out updated series before receiving your email. I can
> > cook up new patch cleaning this.
> 
> I'd prefer a new version of the series, honestly.

OK, sure.

> 
> > I think we can drop scalars and only have arrays and have initializers use
> > <type>_data[0] to create initial property entries.
> 
> Why [0]?  IMO it is better to use the exact size (which is known) in this
> particular case.

diff --git a/include/linux/property.h b/include/linux/property.h
index b315fdc0ec28d..b28c81af7bb68 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -257,11 +257,11 @@ struct property_entry {
        union {
                const void *pointer;
                union {
-                       u8 u8_data;
-                       u16 u16_data;
-                       u32 u32_data;
-                       u64 u64_data;
-                       const char *str;
+                       u8 u8_data[sizeof(u64) / sizeof(u8)];
+                       u16 u16_data[sizeof(u64) / sizeof(u16)];
+                       u32 u32_data[sizeof(u64) / sizeof(u32)];
+                       u64 u64_data[sizeof(u64) / sizeof(u64)];
+                       const char *str[sizeof(u64) / sizeof(char *)];
                } value;
        };
 };
@@ -273,7 +273,7 @@ struct property_entry {
  */

 #define __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_)                          \
-       sizeof(((struct property_entry *)NULL)->value._elem_)
+       sizeof(((struct property_entry *)NULL)->value._elem_[0])

 #define __PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_, _elsize_, _Type_,    \
                                          _val_, _len_)                 \
@@ -323,7 +323,7 @@ struct property_entry {
        .length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),                \
        .is_inline = true,                                              \
        .type = DEV_PROP_##_Type_,                                      \
-       { .value = { ._elem_ = _val_ } },                               \
+       { .value = { ._elem_[0] = _val_ } },                            \
 }

 #define PROPERTY_ENTRY_U8(_name_, _val_)                               \

> 
> Also note that u64 is naturally a scalar only.

It still can be expressed as array of 1 element.

>  
> > > 
> > > > In the mean time, can you please consider patches 12-14?
> > > 
> > > I cannot find drivers/platform/x86/intel_cht_int33fe_typec.c in the mainline,
> > > so I cannot apply patch [13/15] now and I'm not sure how useful it would be
> > > to apply patches [10,12/15] without the other two.
> > 
> > Hmm, drivers/platform/x86/intel_cht_int33fe_typec.c used to be
> > drivers/platform/x86/intel_cht_int33fe.c I think.
> > 
> > I can either regenerate against your tree instead of -next (but then
> > there will be merge conflict) or we could postpone #13 and #14 (or #5
> > and #6 in v7) till after merge window.
> > 
> > Please let me know.
> 
> I'd rather postpone the whole series to until the dependencies are in,
> which may be during the merge window (e.g. if this happens during the
> first week of it, waiting for another extra week just for the merge
> window to end is not quite useful IMO).

Hmm, OK, but I am not sure why we can't apply new functionality now and
get cleanup patches in afterwards...

Thanks.

-- 
Dmitry
