Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D280578C28
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jul 2022 22:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiGRUwl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jul 2022 16:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiGRUwk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jul 2022 16:52:40 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BF232464;
        Mon, 18 Jul 2022 13:52:39 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id d4so6676829ilc.8;
        Mon, 18 Jul 2022 13:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sDzrGFv/POvYUmkSXQk+JeZ+9cmmjO01b/b6PiXOSLY=;
        b=XPqGKcbqifFEpQrCQw243nmyU0SpGwXMPYgtbUwCugFIqnIoIZinX9MYXH9omy+Shx
         HHaX4OBS6i7PJpOWvIkLV/SHqwTyLM22flp2NwScGxadUKA7em05/bpxiEJy82MN/Zj9
         o1GjdQhLEDqBSi+ruZU3cNoeaVsKY3hi3P1nAhHFmNIonm/uIQs5oRKn4yrVox0A+Zx+
         Vm3j6CKy+U9N0+CWB1QM02gybHkUIXwS9eYb8XhLqaop6BUmnGjzQlRIYmuO7AqcZ+8B
         td9hbkOY4z5jc9+bVK8mjwwDbYdd5R2MTibR+/g0amhRi1ldQRdCOnWIOXcwsO6b+e6W
         ikVw==
X-Gm-Message-State: AJIora/mzUiISEF7uzUvX5ejjstAEmJr2lGUQ5h5bDlKGQUTXhYjMuWE
        v+o0gANLgi81TUEzbLaILA==
X-Google-Smtp-Source: AGRyM1vb7zM4lozED+1rA0yZakxdeUePx8hrfiscG1eRGVqn0iP39b9cl/tpn83B+6ntm6WghLMb0Q==
X-Received: by 2002:a05:6e02:1c23:b0:2dc:e497:8b12 with SMTP id m3-20020a056e021c2300b002dce4978b12mr4019353ilh.151.1658177558514;
        Mon, 18 Jul 2022 13:52:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o5-20020a022205000000b00339f193b8ddsm5848337jao.130.2022.07.18.13.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:52:38 -0700 (PDT)
Received: (nullmailer pid 3532480 invoked by uid 1000);
        Mon, 18 Jul 2022 20:52:36 -0000
Date:   Mon, 18 Jul 2022 14:52:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 4/4] dt-bindings: gpio: add pull-disable flag
Message-ID: <20220718205236.GA3532446-robh@kernel.org>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
 <20220713131421.1527179-5-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713131421.1527179-5-nuno.sa@analog.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 13 Jul 2022 15:14:21 +0200, Nuno Sá wrote:
> This extends the flags that can be used in GPIO specifiers to indicate
> that no bias is intended in the pin.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  include/dt-bindings/gpio/gpio.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
