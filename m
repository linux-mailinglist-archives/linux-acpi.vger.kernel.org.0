Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254A620B227
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 15:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgFZNHY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jun 2020 09:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgFZNHX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jun 2020 09:07:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 105DF2080C;
        Fri, 26 Jun 2020 13:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593176842;
        bh=16hSAoBgkzFDqdIECQ7sxZWZ9kzrW7zU6H3vwJLq6tc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m1uqulmq0ck9PhOoNMR80zbtNsBuc3vZMydFHgVM30eTcDTQO3CKLyb/jUwyfJJZM
         2exOrslcDYFlIGzMLEfeX9UpbMqiw1CrmHw13q9X7FXlbUqbuKyPcf1jM0VAYrDny4
         oKfGjmf2Vzxb2fapvoQGZTBOm0R0qqWcjevv7yOY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1joo4e-006dkn-Jt; Fri, 26 Jun 2020 14:07:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jun 2020 14:07:20 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Oscar Carter <oscar.carter@gmx.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Len Brown <lenb@kernel.org>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 0/3] drivers/acpi: Remove function callback casts
In-Reply-To: <20200530143430.5203-1-oscar.carter@gmx.com>
References: <20200530143430.5203-1-oscar.carter@gmx.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <07911cc62ef21900c43aeefbcbfc8d9f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: oscar.carter@gmx.com, rjw@rjwysocki.net, keescook@chromium.org, tglx@linutronix.de, jason@lakedaemon.net, lenb@kernel.org, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 2020-05-30 15:34, Oscar Carter wrote:
> In an effort to enable -Wcast-function-type in the top-level Makefile 
> to
> support Control Flow Integrity builds, there are the need to remove all
> the function callback casts in the acpi driver.
> 
> The first patch creates a macro called 
> ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
> to initialize the acpi_probe_entry struct using the probe_subtbl field
> instead of the probe_table field to avoid function cast mismatches.
> 
> The second patch modifies the IRQCHIP_ACPI_DECLARE macro to use the new
> defined macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY instead of the macro
> ACPI_DECLARE_PROBE_ENTRY. Also, modifies the prototype of the functions
> used by the invocation of the IRQCHIP_ACPI_DECLARE macro to match all 
> the
> parameters.
> 
> The third patch removes the function cast in the 
> ACPI_DECLARE_PROBE_ENTRY
> macro to ensure that the functions passed as a last parameter to this 
> macro
> have the right prototype. This macro is used only in another macro
> called "TIMER_ACPI_DECLARE". An this is used only in the file:
> 
> drivers/clocksource/arm_arch_timer.c
> 
> In this file, the function used in the last parameter of the
> TIMER_ACPI_DECLARE macro already has the right prototype. So there is 
> no
> need to modify its prototype.

I'd like to see this into 5.9. Can you please let me know if
you are OK with the acpi.h changes? I can queue it via the irqchip
tree.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
