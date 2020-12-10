Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AF82D6B4E
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 00:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbgLJW6k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 17:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389170AbgLJWzP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 17:55:15 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA581C0619D9
        for <linux-acpi@vger.kernel.org>; Thu, 10 Dec 2020 14:46:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g25so3617606wmh.1
        for <linux-acpi@vger.kernel.org>; Thu, 10 Dec 2020 14:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+MZ667GBhR16D6p2nOjMBUchu0pJ54NQx/e3qdCjZQ0=;
        b=TxY8facWBaukogy+zBNiDa+n1buQ8OzEeTbyUlASACQgivOLqi9cMrkx5OUEXXl9iO
         4YDGTznDREXNgseRrM9YgrmN6NiJoGG4dRNtRUSp7ZxYgIJFUCZCLsZdpzIny5tSAfJp
         7Jcy2aypuwv6Y6AskLPB53YiijMimu+ErY1bptD+QMj+8dCj8Zw/stQ5WeZTSxp2Po+e
         N+fnYt6eiLWeLN0MBZNFWsqSAM/5OjUG8EfmIbV+CLE1hMkdDJSHNf/+HWVdXffQ20ft
         9KAi35KR4Fh/HUFmWRHt+u3c3kxHEoxWzWbFwl04r1ugs79ScjD9rNnlVUklQQhFTEBW
         7UuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+MZ667GBhR16D6p2nOjMBUchu0pJ54NQx/e3qdCjZQ0=;
        b=OM33r6MEG9CPlSCu0dAlb4NxMinjRA5lHdDbwcSbDwh7LOfN8qojncOE+OH0Rxxnyy
         ZF4bQ5P8QnN7tG2bjzKKaJJXa5IE1wPZ7DSk/pWjxnkje5g/NRZg0T2uACtwhevdORVe
         MhT+tf46rzBRa8VFxGB7Pjcyu7/crptvEXcJLK70nUtThaL+s4xY8EoyPtpeBYMbqHay
         zzUI2jMyJnPMrsw0ABOnwcsAW4wWicrSjNGfTmS8KW95jx4NU9Fkv8N0ig/n3mxEHH3L
         eeoRab9mmiphjdckhm2Ybo4mBJAn6vdO8wG4jHUui0rXLGLyFFmdxvjV1HOmSbv3udGC
         LM7g==
X-Gm-Message-State: AOAM533DihON9vT6udYcgoNio0g8p1VO5T3NlXWVpY2IYy+nYXDSEsD9
        8ZmkEdY87J5DgloBzswC+ZdpWUwEvIimJQ==
X-Google-Smtp-Source: ABdhPJz5anVjOQQozbc/8qr83yVfO3F/pIWAtAGXCm6n085nPUc7i8uDfuhWc0qJSZK4odJkysHTlQ==
X-Received: by 2002:a1c:2288:: with SMTP id i130mr10642433wmi.78.1607640393423;
        Thu, 10 Dec 2020 14:46:33 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id c9sm11835763wrn.65.2020.12.10.14.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 14:46:32 -0800 (PST)
Subject: Re: acpi_device_notify() binding devices that don't seem like they
 should be bound
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com>
 <CAJZ5v0inSq27Zpq=K4df=wypnSdyk5u1P-06wXiVG_vE2ZvDCQ@mail.gmail.com>
 <d3758b6a-7661-03b7-5a67-1fcb82253fb7@gmail.com>
 <1874841.VfOVrlA5c3@kreacher>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <f2f4542d-9469-82f7-22ce-04d75f57453e@gmail.com>
