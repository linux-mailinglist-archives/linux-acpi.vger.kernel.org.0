Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29502D1871
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 19:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgLGSXV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 13:23:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726110AbgLGSXV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 13:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607365314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sdDUmxzObkvlmtgXKPhQxtpEVX8JbdclTJVfFITbFQ=;
        b=KSCCZVzuiSnQdYHVsbxa7OSvyWD/O9GyiTAxEeh3YI3nayOj+sA9OInRtCv/NNiGtLjMxC
        msRpWo5QMMeizWuoC/R8Kjbyylz5jLHShOgdvSDqyqtG+n63or6x8OJQ9Mac1dZj14knA3
        q0ZohvSNza5kyhNKee+dmnN1S03x65k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-NdQTsd9xPAap2wEUlkOt4A-1; Mon, 07 Dec 2020 13:21:53 -0500
X-MC-Unique: NdQTsd9xPAap2wEUlkOt4A-1
Received: by mail-ed1-f72.google.com with SMTP id u17so1371082edi.18
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2020 10:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9sdDUmxzObkvlmtgXKPhQxtpEVX8JbdclTJVfFITbFQ=;
        b=pbXO4VUHo7mEdTjjc+joj4IE9qKfjej+Nv/4vJy0f/IN8NAR5PF3LWCgFy7mFn0dvY
         sXLQeSy/2HFRioltHBktfboYJ5vqS0Seb+DWEqdQL0FtksbkMGnle5efzkV0UvPjn0N5
         v7bMWhEvxFmGgIkkTfBO3m4o82VVJEo51QPJsZE18sTNYhU761QJQ2Y9PbxoTkjT5jSD
         yDqh4S39bTpb0a9GrVWGHuSxKiFkch8VCa+vHJsN1RZnsMaq4DmB30JeAaUeePat3kt4
         KUleBOYfx5CVuIRq+cz0dQUmt63E0OSeJlc3YD8N4N5GRerlDm0iT35hcj2zP42x89QD
         PwdQ==
X-Gm-Message-State: AOAM532DORpKjpD04urxE/52zTwv3XDMFQejMl6n/d0i7P5mv5Zrmljp
        CiaRAyqbWIhgyDJxoyqIXQGB5R+z52ZHFvEU4h9xpKJ4+CfW9heALNKqKQQwG5GJJNsGmBbHtyx
        BCRB4VIxlHLOYfj/mvoTn0A==
X-Received: by 2002:a17:906:4bd2:: with SMTP id x18mr19721834ejv.464.1607365311272;
        Mon, 07 Dec 2020 10:21:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysF62b/9EGmsRFN0aGkV9U90I0qPEfB39SdKUggYcDeLV+AkT7k5X5iH/EBJ9lML6lAu1cSg==
X-Received: by 2002:a17:906:4bd2:: with SMTP id x18mr19721820ejv.464.1607365311099;
        Mon, 07 Dec 2020 10:21:51 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u5sm14291209edp.5.2020.12.07.10.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:21:50 -0800 (PST)
Subject: Re: [PATCH] ACPI: scan: Fix up _DEP-related terminology with
 supplier/consumer
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <6314382.p3e4rEhblS@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <054cc790-bebb-9c84-e14c-16b9460d1636@redhat.com>
Date:   Mon, 7 Dec 2020 19:21:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <6314382.p3e4rEhblS@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/7/20 6:46 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI namespace scanning code uses the terms master/slave when
> populating the list of _DEP dependencies, but that use has no
> external exposures and is not mandated by nor associated with any
> external specifications.
> 
> Change the language used through-out to supplier/consumer.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/scan.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -51,8 +51,8 @@ static u64 spcr_uart_addr;
>  
>  struct acpi_dep_data {
>  	struct list_head node;
> -	acpi_handle master;
> -	acpi_handle slave;
> +	acpi_handle supplier;
> +	acpi_handle consumer;
>  };
>  
>  void acpi_scan_lock_acquire(void)
> @@ -1881,8 +1881,8 @@ static void acpi_device_dep_initialize(s
>  		if (!dep)
>  			return;
>  
> -		dep->master = dep_devices.handles[i];
> -		dep->slave  = adev->handle;
> +		dep->supplier = dep_devices.handles[i];
> +		dep->consumer  = adev->handle;
>  		adev->dep_unmet++;
>  
>  		mutex_lock(&acpi_dep_list_lock);
> @@ -2058,8 +2058,8 @@ void acpi_walk_dep_device_list(acpi_hand
>  
>  	mutex_lock(&acpi_dep_list_lock);
>  	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
> -		if (dep->master == handle) {
> -			acpi_bus_get_device(dep->slave, &adev);
> +		if (dep->supplier == handle) {
> +			acpi_bus_get_device(dep->consumer, &adev);
>  			if (!adev)
>  				continue;
>  
> 
> 
> 

