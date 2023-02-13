Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF57693DC4
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 06:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBMFNx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 00:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMFNw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 00:13:52 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC106A5E6
        for <linux-acpi@vger.kernel.org>; Sun, 12 Feb 2023 21:13:51 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so11047224pjw.2
        for <linux-acpi@vger.kernel.org>; Sun, 12 Feb 2023 21:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/rXlbQZUiYssX0GWdtn60fAH8aeaRBmLehOaQBY1mE=;
        b=BczA9Dit8WldsIfP8UBgYlgc8TWJhovdzXsusWUlS+5qwERWfEecSRfNvw2jdkipTt
         FftWA7ruHlkUk3JVzZ1R2/G95S9ueaU75uXAfKH/d+o6Wvx4A4+tsy2UkZIZma/LHypW
         b1HtPzukBNiYeS0/OLsWF5NHpFKXqO/xMwlEYEGDKUzBZ8D91k9sx7/8fVBaxjddDALw
         /YCfRX/nPAgzOb51JRnSuTkMLiQr0ZQA5dXciGNdnFXKrI+gu84pYpUm/ENQNd65VC1s
         ugorSZLeiHIEBj3MNBjGdwfT2IeeGdw1kY8bm8vt05A2ZhJTkpwI5IEJNhKGy16PpfJv
         i99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/rXlbQZUiYssX0GWdtn60fAH8aeaRBmLehOaQBY1mE=;
        b=YjtSvbQNQKyZ3vSfPuVW5bWMeqBDSITWVvjYVwUKY56WSz+UTFOOad/k3tviVvl/rJ
         Y3qAnnvijMRcwnC7VEL2QviFQYxbw/QHHXwNtVwrWFzqiIECXKMqBBWeOOfpHeava6D0
         5GD4myxZ7eDnbHzlwQLYki+db3FbzBVx9OgNJ5+s5Cs7Q92ogq/YasetUmtRL90DOra6
         lQDDITZtUjjZTBDCk6GueqjwicQLTzCJ+FzsGjAjSXtW9drNI0bSskP+i5m5iz0jF5Sh
         Zg4PNKU6Dnint0VGeJwaLtIfeegceLTa7GXl7Bnqnw05441pWXl370eR1VorutLDCIEo
         qTMQ==
X-Gm-Message-State: AO0yUKVHacP/ssnSh+0aVRbcfiksxlV+DZPBSDNeL502gii2PvYpePO+
        Nd9e5o1a7Y8TYF5BMLWlqgB4kw==
X-Google-Smtp-Source: AK7set+HBd/TKOpekO2R5ZNBdJ5nlE4W2Q0OVyhq7zVLBYibkTxtu4XeGFM4NuzAT9/O7iEzdrKiyA==
X-Received: by 2002:a17:903:24c:b0:198:a715:d26d with SMTP id j12-20020a170903024c00b00198a715d26dmr25510023plh.8.1676265231494;
        Sun, 12 Feb 2023 21:13:51 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00198f9fa23a3sm7079601pln.287.2023.02.12.21.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 21:13:51 -0800 (PST)
Date:   Mon, 13 Feb 2023 10:43:42 +0530
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
        Atish Patra <atishp@rivosinc.com>,
        Robert Moore <robert.moore@intel.com>,
        acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH 02/24] ACPICA: MADT: Add RISC-V INTC interrupt controller
Message-ID: <Y+nHBivfemYR2NGD@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-3-sunilvl@ventanamicro.com>
 <Y+P/BDbP68vNTOao@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+P/BDbP68vNTOao@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 08, 2023 at 07:59:00PM +0000, Conor Dooley wrote:
> On Mon, Jan 30, 2023 at 11:52:03PM +0530, Sunil V L wrote:
> > The ECR to add RISC-V INTC interrupt controller is approved by
> > the UEFI forum and will be availabl in the next revision of
> 
> nit: available
> 
Thanks!

> > the ACPI specification.
> > 
> > This patch is not yet merged in ACPICA but a PR is raised.
> > 
> > ACPICA PR: https://github.com/acpica/acpica/pull/804
> 
> I had a quick check with git grep, and as this doesn't appear to be a
> regular pattern in the history, so could you please make this a regular
> Link: trailer?
> 
This patch should be merged in acpica repo first and then we will get
this in standard format. Until then, it exists to allow other
patches get reviewed. I believe by the time we get all other patches
reviewed, acpica will have this merged.

Thanks!
Sunil
