Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6011434DC08
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 00:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhC2WqC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 18:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhC2Wpc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 18:45:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796EAC061762;
        Mon, 29 Mar 2021 15:45:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so245977wma.0;
        Mon, 29 Mar 2021 15:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ETElOIEjdVlntEPGKFfKH5hdv13+jUzKgNis+gv7d0Y=;
        b=I+IhwZ48NFnJUjuO1Rzmhhhm1o+iYydBzUK7BfQjz7PysEuDydE9oYAzwgHCCcZ3RS
         kYgmh0XTuAZ1Imyp/i87qIoiDc1He1bhpNK9V44KTHI7tieMsa1DoVg3KIX5KaXfXmY9
         sxIlZLQiwm1BTE+4GH2rsYUAyNWszWhQIGG8iWGjit1sT9QnmAjDMtn6wIqS42BIb96r
         hHcKdnvjM/yItitQ5aFtNpmVGsB7PT6R3efYlpaluS9dsYVltdqqWYYkdzS2aMAHp/Je
         1+kyTYDZgYooTfcNS37EKmvoGYP5F6DyVgVFu9rvEiWDnNKe2b+07Scg0rWsA8ukMq82
         fYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ETElOIEjdVlntEPGKFfKH5hdv13+jUzKgNis+gv7d0Y=;
        b=NyG2J5iCFIDp4UiCNwb7DkvMn/kljOJ6ec+SVVC6jLJi/G4/i+vgUP7NoNpIRR/A2k
         pzToP9AkUCfra+0Jn6S+SjG5Rw5ejH3Qb8m80UFKKcQRUelaecrF4RC9dixNpte1I+I0
         vPf/7j/A1sVF4P6ul54Vmu7UHSgQCHrb4AqUtNo4Il+ZYo8UAY/d+wWN+Ak9kYzlNbeU
         Qr7AnOJdikZrGEQNwdU+kTLaf0D4fe8JDauGhGwXi2+72iOvnKHTex/xuA4K5sLV9w6Q
         IAYjhz1VEQnimR34MAimbsNNLLQgkqkxT243U14MrMJyTimKYVCoPp7gB3UYFmSoOSD+
         A+pQ==
X-Gm-Message-State: AOAM530JUxpZoQyQXApxwXdlSjHbmt1DIMNGiwDCIAexgS6E7LVJOA2T
        Rl57NNehoHdvcgAj8V57gtR2GB3ZBFM=
X-Google-Smtp-Source: ABdhPJxyRVPH6LZ09xytzgreMLOzWL84xbVukFnYvZDzbBVKV7qUeIJj/aFitR0isTzjCLSK7EtWow==
X-Received: by 2002:a7b:c8d9:: with SMTP id f25mr1012593wml.157.1617057931268;
        Mon, 29 Mar 2021 15:45:31 -0700 (PDT)
Received: from [192.168.1.211] ([91.110.20.103])
        by smtp.gmail.com with ESMTPSA id g5sm32251362wrq.30.2021.03.29.15.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 15:45:30 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] software node: Introduce SOFTWARE_NODE_REFERENCE()
 helper macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
 <20210329151207.36619-5-andriy.shevchenko@linux.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <5e76c3b8-d154-e5ca-25d8-290376469e5a@gmail.com>
Date:   Mon, 29 Mar 2021 23:45:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210329151207.36619-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

On 29/03/2021 16:12, Andy Shevchenko wrote:
> This is useful to assign software node reference with arguments
> in a common way. Moreover, we have already couple of users that
> may be converted. And by the fact, one of them is moved right here
> to use the helper.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: no changes
>  drivers/base/test/property-entry-test.c | 11 ++---------
>  include/linux/property.h                | 13 ++++++++-----
>  2 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
> index abe03315180f..c2e455d46ffd 100644
> --- a/drivers/base/test/property-entry-test.c
> +++ b/drivers/base/test/property-entry-test.c
> @@ -370,15 +370,8 @@ static void pe_test_reference(struct kunit *test)
>  	};
>  
>  	static const struct software_node_ref_args refs[] = {
> -		{
> -			.node = &nodes[0],
> -			.nargs = 0,
> -		},
> -		{
> -			.node = &nodes[1],
> -			.nargs = 2,
> -			.args = { 3, 4 },
> -		},
> +		SOFTWARE_NODE_REFERENCE(&nodes[0]),
> +		SOFTWARE_NODE_REFERENCE(&nodes[1], 3, 4),
>  	};
>  
>  	const struct property_entry entries[] = {
> diff --git a/include/linux/property.h b/include/linux/property.h
> index dd4687b56239..0d876316e61d 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -254,6 +254,13 @@ struct software_node_ref_args {
>  	u64 args[NR_FWNODE_REFERENCE_ARGS];
>  };
>  
> +#define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
> +(const struct software_node_ref_args) {				\
> +	.node = _ref_,						\
> +	.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\
> +	.args = { __VA_ARGS__ },				\
> +}
> +
>  /**
>   * struct property_entry - "Built-in" device property representation.
>   * @name: Name of the property.
> @@ -362,11 +369,7 @@ struct property_entry {
>  	.name = _name_,							\
>  	.length = sizeof(struct software_node_ref_args),		\
>  	.type = DEV_PROP_REF,						\
> -	{ .pointer = &(const struct software_node_ref_args) {		\
> -		.node = _ref_,						\
> -		.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\
> -		.args = { __VA_ARGS__ },				\
> -	} },								\
> +	{ .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },	\
>  }


What are the .args intended to be used for? I actually had it in mind to
replace this with a simple pointer to a struct software_node, because I
can't see any users of them and the fact that it's actually storing a
pointer to a new variable is something that confused me for a good long
time when I wrote the cio2-bridge (though that's mostly due to my
relative inexperience of course, but still)

>  
>  struct property_entry *
