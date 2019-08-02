Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C737FB65
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2019 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfHBNoc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Aug 2019 09:44:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37930 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfHBNoc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Aug 2019 09:44:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so77238857wrr.5
        for <linux-acpi@vger.kernel.org>; Fri, 02 Aug 2019 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PNAMiOH+KosAOfYs6ZQtMwro3Z+vEfTrrxaffk0uncw=;
        b=NxwSMQH0vURU2W7+Q0c9vrt0Vwrgyu94uuj3bwLxRVMOwmF4uqRIsMaAwkj8hTLEw8
         F1owxyRhpAQgSTovu/e2I52MO0Lolj2UMZgkg4JcrL+hRFdAcKRup/OvDhVaw70ZQq+V
         uvvKNDR+Zb5oEGRPzvhI8ih8UF3S+73PGW6eEUsbVjiCwgXHvw6DNRw+aCeSMRfJTbc/
         Zv0NbVhFgaJBPIctMWHtB1DCNZF8m2HZ8kKkoUGbtw3giIBybfz1dL1m33ixcvo8XwhC
         49Vev+h9RdY7NHBCJpy2RRnrcKCF4RI0N6QcyA75OUDODMM5Q8sFHIyeOO2WY43RnnWz
         JQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PNAMiOH+KosAOfYs6ZQtMwro3Z+vEfTrrxaffk0uncw=;
        b=CotxPB7jK75L8vw3gb4pzbtScr3/Yqeo3s78iHXwSsAb4Xa1n35wlSAUZy8lE+4WVh
         IZWRF7+17Ykdm9KsiRLm+W/+COxIPpWyqZmQaS5k9DWn1EqzPfRHm6ZlTJMam5pDzFqu
         /OiKm1FXMuXA7NmHpfCvrgVY736qvFhRDPjRJeU491BfNOr5wldBJP9BoeSADvNROWnF
         PT8S6hfCgWLoK6tKzh6DCAPgE3nrqHqE31/Helg6FQwkXOiLUhM771sMHB3SQQxiGR70
         T4VxKm7ofDDvapeYb5BgwAdvm60uG+tMOJffvnkAwNqbjxIUIRjXZVeg8wtkaED3gxh6
         zojg==
X-Gm-Message-State: APjAAAU8gASIq4ykIL58JN1ZXsxkD38sREi0NWwYRUjJ96x7aUR8aiez
        wHpHbln0CgB682Axpx601jw=
X-Google-Smtp-Source: APXvYqxZf4Umt0uqJeK5AzqQ3YwB8DEWEFy4owFZTJg4xeIJXE8GO65jbt3iPMWS9EZ8KzsKnTHfxQ==
X-Received: by 2002:a05:6000:187:: with SMTP id p7mr22834655wrx.189.1564753471024;
        Fri, 02 Aug 2019 06:44:31 -0700 (PDT)
Received: from rric.localdomain (x4e375ad3.dyn.telefonica.de. [78.55.90.211])
        by smtp.gmail.com with ESMTPSA id i18sm99708446wrp.91.2019.08.02.06.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 06:44:30 -0700 (PDT)
Date:   Fri, 2 Aug 2019 15:44:27 +0200
From:   Robert Richter <rric@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, sudeep.holla@arm.com, will@kernel.org,
        lenb@kernel.org
Subject: Re: [PATCH v4 2/2] arm64: topology: Use PPTT to determine if PE is a
 thread
Message-ID: <20190802134427.dmclik66zcgxapy3@rric.localdomain>
References: <20190801034634.26913-1-jeremy.linton@arm.com>
 <20190801034634.26913-3-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801034634.26913-3-jeremy.linton@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 31.07.19 22:46:34, Jeremy Linton wrote:

> @@ -358,6 +356,10 @@ static int __init parse_acpi_topology(void)
>  		if (topology_id < 0)
>  			return topology_id;
>  
> +		is_threaded = acpi_pptt_cpu_is_thread(cpu);
> +		if (is_threaded < 0)
> +			is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
> +

I think the return code handling is error-prone, as in the kernel such
functions are typically used like:

	if (something_is_thread) { ... }

I see this is due to acpi and arch code separation so we cannot simply
move the fallback to pptt code.

So maybe we have a static function cpu_is_thread() in this file that
handles all the logic and directly use check_acpi_cpu_flag() from
there. However, code may change here in case of a rework as I
suggested in patch #1. In both cases the acpi api is more straight
then.

-Robert

>  		if (is_threaded) {
>  			cpu_topology[cpu].thread_id = topology_id;
>  			topology_id = find_acpi_cpu_topology(cpu, 1);
