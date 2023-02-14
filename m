Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97C86957F5
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Feb 2023 05:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBNEmZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 23:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBNEmY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 23:42:24 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A3D17CC3
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 20:42:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id bd35so4390736pfb.6
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 20:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IytFRD13wyHkORVwldfX0cj+olMfAcIjoNBkr5UdNv4=;
        b=CpaV4dVNUa0pCGK5PDzg426zSTmY7CxCQXGkQc/due8N9WbSNf6YnYNaaZJlzPQzRU
         4s0iVdibYJ1vax2anrQWNpvuZAStqApzDgYGWguJpL56MKYEoQgZaI+vmNIiamU8lFDV
         tyzEA6plQxp7DGNo3rrpCE6kEmRoWISwepZNgWnkKgHTSGrSSjYfZw8BEh9uYnOmnu1y
         3zFRl0bQ3jXcROaXtBLT4UglIskyT4lWVFuYiMxAiHOSaik7J+HXrvgqyyWxXOa5eCoY
         Ns5YOAcrrMGyhU6lBeuM1ckz+k2ZSKU+hls5ed89+Q3rPD5x9fgKjshULNq9RO13E66x
         s13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IytFRD13wyHkORVwldfX0cj+olMfAcIjoNBkr5UdNv4=;
        b=pp4ZRDimuZNDtY0eo1sHQcBv1gZM98fERsf0e9xqYBRJXWD1mmt+mDnybyfovFVqcG
         a36jBwkuRPpdKVPrDRqOz9hQE+sumdPOUSu8gLuD9AH5p1WMMyhrSbQXWWfTCCICmzBC
         z/qFr6cjjcYy+IgYMpBo6SyyLCWSB8p0jXhyUCopTRK5EPX6dB6bLBtxwu7CmdUeSA+E
         0jfaotqpx27MH+72nbHH5FeWX7PBS/j1GXB+stxRQHcrDfMZabpm9g43xsox7nOuCdrw
         0krN+1kLxY0bqnEJiMv563XCB76Wk7+gZmq1MXV1WWeH8zmWgHJJp2+xGyLXjl3ROdqS
         itWA==
X-Gm-Message-State: AO0yUKV4OmxhnVBldibbbQ/Sz7vvnvpBKguNoOu8VLsJPqyij2BYL4tq
        U0+Xul85Er2FPl2Lm9o+FzQBDQ==
X-Google-Smtp-Source: AK7set/4s/cLnv837AHxP+fni/9CnhX3OJuvf1GQstOD0qP6CHuBqukJFcvLiwos3jjiUZAL1jHLxQ==
X-Received: by 2002:aa7:973d:0:b0:5a8:be36:65a8 with SMTP id k29-20020aa7973d000000b005a8be3665a8mr750675pfg.27.1676349742500;
        Mon, 13 Feb 2023 20:42:22 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id i9-20020aa79089000000b0058173c4b3d1sm8285835pfa.80.2023.02.13.20.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 20:42:22 -0800 (PST)
Date:   Tue, 14 Feb 2023 10:12:13 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH 06/24] RISC-V: ACPI: Add PCI functions to build ACPI core
Message-ID: <Y+sRJVf985vXvQG/@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-7-sunilvl@ventanamicro.com>
 <33DF2416-0629-414D-B50E-D99CB55A83AA@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33DF2416-0629-414D-B50E-D99CB55A83AA@jrtc27.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 13, 2023 at 05:26:13PM +0000, Jessica Clarke wrote:
> On 30 Jan 2023, at 18:22, Sunil V L <sunilvl@ventanamicro.com> wrote:
> > 
> > When CONFIG_PCI is enabled, ACPI core expects few arch
> > functions related to PCI. Add those functions so that
> > ACPI core gets build. These are levraged from arm64.
> 
> Presumably this is pretty generic and applies to anything without x86
> weirdness. Copying all this supposedly architecture specific code
> that’s really generic seems like bad practice to me as an outsider.
> Should this not be unifying the two in a shared location as has been
> done for other subsystems?

Make sense. Let me add these functions in a common location pci-acpi.c
for RISC-V. Other architectures can migrate to this in future.

Thanks,
Sunil
