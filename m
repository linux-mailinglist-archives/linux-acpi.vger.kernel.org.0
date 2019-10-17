Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358B8DB1DD
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfJQQEk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 12:04:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36190 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbfJQQEk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2019 12:04:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so1619941pgk.3;
        Thu, 17 Oct 2019 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MEWWAMBOeS/era9AcFti+L6FUy/miAh0BHzcw7O5fnw=;
        b=Toz6mSendGQ8kRPgCgNqB7dBwisIvwTPYspQQQQkaUCt7djKRT9RUi0rVbwijTn77k
         4dB5vPvX8zG/9MyP0jX21p9tdea6r0kHvYuuXlKhZZhEFaPM9j5ZSRQ4kzozIn0x5Di1
         jC7UJVbx8RdH59KgYauVgbXbFa9L2gG0ZAuhaY0eSrFWquTrmHf6p6SwLOww3ZfIaYA4
         /5eNzoUC4Amtrllk5AEO5Q5jxYB/PvKVwIbF3yrdklnHRb8z/y6P7iBM/kXcaWV3UmjZ
         i+1+FoPIpdJzl1e+mA6Dupg06baZjV9J2luee8dpVse3O8iWYvX32ihgLNihMi7VnFvt
         Kazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MEWWAMBOeS/era9AcFti+L6FUy/miAh0BHzcw7O5fnw=;
        b=lLMnFmFZyJgKUL1Z+GJhnwGbfZKfADflp/HvB3jhWozuK2py3GeaMXQI34ExyD5HF7
         bheFH8wTHcDAGtbhn8Pq84GX25r9mRYCE64ijyPyfoJANAEQmJlcGFFzZtUFI4j33kPe
         uY78aLyCCEVWvxPUW+PE8DXjXmjdc2FlMViXfxtjzrxbnt+TRvqDImyobWJ3H49gVIGt
         LfCVBCekvNGxmCtjKRwhi3pxX5LKVnruexaiD5+Ma/E8D1XW75YTi+ms7B3B0Pj3fMGw
         w/PNP8OIP97Y+S7on2V1IEf/WbFVmkRtVIoRJhIC6ssCwic8BjicXb98h8sWeWTbbU5E
         H3qQ==
X-Gm-Message-State: APjAAAX/9yyOdF+POG5arD8LIeHVfW3QXLLxpuzs2SBtycy8f/Kc4ODf
        gZWS5QVOxGAspNuKxMUxRM0=
X-Google-Smtp-Source: APXvYqzUDopEAJP5Iwc/f4Fn8fLjI9XM3OplF1Y7VC4MJkS0urPGJz1/1ZFGXQPxt8eputADJ+q2Jw==
X-Received: by 2002:a17:90b:914:: with SMTP id bo20mr5074233pjb.6.1571328279276;
        Thu, 17 Oct 2019 09:04:39 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a11sm2996970pfo.165.2019.10.17.09.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 09:04:38 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:04:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 11/14] software node: move small properties inline
 when copying
Message-ID: <20191017160436.GH35946@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-12-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011230721.206646-12-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2019 at 04:07:18PM -0700, Dmitry Torokhov wrote:
> When copying/duplicating set of properties, move smaller properties that
> were stored separately directly inside property entry structures. We can
> move:
> 
> - up to 8 bytes from U8 arrays
> - up to 4 words
> - up to 2 double words
> - one U64 value
> - one or 2 strings.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/swnode.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index ae4b24ee2a54..546fc1b20095 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -277,6 +277,16 @@ static int property_entry_copy_data(struct property_entry *dst,
>  		dst->value = src->value;
>  	}
>  
> +	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
> +		/* We have an opportunity to move the data inline */
> +		const void *tmp = dst->pointer;
> +
> +		memcpy(&dst->value, tmp, dst->length);
> +		dst->is_inline = true;
> +
> +		kfree(tmp);
> +	}

This chunk needs to be moved to after dst->length is assigned.  I'll
send updated version after I get more feedback.

> +
>  	dst->length = src->length;
>  	dst->type = src->type;
>  	dst->name = kstrdup(src->name, GFP_KERNEL);

Thanks.

-- 
Dmitry
