Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD3307BF7
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jan 2021 18:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhA1ROq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jan 2021 12:14:46 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:43903 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhA1RMm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2021 12:12:42 -0500
Received: by mail-pg1-f175.google.com with SMTP id n10so4676195pgl.10;
        Thu, 28 Jan 2021 09:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7IZgfmQPy76ebRsuihPtDZZCFVdTlHAyz3G2qFI1HQw=;
        b=n8aY1DjBrdZL0L0LObg4DGj4tb9lgKqritlJqUBfBFCWIlnztMbwyRmO9Pv++/bePP
         rRG5WXD0hkdWLSTN/JjUzQ2zMKrjxbeA8mIHMvMZ9IZhUr4UJ7Ab8HHj8Mbilq4z9vZU
         ZAoy5HxmCXbmmecbCUS1bCPLK1b3Xdtg6vSbdPyhVNte3Fxd9rjkViSWWzm9JNZZEjaB
         JyoAh74r2wl34xGIDRJj5Ic1xkrLJ4xpeptXQN9fpKnKmMazNsmRLd/NVMBt9ByJzEBD
         sq94dx2HcMfWAn/gH1fsQ628LOxX78IoLBhgioOs/tTcl3USTheWmr61oIlqq5AbG+6R
         RMhg==
X-Gm-Message-State: AOAM533hxN5v+6YvXQC5ps8CNhVWvkRr96QeFg5UgRcPWWesIgGHopYK
        /R50mXQesxrzYIte/TSN8zI=
X-Google-Smtp-Source: ABdhPJzPaExRZtIKUJvIRjA8Cw4fxIv70iGyA6SNDMcUfKU1EIESlQSKazH5tToRW2b3DphD4uynrQ==
X-Received: by 2002:a63:4a1a:: with SMTP id x26mr520693pga.260.1611853920802;
        Thu, 28 Jan 2021 09:12:00 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id y22sm6295168pfb.132.2021.01.28.09.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:11:59 -0800 (PST)
Date:   Thu, 28 Jan 2021 09:11:58 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     lorenzo.pieralisi@arm.com, Moritz Fischer <mdf@kernel.org>,
        Will Deacon <will@kernel.org>, guohanjun@huawei.com,
        sudeep.holla@arm.com, linux-acpi@vger.kernel.org,
        moritzf@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net
Subject: Re: [PATCH v2] ACPI/IORT: Do not blindly trust DMA masks from
 firmware
Message-ID: <YBLwXgUJR4L6IiSl@epycbox.lan>
References: <20210122012419.95010-1-mdf@kernel.org>
 <161175296410.16506.7622624950228429208.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161175296410.16506.7622624950228429208.b4-ty@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Catalin,

On Wed, Jan 27, 2021 at 01:09:36PM +0000, Catalin Marinas wrote:
> On Thu, 21 Jan 2021 17:24:19 -0800, Moritz Fischer wrote:
> > Address issue observed on real world system with suboptimal IORT table
> > where DMA masks of PCI devices would get set to 0 as result.
> > 
> > iort_dma_setup() would query the root complex'/named component IORT
> > entry for a DMA mask, and use that over the one the device has been
> > configured with earlier.
> > 
> > [...]
> 
> Applied to arm64 (for-next/fixes), thanks!
> 
> [1/1] ACPI/IORT: Do not blindly trust DMA masks from firmware
>       https://git.kernel.org/arm64/c/a1df829ead58
> 
> -- 
> Catalin
> 

Should we consider this for stable, too? If so I can send an email to
stable@ once it's in Linus' tree, since I'm the one forgetting to CC
stable in the first place :)

It would be nice if at least 5.10 would get this.

Cheers,
Moritz