Date:   Thu, 10 Dec 2020 22:46:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1874841.VfOVrlA5c3@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 10/12/2020 16:59, Rafael J. Wysocki wrote:
> On Thursday, December 10, 2020 5:07:56 PM CET Daniel Scally wrote:
>> On 10/12/2020 16:05, Rafael J. Wysocki wrote:
>>> All the adevs with matching _ADR also have both _STA and _HID
>>> unfortunately. Sorry; let me stop half-arsing this and show you
>>> something useful:
>>>
>>> [    0.219953] acpi_find_child_device(PNP0A08:00, 0x00, false)
>>> [    0.220818] INT3472:00: _STA 0x00, _ADR=0x00000000, _HID=INT3472
>>> [    0.220821] INT3472:01: _STA 0x00, _ADR=0x00000000, _HID=INT3472
>>> [    0.220870] INT3472:02: _STA 0x00, _ADR=0x00000000, _HID=INT3472
>>> [    0.220892] INT3472:03: _STA 0x00, _ADR=0x00000000, _HID=INT3472
>>> [    0.220916] INT3472:04: _STA 0x00, _ADR=0x00000000, _HID=INT3472
>>> [    0.220941] INT3472:05: _STA 0x00, _ADR=0x00000000, _HID=INT3472
>>> [    0.220965] INT3472:06: _STA 0x00, _ADR=0x00000000, _HID=INT3472
>>> [    0.220990] INT3472:07: _STA 0x00, _ADR=0x00000000, _HID=INT3472
>>> These will be ignored with -ENODEV.
>>>
>>>> [    0.221038] INT3472:08: _STA 0x0f, _ADR=0x00000000, _HID=INT3472
>>> For this acpi_find_child_device() will return FIND_CHILD_MIN_SCORE if
>>> I'm not mistaken.
>> It does - this is the one that binds, being the first.
>>>> [    0.221051] OVTI5648:00: _STA 0x0f, _ADR=0x00000000, _HID=OVTI5648
>>>> [    0.221061] INT3472:09: _STA 0x0f, _ADR=0x00000000, _HID=INT3472
>>>> [    0.221070] OVTI2680:00: _STA 0x0f, _ADR=0x00000000, _HID=OVTI2680
>>> As well as for the three above.
>>>
>>>> [    0.221079] INT3471:00: _STA 0x00, _ADR=0x00000000, _HID=INT3471
>>>> [    0.221105] INT33BE:00: _STA 0x00, _ADR=0x00000000, _HID=INT33BE
>>>> [    0.221130] INT3471:01: _STA 0x00, _ADR=0x00000000, _HID=INT3471
>>>> [    0.221156] INT33BE:01: _STA 0x00, _ADR=0x00000000, _HID=INT33BE
>>> And the rest will be ignored.
>>>
>>>> That's the debug output I included for each adev that's assessed as a
>>>> child of PNP0A08:00. _STA, _ADR and _HID present for all, _ADR 0x00 for
>>>> all, _STA 0x0f for the 2 sensors and their PMIC's and 0x00 for the rest.
>>>> The same situation holds on both of my devices.
>>> So in fact we don't want to have an ACPI companion for (PNP0A08:00,
>>> 0x00, false).
>> Yeah, I think that's right
>>> This is a hostbridge special case and let me think about this for a while.
>> Sure - thanks very much for your help.
> I've come up with the following patch.
>
> Please let me know if it works for you.
>
> ---
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1162,14 +1162,32 @@ void acpi_pci_remove_bus(struct pci_bus
>  static struct acpi_device *acpi_pci_find_companion(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct acpi_device *adev;
>  	bool check_children;
>  	u64 addr;
>  
>  	check_children = pci_is_bridge(pci_dev);
>  	/* Please ref to ACPI spec for the syntax of _ADR */
>  	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
> -	return acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
> +	adev = acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
>  				      check_children);
> +	/*
> +	 * There may be ACPI device objects in the ACPI namesoace that are
> +	 * children of the device object representing the host bridge, but don't
> +	 * represent PCI devices.  Both _HID and _ADR may be present for them,
> +	 * even though that is against the specification (for example, see
> +	 * Section 6.1 of ACPI 6.3), but in many cases the _ADR returns 0 which
> +	 * appears to indicate that they should not be taken into consideration
> +	 * as potential companions of PCI devices on the root bus.
> +	 *
> +	 * To catch this special case, disregard the returned device object if
> +	 * it has a valid _HID, addr is 0 and the PCI device at hand is on the
> +	 * root bus.
> +	 */
> +	if (adev->pnp.type.platform_id && !addr && !pci_dev->bus->parent)
> +		return NULL;
> +
> +	return adev;
>  }
>  
>  /**
>
Thanks - this needs to check adev for NULL too; acpi_find_child_device()
does return that sometimes. When changed to:

+	if (adev && adev->pnp.type.platform_id && !addr && !pci_dev->bus->parent)
+		return NULL;

Then it boots properly, and fixes the original problem.  Also;
s/namesoace/namespace in the comment.


Really appreciate the help - thank you!

