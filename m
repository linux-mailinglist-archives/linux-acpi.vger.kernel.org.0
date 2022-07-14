Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBAB57422E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 06:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiGNEU7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 00:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGNEU6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 00:20:58 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07802252A8;
        Wed, 13 Jul 2022 21:20:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so7056679pjo.3;
        Wed, 13 Jul 2022 21:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mrgABAOPXIqnoxNX/Ij0KBpROHcNGooVUjMudajcz/g=;
        b=cl07ZWIwxwnTInCiRgVPiZA/H/npfaSPXfYzoMYNB05WNyren7DToX+zPthoxaDmhW
         6QLS5/pW3yXZWfoN4ZW4R5+a8BpboPEoJhL83ekvendzpWbfY1fjCtXYVqY+XGjuYC/M
         DHSJultXsCoqXFGxx/NPR+zx+4VhDhhwrunRjOAMtmLCBcdxNB0SXBYPYYtrJ1LFOOBe
         KKl84YF1jzvEhLKhPKggCsKiX6jm60G5OIUaifYrhgNwfpVxjPMP0YOmrayHlxw4XoPr
         GmL4DpJuTCi57l6tS+NhyPW2cSFla7A4QtglZMLot4iNyRPBXFr5dFbiLcA68JfepH1l
         CF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mrgABAOPXIqnoxNX/Ij0KBpROHcNGooVUjMudajcz/g=;
        b=g7Q4SSST16ydshudlFnRtyFKi+NslMGmREEiJ3tqJleq0rrNNYV1PApovMCy2om9cU
         OJWByQ7HXG4UEFYqJEtN2/iOs+pynUN5QjVS6HmY5YfcbgUgpKlB1rgQE+p1FtW7P7ng
         1tDVxS50bcWhSxETlI1uIwkM9IqMeRh+ay/Uvf4lgHW2hvuHLI/egHaD6TyLtWnKZT9N
         7GpEZ6FUeohrdh4Digb5jqZPcR2jjSQmjZN6w1aNWDe3VI3LM2hlErtG85hP+GmuHFtI
         NWA5Z9HphCPl4NmDakO59AJc3Sroaex84Em/3ce0IPAUSb63bZGxp7KnyTWy4n5ZyiHF
         KMBg==
X-Gm-Message-State: AJIora+N3DpInx+BxdW2CrVps0+02AjlHWIMRwfxzABStuP1vseBDRXz
        G5TRumyy+pRAq27IdYfqPTY=
X-Google-Smtp-Source: AGRyM1v/oGRNKBO7rocEOzLw4mxg2piFBftuYiOjM7kJLTGjMSFaoHKOGfyDvfTKL9BCmdNFEwiR+A==
X-Received: by 2002:a17:902:a618:b0:16c:abb9:d7a6 with SMTP id u24-20020a170902a61800b0016cabb9d7a6mr1874336plq.119.1657772457460;
        Wed, 13 Jul 2022 21:20:57 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id y3-20020a1709027c8300b00161947ecc82sm264763pll.199.2022.07.13.21.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 21:20:56 -0700 (PDT)
Date:   Thu, 14 Jul 2022 12:20:50 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] gpiolib: add support for bias pull disable
Message-ID: <20220714042050.GA76737@sol>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
 <20220713131421.1527179-2-nuno.sa@analog.com>
 <Ys8CpqYhWp7zVNC8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ys8CpqYhWp7zVNC8@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 13, 2022 at 08:36:38PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 13, 2022 at 03:14:18PM +0200, Nuno Sá wrote:
> > This change prepares the gpio core to look at firmware flags and set
> > 'FLAG_BIAS_DISABLE' if necessary. It works in similar way to
> > 'GPIO_PULL_DOWN' and 'GPIO_PULL_UP'.
> 
> ...
> 
> >  	GPIO_PULL_UP			= (1 << 4),
> >  	GPIO_PULL_DOWN			= (1 << 5),
> > +	GPIO_PULL_DISABLE		= (1 << 6),
> 
> To me it seems superfluous. You have already two flags:
> PUp
> PDown
> When none is set --> Pdisable
> 

Agree with Andy on this.  The FLAG_BIAS_DISABLE was added, by me, to
allow the cdev interface to support bias.  cdev requires a "don't care"
state, distinct from an explicit BIAS_DISABLE.
The FLAG_BIAS_DISABLE allows gpiolib-cdev to communicate that to
gpiolib, without altering the interpretation of the existing PULL_UP and
PULL_DOWN flags.
That is not an issue on the machine interface, where the two GPIO_PULL
flags suffice.

If you are looking for the place where FLAG_BIAS_DISABLE is set it is in
gpio_v2_line_config_flags_to_desc_flags() in gpiolib-cdev.c.

Referring to gpio_set_bias(), the only place in gpiolib the
FLAG_BIAS_DISABLE is used, if neither FLAG_PULL_UP, FLAG_PULL_DOWN,
nor FLAG_BIAS_DISABLE are set then the bias configuration remains
unchanged (the don't care case) - no change is passed to the driver.
Otherwise the corresponding PIN_CONFIG_BIAS flag is passed to the
driver.

If there are cases of drivers not fully or correctly supporting those
PIN_CONFIG_BIAS flags, then that is an issue with those drivers.

Cheers,
Kent.
