Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74417F7C1
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2019 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392917AbfHBNFQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Aug 2019 09:05:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43393 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388458AbfHBNFQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Aug 2019 09:05:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so2553773wru.10
        for <linux-acpi@vger.kernel.org>; Fri, 02 Aug 2019 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=il2Ej3vHRliPEn6sqXO6sZuqcYtp78kT2DJDKX0yHiY=;
        b=D3PJqvXkehUgJ7EFnE1gNmRspFqaGcYW4guK1N6q7nRPkAxFFE7rj2vbbVHaVAKqmi
         q05/TUKmrPFhyIt4LsJBS/nnfDAqxrBtE59osyWVEdvYNYZcIlDRin0/OXKTldzAftr5
         lLhE7vi2uhlWxG6ccEomevf4GHgds/jY7sID9dZZR4Tus2brra7qTlTK6LnGbb+0HfEo
         gMWAmrlWbD+ArRDbEj8aPFHlEDIB7OtBghqX+qm9JCERxyvezWAOto7rmpQtGKiwbus8
         T/GtpbYupujhuzSxXGHAwafwUEUMxz2xeWmhTeurmadWEihvTOkzUoZWKUmWfgxI9ZXY
         ilYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=il2Ej3vHRliPEn6sqXO6sZuqcYtp78kT2DJDKX0yHiY=;
        b=I/iOIixrxF2BsD64AQXTpAfxDgAkFZdTv41VWNYaxbIvtWfQ/7P2YpOXmcOpdcHF5h
         p1Uy1BJmaFVnkwVLgTrNnsYZQcGNWcnHBH1vHm3ahdZru7+QON1FmM5nk0GY5xS0KWON
         tGFnVVtTnXddyn0a9e2vv8iOoGb+cTxhz0P7FawX32yqusCdwrGcYSrCW4ZxHPP3Fn84
         lTP+Cr9BCgKt1Avfyb2jiVJ9drXFfifhxwV74qre0IEbw2wCEZZkzCiDzfHNpLBM5YJw
         FOe1xE1cY4cS5tfhvwQLN5xacqvO/GzeUg84x3kEit+nPcYoCXdz04v4hN5bgPOmtGgU
         cy1A==
X-Gm-Message-State: APjAAAXoz22nkx6XEA4GfjmX0mBfMHlDThZZ8UyEtQmTOBQn82fl7Y1I
        rz8FU6WbWotDbOKSkbD6sh0=
X-Google-Smtp-Source: APXvYqy6Xh0VOvj4zV+m+M+mewFsvTNPkf1aVgulz9pxWbDZ7xtEsGCJplXZliZM/ojiTUAxS83E3w==
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr70067056wrn.324.1564751114494;
        Fri, 02 Aug 2019 06:05:14 -0700 (PDT)
Received: from rric.localdomain (x4e375ad3.dyn.telefonica.de. [78.55.90.211])
        by smtp.gmail.com with ESMTPSA id y7sm55067297wmm.19.2019.08.02.06.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 06:05:13 -0700 (PDT)
Date:   Fri, 2 Aug 2019 15:05:11 +0200
From:   Robert Richter <rric@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, sudeep.holla@arm.com, will@kernel.org,
        lenb@kernel.org
Subject: Re: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
Message-ID: <20190802130510.rd4uyndtqlcfdhtm@rric.localdomain>
References: <20190801034634.26913-1-jeremy.linton@arm.com>
 <20190801034634.26913-2-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801034634.26913-2-jeremy.linton@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 31.07.19 22:46:33, Jeremy Linton wrote:

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 9426b9aaed86..9d0e20a2ac83 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1302,11 +1302,16 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  #endif
>  
>  #ifdef CONFIG_ACPI_PPTT
> +int acpi_pptt_cpu_is_thread(unsigned int cpu);
>  int find_acpi_cpu_topology(unsigned int cpu, int level);
>  int find_acpi_cpu_topology_package(unsigned int cpu);
>  int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>  int find_acpi_cpu_cache_topology(unsigned int cpu, int level);

All those functions (exept hetero_id) are used only in
parse_acpi_topology(). So how about creating a struct with thread_id,
core_id, and cache_id (and hetero_id (?)) and have a single pptt table
parsing function that fills in all of this into that struct? This
simplifies the api and also the code.

This also shows that hetid (see arm_pmu_acpi.c) better should be
stored in cpu_topology[] too and thus being parsed with the other
parameters as well and made accessible from there by a helper.

-Robert
