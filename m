Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CD92CFCCE
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Dec 2020 19:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgLESTW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Dec 2020 13:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727942AbgLESE0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Dec 2020 13:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607191375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngbQFaYupjBC+H+tboAOi4kI6aZEZIqf728BmBL002o=;
        b=It3CLJ5wQw7T6iQ0EhF/stbl6MWLxpbmkzQCUIkaEYRFYbYwWxXUp+pQp08FMillnIFCEp
        Rmdt2eWoVnUwjk/9TcRgSsW4c48aWsw2iPa5F0xjwUTqg1+WV6PmRpR0Anp3/XiQEZizx8
        NYHuIKMqXBeIpeOjp//k8X/H7oM3vg8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-hHHVUDd_NxKR7xSA3N8Rlg-1; Sat, 05 Dec 2020 10:34:48 -0500
X-MC-Unique: hHHVUDd_NxKR7xSA3N8Rlg-1
Received: by mail-ed1-f70.google.com with SMTP id dh21so2813234edb.6
        for <linux-acpi@vger.kernel.org>; Sat, 05 Dec 2020 07:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ngbQFaYupjBC+H+tboAOi4kI6aZEZIqf728BmBL002o=;
        b=lJ5FFiKDHSj08ns6N8vKrONnNpp2MrOmi/0tJEZtn+ZT+Vj5GaMM/kMDQWD1szNHNx
         VN/TYVPls7jw0l8lfQwv2+EPqVhVVY9COEiuSD8d4Ehpw9BmP+BdGPlGLjX30LM+9J59
         fcFwZ9FE+HJXdMYVI1Sg078hFVBSVCYta/rPi/5v34tMnOO3OEMl+FpaqCMXxcvNKwDH
         ZTFMvQ66cRtybfwfDmtTfVnkzCpvmx6+KLV0O5IgFLxtjHmM1yken00+cE3adpQ0klto
         eRono2dpBxspTYdLttGn0zxbiEXTN5GhHPKrCM43mU11GHIoNrP/wd42gV5Pnstyb6pR
         SshA==
X-Gm-Message-State: AOAM533U/ve/tNbI99sezEmV2+rMrvaQ18pkDk3ssfFTRWOVpFedDi63
        Jvw5ayx6snceA3zGPWh/X3sUdApVd311ORDFEkL8H14qszCRoUNjH6C8q8+vu+dsLdxtC5jYh7k
        iwhGy4eg/G1dSrX4Vi+LCmQ==
X-Received: by 2002:a05:6402:8cc:: with SMTP id d12mr12372036edz.0.1607182487238;
        Sat, 05 Dec 2020 07:34:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYPmjObSWDGzOcfnFCRrago04hStbb9gkJSWAB21feYry+hxhfXvJ/UUwB6qTP3ITLvN7nEA==
X-Received: by 2002:a05:6402:8cc:: with SMTP id d12mr12372021edz.0.1607182487069;
        Sat, 05 Dec 2020 07:34:47 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p91sm5921160edp.9.2020.12.05.07.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 07:34:46 -0800 (PST)
Subject: Re: [PATCH] ACPI: scan: Add PNP0D80 to the _DEP exceptions list
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>
References: <3849919.JfvvSOo2yN@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <52a2b98c-6bf3-760b-eca9-93cf05fb4877@redhat.com>
Date:   Sat, 5 Dec 2020 16:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3849919.JfvvSOo2yN@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/5/20 4:29 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The PNP0D80 ("Windows-compatible System Power Management Controller")
> device ID is used for identifying the special device object providing
> the LPI (Low-power S0 Idle) _DSM interface [1].  That device object
> does not supply any operation regions, but it appears in _DEP lists
> for other devices in the ACPI tables on some systems to enforce
> specific enumeration ordering that does not matter in Linux.
> 
> For this reason, _DEP list entries pointing to the device object whose
> _CID returns PNP0D80 need not be taken into account as real operation
> region dependencies, so add that device ID to the list of device IDs
> for which the matching _DEP list entries should be ignored.
> 
> Accordingly, update the function used for matching device IDs in that
> list to allow it to check _CID as well as _HID and rename it to
> acpi_info_matches_ids().
> 
> Link: https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you for doing this, I contemplated doing the exact same
thing but never got around to it.

One small review remark inline:

> ---
>  drivers/acpi/scan.c |   27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -719,25 +719,40 @@ int acpi_device_add(struct acpi_device *
>  /* --------------------------------------------------------------------------
>                                   Device Enumeration
>     -------------------------------------------------------------------------- */
> -static bool acpi_info_matches_hids(struct acpi_device_info *info,
> -				   const char * const hids[])
> +static bool acpi_info_matches_ids(struct acpi_device_info *info,
> +				  const char * const ids[])
>  {
> +	struct acpi_pnp_device_id_list *cid_list = NULL;
>  	int i;
>  
>  	if (!(info->valid & ACPI_VALID_HID))
>  		return false;
>  
> -	for (i = 0; hids[i]; i++) {
> -		if (!strcmp(info->hardware_id.string, hids[i]))
> +	if (info->valid & ACPI_VALID_CID)
> +		cid_list = &info->compatible_id_list;
> +
> +	for (i = 0; ids[i]; i++) {
> +		int j;
> +
> +		if (!strcmp(info->hardware_id.string, ids[i]))
>  			return true;
> +
> +		if (!cid_list)
> +			continue;
> +
> +		for (j = 0; j < cid_list->count; j++) {
> +			if (!strcmp(cid_list->ids[j].string, ids[i]))
> +				return true;
> +		}
>  	}
>  
>  	return false;
>  }
>  
>  /* List of HIDs for which we ignore matching ACPI devices, when checking _DEP lists. */
> -static const char * const acpi_ignore_dep_hids[] = {
> +static const char * const acpi_ignore_dep_ids[] = {
>  	"INT3396", /* Windows System Power Management Controller */

I think this one can be dropped now, I checked my acpidump / dsdt.dsl
collection and 45/45 DSDTs declaring a _HID of INT3396 also added a _CID of
PNP0D80 to this.

Regards,

Hans


> +	"PNP0D80", /* Windows-compatible System Power Management Controller */
>  	NULL
>  };
>  
> @@ -1857,7 +1872,7 @@ static void acpi_device_dep_initialize(s
>  			continue;
>  		}
>  
> -		skip = acpi_info_matches_hids(info, acpi_ignore_dep_hids);
> +		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
>  		kfree(info);
>  
>  		if (skip)
> 
> 
> 

