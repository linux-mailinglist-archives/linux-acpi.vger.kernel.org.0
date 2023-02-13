Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D65694E75
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 18:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBMRxZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 12:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjBMRxY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 12:53:24 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8518E35A9
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:53:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gd1so1897883pjb.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9oVVr3kQ4dvAV/kgzEs7a/6cws3klBr48elRB1k69r0=;
        b=LgKghyebGOh3bP8hEzFdfwGSMH1cBm60cGIsaZx4fuMF1cE9MKe95/CBSIay+QUiGs
         K5K6RtfkTuHGEqjv71opafmVuUPM1Nft/EzzyEKVJzTBUNUKnOaRBfq5zjBK3LgJ7fVw
         OzZi5n1ouKx3lYXXyr4Ci0lh/xE3zl88BMexkD/o8grh8QpNpfJxB67leAlRvdwdTyUP
         taku6PTjeZisqV4wQzgbj5BhHK48ei4lFfl67jUv16Bloub9IASuBmpue9CPJbJoktbr
         Ec8HgAJl7XpobYesmC2Bu271Eao9xSQUoxQJDVTEe1yJQKnR3QDoCJ0UisuThdBFETZZ
         w5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oVVr3kQ4dvAV/kgzEs7a/6cws3klBr48elRB1k69r0=;
        b=0aKCcAw6xunBViZU1JmzpDnPYSXXESFUyrgLLHbZfPn7bRqyIo76Wp/1qJI8tkl4mx
         3VcXybh4nmu44S2kkghY6MGZ+qjQ0YUQWcl3OZpMnfQj7fIiwCZJp9ZCBRIIlfT10TEU
         t6PpOIiYg+/HMVyXD+Dyg8HqbS7PrcPSL3Bn5adV2HCjP/n1/LN/jlqMbtC5kbwlNIGQ
         kAH+WdoIQe5Kghbq5g7hFWMRfMsiopBLVwuQEt20CPPtzgmdFtBrE3ZgpfNzIWHBQN0I
         IO1sQBK3gRT0RqKPZ3oxhjzPOVR8HgiTNkJQZlt2+rXgaI2WT1+aOaW7+M4va0x1IFkY
         aXHQ==
X-Gm-Message-State: AO0yUKUG17ZghhElUgQe0+OFCuLyKuFxVG/lHlbHcMRa3n8lrtUpHWj4
        y5f5HYAMQCQauYkE/IrwMqO2qA==
X-Google-Smtp-Source: AK7set/Qv3EVerw9Rt6XlSc5yNUHkObHYZU2J5Vc5WEa1EMKFQCvEB+ZhzHAg32cootQVX1l5sQS9Q==
X-Received: by 2002:a17:902:c791:b0:19a:9642:dee8 with SMTP id w17-20020a170902c79100b0019a9642dee8mr5270304pla.0.1676310803091;
        Mon, 13 Feb 2023 09:53:23 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902b71700b001933b4b1a49sm7453935pls.183.2023.02.13.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 09:53:22 -0800 (PST)
Date:   Mon, 13 Feb 2023 23:23:16 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 23/24] MAINTAINERS: Add entry for drivers/acpi/riscv
Message-ID: <Y+p5DL/c12naJotE@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-24-sunilvl@ventanamicro.com>
 <Y+Vroj6CmrL4I9lN@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Vroj6CmrL4I9lN@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 09, 2023 at 09:54:42PM +0000, Conor Dooley wrote:
> On Mon, Jan 30, 2023 at 11:52:24PM +0530, Sunil V L wrote:
> > ACPI defines few RISC-V specific tables which need
> > parsing code added in drivers/acpi/riscv. Add maintainer
> > entries for this newly created folder.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8a5c25c20d00..b14ceb917a81 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -450,6 +450,13 @@ S:	Orphan
> >  F:	drivers/platform/x86/wmi.c
> >  F:	include/uapi/linux/wmi.h
> >  
> > +ACPI FOR RISC-V (ACPI/riscv)
> > +M:	Sunil V L <sunilvl@ventanamicro.com>
> > +L:	linux-acpi@vger.kernel.org
> > +L:	linux-riscv@lists.infradead.org
> > +S:	Maintained
> 
> Supported, no?
> 
I prefer to keep it same as ARM.
