Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD35F3D70
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 02:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKHBex (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 20:34:53 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55792 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKHBew (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 20:34:52 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id a0a5949f819b3b32; Fri, 8 Nov 2019 02:34:48 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v6 11/15] software node: move small properties inline when copying
Date:   Fri, 08 Nov 2019 02:34:48 +0100
Message-ID: <6348991.dSJoU6Kmcj@kreacher>
In-Reply-To: <20191108004946.GY57214@dtor-ws>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com> <9656909.LrxhuH3ECW@kreacher> <20191108004946.GY57214@dtor-ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, November 8, 2019 1:49:46 AM CET Dmitry Torokhov wrote:
> On Fri, Nov 08, 2019 at 01:45:03AM +0100, Rafael J. Wysocki wrote:
> > On Friday, November 8, 2019 1:28:44 AM CET Dmitry Torokhov wrote:
> > > On Fri, Nov 08, 2019 at 01:04:31AM +0100, Rafael J. Wysocki wrote:
> > > > On Wednesday, November 6, 2019 12:56:56 AM CET Dmitry Torokhov wrote:
> > > > > Hi Rafael,
> > > > > 
> > > > > On Wed, Nov 06, 2019 at 12:42:02AM +0100, Rafael J. Wysocki wrote:
> > > > > > On Wednesday, October 23, 2019 10:02:29 PM CET Dmitry Torokhov wrote:
> > > > > > > When copying/duplicating set of properties, move smaller properties that
> > > > > > > were stored separately directly inside property entry structures. We can
> > > > > > > move:
> > > > > > > 
> > > > > > > - up to 8 bytes from U8 arrays
> > > > > > > - up to 4 words
> > > > > > > - up to 2 double words
> > > > > > > - one U64 value
> > > > > > > - one or 2 strings.
> > > > > > 
> > > > > > Yes, we can do that, but how much of a difference does this really make?
> > > > > 
> > > > > Arguably not much I think, but it was pretty cheap to do.
> > > > > 
> > > > > > 
> > > > > > Also, how can one distinguish between a single-value property and an inline
> > > > > > array which this change?  By looking at the length?
> > > > > 
> > > > > We do not really need to distinguish between the 2. The device
> > > > > properties API is typically wrap single values around arrays (i.e. it is
> > > > > perfectly fine to use scalar API to fetch first element of array and use
> > > > > array API to fetch a scalar). So we have property of certain type with
> > > > > certain number of elements, and it can either be stored inside
> > > > > property_entry structure, or outside of it. They are 2 orthogonal
> > > > > concepts.
> > > > > 
> > > > > > 
> > > > > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/base/swnode.c | 10 ++++++++++
> > > > > > >  1 file changed, 10 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > > > > > > index 18a30fb3cc58..49e1108aa4b7 100644
> > > > > > > --- a/drivers/base/swnode.c
> > > > > > > +++ b/drivers/base/swnode.c
> > > > > > > @@ -280,6 +280,16 @@ static int property_entry_copy_data(struct property_entry *dst,
> > > > > > >  	if (!dst->name)
> > > > > > >  		goto out_free_data;
> > > > > > >  
> > > > > > > +	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
> > > > > > > +		/* We have an opportunity to move the data inline */
> > > > > > > +		const void *tmp = dst->pointer;
> > > > > > > +
> > > > > > > +		memcpy(&dst->value, tmp, dst->length);
> > > > > > > +		dst->is_inline = true;
> > > > > > > +
> > > > > > > +		kfree(tmp);
> > > > > > 
> > > > > > This would have been more useful if we had been able to avoid making the
> > > > > > allocation altogether.
> > > > > 
> > > > > OK, I can do that and re-send this patch and the one with the tests.
> > > > 
> > > > But if you do that, IMO it would be prudent to extend the definition of
> > > > struct property_entry like this:
> > > > 
> > > >  struct property_entry {
> > > >  	const char *name;
> > > >  	size_t length;
> > > >  	bool is_array;
> > > >  	enum dev_prop_type type;
> > > >  	union {
> > > >  		union {
> > > >  			const u8 *u8_data;
> > > >  			const u16 *u16_data;
> > > >  			const u32 *u32_data;
> > > >  			const u64 *u64_data;
> > > >  			const char * const *str;
> > > >  		} pointer;
> > > >  		union {
> > > >  			u8 u8_data;
> > > >  			u16 u16_data;
> > > >  			u32 u32_data;
> > > >  			u64 u64_data;
> > > >  			const char *str;
> > > > +			u8 u8_buf[sizeof(u64)];
> > > > +			u16 u16_buf[sizeof(u64)/sizeof(u16)];
> > > > +			u32 u32_buf[sizeof(u64)/sizeof(u32)];
> > > > +			char char_buf[sizeof(u64)];
> > > >  		} value;
> > > >  	};
> > > >  };
> > > > 
> > > > to make it clear that the value field is going to be used as an array in
> > > > some cases.
> > > 
> > > Sorry, just sent out updated series before receiving your email. I can
> > > cook up new patch cleaning this.
> > 
> > I'd prefer a new version of the series, honestly.
> 
> OK, sure.
> 
> > 
> > > I think we can drop scalars and only have arrays and have initializers use
> > > <type>_data[0] to create initial property entries.
> > 
> > Why [0]?  IMO it is better to use the exact size (which is known) in this
> > particular case.
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index b315fdc0ec28d..b28c81af7bb68 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -257,11 +257,11 @@ struct property_entry {
>         union {
>                 const void *pointer;
>                 union {
> -                       u8 u8_data;
> -                       u16 u16_data;
> -                       u32 u32_data;
> -                       u64 u64_data;
> -                       const char *str;
> +                       u8 u8_data[sizeof(u64) / sizeof(u8)];
> +                       u16 u16_data[sizeof(u64) / sizeof(u16)];
> +                       u32 u32_data[sizeof(u64) / sizeof(u32)];
> +                       u64 u64_data[sizeof(u64) / sizeof(u64)];

IMO with a scalar u64 this kind of would explain itself, but with a u64 array
it becomes somewhat confusing.

> +                       const char *str[sizeof(u64) / sizeof(char *)];
>                 } value;
>         };
>  };
> @@ -273,7 +273,7 @@ struct property_entry {
>   */
> 
>  #define __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_)                          \
> -       sizeof(((struct property_entry *)NULL)->value._elem_)
> +       sizeof(((struct property_entry *)NULL)->value._elem_[0])
> 
>  #define __PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_, _elsize_, _Type_,    \
>                                           _val_, _len_)                 \
> @@ -323,7 +323,7 @@ struct property_entry {
>         .length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),                \
>         .is_inline = true,                                              \
>         .type = DEV_PROP_##_Type_,                                      \
> -       { .value = { ._elem_ = _val_ } },                               \
> +       { .value = { ._elem_[0] = _val_ } },                            \
>  }
> 
>  #define PROPERTY_ENTRY_U8(_name_, _val_)                               \
> 
> > 
> > Also note that u64 is naturally a scalar only.
> 
> It still can be expressed as array of 1 element.

It can, but for what purpose?

> >  
> > > > 
> > > > > In the mean time, can you please consider patches 12-14?
> > > > 
> > > > I cannot find drivers/platform/x86/intel_cht_int33fe_typec.c in the mainline,
> > > > so I cannot apply patch [13/15] now and I'm not sure how useful it would be
> > > > to apply patches [10,12/15] without the other two.
> > > 
> > > Hmm, drivers/platform/x86/intel_cht_int33fe_typec.c used to be
> > > drivers/platform/x86/intel_cht_int33fe.c I think.
> > > 
> > > I can either regenerate against your tree instead of -next (but then
> > > there will be merge conflict) or we could postpone #13 and #14 (or #5
> > > and #6 in v7) till after merge window.
> > > 
> > > Please let me know.
> > 
> > I'd rather postpone the whole series to until the dependencies are in,
> > which may be during the merge window (e.g. if this happens during the
> > first week of it, waiting for another extra week just for the merge
> > window to end is not quite useful IMO).
> 
> Hmm, OK, but I am not sure why we can't apply new functionality now and
> get cleanup patches in afterwards...

Because that's harder to follow from the history perspective and makes no
real difference in the end of the day.



