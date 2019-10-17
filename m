Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 402B5DB1C6
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 18:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbfJQQCn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 12:02:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37662 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731629AbfJQQCn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2019 12:02:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so1937909pfo.4;
        Thu, 17 Oct 2019 09:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y70YcjMTae+KBmY5i8e+kvbER0Afq5EJqUnZxrc9iiw=;
        b=m1BoLmnU/H/Dhb3zBe/SBpL7c9FEF5eKXunx5owEt9yb2l+YZxVlOuw575ghC7extd
         csxTCpHt1uUDO4Tqp3CdjNgej+RymtE13DaEqXL4ZiFgLntwTajVvKzH9oedTdfgx3oL
         JZUTzDfbcH0cz9nO2MVF9RZ97YYY3gRVQ9LUALLZ4zqUytu5IfkQR0m4yG9XcAJhrWa5
         0rcGuueF0VtyihrBe6hKTXkcgXLipYu9TEIQi8H02pUUzXkEx89Eukaf9lnVoLgK7akv
         jI88l17Y1BScByhj5UL301XtS9gqikEE80W8D5CH1nVo2EkU2TUA1l9X73wNPbXZl7Yn
         EkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y70YcjMTae+KBmY5i8e+kvbER0Afq5EJqUnZxrc9iiw=;
        b=Cw36TFfEyeyPuuSafwCOMDQLkjOeXLTXHcuHMsunTbqnppPyi0kWVR0clrqM6B4cwe
         jxspGh4eY8Ca6Lke565DVX8QOpDa+JmE870HuXj8ssVoMOaGAeLEO6p+a0jgGm8F+vr8
         RjV65DSEjFzTa0xBKagNIi6f1lABIhFSxVf/LmwU+F3uQ4hk8cc14sYW8N9iTjT2vcRW
         gLrrKuAuT4xaJqKlJfgH0sB2ephfUGw+m0fxbXBPJeeK2ixbD97iqzAuQg+ttMLRDWDe
         eQPUeKymuwCLj7ETHLNaLxryoiepNfFga35y9k1KHAugambdFY+hSNU6NhDVnfWmglZV
         BwJQ==
X-Gm-Message-State: APjAAAVJ6gLeCxzTrdBV6seyTDXM0x55ri3xixY+1QZ0lcKJfbVINzn5
        fRFI/lSAjZSOJz4DRFoUy5w=
X-Google-Smtp-Source: APXvYqyMCbyvP5twVk/9K5eZYp7k9rZ9LTNFF1bkof2hrnZcyKas+XsbwKCpdr96xRh0FMJ7m5lPEg==
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr5421265pjb.2.1571328162065;
        Thu, 17 Oct 2019 09:02:42 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u5sm3742939pfl.25.2019.10.17.09.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 09:02:41 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:02:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 10/14] software node: rename is_array to is_inline
Message-ID: <20191017160239.GG35946@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-11-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011230721.206646-11-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2019 at 04:07:17PM -0700, Dmitry Torokhov wrote:
> We do not need a special flag to know if we are dealing with an array,
> as we can get that data from ratio between element length and the data
> size, however we do need a flag to know whether the data is stored
> directly inside property_entry or separately.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/swnode.c    |  9 +++++----
>  include/linux/property.h | 12 +++++++-----
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 8826c9040c80..ae4b24ee2a54 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -108,7 +108,7 @@ static const void *property_get_pointer(const struct property_entry *prop)
>  	if (!prop->length)
>  		return NULL;
>  
> -	if (prop->is_array)
> +	if (!prop->is_inline)
>  		return prop->pointer;
>  
>  	return &prop->value;
> @@ -205,7 +205,7 @@ static void property_entry_free_data(const struct property_entry *p)
>  	const char * const *src_str;
>  	size_t i, nval;
>  
> -	if (p->is_array) {
> +	if (!p->is_inline) {
>  		if (p->type == DEV_PROP_STRING && p->pointer) {
>  			src_str = p->pointer;
>  			nval = p->length / sizeof(const char *);
> @@ -250,7 +250,7 @@ static int property_entry_copy_data(struct property_entry *dst,
>  	const void *pointer = property_get_pointer(src);
>  	const void *new;
>  
> -	if (src->is_array) {
> +	if (!src->is_inline) {
>  		if (!src->length)
>  			return -ENODATA;
>  
> @@ -264,15 +264,16 @@ static int property_entry_copy_data(struct property_entry *dst,
>  				return -ENOMEM;
>  		}
>  
> -		dst->is_array = true;
>  		dst->pointer = new;
>  	} else if (src->type == DEV_PROP_STRING) {
>  		new = kstrdup(src->value.str, GFP_KERNEL);
>  		if (!new && src->value.str)
>  			return -ENOMEM;
>  
> +		dst->is_inline = true;
>  		dst->value.str = new;
>  	} else {
> +		dst->is_inline = true;
>  		dst->value = src->value;
>  	}
>  
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 238e1507925f..ac7823d58cfe 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -222,15 +222,17 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
>   * struct property_entry - "Built-in" device property representation.
>   * @name: Name of the property.
>   * @length: Length of data making up the value.
> - * @is_array: True when the property is an array.
> + * @is_inline: True when the property value is stored directly in
> + *     &struct property_entry instance.
>   * @type: Type of the data in unions.
> - * @pointer: Pointer to the property (an array of items of the given type).
> - * @value: Value of the property (when it is a single item of the given type).
> + * @pointer: Pointer to the property when it is stored separately from
> + *     the &struct property_entry instance.
> + * @value: Value of the property when it is stored inline.
>   */
>  struct property_entry {
>  	const char *name;
>  	size_t length;
> -	bool is_array;
> +	bool is_inline;
>  	enum dev_prop_type type;
>  	union {
>  		const void *pointer;
> @@ -257,7 +259,6 @@ struct property_entry {
>  (struct property_entry) {						\
>  	.name = _name_,							\
>  	.length = (_len_) * __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
> -	.is_array = true,						\
>  	.type = DEV_PROP_##_Type_,					\
>  	{ .pointer = _val_ },						\
>  }
> @@ -288,6 +289,7 @@ struct property_entry {
>  (struct property_entry) {						\
>  	.name = _name_,							\
>  	.length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),		\
> +	.is_inline = true,						\
>  	.type = DEV_PROP_##_Type_,					\
>  	{ .value = { ._elem_ = _val_ } },				\
>  }

The patch also needs to set is_inline in PROPERTY_ENTRY_BOOL(), I'll
send updated version after I get more feedback.

Thanks.

-- 
Dmitry
