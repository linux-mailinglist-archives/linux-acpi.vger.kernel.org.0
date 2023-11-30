Return-Path: <linux-acpi+bounces-2044-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7903580003B
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 01:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4BE1C20432
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 00:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B887468A
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k4Ww14Xp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917C0BC
	for <linux-acpi@vger.kernel.org>; Thu, 30 Nov 2023 15:29:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0521554ddso1435895ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Nov 2023 15:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701386952; x=1701991752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HPY3TT1DdAebITcwh+393iq5bpwNcS6Rr6c3e/xXuY=;
        b=k4Ww14XpJuIWQEjgifQ+H4EGYTO8LVHgM1W45VuZC9BydvA6ZFlB8dRh2uauy6vdUW
         WX/NAqo0LK8YYvIi6DYIEpvQrQD61NN29IBfrjzHKukk+cjyvPE673anDO3B6IP4SfVK
         4sPFzEQXrA1mG7iSfQXk+/VYh73M5usosgz/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701386952; x=1701991752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HPY3TT1DdAebITcwh+393iq5bpwNcS6Rr6c3e/xXuY=;
        b=TWc3rvWhFPiV7lFcg2nbn0HDi0XKNc2sq7wRrjj1w03JMIfX8jVk10dhpB0WEO0E2Z
         arhhcphbaBucxba8Sw0gz4FOMId49PzoZ7kT8flzNXidfAMwwtCsFvqtxoWmh4/pV/QI
         9mF+Q8b9qag7N/ub+kywYqYW4Yg86gKU9ktvkyzoUjq2QqANmv7rvw11I4zFvN3JgpFk
         UXYW8AYurrG8yLLNUJYxFn3HssZRYgVbd5lVQOWlx78KSQPLGiuekjblfZayYdh14vu6
         hB/DVVZqljBNk4KCKhhWyYo0SzgDyS6lIoI5/NvWo/fwYGs8lx4BsArjc1QijLJcshHY
         PPhA==
X-Gm-Message-State: AOJu0YxGRuThptZztUeAm/fDj+aBzfTJSrNML0dgR7r1KtZmg2n4f8Ji
	PKdWitqe8dNhXmueo0i6W8hGaiuepXPaf0jRBL4=
X-Google-Smtp-Source: AGHT+IGCcytbrQoG3B5BIwicvjqsrdsvS6w7A1bwwPICt+6cwYQMogPuC5DVM70nRicz1zH+iSXfNg==
X-Received: by 2002:a17:902:e88d:b0:1cf:c18e:c923 with SMTP id w13-20020a170902e88d00b001cfc18ec923mr19635866plg.45.1701386951928;
        Thu, 30 Nov 2023 15:29:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090282c800b001cfc1b93179sm1116108plz.232.2023.11.30.15.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:29:11 -0800 (PST)
Date: Thu, 30 Nov 2023 15:29:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] [v2] pnp: acpi: fix fortify warning
Message-ID: <202311301528.EC95F51@keescook>
References: <CAJZ5v0hrMy8c_eA+TxBb=gFF5tS147v3wORrQq=YTpuBDp5hKg@mail.gmail.com>
 <20231128025411.141602-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128025411.141602-1-dmantipov@yandex.ru>

On Tue, Nov 28, 2023 at 05:52:10AM +0300, Dmitry Antipov wrote:
> When compiling with gcc version 14.0.0 20231126 (experimental)
> and CONFIG_FORTIFY_SOURCE=y, I've noticed the following:
> 
> In file included from ./include/linux/string.h:295,
>                  from ./include/linux/bitmap.h:12,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/paravirt.h:17,
>                  from ./arch/x86/include/asm/cpuid.h:62,
>                  from ./arch/x86/include/asm/processor.h:19,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:9,
>                  from ./include/linux/preempt.h:79,
>                  from ./include/linux/spinlock.h:56,
>                  from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/slab.h:16,
>                  from ./include/linux/resource_ext.h:11,
>                  from ./include/linux/acpi.h:13,
>                  from drivers/pnp/pnpacpi/rsparser.c:11:
> In function 'fortify_memcpy_chk',
>     inlined from 'pnpacpi_parse_allocated_vendor' at drivers/pnp/pnpacpi/rsparser.c:158:3,
>     inlined from 'pnpacpi_allocated_resource' at drivers/pnp/pnpacpi/rsparser.c:249:3:
> ./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   588 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> According to the comments in include/linux/fortify-string.h, 'memcpy()',
> 'memmove()' and 'memset()' must not be used beyond individual struct
> members to ensure that the compiler can enforce protection against
> buffer overflows, and, IIUC, this also applies to partial copies from
> the particular member ('vendor->byte_data' in this case). So it should
> be better (and safer) to do both copies at once (and 'byte_data' of
> 'struct acpi_resource_vendor_typed' seems to be a good candidate for
> '__counted_by(byte_length)' as well).
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: prefer sizeof(range) over hardcoded constant (Rafael J. Wysocki)

Yeah, this looks good to me. Thanks for the fix!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/pnp/pnpacpi/rsparser.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
> index 4f05f610391b..c02ce0834c2c 100644
> --- a/drivers/pnp/pnpacpi/rsparser.c
> +++ b/drivers/pnp/pnpacpi/rsparser.c
> @@ -151,13 +151,13 @@ static int vendor_resource_matches(struct pnp_dev *dev,
>  static void pnpacpi_parse_allocated_vendor(struct pnp_dev *dev,
>  				    struct acpi_resource_vendor_typed *vendor)
>  {
> -	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid, 16)) {
> -		u64 start, length;
> +	struct { u64 start, length; } range;
>  
> -		memcpy(&start, vendor->byte_data, sizeof(start));
> -		memcpy(&length, vendor->byte_data + 8, sizeof(length));
> -
> -		pnp_add_mem_resource(dev, start, start + length - 1, 0);
> +	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid,
> +				    sizeof(range))) {
> +		memcpy(&range, vendor->byte_data, sizeof(range));
> +		pnp_add_mem_resource(dev, range.start, range.start +
> +				     range.length - 1, 0);
>  	}
>  }
>  
> -- 
> 2.43.0
> 

-- 
Kees Cook

