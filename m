Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F3DCE620
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2019 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfJGOzM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Oct 2019 10:55:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44735 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGOzL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Oct 2019 10:55:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so15652577wrl.11;
        Mon, 07 Oct 2019 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zyoLjL42jHZiwxAXIV2/XDf7QRXhcD/Qv0lwPPBYTCw=;
        b=B3otWI4U0GSNrjqwP6usJ0QsQXw4reQk8JjX63gKbNmDqAXYg4VYGfTbWUjktkuzGX
         +xaCfb5w2mNmI+cZOUkZOU2oHYUZaeDacr7lOFz0b6bpbtHDBxwDlGimM2pweeUoUckb
         v71aW6da+G0WmrKWP7WjLNZbCZDKxBxv68vuIk2coAyjeKrN0uLlkMoQjeEjUizhgWhB
         81cL91Uw1tAqjPAg4Q1xObpfA9FCGncyUd+XXhjU/zpBiTAHru93glYwQ6hFXRh0jU+c
         o0lQx8rf0p+RmPNf5M6kyseZ00wCTEeZa7k7f3nPTm7LwKAffx8C99poDTbS0a5pit/4
         HeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyoLjL42jHZiwxAXIV2/XDf7QRXhcD/Qv0lwPPBYTCw=;
        b=MlW0ojwhToYlPfCDYVsgL6bxsaI8PSKD9se19pgLFkzBC1di8Ame4yu0n9sLxvTZ7N
         LPNA36+M3umUPsZ7V2k7g3Twuq8cZjm4608xYvuW/lcmVDq92A2P7IVJxn6PNQWuMH2h
         oladtQ9b0xd2HvtC+BMR7OZlxEMDEDJ4Xd1TCHVmqHfW4rWnlz2iQuknzjliGqlkiMUb
         2A2r3/6j7B2GLSc33m4MYmWMaywqU86jYXpnEg9o/hbmhHrIJO5Xt5SADzGSB64euEQe
         aXky1pvmOyBdrV+zCPu8KqY2xaaUIaKp1oTfVoINAVUgRe7rqhLR9tc5CZcLLteyAGpa
         wu2A==
X-Gm-Message-State: APjAAAU0Xt0ESDp0yqiD8NSZa11U4LHGDxea7S9ezVYEbJZ6UOOySJYK
        51paO4IydqjJnfi69XJRqZeB28+x
X-Google-Smtp-Source: APXvYqwE7b8tg9jRbFJHNexgtg4+8TZ17/nub3x5etgIlxbBApsOnGRJD+30XW12FT483Q+wyoX9kg==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr22942357wrq.78.1570460108023;
        Mon, 07 Oct 2019 07:55:08 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s1sm26307592wrg.80.2019.10.07.07.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 07:55:07 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:55:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Keith Busch <keith.busch@intel.com>,
        jglisse@redhat.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linuxarm@huawei.com, Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V5 3/4] x86: Support Generic Initiator only proximity
 domains
Message-ID: <20191007145505.GB88143@gmail.com>
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
 <20191004114330.104746-4-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004114330.104746-4-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


* Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Done in a somewhat different fashion to arm64.
> Here the infrastructure for memoryless domains was already
> in place.  That infrastruture applies just as well to
> domains that also don't have a CPU, hence it works for
> Generic Initiator Domains.
> 
> In common with memoryless domains we only register GI domains
> if the proximity node is not online. If a domain is already
> a memory containing domain, or a memoryless domain there is
> nothing to do just because it also contains a Generic Initiator.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  arch/x86/include/asm/numa.h |  2 ++
>  arch/x86/kernel/setup.c     |  1 +
>  arch/x86/mm/numa.c          | 14 ++++++++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> index bbfde3d2662f..f631467272a3 100644
> --- a/arch/x86/include/asm/numa.h
> +++ b/arch/x86/include/asm/numa.h
> @@ -62,12 +62,14 @@ extern void numa_clear_node(int cpu);
>  extern void __init init_cpu_to_node(void);
>  extern void numa_add_cpu(int cpu);
>  extern void numa_remove_cpu(int cpu);
> +extern void init_gi_nodes(void);
>  #else	/* CONFIG_NUMA */
>  static inline void numa_set_node(int cpu, int node)	{ }
>  static inline void numa_clear_node(int cpu)		{ }
>  static inline void init_cpu_to_node(void)		{ }
>  static inline void numa_add_cpu(int cpu)		{ }
>  static inline void numa_remove_cpu(int cpu)		{ }
> +static inline void init_gi_nodes(void)			{ }
>  #endif	/* CONFIG_NUMA */
>  
>  #ifdef CONFIG_DEBUG_PER_CPU_MAPS
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index cfb533d42371..b6c977907ea5 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1264,6 +1264,7 @@ void __init setup_arch(char **cmdline_p)
>  	prefill_possible_map();
>  
>  	init_cpu_to_node();
> +	init_gi_nodes();
>  
>  	io_apic_init_mappings();
>  
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 4123100e0eaf..50bf724a425e 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -733,6 +733,20 @@ static void __init init_memory_less_node(int nid)
>  	 */
>  }
>  
> +/*
> + * Generic Initiator Nodes may have neither CPU nor Memory.
> + * At this stage if either of the others were present we would
> + * already be online.
> + */
> +void __init init_gi_nodes(void)
> +{
> +	int nid;
> +
> +	for_each_node_state(nid, N_GENERIC_INITIATOR)
> +		if (!node_online(nid))
> +			init_memory_less_node(nid);
> +}

Nit: missing curly braces.

How do these work in practice, will a system that only had nodes 0-1 
today grow a third node '2' that won't have any CPUs on memory on them?

Thanks,

	Ingo
