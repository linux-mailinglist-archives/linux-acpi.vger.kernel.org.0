Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C58DD7EE3
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 20:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbfJOSZ5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 14:25:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47099 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389041AbfJOSZ5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2019 14:25:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id e15so4628221pgu.13;
        Tue, 15 Oct 2019 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tg5G4EHdsp8D34zYrPgeEgWJ5a4qkrRxOx3WVGEN8fU=;
        b=A/DfNiIAQ8QBffPYPPJMcaxcV45QnhvBYZo4nESjZbh6rfCiOeL3pi/64O9xKEj8Qf
         gZRKaMLVnthymX6g936JU+wlSRjRlk4UoTDRzgDPcYDVwowjeYb9HnKkZ+Am8zgc9dqa
         5lIw8D5xpswKe+RrLP+gQSmf1Y9kTT5aw44Cmh0uqE58epfrR/Lt/ekwQ7xZuWwDMPI+
         4GE9H23R1c6cRCELyWMfIFbvYH+vjPNm8SXbHYHgO0zWmVm3sJEfH6kLQpJPkX/Rl1yX
         0efRf7fMHx2MjxDPUWZg+EZL9azdY/e184Mh/pTbRwEcHiK4CZG77E+7tmXcCltRdSej
         QhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tg5G4EHdsp8D34zYrPgeEgWJ5a4qkrRxOx3WVGEN8fU=;
        b=ncdaJE3M5Klq+LCq45UZStF6I4zreo8hU2Aj4YZXf/lG6LZTCM3mW++Ddsw58wFCcY
         +ngN83R5VC5zMpxLJjyCEQeTBQzocEtn/69Xt1zK/go75b04zaM4Ss+g5eLQDtdQsytW
         5BViVACn3w1ccUDwgW3VM/yWzmcTovLMC8KuCVa1wK9qTA/nyqmOIL2IFwXhHvHfpW51
         J5TVPHeE0h9nLFj6OzuKT9HsrHZPHKz8glwvRfaaTfrt4i9Yv00tthXiWgKJQdLIWSWr
         82KMern+vhmC7I/W6SYjbg7N6Ocz1S8zHvYhHSD5sCgEaiiwaNNyTi/u2188Yy2jWG2g
         +/bw==
X-Gm-Message-State: APjAAAX9zG+JphPKrokzLvh2O3937V5DtBMkmLAPI60IrK052xvMLEI7
        0NDiuZFx3jQ3X2e3AwSS7uo=
X-Google-Smtp-Source: APXvYqzN5EU2k8674nLx996z8n1uZTUDKTn8VhT3YOXFc6lb7g90HIQpJyLvBgwgJImjiPmdvNdh5A==
X-Received: by 2002:a17:90a:db43:: with SMTP id u3mr42468747pjx.54.1571163956306;
        Tue, 15 Oct 2019 11:25:56 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e14sm24254pjt.8.2019.10.15.11.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:25:55 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:25:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 11/14] software node: move small properties inline
 when copying
Message-ID: <20191015182553.GG105649@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-12-dmitry.torokhov@gmail.com>
 <20191015122028.GI32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015122028.GI32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 15, 2019 at 03:20:28PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 04:07:18PM -0700, Dmitry Torokhov wrote:
> > When copying/duplicating set of properties, move smaller properties that
> > were stored separately directly inside property entry structures. We can
> > move:
> > 
> > - up to 8 bytes from U8 arrays
> > - up to 4 words
> > - up to 2 double words
> > - one U64 value
> > - one or 2 strings.
> 
> Can you show where you extract such values?

the "value" union's largest member is u64, which is 8 bytes. Strings are
pointers, so on 32-bit arches you can stuff 2 pointers into 8 bytes,
while on 64-bits you have space for only one.

> 
> > +	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
> > +		/* We have an opportunity to move the data inline */
> > +		const void *tmp = dst->pointer;
> > +
> 
> > +		memcpy(&dst->value, tmp, dst->length);
> 
> ...because this is strange trick.

Not sure what is so strange about it. You just take data that is stored
separately and move it into the structure, provided that it is not too
big (i.e. it does not exceed sizeof(value union) size).

> 
> > +		dst->is_inline = true;
> > +
> > +		kfree(tmp);
> > +	}
> 

Thanks.

-- 
Dmitry
