Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A013A4760
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jun 2021 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhFKREM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Jun 2021 13:04:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhFKREJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2021 13:04:09 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 79F701FD78;
        Fri, 11 Jun 2021 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623430929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uFLF/DAeBIqfywLgKe5uHR/+eJc0g7h5W+DoDmbxoI=;
        b=DtK4HBsg7xH375NlC1YWTcJFTK15TKfAEltUMCH10JbV01PCcgBf8qE8z75AQbuZ5XAENb
        jxdylwtvryGmVoaIgYm5bIFsf9aiwEUlY5AjphuKkfWi1L0C+w/0JZk+u59gZdT3oP/vBt
        nXGx/x0Ms//2eLgUsK0vqRBJFX7xF5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623430929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uFLF/DAeBIqfywLgKe5uHR/+eJc0g7h5W+DoDmbxoI=;
        b=RdD5fGxLiw/3mRcwQqlRVT3Mx0pWXpIpaLxxN1rEjA38R3ZtqlAVe0NM0AqFicWlGEFDPs
        7zru1cKvWEkIjJCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5A95B118DD;
        Fri, 11 Jun 2021 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623430929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uFLF/DAeBIqfywLgKe5uHR/+eJc0g7h5W+DoDmbxoI=;
        b=DtK4HBsg7xH375NlC1YWTcJFTK15TKfAEltUMCH10JbV01PCcgBf8qE8z75AQbuZ5XAENb
        jxdylwtvryGmVoaIgYm5bIFsf9aiwEUlY5AjphuKkfWi1L0C+w/0JZk+u59gZdT3oP/vBt
        nXGx/x0Ms//2eLgUsK0vqRBJFX7xF5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623430929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uFLF/DAeBIqfywLgKe5uHR/+eJc0g7h5W+DoDmbxoI=;
        b=RdD5fGxLiw/3mRcwQqlRVT3Mx0pWXpIpaLxxN1rEjA38R3ZtqlAVe0NM0AqFicWlGEFDPs
        7zru1cKvWEkIjJCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id x4lyFRGXw2CdQQAALh3uQQ
        (envelope-from <bp@suse.de>); Fri, 11 Jun 2021 17:02:09 +0000
Date:   Fri, 11 Jun 2021 19:02:03 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: power: Use dev_dbg() to print some messages
Message-ID: <YMOW4CrbhVCa8l5Q@zn.tnic>
References: <2601165.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2601165.mvXUDI8C0e@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 11, 2021 at 06:58:48PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The messages printed by acpi_resume_power_resources() and
> acpi_turn_off_unused_power_resources() are not important enough to be
> printed with pr_info(), so use dev_dbg() instead of it to get rid of
> some noise in the kernel log.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/power.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/acpi/power.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/power.c
> +++ linux-pm/drivers/acpi/power.c
> @@ -1004,7 +1004,7 @@ void acpi_resume_power_resources(void)
>  
>  		if (state == ACPI_POWER_RESOURCE_STATE_OFF
>  		    && resource->ref_count) {
> -			dev_info(&resource->device.dev, "Turning ON\n");
> +			dev_dbg(&resource->device.dev, "Turning ON\n");
>  			__acpi_power_on(resource);
>  		}
>  
> @@ -1034,7 +1034,7 @@ void acpi_turn_off_unused_power_resource
>  		 */
>  		if (!resource->ref_count &&
>  		    resource->state != ACPI_POWER_RESOURCE_STATE_OFF) {
> -			dev_info(&resource->device.dev, "Turning OFF\n");
> +			dev_dbg(&resource->device.dev, "Turning OFF\n");
>  			__acpi_power_off(resource);
>  		}

Acked-by: Borislav Petkov <bp@suse.de>

Thx!

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
